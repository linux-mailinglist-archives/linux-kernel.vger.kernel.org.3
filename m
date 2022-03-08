Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B753A4D16B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346633AbiCHL53 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 8 Mar 2022 06:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235676AbiCHL51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:57:27 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF7E3982C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:56:28 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nRYRx-00075n-Lt; Tue, 08 Mar 2022 12:56:21 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, liush@allwinnertech.com, guoren@kernel.org,
        atishp@atishpatra.org, anup@brainfault.org, drew@beagleboard.org,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        wens@csie.org, maxime@cerno.tech, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        mick@ics.forth.gr, allen.baum@esperantotech.com,
        jscheid@ventanamicro.com, rtrauben@gmail.com, samuel@sholland.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu
Subject: Re: [PATCH v7 00/13] riscv: support for Svpbmt and D1 memory types
Date:   Tue, 08 Mar 2022 12:56:20 +0100
Message-ID: <2347714.EJkkgcx2xJ@diego>
In-Reply-To: <mhng-4052f547-4a01-44ca-9286-97cc57819fbc@palmer-ri-x1c9>
References: <mhng-4052f547-4a01-44ca-9286-97cc57819fbc@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

Am Dienstag, 8. M�rz 2022, 01:47:25 CET schrieb Palmer Dabbelt:
> On Mon, 07 Mar 2022 12:52:57 PST (-0800), heiko@sntech.de wrote:
> > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> > for things like non-cacheable pages or I/O memory pages.
> >
> >
> > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> > types) using the alternatives framework.
> >
> > This includes a number of changes to the alternatives mechanism itself.
> > The biggest one being the move to a more central location, as I expect
> > in the future, nearly every chip needing some sort of patching, be it
> > either for erratas or for optional features (svpbmt or others).
> >
> > Detection of the svpbmt functionality is done via Atish's isa extension
> > handling series [0] and thus does not need any dt-parsing of its own
> > anymore.
> >
> > The series also introduces support for the memory types of the D1
> > which are implemented differently to svpbmt. But when patching anyway
> > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> > location.
> >
> > The only slightly bigger difference is that the "normal" type is not 0
> > as with svpbmt, so kernel patches for this PMA type need to be applied
> > even before the MMU is brought up, so the series introduces a separate
> > stage for that.
> >
> >
> > In theory this series is 3 parts:
> > - sbi cache-flush / null-ptr
> 
> That first patch looks like an acceptable candidate for fixes.  If 
> there's a regression that manifests I'm happy to take it, but if it's 
> only possible to manifest a crash with the new stuff then I'm OK just 
> holding off until the merge window.

While right now only my poking around the early init via alternatives
is affected, the problem exists for everyone.

I.e. I do consider flush_icache_all() to be generic enough that we
should expect someone trying to call this in some early code-path
as well.

But any call to flush_icache_all() before sbi_init() ran will cause the
breakage that is fixed by patch1 .


So it doesn't look like any _current_ code path has that issue, but
it might be good to just pick patch1 for the next merge window
individually?



> > - alternatives improvements
> > - svpbmt+d1
> >
> > So expecially patches from the first 2 areas could be applied when
> > deemed ready, I just thought to keep it together to show-case where
> > the end-goal is and not requiring jumping between different series.
> >
> >
> > I picked the recipient list from the previous versions, hopefully
> > I didn't forget anybody.
> >
> > changes in v7:
> > - fix typo in patch1 (Atish)
> > - moved to Atish's isa-extension framework
> > - and therefore move regular boot-alternatives directly behind fill_hwcaps
> > - change T-Head errata Kconfig text (Atish)
> 
> I was just poking around v6, so I have some minor comments there.  None 
> of those need to block merging this, but I am getting a bunch of build 
> failures under allmodconfig
> 
>     $ make.riscv allmodconfig
>     #
>     # configuration written to .config
>     #
>     $ make.riscv mm/kasan/init.o
>       SYNC    include/config/auto.conf.cmd
>       CALL    scripts/atomic/check-atomics.sh
>       CC      arch/riscv/kernel/asm-offsets.s
>       CALL    scripts/checksyscalls.sh
>       CC      mm/kasan/init.o
>     ./arch/riscv/include/asm/pgtable.h: Assembler messages:
>     ./arch/riscv/include/asm/pgtable.h:323: Error: attempt to move .org backwards
>     make[2]: *** [scripts/Makefile.build:288: mm/kasan/init.o] Error 1
>     make[1]: *** [scripts/Makefile.build:550: mm/kasan] Error 2
>     make: *** [Makefile:1831: mm] Error 2
> 
> Unfortunately my build box just blew up so I haven't had time to confim 
> this still exists on v7, but nothing's jumping out as a fix.  I've put 
> this on the riscv-d1 branch at kernel.org/palmer/linux, not sure exactly 
> what's going on but I'm guessing one of the macros has gone off the 
> rails.  I'm going to look at something else (as this one at least 
> depends on Atish's patches), but LMK if you've got the time to look into 
> this or if I should.

Yeah, we now depend on Atish's isa-extension parsing (same for my cmo
series and some more series I saw on the list), so getting that into a
mergeable position would be really great :-)

"attempt to move .org backwards" seems to be the telltale sign of the
alternatives blocks not matching up in size. While I definitly didn't see
anything like this in my tests on qemu + d1, I'll try to investigate where
that comes from.


Heiko



> > changes in v6:
> > - rebase onto 5.17-rc1
> > - handle sbi null-ptr differently
> > - improve commit messages
> > - use riscv,mmu as property name
> >
> > changes in v5:
> > - move to use alternatives for runtime-patching
> > - add D1 variant
> >
> >
> > [0] https://lore.kernel.org/r/20220222204811.2281949-2-atishp@rivosinc.com
> >
> >
> > Heiko Stuebner (12):
> >   riscv: prevent null-pointer dereference with sbi_remote_fence_i
> >   riscv: integrate alternatives better into the main architecture
> >   riscv: allow different stages with alternatives
> >   riscv: implement module alternatives
> >   riscv: implement ALTERNATIVE_2 macro
> >   riscv: extend concatenated alternatives-lines to the same length
> >   riscv: prevent compressed instructions in alternatives
> >   riscv: move boot alternatives to after fill_hwcap
> >   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
> >   riscv: add cpufeature handling via alternatives
> >   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
> >   riscv: add memory-type errata for T-Head
> >
> > Wei Fu (1):
> >   riscv: add RISC-V Svpbmt extension support
> >
> >  arch/riscv/Kconfig.erratas                  |  29 +++--
> >  arch/riscv/Kconfig.socs                     |   1 -
> >  arch/riscv/Makefile                         |   2 +-
> >  arch/riscv/errata/Makefile                  |   2 +-
> >  arch/riscv/errata/sifive/errata.c           |  17 ++-
> >  arch/riscv/errata/thead/Makefile            |   1 +
> >  arch/riscv/errata/thead/errata.c            |  85 +++++++++++++++
> >  arch/riscv/include/asm/alternative-macros.h | 114 +++++++++++---------
> >  arch/riscv/include/asm/alternative.h        |  16 ++-
> >  arch/riscv/include/asm/errata_list.h        |  52 +++++++++
> >  arch/riscv/include/asm/fixmap.h             |   2 -
> >  arch/riscv/include/asm/hwcap.h              |   1 +
> >  arch/riscv/include/asm/pgtable-32.h         |  17 +++
> >  arch/riscv/include/asm/pgtable-64.h         |  79 +++++++++++++-
> >  arch/riscv/include/asm/pgtable-bits.h       |  10 --
> >  arch/riscv/include/asm/pgtable.h            |  53 +++++++--
> >  arch/riscv/include/asm/vendorid_list.h      |   1 +
> >  arch/riscv/kernel/Makefile                  |   1 +
> >  arch/riscv/{errata => kernel}/alternative.c |  48 +++++++--
> >  arch/riscv/kernel/cpu.c                     |   1 +
> >  arch/riscv/kernel/cpufeature.c              |  80 +++++++++++++-
> >  arch/riscv/kernel/module.c                  |  29 +++++
> >  arch/riscv/kernel/sbi.c                     |  10 +-
> >  arch/riscv/kernel/setup.c                   |   2 +
> >  arch/riscv/kernel/smpboot.c                 |   4 -
> >  arch/riscv/kernel/traps.c                   |   2 +-
> >  arch/riscv/mm/init.c                        |   1 +
> >  27 files changed, 546 insertions(+), 114 deletions(-)
> >  create mode 100644 arch/riscv/errata/thead/Makefile
> >  create mode 100644 arch/riscv/errata/thead/errata.c
> >  rename arch/riscv/{errata => kernel}/alternative.c (59%)
> 




