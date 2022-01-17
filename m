Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2D490BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:49:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240605AbiAQPtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237369AbiAQPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:49:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:49:52 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l6-20020a17090a4d4600b001b44bb75a8bso190973pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dx8fnWE+qOBeQr9kWBJW6eoNu5QGa/KK1NgfQeSied0=;
        b=NPslNjmG+eWwHB4BtfIVCYR/L1b7WXwleBapn1UxMXM+0hYxNssNCjNwMG12tN1QBb
         /fm7PzlXOTqJyEk4jK9gV8YzP07uhWLhxUMFCForGuawYMNXa0J3gHQ78yYFrGhZ1sft
         NqGqkP/wf9uFBs7xEzqT3h+6oDriJo6uMgwjyzvaNCLZpMh5Ul1WPa9MF6ZcikwmRmce
         oCHtO1dTHUt5sZ79e0jQK1l7W3fbxyuds66AvJdSDhJdDZoR9O4IHxIpZk7umIYBjGb7
         2tQT+NknALyO62g/bLLIWbwCTvlAK7QgsXsxP8QRR5uzZRhMVv2Vg1InCdTfrZwNwXDu
         +GsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dx8fnWE+qOBeQr9kWBJW6eoNu5QGa/KK1NgfQeSied0=;
        b=bfdwZIBFgJcyiWhAi5gBT93YNAcMjkdCFmhMv1aw1PTWw/6fswQEat3ZuZ2XKDKKaU
         FTUESWrQWC905WV0dSPwmGowd8bhrvu/yB4FhIsjSEvWE9UTQVQB67mzib4S3VNm+05+
         tKQWVy2C6NwGhnSLLGV6dUtfK1Q34tm45464k0ErYdLwnGpiW2LtMiyZNfC/e0ZDWVgS
         mp1WXzefl77egENYx68Bj5VRNvw/vjnWf3HncjVSXZlohECY9NBl/SKVlK5nqlY/0cbp
         usXa/TH8zn88seeQJKQXzhIpeWWZpifNOemRmryFhPrmpA2WMFI4Y+rFQL+EE63D1Wlo
         pD3Q==
X-Gm-Message-State: AOAM532EdBBsK5LKom24F18VytX8LCSMCg5LoMSTNa3K6NCQ6b9a/pLP
        AR993O233Am7FNu4cCgtFWcB0gKjKGNHnbIt39V9qQ==
X-Google-Smtp-Source: ABdhPJx438y5P/pXbWn13UAH3bdxpvZwSPVeO84ILQCgrWjMtGNUu/plW6d6LoxJo/0nGn6EOb1T0M4Sha0cjXqw+VE=
X-Received: by 2002:a17:902:b189:b0:149:6c45:24c with SMTP id
 s9-20020a170902b18900b001496c45024cmr22987695plr.21.1642434591811; Mon, 17
 Jan 2022 07:49:51 -0800 (PST)
MIME-Version: 1.0
References: <20220117154150.5145-1-lzmlzmhh@gmail.com>
In-Reply-To: <20220117154150.5145-1-lzmlzmhh@gmail.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 Jan 2022 16:49:40 +0100
Message-ID: <CAG3jFyuEpiSdzNQ9=U30Bvr4bC+diG3XJHX6Kz38Mw62a5YVGA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/bridge: Remove extra device acquisition method of
 i2c client in lt9611 driver
To:     Zhiming Liu <lzmlzmhh@gmail.com>
Cc:     narmstrong@baylibre.com, laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Zhiming,

On Mon, 17 Jan 2022 at 16:42, Zhiming Liu <lzmlzmhh@gmail.com> wrote:
>
> drm/bridge: Remove extra device acquisition method of i2c client in lt9611 driver.

The commit title is already in the email title, it doesn't need to be
sent twice, sorry if I was unclear about this.

>
> We have got the device of i2c client in probe function.So we should remove extra

This line is too long, and `checkpatch.pl --strict` complains about its length.

> device acquisition method of i2c client.
>
> Signed-off-by: Zhiming Liu <lzmlzmhh@gmail.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c    | 4 ++--
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
> index dafb1b47c15f..feb128a4557d 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
> @@ -1090,7 +1090,7 @@ static int lt9611_probe(struct i2c_client *client,
>         if (!lt9611)
>                 return -ENOMEM;
>
> -       lt9611->dev = &client->dev;
> +       lt9611->dev = dev;
>         lt9611->client = client;
>         lt9611->sleep = false;
>
> @@ -1100,7 +1100,7 @@ static int lt9611_probe(struct i2c_client *client,
>                 return PTR_ERR(lt9611->regmap);
>         }
>
> -       ret = lt9611_parse_dt(&client->dev, lt9611);
> +       ret = lt9611_parse_dt(dev, lt9611);
>         if (ret) {
>                 dev_err(dev, "failed to parse device tree\n");
>                 return ret;
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> index 33f9716da0ee..3d62e6bf6892 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
> @@ -860,7 +860,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
>         if (!lt9611uxc)
>                 return -ENOMEM;
>
> -       lt9611uxc->dev = &client->dev;
> +       lt9611uxc->dev = dev;
>         lt9611uxc->client = client;
>         mutex_init(&lt9611uxc->ocm_lock);
>
> @@ -870,7 +870,7 @@ static int lt9611uxc_probe(struct i2c_client *client,
>                 return PTR_ERR(lt9611uxc->regmap);
>         }
>
> -       ret = lt9611uxc_parse_dt(&client->dev, lt9611uxc);
> +       ret = lt9611uxc_parse_dt(dev, lt9611uxc);
>         if (ret) {
>                 dev_err(dev, "failed to parse device tree\n");
>                 return ret;
> --

I fixed the two remaining issues in your patch, but in the future I
would suggest running `checkpatch.pl --strict` on every patch before
emailing them out. It's very easy to miss something.

Reviewed-by: Robert Foss <robert.foss@linaro.org>

Applied to drm-misc-next.
