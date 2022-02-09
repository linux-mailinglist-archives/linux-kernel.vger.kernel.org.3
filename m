Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C250E4AEC5D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiBII3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:29:13 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiBII3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:29:07 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C853C05CBBE;
        Wed,  9 Feb 2022 00:28:55 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id f6so1731987vsa.5;
        Wed, 09 Feb 2022 00:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfJBTLXzI7eyNZEn87oG5nH5B0aw/JRn1EB0ZDzVuOc=;
        b=0z5BLcjtUo+t9I9YQ2Qhc91zLqn1IDcK47A5ad3FCygnfMELZ3BXgQUmLlOMVNHuTz
         fKBKdlcjWR1DmZlgZeVjYsxgqjHfIJlzq1mLOAyRTpt6PiuswfEzkQfRDGzwaB3j5Yy8
         kSLRB/lr6QjjYQpHNFNqeq7Jh6gIvkEzH+MndWIYQltn9ijo4u6qdL1xjIl/el2QTt8y
         SwttbiJ92xdTQ+DEoDQyp87V/G93XOR5uqtv5MJ2B9P4JNmUe03KyrI0sxQ7tVqOHoAz
         MkvRk6NWVBvYFMRMPE/RpIwa9LPAxsPIhreXrMcwlYsi/sT268bKhpDvrC+9EgscGCGo
         9FfQ==
X-Gm-Message-State: AOAM530+1eM0W9sPIE0i7XG/84fMDxE9zAFMLCpVRrbMIwMxFxS5g6uw
        mVvDEejYVyTcA4Ku+CBt3X49JTaiW3k49w==
X-Google-Smtp-Source: ABdhPJzIMhigm0wwsjiTQmt+wWOcd9W46b4Pk94/YNum4RScjfDOeMskaNJE2G181RnOrcK6OShxPg==
X-Received: by 2002:a67:ea4e:: with SMTP id r14mr290996vso.51.1644395334432;
        Wed, 09 Feb 2022 00:28:54 -0800 (PST)
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com. [209.85.217.53])
        by smtp.gmail.com with ESMTPSA id b191sm3239091vkb.32.2022.02.09.00.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:28:54 -0800 (PST)
Received: by mail-vs1-f53.google.com with SMTP id w6so1320851vsf.3;
        Wed, 09 Feb 2022 00:28:54 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr379149vst.68.1644395333887;
 Wed, 09 Feb 2022 00:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20220208183511.2925304-1-jjhiblot@traphandler.com> <20220208183511.2925304-6-jjhiblot@traphandler.com>
In-Reply-To: <20220208183511.2925304-6-jjhiblot@traphandler.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 09:28:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV4PM9gC2wDZJKXKUt7AG2wS+adub=M+d0BrOedZ9ENPg@mail.gmail.com>
Message-ID: <CAMuHMdV4PM9gC2wDZJKXKUt7AG2wS+adub=M+d0BrOedZ9ENPg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] watchdog: Add Renesas RZ/N1 Watchdog driver
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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

On Tue, Feb 8, 2022 at 7:35 PM Jean-Jacques Hiblot
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
> @@ -0,0 +1,208 @@
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
> +#define DEFAULT_TIMEOUT                60
> +
> +#define RZN1_WDT_RETRIGGER                     0x0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL          0
> +#define RZN1_WDT_RETRIGGER_RELOAD_VAL_MASK     0xfff
> +#define RZN1_WDT_RETRIGGER_PRESCALE            BIT(12)
> +#define RZN1_WDT_RETRIGGER_ENABLE              BIT(13)
> +#define RZN1_WDT_RETRIGGER_WDSI                        (0x2 << 14)
> +
> +#define RZN1_WDT_PRESCALER                     16384
> +#define RZN1_WDT_MAX                           4095
> +
> +struct rzn1_watchdog {
> +       struct watchdog_device          wdt;
> +       void __iomem                    *base;
> +       unsigned long                   clk_rate;
> +};
> +
> +#define to_rzn1_watchdog(_ptr) \
> +       container_of(_ptr, struct rzn1_watchdog, wdt)
> +
> +static inline uint32_t get_max_heart_beat(uint32_t clk_rate)

unsigned long clk_rate

> +{
> +       return (RZN1_WDT_MAX * RZN1_WDT_PRESCALER) / (clk_rate / 1000);

Is clk_rate always a multiple of 1000? If not, you want to reorder
this to avoid losing precision.

> +}
> +static inline uint32_t compute_reload_value(uint32_t tick_ms, uint32_t clk)

unsigned long clk_rate

> +{
> +       return (tick_ms * (clk / 1000)) / RZN1_WDT_PRESCALER;

Likewise.

> +}

> +static int rzn1_wdt_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct rzn1_watchdog *wdt;
> +       struct device_node *np = dev->of_node;
> +       struct clk *clk;
> +       int ret;
> +       int irq;
> +
> +       wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +       if (!wdt)
> +               return -ENOMEM;
> +
> +       wdt->wdt = rzn1_wdt;
> +       wdt->wdt.parent = dev;
> +
> +       wdt->base = devm_platform_ioremap_resource(pdev, 0);
> +       if (IS_ERR(wdt->base))
> +               return PTR_ERR(wdt->base);
> +
> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(dev, "failed to get the irq\n");

No need to print a message, platform_get_irq() already does that.

> +               return irq;
> +       }
> +
> +       ret = devm_request_irq(dev, irq, rzn1_wdt_irq, 0,
> +                              np->name, wdt);
> +       if (ret) {
> +               dev_err(dev, "failed to request irq %d\n", irq);
> +               return ret;
> +       }
> +
> +       clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(dev, "failed to get the clock\n");
> +               return PTR_ERR(clk);
> +       }
> +
> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(dev, "failed to prepare/enable the clock\n");
> +               return ret;
> +       }
> +
> +       ret = devm_add_action_or_reset(dev, rzn1_wdt_clk_disable_unprepare,
> +                                      clk);
> +       if (ret) {
> +               dev_err(dev, "failed to register clock unprepare callback\n");
> +               clk_disable_unprepare(clk);

Please drop this, as devm_add_action_or_reset() calls the
action on failure.

> +               return ret;
> +       }
> +
> +       wdt->clk_rate = clk_get_rate(clk);
> +       if (!wdt->clk_rate) {
> +               dev_err(dev, "failed to get the clock rate\n");
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * The period of the watchdog cannot be changed once set
> +        * and is limited to a very short period.
> +        * Configure it for a 1s period once and for all, and
> +        * rely on the heart-beat provided by the watchdog core
> +        * to make this usable by the user-space.
> +        */
> +       wdt->wdt.max_hw_heartbeat_ms = get_max_heart_beat(wdt->clk_rate);
> +       if (wdt->wdt.max_hw_heartbeat_ms > 1000)
> +               wdt->wdt.max_hw_heartbeat_ms = 1000;
> +
> +       wdt->wdt.timeout = DEFAULT_TIMEOUT;
> +       ret = watchdog_init_timeout(&wdt->wdt, 0, dev);
> +
> +       return devm_watchdog_register_device(dev, &wdt->wdt);
> +}
> +
> +
> +static const struct of_device_id rzn1_wdt_match[] = {
> +       { .compatible = "renesas,r9a06g032-wdt" },

No need to match on the soc-specific compatible value, as the
family-specific value should be present in the DTB, too.

> +       { .compatible = "renesas,rzn1-wdt" },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, rzn1_wdt_match);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
