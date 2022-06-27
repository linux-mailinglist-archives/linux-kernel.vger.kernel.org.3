Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2655C449
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiF0NQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiF0NPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:15:53 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAE2B37;
        Mon, 27 Jun 2022 06:12:47 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id n15so14545384qvh.12;
        Mon, 27 Jun 2022 06:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JxlerhPV4IshYu4oVBQQfkBjlxEmLypIX65zQRQHmm0=;
        b=q5hBxfZq9Ef3H08AbGbWHvuJyCjmPHBtfRgtpPw8IvMMMZ5i6TQP2hSxwAYxhQYj/Q
         pFBxWuJSY1r82ccTFPWx1O8vv1GBjCXCh4n+4XAhFbgkPyH5f4cFhoZQoVgGpEgmikKq
         vxE7s9HSR341bIfgB3E0KGsbVt7pz4fdipPF3Gm2v/+NJbe1cRv7ve2EZj1fpFrl+w8v
         3t85J592QYFptVqqAJWhvNoQV5riqXmsGNho8hYKZw04ZY7Bk2mfeFKIDu+98exweUzp
         IKqO4FPgN3zRt6ibDYups/a4q4DzUCb4rRTVSfbQvrPb/h7NMjvmZXFRQvesd4EsrTQc
         FHwQ==
X-Gm-Message-State: AJIora/8n2PfdXFQfoVVCPcpmzBdH+3emRXq/yChGMkn489wltmIx7Wo
        1CCkZXsuRY1eZ0NkFdK5TBCnf7YxdZk0QA==
X-Google-Smtp-Source: AGRyM1uL+xPshhK3u7MzAUT21eTIl0JO53bALEr9d+AJeoxUkWpqI3WPKq02soAQz58dlLdgQsbq8A==
X-Received: by 2002:a05:6214:2b07:b0:432:f7e6:e443 with SMTP id jx7-20020a0562142b0700b00432f7e6e443mr8564814qvb.125.1656335565552;
        Mon, 27 Jun 2022 06:12:45 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id de43-20020a05620a372b00b006a2f5ea4a29sm8673754qkb.46.2022.06.27.06.12.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:12:45 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-317a66d62dfso84876797b3.7;
        Mon, 27 Jun 2022 06:12:45 -0700 (PDT)
X-Received: by 2002:a81:574c:0:b0:317:7c3a:45be with SMTP id
 l73-20020a81574c000000b003177c3a45bemr14359795ywb.316.1656335564838; Mon, 27
 Jun 2022 06:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220626004326.8548-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220626004326.8548-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <87wnd3erab.wl-maz@kernel.org> <CA+V-a8tcxj_N0sBHhgAZAN8WSJ12JnDzAvUUnCXto3wHLqNVwg@mail.gmail.com>
 <87v8snehwi.wl-maz@kernel.org> <CAMuHMdVt9FjCtvMgJcCh=g2b+8b-fgabGbOLDcXNrrPMpC+3jQ@mail.gmail.com>
 <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
In-Reply-To: <CA+V-a8uLzLJ=wB6oUu0b2oZO=FPSCTSrqb=3m9=BJxATFKmjMw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Jun 2022 15:12:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUWC_7MPnP6LcOqi96FAhrAENC4iwtv2ksZVnvR8BC4ww@mail.gmail.com>
Message-ID: <CAMuHMdUWC_7MPnP6LcOqi96FAhrAENC4iwtv2ksZVnvR8BC4ww@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] irqchip/sifive-plic: Add support for Renesas
 RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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

Hi Prabhakar,

On Mon, Jun 27, 2022 at 3:06 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Jun 27, 2022 at 9:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, Jun 26, 2022 at 2:19 PM Marc Zyngier <maz@kernel.org> wrote:
> > > On Sun, 26 Jun 2022 10:38:18 +0100,
> > > "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> > > > On Sun, Jun 26, 2022 at 9:56 AM Marc Zyngier <maz@kernel.org> wrote:
> > > > > On Sun, 26 Jun 2022 01:43:26 +0100,
> > > > > Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > > The Renesas RZ/Five SoC has a RISC-V AX45MP AndesCore with NCEPLIC100. The
> > > > > > NCEPLIC100 supports both edge-triggered and level-triggered interrupts. In
> > > > > > case of edge-triggered interrupts NCEPLIC100 ignores the next interrupt
> > > > > > edge until the previous completion message has been received and
> > > > > > NCEPLIC100 doesn't support pending interrupt counter, hence losing the
> > > > > > interrupts if not acknowledged in time.
> > > > > >
> > > > > > So the workaround for edge-triggered interrupts to be handled correctly
> > > > > > and without losing is that it needs to be acknowledged first and then
> > > > > > handler must be run so that we don't miss on the next edge-triggered
> > > > > > interrupt.
> > > > > >
> > > > > > This patch adds a new compatible string for Renesas RZ/Five SoC and adds
> > > > > > support to change interrupt flow based on the interrupt type. It also
> > > > > > implements irq_ack and irq_set_type callbacks.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > > > > > +     if (of_device_is_compatible(node, "renesas,r9a07g043-plic")) {
> > > > > > +             priv->of_data = RENESAS_R9A07G043_PLIC;
> > > > > > +             plic_chip.name = "Renesas RZ/Five PLIC";
> > > > >
> > > > > NAK. The irq_chip structure isn't the place for platform marketing.
> > > > > This is way too long anyway (and same for the edge version), and you
> > > > > even sent me a patch to make that structure const...
> > > > >
> > > > My bad will drop this.
> > >
> > > And why you're at it, please turn this rather random 'of_data' into
> > > something like:
> > >
> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > > index bb87e4c3b88e..cd1683b77caf 100644
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > @@ -64,6 +64,10 @@ struct plic_priv {
> > >         struct cpumask lmask;
> > >         struct irq_domain *irqdomain;
> > >         void __iomem *regs;
> > > +       enum {
> > > +               VANILLA_PLIC,
> > > +               RENESAS_R9A07G043_PLIC,
> > > +       } flavour;
> > >  };
> > >
> > >  struct plic_handler {
> > >
> > > to give some structure to the whole thing, because I'm pretty sure
> > > we'll see more braindead implementations as time goes by.
> >
> > What about using a feature flag (e.g. had_edge_irqs) instead?
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index 9f16833dcb41..247c3c98b655 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -60,13 +60,13 @@
>  #define        PLIC_DISABLE_THRESHOLD          0x7
>  #define        PLIC_ENABLE_THRESHOLD           0
>
> +#define PLIC_QUIRK_EDGE_INTERRUPT      BIT(0)
>
>  struct plic_priv {
>         struct cpumask lmask;
>         struct irq_domain *irqdomain;
>         void __iomem *regs;
> +       u32 plic_quirks;
>  };
>
> What about something like above?

LGTM.

Marc suggested to make this unsigned long, but TBH, that won't make
much of a difference.  PLICs are present on RV32 SoCs, too, so you
cannot rely on having more than 32 bits anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
