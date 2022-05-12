Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5FA525476
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357478AbiELSJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357388AbiELSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:09:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86EC2689C6;
        Thu, 12 May 2022 11:09:11 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7ca2ce255so65827237b3.7;
        Thu, 12 May 2022 11:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=utw+wRrLLHkWNiU0y2u6oIEPePEoYxLkOdswowmRTMM=;
        b=l8/Frn8UN0Vf8Hecf6ajk1Nd5xbOFiBXDirjvj9dZmmPNdK/EGG3eebyd7U35CGbmP
         n4DJKgL47FWFXB4UfpDDV7CPR+y7tBOuhyz9ALFABmqS/6Dbgd6KDbqMYilfMn4PtwOj
         ZykWXbnLrhXCAccePg8FmCSNDWmo6UoDvb9aKx6PADLbmZvNmX8//j6Mu+Sb/RuKI1Il
         jKHGZuq2NaaDY1WcFhGogJhcItK34YK0js+Wg68SRoP35egR9x2rUJIzUXrQONzWjpLt
         Bo9vqZHFEfH4/P8ayqoAWekmmzghifIENr9P9x2JpZkGal8S9LPx+HLaC6Mv7QvPmuJF
         M3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=utw+wRrLLHkWNiU0y2u6oIEPePEoYxLkOdswowmRTMM=;
        b=vfpzN0ljiglKANxi2iWYqfgaiRmGsXLqS2YHPnWDkVbfe+UuGX3CffeL+x/sBeuUpo
         loJe+OnssMscCvbVCP/3OOP+RoylBuSvWcpmn54JUS2xifHtHwiN7m+TWG/fIMsJ6NYZ
         SlndgVmkb1IjROn5IwfGPInQ/bC7ytBNPY2W9+6kEMTG0rqtlVenKisVSnIP2gDdtSku
         VUMl7H2sMU2ntXiJaQ4pu4gzZboEKY7w+/SypDTU7tDMMXRcPWFLAdj6nIS2tswvvn4A
         8dL6Zqq45k3L4z0wRQcy+wfLgncXRNgVlgGxlK3+XOPlyVDHFdRNzn3v1J+U8Iyfy7+W
         P+Xw==
X-Gm-Message-State: AOAM5302xgzRGsZ9M8E7ktAl+CC+FzeqHifRnxBEUV6ZRgdDmTU5ctSc
        Ru3cz0IcqOKpcfn2ekNvLPfSbcO9+UGUAH2w+Tn507/kpeTx3g==
X-Google-Smtp-Source: ABdhPJzPf8p2lHx1BG4/2h0PNbTz0EjRohFJoX6J3fsplEwYfBDAjoUxZ9PDBtZXO4MRHvFZ0TAk/+O1o17AufNtdcY=
X-Received: by 2002:a0d:d491:0:b0:2ef:5485:fca with SMTP id
 w139-20020a0dd491000000b002ef54850fcamr1473203ywd.16.1652378950724; Thu, 12
 May 2022 11:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220511183210.5248-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220511183210.5248-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <87zgjnmcxt.wl-maz@kernel.org>
In-Reply-To: <87zgjnmcxt.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 12 May 2022 19:08:44 +0100
Message-ID: <CA+V-a8v_M40zuduO9+-w98AYhRA0-Fs9vaHrwu2aYSL=xk0qZg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

Hi Marc,

Thank you for the review.

On Thu, May 12, 2022 at 8:23 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 11 May 2022 19:32:07 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports
> > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > to be used as IRQ lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/irqchip/Kconfig             |   8 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c | 444 ++++++++++++++++++++++++++++
> >  3 files changed, 453 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> > index 15edb9a6fcae..f3d071422f3b 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
> >         Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
> >         to 8 external interrupts with configurable sense select.
> >
> > +config RENESAS_RZG2L_IRQC
> > +     bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     help
> > +       Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt Controller
> > +       for external devices.
> > +
> >  config SL28CPLD_INTC
> >       bool "Kontron sl28cpld IRQ controller"
> >       depends on MFD_SL28CPLD=y || COMPILE_TEST
> > diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> > index 160a1d8ceaa9..eaa56eec2b23 100644
> > --- a/drivers/irqchip/Makefile
> > +++ b/drivers/irqchip/Makefile
> > @@ -51,6 +51,7 @@ obj-$(CONFIG_RDA_INTC)                      += irq-rda-intc.o
> >  obj-$(CONFIG_RENESAS_INTC_IRQPIN)    += irq-renesas-intc-irqpin.o
> >  obj-$(CONFIG_RENESAS_IRQC)           += irq-renesas-irqc.o
> >  obj-$(CONFIG_RENESAS_RZA1_IRQC)              += irq-renesas-rza1.o
> > +obj-$(CONFIG_RENESAS_RZG2L_IRQC)     += irq-renesas-rzg2l.o
> >  obj-$(CONFIG_VERSATILE_FPGA_IRQ)     += irq-versatile-fpga.o
> >  obj-$(CONFIG_ARCH_NSPIRE)            += irq-zevio.o
> >  obj-$(CONFIG_ARCH_VT8500)            += irq-vt8500.o
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..61435d8dbe1a
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,444 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Renesas RZ/G2L IRQC Driver
> > + *
> > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > + *
> > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > + */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +#include <linux/irqchip.h>
> > +#include <linux/irqdomain.h>
> > +#include <linux/of_address.h>
> > +#include <linux/reset.h>
> > +#include <linux/spinlock.h>
> > +
> > +#define IRQC_IRQ_START                       1
> > +#define IRQC_IRQ_COUNT                       8
> > +#define IRQC_TINT_START                      (IRQC_IRQ_START + IRQC_IRQ_COUNT)
> > +#define IRQC_TINT_COUNT                      32
> > +#define IRQC_NUM_IRQ                 (IRQC_TINT_START + IRQC_TINT_COUNT)
> > +
> > +#define ISCR                         0x10
> > +#define IITSR                                0x14
> > +#define TSCR                         0x20
> > +#define TITSR0                               0x24
> > +#define TITSR1                               0x28
> > +#define TITSR0_MAX_INT                       16
> > +#define TITSEL_WIDTH                 0x2
> > +#define TSSR(n)                              (0x30 + ((n) * 4))
> > +#define TIEN                         BIT(7)
> > +#define TSSEL_SHIFT(n)                       (8 * (n))
> > +#define TSSEL_MASK                   GENMASK(7, 0)
> > +#define IRQ_MASK                     0x3
> > +
> > +#define TSSR_OFFSET(n)                       ((n) % 4)
> > +#define TSSR_INDEX(n)                        ((n) / 4)
> > +
> > +#define TITSR_TITSEL_EDGE_RISING     0
> > +#define TITSR_TITSEL_EDGE_FALLING    1
> > +#define TITSR_TITSEL_LEVEL_HIGH              2
> > +#define TITSR_TITSEL_LEVEL_LOW               3
> > +
> > +#define IITSR_IITSEL(n, sense)               ((sense) << ((n) * 2))
> > +#define IITSR_IITSEL_LEVEL_LOW               0
> > +#define IITSR_IITSEL_EDGE_FALLING    1
> > +#define IITSR_IITSEL_EDGE_RISING     2
> > +#define IITSR_IITSEL_EDGE_BOTH               3
> > +#define IITSR_IITSEL_MASK(n)         IITSR_IITSEL((n), 3)
> > +
> > +#define TINT_EXTRACT_HWIRQ(x)                ((x) & ~GENMASK(31, 16))
>
> This is really backward. You want to keep the lower bits, so just do
> that instead of masking out the top bits. This will also work if (x)
> suddenly becomes a 64bit quantity. Something like:
>
> #define TINT_EXTRACT_HWIRQ(x)           FIELD_GET(GENMASK(15, 0), (x))
>
>
> > +#define TINT_EXTRACT_GPIOINT(x)              ((x) >> 16)
>
> Same thing. Please write it as:
>
> #define TINT_EXTRACT_GPIOINT(x)         FIELD_GET(GENMASK(31, 16), (x))
>
Thanks for the pointer I hadn't come across the FIELD_GET macro.

> > +
> > +struct rzg2l_irqc_priv {
> > +     void __iomem *base;
> > +     struct of_phandle_args map[IRQC_NUM_IRQ];
> > +     raw_spinlock_t lock;
> > +};
> > +
> > +struct rzg2l_irqc_chip_data {
> > +     int tint;
> > +};
> > +
> > +static struct rzg2l_irqc_priv *irq_data_to_priv(struct irq_data *data)
> > +{
> > +     return data->domain->host_data;
> > +}
> > +
> > +static void rzg2l_irq_eoi(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + ISCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + ISCR);
> > +}
> > +
> > +static void rzg2l_tint_eoi(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + TSCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + TSCR);
> > +}
> > +
> > +static void rzg2l_irqc_eoi(struct irq_data *d)
> > +{
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
> > +             rzg2l_irq_eoi(d);
> > +     else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT)
> > +             rzg2l_tint_eoi(d);
> > +     raw_spin_unlock(&priv->lock);
> > +     irq_chip_eoi_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_disable(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +             u32 offset = hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > +             u8 tssr_index = TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg &= ~(TSSEL_MASK << tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_disable_parent(d);
> > +}
> > +
> > +static void rzg2l_irqc_irq_enable(struct irq_data *d)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +
> > +     if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT) {
> > +             struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +             struct rzg2l_irqc_chip_data *chip_data = d->chip_data;
> > +             u32 offset = hw_irq - IRQC_TINT_START;
> > +             u32 tssr_offset = TSSR_OFFSET(offset);
> > +             u8 tssr_index = TSSR_INDEX(offset);
> > +             u32 reg;
> > +
> > +             raw_spin_lock(&priv->lock);
> > +             reg = readl_relaxed(priv->base + TSSR(tssr_index));
> > +             reg |= (TIEN | chip_data->tint) << TSSEL_SHIFT(tssr_offset);
> > +             writel_relaxed(reg, priv->base + TSSR(tssr_index));
> > +             raw_spin_unlock(&priv->lock);
> > +     }
> > +     irq_chip_enable_parent(d);
> > +}
> > +
> > +static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u16 sense, tmp;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_LEVEL_LOW:
> > +             sense = IITSR_IITSEL_LEVEL_LOW;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense = IITSR_IITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense = IITSR_IITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_BOTH:
> > +             sense = IITSR_IITSEL_EDGE_BOTH;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     tmp = readl_relaxed(priv->base + IITSR);
> > +     tmp &= ~IITSR_IITSEL_MASK(hw_irq);
> > +     tmp |= IITSR_IITSEL(hw_irq, sense);
> > +     writel_relaxed(tmp, priv->base + IITSR);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type)
> > +{
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     unsigned int hwirq = irqd_to_hwirq(d);
> > +     u32 titseln = hwirq - IRQC_TINT_START;
> > +     u32 offset;
> > +     u8 sense;
> > +     u32 reg;
> > +
> > +     switch (type & IRQ_TYPE_SENSE_MASK) {
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             sense = TITSR_TITSEL_EDGE_RISING;
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_FALLING:
> > +             sense = TITSR_TITSEL_EDGE_FALLING;
> > +             break;
> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     offset = TITSR0;
> > +     if (titseln >= TITSR0_MAX_INT) {
> > +             titseln -= TITSR0_MAX_INT;
> > +             offset = TITSR1;
> > +     }
> > +
> > +     raw_spin_lock(&priv->lock);
> > +     reg = readl_relaxed(priv->base + offset);
> > +     reg &= ~(IRQ_MASK << (titseln * TITSEL_WIDTH));
> > +     reg |= sense << (titseln * TITSEL_WIDTH);
> > +     writel_relaxed(reg, priv->base + offset);
> > +     raw_spin_unlock(&priv->lock);
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     unsigned int hw_irq = irqd_to_hwirq(d);
> > +     int ret = -EINVAL;
> > +
> > +     if (hw_irq >= IRQC_IRQ_START && hw_irq <= IRQC_IRQ_COUNT)
> > +             ret = rzg2l_irq_set_type(d, type);
> > +     else if (hw_irq >= IRQC_TINT_START && hw_irq <= IRQC_TINT_COUNT)
> > +             ret = rzg2l_tint_set_edge(d, type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
> > +}
> > +
> > +static struct irq_chip irqc_chip = {
>
> You should now be able to make this struct const.
>
Agreed.

> > +     .name                   = "rzg2l-irqc",
> > +     .irq_eoi                = rzg2l_irqc_eoi,
> > +     .irq_mask               = irq_chip_mask_parent,
> > +     .irq_unmask             = irq_chip_unmask_parent,
> > +     .irq_disable            = rzg2l_irqc_irq_disable,
> > +     .irq_enable             = rzg2l_irqc_irq_enable,
> > +     .irq_get_irqchip_state  = irq_chip_get_parent_state,
> > +     .irq_set_irqchip_state  = irq_chip_set_parent_state,
> > +     .irq_retrigger          = irq_chip_retrigger_hierarchy,
> > +     .irq_set_type           = rzg2l_irqc_set_type,
> > +     .flags                  = IRQCHIP_MASK_ON_SUSPEND |
> > +                               IRQCHIP_SET_TYPE_MASKED |
> > +                               IRQCHIP_SKIP_SET_WAKE,
> > +};
> > +
> > +static int rzg2l_irqc_alloc(struct irq_domain *domain, unsigned int virq,
> > +                         unsigned int nr_irqs, void *arg)
> > +{
> > +     struct rzg2l_irqc_priv *priv = domain->host_data;
> > +     struct rzg2l_irqc_chip_data *chip_data = NULL;
> > +     struct irq_fwspec spec;
> > +     irq_hw_number_t hwirq;
> > +     int tint = -EINVAL;
> > +     unsigned int type;
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     ret = irq_domain_translate_twocell(domain, arg, &hwirq, &type);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * For TINIT interrupts ie where pinctrl driver is child of irqc domain
> > +      * the hwirq and TINT are encoded in fwspec->param[0].
> > +      * hwirq for TINIT range from 9-40, hwirq is embedded 0-15 bits and TINT
> > +      * from 16-31 bits. TINIT from the pinctrl driver needs to be programmed
> > +      * in IRQC registers to enable a given gpio pin as interrupt.
> > +      */
> > +     if (hwirq > IRQC_IRQ_COUNT) {
> > +             tint = TINT_EXTRACT_GPIOINT(hwirq);
> > +             hwirq = TINT_EXTRACT_HWIRQ(hwirq);
> > +
> > +             if (hwirq < IRQC_TINT_START)
> > +                     return -EINVAL;
> > +     }
> > +
> > +     if (hwirq > (IRQC_NUM_IRQ - 1))
> > +             return -EINVAL;
> > +
> > +     chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > +     if (!chip_data)
> > +             return -ENOMEM;
> > +     chip_data->tint = tint;
>
> An allocation for something that would readily fit in the pointer?
> Just the metadata costs you more than the data you are storing... I'd
> rather you cast the data back and forth, which simplifies everything.
> And you can make it an unsigned long, which is guaranteed to have the
> same size as a pointer.
>
Ok, I will make it as an unsigned long pointer.

> > +
> > +     ret = irq_domain_set_hwirq_and_chip(domain, virq, hwirq, &irqc_chip,
> > +                                         chip_data);
> > +     if (ret) {
> > +             kfree(chip_data);
> > +             return ret;
> > +     }
> > +
> > +     spec.fwnode = domain->parent->fwnode;
> > +     spec.param_count = priv->map[hwirq].args_count;
> > +     for (i = 0; i < spec.param_count; i++)
> > +             spec.param[i] = priv->map[hwirq].args[i];
> > +
> > +     ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, &spec);
> > +     if (ret)
> > +             kfree(chip_data);
> > +
> > +     return ret;
> > +}
> > +
> > +static void rzg2l_irqc_domain_free(struct irq_domain *domain, unsigned int virq,
> > +                                unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d;
> > +
> > +     d = irq_domain_get_irq_data(domain, virq);
> > +     if (d) {
> > +             struct rzg2l_irqc_chip_data *chip_data = d->chip_data;
> > +
> > +             kfree(chip_data);
>
> Why the intermediate variable?
>
will drop that.

> > +     }
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs);
>
> Is there any case where you would need this when d is NULL?
>
d == NULL may not happen unless something is really screwed up. But
will move this inside if block.

> > +}
> > +
> > +static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
> > +     .alloc = rzg2l_irqc_alloc,
> > +     .free = rzg2l_irqc_domain_free,
> > +     .translate = irq_domain_translate_twocell,
> > +};
> > +
> > +static int rzg2l_irqc_parse_map(struct rzg2l_irqc_priv *priv,
> > +                             struct device_node *np)
> > +{
> > +     unsigned int i;
> > +     int ret;
> > +
> > +     for (i = 0; i < IRQC_NUM_IRQ; i++) {
> > +             ret = of_irq_parse_one(np, i, &priv->map[i]);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_node *parent)
> > +{
> > +     struct irq_domain *irq_domain, *parent_domain;
> > +     struct reset_control *resetn;
> > +     struct rzg2l_irqc_priv *priv;
> > +     struct clk *clk;
> > +     struct clk *pclk;
> > +     int ret;
> > +
> > +     priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
>
> Since you are implementing this as a platform driver, consider
> converting this to the devm_* helpers (you can obtain the device
> structure via of_find_device_by_node()).
>
Thanks for of_find_device_by_node() pointer, I'll switch to devm* helpers.

Cheers,
Prabhakar
