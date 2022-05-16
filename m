Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04BF527D79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240243AbiEPGQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiEPGQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:16:37 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BCF220E0
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:16:35 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2f7c57ee6feso141745337b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lQUWkLFvRiKIrF+HSZSqiwkv57dZkIgmk32WeQyOUX8=;
        b=CIZFB6HJ6q3cj2sK4GTb4QNxqkVDKajg+jk3NVpUIgj6Yc/2bGqXxlnOA5sr5gMu4g
         894NISM0OWmzwgOE7DZtYWcbKDSQoIetDaBUQ/0Ls92jmchLF/xhFehTSap/FUmFoXlF
         YjVu65mTTs4/vrlQrXDfWFN06Hk5WhtXtV/rXAZTgjynk09EzT85qUPVDYpFhEOIHvkL
         c/05gKAI75MQhfPNH0mdXDv1f0NNCIUVh+gc+R3SpqrTd79oS/5XKWoQLsvXWfXnOsUR
         2mPUwNcM8qszytVbVmyPuYg9imtv5mlLP8ic8ah+XJY9v6no3n3fQaIAg6jzHQpO/rSH
         tYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lQUWkLFvRiKIrF+HSZSqiwkv57dZkIgmk32WeQyOUX8=;
        b=NwSO33uwLId/DWEnrGmwxUeGMD5Zv/+IsqT+vaA18M9xIP73FBGJjrH5fJWeQ5oZ82
         HI/NGwG044bU8v0Ew1MNPElE4YrxK1MiifJkIgRBBUFGF1WkPoytIQiiD18YZa7wvugl
         Cn9die/BV3QOaDwd82NVyVpb21jXZR/67qdBbV6eqrlbf0UEmzxJOWsTWrIOw7O7l9Te
         6zcTXPGrjlFKtDxdlFGOojFqhN3R7/Vl6MhMXwWloggCof4KjPzL48BkEUsKQOs1V+AO
         JeLBdb0gxXjDuhtjTHJc2orLN1JBZN+zsB1aitNpWziZm8KzrYIzMLEQpAiTUmEZTxst
         VT0w==
X-Gm-Message-State: AOAM533jM5WZCz/KkB4yBEG4VGxuRiRcaWrpNgJpbr1xlOjqWtem/xxr
        5QvZWnVYoHeqrwgbqHney+pNB/Y3vCKo2GwOERLMf15KBd6OQA==
X-Google-Smtp-Source: ABdhPJw2GR6ze8aFANCNNgqvTuLB4QMho8Ehur0Zr3iImo4CEJj1Y274SXiMjDNCWZTrnPkeqJVJWVNL3pD7kNwly2c=
X-Received: by 2002:a81:3ac2:0:b0:2f7:f777:a43 with SMTP id
 h185-20020a813ac2000000b002f7f7770a43mr18442921ywa.60.1652681793588; Sun, 15
 May 2022 23:16:33 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 16 May 2022 11:46:22 +0530
Message-ID: <CA+G9fYtsp-1pi6d4J71BPYh-msjzbVt_-v3YrUu12dXPeyqTDg@mail.gmail.com>
Subject: Unexpected kernel BRK exception at EL1 - Internal error: BRK handler:
 f20003e8 - gic_dist_config
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>, pali@kernel.org,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel crash reported on arm64 juno-r2 device with kselftest-merge config
while booting Linux next-20220513 kernel  [1].

[    0.000000] Booting Linux on physical CPU 0x0000000100 [0x410fd033]
[    0.000000] Linux version 5.18.0-rc6-next-20220513
(oe-user@oe-host) (aarch64-linaro-linux-gcc (GCC) 7.3.0, GNU ld (GNU
Binutils) 2.30.0.20180208) #1 SMP PREEMPT Fri May 13 08:34:42 UTC 2022
[    0.000000] Machine model: ARM Juno development board (r2)
[    0.000000] earlycon: pl11 at MMIO 0x000000007ff80000 (options '')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found
[    0.000000] NUMA: Faking a node at [mem
0x0000000080000000-0x00000009ffffffff]
[    0.000000] NUMA: NODE_DATA [mem 0x9fefce600-0x9fefd0fff]
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000080000000-0x00000000ffffffff]
[    0.000000]   DMA32    empty
[    0.000000]   Normal   [mem 0x0000000100000000-0x00000009ffffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000080000000-0x00000000feffffff]
[    0.000000]   node   0: [mem 0x0000000880000000-0x00000009ffffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000080000000-0x00000009ffffffff]
[    0.000000] On node 0, zone Normal: 4096 pages in unavailable ranges
[    0.000000] cma: Reserved 32 MiB at 0x00000000fd000000
[    0.000000] psci: probing for conduit method from DT.
[    0.000000] psci: PSCIv1.1 detected in firmware.
[    0.000000] psci: Using standard PSCI v0.2 function IDs
[    0.000000] psci: Trusted OS migration not required
[    0.000000] psci: SMC Calling Convention v1.0
[    0.000000] percpu: Embedded 31 pages/cpu s89632 r8192 d29152 u126976
[    0.000000] pcpu-alloc: s89632 r8192 d29152 u126976 alloc=31*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 [0] 4 [0] 5
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: detected: ARM erratum 843419
[    0.000000] CPU features: detected: ARM erratum 845719
[    0.000000] Fallback order for Node 0: 0
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 2060288
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: console=ttyAMA0,115200n8
root=/dev/nfs rw
nfsroot=10.66.16.125:/var/lib/lava/dispatcher/tmp/5021955/extract-nfsrootfs-23zdukp_,tcp,hard,vers=3
rootwait earlycon=pl011,0x7ff80000 debug systemd.log_target=null
user_debug=31 androidboot.hardware=juno loglevel=9
sky2.mac_address=0x00,0x02,0xF7,0x00,0x68,0x3F ip=dhcp
[    0.000000] Unknown kernel command line parameters
\"user_debug=31\", will be passed to user space.
[    0.000000] Dentry cache hash table entries: 1048576 (order: 11,
8388608 bytes, linear)
[    0.000000] Inode-cache hash table entries: 524288 (order: 10,
4194304 bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:on, heap free:off
[    0.000000] Stack Depot early init allocating hash table with
memblock_alloc, 8388608 bytes
[    0.000000] software IO TLB: mapped [mem
0x00000000f9000000-0x00000000fd000000] (64MB)
[    0.000000] Memory: 8038640K/8372224K available (22784K kernel
code, 5468K rwdata, 11824K rodata, 11520K init, 11734K bss, 300816K
reserved, 32768K cma-reserved)
[    0.000000] **********************************************************
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **                                                      **
[    0.000000] ** This system shows unhashed kernel memory addresses   **
[    0.000000] ** via the console, logs, and other interfaces. This    **
[    0.000000] ** might reduce the security of your system.            **
[    0.000000] **                                                      **
[    0.000000] ** If you see this message and you are not debugging    **
[    0.000000] ** the kernel, report this immediately to your system   **
[    0.000000] ** administrator!                                       **
[    0.000000] **                                                      **
[    0.000000] **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
[    0.000000] **********************************************************
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=6, Nodes=1
[    0.000000] ftrace: allocating 69398 entries in 272 pages
[    0.000000] ftrace: allocated 272 pages with 2 groups
[    0.000000] trace event string verifier disabled
[    0.000000] Running RCU self tests
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000] rcu: RCU event tracing is enabled.
[    0.000000] rcu: RCU lockdep checking is enabled.
[    0.000000] rcu: RCU restricting CPUs from NR_CPUS=256 to nr_cpu_ids=6.
[    0.000000] Trampoline variant of Tasks RCU enabled.
[    0.000000] Rude variant of Tasks RCU enabled.
[    0.000000] Tracing variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 25 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=6
[    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
[    0.000000] Root IRQ handler: gic_handle_irq
[    0.000000] GIC: Using split EOI/Deactivate mode
[    0.000000] Unexpected kernel BRK exception at EL1
[    0.000000] Internal error: BRK handler: f20003e8 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
5.18.0-rc6-next-20220513 #1
[    0.000000] Hardware name: ARM Juno development board (r2) (DT)
[    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : gic_dist_config+0x4c/0x68
[    0.000000] lr : gic_init_bases+0xd4/0x248
[    0.000000] sp : ffff80000ad33b90
[    0.000000] x29: ffff80000ad33b90 x28: ffff80000a2dd8d8 x27: ffff80000ad442d0
[    0.000000] x26: dead000000000100 x25: ffff00097efdeb10 x24: 0000000000000000
[    0.000000] x23: ffff80000a0ef000 x22: ffff80000a0ef000 x21: 0000000000000000
[    0.000000] x20: ffff800008005000 x19: 0000000000000180 x18: 0000000000000000
[    0.000000] x17: ffff80000a2237c4 x16: ffff80000a223210 x15: ffff8000087f8fa0
[    0.000000] x14: ffff80000815dfdc x13: ffff80000a1f03ec x12: 000000000004ff45
[    0.000000] x11: ffff80000b33e680 x10: 0000000000000032 x9 : ffff80000b29b7b0
[    0.000000] x8 : ffff80000bcfb24c x7 : 00000000ffffffff x6 : ffff80000ad44244
[    0.000000] x5 : ffff80000ad4d100 x4 : ffff80000ade3508 x3 : 0000000004040404
[    0.000000] x2 : 0000000000000180 x1 : 0000000000000180 x0 : ffff800008005c5c
[    0.000000] Call trace:
[    0.000000]  gic_dist_config+0x4c/0x68
[    0.000000]  gic_init_bases+0xd4/0x248
[    0.000000]  __gic_init_bases+0xac/0x16c
[    0.000000]  gic_of_init+0x28c/0x380
[    0.000000]  of_irq_init+0x208/0x3f8
[    0.000000]  irqchip_init+0x1c/0x40
[    0.000000]  init_IRQ+0xf0/0x108
[    0.000000]  start_kernel+0x53c/0x740
[    0.000000]  __primary_switched+0xc0/0xc8
[    0.000000] Code: b900001f 11004042 6b02027f 54ffff48 (d4207d00)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 1e1b28b936aed946122b4e0991e7144fdbbfd77e
  git describe: next-20220513
  make_kernelversion: 5.18.0-rc6
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/juno/lkft/linux-next/1226/config
  build-location:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/juno/lkft/linux-next/1226
  toolchain: aarch64-linaro-linux 7.%


--
Linaro LKFT
https://lkft.linaro.org

[1] https://lkft.validation.linaro.org/scheduler/job/5021955#L931
