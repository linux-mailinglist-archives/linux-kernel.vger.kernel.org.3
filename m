Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034A0569599
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbiGFXDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiGFXDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:03:00 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A41DA6A;
        Wed,  6 Jul 2022 16:02:57 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o9E2X-0002uT-8c; Thu, 07 Jul 2022 01:02:37 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Fu <wefu@redhat.com>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Christoph Hellwig <hch@lst.de>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Rob Herring <robh+dt@kernel.org>, krzk+dt@kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH v6 3/4] riscv: Add support for non-coherent devices using zicbom extension
Date:   Thu, 07 Jul 2022 01:02:36 +0200
Message-ID: <3111003.5fSG56mABF@diego>
In-Reply-To: <CAJF2gTT6DzPihaP+BHLM6Wvn=Hba-jb-bhs96U3+ApdSmT593g@mail.gmail.com>
References: <20220705224703.1571895-1-heiko@sntech.de> <20220705224703.1571895-4-heiko@sntech.de> <CAJF2gTT6DzPihaP+BHLM6Wvn=Hba-jb-bhs96U3+ApdSmT593g@mail.gmail.com>
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

Hi Guo,

Am Mittwoch, 6. Juli 2022, 01:32:12 CEST schrieb Guo Ren:
> On Wed, Jul 6, 2022 at 6:47 AM Heiko Stuebner <heiko@sntech.de> wrote:
> >
> > The Zicbom ISA-extension was ratified in november 2021
> > and introduces instructions for dcache invalidate, clean
> > and flush operations.
> >
> > Implement cache management operations for non-coherent devices
> > based on them.
> >
> > Of course not all cores will support this, so implement an
> > alternative-based mechanism that replaces empty instructions
> > with ones done around Zicbom instructions.
> >
> > As discussed in previous versions, assume the platform
> > being coherent by default so that non-coherent devices need
> > to get marked accordingly by firmware.
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <anup@brainfault.org>
> > ---
> >  arch/riscv/Kconfig                   |  31 ++++++++
> >  arch/riscv/Makefile                  |   4 +
> >  arch/riscv/include/asm/cache.h       |   4 +
> >  arch/riscv/include/asm/cacheflush.h  |  10 +++
> >  arch/riscv/include/asm/errata_list.h |  19 ++++-
> >  arch/riscv/include/asm/hwcap.h       |   1 +
> >  arch/riscv/kernel/cpu.c              |   1 +
> >  arch/riscv/kernel/cpufeature.c       |  24 ++++++
> >  arch/riscv/kernel/setup.c            |   2 +
> >  arch/riscv/mm/Makefile               |   1 +
> >  arch/riscv/mm/dma-noncoherent.c      | 112 +++++++++++++++++++++++++++
> >  11 files changed, 208 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/mm/dma-noncoherent.c
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index 32ffef9f6e5b..f7b2b3a4b7f1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -113,6 +113,7 @@ config RISCV
> >         select MODULES_USE_ELF_RELA if MODULES
> >         select MODULE_SECTIONS if MODULES
> >         select OF
> > +       select OF_DMA_DEFAULT_COHERENT
> >         select OF_EARLY_FLATTREE
> >         select OF_IRQ
> >         select PCI_DOMAINS_GENERIC if PCI
> > @@ -218,6 +219,14 @@ config PGTABLE_LEVELS
> >  config LOCKDEP_SUPPORT
> >         def_bool y
> >
> > +config RISCV_DMA_NONCOHERENT
> > +       bool
> > +       select ARCH_HAS_DMA_PREP_COHERENT
> > +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > +       select ARCH_HAS_SYNC_DMA_FOR_CPU
> > +       select ARCH_HAS_SETUP_DMA_OPS
> > +       select DMA_DIRECT_REMAP
> > +
> >  source "arch/riscv/Kconfig.socs"
> >  source "arch/riscv/Kconfig.erratas"
> >
> > @@ -376,6 +385,28 @@ config RISCV_ISA_SVPBMT
> >
> >            If you don't know what to do here, say Y.
> >
> > +config CC_HAS_ZICBOM
> > +       bool
> > +       default y if 64BIT && $(cc-option,-mabi=lp64 -march=rv64ima_zicbom)
> > +       default y if 32BIT && $(cc-option,-mabi=lp64 -march=rv32ima_zicbom)
>
> -mabi=lp64 for rv32?

Thanks for catching that! :-) 

When I converted over to using the real instructions for Zicbom instead of
pre-coded ones, I used a different format first for detecting the Zicbom
existence and I guess when moving over to the above I made a mistake
in the conversion.

In any case, that should of course be ilp32, same as in the Makefile.
With updated opensbi and Qemu I have now re-tested all possible
combinations and am pretty hopefully that this should fit now.

v7 following shortly.

Thanks
Heiko


