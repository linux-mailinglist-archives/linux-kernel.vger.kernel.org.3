Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE36592EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiHOMNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiHOMMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:12:55 -0400
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 05:12:54 PDT
Received: from mail.wantstofly.org (hmm.wantstofly.org [213.239.204.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0724BEC
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:12:54 -0700 (PDT)
Received: by mail.wantstofly.org (Postfix, from userid 1000)
        id 137D07F527; Mon, 15 Aug 2022 15:05:09 +0300 (EEST)
Date:   Mon, 15 Aug 2022 15:05:09 +0300
From:   Lennert Buytenhek <buytenh@wantstofly.org>
To:     Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sashal@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        linux-kernel@vger.kernel.org,
        Scarlett Gourley <scarlett@arista.com>,
        James Sewart <jamessewart@arista.com>,
        Jack O'Sullivan <jack@arista.com>
Subject: lockdep splat due to klist iteration from atomic context in Intel
 IOMMU driver
Message-ID: <Yvo2dfpEh/WC+Wrr@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a build of 7ebfc85e2cd7 ("Merge tag 'net-6.0-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net"), with
CONFIG_INTEL_IOMMU_DEBUGFS enabled, I am seeing the lockdep splat
below when an I/O page fault occurs on a machine with an Intel
IOMMU in it.

The issue seems to be the klist iterator functions using
spin_*lock_irq*() but the klist insertion functions using
spin_*lock(), combined with the Intel DMAR IOMMU driver iterating
over klists from atomic (hardirq) context as of commit 8ac0b64b9735
("iommu/vt-d: Use pci_get_domain_bus_and_slot() in pgtable_walk()")
when CONFIG_INTEL_IOMMU_DEBUGFS is enabled, where
pci_get_domain_bus_and_slot() calls into bus_find_device() which
iterates over klists.

I found this commit from 2018:

	commit 624fa7790f80575a4ec28fbdb2034097dc18d051
	Author: Bart Van Assche <bvanassche@acm.org>
	Date:   Fri Jun 22 14:54:49 2018 -0700

	    scsi: klist: Make it safe to use klists in atomic context

This commit switched lib/klist.c:klist_{prev,next} from
spin_{,un}lock() to spin_{lock_irqsave,unlock_irqrestore}(), but left
the spin_{,un}lock() calls in add_{head,tail}() untouched.

The simplest fix for this would be to switch lib/klist.c:add_{head,tail}()
over to use the IRQ-safe spinlock variants as well?



[   32.283545] DMAR: DRHD: handling fault status reg 3
[   32.288571] DMAR: [DMA Write NO_PASID] Request device [00:1a.0] fault addr 0x0 [fault reason 0x05] PTE Write access is not set
[   32.288576] DMAR: Dump dmar0 table entries for IOVA 0x0
[   32.288579] DMAR: root entry: 0x0000000127f42001
[   32.288581] DMAR: context entry: hi 0x0000000000001502, low 0x000000012d8ab001
[   32.288589]
[   32.288590] ================================
[   32.288591] WARNING: inconsistent lock state
[   32.288593] 5.20.0-0.rc0.20220812git7ebfc85e2cd7.10.fc38.x86_64 #1 Not tainted
[   32.288594] --------------------------------
[   32.288595] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
[   32.288596] rngd/1006 [HC1[1]:SC0[0]:HE0:SE1] takes:
[   32.288598] ff177021416f2d78 (&k->k_lock){?.+.}-{2:2}, at: klist_next+0x1b/0x160
[   32.288610] {HARDIRQ-ON-W} state was registered at:
[   32.288611]   lock_acquire+0xce/0x2d0
[   32.288617]   _raw_spin_lock+0x33/0x80
[   32.288625]   klist_add_tail+0x46/0x80
[   32.288627]   bus_add_device+0xee/0x150
[   32.288632]   device_add+0x39d/0x9a0
[   32.288634]   add_memory_block+0x108/0x1d0
[   32.288640]   memory_dev_init+0xe1/0x117
[   32.288648]   driver_init+0x43/0x4d
[   32.288651]   kernel_init_freeable+0x1c2/0x2cc
[   32.288657]   kernel_init+0x16/0x140
[   32.288663]   ret_from_fork+0x1f/0x30
[   32.406866] irq event stamp: 7812
[   32.406867] hardirqs last  enabled at (7811): [<ffffffff85000e86>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[   32.406873] hardirqs last disabled at (7812): [<ffffffff84f16894>] irqentry_enter+0x54/0x60
[   32.406876] softirqs last  enabled at (7794): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170
[   32.406883] softirqs last disabled at (7787): [<ffffffff840ff669>] __irq_exit_rcu+0xf9/0x170
[   32.406886]
[   32.406886] other info that might help us debug this:
[   32.406886]  Possible unsafe locking scenario:
[   32.406886]
[   32.406887]        CPU0
[   32.406888]        ----
[   32.406888]   lock(&k->k_lock);
[   32.406889]   <Interrupt>
[   32.406890]     lock(&k->k_lock);
[   32.406891]
[   32.406891]  *** DEADLOCK ***
[   32.406891]
[   32.406892] no locks held by rngd/1006.
[   32.406893]
[   32.406893] stack backtrace:
[   32.406894] CPU: 0 PID: 1006 Comm: rngd Not tainted 5.20.0-0.rc0.20220812git7ebfc85e2cd7.10.fc38.x86_64 #1
[   32.406897] Hardware name: Intel Corporation Idaville/Unknown, BIOS SB_IDVH .001.001.000.000.008.00006.D-569F2C6B571C2177 Aug 11 2022
[   32.406898] Call Trace:
[   32.406900]  <TASK>
[   32.406901]  dump_stack_lvl+0x5b/0x77
[   32.406910]  mark_lock.cold+0x48/0xe1
[   32.406916]  ? find_held_lock+0x32/0x90
[   32.406924]  __lock_acquire+0x948/0x1ef0
[   32.406926]  ? __lock_acquire+0x388/0x1ef0
[   32.406929]  lock_acquire+0xce/0x2d0
[   32.406931]  ? klist_next+0x1b/0x160
[   32.406933]  ? lock_is_held_type+0xe8/0x140
[   32.406936]  ? find_held_lock+0x32/0x90
[   32.406939]  ? sched_clock_cpu+0xb/0xc0
[   32.406942]  ? system_root_device_release+0x10/0x10
[   32.406944]  _raw_spin_lock_irqsave+0x4d/0xa0
[   32.406947]  ? klist_next+0x1b/0x160
[   32.406949]  klist_next+0x1b/0x160
[   32.406951]  ? pci_uevent_ers+0x80/0x80
[   32.406956]  bus_find_device+0x52/0xa0
[   32.406959]  pci_get_domain_bus_and_slot+0x70/0xf0
[   32.406968]  dmar_fault_dump_ptes+0xf5/0x28f
[   32.406972]  dmar_fault.cold+0xf2/0x1e6
[   32.487869]  __handle_irq_event_percpu+0x90/0x330
[   32.497674]  handle_irq_event+0x34/0x70
[   32.497677]  handle_edge_irq+0x9f/0x240
[   32.497681]  __common_interrupt+0x6e/0x150
[   32.497686]  common_interrupt+0x5c/0xd0
[   32.509825]  asm_common_interrupt+0x22/0x40
[   32.509828] RIP: 0033:0x7facc2b09688
[   32.644127] Code: 98 48 83 c0 40 48 8b 00 48 f7 d0 48 89 c1 48 8b 45 98 48 83 c0 48 48 8b 00 48 21 c1 48 8b 45 98 48 83 c0 38 48 31 ca 48 89 10 <48> 8b 45 98 48 83 c0 60 48 8b 10 48 8b 45 98 48 83 c0 68 480
[   32.644129] RSP: 002b:00007facc1c80820 EFLAGS: 00000202
[   32.644132] RAX: 000055b21df61db8 RBX: 00007facbc004c10 RCX: 04428d8038200044
[   32.644133] RDX: 5e6e24505b76b92a RSI: 1968b00000000000 RDI: 000055b21df61d80
[   32.644135] RBP: 00007facc1c80890 R08: 00007facbc004c10 R09: 0000000000000064
[   32.644136] R10: 00007fffeddfa080 R11: 00000000000078d6 R12: 0000000000000000
[   32.697491] R13: 000055b21d88e440 R14: 000055b21d8892e5 R15: 000055b21d88a058
[   32.697496]  </TASK>
[   32.697521] DMAR: PTE not present at level 4
