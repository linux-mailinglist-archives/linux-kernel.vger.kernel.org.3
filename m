Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8AC4DC1CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiCQIta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiCQIt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:49:27 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5322E034;
        Thu, 17 Mar 2022 01:48:10 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KK0z059dkz1GCXH;
        Thu, 17 Mar 2022 16:43:08 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 16:48:07 +0800
Received: from huawei.com (10.67.174.153) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 16:48:07 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <paulmck@kernel.org>, <josh@joshtriplett.org>
CC:     <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>,
        <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zhang Qiao <zhangqiao22@huawei.com>
Subject: [PATCH] rcu: Use printk_deferred when holding rtp->cbs_gbl_lock
Date:   Thu, 17 Mar 2022 16:47:26 +0800
Message-ID: <20220317084726.77336-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.153]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a lockdep complains about invalid context:

[2.464191] [ BUG: Invalid wait context ]
[2.464192] 5.17.0-rc8-43124-gf8d61731923c #75 Not tainted
[2.464193] -----------------------------
[2.464193] swapper/0/1 is trying to lock:
[2.464194] ffffffff846e8c38 (&port_lock_key){....}-{3:3}, at: serial8250_console_write+0x2b0/0x320
[2.464202] other info that might help us debug this:
[2.464202] context-{5:5}
[2.464203] 3 locks held by swapper/0/1:
[2.464204]  #0: ffffffff82b77f08 (rcu_tasks.cbs_gbl_lock){....}-{2:2}, at: cblist_init_generic+0x26/0x2a0
[2.464211]  #1: ffffffff82b74540 (console_lock){+.+.}-{0:0}, at: vprintk_emit+0xb5/0x2a0
[2.464217]  #2: ffffffff82a94320 (console_owner){....}-{0:0}, at: console_unlock+0x18a/0x5f0
[2.464221] stack backtrace:
...
[2.464266]  _printk+0x52/0x6e
[2.464271]  cblist_init_generic+0x25a/0x2a0
[2.464277]  rcu_init_tasks_generic+0x21/0xe1
[2.464280]  kernel_init_freeable+0x156/0x324
[2.464285]  kernel_init+0x17/0x150
[2.464288]  ret_from_fork+0x22/0x30
[2.464293]  </TASK>

At cblist_init_generic() and rcu_tasks_need_gpcb(),
After taking rtp->cbs_gbl_lock(raw spinlock), at cblist_init_generic()
and rcu_tasks_need_gpcb(), we print some logs and will attempt to
acquire a spinlock(port_lock_key). Since spin_lock() can sleep
with PREEMPT_RT, it is illegal that attempt to acquire spinlocks
inside raw_spinlocks.

This patch tries to avoid this issue by using printk_deferred().

Fixes: ab97152f88a4 ("rcu-tasks: Use more callback queues if contention encountered")
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/rcu/tasks.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d64f0b1d8cd3..98249e6a1054 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -222,7 +222,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 	if (rcu_task_enqueue_lim < 0) {
 		rcu_task_enqueue_lim = 1;
 		rcu_task_cb_adjust = true;
-		pr_info("%s: Setting adjustable number of callback queues.\n", __func__);
+		printk_deferred("%s: Setting adjustable number of callback queues.\n",
+				__func__);
 	} else if (rcu_task_enqueue_lim == 0) {
 		rcu_task_enqueue_lim = 1;
 	}
@@ -305,7 +306,8 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
 			WRITE_ONCE(rtp->percpu_dequeue_lim, nr_cpu_ids);
 			smp_store_release(&rtp->percpu_enqueue_lim, nr_cpu_ids);
-			pr_info("Switching %s to per-CPU callback queuing.\n", rtp->name);
+			printk_deferred("Switching %s to per-CPU callback queuing.\n",
+					rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -420,7 +422,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 			WRITE_ONCE(rtp->percpu_enqueue_shift, ilog2(nr_cpu_ids) + 1);
 			smp_store_release(&rtp->percpu_enqueue_lim, 1);
 			rtp->percpu_dequeue_gpseq = get_state_synchronize_rcu();
-			pr_info("Starting switch %s to CPU-0 callback queuing.\n", rtp->name);
+			printk_deferred("Starting switch %s to CPU-0 callback queuing.\n",
+					rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
@@ -429,7 +432,8 @@ static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
 		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
 		if (rtp->percpu_enqueue_lim < rtp->percpu_dequeue_lim) {
 			WRITE_ONCE(rtp->percpu_dequeue_lim, 1);
-			pr_info("Completing switch %s to CPU-0 callback queuing.\n", rtp->name);
+			printk_deferred("Completing switch %s to CPU-0 callback queuing.\n",
+					rtp->name);
 		}
 		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 	}
-- 
2.18.0.huawei.25

