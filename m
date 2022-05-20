Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CF652E2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 05:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345075AbiETDMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 23:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbiETDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 23:12:06 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFA149DBC;
        Thu, 19 May 2022 20:12:03 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L4BTh4nw1zCspc;
        Fri, 20 May 2022 11:07:04 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500015.china.huawei.com (7.221.188.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 20 May 2022 11:12:01 +0800
Received: from huawei.com (10.175.127.227) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 20 May
 2022 11:12:00 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <ming.lei@redhat.com>, <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH -next v2] blk-mq: fix panic during blk_mq_run_work_fn()
Date:   Fri, 20 May 2022 11:25:42 +0800
Message-ID: <20220520032542.3331610-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our test report a following crash:

BUG: kernel NULL pointer dereference, address: 0000000000000018
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 6 PID: 265 Comm: kworker/6:1H Kdump: loaded Tainted: G           O      5.10.0-60.17.0.h43.eulerosv2r11.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
Workqueue: kblockd blk_mq_run_work_fn
RIP: 0010:blk_mq_delay_run_hw_queues+0xb6/0xe0
RSP: 0018:ffffacc6803d3d88 EFLAGS: 00010246
RAX: 0000000000000006 RBX: ffff99e2c3d25008 RCX: 00000000ffffffff
RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffff99e2c911ae18
RBP: ffffacc6803d3dd8 R08: 0000000000000000 R09: ffff99e2c0901f6c
R10: 0000000000000018 R11: 0000000000000018 R12: ffff99e2c911ae18
R13: 0000000000000000 R14: 0000000000000003 R15: ffff99e2c911ae18
FS:  0000000000000000(0000) GS:ffff99e6bbf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000018 CR3: 000000007460a006 CR4: 00000000003706e0
Call Trace:
 __blk_mq_do_dispatch_sched+0x2a7/0x2c0
 ? newidle_balance+0x23e/0x2f0
 __blk_mq_sched_dispatch_requests+0x13f/0x190
 blk_mq_sched_dispatch_requests+0x30/0x60
 __blk_mq_run_hw_queue+0x47/0xd0
 process_one_work+0x1b0/0x350
 worker_thread+0x49/0x300
 ? rescuer_thread+0x3a0/0x3a0
 kthread+0xfe/0x140
 ? kthread_park+0x90/0x90
 ret_from_fork+0x22/0x30

After digging from vmcore, I found that the queue is cleaned
up(blk_cleanup_queue() is done) and tag set is
freed(blk_mq_free_tag_set() is done).

There are two problems here:

1) blk_mq_delay_run_hw_queues() will only be called from
__blk_mq_do_dispatch_sched() if e->type->ops.has_work() return true.
This seems impossible because blk_cleanup_queue() is done, and there
should be no io. Commit ddc25c86b466 ("block, bfq: make bfq_has_work()
more accurate") fix the problem in bfq. And currently ohter schedulers
don't have such problem.

2) 'hctx->run_work' still exists after blk_cleanup_queue().
blk_mq_cancel_work_sync() is called from blk_cleanup_queue() to cancel
all the 'run_work'. However, there is no guarantee that new 'run_work'
won't be queued after that(and before blk_mq_exit_queue() is done).

The first problem is not the root cause, it will only increase the
probability of the second problem. this patch fix the second problem by
checking the 'QUEUE_FLAG_DEAD' before queuing 'hctx->run_work', and
using 'queue_lock' to synchronize queuing new work and cacelling the
old work.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-core.c |  3 +++
 block/blk-mq.c   | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 80fa73c419a9..f3e36d8143ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -314,7 +314,10 @@ void blk_cleanup_queue(struct request_queue *q)
 	 */
 	blk_freeze_queue(q);
 
+	/* New 'hctx->run_work' can't be queued after setting the dead flag */
+	spin_lock_irq(&q->queue_lock);
 	blk_queue_flag_set(QUEUE_FLAG_DEAD, q);
+	spin_unlock_irq(&q->queue_lock);
 
 	blk_sync_queue(q);
 	if (queue_is_mq(q)) {
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ed1869a305c4..fb35d335d554 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2093,6 +2093,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 					unsigned long msecs)
 {
+	unsigned long flags;
+
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
 
@@ -2107,8 +2109,12 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
 
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work,
-				    msecs_to_jiffies(msecs));
+	spin_lock_irqsave(&hctx->queue->queue_lock, flags);
+	if (!blk_queue_dead(hctx->queue))
+		kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx),
+					    &hctx->run_work,
+					    msecs_to_jiffies(msecs));
+	spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);
 }
 
 /**
-- 
2.31.1

