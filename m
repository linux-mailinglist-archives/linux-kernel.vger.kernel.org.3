Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C51533A00
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235961AbiEYJfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbiEYJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:35:30 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718848B094;
        Wed, 25 May 2022 02:35:27 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id l1so16033221qvh.1;
        Wed, 25 May 2022 02:35:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTaGoLkIAZLAWf0HUaCretqVIbmJhnkdDonZvTvD9v0=;
        b=fSwAOHiVX5xiBwxMswDFPIAOdQjHTsEmTIgzXLD9R+aGiV9XI3mH8/8Xx272vFhgiV
         KgLzz8HNamNJxKUSRf83M3kOTwjdREAhN96M/QmoUoHA+Ce42gaQuns6+2PSbDk4BInU
         OADwV6CCH9KDYHuYhHI2e+P3T7pJkuUGSi9qdBrLs5nLrS931oZB0r/oPH6dHklmZiM2
         rcM86nQkATqk8tgsn/0nWaRP/Mg3O9g6cs9+MXJba6btrJsAnU6fJfaqddIr+dKQUToS
         VjN5D9GhswDSJ1XPAeqXFcbLXczyIjmGSp8nhSURnKolamPeDNTTCMsml4oB4vbLo4GX
         aI+A==
X-Gm-Message-State: AOAM530eOpZAm5htUcpl/w4llr82rMAxALh7yZEghXxY0elQW+2ekHTq
        ML4tYR4bRpMar7ECGg6t4dxXcoDFyAH2HQ==
X-Google-Smtp-Source: ABdhPJyu9UchkWDz8kQe78B3XOZ7jtdUrx87ePROtPKFyfGef8UVw+JMliXPNphpoQypZYTQV7kR8Q==
X-Received: by 2002:a05:6214:3005:b0:462:21ca:58b1 with SMTP id ke5-20020a056214300500b0046221ca58b1mr15512249qvb.47.1653471326300;
        Wed, 25 May 2022 02:35:26 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id y21-20020a376415000000b0069fc13ce23csm987210qkb.109.2022.05.25.02.35.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 02:35:25 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id i187so33059878ybg.6;
        Wed, 25 May 2022 02:35:25 -0700 (PDT)
X-Received: by 2002:a25:6851:0:b0:655:8432:e88d with SMTP id
 d78-20020a256851000000b006558432e88dmr4033965ybc.380.1653471324865; Wed, 25
 May 2022 02:35:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220524172214.5104-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220524172214.5104-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX0pqr8pmbX8OfUyTeEwiFGSG5uyP4nLG1LPy7_zzLPbQ@mail.gmail.com> <CA+V-a8ubrkDU2B=mJopzFrjhv1nVn5EXZmaprta0oj4p3J_N5Q@mail.gmail.com>
In-Reply-To: <CA+V-a8ubrkDU2B=mJopzFrjhv1nVn5EXZmaprta0oj4p3J_N5Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 May 2022 11:35:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVncBnD25RLLqL2qDFwboPSVvo5faJvamDxPH_wq9r22Q@mail.gmail.com>
Message-ID: <CAMuHMdVncBnD25RLLqL2qDFwboPSVvo5faJvamDxPH_wq9r22Q@mail.gmail.com>
Subject: Re: [PATCH RFC 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
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

On Wed, May 25, 2022 at 11:01 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Wed, May 25, 2022 at 9:01 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, May 24, 2022 at 7:22 PM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > edge until the previous completion message has been received and
> > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > interrupts if not acknowledged in time.
> > >
> > > So the workaround for edge-triggered interrupts to be handled correctly
> > > and without losing is that it needs to be acknowledged first and then
> > > handler must be run so that we don't miss on the next edge-triggered
> > > interrupt.
> > >
> > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > > support to change interrupt flow based on the interrupt type. It also
> > > implements irq_ack and irq_set_type callbacks.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Thanks for your patch!
> >
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c

> > > @@ -163,10 +166,31 @@ static int plic_set_affinity(struct irq_data *d,
> > >  }
> > >  #endif
> > >
> > > +static void plic_irq_ack(struct irq_data *d)
> > > +{
> > > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > +
> >
> > No check for RZ/Five or irq type?
> That is because we set the handle_fasteoi_ack_irq() only in case of
> RZ/Five and it is already checked in set_type() callback.
>
> > .irq_ack() seems to be called for level interrupts, too
> > (from handle_level_irq() through mask_ack_irq()).
> >
> Right but we are using handle_fasteoi_irq() for level interrupt which
> doesn't call mask_ack_irq(). And I have confirmed by adding a print in
> ack callback  and just enabling the serial (which has level
> interrupts).

But handle_fasteoi_irq() is configured only on RZ/Five below?
Which handler is used on non-RZ/Five?

I have to admit I'm not that deep into irq handling, and
adding a print indeed doesn't trigger on Starlight Beta.

> > > @@ -176,11 +200,37 @@ static void plic_irq_eoi(struct irq_data *d)
> > >         }
> > >  }
> > >
> > > +static int plic_irq_set_type(struct irq_data *d, unsigned int type)
> > > +{
> > > +       struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
> > > +
> > > +       if (handler->priv->of_data != RENESAS_R9A07G043_PLIC)
> > > +               return 0;
> > > +
> > > +       switch (type) {
> > > +       case IRQ_TYPE_LEVEL_HIGH:
> > > +               irq_set_handler_locked(d, handle_fasteoi_irq);
> > > +               break;
> > > +
> > > +       case IRQ_TYPE_EDGE_RISING:
> > > +               irq_set_handler_locked(d, handle_fasteoi_ack_irq);
> > > +               break;
> > > +
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >  static struct irq_chip plic_chip = {
> > >         .name           = "SiFive PLIC",
> > >         .irq_mask       = plic_irq_mask,
> > >         .irq_unmask     = plic_irq_unmask,
> > > +       .irq_ack        = plic_irq_ack,
> >
> > This causes extra processing on non-affected PLICs.
> > Perhaps use a separate irq_chip instance?
> >
> I don't think so as the handle_fasteoi_ack_irq() is installed only in
> case of RZ/Five, so irq_ack() will not be called for non-affected
> PLIC's. Please correct me if I am wrong.

Hence I'll leave this to the irq maintainer...

> > > @@ -293,6 +356,9 @@ static int __init plic_init(struct device_node *node,
> > >         if (!priv)
> > >                 return -ENOMEM;
> > >
> > > +       if (of_device_is_compatible(node, "renesas-r9a07g043-plic"))
> > > +               priv->of_data = RENESAS_R9A07G043_PLIC;
> > > +
> >
> > So perhaps instead just look at #interrupt-cells, and use the onecell
> > or twocell irq_chip/irq_domain_ops based on that?
> >
> But we do call plic_irq_domain_translate() in the alloc callback and
> don't have a node pointer in there to check the interrupt cell count.
> Or maybe we can store the interrupt cell count in priv and use it
> accordingly above?

That's a reasonable option.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
