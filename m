Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8371A4D51D9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 20:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbiCJTR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 14:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239336AbiCJTR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 14:17:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC3A15AF3E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:16:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB18060F6B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:16:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C92C340E8;
        Thu, 10 Mar 2022 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646939815;
        bh=98BAjpDiS+f2yyd2llp2H9fAlMk4kAmKnIuHf/iQiIE=;
        h=Date:From:To:Cc:Subject:From;
        b=ltuGhYwGrHmQ4/SbpQCjde+9HFEtPRQcvBoWa/6qGrHJA3GnlXFFrUwWPjaV7Zgge
         VCIllPabGBZmYOwEOzkmoBLIE4tEb0bRhTbMEmPPZ3mF6b1bg8S/qzdqitJ41LAIqm
         wp6khX8bmr1v33FZMGmFOTFvrSdoVCfgDqoXFmQ2uaS7yVqenfUi88w7PY0y7uJr+v
         vF5I7IIBUvJEY2+ZI6NUbiSXEfpzk+DdO3HmU+cMTEj4Ko2wMVKVsBp2hOicW5qbUd
         HawRm7Y1GL1sj9UlPLYuAaEi3vJ3x3LPy3Ol31W2fRgXa6p7H4HRg4MR1sgZut3B1z
         pzqGe0LLOcIQg==
Date:   Thu, 10 Mar 2022 12:16:48 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: CONFIG_THUMB2_KERNEL=y boot failure after Spectre BHB fixes
Message-ID: <YipOoAaBIHjeCKOq@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="JBR58G1UIffudVF/"
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JBR58G1UIffudVF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

Apologies if this has already been reported, I did not see anything when
sifting through lore.kernel.org and I can still reproduce this with
current mainline (1db333d9a51f).

I noticed a QEMU boot failure with multi_v7_defconfig with
CONFIG_THUMB2_KERNEL=y in our continuous integration [1]. It does not
appear to be compiler specific, as it reproduces with a bunch of
different clang versions and GCC 11.2.0 (I didn't try other GCC
versions).

At commit 04e91b732476 ("ARM: early traps initialisation"), everything
boots fine.

At commit 8d9d651ff227 ("ARM: use LOADADDR() to get load address of
sections"), there is no output from QEMU at all.

At commit b9baf5c8c5c3 ("ARM: Spectre-BHB workaround"), there is some
output but the boot still hangs before init. I have included a log of
the output of QEMU at this revision along with the command line I am
using, which comes from [2]. If I disable CONFIG_HARDEN_BRANCH_HISTORY,
the kernel boots.

If there is any further information I can provide or patches I can try,
I am happy to do so.

[1]: https://github.com/ClangBuiltLinux/continuous-integration2/runs/5496036256?check_suite_focus=true
[2]: https://github.com/ClangBuiltLinux/boot-utils

Cheers,
Nathan

--JBR58G1UIffudVF/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="boot.log"

+ timeout --foreground 1m stdbuf -oL -eL qemu-system-arm -initrd /home/nathan/cbl/github/boot-utils-ro/images/arm/rootfs.cpio -append 'console=ttyAMA0 earlycon' -machine virt -no-reboot -display none -kernel /home/nathan/cbl/src/linux/arch/arm/boot/zImage -m 512m -nodefaults -serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.16.0-00004-gb9baf5c8c5c3 (nathan@dev-arch.thelio-3990X) (arm-none-eabi-gcc (Arch Repository) 11.2.0, GNU ld (GNU Binutils) 2.37) #1 SMP Thu Mar 10 12:03:57 MST 2022
[    0.000000] CPU: ARMv7 Processor [412fc0f1] revision 1 (ARMv7), cr=50c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt: Machine model: linux,dummy-virt
[    0.000000] earlycon: pl11 at MMIO 0x09000000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 64 MiB at 0x5c000000
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000]   Normal   empty
[    0.000000]   HighMem  empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 16 pages/cpu s33996 r8192 d23348 u65536
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=ttyAMA0 earlycon
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 428336K/524288K available (10240K kernel code, 2268K rwdata, 5524K rodata, 2048K init, 392K bss, 30416K reserved, 65536K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] trace event string verifier disabled
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu: 	RCU event tracing is enabled.
[    0.000000] rcu: 	RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] GICv2m: range[mem 0x08020000-0x08020fff], SPI[80:143]
[    0.000000] random: get_random_bytes called from _etext+0x600c95/0x67d464 with crng_init=0
[    0.000000] arch_timer: cp15 timer(s) running at 62.50MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
[    0.000114] sched_clock: 57 bits at 62MHz, resolution 16ns, wraps every 4398046511096ns
[    0.000363] Switching to timer-based delay loop, resolution 16ns
[    0.002953] Console: colour dummy device 80x30
[    0.004065] Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
[    0.004331] pid_max: default: 32768 minimum: 301
[    0.005091] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.005239] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
qemu-system-arm: terminating on signal 15 from pid 511549 (timeout)
+ RET=124
+ set +x

--JBR58G1UIffudVF/--
