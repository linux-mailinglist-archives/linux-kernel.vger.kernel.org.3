Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFF549050C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiAQJkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbiAQJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:40:00 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613E8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:40:00 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id l21-20020a17090b079500b001b49df5c4dfso3077722pjz.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 01:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIgYGrN4LwQTs17+VXthu1/mXIG34ztGcllpOGCYBUY=;
        b=xmwbCLYhEE9bYLZqv0I8ALMO0V7d/Xi97LrM068AbIRSOFBFz8JsLtB1mgWWNRGesf
         N0fUx0p0QfouvE3r0dGowIIBaKql09cSLdkOlENedU7pO9TTq6mb6XQIWY/d2V9Ibp54
         Wcd7sC9ZaSsMvkh2cPEcsaON2uKZeXtydaQi+g/ClzR+azMiZ/MtX74f+BTlsOkM0hfh
         SUsr2LcUVDEQzDMYEtPRt+ZXyQKXGqjdFDJyZRiJUok3HnC4JHUSO3t4MNSNMyJ3rVh1
         hdOOuhJ5NeumWzaHP39f+EMxIwoXU4BCws14SmywAt+3b2rfrdGYRfJkGU/9bP/JVUi1
         ElcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIgYGrN4LwQTs17+VXthu1/mXIG34ztGcllpOGCYBUY=;
        b=qbs+LEHkgz5BMCHwrZnLg9oNiJjSOlN5ANwcFstfYGVet+x5DfgAAPCfoZU5YS1Rzm
         oPxrDjs7hZKoxEJDhTQ3S4WI7eONKgupTmmnLmwSGPv5cdvWZQ2IybKEbpGpaB2yZncI
         ry7X5UAlTXWRGZqrGV2fII3KcyELWec+wVcJSb63zleB+Iq0u6uICJchu37zBSh4Ld/e
         zwvnHcfnpafiIMHx1EkLm4VMARUgXfauMatV9OuO5U8OSJK3EZEESP0evcB2f9WIR6jW
         EwstSjy6HOZRu8qZQZ3XOWHm5RM5Qkcj9cyTjMz7pQf0i2l+ZxMAib6JsEgxICFkidCA
         Fi4g==
X-Gm-Message-State: AOAM532eutlhf4eNNjw6+SqaXZszjNe9DE6J6i4qDnOl+z3lqkwvq4Jr
        mUMva3v3m1fh1e/SBrdn8VOY71oCsG2tJ1lD1450XA==
X-Google-Smtp-Source: ABdhPJzKo2IbXPNzAcrx2/AE8zdZh33V97DTVPFXqTRHcM78M5VmIK/iUSHi57i+F5m2mfCvXcDIC4am/FsNxlj2aHI=
X-Received: by 2002:a17:90b:3e8e:: with SMTP id rj14mr17892801pjb.179.1642412399902;
 Mon, 17 Jan 2022 01:39:59 -0800 (PST)
MIME-Version: 1.0
References: <20220113082918.2279347-1-hsinyi@chromium.org>
In-Reply-To: <20220113082918.2279347-1-hsinyi@chromium.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 17 Jan 2022 10:39:48 +0100
Message-ID: <CAG3jFytu8VpopWYHvGiSYRW2bcX-wHSoYgQ42u84WBQKGrnfZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/bridge: anx7625: Convert to use devm_kzalloc
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Xin Ji <xji@analogixsemi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Hsin-Yi,


On Thu, 13 Jan 2022 at 09:29, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> Use devm_kzalloc instead of kzalloc and drop kfree(). Let the memory
> handled by driver detach.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Xin Ji <xji@analogixsemi.com>
> ---
> v2->v3: remove kfree() in anx7625_i2c_remove().
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 0b858c78abe8b6..d3661c78770a8f 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -2515,7 +2515,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>                 return -ENODEV;
>         }
>
> -       platform = kzalloc(sizeof(*platform), GFP_KERNEL);
> +       platform = devm_kzalloc(dev, sizeof(*platform), GFP_KERNEL);
>         if (!platform) {
>                 DRM_DEV_ERROR(dev, "fail to allocate driver data\n");
>                 return -ENOMEM;
> @@ -2527,7 +2527,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         if (ret) {
>                 if (ret != -EPROBE_DEFER)
>                         DRM_DEV_ERROR(dev, "fail to parse DT : %d\n", ret);
> -               goto free_platform;
> +               return ret;
>         }
>
>         platform->client = client;
> @@ -2552,7 +2552,7 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         if (!platform->hdcp_workqueue) {
>                 dev_err(dev, "fail to create work queue\n");
>                 ret = -ENOMEM;
> -               goto free_platform;
> +               return ret;
>         }
>
>         platform->pdata.intp_irq = client->irq;
> @@ -2637,9 +2637,6 @@ static int anx7625_i2c_probe(struct i2c_client *client,
>         if (platform->hdcp_workqueue)
>                 destroy_workqueue(platform->hdcp_workqueue);
>
> -free_platform:
> -       kfree(platform);
> -
>         return ret;
>  }
>
> @@ -2666,7 +2663,6 @@ static int anx7625_i2c_remove(struct i2c_client *client)
>         if (platform->pdata.audio_en)
>                 anx7625_unregister_audio(platform);
>
> -       kfree(platform);
>         return 0;
>  }
>

I just had a look at applying this series, but it fails to apply on
drm-misc-next today.

Could you send a v4 that applies cleanly, and I'll try to be quick
about applying it.


Rob.
