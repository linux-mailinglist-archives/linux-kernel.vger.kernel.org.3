Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0265735EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235804AbiGMMAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiGMMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:00:10 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4FF54CD;
        Wed, 13 Jul 2022 05:00:09 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ef5380669cso109754427b3.9;
        Wed, 13 Jul 2022 05:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqFcQmgGQGc7DUvpJqUQSaobZTRakvVtcLc5e1986Vg=;
        b=KhrYSrsfk8B9x/UWggXcmUu32sbl1kCbFRyaN1DN5TzUwr96/dDlMsHnUkApLAl2/v
         DRGra9Hj2Ww4eMIz2rOWnyKZUXh3lVVEQsMxP1R2+c4rHwOWvySRfl1b7g1X+MizOaep
         /ieaGTJW0zRzov/nWOTU3ihjS9RqB4YvnhAGNWMqWrYYNNezRh8MM/bWxLXYHUiWxtr/
         RK0JDk+rDbIU7z/WaARg1Jzg6XEjAeceLGBjNZgihUKHOy9wcwNPxdku5770oTw8NR+a
         Olz8IVAUeC90C27gzlIptJK7gr/FVa4YSj1HBPZtgEgjw9L0PqTGhBWarpTxlZV0IFa2
         wfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqFcQmgGQGc7DUvpJqUQSaobZTRakvVtcLc5e1986Vg=;
        b=tdwCMgLrr0Bh5Q8JzYpHx+fKfNj1LL/h2d4CmX/POImjGMd1JsV7sSGIlcLCXCeDXt
         Y2m8B8JPwGZl3UFDKKAe8qGCo2sa2KUac2zQ/FQxFgCmH0JPuETR15RdUg3+yi67csDs
         dV77Q75+4i4DTvxcpt7OEGEAwV1pmj41S5nEhZr4/x17ArbnMHEVhlHkChjGVACpqii9
         yFl16WKckptY8/riwUrH1Xf/MeIpatFsZvR+M+yHiOKxEPUOor7CyT7Z3TWOobaRL8Nv
         TruXXTEQI4jhNkPSn7qwgOZGbGF30vW4BvYE5IGrV/ESo9vnuCLi1FsMjeJeyBQs3lsT
         yUsw==
X-Gm-Message-State: AJIora/XZY4iF4nrQsOmh6PggNJMoMHY26GYvYrnHnLUN7XF/e4OLw4s
        JD34dVvARwwETNMfQjreHA78IVOdmKc1gth6LuE=
X-Google-Smtp-Source: AGRyM1syQeK/8RcImkP0kJZa5KTMfWyLkuNxadGq7hNXN7TJYZiJaCWins20mzbQKrVOPZN5cWibsrXT/1Ly2VM5GmA=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr3630269ywa.185.1657713608712; Wed, 13
 Jul 2022 05:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220713105910.931983-1-lewis.hanly@microchip.com> <20220713105910.931983-2-lewis.hanly@microchip.com>
In-Reply-To: <20220713105910.931983-2-lewis.hanly@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Jul 2022 13:59:32 +0200
Message-ID: <CAHp75VfGTd02jKYsFq94BF_Gqro2trk3iyyALBatS1Bps3HYhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] gpio: mpfs: add polarfire soc gpio support
To:     lewis.hanly@microchip.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Marc Zyngier <maz@kernel.org>, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com
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

On Wed, Jul 13, 2022 at 1:00 PM <lewis.hanly@microchip.com> wrote:
>
> From: Lewis Hanly <lewis.hanly@microchip.com>
>
> Add a driver to support the Polarfire SoC gpio controller.

GPIO

...

Below my comments, I have tried hard not to duplicate what Conor
already mentioned. So consider this as additional part.

...

> +config GPIO_POLARFIRE_SOC
> +       bool "Microchip FPGA GPIO support"

Why not tristate?

> +       depends on OF_GPIO

Why?

> +       select GPIOLIB_IRQCHIP
> +       select IRQ_DOMAIN_HIERARCHY

More naturally this line looks if put before GPIOLB_IRQCHIP one.

> +       select GPIO_GENERIC
> +       help
> +         Say yes here to support the GPIO device on Microchip FPGAs.

When allowing it to be a module, add a text that tells how the driver
will be called.

...

> +/*
> + * Microchip PolarFire SoC (MPFS) GPIO controller driver
> + *
> + * Copyright (c) 2018-2022 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Lewis Hanly <lewis.hanly@microchip.com>

> + *

This line is not needed.

> + */

...

> +#include <linux/of.h>
> +#include <linux/of_irq.h>

Why?

Also don't forget mod_devicetable.h.

...

> +#define NUM_GPIO                       32
> +#define BYTE_BOUNDARY                  0x04

Without namespace?

...

> +       gpio_cfg = readl(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY));

> +

Unneeded line.

> +       if (gpio_cfg & MPFS_GPIO_EN_IN)
> +               return 1;
> +
> +       return 0;

Don't we have specific definitions for the directions?

...

> +       struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
> +       int gpio_index = irqd_to_hwirq(data);
> +       u32 interrupt_type;

> +       struct mpfs_gpio_chip *mpfs_gpio = gpiochip_get_data(gc);

This line naturally looks better before interrupt_type definition.
Try to keep the "longest line first" everywhere in the driver.

> +       u32 gpio_cfg;
> +       unsigned long flags;

...

> +       switch (type) {
> +       case IRQ_TYPE_EDGE_BOTH:
> +               interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_BOTH;
> +               break;

> +

Unneeded line here and everywhere in the similar cases in the entire code.

> +       case IRQ_TYPE_EDGE_FALLING:
> +               interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_NEG;
> +               break;
> +
> +       case IRQ_TYPE_EDGE_RISING:
> +               interrupt_type = MPFS_GPIO_TYPE_INT_EDGE_POS;
> +               break;
> +
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               interrupt_type = MPFS_GPIO_TYPE_INT_LEVEL_HIGH;
> +               break;
> +
> +       case IRQ_TYPE_LEVEL_LOW:
> +               interrupt_type = MPFS_GPIO_TYPE_INT_LEVEL_LOW;
> +               break;
> +       }

...

> +       mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY),
> +                            MPFS_GPIO_EN_INT, 1);

Too many parentheses.

...

> +       mpfs_gpio_assign_bit(mpfs_gpio->base + (gpio_index * BYTE_BOUNDARY),
> +                            MPFS_GPIO_EN_INT, 0);

Ditto.

...

> +static int mpfs_gpio_irq_set_affinity(struct irq_data *data,
> +                                     const struct cpumask *dest,
> +                                     bool force)
> +{

> +       if (data->parent_data)

> +               return irq_chip_set_affinity_parent(data, dest, force);
> +
> +       return -EINVAL;
> +}

Why do you need this? Isn't it taken care of by the IRQ chip core?

...

> +       struct clk *clk;
> +       struct device *dev = &pdev->dev;

> +       struct device_node *node = pdev->dev.of_node;
> +       struct device_node *irq_parent;

Why do you need these?

> +       struct gpio_irq_chip *girq;
> +       struct irq_domain *parent;
> +       struct mpfs_gpio_chip *mpfs_gpio;
> +       int i, ret, ngpio;

...

> +       clk = devm_clk_get(&pdev->dev, NULL);
> +       if (IS_ERR(clk)) {
> +               dev_err(&pdev->dev, "devm_clk_get failed\n");
> +               return PTR_ERR(clk);
> +       }

return dev_err_probe(...);

It's not only convenient, but here it fixes a bug.

> +       ret = clk_prepare_enable(clk);
> +       if (ret) {
> +               dev_err(&pdev->dev, "failed to enable clock\n");
> +               return ret;

return dev_err_probe(...);

> +       }

Make it managed as well in addition to gpiochip_add_data(), otherwise
you will have wrong ordering.

...

> +       ngpio = of_irq_count(node);
> +       if (ngpio > NUM_GPIO) {

> +               dev_err(dev, "Too many GPIO interrupts (max=%d)\n",
> +                       NUM_GPIO);
> +               ret = -ENXIO;
> +               goto cleanup_clock;

return dev_err_probe(...);

> +       }
> +
> +       irq_parent = of_irq_find_parent(node);
> +       if (!irq_parent) {
> +               dev_err(dev, "no IRQ parent node\n");
> +               ret = -ENODEV;
> +               goto cleanup_clock;

Ditto.

> +       }
> +       parent = irq_find_host(irq_parent);
> +       if (!parent) {
> +               dev_err(dev, "no IRQ parent domain\n");
> +               ret = -ENODEV;
> +               goto cleanup_clock;

Ditto.

> +       }

Why do you need all these? Seems a copy'n'paste from gpio-sifive,
which is the only GPIO driver using this pattern.

...

> +               mpfs_gpio_assign_bit(mpfs_gpio->base + (i * BYTE_BOUNDARY),
> +                                    MPFS_GPIO_EN_INT, 0);

Too many parentheses.


> +       girq->fwnode = of_node_to_fwnode(node);

This is an interesting way of

    ...->fwnode = dev_fwnode(dev);


...

> +       dev_info(dev, "Microchip MPFS GPIO registered, ngpio=%d\n", ngpio);

Noise.

...

> +               .of_match_table = of_match_ptr(mpfs_gpio_match),

Please, avoid using of_match_ptr(). It brings more harm than usefulness.

-- 
With Best Regards,
Andy Shevchenko
