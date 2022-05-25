Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 722855337E6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbiEYIBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiEYIBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:01:13 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD4142ED8;
        Wed, 25 May 2022 01:01:12 -0700 (PDT)
Received: by mail-qt1-f171.google.com with SMTP id h9so11873660qtx.2;
        Wed, 25 May 2022 01:01:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rlhkBuzRG2HpsdoImNR9zGgXgfkVtL8VEEmP1MsIdp4=;
        b=e/dGJoHTdDLkXLNsUeOnQo+c0/GOI+Z8ysk2EYWXuen8VmyvdkuCPEP1bk47021cCn
         tUU9okQTvpvZxXOP5NYuNfilOMlrtiibo+79lCjHmyM8Hl39FTL2C0meP+snFhc184uu
         LslRNuFFUgHUjSDi7lFJ3cqwAb3PvputEjMkmMVbGImZYClfbcGZ5RzsNEceUB+DWrRr
         IGsRRnFVgtyARaV279qlQejA9ow2yHe5o9V/4qn9dLTvkCBWYmEuoMAAS5Ua4ESrdFxw
         GUxX1K8D5MK/Ok0tYPEm9jdVCgfVm5qOiLp8XoPI518poWDwuqCiB3Wkxec3Tja/XTCy
         /HNw==
X-Gm-Message-State: AOAM531OFArkgFw8g39P5rGdXNAlqemCwhEn/wIjOgmeHtYBYSrXnQBA
        bkFbHEnrwpp7Gd2lVVd4nsco0EpGyFtqIA==
X-Google-Smtp-Source: ABdhPJyn968E+lnfj0Y4TJSLlb6EF9DLEeRadKECc2P+iM3t5kQtZIWu3sf/mZbnaKMmD1i445JXqw==
X-Received: by 2002:a05:622a:1108:b0:2f3:d7d1:cf28 with SMTP id e8-20020a05622a110800b002f3d7d1cf28mr23015938qty.481.1653465671266;
        Wed, 25 May 2022 01:01:11 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id g25-20020ac870d9000000b002f9433ed963sm923254qtp.64.2022.05.25.01.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 01:01:10 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-30007f11f88so74701107b3.7;
        Wed, 25 May 2022 01:01:09 -0700 (PDT)
X-Received: by 2002:a81:ad11:0:b0:2fe:fb00:a759 with SMTP id
 l17-20020a81ad11000000b002fefb00a759mr32321342ywh.283.1653465668841; Wed, 25
 May 2022 01:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 May 2022 10:00:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com>
Message-ID: <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
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

On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
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

Thanks for your patch!

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

Usually it's cleaner to use feature bits instead of enum types.

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

No check for RZ/Five or irq type?
.irq_ack() seems to be called for level interrupts, too
(from handle_level_irq() through mask_ack_irq()).

> +       if (irqd_irq_masked(d)) {
> +               plic_irq_unmask(d);
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +               plic_irq_mask(d);
> +       } else {
> +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +       }
> +}

The above is identical to the old plic_irq_eoi()...

> +
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

... so you can just call into plic_irq_ack() here?

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

I think this can be const.

>         .name           = "SiFive PLIC",
>         .irq_mask       = plic_irq_mask,
>         .irq_unmask     = plic_irq_unmask,
> +       .irq_ack        = plic_irq_ack,

This causes extra processing on non-affected PLICs.
Perhaps use a separate irq_chip instance?

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

This one clearly shows the discerning feature: onecell or twocell...

> +}
> +
>  static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
>                                  unsigned int nr_irqs, void *arg)
>  {

> @@ -293,6 +356,9 @@ static int __init plic_init(struct device_node *node,
>         if (!priv)
>                 return -ENOMEM;
>
> +       if (of_device_is_compatible(node, "renesas-r9a07g043-plic"))
> +               priv->of_data = RENESAS_R9A07G043_PLIC;
> +

So perhaps instead just look at #interrupt-cells, and use the onecell
or twocell irq_chip/irq_domain_ops based on that?

>         priv->regs = of_iomap(node, 0);
>         if (WARN_ON(!priv->regs)) {
>                 error = -EIO;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
