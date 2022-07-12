Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E0571A78
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbiGLMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiGLMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:50:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0235BAE61;
        Tue, 12 Jul 2022 05:50:05 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B5A61516;
        Tue, 12 Jul 2022 05:50:05 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.157])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 255A63F70D;
        Tue, 12 Jul 2022 05:50:03 -0700 (PDT)
Date:   Tue, 12 Jul 2022 13:49:55 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Aishwarya TCV <Aishwarya.TCV@arm.com>
Subject: Re: FVP: kernel BUG at arch/arm64/kernel/traps.c:497 - Internal
 error: Oops - BUG: 0
Message-ID: <Ys1t8win0pVPPuig@FVFF77S0Q05N.cambridge.arm.com>
References: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtOX-6=f70FA5PuDVA=kX=2L4spXKXS8=LHkUphafXowg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 03:27:09PM +0530, Naresh Kamboju wrote:
> FVP boot failed with linux next 20220712.

FWIW, I just grabbed your Image from:

 https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/

...  and it boots perfectly fine under:

* An FVP Base RevC model using the latest boot-wrapper
* a QEMU KVM VM on a ThunderX2 host.
* a QEMU TCG VM on a ThunderX2 host (with -cpu max).

What firmware are you using in your FVP? How are you loading the kernel?

> Reported-by:  Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> 
> Boot log:
> Starting kernel ...
> 
> [    0.000000] Booting Linux on physical CPU 0x0000000000 [0x410fd0f0]
> [    0.000000] Linux version 5.19.0-rc6-next-20220711
> (tuxmake@tuxmake) (aarch64-linux-gnu-gcc (Debian 11.3.0-3) 11.3.0, GNU
> ld (GNU Binutils for Debian) 2.38) #1 SMP PREEMPT @1657539508
> [    0.000000] Machine model: FVP Base RevC
> [    0.000000] earlycon: pl11 at MMIO 0x000000001c090000 (options '')
> [    0.000000] printk: bootconsole [pl11] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Reserved memory: created DMA memory pool at
> 0x0000000018000000, size 8 MiB
> [    0.000000] OF: reserved mem: initialized node vram@18000000,
> compatible id shared-dma-pool
> [    0.000000] NUMA: No NUMA configuration found
> [    0.000000] NUMA: Faking a node at [mem
> 0x0000000080000000-0x00000008ffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x8ff7f6b40-0x8ff7f8fff]
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000100000000-0x00000008ffffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
> [    0.000000]   node   0: [mem 0x0000000880000000-0x00000008ffffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000008ffffffff]
> [    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
> [    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
> [    0.000000] psci: probing for conduit method from DT.
> [    0.000000] psci: PSCIv1.1 detected in firmware.
> [    0.000000] psci: Using standard PSCI v0.2 function IDs
> [    0.000000] psci: MIGRATE_INFO_TYPE not supported.
> [    0.000000] psci: SMC Calling Convention v1.2
> [    0.000000] percpu: Embedded 30 pages/cpu s82856 r8192 d31832 u122880
> [    0.000000] pcpu-alloc: s82856 r8192 d31832 u122880 alloc=30*4096
> [    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5 [0] 6 [0] 7
> [    0.000000] Detected PIPT I-cache on CPU0
> [    0.000000] CPU features: detected: Branch Target Identification
> [    0.000000] CPU features: detected: Address authentication (IMP DEF
> algorithm)
> [    0.000000] CPU features: detected: GIC system register CPU interface
> [    0.000000] CPU features: detected: Virtualization Host Extensions
> [    0.000000] CPU features: detected: Hardware dirty bit management
> [    0.000000] CPU features: detected: Spectre-v4
> [    0.000000] alternatives: patching kernel code
> [    0.000000] Fallback order for Node 0: 0
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 1028096
> [    0.000000] Policy zone: Normal
> [    0.000000] Kernel command line: console=ttyAMA0
> earlycon=pl011,0x1c090000 root=/dev/vda rw ip=dhcp debug user_debug=31
> loglevel=9
> [    0.000000] Unknown kernel command line parameters
> \"user_debug=31\", will be passed to user space.
> [    0.000000] Dentry cache hash table entries: 524288 (order: 10,
> 4194304 bytes, linear)
> [    0.000000] Inode-cache hash table entries: 262144 (order: 9,
> 2097152 bytes, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] software IO TLB: mapped [mem
> 0x00000000f9000000-0x00000000fd000000] (64MB)
> [    0.000000] Memory: 3947088K/4177920K available (20288K kernel
> code, 4902K rwdata, 11308K rodata, 11136K init, 955K bss, 198064K
> reserved, 32768K cma-reserved)
> [    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=8, Nodes=1
> [    0.000000] ftrace: allocating 65660 entries in 257 pages
> [    0.000000] ------------[ ftrace bug ]------------
> [    0.000000] ftrace failed to modify
> [    0.000000] [<ffff800009f80030>] udpv6_init+0x8/0x74
> [    0.000000]  actual:   00:00:00:00
> [    0.000000] Initializing ftrace call sites
> [    0.000000] ftrace record flags: 0
> [    0.000000]  (0)
> [    0.000000]  expected tramp: ffff80000802f3a8
> [    0.000000] ------------[ cut here ]------------

This looks bad. IIUC that "actual" line tells us that the instruction we wanted
to modify consisted of zeroes, and was not a NOP as it should have been.

So perhaps the kernel has not been fully loaded into memory, or has been
corrupted somehow after loading. That could explain the subsequent failure, too.

[...]

> [    0.500613] ------------[ cut here ]------------
> [    0.500709] kernel BUG at arch/arm64/kernel/traps.c:497!
> [    0.500777] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [    0.500860] Modules linked in:
> [    0.500947] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W
>    5.19.0-rc6-next-20220711 #1
> [    0.501034] Hardware name: FVP Base RevC (DT)
> [    0.501109] pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    0.501209] pc : do_undefinstr+0x284/0x2b4
> [    0.501381] lr : do_undefinstr+0x150/0x2b4
> [    0.501509] sp : ffff80000affbbc0
> [    0.501509] x29: ffff80000affbbc0 x28: ffff000800330000 x27: ffff800009f00444
> [    0.501759] x26: ffff800009fe6038 x25: 0000000000000001 x24: ffff80000a115968
> [    0.501923] x23: 0000000040400009 x22: ffff800009f80de0 x21: ffff80000affbd90
> [    0.502109] x20: 0000000001000000 x19: ffff80000affbc40 x18: ffffffffffffffff
> [    0.502309] x17: 000000000000003f x16: 000000000000000a x15: ffff0008002b1a1c
> [    0.502422] x14: ffffffffffffffff x13: ffff0008002b1268 x12: 20726f20746e6573
> [    0.502683] x11: ffff80000aa12950 x10: 0000000000000073 x9 : ffff8000093bcd6c
> [    0.502856] x8 : 000000003d4d554e x7 : ffff80000affbce0 x6 : 0000000000000001
> [    0.503030] x5 : ffff80000a9ef000 x4 : ffff80000a9ef2e0 x3 : 0000000000000000
> [    0.503234] x2 : ffff000800330000 x1 : ffff000800330000 x0 : 0000000040400009
> [    0.503409] Call trace:
> [    0.503480]  do_undefinstr+0x284/0x2b4
> [    0.503562]  el1_undef+0x30/0x60
> [    0.503709]  el1h_64_sync_handler+0x84/0xd0
> [    0.503811]  el1h_64_sync+0x64/0x68
> [    0.503909]  net_sysctl_init+0x8/0x7c
> [    0.504053]  do_one_initcall+0x50/0x2b0
> [    0.504158]  kernel_init_freeable+0x24c/0x2d4
> [    0.504245]  kernel_init+0x30/0x140
> [    0.504381]  ret_from_fork+0x10/0x20
> [    0.504509] Code: 17ffff98 a9425bf5 17ffffbb a9025bf5 (d4210000)
> [    0.504627] ---[ end trace 0000000000000000 ]---

We should really improve this WARN to something that tells us about the actual
failing instruction.

Thanks.
Mark.

> Build:
> https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20220711/testrun/10743317/suite/log-parser-test/tests/
> 
> https://builds.tuxbuild.com/2BnQMpJj3kDTJXoCwd2pY5gW9CN/
> 
> Best regards
> Naresh Kamboju
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
