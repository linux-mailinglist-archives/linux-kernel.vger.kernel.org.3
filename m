Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9C5579518
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiGSIRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiGSIRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:17:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78E1248DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:17:02 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r6so18538345edd.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UXsZJsgsSiHl9h8RmO5qeLacMCfPdBxMaAGdhnsVAEI=;
        b=wDHr4F7sTbDK+tOafzkIIYA5Xc1iZGxmrC6Pi76n7uaHfMuTIwidIqjeGRB40fqnCK
         hB31oNLMZ6qNAuZEok/jWJMk4h1Zs4RPp/tHACBF6aqJgacAP7SM8KoK5LlESQ3BY3zR
         +2byXG0Fe9EstkciQN6oHNR0fuClRAvFE/vmW55SI9vPKc1RKWznzh0iZKzV524OhZdK
         kZqbV9VroCYE+PeL5rYKg5yMpIWEWHajN5Y/omP3JoDCNsW732wSZ+bMaW4uFV6riSM0
         eYMxv5pSO5CxFMM1F7QKnYrCoY6Js5Sqhh3vhbBgCIjVETwl4eqwjgxO+F0D82iDJ8VT
         h3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UXsZJsgsSiHl9h8RmO5qeLacMCfPdBxMaAGdhnsVAEI=;
        b=NacnWhBqBoDjAZh2bwmlZnCT/FoIDMpv+51E9H1cRyYKp6Z18rX0wfHglV+0K0QgkL
         AEYbIoAnRP/oJHozXd+o+/+SYAId+vSLBQQEtYvN+ydizgyeQtDhMaxMYzhXpncfETK3
         XDvVl+O0i67BhfHiRK8C02BGb8iGlO+iCgf1RXC9FSbzzMi/aYCABzd99pA5zTI0KEVC
         0tE0rD9urkTH+xTmSE18IXr6nv96NlyJKmYjpBoKXDk0n3IhYJcLOzDFuhCdNjBO3EgW
         DQc/iZqS16DdBh6EyPsDSWea1RkVhdOUY4V1ZJvsBBEAncZktar28kP3fkQRNdqmAAZg
         pHtQ==
X-Gm-Message-State: AJIora9ULzA81dKvDV9Z7vHqF1KSQYIQUdOnF51ff2a/Nr2AX9lcAgpY
        /mfGu5ShJBd4T6MDWeJ4ORdf0E2nOt333cw3Es4ClQ==
X-Google-Smtp-Source: AGRyM1tkBVfbS/WPKnxaS2KbVDC/keFlDelm0NcUe5mIC0qaW1Ydh0VTld8nwZUz3COVJzBuqULd3kayOkDFMz4FOIQ=
X-Received: by 2002:a05:6402:4c3:b0:43a:f612:179d with SMTP id
 n3-20020a05640204c300b0043af612179dmr42516765edw.422.1658218621366; Tue, 19
 Jul 2022 01:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220718220252.16923-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Jul 2022 10:16:50 +0200
Message-ID: <CAMRc=MfA7Bea3MHMx0Q0dyNa096po_Pcs54vtV+PQ6h4tMduPA@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpio: 74xx-mmio: Make use of device properties
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 12:02 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Convert the module to be property provider agnostic and allow
> it to be used on non-OF platforms.
>
> Add mod_devicetable.h include.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-74xx-mmio.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
> index 173e06758e6c..5e3c948ddb73 100644
> --- a/drivers/gpio/gpio-74xx-mmio.c
> +++ b/drivers/gpio/gpio-74xx-mmio.c
> @@ -6,10 +6,11 @@
>   */
>
>  #include <linux/err.h>
> -#include <linux/module.h>
> -#include <linux/of_device.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>
>  #define MMIO_74XX_DIR_IN       (0 << 8)
>  #define MMIO_74XX_DIR_OUT      (1 << 8)
> @@ -112,7 +113,7 @@ static int mmio_74xx_gpio_probe(struct platform_device *pdev)
>         if (!priv)
>                 return -ENOMEM;
>
> -       priv->flags = (uintptr_t)of_device_get_match_data(&pdev->dev);
> +       priv->flags = (uintptr_t)device_get_match_data(&pdev->dev);
>
>         dat = devm_platform_ioremap_resource(pdev, 0);
>         if (IS_ERR(dat))
> --
> 2.35.1
>

All three applied, thanks!

Bart
