require 'redis'
require 'securerandom'

redis = []
redis[0] << Redis.new(port: 16379)
redis[1] << Redis.new(port: 26379)
redis[2] << Redis.new(port: 36379)

100.times do |i|
  redis[0].setex "foo_#{i}", 1000+i, SecureRandom.base64(1024*100)
end

keys = []
redis.size.times do |i|
  keys[i] = redis[i].keys.sort
end

p keys[0]-keys[1]
p keys[1]-keys[2]
