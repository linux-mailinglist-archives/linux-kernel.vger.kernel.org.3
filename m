Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0836548435B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiADO3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiADO3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:29:11 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688A9C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:29:11 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so3309016pji.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WvukAqqIMpExigFVa+1wXXFL04/zNpt+dsk6xQ5zeLE=;
        b=pCa1FV0Tz/uvA2Z6W33ptJzic6KvrDtq39+8MrnZVLQcrULnLLYl6TcLNKMiDwArK1
         f8UtS25nf5Kv4T4DC7d1jpPVjOOPH/4YD7Yb6v+TO5gQFCkgh84W6F5Xo1JHC5ugdDuc
         opNdN0JdNj69t4kl6o0lf1kL7mIwwYrLTOC3N3cBir/wuTGNo+vgnV1xVWQBqkDxVyGh
         14Gjj+zYWfz0w5aew3zRPUKwM1erIqNbuXabdArWawnhcrOgkZsi6OQUYjwNf9qN6p2R
         kJpzG3wFw45qyUwK7cycRiRTDAb7s6FkdibziD/+A/s6qFLYQ0JW1hfcxKKD34blRQxW
         KqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WvukAqqIMpExigFVa+1wXXFL04/zNpt+dsk6xQ5zeLE=;
        b=DwsGOI43YhrlLQE6chRSaVlezUqlZSLUqdUHg249QI9M9ZHpsWxIYt6bKFaFmF4PyY
         9FuJXqLrvPBEHA7zUinocoyGk2YwQUEEj5m/8gn38olX98EjPRd3U7WMJDjBqAT9mgq2
         F1/HIplhulExxdTsrnwLV87iGXO+pjEYKTDjVZ9QW9AdUqNWp0ts2W7hiwfpuIi4cDSl
         QokOUqpthTRylDSsGL2/n4o8ibliz5hvwxkDX7G6Sa4aA77Mcm2cIV8B+99sSVLOJefB
         CT146oIMzWBCCe4SaZCHLI5r877tIgxVyPZ3VhIuD5eaUYa7OYmCBBFy8VqZ9K7pQ7XF
         BLEg==
X-Gm-Message-State: AOAM533QIc3sfkQ6h0SznuhCZhji96c8RJpQas2zo2NAuE3rSE4a8CW8
        UxNkYZ5sK+1y2EfM4FoTnJ+bD7vx2hn/nThUsyum4g==
X-Google-Smtp-Source: ABdhPJz/LplF3gfbp7D6wtf71ae2gJxJJVBqMdnj1fk+ayjLSUbdaDRYvvB+Xm+DybrPHlsSDc0XjkRgtuT1wLyB7hQ=
X-Received: by 2002:a17:903:110c:b0:149:8018:e9d4 with SMTP id
 n12-20020a170903110c00b001498018e9d4mr36711837plh.117.1641306550920; Tue, 04
 Jan 2022 06:29:10 -0800 (PST)
MIME-Version: 1.0
References: <20211222083350.18514-1-linmq006@gmail.com>
In-Reply-To: <20211222083350.18514-1-linmq006@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 15:29:00 +0100
Message-ID: <CAG3jFysrEDzYVbpwDVK2OJYMsEKRqpcBexK__m08A6vevm=ubw@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: anx7625: Fix null vs IS_ERR() checking in anx7625_register_i2c_dummy_clients
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Xin Ji <xji@analogixsemi.com>, Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Miaoqian,

Thanks for submitting this fix.

On Wed, 22 Dec 2021 at 09:33, Miaoqian Lin <linmq006@gmail.com> wrote:
>
> Since i2c_new_client_device() function return error pointers.
> The i2c_new_dummy_device() function does not return NULL, It returns error
> pointers too. Using IS_ERR() to check the return value to fix this.
>
> Fixes: 8bdfc5dae4e3("drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 32 ++++++++++++++++-------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 1a871f6b6822..eb72aa6aedd6 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1637,40 +1637,54 @@ static const struct drm_bridge_funcs anx7625_bridge_funcs = {
>  static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
>                                               struct i2c_client *client)
>  {
> +       int err = 0;
> +
>         ctx->i2c.tx_p0_client = i2c_new_dummy_device(client->adapter,
>                                                      TX_P0_ADDR >> 1);
> -       if (!ctx->i2c.tx_p0_client)
> -               return -ENOMEM;
> +       if (IS_ERR(ctx->i2c.tx_p0_client))
> +               return PTR_ERR(ctx->i2c.tx_p0_client);
>
>         ctx->i2c.tx_p1_client = i2c_new_dummy_device(client->adapter,
>                                                      TX_P1_ADDR >> 1);
> -       if (!ctx->i2c.tx_p1_client)
> +       if (IS_ERR(ctx->i2c.tx_p1_client)) {
> +               err = PTR_ERR(ctx->i2c.tx_p1_client);
>                 goto free_tx_p0;
> +       }
>
>         ctx->i2c.tx_p2_client = i2c_new_dummy_device(client->adapter,
>                                                      TX_P2_ADDR >> 1);
> -       if (!ctx->i2c.tx_p2_client)
> +       if (IS_ERR(ctx->i2c.tx_p2_client)) {
> +               err = PTR_ERR(ctx->i2c.tx_p2_client);
>                 goto free_tx_p1;
> +       }
>
>         ctx->i2c.rx_p0_client = i2c_new_dummy_device(client->adapter,
>                                                      RX_P0_ADDR >> 1);
> -       if (!ctx->i2c.rx_p0_client)
> +       if (IS_ERR(ctx->i2c.rx_p0_client)) {
> +               err = PTR_ERR(ctx->i2c.rx_p0_client);
>                 goto free_tx_p2;
> +       }
>
>         ctx->i2c.rx_p1_client = i2c_new_dummy_device(client->adapter,
>                                                      RX_P1_ADDR >> 1);
> -       if (!ctx->i2c.rx_p1_client)
> +       if (IS_ERR(ctx->i2c.rx_p1_client)) {
> +               err = PTR_ERR(ctx->i2c.rx_p1_client);
>                 goto free_rx_p0;
> +       }
>
>         ctx->i2c.rx_p2_client = i2c_new_dummy_device(client->adapter,
>                                                      RX_P2_ADDR >> 1);
> -       if (!ctx->i2c.rx_p2_client)
> +       if (IS_ERR(ctx->i2c.rx_p2_client)) {
> +               err = PTR_ERR(ctx->i2c.rx_p2_client);
>                 goto free_rx_p1;
> +       }
>
>         ctx->i2c.tcpc_client = i2c_new_dummy_device(client->adapter,
>                                                     TCPC_INTERFACE_ADDR >> 1);
> -       if (!ctx->i2c.tcpc_client)
> +       if (IS_ERR(ctx->i2c.tcpc_client)) {
> +               err = PTR_ERR(ctx->i2c.tcpc_client);
>                 goto free_rx_p2;
> +       }
>
>         return 0;
>
> @@ -1687,7 +1701,7 @@ static int anx7625_register_i2c_dummy_clients(struct anx7625_data *ctx,
>  free_tx_p0:
>         i2c_unregister_device(ctx->i2c.tx_p0_client);
>
> -       return -ENOMEM;
> +       return err;
>  }
>
>  static void anx7625_unregister_i2c_dummy_clients(struct anx7625_data *ctx)
> --
> 2.17.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
