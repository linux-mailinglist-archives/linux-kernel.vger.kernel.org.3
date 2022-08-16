Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E85957B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiHPKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiHPKK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:10:58 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7DDB84;
        Tue, 16 Aug 2022 02:17:32 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNshO-0002qi-Pk; Tue, 16 Aug 2022 11:17:22 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     samuel@sholland.org, wens@csie.org, jernej.skrabec@gmail.com,
        linux-sunxi@lists.linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor.Dooley@microchip.com
Subject: Re: [PATCH 05/12] riscv: Add the Allwinner SoC family Kconfig option
Date:   Tue, 16 Aug 2022 11:17:22 +0200
Message-ID: <10785313.BaYr0rKQ5T@diego>
In-Reply-To: <a70e34b9-7106-ad2a-16e1-5f115e34ff1e@microchip.com>
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-6-samuel@sholland.org> <a70e34b9-7106-ad2a-16e1-5f115e34ff1e@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. August 2022, 18:56:23 CEST schrieb Conor.Dooley@microchip.com:
> On 15/08/2022 06:08, Samuel Holland wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Allwinner manufactures the sunxi family of application processors. This
> > includes the "sun8i" series of ARMv7 SoCs, the "sun50i" series of ARMv8
> > SoCs, and now the "sun20i" series of 64-bit RISC-V SoCs.
> > 
> > The first SoC in the sun20i series is D1, containing a single T-HEAD
> > C906 core. D1s is a low-pin-count variant of D1 with co-packaged DRAM.
> > 
> > Most peripherals are shared across the entire chip family. In fact, the
> > ARMv7 T113 SoC is pin-compatible and almost entirely register-compatible
> > with the D1s.
> > 
> > This means many existing device drivers can be reused. To facilitate
> > this reuse, name the symbol ARCH_SUNXI, since that is what the existing
> > drivers have as their dependency.
> 
> Hey Samuel,
> I think this and patch 12/12 with the defconfig changes should be
> deferred until post LPC (which still leaves plenty of time for
> making the 6.1 merge window). We already have like 4 different
> approaches between the existing SOC_FOO symbols & two more when
> D1 stuff and the Renesas stuff is considered.

On the other hand, I don't really think it's that hard to change things
after the fact? I.e. ARCH_SUNXI is pretty much set in stone anyway,
so there isn't very much that _could_ change without affecting most
driver subsystems in the kernel.

So I don't think we'd actually need to wait with the Allwinner symbol.


Heiko

> Plan is to decide at LPC on one approach for what to do with
> Kconfig.socs & to me it seems like a good idea to do what's being
> done here - it's likely that further arm vendors will move and
> keeping the common symbols makes a lot of sense to me...
> 
> Thanks,
> Conor.
> 
> > 
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  arch/riscv/Kconfig.socs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> > index 69774bb362d6..1caacbfac1a5 100644
> > --- a/arch/riscv/Kconfig.socs
> > +++ b/arch/riscv/Kconfig.socs
> > @@ -1,5 +1,14 @@
> >  menu "SoC selection"
> > 
> > +config ARCH_SUNXI
> > +       bool "Allwinner sun20i SoCs"
> > +       select ERRATA_THEAD if MMU && !XIP_KERNEL
> > +       select SIFIVE_PLIC
> > +       select SUN4I_TIMER
> > +       help
> > +         This enables support for Allwinner sun20i platform hardware,
> > +         including boards based on the D1 and D1s SoCs.
> > +
> >  config SOC_MICROCHIP_POLARFIRE
> >         bool "Microchip PolarFire SoCs"
> >         select MCHP_CLK_MPFS
> > --
> > 2.35.1
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 




