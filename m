Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490B3465B14
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354695AbhLBAmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354678AbhLBAmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514CDC061756;
        Wed,  1 Dec 2021 16:39:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0ACC1B82197;
        Thu,  2 Dec 2021 00:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9020FC53FD0;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=HNfBCLdWxuBOfYl8mDGyFh3aZ99YRNf8LSmls6I+8sg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jb3ewenSR24EtnHB1r3J5BomnpKjaKRr6KTJjS9igkTjvYFw7ilYTmf7CZpBdu9p3
         uEB4NmMItBuIDIB1YGHj56xgCkcf0If9fb1MjP1Zya65cC69GyDwZ/YzJdKpNwyQ/K
         taYRcMqpzp1FuveKHAHZoZXzm+k8H+OSIuI+y+itpYQSBEi9SyYDIpMCJ0WaSB9o/R
         BpUq0jqvB1nbv+oZq8HV4CT4RxiPZrNOrLHTzglRLOSqDTp4fGTsbfY5Vy/QzCY87c
         clnL+58CWNL8GF8F/6diPUY44wm/6kH3xYhjZdKkwj3RJsxMfBDF+ppcThaDy3t2EQ
         TaVLIrM22yPUA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 4C4E55C110A; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 05/18] rcu_tasks: Convert bespoke callback list to rcu_segcblist structure
Date:   Wed,  1 Dec 2021 16:38:45 -0800
Message-Id: <20211202003858.3129628-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit moves from a bespoke head and tail pointer in the
rcu_tasks_percpu structure to an rcu_segcblist structure, thus allowing
associating the grace-period sequence number with groups of callbacks.
This in turn will allow callbacks to be invoked independently on
different CPUs.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig |  2 +-
 kernel/rcu/tasks.h | 52 ++++++++++++++++++++++++++--------------------
 2 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 3128b7cf8e1fd..42bcd34312c2c 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -112,7 +112,7 @@ config RCU_STALL_COMMON
 	  making these warnings mandatory for the tree variants.
 
 config RCU_NEED_SEGCBLIST
-	def_bool ( TREE_RCU || TREE_SRCU )
+	def_bool ( TREE_RCU || TREE_SRCU || TASKS_RCU_GENERIC )
 
 config RCU_FANOUT
 	int "Tree-based hierarchical RCU fanout value"
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index ed84d59b6dbfa..2e58d7fa2da41 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -6,6 +6,7 @@
  */
 
 #ifdef CONFIG_TASKS_RCU_GENERIC
+#include "rcu_segcblist.h"
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -21,13 +22,11 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
  * struct rcu_tasks_percpu - Per-CPU component of definition for a Tasks-RCU-like mechanism.
- * @cbs_head: Head of callback list.
- * @cbs_tail: Tail pointer for callback list.
+ * @cblist: Callback list.
  * @cbs_pcpu_lock: Lock protecting per-CPU callback list.
  */
 struct rcu_tasks_percpu {
-	struct rcu_head *cbs_head;
-	struct rcu_head **cbs_tail;
+	struct rcu_segcblist cblist;
 	raw_spinlock_t cbs_pcpu_lock;
 };
 
@@ -180,8 +179,8 @@ static void cblist_init_generic(struct rcu_tasks *rtp)
 		if (cpu)
 			raw_spin_lock_init(&rtpcp->cbs_pcpu_lock);
 		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
-		if (!WARN_ON_ONCE(rtpcp->cbs_tail))
-			rtpcp->cbs_tail = &rtpcp->cbs_head;
+		if (rcu_segcblist_empty(&rtpcp->cblist))
+			rcu_segcblist_init(&rtpcp->cblist);
 		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
 	}
 	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
@@ -202,14 +201,13 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 	rtpcp = per_cpu_ptr(rtp->rtpcpu,
 			    smp_processor_id() >> READ_ONCE(rtp->percpu_enqueue_shift));
 	raw_spin_lock(&rtpcp->cbs_pcpu_lock);
-	if (!rtpcp->cbs_tail) {
+	if (!rcu_segcblist_is_enabled(&rtpcp->cblist)) {
 		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
 		cblist_init_generic(rtp);
 		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
 	}
-	needwake = !rtpcp->cbs_head;
-	WRITE_ONCE(*rtpcp->cbs_tail, rhp);
-	rtpcp->cbs_tail = &rhp->next;
+	needwake = rcu_segcblist_empty(&rtpcp->cblist);
+	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
 	raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
@@ -231,8 +229,9 @@ static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 static int __noreturn rcu_tasks_kthread(void *arg)
 {
 	unsigned long flags;
-	struct rcu_head *list;
-	struct rcu_head *next;
+	int len;
+	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
+	struct rcu_head *rhp;
 	struct rcu_tasks *rtp = arg;
 
 	/* Run on housekeeping CPUs by default.  Sysadm can move if desired. */
@@ -253,16 +252,15 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 		/* Pick up any new callbacks. */
 		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
-		list = rtpcp->cbs_head;
-		rtpcp->cbs_head = NULL;
-		rtpcp->cbs_tail = &rtpcp->cbs_head;
+		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
 		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
 
 		/* If there were none, wait a bit and start over. */
-		if (!list) {
+		if (!rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
 			wait_event_interruptible(rtp->cbs_wq,
-						 READ_ONCE(rtpcp->cbs_head));
-			if (!rtpcp->cbs_head) {
+						 rcu_segcblist_pend_cbs(&rtpcp->cblist));
+			if (!rcu_segcblist_pend_cbs(&rtpcp->cblist)) {
 				WARN_ON(signal_pending(current));
 				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
 				schedule_timeout_idle(HZ/10);
@@ -279,14 +277,22 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 
 		/* Invoke the callbacks. */
 		set_tasks_gp_state(rtp, RTGS_INVOKE_CBS);
-		while (list) {
-			next = list->next;
+		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
+		smp_mb__after_spinlock(); // Order updates vs. GP.
+		rcu_segcblist_advance(&rtpcp->cblist, rcu_seq_current(&rtp->tasks_gp_seq));
+		rcu_segcblist_extract_done_cbs(&rtpcp->cblist, &rcl);
+		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
+		len = rcl.len;
+		for (rhp = rcu_cblist_dequeue(&rcl); rhp; rhp = rcu_cblist_dequeue(&rcl)) {
 			local_bh_disable();
-			list->func(list);
+			rhp->func(rhp);
 			local_bh_enable();
-			list = next;
 			cond_resched();
 		}
+		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
+		rcu_segcblist_add_len(&rtpcp->cblist, -len);
+		(void)rcu_segcblist_accelerate(&rtpcp->cblist, rcu_seq_snap(&rtp->tasks_gp_seq));
+		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
 		/* Paranoid sleep to keep this from entering a tight loop */
 		schedule_timeout_idle(rtp->gp_sleep);
 	}
@@ -339,7 +345,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		data_race(rcu_seq_current(&rtp->tasks_gp_seq)),
 		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
-		".C"[!!data_race(rtpcp->cbs_head)],
+		".C"[!data_race(rcu_segcblist_empty(&rtpcp->cblist))],
 		s);
 }
 #endif // #ifndef CONFIG_TINY_RCU
-- 
2.31.1.189.g2e36527f23

