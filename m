Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F58B5338F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiEYJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiEYJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:01:14 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9F070374;
        Wed, 25 May 2022 02:01:13 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id z7so13883173ybf.7;
        Wed, 25 May 2022 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ng9vmXyRhXj4QrWMiydiTC2faW35Q1++d5V/xgecxmQ=;
        b=PFkRPQn3kfsCRcrb1KcMf6/C0L6KFBUP68UImSssNuWQs2ApfAbbH3vXNkot1xdz23
         LqC7TUa1swTcKCEaP/vhBe5CECBi3gue8+ccNVaPmwNIWdvSD7mUW5UxIUZo6jOOB1b4
         WNVh5JKCJrYwJULdJsECDMNCVqEyH4nJybF6r02yTPtmu5qIXYAgkmN1wACXkaQH1xjt
         9qOR7zWujP4uoZVa1i23Ir7aow3d34ilxFsinl/joxal9Zu6EQAl9GYGBCzPghsuwc/4
         8R92QiIbk3DN8NzhVyGCL4d04mjbxTZEbFX+wsJ7sa4Yd0GII6nb9VG4xdwt/xLJzhYG
         Mg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ng9vmXyRhXj4QrWMiydiTC2faW35Q1++d5V/xgecxmQ=;
        b=tSA1l60WON3bHGQCnZ3pwXOqyi1aUbEEkOOtOQZA9piT/8fPZP56i4GgRSEuAhFDSW
         gYxaQdhP2RU8xQbEIeMqD6ox49Ma5ad8/FWb/x7bWkVUdVn/e6Tt/kpax2CP/JsH3f7u
         5yXXeYXYY8CNmEUpJ684XmJ3adVJEkWHIoofeaueWg3jfqa7F+mEJ7bZTL6MpyWlSqfu
         g/NGgA0aOxwPMIkzZaEr636jYc+q5paxmS6/CsZ6qCU74KsoXj0uoj9uxth4O8+L0uVQ
         seNb+MBouIIl24CD3KAW9SrgsKy11zm7HyuQOQkE1oGxnKys3II8WyNzRafPt+vDXA+a
         8mOw==
X-Gm-Message-State: AOAM5301DFVY02zZMJ0jqv078GmdtM0j80laQ4Cmm7x2UHRZtwpCUGaA
        2hL98mgxPfJGDzPP33S2DEkGpfoDYQ9G+Hj9/S4rRN1gM1W53J3P
X-Google-Smtp-Source: ABdhPJxKpV63L+V/62qDba7rT3D1hrve3O2Qa69s+0UkTTVmwAHqOFMTteNULGyp9qVmeGsRer+V8ktz7oy/rPiR5kk=
X-Received: by 2002:a25:4bc4:0:b0:655:b2db:484 with SMTP id
 y187-20020a254bc4000000b00655b2db0484mr1210811yba.431.1653469272766; Wed, 25
 May 2022 02:01:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 25 May 2022 10:00:46 +0100
Message-ID: <CA+V-a8ubrkDU2B=mJopzFrjhv1nVn5EXZmaprta0oj4p3J_N5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Geert,

Thank you for the review.

On Wed, May 25, 2022 at 9:01 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
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
>
> Thanks for your patch!
>
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -60,10 +60,13 @@
> >  #define        PLIC_DISABLE_THRESHOLD          0x7
> >  #define        PLIC_ENABLE_THRESHOLD           0
> >
> > +#define RENESAS_R9A07G043_PLIC         1
> > +
> >  struct plic_priv {
> >         struct cpumask lmask;
> >         struct irq_domain *irqdomain;
> >         void __iomem *regs;
> > +       u8 of_data;
>
> Usually it's cleaner to use feature bits instead of enum types.
>
Agreed.

> >  };
> >
> >  struct plic_handler {
> > @@ -163,10 +166,31 @@ static int plic_set_affinity(struct irq_data *d,
> >  }
> >  #endif
> >
> > +static void plic_irq_ack(struct irq_data *d)
> > +{
> > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +
>
> No check for RZ/Five or irq type?
That is because we set the handle_fasteoi_ack_irq() only in case of
RZ/Five and it is already checked in set_type() callback.

> .irq_ack() seems to be called for level interrupts, too
> (from handle_level_irq() through mask_ack_irq()).
>
Right but we are using handle_fasteoi_irq() for level interrupt which
doesn't call mask_ack_irq(). And I have confirmed by adding a print in
ack callback  and just enabling the serial (which has level
interrupts).

> > +       if (irqd_irq_masked(d)) {
> > +               plic_irq_unmask(d);
> > +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +               plic_irq_mask(d);
> > +       } else {
> > +               writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > +       }
> > +}
>
> The above is identical to the old plic_irq_eoi()...
>
Indeed..

> > +
> >  static void plic_irq_eoi(struct irq_data *d)
> >  {
> >         struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> >
> > +       /*
> > +        * For Renesas R9A07G043 SoC if the interrupt type is EDGE
> > +        * we have already acknowledged it in ack callback.
> > +        */
> > +       if (handler->priv->of_data == RENESAS_R9A07G043_PLIC &&
> > +           !irqd_is_level_type(d))
> > +               return;
> > +
>
> ... so you can just call into plic_irq_ack() here?
>
... yes it can be done.

> >         if (irqd_irq_masked(d)) {
> >                 plic_irq_unmask(d);
> >                 writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> > @@ -176,11 +200,37 @@ static void plic_irq_eoi(struct irq_data *d)
> >         }
> >  }
> >
> > +static int plic_irq_set_type(struct irq_data *d, unsigned int type)
> > +{
> > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > +
> > +       if (handler->priv->of_data != RENESAS_R9A07G043_PLIC)
> > +               return 0;
> > +
> > +       switch (type) {
> > +       case IRQ_TYPE_LEVEL_HIGH:
> > +               irq_set_handler_locked(d, handle_fasteoi_irq);
> > +               break;
> > +
> > +       case IRQ_TYPE_EDGE_RISING:
> > +               irq_set_handler_locked(d, handle_fasteoi_ack_irq);
> > +               break;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static struct irq_chip plic_chip = {
>
> I think this can be const.
>
Yes, I will update it.

> >         .name           = "SiFive PLIC",
> >         .irq_mask       = plic_irq_mask,
> >         .irq_unmask     = plic_irq_unmask,
> > +       .irq_ack        = plic_irq_ack,
>
> This causes extra processing on non-affected PLICs.
> Perhaps use a separate irq_chip instance?
>
I don't think so as the handle_fasteoi_ack_irq() is installed only in
case of RZ/Five, so irq_ack() will not be called for non-affected
PLIC's. Please correct me if I am wrong.

> >         .irq_eoi        = plic_irq_eoi,
> > +       .irq_set_type   = plic_irq_set_type,
> > +
> >  #ifdef CONFIG_SMP
> >         .irq_set_affinity = plic_set_affinity,
> >  #endif
> > @@ -198,6 +248,19 @@ static int plic_irqdomain_map(struct irq_domain *d, unsigned int irq,
> >         return 0;
> >  }
> >
> > +static int plic_irq_domain_translate(struct irq_domain *d,
> > +                                    struct irq_fwspec *fwspec,
> > +                                    unsigned long *hwirq,
> > +                                    unsigned int *type)
> > +{
> > +       struct plic_priv *priv = d->host_data;
> > +
> > +       if (priv->of_data == RENESAS_R9A07G043_PLIC)
> > +               return irq_domain_translate_twocell(d, fwspec, hwirq, type);
> > +
> > +       return irq_domain_translate_onecell(d, fwspec, hwirq, type);
>
> This one clearly shows the discerning feature: onecell or twocell...
>
> > +}
> > +
> >  static int plic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> >                                  unsigned int nr_irqs, void *arg)
> >  {
>
> > @@ -293,6 +356,9 @@ static int __init plic_init(struct device_node *node,
> >         if (!priv)
> >                 return -ENOMEM;
> >
> > +       if (of_device_is_compatible(node, "renesas-r9a07g043-plic"))
> > +               priv->of_data = RENESAS_R9A07G043_PLIC;
> > +
>
> So perhaps instead just look at #interrupt-cells, and use the onecell
> or twocell irq_chip/irq_domain_ops based on that?
>
But we do call plic_irq_domain_translate() in the alloc callback and
don't have a node pointer in there to check the interrupt cell count.
Or maybe we can store the interrupt cell count in priv and use it
accordingly above?

Cheers,
Prabhakar

> >         priv->regs = of_iomap(node, 0);
> >         if (WARN_ON(!priv->regs)) {
> >                 error = -EIO;
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
