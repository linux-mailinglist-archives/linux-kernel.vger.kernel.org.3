Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C8F4D2E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiCIMAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiCIMAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:00:50 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164EF94E7;
        Wed,  9 Mar 2022 03:59:51 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id z30so3861215ybi.2;
        Wed, 09 Mar 2022 03:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfNPAq/xUBFYXwIgl1HZDnGv0DGUDqF2s2A85pcqjZg=;
        b=MnnhLtR5FEJAHdHPjX7mN7njyVpCD396Qt47sfyw8J2MvN5JGwW+0wj4OTBSSlsANt
         Iq+BGRwtxLz4FfIpPFLuBEPy35/ftoUxB6lukMB0INyoDUT1LTsdidxHE4yS4K3ddE32
         kdfRF/ePV78hxOI1UsVSewWkWZ8JscQQPEhWDkJ2E8zt3y04BKE9ubT8a6s3y2tuZu83
         WCcVnsq2ERMEL0SeQlHK+Ui8WB6AlJ0BXvngqWRvTX04SOmW5TtwV+wjblrRYwthFfk+
         c+FzbA3fDIZeUx2RVXea+ae/1TnbJfvOHVgj9eK+uuyhyEQ8JpqVamrmuEhaDGNynxj0
         No9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfNPAq/xUBFYXwIgl1HZDnGv0DGUDqF2s2A85pcqjZg=;
        b=KaIHLwk4RwEx7gdHPzGuFLfxByCOkyXEwXguq2bWpTX9EJSwK+nDwfzuqsjkNwlfzo
         EGK0UgtEdx0C+d0QoJHI1UVDsyoQz3pd9/7WgiVqGhVVPRnnOfJWZ7qrJXMbnFez32hE
         MZnADbyGu5WqvPactbOUeQbnkpjueQI3rH8MzKOjh6JgyxMwgjg5ls3vIxmsUxcx3Bdb
         bhnwwIelSa/ceyuqBL2C19/tzcvGTylSzpwJGnz6dorOUrX6tIWbvMiG3JkrzsXT3bQ4
         p4N3o5KxBHw/yBpwgZZRK8da9XszyzJnrQSXHPSQR97j0cJ7/6AEkhhrR7oN89VfuOix
         ARmA==
X-Gm-Message-State: AOAM532d2p/U0RGOI9EUObolonqbk+ScgahROA4R4QI4Rll2QHj3hO6U
        ZD0f9KqbYD/mknHj/nKWdw0NWZzz8huaoIoUetk=
X-Google-Smtp-Source: ABdhPJxibLKTnvAHHyuiLIXxursyh1UBsom2xJiQJLwSHl5bfQHLMx6R6kZ20WAVfISF8B/zmAJ9X4XaZOJ43VGg7NY=
X-Received: by 2002:a25:d3cb:0:b0:629:182c:6c50 with SMTP id
 e194-20020a25d3cb000000b00629182c6c50mr16116332ybf.417.1646827190454; Wed, 09
 Mar 2022 03:59:50 -0800 (PST)
MIME-Version: 1.0
References: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220110144039.5810-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 9 Mar 2022 11:59:24 +0000
Message-ID: <CA+V-a8uTtUjj2ccHDqB0TKfKw5KO-joPv0umw1fDP4cz6sUj2Q@mail.gmail.com>
Subject: Re: [PATCH v4] thermal: rcar_thermal: Use platform_get_irq_optional()
 to get the interrupt
To:     =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On Mon, Jan 10, 2022 at 2:40 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> allocation of IRQ resources in DT core code, this causes an issue
> when using hierarchical interrupt domains using "interrupts" property
> in the node as this bypasses the hierarchical setup and messes up the
> irq chaining.
>
> In preparation for removal of static setup of IRQ resource from DT core
> code use platform_get_irq_optional().
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4:
> * Updated check as suggested by Andy
>
> v2->v3:
> * Fixed review comment pointed by Andy
>
> v1->v2
> * Simplified checking error code
> * Break loop earlier if no interrupts are seen
>
> v1: https://lkml.org/lkml/2021/12/18/163
> ---
>  drivers/thermal/rcar_thermal.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
This patch is not in -next yet. In which release v5.18/19 do you plan
to merge this in?

Cheers,
Prabhakar

> diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
> index b49f04daaf47..1d729ed4d685 100644
> --- a/drivers/thermal/rcar_thermal.c
> +++ b/drivers/thermal/rcar_thermal.c
> @@ -445,7 +445,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>         struct rcar_thermal_common *common;
>         struct rcar_thermal_priv *priv;
>         struct device *dev = &pdev->dev;
> -       struct resource *res, *irq;
> +       struct resource *res;
>         const struct rcar_thermal_chip *chip = of_device_get_match_data(dev);
>         int mres = 0;
>         int i;
> @@ -467,9 +467,16 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>         pm_runtime_get_sync(dev);
>
>         for (i = 0; i < chip->nirqs; i++) {
> -               irq = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> -               if (!irq)
> -                       continue;
> +               int irq;
> +
> +               ret = platform_get_irq_optional(pdev, i);
> +               if (ret < 0 && ret != -ENXIO)
> +                       goto error_unregister;
> +               if (ret > 0)
> +                       irq = ret;
> +               else
> +                       break;
> +
>                 if (!common->base) {
>                         /*
>                          * platform has IRQ support.
> @@ -487,7 +494,7 @@ static int rcar_thermal_probe(struct platform_device *pdev)
>                         idle = 0; /* polling delay is not needed */
>                 }
>
> -               ret = devm_request_irq(dev, irq->start, rcar_thermal_irq,
> +               ret = devm_request_irq(dev, irq, rcar_thermal_irq,
>                                        IRQF_SHARED, dev_name(dev), common);
>                 if (ret) {
>                         dev_err(dev, "irq request failed\n ");
> --
> 2.17.1
>
