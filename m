Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5C8514603
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357092AbiD2J4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 05:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345976AbiD2J4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 05:56:44 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA661C906;
        Fri, 29 Apr 2022 02:53:26 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id f186so5443408qke.8;
        Fri, 29 Apr 2022 02:53:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70I8wSWrKC9k1ABQmO5BN6/h/e8/pNZTe7YapF+lr7s=;
        b=50KfD2AhtnJl6nK24oGdTUE1x28/iGbcjiJb9/3gqdroeztnVOIfno2Qw9VOda/Vz7
         K5oNJjmXZLDtYeDQksBkB6e6DlTPfYqaIwKvBNTaV7y5VIaak5bOUoQ/DDLwyaq17dIm
         f73eTaUwuTIli1z4Z5GPR4DCus6lM7wHWW2+YM1Q4j/kZEHxDrJtQpNYNPcAon59Wpqw
         AL5d4433rNIxL/EGvgMBi02IwwJJrNcsTQEVP0pi/AiewZ578ggbbctO7HEdYMHdk5o1
         MxCGeADVuriRV/T/sO2RQA72f68jG24LaVfxP8aht0/vqAFWoSdm8l/9U4os8Xdr3Hvk
         wo0g==
X-Gm-Message-State: AOAM530HyS0+oH68qto5BtOXhKfTYuF/Cg9jbApVrkMqB1XNCtne+CH0
        aMQHt1C3JPn4Kb9NnlA7I7tsp6dhrM7T7DRG
X-Google-Smtp-Source: ABdhPJwdqh93fEMojiK4pRLYGnq9ONN3iP2KxS4jOfPWuhNguQmZHcMwBK5XGf2WPoqQ5vm4sm8Srw==
X-Received: by 2002:a37:98c4:0:b0:69a:e14:16a2 with SMTP id a187-20020a3798c4000000b0069a0e1416a2mr21979526qke.610.1651226005475;
        Fri, 29 Apr 2022 02:53:25 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id s4-20020ae9de04000000b0069c3a577b0asm1236000qkf.51.2022.04.29.02.53.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 02:53:24 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id f38so13579850ybi.3;
        Fri, 29 Apr 2022 02:53:24 -0700 (PDT)
X-Received: by 2002:a25:d84c:0:b0:648:7d5e:e2d4 with SMTP id
 p73-20020a25d84c000000b006487d5ee2d4mr21891538ybg.6.1651226004378; Fri, 29
 Apr 2022 02:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220421221159.31729-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421221159.31729-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVqk1ryzzK9-BZCMDPeyjfF1-8hMpzUoEPCcg8pJ2-ang@mail.gmail.com> <CA+V-a8tosEeNqzPZsdX=VCKTrkQfAhpMRWQDwva+fpQGc8x+jA@mail.gmail.com>
In-Reply-To: <CA+V-a8tosEeNqzPZsdX=VCKTrkQfAhpMRWQDwva+fpQGc8x+jA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 29 Apr 2022 11:53:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWTQkxZjCtWhcRnOo6w-Vz6SKrjuaK-YOMr=qfwLnD7Rg@mail.gmail.com>
Message-ID: <CAMuHMdWTQkxZjCtWhcRnOo6w-Vz6SKrjuaK-YOMr=qfwLnD7Rg@mail.gmail.com>
Subject: Re: [PATCH 2/2] irqchip: Add RZ/G2L IA55 Interrupt Controller driver
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Apr 29, 2022 at 11:43 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Apr 28, 2022 at 10:42 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Apr 22, 2022 at 12:12 AM Lad Prabhakar
> > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > Add a driver for the Renesas RZ/G2L Interrupt Controller.
> > >
> > > This supports external pins being used as interrupts. It supports
> > > one line for NMI, 8 external pins and 32 GPIO pins (out of 123)
> > > to be used as IRQ lines.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > --- /dev/null
> > > +++ b/drivers/irqchip/irq-renesas-rzg2l.c
> > > @@ -0,0 +1,447 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Renesas RZ/G2L IRQC Driver
> > > + *
> > > + * Copyright (C) 2022 Renesas Electronics Corporation.
> > > + *
> > > + * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > + */
> > > +
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/irqchip.h>
> > > +#include <linux/irqdomain.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/spinlock.h>
> > > +
> > > +#define IRQC_IRQ_START                 1
> > > +#define IRQC_IRQ_COUNT                 8
> > > +#define IRQC_TINT_START                        9
> >
> > = IRQC_IRQ_START + IRQC_IRQ_COUNT
> >
> OK
>
> > > +#define IRQC_TINT_COUNT                        32
> > > +#define IRQC_NUM_IRQ                   41
> >
> > = IRQC_TINT_START + IRQC_TINT_COUNT
> >
> OK.
>
> > Should these be in a DT binding header file?
> >
> > Combining all types into a single linear number space makes it hard
> > to extend the range, when reusing for an SoC that supports more
> > interrupt sources.
> >
> Or  DT data maybe?

Let's leave it for now. As I missed that DT consumers will refer to
external interrupt numbers only (is that actually enforced?), there
won't be an issue.

The driver can be changed later to derive IRQC_IRQ_COUNT from the
compatible value, when needed.

> > > +       u32 reg;
> > > +
> > > +       reg = readl_relaxed(priv->base + ISCR);
> > > +       if (reg & bit)
> > > +               writel_relaxed(GENMASK(IRQC_IRQ_COUNT - 1, 0) & ~bit,
> >
> > As writes to the unused upper bits are ignored, you can drop the
> > masking with GENMASK(IRQC_IRQ_COUNT - 1, 0), and be prepared for more
> > interrupt sources.
> >
> Agreed.

> > > +       u32 bit = BIT(hw_irq - IRQC_TINT_START);
> > > +       u32 reg;
> > > +
> > > +       reg = readl_relaxed(priv->base + TSCR);
> > > +       if (reg & bit)
> > > +               writel_relaxed(GENMASK(IRQC_TINT_COUNT - 1, 0) & ~bit,
> >
> > Drop the masking with all-ones?
> >
> You mean instead of a mask just use the reg instead?

No, I meant to drop the masking with GENMASK(IRQC_TINT_COUNT - 1, 0),
cfr. for external interrupts.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
