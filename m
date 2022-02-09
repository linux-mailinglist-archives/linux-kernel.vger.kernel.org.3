Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9354B0153
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiBIXcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:32:02 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiBIXbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:31:11 -0500
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D586E05ADC2;
        Wed,  9 Feb 2022 15:31:07 -0800 (PST)
Received: by mail-pf1-f175.google.com with SMTP id x15so4671634pfr.5;
        Wed, 09 Feb 2022 15:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6xycm4hmRCeCF2fAz0KCw4zeWL4PHOyrTUozMcCahg=;
        b=daUDlzRSzeRmDEwY9mkz98eKlgDZcHKh1oa/CP8NP0GkjL7NNmO6ATklbHr0etgDEy
         jAkD8zVdqEhaFN+mqgWtpKoedZAnI+nilNIG/gtknw0FSDgO/lwrBN4RQMLBuilHBLD3
         iTeTlrHY+JmD468WivMV49jjsYRkwthVwi0w13nU01kYngsx8P8oMVY3l4WGxZJ4cqLg
         4y0XQZbuNHts84vNXlXwabt7tcaBUh41Q/NfXxLuDyWxD5LvvA53eTFO0KqofnWwV4kq
         /TGBTE+lnG/Q9LwHodVJHfEu6hH6MPdkK/KQbfIPWQB58fFBdRq4hoK34zCoFOWqj8QR
         c2HA==
X-Gm-Message-State: AOAM532cZf0LCTu83xcDssgMMCdilAYr0mvhR1QyfT34gQMy+rzOQ2uf
        EF+XUoj+VagGF14cU8EYK2hhw65eCzOburdf+zD/1l2e
X-Google-Smtp-Source: ABdhPJxZqhpWC2lwtdeFkToCcerNanbm+NA01wfUW90jqS8wOVU85ldbDkA3kOg6hERpzClJNyhZzpHahX3cMAC0zcE=
X-Received: by 2002:a63:2a02:: with SMTP id q2mr3781413pgq.519.1644449466554;
 Wed, 09 Feb 2022 15:31:06 -0800 (PST)
MIME-Version: 1.0
References: <20220209162607.1118325-1-maz@kernel.org> <20220209162607.1118325-11-maz@kernel.org>
In-Reply-To: <20220209162607.1118325-11-maz@kernel.org>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Thu, 10 Feb 2022 00:30:55 +0100
Message-ID: <CANBLGcwKeLn7Q1Ra8pCw=cXy=kJeEFRmBjOxjds10+k70LvzXA@mail.gmail.com>
Subject: Re: [PATCH 10/10] pinctrl: starfive: Switch to dynamic chip name output
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        kernel-team@android.com
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

On Wed, 9 Feb 2022 at 17:49, Marc Zyngier <maz@kernel.org> wrote:
>
> Instead of overloading the name field, use the relevant callback to
> output the device name.
>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/pinctrl/pinctrl-starfive.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-starfive.c b/drivers/pinctrl/pinctrl-starfive.c
> index 5be9866c2b3c..f29d9ccf858b 100644
> --- a/drivers/pinctrl/pinctrl-starfive.c
> +++ b/drivers/pinctrl/pinctrl-starfive.c
> @@ -15,6 +15,7 @@
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
> +#include <linux/seq_file.h>
>  #include <linux/spinlock.h>
>
>  #include <linux/pinctrl/pinctrl.h>
> @@ -1163,12 +1164,20 @@ static int starfive_irq_set_type(struct irq_data *d, unsigned int trigger)
>         return 0;
>  }
>
> +static void starfive_irq_print_chip(struct irq_data *d, struct seq_file *p)
> +{
> +       struct starfive_pinctrl *sfp = starfive_from_irq_data(d);
> +
> +       seq_printf(p, sfp->gc.label);
> +}
> +
>  static struct irq_chip starfive_irq_chip = {
>         .irq_ack = starfive_irq_ack,
>         .irq_mask = starfive_irq_mask,
>         .irq_mask_ack = starfive_irq_mask_ack,
>         .irq_unmask = starfive_irq_unmask,
>         .irq_set_type = starfive_irq_set_type,
> +       .irq_print_chip = starfive_irq_print_chip,
>         .flags = IRQCHIP_SET_TYPE_MASKED,
>  };

The parent interrupt doesn't show up in /proc/interrupts anyway, so if
setting the name is considered abuse we can just drop the addition
above and just delete the two lines below.

The gpio framework seems to fill in default handlers in the struct
above, so unfortunately it can't yet be made const. Is this something
you intend to fix in the future?

> @@ -1307,8 +1316,6 @@ static int starfive_probe(struct platform_device *pdev)
>         sfp->gc.base = -1;
>         sfp->gc.ngpio = NR_GPIOS;
>
> -       starfive_irq_chip.name = sfp->gc.label;
> -
>         sfp->gc.irq.chip = &starfive_irq_chip;
>         sfp->gc.irq.parent_handler = starfive_gpio_irq_handler;
>         sfp->gc.irq.num_parents = 1;
> --
> 2.30.2
>
