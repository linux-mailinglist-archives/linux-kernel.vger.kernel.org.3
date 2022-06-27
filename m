Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6470055C39B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiF0Ixb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiF0Ix3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:53:29 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741862DE;
        Mon, 27 Jun 2022 01:53:28 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id z16so1537021qkj.7;
        Mon, 27 Jun 2022 01:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ruOoryFdJTYSwm98bFwmI1FC+X3Sx2AY+/obbwRbEE=;
        b=s/jqXpK4Y0Lcnk3vSoatioIlX5IcfkDXjW9ogrsyob1BWuigmzgFhEENh+X2vDXxEC
         uy6GPUd7yNRrWoDprwo1u4pyaR0Lj/Wc9yC0msf4cn5ENAIuBVs6xjVf1xnYUqw1vyMK
         rEgkbsgTvMXO5zg3kt5RPcOlti0cgYQFDMWJj9jUXld7Z/P5cRLLB3xzDsSEDUhO20BY
         /i4zFx/rM3EannwmMvA4dv+UUgXuuLkCOc2zofN4fcbQMGKZr3TBkli416Xh7MIls0j5
         lEYGgZWlGV8tBC+KXhwQPQqjxJWa43ufUkOy4ZALUBYTvD6TEt9u0K3AZNvVUF4yFCr5
         Qs2Q==
X-Gm-Message-State: AJIora+ZB0Vc05K2NqtNTj+jouuxYAMFjlE2jbdkgH9KoG5kIoMQo4X2
        xlxqSmI4sz7ssriJm6Fu7722VdNgrJiFfQ==
X-Google-Smtp-Source: AGRyM1u6Zm/B/Gpqh1OPf5d94BINJWBUKILk/zcoslIHOeJOezFF6QkMq5t/rxHHBi68CXNei+lPSw==
X-Received: by 2002:a37:9605:0:b0:6ae:e9c8:181c with SMTP id y5-20020a379605000000b006aee9c8181cmr7085583qkd.585.1656320007404;
        Mon, 27 Jun 2022 01:53:27 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id l2-20020a05620a28c200b006a6cadd89efsm8918986qkp.82.2022.06.27.01.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 01:53:26 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-318889e6a2cso78336577b3.1;
        Mon, 27 Jun 2022 01:53:26 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr13161209ywb.316.1656320006319; Mon, 27
 Jun 2022 01:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org> <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org>
In-Reply-To: <87v8snehwi.wl-maz@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 10:53:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
Message-ID: <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Sun, Jun 26, 2022 at 2:19 PM Marc Zyngier <maz@kernel.org> wrote:
> On Sun, 26 Jun 2022 10:38:18 +0100,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > On Sun, Jun 26, 2022 at 9:56 AM Marc Zyngier <maz@kernel.org> wrote:
> > > On Sun, 26 Jun 2022 01:43:26 +0100,
> > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > > edge until the previous completion message has been received and
> > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > > interrupts if not acknowledged in time.
> > > >
> > > > So the workaround for edge-triggered interrupts to be handled correctly
> > > > and without losing is that it needs to be acknowledged first and then
> > > > handler must be run so that we don't miss on the next edge-triggered
> > > > interrupt.
> > > >
> > > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > > > support to change interrupt flow based on the interrupt type. It also
> > > > implements irq_ack and irq_set_type callbacks.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > > +     if (of_device_is_compatible(node, "renesas,r9a07g043-plic")) {
> > > > +             priv->of_data = RENESAS_R9A07G043_PLIC;
> > > > +             plic_chip.name = "Renesas RZ/Five PLIC";
> > >
> > > NAK. The irq_chip structure isn't the place for platform marketing.
> > > This is way too long anyway (and same for the edge version), and you
> > > even sent me a patch to make that structure const...
> > >
> > My bad will drop this.
>
> And why you're at it, please turn this rather random 'of_data' into
> something like:
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index bb87e4c3b88e..cd1683b77caf 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -64,6 +64,10 @@ struct plic_priv {
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> +       enum {
> +               VANILLA_PLIC,
> +               RENESAS_R9A07G043_PLIC,
> +       } flavour;
>  };
>
>  struct plic_handler {
>
> to give some structure to the whole thing, because I'm pretty sure
> we'll see more braindead implementations as time goes by.

What about using a feature flag (e.g. had_edge_irqs) instead?

> It almost feels like I've written this whole patch. Oh wait...

> Without deviation from the norm, progress is not possible.

How applicable ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
