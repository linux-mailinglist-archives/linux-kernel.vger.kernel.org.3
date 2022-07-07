Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3DC5699AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiGGFG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbiGGFGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:06:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04313121C;
        Wed,  6 Jul 2022 22:06:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CDB4621D2;
        Thu,  7 Jul 2022 05:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CCAC341C8;
        Thu,  7 Jul 2022 05:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657170413;
        bh=Jp56n1Q8nuuJ/Ol2IwRkJZiElt4410mpz3pcmqKCxJQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UlNfbR2HTEcD0ouFvz/nuuJ+dKNh330v0fKcd9bGKzrJE6FQRmHeVBJkxlIx2fsdg
         hg7VEWIXy3zgJaBm2kx7xXvcGy54OpuYmUGFUgxlMvijDTfjVCAK/o+a5DGf4ZCm69
         m4SwX5DjtkEhCQCc/iQhonhIL+QzskEYOkI16GUCc8zA3uNkhBupFwwls2KEO9XjNh
         Mc0UGEshZ5hjEv+dtIKISzM9YPum32+NO/bONY3O0iOE0/GddiqWQOE8IifLKyjrLf
         faC23qPGZ+zlwV7nmww/RY73vJRrtLpGamzUWIhdYLY2qH+7wMPOKl/zOjhin+fzfK
         p0UXYDuzybAVw==
Received: by mail-vs1-f41.google.com with SMTP id o13so17148795vsn.4;
        Wed, 06 Jul 2022 22:06:53 -0700 (PDT)
X-Gm-Message-State: AJIora8uNnT7EHXODZ2qGSFz3nDM4LuXUUIfG3lKz9tebfvxQH4KEQX7
        0SLGZrpKl+gBTfa/jau9DSog4V9HKprpcEYGDrM=
X-Google-Smtp-Source: AGRyM1sBMYmY+OGkZyWew1/NJ8m7Qs8YwqG4AF408nwDsdImXvFwJf0275nYv5IOS7xzaf2G+kyMnCcJ1FIsKk2mlbI=
X-Received: by 2002:a67:ae0e:0:b0:356:c48b:401d with SMTP id
 x14-20020a67ae0e000000b00356c48b401dmr10397967vse.51.1657170412784; Wed, 06
 Jul 2022 22:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220705224703.1571895-1-heiko@sntech.de> <20220705224703.1571895-4-heiko@sntech.de>
 <CAJF2gTT6DzPihaP+BHLM6Wvn=Hba-jb-bhs96U3+ApdSmT593g@mail.gmail.com> <3111003.5fSG56mABF@diego>
In-Reply-To: <3111003.5fSG56mABF@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 7 Jul 2022 13:06:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRN1J3edjbt5L9ELLtMzXKWUABQb=QxDA90uY7mj=O0rw@mail.gmail.com>
Message-ID: <CAJF2gTRN1J3edjbt5L9ELLtMzXKWUABQb=QxDA90uY7mj=O0rw@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] riscv: Add support for non-coherent devices using
 zicbom extension
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 7, 2022 at 7:03 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Guo,
>
> Am Mittwoch, 6. Juli 2022, 01:32:12 CEST schrieb Guo Ren:
> > On Wed, Jul 6, 2022 at 6:47 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > The Zicbom ISA-extension was ratified in november 2021
> > > and introduces instructions for dcache invalidate, clean
> > > and flush operations.
> > >
> > > Implement cache management operations for non-coherent devices
> > > based on them.
> > >
> > > Of course not all cores will support this, so implement an
> > > alternative-based mechanism that replaces empty instructions
> > > with ones done around Zicbom instructions.
> > >
> > > As discussed in previous versions, assume the platform
> > > being coherent by default so that non-coherent devices need
> > > to get marked accordingly by firmware.
> > >
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > > Cc: Guo Ren <guoren@kernel.org>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > ---
> > >  arch/riscv/Kconfig                   |  31 ++++++++
> > >  arch/riscv/Makefile                  |   4 +
> > >  arch/riscv/include/asm/cache.h       |   4 +
> > >  arch/riscv/include/asm/cacheflush.h  |  10 +++
> > >  arch/riscv/include/asm/errata_list.h |  19 ++++-
> > >  arch/riscv/include/asm/hwcap.h       |   1 +
> > >  arch/riscv/kernel/cpu.c              |   1 +
> > >  arch/riscv/kernel/cpufeature.c       |  24 ++++++
> > >  arch/riscv/kernel/setup.c            |   2 +
> > >  arch/riscv/mm/Makefile               |   1 +
> > >  arch/riscv/mm/dma-noncoherent.c      | 112 +++++++++++++++++++++++++=
++
> > >  11 files changed, 208 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/mm/dma-noncoherent.c
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 32ffef9f6e5b..f7b2b3a4b7f1 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -113,6 +113,7 @@ config RISCV
> > >         select MODULES_USE_ELF_RELA if MODULES
> > >         select MODULE_SECTIONS if MODULES
> > >         select OF
> > > +       select OF_DMA_DEFAULT_COHERENT
> > >         select OF_EARLY_FLATTREE
> > >         select OF_IRQ
> > >         select PCI_DOMAINS_GENERIC if PCI
> > > @@ -218,6 +219,14 @@ config PGTABLE_LEVELS
> > >  config LOCKDEP_SUPPORT
> > >         def_bool y
> > >
> > > +config RISCV_DMA_NONCOHERENT
> > > +       bool
> > > +       select ARCH_HAS_DMA_PREP_COHERENT
> > > +       select ARCH_HAS_SYNC_DMA_FOR_DEVICE
> > > +       select ARCH_HAS_SYNC_DMA_FOR_CPU
> > > +       select ARCH_HAS_SETUP_DMA_OPS
> > > +       select DMA_DIRECT_REMAP
> > > +
> > >  source "arch/riscv/Kconfig.socs"
> > >  source "arch/riscv/Kconfig.erratas"
> > >
> > > @@ -376,6 +385,28 @@ config RISCV_ISA_SVPBMT
> > >
> > >            If you don't know what to do here, say Y.
> > >
> > > +config CC_HAS_ZICBOM
> > > +       bool
> > > +       default y if 64BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv64i=
ma_zicbom)
> > > +       default y if 32BIT && $(cc-option,-mabi=3Dlp64 -march=3Drv32i=
ma_zicbom)
> >
> > -mabi=3Dlp64 for rv32?
>
> Thanks for catching that! :-)
Okay, Add my "Reviewed-by: Guo Ren <guoren@kernel.org>" in your next versio=
n.

>
> When I converted over to using the real instructions for Zicbom instead o=
f
> pre-coded ones, I used a different format first for detecting the Zicbom
> existence and I guess when moving over to the above I made a mistake
> in the conversion.
>
> In any case, that should of course be ilp32, same as in the Makefile.
> With updated opensbi and Qemu I have now re-tested all possible
> combinations and am pretty hopefully that this should fit now.
>
> v7 following shortly.
>
> Thanks
> Heiko
>
>


--=20
Best Regards
 Guo Ren
