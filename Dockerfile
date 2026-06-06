FROM node:22-alpine AS builder

WORKDIR /app

RUN corepack enable && corepack prepare pnpm@9.15.0 --activate

COPY package.json pnpm-lock.yaml .npmrc ./
RUN pnpm install --frozen-lockfile

COPY . .

ARG VITE_APP_BACKEND
ENV VITE_APP_BACKEND=${VITE_APP_BACKEND}

RUN pnpm run build

FROM scratch

COPY --from=builder /app/dist /
