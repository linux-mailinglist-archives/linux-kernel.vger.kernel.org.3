Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E16524724
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351008AbiELHjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351138AbiELHja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:39:30 -0400
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862676C540;
        Thu, 12 May 2022 00:39:27 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id h13so3825682qvh.0;
        Thu, 12 May 2022 00:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/a3zW+rITF/ZbovcnHnUbynM+/qA3KOenciLxfbKnzs=;
        b=GKIqn7SQw6d1D5m11jx/dbrrLtn4f8iXZ+CLzC5o6ZNluXK2CtwaL+G20eNF29VrMo
         aAHWWt8ZsNJ1hu7oI2l0MYpYReZ+L9N/4QTrvrytXRaHuBmhM/kTLhenuhuAdiacO1Tm
         VoxPW3iBCMlKoj8Esl6Rix+hzIPWn6zSpoSkx8NgHQXGl6inir4rnYmKhT5Og43cZn39
         yWzCrC0CGfLYQ4PB+2kSYJ7CZEUe2ZF5tyPdvQDpyyRWyfgorO2vNSi8JhYCnVo6u2+P
         ku2M/1zP/gBwMXCwVA4rLrfr42pz6fxSureCKLWiriIlgABSxELIMR7YITTCttPsLgFw
         70kw==
X-Gm-Message-State: AOAM533YoPVmRv3OP0k5zsgM9MoLFEjWrsH4druBgN8T+ab7vXhq6aKV
        j3VmvXTc8RCsPKXSaJnuteLJjmECIfqt7A==
X-Google-Smtp-Source: ABdhPJx7NhwG7fp1uq4BhsLTdCiTiv2BXcSaC8Bj9RXlYlgLN8ErXWGnbBxGfBFvoO3bjN/KiGHnfg==
X-Received: by 2002:a05:6214:1c83:b0:443:6749:51f8 with SMTP id ib3-20020a0562141c8300b00443674951f8mr25538581qvb.74.1652341166428;
        Thu, 12 May 2022 00:39:26 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id h124-20020a376c82000000b0069fc13ce203sm2553104qkc.52.2022.05.12.00.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 00:39:25 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2f7b815ac06so46657427b3.3;
        Thu, 12 May 2022 00:39:25 -0700 (PDT)
X-Received: by 2002:a81:6588:0:b0:2f8:b75e:1e1a with SMTP id
 z130-20020a816588000000b002f8b75e1e1amr30053583ywb.358.1652341165120; Thu, 12
 May 2022 00:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220511183210.5248-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 May 2022 09:39:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
Message-ID: <CAMuHMdXDQ+eECWwvAGOb-MaN16H17qm_v_1baZ7PdT8qx9McSw@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Wed, May 11, 2022 at 8:32 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.

domain

> GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be
> used as IRQ lines at given time. Selection of pins as IRQ lines

at a given time

> is handled by IA55 (which is the IRQC block) which sits in between the
> GPIO and GIC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c

>  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
>  {
>         struct device_node *np = pctrl->dev->of_node;
>         struct gpio_chip *chip = &pctrl->gpio_chip;
>         const char *name = dev_name(pctrl->dev);
> +       struct irq_domain *parent_domain;
>         struct of_phandle_args of_args;
> +       struct device_node *parent_np;
> +       struct gpio_irq_chip *girq;
>         int ret;
>
> +       parent_np = of_irq_find_parent(np);
> +       if (!parent_np)
> +               return -ENXIO;
> +
> +       parent_domain = irq_find_host(parent_np);
> +       of_node_put(parent_np);
> +       if (!parent_domain)
> +               return -EPROBE_DEFER;
> +
>         ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0, &of_args);
>         if (ret) {
>                 dev_err(pctrl->dev, "Unable to parse gpio-ranges\n");
> @@ -1138,6 +1330,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)
>         chip->base = -1;
>         chip->ngpio = of_args.args[2];
>
> +       girq = &chip->irq;
> +       girq->chip = &rzg2l_gpio_irqchip;
> +       girq->fwnode = of_node_to_fwnode(np);
> +       girq->parent_domain = parent_domain;
> +       girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> +       girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> +       girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> +       girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> +

I think you need to provide a .init_valid_mask() callback, as
gpiochip_irqchip_remove() relies on that for destroying interrupts.
However, the mask will need to be dynamic, as GPIO interrupts can be
mapped and unmapped to one of the 32 available interrupts dynamically,
right?
I'm not sure if that can be done easily: if gpiochip_irqchip_irq_valid()
is ever called too early, before the mapping is done, it would fail.

>         pctrl->gpio_range.id = 0;
>         pctrl->gpio_range.pin_base = 0;
>         pctrl->gpio_range.base = 0;


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
