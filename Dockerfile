FROM golang:1.22.5 as base   #as the application is go based application so hence 

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

#if I would run without converting into distroless image, it will work but I want to reduce the size
#Final stage - Distroless image

FROM gcr.io/distroless/base

COPY --from=base /app/main .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD [ "./main" ]

