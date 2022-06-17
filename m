Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9768954FAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383204AbiFQQMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383176AbiFQQMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:12:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C2E3CA5A;
        Fri, 17 Jun 2022 09:12:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id me5so9686395ejb.2;
        Fri, 17 Jun 2022 09:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkWBEoYROYFPkO8O2oGYhag4IZXC0DYd+b57eJG9PU4=;
        b=XuF46wcpohhcJbZiGA3bWfk827eeBjKW+tUfKWo9v3XTjwbFZ8ruy2LRqzdp/PFEwr
         n1qkB6lIf3nhW/vqVd0r9ir3nGAi/nuCjI8f2V+z+Juz2Nvr3CqgNAwouRaT6Lc7y6RG
         /D9ounJnDPTjBk9iCYpCt8bfIJoWb3L8nFfBvkxHEcxiBZCwWlN0FJFxbvONjxKd+b+9
         ccTK8ug4BSNxbSVzR2WdGLNo0ssOIgwy6xGjboeBDnTeTjBnFvUtzci72MrDKeS/jGyI
         y7KkGMlilIyWdAZ0v/ojVmBU0xRzAUR5d1eIPkxqf3FjpJSb63WhM3i8CgbPvWmpR+xN
         ZR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkWBEoYROYFPkO8O2oGYhag4IZXC0DYd+b57eJG9PU4=;
        b=rBnwZ1yITbjkOrCbCJtKVr34PYkx5dQKpPAbIjAmX4sOzlwZx76DlwlmLAsHCiuq4x
         SxfDSnDfH4M29S8zBT/RRA5V90TO5bsQojauKqEpASXAdTdQMPMoxbO8nF4Z+shuIeWx
         FUly21dfv0is4O0Yd571SxDuACROCrs1YXO/T7v1clcr21ci/01f8ZSvnBZuB+nxPFXv
         TdCCBXsOS6xr7MC2fvN1plYGp1yNSq6CcbANj+EbYVJOG/zKXEb+25+YWHykGJ4HiJ6K
         rCUrW26U0WXUJ9OL244SxRWhDo2swEyieTZCosikE/N2mpiKhlJkOdimmohtzcsgknyH
         8bgg==
X-Gm-Message-State: AJIora/NZL+ydcQ7m6dByETt9Z9uDfu10E8rOF1kvQ54B7mc2kRAOlAl
        fJdVXrZ2V/Nk6xAvXXbi4cLZUXf9p+sQ89pd1aI=
X-Google-Smtp-Source: AGRyM1tMi+HZrksSjd3rZFxe0IpQGaA4f3tKAoAHLuPl3Ty2XshNDwJZKTeG1mo1g60oC1DQJKW5QPkmiqCfvXRj5B8=
X-Received: by 2002:a17:906:d550:b0:704:7ba6:9854 with SMTP id
 cr16-20020a170906d55000b007047ba69854mr9974662ejc.579.1655482324888; Fri, 17
 Jun 2022 09:12:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220617122855.739190-1-aidanmacdonald.0x0@gmail.com> <20220617122855.739190-3-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220617122855.739190-3-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Jun 2022 18:11:25 +0200
Message-ID: <CAHp75Vezjbd0rFbysgbw+Spq7WrML5eMu7FExJvpu1T_08Zxvg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] pinctrl: ingenic: Convert to immutable irq chip
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Jun 17, 2022 at 2:28 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Update the driver to use an immutable IRQ chip to fix this warning:
>
>     "not an immutable chip, please consider fixing it!"
>
> Preserve per-chip labels by adding an irq_print_chip callback.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
One nit-pick below, though.

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/pinctrl/pinctrl-ingenic.c | 41 ++++++++++++++++++++-----------
>  1 file changed, 27 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-ingenic.c b/drivers/pinctrl/pinctrl-ingenic.c
> index 69e0d88665d3..787a8daa400e 100644
> --- a/drivers/pinctrl/pinctrl-ingenic.c
> +++ b/drivers/pinctrl/pinctrl-ingenic.c
> @@ -22,6 +22,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> +#include <linux/seq_file.h>

Ordered?

>  #include "core.h"
>  #include "pinconf.h"
> @@ -135,7 +136,6 @@ struct ingenic_pinctrl {
>  struct ingenic_gpio_chip {
>         struct ingenic_pinctrl *jzpc;
>         struct gpio_chip gc;
> -       struct irq_chip irq_chip;
>         unsigned int irq, reg_base;
>  };
>
> @@ -3419,6 +3419,8 @@ static void ingenic_gpio_irq_enable(struct irq_data *irqd)
>         struct ingenic_gpio_chip *jzgc = gpiochip_get_data(gc);
>         irq_hw_number_t irq = irqd_to_hwirq(irqd);
>
> +       gpiochip_enable_irq(gc, irq);
> +
>         if (is_soc_or_above(jzgc->jzpc, ID_JZ4770))
>                 ingenic_gpio_set_bit(jzgc, JZ4770_GPIO_INT, irq, true);
>         else if (is_soc_or_above(jzgc->jzpc, ID_JZ4740))
> @@ -3443,6 +3445,8 @@ static void ingenic_gpio_irq_disable(struct irq_data *irqd)
>                 ingenic_gpio_set_bit(jzgc, JZ4740_GPIO_SELECT, irq, false);
>         else
>                 ingenic_gpio_set_bit(jzgc, JZ4730_GPIO_GPIER, irq, false);
> +
> +       gpiochip_disable_irq(gc, irq);
>  }
>
>  static void ingenic_gpio_irq_ack(struct irq_data *irqd)
> @@ -3687,6 +3691,27 @@ static void ingenic_gpio_irq_release(struct irq_data *data)
>         return gpiochip_relres_irq(gpio_chip, irq);
>  }
>
> +static void ingenic_gpio_irq_print_chip(struct irq_data *data, struct seq_file *p)
> +{
> +       struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
> +
> +       seq_printf(p, "%s", gpio_chip->label);
> +}
> +
> +static const struct irq_chip ingenic_gpio_irqchip = {
> +       .irq_enable             = ingenic_gpio_irq_enable,
> +       .irq_disable            = ingenic_gpio_irq_disable,
> +       .irq_unmask             = ingenic_gpio_irq_unmask,
> +       .irq_mask               = ingenic_gpio_irq_mask,
> +       .irq_ack                = ingenic_gpio_irq_ack,
> +       .irq_set_type           = ingenic_gpio_irq_set_type,
> +       .irq_set_wake           = ingenic_gpio_irq_set_wake,
> +       .irq_request_resources  = ingenic_gpio_irq_request,
> +       .irq_release_resources  = ingenic_gpio_irq_release,
> +       .irq_print_chip         = ingenic_gpio_irq_print_chip,
> +       .flags                  = IRQCHIP_MASK_ON_SUSPEND | IRQCHIP_IMMUTABLE,
> +};
> +
>  static int ingenic_pinmux_set_pin_fn(struct ingenic_pinctrl *jzpc,
>                 int pin, int func)
>  {
> @@ -4175,20 +4200,8 @@ static int __init ingenic_gpio_probe(struct ingenic_pinctrl *jzpc,
>         if (!jzgc->irq)
>                 return -EINVAL;
>
> -       jzgc->irq_chip.name = jzgc->gc.label;
> -       jzgc->irq_chip.irq_enable = ingenic_gpio_irq_enable;
> -       jzgc->irq_chip.irq_disable = ingenic_gpio_irq_disable;
> -       jzgc->irq_chip.irq_unmask = ingenic_gpio_irq_unmask;
> -       jzgc->irq_chip.irq_mask = ingenic_gpio_irq_mask;
> -       jzgc->irq_chip.irq_ack = ingenic_gpio_irq_ack;
> -       jzgc->irq_chip.irq_set_type = ingenic_gpio_irq_set_type;
> -       jzgc->irq_chip.irq_set_wake = ingenic_gpio_irq_set_wake;
> -       jzgc->irq_chip.irq_request_resources = ingenic_gpio_irq_request;
> -       jzgc->irq_chip.irq_release_resources = ingenic_gpio_irq_release;
> -       jzgc->irq_chip.flags = IRQCHIP_MASK_ON_SUSPEND;
> -
>         girq = &jzgc->gc.irq;
> -       girq->chip = &jzgc->irq_chip;
> +       gpio_irq_chip_set_chip(girq, &ingenic_gpio_irqchip);
>         girq->parent_handler = ingenic_gpio_irq_handler;
>         girq->num_parents = 1;
>         girq->parents = devm_kcalloc(dev, 1, sizeof(*girq->parents),
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
