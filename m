Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A789484297
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbiADNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiADNhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:37:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C417AC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 05:37:13 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f5so3368151pgk.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 05:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D736xcW6mnSzdCeNa4cuzz73/79ln4mEm4aUwrA4o7g=;
        b=H9KIaxj+4rUigwIZEcx9omWefyC8Cr+m2kkulm/BfX3ayl6owe1bEUUKGCG/8IrWKi
         X+Y+gJk4PgNmY3f6SVp24N5TW2QGt2kflhnSH/J5dWBxw8RTOqd0lzsCagYumzAdJ4p0
         gN9y9y/5GOr9FOY4navQhMx0B4Vt2cauY5MuCHy2KiGFoi+dIGH6xX5NvMaIRIs3TT1h
         iRW1TZMRHSm4ZpzLoB+8P61blWZBpR3awOWhqbLJLiLon+bHkmp5aQ8SIRK1OWEb1CWI
         GqUAtQCebmlmF2kV4OC+1CA+KxvBjEgoxp49ehpLx8lxCtnM04MyZXXCSnmPJtZKrPwy
         NBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D736xcW6mnSzdCeNa4cuzz73/79ln4mEm4aUwrA4o7g=;
        b=MT+TPsC8YlGaggexUdNAS7FZiFNi3DhuVzeJbprEbSourB6qZNGV7gN0UF9s0HCp5u
         1nF2uFXoXihjrWHiUYttcGsiJWcxPsOqbRKXFrZN+qnSLcSIeSK3Z4Z3QDSOb7+DVryq
         tZuNAA6txfmgQdkAns0oFU7W60WV9Jv3knt3FWF/lB9caArDyucgpuJr4dY3GvaJm+P1
         AWFVS26NUu/qapVf9HcIYElAzp5idytE2N0Sgw+wT7okPpQKtm+nYfCj7xXRUIDCLtWP
         qDf3Mky19dbdyNPJDenPuqI8VO3EL0EGmzZRnUkFxioYOlZBR0Wtyq04u2lmYFtGOmYu
         yGCg==
X-Gm-Message-State: AOAM532rTp76tkszbRgSCQJFL313cbmO+Nmw8PJ1+s23YEwwY96siFQS
        Np/5YFDtE79IasJFle/+KN7wj2O4ZT6GJhAiGE58EQ==
X-Google-Smtp-Source: ABdhPJws1bqBeVSXlUmBPeCwIC2GMIkSO+RxkrQ9CkAgsC669S9+4XmAOnJ4iVvmArIN/4+CNqraGyHUpsTWRPnDUY4=
X-Received: by 2002:a63:854a:: with SMTP id u71mr43809083pgd.201.1641303433298;
 Tue, 04 Jan 2022 05:37:13 -0800 (PST)
MIME-Version: 1.0
References: <20211119015804.3824027-1-xji@analogixsemi.com>
In-Reply-To: <20211119015804.3824027-1-xji@analogixsemi.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Tue, 4 Jan 2022 14:37:02 +0100
Message-ID: <CAG3jFytg88mWgA24ce4CbPKDA7HDdXOjC=AVxYrhv1c0Z5GTPA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: anx7625: Check GPIO description to avoid crash
To:     Xin Ji <xji@analogixsemi.com>
Cc:     narmstrong@baylibre.com, dan.carpenter@oracle.com,
        laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        sam@ravnborg.org, pihsun@chromium.org, tzungbi@google.com,
        maxime@cerno.tech, drinkcat@google.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        bliang@analogixsemi.com, qwen@analogixsemi.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2021 at 02:58, Xin Ji <xji@analogixsemi.com> wrote:
>
> As GPIO probe function "devm_gpiod_get_optional()" may return error
> code, driver should identify GPIO desc as NULL to avoid crash.
>
> Acked-by: Tzung-Bi Shih <tzungbi@google.com>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  drivers/gpu/drm/bridge/analogix/anx7625.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
> index 001fb39d9919..652ae814246d 100644
> --- a/drivers/gpu/drm/bridge/analogix/anx7625.c
> +++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
> @@ -1098,9 +1098,18 @@ static void anx7625_init_gpio(struct anx7625_data *platform)
>         /* Gpio for chip power enable */
>         platform->pdata.gpio_p_on =
>                 devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> +       if (IS_ERR_OR_NULL(platform->pdata.gpio_p_on)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "no enable gpio found\n");
> +               platform->pdata.gpio_p_on = NULL;
> +       }
> +
>         /* Gpio for chip reset */
>         platform->pdata.gpio_reset =
>                 devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
> +       if (IS_ERR_OR_NULL(platform->pdata.gpio_reset)) {
> +               DRM_DEV_DEBUG_DRIVER(dev, "no reset gpio found\n");
> +               platform->pdata.gpio_reset = NULL;
> +       }
>
>         if (platform->pdata.gpio_p_on && platform->pdata.gpio_reset) {
>                 platform->pdata.low_power_mode = 1;
> --
> 2.25.1
>

Reviewed-by: Robert Foss <robert.foss@linaro.org>
