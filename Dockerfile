FROM node:16-alpine as builder 
WORKDIR '/app'
COPY package.json .
RUN npm install 
COPY . .
RUN npm run build

FROM nginx
#this container gets port mapped to port 80 (by itself this doesnt do anything but AWS Elastic Beanstock is different, it will look at this instruction and use it as the port that gets mapped for incoming traffic )
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
