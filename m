Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B54465B1C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235990AbhLBAoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:44:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37316 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354679AbhLBAm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9283B821A7;
        Thu,  2 Dec 2021 00:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2662C5832E;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405541;
        bh=DexwMjnm6DxyWF5C81fIJP0lKP4dsoYPPT2KKfhwq/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPGdHma3c2saaUM/i4NWdA6WxdhgNHz1Hcsmhqet5rqjG/zBt2w6rz22/e54mrV9m
         9+tKRQck6t4aMh7c78oLfXeGOfmxrlq/gSjv7kcFbwVb/RUR3Jz5mk/DHzX7YPDBwP
         fFhXkY8bjhYi8hBxatjDrSSXvfkHNRRrCAbFW4yQKQwqTaFc4Z1mLg1oS2XRlzaLGf
         kOxFY4mAAHZWqhW+jLNhIxaLRutKzldWbglR/anRf76pHohffR2J+PwcLWSObEPobp
         TBE950g3UqRP9eDvPaDoxnuMqxJafZoV58BA9S0Mvg3I1Py50CrFmm+sFzULXf9ZlU
         t22Ag+BXV0nRA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 59D965C12E4; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
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
Subject: [PATCH rcu 12/18] rcu-tasks: Make rcu_barrier_tasks*() handle multiple callback queues
Date:   Wed,  1 Dec 2021 16:38:52 -0800
Message-Id: <20211202003858.3129628-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, rcu_barrier_tasks(), rcu_barrier_tasks_rude(),
and rcu_barrier_tasks_trace() simply invoke the corresponding
synchronize_rcu_tasks*() function.  This works because there is only
one callback queue.

However, there will soon be multiple callback queues.  This commit
therefore scans the queues currently in use, entraining a callback on
each non-empty queue.  Sequence numbers and reference counts are used
to synchronize this process in a manner similar to the approach taken
by rcu_barrier().

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 70 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 64 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a75a4ca78a621..61a606569868b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -25,11 +25,15 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @cblist: Callback list.
  * @lock: Lock protecting per-CPU callback list.
  * @rtp_work: Work queue for invoking callbacks.
+ * @barrier_q_head: RCU callback for barrier operation.
+ * @cpu: CPU number corresponding to this entry.
+ * @rtpp: Pointer to the rcu_tasks structure.
  */
 struct rcu_tasks_percpu {
 	struct rcu_segcblist cblist;
 	raw_spinlock_t __private lock;
 	struct work_struct rtp_work;
+	struct rcu_head barrier_q_head;
 	int cpu;
 	struct rcu_tasks *rtpp;
 };
@@ -57,6 +61,10 @@ struct rcu_tasks_percpu {
  * @rtpcpu: This flavor's rcu_tasks_percpu structure.
  * @percpu_enqueue_shift: Shift down CPU ID this much when enqueuing callbacks.
  * @percpu_enqueue_lim: Number of per-CPU callback queues in use.
+ * @barrier_q_mutex: Serialize barrier operations.
+ * @barrier_q_count: Number of queues being waited on.
+ * @barrier_q_completion: Barrier wait/wakeup mechanism.
+ * @barrier_q_seq: Sequence number for barrier operations.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
@@ -82,6 +90,10 @@ struct rcu_tasks {
 	struct rcu_tasks_percpu __percpu *rtpcpu;
 	int percpu_enqueue_shift;
 	int percpu_enqueue_lim;
+	struct mutex barrier_q_mutex;
+	atomic_t barrier_q_count;
+	struct completion barrier_q_completion;
+	unsigned long barrier_q_seq;
 	char *name;
 	char *kname;
 };
@@ -100,6 +112,8 @@ static struct rcu_tasks rt_name =							\
 	.name = n,									\
 	.percpu_enqueue_shift = ilog2(CONFIG_NR_CPUS),					\
 	.percpu_enqueue_lim = 1,							\
+	.barrier_q_mutex = __MUTEX_INITIALIZER(rt_name.barrier_q_mutex),		\
+	.barrier_q_seq = (0UL - 50UL) << RCU_SEQ_CTR_SHIFT,				\
 	.kname = #rt_name,								\
 }
 
@@ -238,6 +252,53 @@ static void synchronize_rcu_tasks_generic(struct rcu_tasks *rtp)
 	wait_rcu_gp(rtp->call_func);
 }
 
+// RCU callback function for rcu_barrier_tasks_generic().
+static void rcu_barrier_tasks_generic_cb(struct rcu_head *rhp)
+{
+	struct rcu_tasks *rtp;
+	struct rcu_tasks_percpu *rtpcp;
+
+	rtpcp = container_of(rhp, struct rcu_tasks_percpu, barrier_q_head);
+	rtp = rtpcp->rtpp;
+	if (atomic_dec_and_test(&rtp->barrier_q_count))
+		complete(&rtp->barrier_q_completion);
+}
+
+// Wait for all in-flight callbacks for the specified RCU Tasks flavor.
+// Operates in a manner similar to rcu_barrier().
+static void rcu_barrier_tasks_generic(struct rcu_tasks *rtp)
+{
+	int cpu;
+	unsigned long flags;
+	struct rcu_tasks_percpu *rtpcp;
+	unsigned long s = rcu_seq_snap(&rtp->barrier_q_seq);
+
+	mutex_lock(&rtp->barrier_q_mutex);
+	if (rcu_seq_done(&rtp->barrier_q_seq, s)) {
+		smp_mb();
+		mutex_unlock(&rtp->barrier_q_mutex);
+		return;
+	}
+	rcu_seq_start(&rtp->barrier_q_seq);
+	init_completion(&rtp->barrier_q_completion);
+	atomic_set(&rtp->barrier_q_count, 2);
+	for_each_possible_cpu(cpu) {
+		if (cpu >= smp_load_acquire(&rtp->percpu_enqueue_lim))
+			break;
+		rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+		rtpcp->barrier_q_head.func = rcu_barrier_tasks_generic_cb;
+		raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
+		if (rcu_segcblist_entrain(&rtpcp->cblist, &rtpcp->barrier_q_head))
+			atomic_inc(&rtp->barrier_q_count);
+		raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
+	}
+	if (atomic_sub_and_test(2, &rtp->barrier_q_count))
+		complete(&rtp->barrier_q_completion);
+	wait_for_completion(&rtp->barrier_q_completion);
+	rcu_seq_end(&rtp->barrier_q_seq);
+	mutex_unlock(&rtp->barrier_q_mutex);
+}
+
 // Advance callbacks and indicate whether either a grace period or
 // callback invocation is needed.
 static int rcu_tasks_need_gpcb(struct rcu_tasks *rtp)
@@ -705,8 +766,7 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_tasks);
  */
 void rcu_barrier_tasks(void)
 {
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks();
+	rcu_barrier_tasks_generic(&rcu_tasks);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
@@ -844,8 +904,7 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_rude);
  */
 void rcu_barrier_tasks_rude(void)
 {
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks_rude();
+	rcu_barrier_tasks_generic(&rcu_tasks_rude);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 
@@ -1403,8 +1462,7 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_tasks_trace);
  */
 void rcu_barrier_tasks_trace(void)
 {
-	/* There is only one callback queue, so this is easy.  ;-) */
-	synchronize_rcu_tasks_trace();
+	rcu_barrier_tasks_generic(&rcu_tasks_trace);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
-- 
2.31.1.189.g2e36527f23

