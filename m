Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1551535EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 13:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350765AbiE0LGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 07:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbiE0LGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:06:09 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECEE13276D;
        Fri, 27 May 2022 04:06:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-30a2adffd24so1146427b3.7;
        Fri, 27 May 2022 04:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRa2P5R5JHyAbD0921v5jTq/ooDfcVGFwaV7OE0Et6o=;
        b=kJGGUDKLTlcgvdzeSf1+D3/jxr9Asp7eEdqVnybm5O84SY6IwYmKlOjsAjZ7ecrVva
         uzAwaXxoJrGr7WCKwmJznP4IpRi68uaZB7JY4qkjUBn6PQz8V7M3MN1/59a9CwWJI4vp
         BGojBTyC/1v4vfuvjyNAMMfRHb+zNLDVxKTaD3vXgUfj2aW5+Ry/6YW+eAuQQh+JvACH
         NCsxOXsfQDzr5oSRfOtnHw3Vp6hrHpRP0hNAVxG6GzpyE/RGp8emjDPFXbGUcoTRvgpH
         9TolshWpMSHkvnjcrK90CYS0cHHfJgXKSsdg/YuhGS0XtGq6l89G+sxadk9kuxexmfg7
         kTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRa2P5R5JHyAbD0921v5jTq/ooDfcVGFwaV7OE0Et6o=;
        b=YZ/xL5WepA0MSCADt1Q2rSYcS+rs3s7iP64shs8xU6cQz39ljzVVWAfwKqODB0fz3W
         MtfWtyZFzt04Nf2SeNveqgxriXOSdg4FYBx5WwxFiaDxNxbgxv46InYdZ6rBbrI+hJQA
         wqTHNhVYFFkrPyDAI8N8dE7l5kF61Y9QTdzE9m727yh86opW2G5pK58Q8dHLpoOP5fuS
         yauo5V8XTgAjBd6NPrKsA+h363uakEZwRcL91YZKt/yVQEOWhwG9re90/xjh4SST/XMm
         ckfQ+qtspApmhiqo6CudWwllWliAliuZf997xWgAHKPf6KZuSHfqAqwTlm6Bp17vInxg
         VZoQ==
X-Gm-Message-State: AOAM530zv4rewHkjXYsIBnRZIpfoJ3GobjMd31p/n230RbuIsVoe/2zo
        IsDp+Q453QfNwcS11oQJBDVWuOV+3uIX8UkCX3w=
X-Google-Smtp-Source: ABdhPJxUmotqC0TlXzdswm1/HGKqKMcvrFQ6HTKOQiniXSSy8vS9J3TvvqymhS0jNEyh4j721BFcwJ4bO0u8WRmY+6U=
X-Received: by 2002:a81:6c14:0:b0:306:14a:9f7c with SMTP id
 h20-20020a816c14000000b00306014a9f7cmr2089658ywc.16.1653649565012; Fri, 27
 May 2022 04:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 27 May 2022 12:05:38 +0100
Message-ID: <CA+V-a8vfzsB55YdFmtx3eim617b=WCYJu+Tm3SO9c1QCB3i0Lw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
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

Hi,

On Tue, May 24, 2022 at 6:22 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
>
> The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> edge until the previous completion message has been received and
> NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> interrupts if not acknowledged in time.
>
> So the workaround for edge-triggered interrupts to be handled correctly
> and without losing is that it needs to be acknowledged first and then
> handler must be run so that we don't miss on the next edge-triggered
> interrupt.
>
> This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> support to change interrupt flow based on the interrupt type. It also
> implements irq_ack and irq_set_type callbacks.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  drivers/irqchip/Kconfig           |  1 +
>  drivers/irqchip/irq-sifive-plic.c | 71 ++++++++++++++++++++++++++++++-
>  2 files changed, 70 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index f3d071422f3b..aea0e4e7e547 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -537,6 +537,7 @@ config SIFIVE_PLIC
>         bool "SiFive Platform-Level Interrupt Controller"
>         depends on RISCV
>         select IRQ_DOMAIN_HIERARCHY
> +       select IRQ_FASTEOI_HIERARCHY_HANDLERS
>         help
>            This enables support for the PLIC chip found in SiFive (and
>            potentially other) RISC-V systems.  The PLIC controls devices
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bb87e4c3b88e..abffce48e69c 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -60,10 +60,13 @@
>  #define        PLIC_DISABLE_THRESHOLD          0x7
>  #define        PLIC_ENABLE_THRESHOLD           0
>
> +#define RENESAS_R9A07G043_PLIC         1
> +
>  struct plic_priv {
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> +       u8 of_data;
>  };
>
>  struct plic_handler {
> @@ -163,10 +166,31 @@ static int plic_set_affinity(struct irq_data *d,
>  }
>  #endif
>
> +static void plic_irq_ack(struct irq_data *d)
> +{
> +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
> +       if (irqd_irq_masked(d)) {
> +               plic_irq_unmask(d);
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +               plic_irq_mask(d);
> +       } else {
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       }
> +}
> +
I sometimes still see an interrupt miss!

As per [0], we first need to claim the interrupt by reading the claim
register which needs to be done in the ack callback (which should be
doable) for edge interrupts, but the problem arises in the chained
handler callback where it does claim the interrupt by reading the
claim register.

static void plic_handle_irq(struct irq_desc *desc)
{
    struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
    struct irq_chip *chip = irq_desc_get_chip(desc);
    void __iomem *claim = handler->hart_base + CONTEXT_CLAIM;
    irq_hw_number_t hwirq;

    WARN_ON_ONCE(!handler->present);

    chained_irq_enter(chip, desc);

    while ((hwirq = readl(claim))) {
        int err = generic_handle_domain_irq(handler->priv->irqdomain,
                            hwirq);
        if (unlikely(err))
            pr_warn_ratelimited("can't find mapping for hwirq %lu\n",
                    hwirq);
    }

    chained_irq_exit(chip, desc);
}

I was thinking I would get around by getting the irqdata in
plic_handle_irq() callback using the irq_desc (struct irq_data *d =
&desc->irq_data;) and check the d->hwirq but this will be always 9.

        plic: interrupt-controller@12c00000 {
            compatible = "renesas-r9a07g043-plic";
            #interrupt-cells = <2>;
            #address-cells = <0>;
            riscv,ndev = <543>;
            interrupt-controller;
            reg = <0x0 0x12c00000 0 0x400000>;
            clocks = <&cpg CPG_MOD R9A07G043_NCEPLIC_ACLK>;
            clock-names = "plic100ss";
            power-domains = <&cpg>;
            resets = <&cpg R9A07G043_NCEPLIC_ARESETN>;
            interrupts-extended = <&cpu0_intc 11 &cpu0_intc 9>;
        };

Any pointers on how this could be done sanely.

[0] https://github.com/riscv/riscv-plic-spec/blob/master/images/PLICInterruptFlow.jpg

Cheers,
Prabhakar


>  static void plic_irq_eoi(struct irq_data *d)
>  {
>         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>
> +       /*
> +        * For Renesas R9A07G043 SoC if the interrupt type is EDGE
> +        * we have already acknowledged it in ack callback.
> +        */
> +       if (handler->priv->of_data == RENESAS_R9A07G043_PLIC &&
> +           !irqd_is_level_type(d))
> +               return;
> +
>         if (irqd_irq_masked(d)) {
>                 plic_irq_unmask(d);
>                 writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> @@ -176,11 +200,37 @@ static void plic_irq_eoi(struct irq_data *d)
>         }
>  }
>
> +static int plic_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> +
> +       if (handler->priv->of_data != RENESAS_R9A07G043_PLIC)
> +               return 0;
> +
> +       switch (type) {
> +       case IRQ_TYPE_LEVEL_HIGH:
> +               irq_set_handler_locked(d, handle_fasteoi_irq);
> +               break;
> +
> +       case IRQ_TYPE_EDGE_RISING:
> +               irq_set_handler_locked(d, handle_fasteoi_ack_irq);
> +               break;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct irq_chip plic_chip = {
>         .name           = "SiFive PLIC",
>         .irq_mask       = plic_irq_mask,
>         .irq_unmask     = plic_irq_unmask,
> +       .irq_ack        = plic_irq_ack,
>         .irq_eoi        = plic_irq_eoi,
> +       .irq_set_type   = plic_irq_set_type,
> +
>  #ifdef CONFIG_SMP
>         .irq_set_affinity = plic_set_affinity,
>  #endif
> @@ -198,6 +248,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
>         return 0;
>  }
>
> +static int plic_irq_domain_translate(struct irq_domain *d,
> +                                    struct irq_fwspec *fwspec,
> +                                    unsigned long *hwirq,
> +                                    unsigned int *type)
> +{
> +       struct plic_priv *priv = d->host_data;
> +
> +       if (priv->of_data == RENESAS_R9A07G043_PLIC)
> +               return irq_domain_translate_twocell(d, fwspec, hwirq, type);
> +
> +       return irq_domain_translate_onecell(d, fwspec, hwirq, type);
> +}
> +
>  static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>                                  unsigned int nr_irqs, void *arg)
>  {
> @@ -206,7 +269,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>         unsigned int type;
>         struct irq_fwspec *fwspec = arg;
>
> -       ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
> +       ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
>         if (ret)
>                 return ret;
>
> @@ -220,7 +283,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  }
>
>  static const struct irq_domain_ops plic_irqdomain_ops = {
> -       .translate      = irq_domain_translate_onecell,
> +       .translate      = plic_irq_domain_translate,
>         .alloc          = plic_irq_domain_alloc,
>         .free           = irq_domain_free_irqs_top,
>  };
> @@ -293,6 +356,9 @@ static int __init plic_init(struct device_node *node,
>         if (!priv)
>                 return -ENOMEM;
>
> +       if (of_device_is_compatible(node, "renesas-r9a07g043-plic"))
> +               priv->of_data = RENESAS_R9A07G043_PLIC;
> +
>         priv->regs = of_iomap(node, 0);
>         if (WARN_ON(!priv->regs)) {
>                 error = -EIO;
> @@ -411,5 +477,6 @@ static int __init plic_init(struct device_node *node,
>  }
>
>  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> +IRQCHIP_DECLARE(renesas_r9a07g043_plic, "renesas-r9a07g043-plic", plic_init);
>  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
>  IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_init); /* for firmware driver */
> --
> 2.25.1
>
