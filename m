Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA684AC646
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382358AbiBGQn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390804AbiBGQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:36:13 -0500
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E1BC0401CE;
        Mon,  7 Feb 2022 08:36:12 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id o15so8178636vki.2;
        Mon, 07 Feb 2022 08:36:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w6IGA7V5zDBaCNKiEK2HC79Yzqp6NW/Ipn76BHSEzaU=;
        b=RRGZqcTgKfSZgDEkyNwGTBmF9/ZkI1rOSw6iDiglNIFZbGvybiBzAcAEwon+PstGVD
         N51ye7b/4NrmoNeqwLq8tebeXYkzlMkwFJn5VVlrmrsKv9bAd6oB0EIdYBtaUQulGaZO
         yMiNB/OhQSL2lzHRh9cKlWH+U8iMEYi2RqbF2l7zViuV5WxtdifVJb93rrZPm32s6SsJ
         8vuEFhRC/qGv+k6+Y9oODZw2JlVT3Hbz3YggpPX+xupbGXGztjEnV9mweejUrxAjfWP5
         Sh8I5LzcmwfkBVwPvtxMOilMoeXE5tiVT8puq0RbMwr2i5iLajNRBVIhrBBJcQithNwO
         hbfA==
X-Gm-Message-State: AOAM532QSwPM6xjSZoJPlu2VuCxy3YEmHCek4slREdG93h9ZYwFeYCR0
        NIE2YrJ8TbbDwi0oYXChg1BQukjoRipsbQ==
X-Google-Smtp-Source: ABdhPJyubp38dZ54VKKqION5R7DEn/FrfY3HxN2vVufQFh9ngkCjPJJDuf6VAiX/AB9AIZqgDSbuRQ==
X-Received: by 2002:a05:6122:209f:: with SMTP id i31mr210934vkd.3.1644251771891;
        Mon, 07 Feb 2022 08:36:11 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id t14sm2405584vkb.2.2022.02.07.08.36.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 08:36:11 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id o11so7258258vkl.11;
        Mon, 07 Feb 2022 08:36:11 -0800 (PST)
X-Received: by 2002:a05:6122:1254:: with SMTP id b20mr234876vkp.0.1644251770817;
 Mon, 07 Feb 2022 08:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20220204161806.3126321-1-jjhiblot@traphandler.com> <20220204161806.3126321-7-jjhiblot@traphandler.com>
In-Reply-To: <20220204161806.3126321-7-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Feb 2022 17:35:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWhxq_RyKS3Ugk64bAsNfJx4GB8SHH3nZz-ybY5iaEOwQ@mail.gmail.com>
Message-ID: <CAMuHMdWhxq_RyKS3Ugk64bAsNfJx4GB8SHH3nZz-ybY5iaEOwQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] watchdog: Add Renesas RZ/N1 Watchdog driver
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Jacques,

On Fri, Feb 4, 2022 at 5:18 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> From: Phil Edworthy <phil.edworthy@renesas.com>
>
> This is a driver for the standard WDT on the RZ/N1 devices. This WDT has
> very limited timeout capabilities. However, it can reset the device.
> To do so, the corresponding bits in the SysCtrl RSTEN register need to
> be enabled. This is not done by this driver.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/watchdog/rzn1_wdt.c
> @@ -0,0 +1,197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Renesas RZ/N1 Watchdog timer.
> + * This is a 12-bit timer driver from a (62.5/16384) MHz clock. It can't even
> + * cope with 2 seconds.
> + *
> + * Copyright 2018 Renesas Electronics Europe Ltd.
> + *
> + * Derived from Ralink RT288x watchdog timer.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +#define RZN1_WDT_RETRIGGER                     0x0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL          0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK     0xfff
> +#define RZN1_WDT_RETRIGGER_PRESCALE            BIT(12)
> +#define RZN1_WDT_RETRIGGER_ENABLE              BIT(13)
> +#define RZN1_WDT_RETRIGGER_WDSI                        (0x2 << 14)
> +
> +#define RZN1_WDT_PRESCALER                     BIT(14)

"BIT(14)" is a bit strange, as this is used as a scalar, never as
a bitmask.

> +static int rzn1_wdt_set_timeout(struct watchdog_device *w, unsigned int t)
> +{
> +       struct rzn1_watchdog *wdt = to_rzn1_watchdog(w);
> +
> +       w->timeout = t;
> +
> +       wdt->reload_val = (t * wdt->clk_rate) / RZN1_WDT_PRESCALER;

I guess the multiplication can overflow in 32-bit arithmetic?

> +
> +       return 0;
> +}

> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
> +       struct rzn1_watchdog *wdt;
> +       int ret;
> +       struct device_node *np = pdev->dev.of_node;
> +       int err;
> +       struct clk *clk;
> +
> +       wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +       if (!wdt)
> +               return -ENOMEM;
> +       wdt->dev = &pdev->dev;
> +       wdt->wdt = rzn1_wdt_dev;
> +       platform_set_drvdata(pdev, wdt);
> +
> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(wdt->base)) {
> +               dev_err(wdt->dev, "unable to get register bank\n");

No need to print an error message, __devm_ioremap_resource() takes
care of that.

> +               return PTR_ERR(wdt->base);
> +       }
> +       wdt->irq = irq_of_parse_and_map(np, 0);
> +       if (wdt->irq == NO_IRQ) {
> +               dev_err(wdt->dev, "failed to get IRQ from DT\n");
> +               return -EINVAL;
> +       }

Please use platform_get_irq() instead. Note that on error, it prints
an error message, and returns a negative value.  So you cannot assign
it to wdt->irq before checking, as the latter is unsigned:

    ret = platform_get_irq(pdev, 0);
    if (ret < 0)
            return ret;

    wdt->irq = ret;

> +       wdt->reload_val = RZN1_WDT_MAX;
> +       wdt->wdt.max_hw_heartbeat_ms = (RZN1_WDT_MAX * 1000) /
> +                                       (wdt->clk_rate / RZN1_WDT_PRESCALER);

To avoid loss of precision, it's better to reorder operations.
As the dividend doesn't fit in 32-bit, you have to use a
64-bit-by-unsigned-long division:

    div64_ul(RZN1_WDT_MAX * 1000ULL * RZN1_WDT_PRESCALER,
             wdt->clk_rate);

> +
> +       ret = watchdog_init_timeout(&wdt->wdt, 0, &pdev->dev);
> +       if (ret)
> +               dev_warn(&pdev->dev, "Specified timeout invalid, using default");
> +
> +       ret = devm_watchdog_register_device(&pdev->dev, &wdt->wdt);

"return devm_watchdog_register_device(...);"?

> +       if (ret)
> +               goto error;
> +
> +       dev_info(wdt->dev, "Initialized\n");
> +
> +       return 0;


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
