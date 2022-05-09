Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9951F5BA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiEIHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiEIHj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:39:59 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEE819C1F;
        Mon,  9 May 2022 00:36:04 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id j2so23411746ybu.0;
        Mon, 09 May 2022 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PyeZsf61SixLfLZ0lwLVIHTV84c0cB3O2+IPXBELheI=;
        b=FQF73Q/7kY5xjfqOW7DE6HxTZ3o5uEfq0OdRWSKX2ZI+s2m14QmCB75o2Lc/PCHTEN
         AzmdbfdA6f0R3jBm61avXxPnFCPZA17W/hTKGlmOWPcAlZGAFRH6HBfNOtR5Ny5hK8P7
         YVk/KspSHlEdvBJZlwMnAj+ikSrxQwcDD8oxAhiHjtZskKUG2PB5ECPRrjtXZT0aTv0/
         vIQsbelR9mvOF2aXDDRVLhocuXP+WQaTMC46jke9UH1QrRvW0ORFCtpZjuz/jcQ+axb1
         TliyoQTa51Wp9S8nIpSCdyCOvx6ob1cqSc6UR0aZdZe0B7+2BajUMKPvH7cUZy3f1B/p
         Rbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PyeZsf61SixLfLZ0lwLVIHTV84c0cB3O2+IPXBELheI=;
        b=HlDvb/as/H/0ahtZPpeAVNNkWhayOsU3IdpIWx00ifgh1tVibcTxku3ZAcpHXDMer2
         NY7BeR/jBW4laiPvzsN2wbyweuro+55nxELtNVsergiIJz7jhYRs3Niiup4kRuwBIoEp
         zcmD9SNjR/Kp4xneLI1pABJawthsAmD5XqQNyRp0273XxVpZD9tp+a5ZxoJHY8HN/RuT
         QE71XfsfdevnFb2/Rf60lz55J7CXPLLX4t3be+JBeTUQE4Vyrtc9hizcxLO3XSKMh7T/
         DWWDh0rhHvrD3rzC9xyF6Yi5y5K54MSzQ7E/xHJhGMfOKFRA9LBRxdCvHD3kizFzzyWW
         SRkA==
X-Gm-Message-State: AOAM531Xs+81k+6xbmg1Is00CILRq1uXsP/X4hiSEQiOM0KsQa+5HJtX
        6wRufiH6Wm/7055EJ1xlXK0Jl53ULkL7HmCUpFCIPlItvGU=
X-Google-Smtp-Source: ABdhPJxJTmu42RUbxNorKEv8AUk7cLbCAQOu23kxrz8BA/h+Ec+o9dLa5V54RnloRTYP+4pD/jtOxtxLkXDAGipiJgQ=
X-Received: by 2002:a25:4153:0:b0:648:f7b4:7cb8 with SMTP id
 o80-20020a254153000000b00648f7b47cb8mr137808yba.431.1652081755334; Mon, 09
 May 2022 00:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220509050953.11005-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220509050953.11005-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922B58BB70B92813041745786C69@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 9 May 2022 08:35:29 +0100
Message-ID: <CA+V-a8uM=98O_WdaS1L=U3Eiqf_8Eteu9mDPats0a44W8VgpXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
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

Thank you for the patch.

On Mon, May 9, 2022 at 8:22 AM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
> Thanks for the patch.
>
> > Subject: [PATCH v2 2/5] irqchip: Add RZ/G2L IA55 Interrupt Controller
> > driver
> >
> > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> >
> > This supports external pins being used as interrupts. It supports one line
> > for NMI, 8 external pins and 32 GPIO pins (out of 123) to be used as IRQ
> > lines.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/irqchip/Kconfig             |   8 +
> >  drivers/irqchip/Makefile            |   1 +
> >  drivers/irqchip/irq-renesas-rzg2l.c | 445 ++++++++++++++++++++++++++++
> >  3 files changed, 454 insertions(+)
> >  create mode 100644 drivers/irqchip/irq-renesas-rzg2l.c
> >
> > diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig index
> > 15edb9a6fcae..f3d071422f3b 100644
> > --- a/drivers/irqchip/Kconfig
> > +++ b/drivers/irqchip/Kconfig
> > @@ -242,6 +242,14 @@ config RENESAS_RZA1_IRQC
> >         Enable support for the Renesas RZ/A1 Interrupt Controller, to use
> > up
> >         to 8 external interrupts with configurable sense select.
> >
> > +config RENESAS_RZG2L_IRQC
> > +     bool "Renesas RZ/G2L (and alike SoC) IRQC support" if COMPILE_TEST
> > +     select GENERIC_IRQ_CHIP
> > +     select IRQ_DOMAIN_HIERARCHY
> > +     help
> > +       Enable support for the Renesas RZ/G2L (and alike SoC) Interrupt
> > Controller
> > +       for external devices.
> > +
> >  config SL28CPLD_INTC
> >       bool "Kontron sl28cpld IRQ controller"
> >       depends on MFD_SL28CPLD=y || COMPILE_TEST diff --git
> > a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile index
> > 160a1d8ceaa9..eaa56eec2b23 100644
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
> > diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-
> > renesas-rzg2l.c
> > new file mode 100644
> > index 000000000000..bd6e82100caf
> > --- /dev/null
> > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > @@ -0,0 +1,445 @@
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
> > +#define TINT_EXTRACT_GPIOINT(x)              ((x) >> 16)
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
> > +static void rzg2l_irq_eoi(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + ISCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + ISCR); }
> > +
> > +static void rzg2l_tint_eoi(struct irq_data *d) {
> > +     unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_TINT_START;
> > +     struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
> > +     u32 bit = BIT(hw_irq);
> > +     u32 reg;
> > +
> > +     reg = readl_relaxed(priv->base + TSCR);
> > +     if (reg & bit)
> > +             writel_relaxed(reg & ~bit, priv->base + TSCR); }
> > +
> > +static void rzg2l_irqc_eoi(struct irq_data *d) {
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
> > +static void rzg2l_irqc_irq_disable(struct irq_data *d) {
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
> > +static void rzg2l_irqc_irq_enable(struct irq_data *d) {
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
> > +static int rzg2l_irq_set_type(struct irq_data *d, unsigned int type) {
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
> > +static int rzg2l_tint_set_edge(struct irq_data *d, unsigned int type) {
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
>
> > +     if (titseln < TITSR0_MAX_INT) {
> > +             offset = TITSR0;
> > +     } else {
> > +             titseln /= TITSEL_WIDTH;
> > +             offset  = TITSR1;
> > +     }
>
> as TITSR0 (0x24) and TITSR1(0x28) are contiguous address location
>
> May be like others, above declare it as
> u32 offset = TITSR0; ??
>
> and here
>  if ((titseln >= TITSR0_MAX_INT) {
>         titseln /= TITSEL_WIDTH;
>         offset  += 4;
>  }
>
The current implementation is suggested by the maintainer.

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
> > +static int rzg2l_irqc_set_type(struct irq_data *d, unsigned int type) {
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
> > +     return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH); }
> > +
> > +static struct irq_chip irqc_chip = {
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
> > +                         unsigned int nr_irqs, void *arg) {
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
> > +      * For TINIT interrupts ie where pinctrl driver is child of irqc
> > domain
> > +      * the hwirq and TINT are encoded in fwspec->param[0].
> > +      * hwirq for TINIT range from 9-40, hwirq is embedded 0-15 bits and
> > TINT
> > +      * from 16-31 bits. TINIT from the pinctrl driver needs to be
> > programmed
> > +      * in IRQC registers to enable a given gpio pin as interrupt.
> > +      */
> > +     if (hwirq > IRQC_IRQ_COUNT) {
> > +             tint = TINT_EXTRACT_GPIOINT(hwirq);
> > +             hwirq = TINT_EXTRACT_HWIRQ(hwirq);
> > +     }
> > +
> > +     if (hwirq > (IRQC_NUM_IRQ - 1))
> > +             return -EINVAL;
>
>
> > +
> > +     if (tint != -EINVAL && (hwirq < IRQC_TINT_START || hwirq >
> > (IRQC_NUM_IRQ - 1)))
> > +             return -EINVAL;
>
> hwirq > (IRQC_NUM_IRQ - 1) is redundant check, as it is checked above.
>
>
Sure will drop it.

Cheers,
Prabhakar

> Cheers,
> Biju
>
> > +
> > +     chip_data = kzalloc(sizeof(*chip_data), GFP_KERNEL);
> > +     if (!chip_data)
> > +             return -ENOMEM;
> > +     chip_data->tint = tint;
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
> > +static void rzg2l_irqc_domain_free(struct irq_domain *domain, unsigned int
> > virq,
> > +                                unsigned int nr_irqs)
> > +{
> > +     struct irq_data *d;
> > +
> > +     d = irq_domain_get_irq_data(domain, virq);
> > +     if (d) {
> > +             struct rzg2l_irqc_chip_data *chip_data = d->chip_data;
> > +
> > +             kfree(chip_data);
> > +     }
> > +     irq_domain_free_irqs_common(domain, virq, nr_irqs); }
> > +
> > +static const struct irq_domain_ops rzg2l_irqc_domain_ops = {
> > +     .alloc = rzg2l_irqc_alloc,
> > +     .free = rzg2l_irqc_domain_free,
> > +     .translate = irq_domain_translate_twocell, };
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
> > +static int rzg2l_irqc_init(struct device_node *node, struct device_node
> > +*parent) {
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
> > +
> > +     priv->base = of_iomap(node, 0);
> > +     if (!priv->base) {
> > +             ret = -ENXIO;
> > +             goto free_priv;
> > +     }
> > +
> > +     clk = of_clk_get_by_name(node, "clk");
> > +     if (IS_ERR(clk)) {
> > +             ret = IS_ERR(clk);
> > +             goto iounmap_base;
> > +     }
> > +
> > +     pclk = of_clk_get_by_name(node, "pclk");
> > +     if (IS_ERR(pclk)) {
> > +             ret = IS_ERR(pclk);
> > +             goto iounmap_base;
> > +     }
> > +
> > +     resetn = of_reset_control_get_exclusive_by_index(node, 0);
> > +     if (IS_ERR(resetn)) {
> > +             ret = IS_ERR(resetn);
> > +             goto iounmap_base;
> > +     }
> > +
> > +     parent_domain = irq_find_host(parent);
> > +     if (!parent_domain) {
> > +             pr_err("%pOF: cannot find parent domain\n", node);
> > +             ret = -ENODEV;
> > +             goto iounmap_base;
> > +     }
> > +
> > +     ret = rzg2l_irqc_parse_map(priv, node);
> > +     if (ret) {
> > +             pr_err("%pOF: cannot parse interrupts: %d\n", node, ret);
> > +             goto iounmap_base;
> > +     }
> > +
> > +     ret = reset_control_deassert(resetn);
> > +     if (ret) {
> > +             pr_err("%pOF: failed to deassert resetn pin, %d\n", node,
> > ret);
> > +             goto iounmap_base;
> > +     }
> > +
> > +     raw_spin_lock_init(&priv->lock);
> > +
> > +     ret = clk_prepare_enable(clk);
> > +     if (ret)
> > +             goto assert_reset;
> > +
> > +     ret = clk_prepare_enable(pclk);
> > +     if (ret)
> > +             goto disable_clk;
> > +
> > +     irq_domain = irq_domain_add_hierarchy(parent_domain, 0,
> > IRQC_NUM_IRQ,
> > +                                           node, &rzg2l_irqc_domain_ops,
> > +                                           priv);
> > +     if (!irq_domain) {
> > +             pr_err("%pOF: cannot initialize irq domain\n", node);
> > +             ret = -ENOMEM;
> > +             goto fail_irq_domain;
> > +     }
> > +
> > +     return 0;
> > +
> > +fail_irq_domain:
> > +     clk_disable_unprepare(pclk);
> > +disable_clk:
> > +     clk_disable_unprepare(clk);
> > +assert_reset:
> > +     reset_control_assert(resetn);
> > +iounmap_base:
> > +     iounmap(priv->base);
> > +free_priv:
> > +     kfree(priv);
> > +     return ret;
> > +}
> > +
> > +IRQCHIP_PLATFORM_DRIVER_BEGIN(rzg2l_irqc)
> > +IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
> > +IRQCHIP_PLATFORM_DRIVER_END(rzg2l_irqc)
> > +MODULE_AUTHOR("Lad Prabhakar
> > +<prabhakar.mahadev-lad.rj@bp.renesas.com>");
> > +MODULE_DESCRIPTION("Renesas RZ/G2L IRQC Driver");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.25.1
>
