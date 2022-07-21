Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED5B57CA27
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbiGUL7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiGUL7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:59:37 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0312F65D61;
        Thu, 21 Jul 2022 04:59:34 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id b25so1052394qka.11;
        Thu, 21 Jul 2022 04:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRz/hxcrvKaBBIf3i1cgs6tUJRVDE9Sapae6r7E79pw=;
        b=66SNt/WmtKLXhmxDXTDVgulQYqbOxFF0tMq5ItusPVw8lNq0ECGDEuILGu1giYRcsb
         6DFJHmWvFtYc53ew3b30BBUzvqzmOQCbiOumKKCdo3SiRXILXpT6kPcJoNWUj711E3CF
         kigWhTxI8C758XtHaRdmwGCDYzaRiVZL9tJNGirhJcNbot4FGMWPJR7dYVyPxcB7wB2J
         TH+Kf3n33IhLHJMMt3saYKffTzjw+BftJXdr0OKYw3p6u1oDIdR0hZzBK3OJ9Wm06ha1
         SGQO3eNVGEwUrUp6Xq/1d71TSod7WF1Wbgu6osuYxLZmwO3XspIldq3hst/NP5jc9cKM
         ebEw==
X-Gm-Message-State: AJIora+Cm1BA78I7pFsdsVNdslELYly6OPwc921xpDsFpYLYkwctLoWq
        auphys0BW5RHKCDSbUkF/LO/jjJpAI5u1A==
X-Google-Smtp-Source: AGRyM1tmoehH1ovNz56iTGd4o9Fa2qWfFERqV5Fo8MD0TQRz2/QQuYQnpuvT9fJueixfo2fLaofsBw==
X-Received: by 2002:a37:d281:0:b0:6af:24c7:a981 with SMTP id f123-20020a37d281000000b006af24c7a981mr28334921qkj.736.1658404772977;
        Thu, 21 Jul 2022 04:59:32 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a298600b006a75a0ffc97sm1335467qkp.3.2022.07.21.04.59.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 04:59:32 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31bf3656517so14269367b3.12;
        Thu, 21 Jul 2022 04:59:32 -0700 (PDT)
X-Received: by 2002:a81:6088:0:b0:31e:79fd:3dfa with SMTP id
 u130-20020a816088000000b0031e79fd3dfamr3834563ywb.47.1658404772353; Thu, 21
 Jul 2022 04:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
 <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com>
 <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com> <CA+V-a8uNZ8T6m+nav=UXTFcwtW8o_2dGE2QFMvkhwcUU=Ka42Q@mail.gmail.com>
In-Reply-To: <CA+V-a8uNZ8T6m+nav=UXTFcwtW8o_2dGE2QFMvkhwcUU=Ka42Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 21 Jul 2022 13:59:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRPpr9othmv9xAOx2a8r=pdP0uZw1xFN9Q0noq1zuw8w@mail.gmail.com>
Message-ID: <CAMuHMdXRPpr9othmv9xAOx2a8r=pdP0uZw1xFN9Q0noq1zuw8w@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Thu, Jul 21, 2022 at 1:55 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Thu, Jul 21, 2022 at 12:43 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Thu, Jul 21, 2022 at 1:07 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> > > > > and ETH1 respectively.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Thanks for your patch!
> > > >
> > > > > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > > @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
> > > > >                 compatible = "ethernet-phy-id0022.1640",
> > > > >                              "ethernet-phy-ieee802.3-c22";
> > > > >                 reg = <7>;
> > > > > +               interrupt-parent = <&irqc>;
> > > > > +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > > >
> > > > 2?
> > > >
> > > IRQ2 = SPI 3, the driver expects the SPI number and is used as index
> > > [0] to map the interrupt in the GIC.
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-renesas-rzg2l.c?h=next-20220720#n291
> >
> > Using the SPI number sounds strange to me, as the consumer
> > (Ethernet PHY) is linked to the IRQC, not to the GIC directly.
> >
> Right, are you suggesting that I tweak the driver? The other problem
> is how do we differentiate NMI and IRQ0? How about we add macros for
> IRQ0-7 and use them in the DTS?
>
> > > > "The first cell should contain external interrupt number (IRQ0-7)"
> > > >
> > > Probably I need to reword this to "The first cell should contain the
> > > SPI number for IRQ0-7/NMI interrupt lines" ?
> >
> > Oh, so zero is the NMI?
> > And 1-8 are IRQ0-7.
> >
> Yes that's right.

I don't think it was ever mentioned that the NMI was exposed, too.

Using macros sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
