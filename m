Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4840465B21
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355005AbhLBApM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354668AbhLBAmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8EC061759;
        Wed,  1 Dec 2021 16:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D237AB821A3;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF130C5831C;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=YbUFw30tQaTpKjLc/x9GE0wRx8kCUi1zKFA0wr+P57Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YldjkgY1+KfUB/DqMCXaf5tlF1HhypFEi6tjbMk+cvil5pqocTcEY3RiEtNMjNsV9
         KD3znHGG2ekCjctG9OKAQw25f8g4qyna7SXVMFG3r7w7Sc2/ZP0D9GBWtCyWyHkzad
         FuuGuieiecpBKjpvg6dS0XEs9bfyboIrbQu/vqVIfV7LM1hY3N+z2d0nFlbR06Afua
         N5haLX5lWyrwJJCntkJDMc3kAOY+J6naLYfVhfqbH8YPtGXCBH6+uJxICgRuudnq0f
         KqvHSr3kHJPX0Lm4gYhAd71ZA+BDx824IyUTdTmWC2o0r8kwx6FRWdtuUjTxq+cuqL
         vUx+KqDrbQlzw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4E4505C1180; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 06/18] rcu-tasks: Use spin_lock_rcu_node() and friends
Date:   Wed,  1 Dec 2021 16:38:46 -0800
Message-Id: <20211202003858.3129628-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit renames the rcu_tasks_percpu structure's ->cbs_pcpu_lock
to ->lock and then uses spin_lock_rcu_node() and friends to acquire and
release this lock, preparing for upcoming commits that will spread the
grace-period process across multiple CPUs and kthreads.

[ paulmck: Apply feedback from kernel test robot. ]

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 2e58d7fa2da41..e9f59a88637cf 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -23,11 +23,11 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 /**
  * struct rcu_tasks_percpu - Per-CPU component of definition for a Tasks-RCU-like mechanism.
  * @cblist: Callback list.
- * @cbs_pcpu_lock: Lock protecting per-CPU callback list.
+ * @lock: Lock protecting per-CPU callback list.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
-	raw_spinlock_t cbs_pcpu_lock;
+	raw_spinlock_t __private lock;
 };
 
 /**
@@ -82,7 +82,7 @@ struct rcu_tasks {
 
 #define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
 static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
-	.cbs_pcpu_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),	\
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),		\
 };											\
 static struct rcu_tasks rt_name =							\
 {											\
@@ -177,11 +177,11 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 
 		WARN_ON_ONCE(!rtpcp);
 		if (cpu)
-			raw_spin_lock_init(&rtpcp->cbs_pcpu_lock);
-		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
+			raw_spin_lock_init(&ACCESS_PRIVATE(rtpcp, lock));
+		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 		if (rcu_segcblist_empty(&rtpcp->cblist))
 			rcu_segcblist_init(&rtpcp->cblist);
-		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
+		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
 
@@ -200,15 +200,15 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	local_irq_save(flags);
 	rtpcp = per_cpu_ptr(rtp->rtpcpu,
 			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
-	raw_spin_lock(&rtpcp->cbs_pcpu_lock);
+	raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
-		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
+		raw_spin_unlock_rcu_node(rtpcp); // irqs remain disabled.
 		cblist_init_generic(rtp);
-		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
+		raw_spin_lock_rcu_node(rtpcp); // irqs already disabled.
 	}
 	needwake = rcu_segcblist_empty(&rtpcp->cblist);
 	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
-	raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
+	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		wake_up(&rtp->cbs_wq);
@@ -250,11 +250,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
 		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 
 		/* If there were none, wait a bit and start over. */
 		if (!rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
@@ -277,11 +277,11 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
-		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
 		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
 		rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
-		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 		len = rcl.len;
 		for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 			local_bh_disable();
@@ -289,10 +289,10 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 			local_bh_enable();
 			cond_resched();
 		}
-		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
 		rcu_segcblist_add_len(&rtpcp->cblist, -len);
 		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
-		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_idle(rtp->gp_sleep);
 	}
-- 
2.31.1.189.g2e36527f23

