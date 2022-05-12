Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE91524700
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiELHaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351041AbiELH3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:29:54 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E670E13C4F2;
        Thu, 12 May 2022 00:29:49 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id h13so3814182qvh.0;
        Thu, 12 May 2022 00:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2Mjon8tDago0stqZjye2DqrZ9qBLDemw/CYSCXDVYo=;
        b=GYbntmWUfjRS87Kpx8ZINI0JaZ9LaDt/5pJoG51qAllglwCFhtVkTOYpyNdUdJVl01
         rlXeJHWP7olORRdWItj5hzsMrlJJQ1ioyBiy0AHpwnsxZdvnqT1GKJ3tZd1980jm9Olo
         5yd2Y0o+o0Vii7mRWfGH/7QU7zMhyrWgtfPWCexU0+Wxx1GLIDR6T3PbXbjumfeLCsCd
         o5joPSM0fY0/4epieB9ywGYud/ITtONVs01So0mSGjWEZ7sJaLkaf7ibUFau2YRdn9Gv
         4NDmcfWjGbNv9FOAiQdtqCpaqwbGtKQj5IIwG64wwBqjm97Q5FVeNPkm+eWCjIktTzXc
         v1Fw==
X-Gm-Message-State: AOAM5332LrA3Cce7UOqDexd8urbCw8rrY5Rhshc+pQvPrPuaBWEwjShw
        y1fsE4bfxD5m+FOLnqfm+FfpQO+pWz24ug==
X-Google-Smtp-Source: ABdhPJxD4fdBBnAmA/pKo7J1uN7PFs0kfOKBHyUOMhXwi8gOV35ue7L1wCDtbj7mw4zO7vB6g6ajaw==
X-Received: by 2002:a0c:aad7:0:b0:45a:9960:6097 with SMTP id g23-20020a0caad7000000b0045a99606097mr26345268qvb.55.1652340588840;
        Thu, 12 May 2022 00:29:48 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id e2-20020ac84e42000000b002f39b99f6c6sm2876638qtw.96.2022.05.12.00.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:29:47 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id s30so8158880ybi.8;
        Thu, 12 May 2022 00:29:46 -0700 (PDT)
X-Received: by 2002:a25:448:0:b0:64a:94d6:e420 with SMTP id
 69-20020a250448000000b0064a94d6e420mr22441804ybe.89.1652340586589; Thu, 12
 May 2022 00:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 09:29:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUiq3svPa+OMmG70HP-3h4gKV6puoT8QUm3WgPw+e4i=A@mail.gmail.com>
Message-ID: <CAMuHMdUiq3svPa+OMmG70HP-3h4gKV6puoT8QUm3WgPw+e4i=A@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: gpiolib: Add ngirq member to struct gpio_irq_chip
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Supported GPIO IRQs by the chip is not always equal to the number of GPIO
> pins. For example on Renesas RZ/G2L SoC where it has GPIO0-122 pins but at
> a give point a maximum of only 32 GPIO pins can be used as IRQ lines in
> the IRQC domain.
>
> This patch adds ngirq member to struct gpio_irq_chip and passes this as a
> size to irq_domain_create_hierarchy()/irq_domain_create_simple() if it is
> being set in the driver otherwise fallbacks to using ngpio.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1221,7 +1221,7 @@ static int gpiochip_hierarchy_add_domain(struct gpio_chip *gc)
>         gc->irq.domain = irq_domain_create_hierarchy(
>                 gc->irq.parent_domain,
>                 0,
> -               gc->ngpio,
> +               gc->irq.ngirq ?: gc->ngpio,
>                 gc->irq.fwnode,
>                 &gc->irq.child_irq_domain_ops,
>                 gc);
> @@ -1574,7 +1574,7 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>         } else {
>                 /* Some drivers provide custom irqdomain ops */
>                 gc->irq.domain = irq_domain_create_simple(fwnode,
> -                       gc->ngpio,
> +                       gc->irq.ngirq ?: gc->ngpio,
>                         gc->irq.first,
>                         gc->irq.domain_ops ?: &gpiochip_domain_ops,
>                         gc);

OK.

gpiochip_irqchip_remove() does:

        /* Remove all IRQ mappings and delete the domain */
        if (gc->irq.domain) {
                unsigned int irq;

                for (offset = 0; offset < gc->ngpio; offset++) {
                       if (!gpiochip_irqchip_irq_valid(gc, offset))

Hence it relies on gc->irq.valid_mask, which I think is OK in general.

                                continue;

                        irq = irq_find_mapping(gc->irq.domain, offset);
                        irq_dispose_mapping(irq);
                }

                irq_domain_remove(gc->irq.domain);

        }

> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -51,6 +51,14 @@ struct gpio_irq_chip {
>          */
>         const struct irq_domain_ops *domain_ops;
>
> +       /**
> +        * @ngirq:
> +        *
> +        * The number of GPIO IRQ's handled by this IRQ domain; usually is
> +        * equal to ngpio.

"If not set, ngpio will be used."

> +        */
> +       u16 ngirq;
> +
>  #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
>         /**
>          * @fwnode:

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
