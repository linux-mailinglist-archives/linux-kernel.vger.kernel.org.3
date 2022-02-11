Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6B4B1BDC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347121AbiBKCEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:04:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbiBKCEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:04:51 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7B5F9B;
        Thu, 10 Feb 2022 18:04:49 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nILIc-0004k8-Ic; Fri, 11 Feb 2022 03:04:38 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Wei Fu <wefu@redhat.com>,
        liush <liush@allwinnertech.com>, Guo Ren <guoren@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Drew Fustini <drew@beagleboard.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Greg Favor <gfavor@ventanamicro.com>,
        Andrea Mondelli <andrea.mondelli@huawei.com>,
        Jonathan Behrens <behrensj@mit.edu>,
        Xinhaoqu <xinhaoqu@huawei.com>,
        Bill Huffman <huffman@cadence.com>,
        Nick Kossifidis <mick@ics.forth.gr>,
        Allen Baum <allen.baum@esperantotech.com>,
        Josh Scheid <jscheid@ventanamicro.com>,
        Richard Trauben <rtrauben@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Christoph Muellner <cmuellner@linux.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>
Subject: Re: [PATCH v6 00/14] riscv: support for Svpbmt and D1 memory types
Date:   Fri, 11 Feb 2022 03:04:37 +0100
Message-ID: <2177281.3HUnQTRebA@diego>
In-Reply-To: <CAOnJCUKzE3uBfu0Aqpr19b-XB76qY7qtaeK87FF7H4Tw5B+d_Q@mail.gmail.com>
References: <20220209123800.269774-1-heiko@sntech.de> <CAOnJCUL5w4+_zJvu-BxP+LGN2ohv6arY+uh0DOU586v_5mCE8g@mail.gmail.com> <CAOnJCUKzE3uBfu0Aqpr19b-XB76qY7qtaeK87FF7H4Tw5B+d_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 11. Februar 2022, 02:48:38 CET schrieb Atish Patra:
> On Thu, Feb 10, 2022 at 4:25 PM Atish Patra <atishp@atishpatra.org> wrote:
> >
> > On Wed, Feb 9, 2022 at 4:38 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > Svpbmt is an extension defining "Supervisor-mode: page-based memory types"
> > > for things like non-cacheable pages or I/O memory pages.
> > >
> > >
> > > So this is my 2nd try at implementing Svpbmt (and the diverging D1 memory
> > > types) using the alternatives framework.
> > >
> > > This includes a number of changes to the alternatives mechanism itself.
> > > The biggest one being the move to a more central location, as I expect
> > > in the future, nearly every chip needing some sort of patching, be it
> > > either for erratas or for optional features (svpbmt or others).
> > >
> > > The dt-binding for svpbmt itself is of course not finished and is still
> > > using the binding introduced in previous versions, as where to put
> > > a svpbmt-property in the devicetree is still under dicussion.
> > > Atish seems to be working on a framework for extensions [0],
> > >
> >
> > Here is the patch series
> > https://lore.kernel.org/lkml/20220210214018.55739-1-atishp@rivosinc.com/
> >
> > I think we can simplify the cpu feature probing in PATCH 10 with the
> > above series
> > which simply relies on the existing riscv_isa bitmap.
> >
> > We also don't need the separate svpbmt property in DT mmu node.
> > Let me know what you think.
> >
> > > The series also introduces support for the memory types of the D1
> > > which are implemented differently to svpbmt. But when patching anyway
> > > it's pretty clean to add the D1 variant via ALTERNATIVE_2 to the same
> > > location.
> > >
> > > The only slightly bigger difference is that the "normal" type is not 0
> > > as with svpbmt, so kernel patches for this PMA type need to be applied
> > > even before the MMU is brought up, so the series introduces a separate
> > > stage for that.
> > >
> > >
> > > In theory this series is 3 parts:
> > > - sbi cache-flush / null-ptr
> > > - alternatives improvements
> > > - svpbmt+d1
> > >
> > > So expecially patches from the first 2 areas could be applied when
> > > deemed ready, I just thought to keep it together to show-case where
> > > the end-goal is and not requiring jumping between different series.
> > >
> > >
> > > The sbi cache-flush patch is based on Atish's sparse-hartid patch [1],
> > > as it touches a similar area in mm/cacheflush.c
> > >
> > >
> > > I picked the recipient list from the previous version, hopefully
> > > I didn't forget anybody.
> > >
> 
> I am also getting a load access fault while booting this series in Qemu.
> 
> <with additional debug message when before sbi_trap_redirect in OpenSBI>
> sbi_trap_error_debug: hart1: trap handler failed (error -2)
> sbi_trap_error_debug: hart1: mcause=0x0000000000000005 mtval=0x0000000080046468
> sbi_trap_error_debug: hart1: mtval2=0x0000000000000000 mtinst=0x0000000000000000
> sbi_trap_error_debug: hart1: mepc=0x000000008080a8b8 mstatus=0x0000000a00000800
> sbi_trap_error_debug: hart1: ra=0x0000000080202b06 sp=0x0000000081203f00
> sbi_trap_error_debug: hart1: gp=0x00000000812d9db8 tp=0x0000000080046000
> sbi_trap_error_debug: hart1: s0=0x0000000081203f80 s1=0x0000000080c1a8a8
> sbi_trap_error_debug: hart1: a0=0x0000000080c1a8a8 a1=0x0000000080c1b0d0
> sbi_trap_error_debug: hart1: a2=0x0000000000000002 a3=0x0000000000000000
> sbi_trap_error_debug: hart1: a4=0x00000000812da902 a5=0x0000000000000000
> sbi_trap_error_debug: hart1: a6=0x0000000000000006 a7=0x0000000000000010
> sbi_trap_error_debug: hart1: s2=0x0000000080c1b0d0 s3=0x0000000000000002
> sbi_trap_error_debug: hart1: s4=0x00000000bf000000 s5=0x0000000000000000
> sbi_trap_error_debug: hart1: s6=0x8000000a00006800 s7=0x000000000000007f
> sbi_trap_error_debug: hart1: s8=0x0000000080018038 s9=0x0000000080039eac
> sbi_trap_error_debug: hart1: s10=0x0000000000000000 s11=0x0000000000000000
> sbi_trap_error_debug: hart1: t0=0x0000000080c04000 t1=0x0000000000000002
> sbi_trap_error_debug: hart1: t2=0x0000000000001000 t3=0x0000000000000010
> sbi_trap_error_debug: hart1: t4=0x00000000800168be t5=0x0000000000000027
> sbi_trap_error_debug: hart1: t6=0x0000000000000001
> 
> mepc : 0x000000008080a8b8 - call_function_init (kernel/smp.c)
> 
> Kernel - 5.17-rc2 + my patches
> Qemu - Alistairs next tree + my patches

very strange. I was testing of course with Qemu as well, though never saw
anything like this.

But of course it was Qemu master + the then still pending svpbmt patchset [0]
[looks like Alistair applied this today] + a patch that made qemu insert the
svpbmt dt-property for the virt machine.

Oh ... just to make sure, did you enable the svpbmt parameter when starting
Qemu? (-cpu ...,svpbmt=true)


Heiko

[0] http://lore.kernel.org/r/20220204022658.18097-1-liweiwei@iscas.ac.cn


> I do have some out-of-tree patches but that shouldn't be an issue as I
> am able to boot without your patches.
> Commenting the *_boot_alternatives at both the places works fine as well.
> 
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index 0e1bb97f9749..bdeb7ab3e719 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -342,7 +342,7 @@ clear_bss_done:
>         call kasan_early_init
>  #endif
>         /* Start the kernel */
> -       call apply_boot_alternatives
> +       //call apply_boot_alternatives
>         call soc_early_init
>         tail start_kernel
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 7216db5d6a2c..c6bf8f4d3d16 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -819,7 +819,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         BUG_ON((kernel_map.virt_addr + kernel_map.size) >
> ADDRESS_SPACE_END - SZ_4K);
>  #endif
> 
> -       apply_early_boot_alternatives();
> +       //apply_early_boot_alternatives();
>         pt_ops_set_early();
> 
>         /* Setup early PGD for fixmap */
> 
> I am currently debugging it and will let you know if I find the root cause.
> 
> > > changes in v6:
> > > - rebase onto 5.17-rc1
> > > - handle sbi null-ptr differently
> > > - improve commit messages
> > > - use riscv,mmu as property name
> > >
> > > changes in v5:
> > > - move to use alternatives for runtime-patching
> > > - add D1 variant
> > >
> > >
> > > [0] https://lore.kernel.org/r/20211224211632.1698523-1-atishp@rivosinc.com
> > > [1] https://lore.kernel.org/r/20220120090918.2646626-1-atishp@rivosinc.com
> > >
> > >
> > > Heiko Stuebner (12):
> > >   riscv: prevent null-pointer dereference with sbi_remote_fence_i
> > >   riscv: integrate alternatives better into the main architecture
> > >   riscv: allow different stages with alternatives
> > >   riscv: implement module alternatives
> > >   riscv: implement ALTERNATIVE_2 macro
> > >   riscv: extend concatenated alternatives-lines to the same length
> > >   riscv: prevent compressed instructions in alternatives
> > >   riscv: move boot alternatives to a slightly earlier position
> > >   riscv: Fix accessing pfn bits in PTEs for non-32bit variants
> > >   riscv: add cpufeature handling via alternatives
> > >   riscv: remove FIXMAP_PAGE_IO and fall back to its default value
> > >   riscv: add memory-type errata for T-Head
> > >
> > > Wei Fu (2):
> > >   dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
> > >   riscv: add RISC-V Svpbmt extension support
> > >
> > >  .../devicetree/bindings/riscv/cpus.yaml       |  10 ++
> > >  arch/riscv/Kconfig.erratas                    |  29 ++--
> > >  arch/riscv/Kconfig.socs                       |   1 -
> > >  arch/riscv/Makefile                           |   2 +-
> > >  arch/riscv/errata/Makefile                    |   2 +-
> > >  arch/riscv/errata/sifive/errata.c             |  10 +-
> > >  arch/riscv/errata/thead/Makefile              |   1 +
> > >  arch/riscv/errata/thead/errata.c              |  85 +++++++++++
> > >  arch/riscv/include/asm/alternative-macros.h   | 114 ++++++++-------
> > >  arch/riscv/include/asm/alternative.h          |  16 ++-
> > >  arch/riscv/include/asm/errata_list.h          |  52 +++++++
> > >  arch/riscv/include/asm/fixmap.h               |   2 -
> > >  arch/riscv/include/asm/pgtable-32.h           |  17 +++
> > >  arch/riscv/include/asm/pgtable-64.h           |  79 +++++++++-
> > >  arch/riscv/include/asm/pgtable-bits.h         |  10 --
> > >  arch/riscv/include/asm/pgtable.h              |  53 +++++--
> > >  arch/riscv/include/asm/vendorid_list.h        |   1 +
> > >  arch/riscv/kernel/Makefile                    |   1 +
> > >  arch/riscv/{errata => kernel}/alternative.c   |  48 ++++++-
> > >  arch/riscv/kernel/cpufeature.c                | 136 +++++++++++++++++-
> > >  arch/riscv/kernel/head.S                      |   2 +
> > >  arch/riscv/kernel/module.c                    |  29 ++++
> > >  arch/riscv/kernel/sbi.c                       |  10 +-
> > >  arch/riscv/kernel/smpboot.c                   |   4 -
> > >  arch/riscv/kernel/traps.c                     |   2 +-
> > >  arch/riscv/mm/init.c                          |   1 +
> > >  26 files changed, 606 insertions(+), 111 deletions(-)
> > >  create mode 100644 arch/riscv/errata/thead/Makefile
> > >  create mode 100644 arch/riscv/errata/thead/errata.c
> > >  rename arch/riscv/{errata => kernel}/alternative.c (59%)
> > >
> > > --
> > > 2.30.2
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> >
> >
> > --
> > Regards,
> > Atish
> 
> 
> 
> 




