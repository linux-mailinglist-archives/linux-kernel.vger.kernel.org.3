Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31A84634B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhK3Mo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:44:57 -0500
Received: from first.geanix.com ([116.203.34.67]:37682 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhK3Mo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:44:56 -0500
Received: from skn-laptop (_gateway [172.25.0.1])
        by first.geanix.com (Postfix) with ESMTPSA id 677F9E1E80;
        Tue, 30 Nov 2021 12:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1638276092; bh=jjrzx4VWi8T+BA9gDPmooOJjmrzdkAebQ7CI9lqreQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jUGsSL8xUG1Z9vaRKZNA6iJMOhmtEU/eWuPpAjyerby+TLVkqkXIY3Qll2SdmIZSm
         IEx8BNPAA+U8Wkn+EVEn6R9doq5g2zYHWEZgmsEZccvsK1dRGTsjIcruDMXVSnuE/r
         bbZqIFvdzjBhA1RhmAIuNe4HnFNGojRKfqFFITHEK+YtJmyCnKb6EwvIIrW/o1Tu3g
         IpdaKPtdvAJflwHvZf3CEVxS8dGACwDKcBUl9jskZAhpOFZ5e+oNX50PFNhsv2in8Q
         TcNU3q0LdBT2MvJpsgytgVDIix5VfZYg7mVYs6wexDPQGJTx8m0XMuNXMAAFk0OyvR
         r0Sjq5gYscLTQ==
Date:   Tue, 30 Nov 2021 13:41:31 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while in
 suspend
Message-ID: <20211130124131.6pgu7enjgk6y536m@skn-laptop>
References: <20211102110204.3334609-1-sean@geanix.com>
 <20211102110204.3334609-4-sean@geanix.com>
 <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
 <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
 <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
 <20211123140715.280b2f70@collabora.com>
 <20211129101908.6f1aa715@xps13>
 <20211129094129.xn364czofrgtvfb4@skn-laptop>
 <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 29.11.2021 10:41, Sean Nyekjaer wrote:
> > On Mon, Nov 29, 2021 at 10:19:08AM +0100, Miquel Raynal wrote:
> >> boris.brezillon@collabora.com wrote on Tue, 23 Nov 2021 14:07:15 +0100:
> >>> On Tue, 23 Nov 2021 13:50:12 +0100
> >>> Sean Nyekjaer <sean@geanix.com> wrote:
> >>>> @Boris do we need to do something similar here to what we did with the
> >>>> mtdconcat stuff?
> >>> Absolutely, physmasp subdevices are never initialized/registered, so
> >>> you can't call any of the mtd helpers taking the suspend lock on those.
> >>> I guess it'd be better to call mtd_suspend/resume() on the concat device
> >>> in though:
> >> Any chance that you will come up with a fix or v6 of the series anytime
> >> soon?
> >>
> >>> static void physmap_flash_shutdown(struct platform_device *dev)
> >>> {
> >>> 	struct physmap_flash_info *info = platform_get_drvdata(dev);
> >>>
> >>> 	mtd_suspend(info->cmtd);

There is one more issue when using concat during boot, I think we should
start here :)
It uses uninitialized rwsm.


[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd070]
[    0.000000] Linux version 5.16.0-rc1-00013-g67bcbe202b48 (sean@zen) (aarch64-linux-gnu-gcc (GCC) 11.2.0, GNU ld (GNU Binutils) 2.37) #207 SMP PREEMPT Tue Nov 30 13:22:48 CET 2021
[    0.000000] Machine model: linux,dummy-virt
[    0.000000] efi: UEFI not found.
[    0.000000] NUMA: No NUMA configuration found

[ ... ]

[    1.848327] 0.flash: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000000 Chip ID 0x000000
[    1.848567] Intel/Sharp Extended Query Table at 0x0031
[    1.848999] Using buffer write method
[    1.849237] Concatenating MTD devices:
[    1.849347] (0): "0.flash"
[    1.849637] (1): "0.flash"
[    1.849726] into device "0.flash"
[    1.904985] libphy: Fixed MDIO Bus: probed
[    1.915812] tun: Universal TUN/TAP device driver, 1.6

[ ... ]

[    6.064628] The code is fine but needs lockdep annotation, or maybe
[    6.064756] you didn't initialize this object before use?
[    6.064857] turning off the locking correctness validator.
[    6.065111] CPU: 0 PID: 49 Comm: kworker/0:1H Not tainted 5.16.0-rc1-00013-g67bcbe202b48 #207
[    6.065273] Hardware name: linux,dummy-virt (DT)
[    6.065572] Workqueue: kblockd blk_mq_run_work_fn
[    6.065879] Call trace:
[    6.065943]  dump_backtrace+0x0/0x1a0
[    6.066057]  show_stack+0x1c/0x30
[    6.066130]  dump_stack_lvl+0x8c/0xb8
[    6.066206]  dump_stack+0x1c/0x38
[    6.066270]  register_lock_class+0x49c/0x4c0
[    6.066352]  __lock_acquire+0x78/0x20cc
[    6.066422]  lock_acquire.part.0+0xe0/0x230
[    6.066497]  lock_acquire+0x6c/0x90
[    6.066562]  down_read+0x58/0x7c
[    6.066626]  mtd_read_oob_std+0x98/0x170
[    6.066703]  mtd_read_oob+0x80/0x13c
[    6.066770]  mtd_read+0x64/0xa0
[    6.066834]  concat_read+0xd4/0x1b0
[    6.066900]  mtd_read_oob_std+0x158/0x170
[    6.066972]  mtd_read_oob+0x80/0x13c
[    6.067038]  mtd_read+0x64/0xa0
[    6.067099]  mtdblock_readsect+0x6c/0x160
[    6.067169]  mtd_queue_rq+0x240/0x460
[    6.067234]  blk_mq_dispatch_rq_list+0x19c/0x830
[    6.067313]  __blk_mq_do_dispatch_sched+0x248/0x2d4
[    6.067397]  __blk_mq_sched_dispatch_requests+0x110/0x170
[    6.067487]  blk_mq_sched_dispatch_requests+0x3c/0x80
[    6.067573]  __blk_mq_run_hw_queue+0x60/0xa0
[    6.067647]  blk_mq_run_work_fn+0x24/0x30
[    6.067718]  process_one_work+0x28c/0x6e4
[    6.067790]  worker_thread+0x78/0x464
[    6.067856]  kthread+0x180/0x190
[    6.067919]  ret_from_fork+0x10/0x20
[    6.068868] ------------[ cut here ]------------
[    6.068993] DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0x0, owner = 0xffff528f84c617c1, curr 0xffff528f84c617c0, list not empty
[    6.069592] WARNING: CPU: 0 PID: 49 at kernel/locking/rwsem.c:1302 __up_read+0x1e8/0x270
[    6.069790] Modules linked in:
[    6.069963] CPU: 0 PID: 49 Comm: kworker/0:1H Not tainted 5.16.0-rc1-00013-g67bcbe202b48 #207
[    6.070099] Hardware name: linux,dummy-virt (DT)
[    6.070179] Workqueue: kblockd blk_mq_run_work_fn
[    6.070347] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    6.070487] pc : __up_read+0x1e8/0x270
[    6.070577] lr : __up_read+0x1e8/0x270
[    6.070660] sp : ffff80001026b740
[    6.070728] x29: ffff80001026b740 x28: 000000000003ff88 x27: 0000000000040000
[    6.070912] x26: ffff80001026ba28 x25: ffff528f84e92000 x24: ffff528f8576d000
[    6.071040] x23: 0000000000000000 x22: 0000000003ff0000 x21: ffff80001026b878
[    6.071165] x20: ffffadee32213000 x19: ffff528f84e918b0 x18: ffffffffffffffff
[    6.071292] x17: 672d33313030302d x16: 3163722d302e3631 x15: ffff80009026b457
[    6.071418] x14: 0000000000000007 x13: ffffadee32236658 x12: 0000000000000384
[    6.071543] x11: 000000000000012c x10: ffffadee32236658 x9 : ffffadee32236658
[    6.071692] x8 : 00000000ffffefff x7 : ffffadee3228e658 x6 : ffffadee3228e658
[    6.071817] x5 : 000000000000bff4 x4 : 0000000000000000 x3 : 0000000000000000
[    6.071942] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff528f84c617c0
[    6.072094] Call trace:
[    6.072163]  __up_read+0x1e8/0x270
[    6.072238]  up_read+0x44/0x300
[    6.072301]  mtd_read_oob_std+0xd0/0x170
[    6.072374]  mtd_read_oob+0x80/0x13c
[    6.072441]  mtd_read+0x64/0xa0
[    6.072502]  concat_read+0xd4/0x1b0
[    6.072567]  mtd_read_oob_std+0x158/0x170
[    6.072640]  mtd_read_oob+0x80/0x13c
[    6.072706]  mtd_read+0x64/0xa0
[    6.072766]  mtdblock_readsect+0x6c/0x160
[    6.072843]  mtd_queue_rq+0x240/0x460
[    6.072909]  blk_mq_dispatch_rq_list+0x19c/0x830
[    6.072990]  __blk_mq_do_dispatch_sched+0x248/0x2d4
[    6.073073]  __blk_mq_sched_dispatch_requests+0x110/0x170
[    6.073163]  blk_mq_sched_dispatch_requests+0x3c/0x80
[    6.073249]  __blk_mq_run_hw_queue+0x60/0xa0
[    6.073325]  blk_mq_run_work_fn+0x24/0x30
[    6.073421]  process_one_work+0x28c/0x6e4
[    6.073568]  worker_thread+0x78/0x464
[    6.073643]  kthread+0x180/0x190
[    6.073710]  ret_from_fork+0x10/0x20
[    6.073820] irq event stamp: 1529
[    6.073891] hardirqs last  enabled at (1529): [<ffffadee3114576c>] _raw_spin_unlock_irq+0x48/0x9c
[    6.074067] hardirqs last disabled at (1528): [<ffffadee31145b70>] _raw_spin_lock_irq+0xac/0xb0
[    6.074211] softirqs last  enabled at (1444): [<ffffadee30010528>] __do_softirq+0x478/0x5f0
[    6.074350] softirqs last disabled at (1429): [<ffffadee3009f064>] __irq_exit_rcu+0x184/0x1b0
[    6.074506] ---[ end trace 738f7ffe764b66d5 ]---

I can solve this with this hack from mtd_set_dev_defaults():

diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index f4a4274489b4..a4b69b9558c9 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -693,6 +693,8 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 	concat->mtd.oobavail = subdev[0]->oobavail;
 
 	subdev_master = mtd_get_master(subdev[0]);
+	init_waitqueue_head(&subdev_master->master.resume_wq);
+	init_rwsem(&subdev_master->master.suspend_lock);
 	if (subdev_master->_writev)
 		concat->mtd._writev = concat_writev;
 	if (subdev_master->_read_oob)
@@ -740,6 +742,8 @@ struct mtd_info *mtd_concat_create(struct mtd_info *subdev[],	/* subdevices to c
 		}
 
 		subdev_master = mtd_get_master(subdev[i]);
+		init_waitqueue_head(&subdev_master->master.resume_wq);
+		init_rwsem(&subdev_master->master.suspend_lock);
 		concat->mtd.size += subdev[i]->size;
 		concat->mtd.ecc_stats.badblocks +=
 			subdev[i]->ecc_stats.badblocks;

I do not have a great overview of what is happing here with all these
master devices :/

Any ideas Boris/Miquel?

/Sean
