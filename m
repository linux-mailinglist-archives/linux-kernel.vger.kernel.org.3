Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140CC58F336
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 21:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiHJTcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 15:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiHJTcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 15:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48FA785AA;
        Wed, 10 Aug 2022 12:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D5FE614B2;
        Wed, 10 Aug 2022 19:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD462C433C1;
        Wed, 10 Aug 2022 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660159926;
        bh=6MtJuCtUFZq1GAHDSmLciN7MdEZd7ZF1+k7S2LDrnCU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HsHU0ob0rnlGknBTPIUo5nUuEqTW/g1OKb8+0GpezR6OGXZ7cB2HaQCZpDWqWThb0
         DM+ng05W0G1cglAUvm8zxUJZKcdZ9cAUrq9mfsxnam/AcJzkd2+dY7P6tNSuhWRxbx
         UYPM8uEkBKqO80EWApMEN9WdDB9klIgC0GVDmxiX9i6wxWXXArVif8w2Fl5wVtszun
         201GVIPes7lFSxTaRp4HIqzjiDIudlhml0hWPqMRZRQHf+cRHdhHjfNIikSErzuzZP
         giNMfSiiNVnytLKYycVyTuQVCSMY1lpaa/RyV/lwkNat+1clfrX5nINO9vUUw+KWzA
         AydD0RW5c7Njw==
Date:   Wed, 10 Aug 2022 12:32:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     ndesaulniers@google.com, llvm@lists.linux.dev,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Daire.McNamara@microchip.com, palmer@dabbelt.com
Subject: Re: [PATCH v2 00/12] PolarFire SoC reset controller & clock cleanups
Message-ID: <YvQHtGObJwyBKGCQ@dev-arch.thelio-3990X>
References: <20220704121558.2088698-1-conor.dooley@microchip.com>
 <bd14f1a2-750d-2511-df0a-85a9f5925f84@microchip.com>
 <YvP/bjh+wXihlrdG@dev-arch.thelio-3990X>
 <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc470bf4-33bb-d67b-3860-3ac775982f27@microchip.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 07:20:24PM +0000, Conor.Dooley@microchip.com wrote:
> On 10/08/2022 19:56, Nathan Chancellor wrote:
> > Hi Conor,
> > 
> > On Tue, Aug 09, 2022 at 11:05:32PM +0000, Conor.Dooley@microchip.com wrote:
> >> +CC clang people :)
> >>
> >> Got an odd one here and would appreciate some pointers for where to
> >> look. This code when built with gcc boots fine, for example with:
> >> riscv64-unknown-linux-gnu-gcc (g5964b5cd727) 11.1.0
> >> The same code but build with clang build it fails to boot but prior to
> >> that applying this patchset it boots fine. Specifically it is the patch
> >> "clk: microchip: mpfs: move id & offset out of clock structs"
> >>
> >> I applied this patchset on top of tonight's master (15205c2829ca) but
> >> I've been seeing the same problem for a few weeks on -next too. I tried
> >> the following 2 versions of clang/llvm:
> >> ClangBuiltLinux clang version 15.0.0 (5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa), LLD 15.0.0
> >> ClangBuiltLinux clang version 15.0.0 (bab8af8ea062f6332b5c5d13ae688bb8900f244a), LLD 15.0.0
> > 
> > Good to know that it reproduces with fairly recent versions of LLVM :)
> > 
> >> It's probably something silly that I've overlooked but I am not au
> >> fait with these sort of things unfortunately, but hey - at least I'll
> >> learn something then.
> > 
> > I took a quick glance at the patch you mentioned above and I don't
> > immediately see anything as problematic...
> 
> Yeah, I couldn't see any low hanging fruit either.
> 
> > I was going to see if I could
> > reproduce this locally in QEMU since I do see there is a machine
> > 'microchip-icicle-kit' but I am not having much success getting the
> > machine past SBI. Does this reproduce in QEMU or are you working with
> > the real hardware? If QEMU, do you happen to have a working invocation
> > handy?
> 
> Yeah... So there was a QEMU incantation that worked at some point in
> the past (ie when someone wrote the QEMU port) but most peripherals
> are not implemented and current versions of our openSBI implementation
> requires more than one of the unimplemented peripherals. I was trying to
> get it working lately in the evenings based on some patches that were a
> year old but no joy :/

Heh, I guess that would explain why it wasn't working for me :)

> I'm running on the real hardware, I'll give the older combo of qemu
> "bios" etc a go again over the weekend & try to get it working. In the
> meantime, any suggestions?

Are you building with 'LLVM=1' or just 'CC=clang'? If 'LLVM=1', I would
try breaking it apart into the individual options (LD=ld.lld,
OBJCOPY=llvm-objcopy) and see if dropping one of those makes a
difference. We have had subtle differences between the GNU and LLVM
tools before and it is much easier to look into that difference if we
know it happens in only one tool.

Otherwise, I am not sure I have any immediate ideas other than looking
at the disassembly and trying to see if something is going wrong. Is
the object file being modified in any other way (I don't think there is
something like objtool for RISC-V but I could be wrong)?

Cheers,
Nathan

> >> The boot log is fairly short so here ya go:
> >>
> >> [    0.000000] Linux version 5.19.0-13253-g374b508ee318 (conor@spud) (ClangBuiltLinux clang version 15.0.0 (git@g
> >> ithub.com:llvm/llvm-project.git 5b0788fef86ed7008a11f6ee19b9d86d42b6fcfa), LLD 15.0.0) #1 SMP Tue Aug 9 22:42:10 IST 
> >> 2022
> >> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> >> [    0.000000] Machine model: Microchip PolarFire-SoC Icicle Kit
> >> [    0.000000] earlycon: ns16550a0 at MMIO32 0x0000000020100000 (options '115200n8')
> >> [    0.000000] printk: bootconsole [ns16550a0] enabled
> >> [    0.000000] efi: UEFI not found.
> >> [    0.000000] Zone ranges:
> >> [    0.000000]   DMA32    [mem 0x0000000080200000-0x00000000ffffffff]
> >> [    0.000000]   Normal   [mem 0x0000000100000000-0x000000103fffffff]
> >> [    0.000000] Movable zone start for each node
> >> [    0.000000] Early memory node ranges
> >> [    0.000000]   node   0: [mem 0x0000000080200000-0x00000000adffffff]
> >> [    0.000000]   node   0: [mem 0x0000001000000000-0x000000103fffffff]
> >> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x000000103fffffff]
> >> [    0.000000] On node 0, zone Normal: 16064512 pages in unavailable ranges
> >> [    0.000000] SBI specification v0.3 detected
> >> [    0.000000] SBI implementation ID=0x1 Version=0x9
> >> [    0.000000] SBI TIME extension detected
> >> [    0.000000] SBI IPI extension detected
> >> [    0.000000] SBI RFENCE extension detected
> >> [    0.000000] SBI HSM extension detected
> >> [    0.000000] CPU with hartid=0 is not available
> >> [    0.000000] CPU with hartid=0 is not available
> >> [    0.000000] riscv: base ISA extensions acdfim
> >> [    0.000000] riscv: ELF capabilities acdfim
> >> [    0.000000] percpu: Embedded 18 pages/cpu s34168 r8192 d31368 u73728
> >> [    0.000000] pcpu-alloc: s34168 r8192 d31368 u73728 alloc=18*4096
> >> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
> >> [    0.000000] CPU node for /cpus/cpu@0 exist but the possible cpu range is :0-3
> >> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 224263
> >> [    0.000000] Kernel command line: root=/dev/nfs ip=dhcp debug nfsroot=192.168.2.5:/stuff/nfs_share earlycon
> >> [    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
> >> [    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> >> [    0.000000] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
> >> [    0.000000] software IO TLB: area num 4.
> >> [    0.000000] software IO TLB: mapped [mem 0x00000000aa000000-0x00000000ae000000] (64MB)
> >> [    0.000000] Virtual kernel memory layout:
> >> [    0.000000]       fixmap : 0xffffffc6fee00000 - 0xffffffc6ff000000   (2048 kB)
> >> [    0.000000]       pci io : 0xffffffc6ff000000 - 0xffffffc700000000   (  16 MB)
> >> [    0.000000]      vmemmap : 0xffffffc700000000 - 0xffffffc800000000   (4096 MB)
> >> [    0.000000]      vmalloc : 0xffffffc800000000 - 0xffffffd800000000   (  64 GB)
> >> [    0.000000]       lowmem : 0xffffffd800000000 - 0xffffffe7bfe00000   (  62 GB)
> >> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (2047 MB)
> >> [    0.000000] Memory: 803032K/1800192K available (7485K kernel code, 2858K rwdata, 4096K rodata, 2181K init, 394K bss, 997160K reserved, 0K cma-reserved)
> >> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
> >> [    0.000000] rcu: Hierarchical RCU implementation.
> >> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
> >> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> >> [    0.000000]  Tracing variant of Tasks RCU enabled.
> >> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
> >> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
> >> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> >> [    0.000000] CPU with hartid=0 is not available
> >> [    0.000000] riscv-intc: unable to find hart id for /cpus/cpu@0/interrupt-controller
> >> [    0.000000] riscv-intc: 64 local interrupts mapped
> >> [    0.000000] plic: interrupt-controller@c000000: mapped 186 interrupts with 4 handlers for 9 contexts.
> >> [    0.000000] rcu: srcu_init: Setting srcu_struct sizes based on contention.
> >> [    0.000000] riscv_timer_init_dt: Registering clocksource cpuid [0] hartid [4]
> >> [    0.000000] clocksource: riscv_clocksource: mask: 0xffffffffffffffff max_cycles: 0x1d854df40, max_idle_ns: 3526361616960 ns
> >> [    0.000003] sched_clock: 64 bits at 1000kHz, resolution 1000ns, wraps every 2199023255500ns
> >> [    0.009713] Console: colour dummy device 80x25
> >> [    0.014676] printk: console [tty0] enabled
> >> [    0.019217] printk: bootconsole [ns16550a0] disabled
> >>
> >> FWIW this is right about when the clock driver gets loaded
> >> as you might imagine.
> >>
> >> My config is here, but it's been reproduced on a few different
> >> defconfigs:
> >> https://raw.githubusercontent.com/ConchuOD/polarfire-soc-buildroot-sdk/dev/conf/lowmem/defconfig
> >>
> >> On 04/07/2022 13:15, Conor Dooley wrote:
> >>> Hey all,
> >>> I know I have not sat on the RFC I sent about the aux. bus parts
> >>> for too long, but figured I'd just send the whole thing anyway to all
> >>> lists etc.
> >>>
> >>> Kinda two things happening in this series, but I sent it together to
> >>> ensure the second part would apply correctly.
> >>>
> >>> The first is the reset controller that I promised after discovering the
> >>> issue triggered by CONFIG_PM & the phy not coming up correctly. I have
> >>> now removed all the messing with resets from clock enable/disable
> >>> functions & now use the aux bus to set up a reset controller driver.
> >>> Since I needed something to test it, I hooked up the reset for the
> >>> Cadence MACB on PolarFire SoC. This has been split into a second series
> >>> for v2:
> >>> https://lore.kernel.org/all/20220704114511.1892332-1-conor.dooley@microchip.com/
> >>>
> >>> The second part adds rate control for the MSS PLL clock, followed by
> >>> some simplifications to the driver & conversions of some custom structs
> >>> to the corresponding structs in the framework.
> >>>
> >>> Thanks,
> >>> Conor.
> >>>
> >>> Changes since v1:
> >>> - split off the net patches
> >>> - clk: actually pass the spinlock to the converted dividers & gates
> >>> - reset: added a spinlock around RMW access to registers
> >>> - reset: switched to BIT(i) macros
> >>> - reset: used local copies of some variables as pointed out by Philipp
> >>> - reset: dropped the success printout
> >>>
> >>> Conor Dooley (12):
> >>>   dt-bindings: clk: microchip: mpfs: add reset controller support
> >>>   clk: microchip: mpfs: add reset controller
> >>>   reset: add polarfire soc reset support
> >>>   MAINTAINERS: add polarfire soc reset controller
> >>>   riscv: dts: microchip: add mpfs specific macb reset support
> >>>   clk: microchip: mpfs: add module_authors entries
> >>>   clk: microchip: mpfs: add MSS pll's set & round rate
> >>>   clk: microchip: mpfs: move id & offset out of clock structs
> >>>   clk: microchip: mpfs: simplify control reg access
> >>>   clk: microchip: mpfs: delete 2 line mpfs_clk_register_foo()
> >>>   clk: microchip: mpfs: convert cfg_clk to clk_divider
> >>>   clk: microchip: mpfs: convert periph_clk to clk_gate
> >>>
> >>>  .../bindings/clock/microchip,mpfs.yaml        |  17 +-
> >>>  MAINTAINERS                                   |   1 +
> >>>  arch/riscv/boot/dts/microchip/mpfs.dtsi       |   7 +-
> >>>  drivers/clk/microchip/Kconfig                 |   1 +
> >>>  drivers/clk/microchip/clk-mpfs.c              | 379 +++++++++---------
> >>>  drivers/reset/Kconfig                         |   7 +
> >>>  drivers/reset/Makefile                        |   2 +-
> >>>  drivers/reset/reset-mpfs.c                    | 157 ++++++++
> >>>  include/soc/microchip/mpfs.h                  |   8 +
> >>>  9 files changed, 386 insertions(+), 193 deletions(-)
> >>>  create mode 100644 drivers/reset/reset-mpfs.c
> >>>
> >>>
> >>> base-commit: b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3
