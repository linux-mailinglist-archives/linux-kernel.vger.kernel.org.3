Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D155B0DE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbiFZJiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 05:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiFZJip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:38:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3D69FD6;
        Sun, 26 Jun 2022 02:38:44 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id p7so10505589ybm.7;
        Sun, 26 Jun 2022 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrM8fmr9I0h54joG6BsHjIRR3lQUddnSZFNyk9j4QG4=;
        b=VIbd3IoqOjQ7kptkvw8VpO/Ck4M3JFTFDFvSfVpu4sVCn9Z5yr6JUFEc+wVx5N8J/4
         umaqV7Cw9xMiuDU5LKqvMfltci1x6uTEexYtgNY8XPV8nGPGra1rVfxbSlH18/I1P0HN
         Fgoghf6rlkFQuCG2W2/dq7ZaH+65nGU1HUDJjwDCkw1YJjlf7B0rCABhNtu0voHVAvf/
         nJ/Vc4aLeWIZdyepaStSlzpJ1o+7seFnTPjrU1+9LyADwEyi09AM5zGzC6rbzQaf/nb+
         BFRLSWFZdI2nFrIDSW0xCCDnn6Qlr9aUMAZY2PM8/58tWA/owCIi25c1Nz1hRMWMASfE
         gPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrM8fmr9I0h54joG6BsHjIRR3lQUddnSZFNyk9j4QG4=;
        b=QE9X9DFSL8ZXQjNQDlFAfJAUv2mhT3OnGWh14pRDRlOruOtkDnpGCoU6hSsRlj9Hnz
         NznnXPXIOG0erg0CYQKzc5f2DRY5SesUG/8Jh0HUI0lbCOS+hQwkMz6eNtzeYLrC3s7n
         XogGIhgoiBlvx3NlNbF1Q298L69Wev8DhHgj98Tkgg7D8povWxObNlkcA7HW8WMYqbh7
         iBQdB3ZDwRi/qY3TD5u32RnuK0MqP91kZn5ikfO9F+kfFKnk0vTe3LwzJ69tRdY2bW3X
         GBY0dPbrofo/N4vg6evoMZeRlYKp5tO8zC8Z5ucnbf/hW6zI0TvvcdIzjCHspDA8E8VL
         x/sA==
X-Gm-Message-State: AJIora+YT35Yj2OisOlHk9khiQXKNuKT1Jzzgvhu+lxktth3C8bYwt6w
        fFp2Hq1/8XKIR5+Rvq+YZnfT0qiT1BfMpVt8AgM=
X-Google-Smtp-Source: AGRyM1tZBKCNypkn3sLco2bO7U3aW6bsdf7VDZcN1ireIxS0m1ONqgAohIha7ZFF/SwBKOwt+mUqHn8nmyPXWpLHpz4=
X-Received: by 2002:a25:5f50:0:b0:66c:ae4c:264d with SMTP id
 h16-20020a255f50000000b0066cae4c264dmr1451655ybm.417.1656236323869; Sun, 26
 Jun 2022 02:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <87wnd3erab.wl-maz@kernel.org>
In-Reply-To: <87wnd3erab.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sun, 26 Jun 2022 10:38:18 +0100
Message-ID: <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Sun, Jun 26, 2022 at 9:56 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sun, 26 Jun 2022 01:43:26 +0100,
> Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> >
> > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > edge until the previous completion message has been received and
> > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > interrupts if not acknowledged in time.
> >
> > So the workaround for edge-triggered interrupts to be handled correctly
> > and without losing is that it needs to be acknowledged first and then
> > handler must be run so that we don't miss on the next edge-triggered
> > interrupt.
> >
> > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > support to change interrupt flow based on the interrupt type. It also
> > implements irq_ack and irq_set_type callbacks.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v1->v2:
> > * Implemented IRQ flow as suggested by Marc
> >
> > RFC-->v1:
> > * Fixed review comments pointed by Geert
> > * Dropped handle_fasteoi_ack_irq support as for the PLIC we need to
> > claim the interrupt by reading the register and then acknowledge it.
> > * Add a new chained handler for RZ/Five SoC.
> > ---
> >  drivers/irqchip/Kconfig           |  1 +
> >  drivers/irqchip/irq-sifive-plic.c | 73 ++++++++++++++++++++++++++++++-
> >  2 files changed, 72 insertions(+), 2 deletions(-)
>
> [...]
>
> >
> > +static int plic_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +     struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +
> > +     if (handler->priv->of_data != RENESAS_R9A07G043_PLIC)
> > +             return 0;
> > +
> > +     switch (type) {
> > +     case IRQ_TYPE_LEVEL_HIGH:
> > +             irq_set_chip_handler_name_locked(d, &renesas_rzfive_edge_plic_chip,
> > +                                              handle_fasteoi_ack_irq,
> > +                                              "Edge");
> > +             break;
> > +
> > +     case IRQ_TYPE_EDGE_RISING:
> > +             irq_set_chip_handler_name_locked(d, &plic_chip,
> > +                                              handle_fasteoi_irq,
> > +                                              "Level");
> > +             break;
>
> Really? Have you even tested this?
>
Ouch my bad, while rebasing I did swap this up!

> > +
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >                             irq_hw_number_t hwirq)
> >  {
> > @@ -198,6 +248,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >       return 0;
> >  }
> >
> > +static int plic_irq_domain_translate(struct irq_domain *d,
> > +                                  struct irq_fwspec *fwspec,
> > +                                  unsigned long *hwirq,
> > +                                  unsigned int *type)
> > +{
> > +     struct plic_priv *priv = d->host_data;
> > +
> > +     if (priv->of_data == RENESAS_R9A07G043_PLIC)
> > +             return irq_domain_translate_twocell(d, fwspec, hwirq, type);
> > +
> > +     return irq_domain_translate_onecell(d, fwspec, hwirq, type);
> > +}
> > +
> >  static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >                                unsigned int nr_irqs, void *arg)
> >  {
> > @@ -206,7 +269,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >       unsigned int type;
> >       struct irq_fwspec *fwspec = arg;
> >
> > -     ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
> > +     ret = plic_irq_domain_translate(domain, fwspec, &hwirq, &type);
> >       if (ret)
> >               return ret;
> >
> > @@ -220,7 +283,7 @@ static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >  }
> >
> >  static const struct irq_domain_ops plic_irqdomain_ops = {
> > -     .translate      = irq_domain_translate_onecell,
> > +     .translate      = plic_irq_domain_translate,
> >       .alloc          = plic_irq_domain_alloc,
> >       .free           = irq_domain_free_irqs_top,
> >  };
> > @@ -293,6 +356,11 @@ static int __init plic_init(struct device_node *node,
> >       if (!priv)
> >               return -ENOMEM;
> >
> > +     if (of_device_is_compatible(node, "renesas,r9a07g043-plic")) {
> > +             priv->of_data = RENESAS_R9A07G043_PLIC;
> > +             plic_chip.name = "Renesas RZ/Five PLIC";
>
> NAK. The irq_chip structure isn't the place for platform marketing.
> This is way too long anyway (and same for the edge version), and you
> even sent me a patch to make that structure const...
>
My bad will drop this.

Cheers,
Prabhakar
