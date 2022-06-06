Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F0F53EE0E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiFFSrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbiFFSrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:47:42 -0400
Received: from sibelius.xs4all.nl (80-61-163-207.fixed.kpn.net [80.61.163.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC22F33AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:47:38 -0700 (PDT)
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 68ea6680;
        Mon, 6 Jun 2022 20:47:35 +0200 (CEST)
Date:   Mon, 6 Jun 2022 20:47:35 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     <Conor.Dooley@microchip.com>
Cc:     kettenis@openbsd.org, kernel@esmil.dk, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6acff7ab-6f97-b17a-ce9a-a526aac81181@microchip.com>
        (Conor.Dooley@microchip.com)
Subject: Re: [PATCH] riscv: dts: startfive: currect number of external
 interrupts
References: <20220606162924.71418-1-kettenis@openbsd.org> <6acff7ab-6f97-b17a-ce9a-a526aac81181@microchip.com>
Message-ID: <d3cdaa88f562dcda@bloch.sibelius.xs4all.nl>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: <Conor.Dooley@microchip.com>
> Date: Mon, 6 Jun 2022 16:45:44 +0000
> 
> On 06/06/2022 17:29, Mark Kettenis wrote:
> > [PATCH] riscv: dts: startfive: currect number of external interrupts
> 
> Just as a nit: s/startfive/starfive

I keep making that typo...

> > The PLIC integrated on the Vic_U7_Core integrated on the StarFive
> > JH7100 SoC actually supports 133 external interrupts.  127 of these
> > are exposed to the outside world; the remainder are used by other
> > devices that are part of the core-complex such as the L2 cache
> > controller.  But all 133 interrupts are external interrupts as far
> > as the PLIC is concerned.  Fixing the property that specifies the
> > number of external interrupts allows the driver to manage these
> > additional interrupts, whch is important since the interrupts for
> > the L2 cache controller are enabled by default.
> 
> This sentence is a little hard to follow, maybe:
> Fix the property so that the driver can manage these additional
> external interrupts, which is important...

Thanks, yes, that is better.

> Also, I suppose:
> Fixes: ec85362fb121 ("RISC-V: Add initial StarFive JH7100 device tree")

Sure.

I'll send out a V2 with a fixed commit message in a week or so.

> > ---
> >  arch/riscv/boot/dts/starfive/jh7100.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/boot/dts/starfive/jh7100.dtsi b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> > index 69f22f9aad9d..f48e232a72a7 100644
> > --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> > +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> > @@ -118,7 +118,7 @@ plic: interrupt-controller@c000000 {
> >                         interrupt-controller;
> >                         #address-cells = <0>;
> >                         #interrupt-cells = <1>;
> > -                       riscv,ndev = <127>;
> > +                       riscv,ndev = <133>;
> >                 };
> > 
> >                 clkgen: clock-controller@11800000 {
> > --
> > 2.36.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
