Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4EB51F5D0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbiEIHzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiEIHwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:52:36 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258A5189E7B;
        Mon,  9 May 2022 00:48:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2f7d19cac0bso134523867b3.13;
        Mon, 09 May 2022 00:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/3XvU+ukHMXkz/avq3/dKGMD2ekAov1scQdaFR9JR4=;
        b=PhtkwjT3dTrPdWZJIkwxBZ5TjuM73u5AJHlxUFdFrzHpoWtoDoP1tidpPBRYq5mrPe
         I5r8aTPwdHf41aTvsHqdRBxhuUwAwX6lfj6TTXmU0LspBQjwmH0vQu6TQtomwwZ1CVsE
         EYBOyD8BL+8aHXCbRvWXtVga6P965JtCKBk1LuROY8GRlpHh20xrzzqoUHphQ5+Fpew0
         NrhIYq7KciA+UKCqwgll9osDugigX30/WDt/Jwp++8r0HbT4YzdFZu1Yt0rpbHU/kg15
         oXiWvEYi4mZR+s8mYPKsuEELbyCCqYk1ykNvaWs8eUpPuUaJtM8SEuJVYzChTh2zZR/Z
         of6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/3XvU+ukHMXkz/avq3/dKGMD2ekAov1scQdaFR9JR4=;
        b=0udfmmb9KelCrTW9ZrPr7sk0T3QoXD27ISRc6BTrr4Z9pigCAVMj0Xu/nmbRdyo7u1
         z3xIsv1/ZaVRCs0AaPf3UkU5hu554I/zwP1aueiCeI2jTDujTONRphA+k68Ir6Y4LmWT
         gtvIpmbugP0dxNXOY+OUvuazJFY3bWJ52r1CIjyAetDZ6NF0A3RGuHmBmqDNblJw6+Xz
         flsvuiCElmWcR2QQkAvMOJxuEeMeAUeqdYDUtsNzig90tzxKQ+EjXEn2duA/xg/MSPLL
         CvREhbIIC6cXwXzyloTzywrfJGgMjPsFqBU3oyVaTL6QJ9pm9Lv24OgnyztfzxXQcT29
         O1FQ==
X-Gm-Message-State: AOAM530QbXvVieTbJpIadYd+aNb8K5UAqCroGUoJ/YHag9ti98GTjKuP
        VtzjPZMEy2lwV6COUmGXiim/UwiXEFTxqBpRaR9lRJh/hmQ=
X-Google-Smtp-Source: ABdhPJzd+q5uXimjTDcjm6dyCbZJP/7d510A4tXtZBwx5y3guUaNs+AD22WpsNztBMhAjRDHywAc6hAVogBp24h61fY=
X-Received: by 2002:a81:b651:0:b0:2ef:6d8c:a6f4 with SMTP id
 h17-20020a81b651000000b002ef6d8ca6f4mr13077060ywk.222.1652082521151; Mon, 09
 May 2022 00:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB59228AE4AF4EE53C382E8BA986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB59228AE4AF4EE53C382E8BA986C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 May 2022 08:48:15 +0100
Message-ID: <CA+V-a8syBvN7czRA7tq0TJSmUcBzmgjLrFmizHD6Ycp5kLXJWw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
 handle GPIO interrupt
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
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

Hi Biju,

Thank you for the review.

On Mon, May 9, 2022 at 7:49 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [PATCH v2 5/5] pinctrl: renesas: pinctrl-rzg2l: Add IRQ domain to
> > handle GPIO interrupt
> >
> > Add IRQ domian to RZ/G2L pinctrl driver to handle GPIO interrupt.
> >
> > GPIO0-GPIO122 pins can be used as IRQ lines but only 32 pins can be used as
> > IRQ lines at given time. Selection of pins as IRQ lines is handled by IA55
> > (which is the IRQC block) which sits in between the GPIO and GIC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c | 205 ++++++++++++++++++++++++
> >  1 file changed, 205 insertions(+)
> >
> > diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > index a48cac55152c..275dfec74329 100644
> > --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
> > @@ -9,8 +9,10 @@
> >  #include <linux/clk.h>
> >  #include <linux/gpio/driver.h>
> >  #include <linux/io.h>
> > +#include <linux/interrupt.h>
> >  #include <linux/module.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_irq.h>
> >  #include <linux/pinctrl/pinconf-generic.h>  #include
> > <linux/pinctrl/pinconf.h>  #include <linux/pinctrl/pinctrl.h> @@ -89,6
> > +91,7 @@
> >  #define PIN(n)                       (0x0800 + 0x10 + (n))
> >  #define IOLH(n)                      (0x1000 + (n) * 8)
> >  #define IEN(n)                       (0x1800 + (n) * 8)
> > +#define ISEL(n)                      (0x2c80 + (n) * 8)
> >  #define PWPR                 (0x3014)
> >  #define SD_CH(n)             (0x3000 + (n) * 4)
> >  #define QSPI                 (0x3008)
> > @@ -112,6 +115,10 @@
> >  #define RZG2L_PIN_ID_TO_PORT_OFFSET(id)      (RZG2L_PIN_ID_TO_PORT(id) +
> > 0x10)
> >  #define RZG2L_PIN_ID_TO_PIN(id)              ((id) % RZG2L_PINS_PER_PORT)
> >
> > +#define RZG2L_TINT_MAX_INTERRUPT     32
> > +#define RZG2L_TINT_IRQ_START_INDEX   9
> > +#define RZG2L_PACK_HWIRQ(t, i)               (((t) << 16) | (i))
> > +
> >  struct rzg2l_dedicated_configs {
> >       const char *name;
> >       u32 config;
> > @@ -137,6 +144,9 @@ struct rzg2l_pinctrl {
> >
> >       struct gpio_chip                gpio_chip;
> >       struct pinctrl_gpio_range       gpio_range;
> > +     DECLARE_BITMAP(tint_slot, RZG2L_TINT_MAX_INTERRUPT);
> > +     spinlock_t                      bitmap_lock;
> > +     unsigned int                    hwirq[RZG2L_TINT_MAX_INTERRUPT];
> >
> >       spinlock_t                      lock;
> >  };
> > @@ -883,6 +893,8 @@ static int rzg2l_gpio_get(struct gpio_chip *chip,
> > unsigned int offset)
> >
> >  static void rzg2l_gpio_free(struct gpio_chip *chip, unsigned int offset)
> > {
> > +     unsigned int virq;
> > +
> >       pinctrl_gpio_free(chip->base + offset);
> >
> >       /*
> > @@ -890,6 +902,10 @@ static void rzg2l_gpio_free(struct gpio_chip *chip,
> > unsigned int offset)
> >        * drive the GPIO pin as an output.
> >        */
> >       rzg2l_gpio_direction_input(chip, offset);
> > +
> > +     virq = irq_find_mapping(chip->irq.domain, offset);
> > +     if (virq)
> > +             irq_dispose_mapping(virq);
> >  }
> >
> >  static const char * const rzg2l_gpio_names[] = { @@ -1104,14 +1120,193 @@
> > static struct {
> >       }
> >  };
> >
> > +static int rzg2l_gpio_get_gpioint(unsigned int virq) {
> > +     unsigned int gpioint = 0;
> > +     unsigned int i = 0;
> > +     u32 port, bit;
> > +
> > +     port = virq / 8;
> > +     bit = virq % 8;
> > +
> > +     if (port >= ARRAY_SIZE(rzg2l_gpio_configs))
> > +             return -EINVAL;
> > +
> > +     for (i = 0; i < port; i++)
> > +             gpioint += RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]);
> > +
> > +     if (bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[i]))
> > +             return -EINVAL;
>
> May be combine this statement to above with
>
> || (bit >= RZG2L_GPIO_PORT_GET_PINCNT(rzg2l_gpio_configs[port]))
>                 return -EINVAL;
>
The reason I have kept it outside the loop is that I'll have to check
it only once at the end of the loop instead of repeating the check
every time in the loop.

Cheers,
Prabhakar

> Cheers,
> BIju
>
> > +
> > +     gpioint += bit;
> > +
> > +     return gpioint;
> > +}
> > +
> > +static void rzg2l_gpio_irq_domain_free(struct irq_domain *domain, unsigned
> > int virq,
> > +                                    unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d;
> > +
> > +     d = irq_domain_get_irq_data(domain, virq);
> > +     if (d) {
> > +             struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +             struct rzg2l_pinctrl *pctrl = container_of(gc, struct
> > rzg2l_pinctrl, gpio_chip);
> > +             irq_hw_number_t hwirq = irqd_to_hwirq(d);
> > +             unsigned long flags;
> > +             unsigned int i;
> > +
> > +             for (i = 0; i < RZG2L_TINT_MAX_INTERRUPT; i++) {
> > +                     if (pctrl->hwirq[i] == hwirq) {
> > +                             spin_lock_irqsave(&pctrl->bitmap_lock, flags);
> > +                             bitmap_release_region(pctrl->tint_slot, i,
> > get_order(1));
> > +                             spin_unlock_irqrestore(&pctrl->bitmap_lock,
> > flags);
> > +                             pctrl->hwirq[i] = 0;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs); }
> > +
> > +static void rzg2l_gpio_irq_disable(struct irq_data *d) {
> > +     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +     struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl,
> > gpio_chip);
> > +     unsigned int hwirq = irqd_to_hwirq(d);
> > +     unsigned long flags;
> > +     void __iomem *addr;
> > +     u32 port;
> > +     u8 bit;
> > +
> > +     port = RZG2L_PIN_ID_TO_PORT(hwirq);
> > +     bit = RZG2L_PIN_ID_TO_PIN(hwirq);
> > +
> > +     addr = pctrl->base + ISEL(port);
> > +     if (bit >= 4) {
> > +             bit -= 4;
> > +             addr += 4;
> > +     }
> > +
> > +     spin_lock_irqsave(&pctrl->lock, flags);
> > +     writel(readl(addr) & ~BIT(bit * 8), addr);
> > +     spin_unlock_irqrestore(&pctrl->lock, flags);
> > +
> > +     irq_chip_disable_parent(d);
> > +}
> > +
> > +static void rzg2l_gpio_irq_enable(struct irq_data *d) {
> > +     struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> > +     struct rzg2l_pinctrl *pctrl = container_of(gc, struct rzg2l_pinctrl,
> > gpio_chip);
> > +     unsigned int hwirq = irqd_to_hwirq(d);
> > +     unsigned long flags;
> > +     void __iomem *addr;
> > +     u32 port;
> > +     u8 bit;
> > +
> > +     port = RZG2L_PIN_ID_TO_PORT(hwirq);
> > +     bit = RZG2L_PIN_ID_TO_PIN(hwirq);
> > +
> > +     addr = pctrl->base + ISEL(port);
> > +     if (bit >= 4) {
> > +             bit -= 4;
> > +             addr += 4;
> > +     }
> > +
> > +     spin_lock_irqsave(&pctrl->lock, flags);
> > +     writel(readl(addr) | BIT(bit * 8), addr);
> > +     spin_unlock_irqrestore(&pctrl->lock, flags);
> > +
> > +     irq_chip_enable_parent(d);
> > +}
> > +
> > +static int rzg2l_gpio_irq_set_type(struct irq_data *d, unsigned int
> > +type) {
> > +     return irq_chip_set_type_parent(d, type); }
> > +
> > +static void rzg2l_gpio_irqc_eoi(struct irq_data *d) {
> > +     irq_chip_eoi_parent(d);
> > +}
> > +
> > +static struct irq_chip rzg2l_gpio_irqchip = {
> > +     .name = "rzg2l-gpio",
> > +     .irq_disable = rzg2l_gpio_irq_disable,
> > +     .irq_enable = rzg2l_gpio_irq_enable,
> > +     .irq_mask = irq_chip_mask_parent,
> > +     .irq_unmask = irq_chip_unmask_parent,
> > +     .irq_set_type = rzg2l_gpio_irq_set_type,
> > +     .irq_eoi = rzg2l_gpio_irqc_eoi,
> > +};
> > +
> > +static int rzg2l_gpio_child_to_parent_hwirq(struct gpio_chip *gc,
> > +                                         unsigned int child,
> > +                                         unsigned int child_type,
> > +                                         unsigned int *parent,
> > +                                         unsigned int *parent_type)
> > +{
> > +     struct rzg2l_pinctrl *pctrl = gpiochip_get_data(gc);
> > +     unsigned long flags;
> > +     int gpioint, irq;
> > +
> > +     gpioint = rzg2l_gpio_get_gpioint(child);
> > +     if (gpioint < 0)
> > +             return gpioint;
> > +
> > +     spin_lock_irqsave(&pctrl->bitmap_lock, flags);
> > +     irq = bitmap_find_free_region(pctrl->tint_slot,
> > RZG2L_TINT_MAX_INTERRUPT, get_order(1));
> > +     spin_unlock_irqrestore(&pctrl->bitmap_lock, flags);
> > +     if (irq < 0)
> > +             return -ENOSPC;
> > +     pctrl->hwirq[irq] = child;
> > +     irq += RZG2L_TINT_IRQ_START_INDEX;
> > +
> > +     /* All these interrupts are level high in the CPU */
> > +     *parent_type = IRQ_TYPE_LEVEL_HIGH;
> > +     *parent = RZG2L_PACK_HWIRQ(gpioint, irq);
> > +     return 0;
> > +}
> > +
> > +static void *rzg2l_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > +                                            unsigned int parent_hwirq,
> > +                                            unsigned int parent_type)
> > +{
> > +     struct irq_fwspec *fwspec;
> > +
> > +     fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
> > +     if (!fwspec)
> > +             return NULL;
> > +
> > +     fwspec->fwnode = chip->irq.parent_domain->fwnode;
> > +     fwspec->param_count = 2;
> > +     fwspec->param[0] = parent_hwirq;
> > +     fwspec->param[1] = parent_type;
> > +
> > +     return fwspec;
> > +}
> > +
> >  static int rzg2l_gpio_register(struct rzg2l_pinctrl *pctrl)  {
> >       struct device_node *np = pctrl->dev->of_node;
> >       struct gpio_chip *chip = &pctrl->gpio_chip;
> >       const char *name = dev_name(pctrl->dev);
> > +     struct irq_domain *parent_domain;
> >       struct of_phandle_args of_args;
> > +     struct device_node *parent_np;
> > +     struct gpio_irq_chip *girq;
> >       int ret;
> >
> > +     parent_np = of_irq_find_parent(np);
> > +     if (!parent_np)
> > +             return -ENXIO;
> > +
> > +     parent_domain = irq_find_host(parent_np);
> > +     of_node_put(parent_np);
> > +     if (!parent_domain)
> > +             return -EPROBE_DEFER;
> > +
> >       ret = of_parse_phandle_with_fixed_args(np, "gpio-ranges", 3, 0,
> > &of_args);
> >       if (ret) {
> >               dev_err(pctrl->dev, "Unable to parse gpio-ranges\n"); @@ -
> > 1138,6 +1333,15 @@ static int rzg2l_gpio_register(struct rzg2l_pinctrl
> > *pctrl)
> >       chip->base = -1;
> >       chip->ngpio = of_args.args[2];
> >
> > +     girq = &chip->irq;
> > +     girq->chip = &rzg2l_gpio_irqchip;
> > +     girq->fwnode = of_node_to_fwnode(np);
> > +     girq->parent_domain = parent_domain;
> > +     girq->child_to_parent_hwirq = rzg2l_gpio_child_to_parent_hwirq;
> > +     girq->populate_parent_alloc_arg = rzg2l_gpio_populate_parent_fwspec;
> > +     girq->child_irq_domain_ops.free = rzg2l_gpio_irq_domain_free;
> > +     girq->ngirq = RZG2L_TINT_MAX_INTERRUPT;
> > +
> >       pctrl->gpio_range.id = 0;
> >       pctrl->gpio_range.pin_base = 0;
> >       pctrl->gpio_range.base = 0;
> > @@ -1253,6 +1457,7 @@ static int rzg2l_pinctrl_probe(struct platform_device
> > *pdev)
> >       }
> >
> >       spin_lock_init(&pctrl->lock);
> > +     spin_lock_init(&pctrl->bitmap_lock);
> >
> >       platform_set_drvdata(pdev, pctrl);
> >
> > --
> > 2.25.1
>
