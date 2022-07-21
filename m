Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414A357CA43
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiGUMHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGUMHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:07:32 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE2685FA3;
        Thu, 21 Jul 2022 05:07:20 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-31e7055a61dso14527467b3.11;
        Thu, 21 Jul 2022 05:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xWt72opS7dnmJ8mHP3+9HW2y9iSQk9b7ZoobcDm4Fo=;
        b=F/nzId5pJLfPNxsZ4LdxZvKxK5e8m1FDP9PRCbCRzd8CGgTvdP0/0nIpkXYjFxChs7
         m2rZxLMrP0RFLCbb0qcgilmOMtD0j65k4Qaazcin0/LM67OKMFrvWpU1XOLpoQzvQkS1
         3wAaGlIY5+2e0V+DhCZwdyWUJSclveQCO8zoxmvBr4YgfiEtsoZKsI4naTK0oDHLBdQI
         kGb0d+CePT+jWvA4LhWDSJwK+xHuDKMebgAW/yp8/E7LafQvivo9aNAoIDUE5/wpf80c
         U/rqXsmVHJ3N25tY0ixQ33mJDm53jC384UEWgZ9x3QHFBtv7Guz5QnMspqe57+vzm4K6
         e3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xWt72opS7dnmJ8mHP3+9HW2y9iSQk9b7ZoobcDm4Fo=;
        b=feVEKWWACYrcGcGb/3D6uLbTHdPE7YAZuW9X8S9kcMUoojA0lGhDWrp+rmw0FLw0l1
         D1Q0zaKLwIpgUGbhktvHaIct/MKay6X8CjhJQoSmaxf6tHKtg3Yf0uCEO7Dyiy5zWIgh
         UGcD5SsVYUNh2DL41ME77xYc9ggKUgs7R1ZDorXIu7yXH5yMFNCyIgMOWARuF9LRg8d4
         DyoZ5gMBkIuzT5/8RzPqskEtKV6Jvvboz105e5Xre0cXI6lEPyYl/LHY5aTnmwkcMbOJ
         SropgNAyja83kgJRYBOioXlfiVNul7W2PgdYek3AojRfW+cA8AZZSjSid7MD8Nyu2d4D
         bQJg==
X-Gm-Message-State: AJIora8l2WvVNLUVjEMG5LWfhiC7fmcTqAvVZwbQZynFH47HKdsRTh0I
        Iv/kxVR/MUVqyOGZ85YgLAE+Pfs1FnJg3dhsjRg=
X-Google-Smtp-Source: AGRyM1vlgVps0LNN1GoPgqOu0USAvL2m80D72J/oPB4gS6U8rbDWP+W4ytNC1/aVqR2pjECq/0ibj9o3dnOvdFMKuiA=
X-Received: by 2002:a0d:e9c2:0:b0:31d:cb10:62c with SMTP id
 s185-20020a0de9c2000000b0031dcb10062cmr41945953ywe.24.1658405239265; Thu, 21
 Jul 2022 05:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220718195651.7711-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220718195651.7711-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdV5s-q13pWXs-ki6o5h8=ZMPL11o08YQx1pawe9EUySBA@mail.gmail.com>
 <CA+V-a8tqhiO+WBOzAD40A10K+qtVQ4HE87C9PKVpoFgWkkS54w@mail.gmail.com>
 <CAMuHMdWcj2xv8FrCiTLCVQfWzejONCAv_o-VzAkicLAFNd5gPg@mail.gmail.com>
 <CA+V-a8uNZ8T6m+nav=UXTFcwtW8o_2dGE2QFMvkhwcUU=Ka42Q@mail.gmail.com> <CAMuHMdXRPpr9othmv9xAOx2a8r=pdP0uZw1xFN9Q0noq1zuw8w@mail.gmail.com>
In-Reply-To: <CAMuHMdXRPpr9othmv9xAOx2a8r=pdP0uZw1xFN9Q0noq1zuw8w@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Thu, 21 Jul 2022 13:06:51 +0100
Message-ID: <CA+V-a8v_Ap404DdXXkA1SU-02s2Y6i+r6psb--MzXOPWOss9nA@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: renesas: rzg2l-smarc-som: Add PHY
 interrupt support for ETH{0/1}
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Thu, Jul 21, 2022 at 12:59 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Thu, Jul 21, 2022 at 1:55 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Thu, Jul 21, 2022 at 12:43 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Thu, Jul 21, 2022 at 1:07 PM Lad, Prabhakar
> > > <prabhakar.csengg@gmail.com> wrote:
> > > > On Thu, Jul 21, 2022 at 11:47 AM Geert Uytterhoeven
> > > > <geert@linux-m68k.org> wrote:
> > > > > On Mon, Jul 18, 2022 at 9:57 PM Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > > > The PHY interrupt (INT_N) pin is connected to IRQ2 and IRQ3 for ETH0
> > > > > > and ETH1 respectively.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Thanks for your patch!
> > > > >
> > > > > > --- a/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/renesas/rzg2l-smarc-som.dtsi
> > > > > > @@ -94,6 +94,8 @@ phy0: ethernet-phy@7 {
> > > > > >                 compatible = "ethernet-phy-id0022.1640",
> > > > > >                              "ethernet-phy-ieee802.3-c22";
> > > > > >                 reg = <7>;
> > > > > > +               interrupt-parent = <&irqc>;
> > > > > > +               interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> > > > >
> > > > > 2?
> > > > >
> > > > IRQ2 = SPI 3, the driver expects the SPI number and is used as index
> > > > [0] to map the interrupt in the GIC.
> > > >
> > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/irqchip/irq-renesas-rzg2l.c?h=next-20220720#n291
> > >
> > > Using the SPI number sounds strange to me, as the consumer
> > > (Ethernet PHY) is linked to the IRQC, not to the GIC directly.
> > >
> > Right, are you suggesting that I tweak the driver? The other problem
> > is how do we differentiate NMI and IRQ0? How about we add macros for
> > IRQ0-7 and use them in the DTS?
> >
> > > > > "The first cell should contain external interrupt number (IRQ0-7)"
> > > > >
> > > > Probably I need to reword this to "The first cell should contain the
> > > > SPI number for IRQ0-7/NMI interrupt lines" ?
> > >
> > > Oh, so zero is the NMI?
> > > And 1-8 are IRQ0-7.
> > >
> > Yes that's right.
>
> I don't think it was ever mentioned that the NMI was exposed, too.
>
Sorry for not making this clearer.

> Using macros sounds fine to me.
>
Ok, I will send a v2 (just this patch alone) with the macros added as
a separate patch in rzg2l-pinctrl.h?

Cheers,
Prabhakar

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
