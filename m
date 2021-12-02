Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDE4465B18
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 01:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354769AbhLBAnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 19:43:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56522 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbhLBAm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 19:42:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E888CE2075;
        Thu,  2 Dec 2021 00:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B354C00446;
        Thu,  2 Dec 2021 00:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638405540;
        bh=0QSbZorPFQ0NUvLiIlL0UJPYJeZBpVNTbdWPJaKdmfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZU1F+oUDJCoSWeHnpPhZvfAXlvwhQhRaIp9a/er8tAAj5hsSZmpka4wwzVl+EQW1J
         /DSezafl9sP7vhxfk5g7z+I1c6TnDWBYnYdTnoH9QNlI+b2O/FPPNRkuU6UH6S/Yfo
         zbqBLjaf8uwf5x6F/j8SxmvhrIZTYAbLBOab4KQhQ2XIAKcW7rYQd+QfegifMqs8am
         nS8hH6U7J0YBaASdmwVb8FtBTpP8bcyVEwt6IDeRO9ou3rSS/OqTdaVNsB0VGBEqBS
         zfDG5MHKHNX4g3fZxc3A19Qzbwzq0QuiTnpOGGDj+0KXk5B71sq353IvYtw+lq+hwv
         5KZhuJGRd0YBA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 45CE85C100F; Wed,  1 Dec 2021 16:39:00 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>, Martin Lau <kafai@fb.com>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
        kernel test robot <beibei.si@intel.com>
Subject: [PATCH rcu 02/18] rcu-tasks:  Create per-CPU callback lists
Date:   Wed,  1 Dec 2021 16:38:42 -0800
Message-Id: <20211202003858.3129628-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
References: <20211202003826.GA3129369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, RCU Tasks Trace (as well as the other two flavors of RCU Tasks)
use a single global callback list.  This works well and is simple, but
expected changes in workload will cause this list to become a bottleneck.
This commit therefore creates per-CPU callback lists for the various
flavors of RCU Tasks, but continues queueing on a single list, namely
that of CPU 0.  Later commits will dynamically vary the number of lists
in use to accommodate dynamic changes in workload.

Reported-by: Martin Lau <kafai@fb.com>
Cc: Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Tested-by: kernel test robot <beibei.si@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 106 +++++++++++++++++++++++++++++++++------------
 1 file changed, 78 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bd44cd4794d3d..30048db7aa49d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -20,11 +20,21 @@ typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
 /**
- * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
+ * struct rcu_tasks_percpu - Per-CPU component of definition for a Tasks-RCU-like mechanism.
  * @cbs_head: Head of callback list.
  * @cbs_tail: Tail pointer for callback list.
+ * @cbs_pcpu_lock: Lock protecting per-CPU callback list.
+ */
+struct rcu_tasks_percpu {
+	struct rcu_head *cbs_head;
+	struct rcu_head **cbs_tail;
+	raw_spinlock_t cbs_pcpu_lock;
+};
+
+/**
+ * struct rcu_tasks - Definition for a Tasks-RCU-like mechanism.
  * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
- * @cbs_lock: Lock protecting callback list.
+ * @cbs_gbl_lock: Lock protecting callback list.
  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
  * @gp_func: This flavor's grace-period-wait function.
  * @gp_state: Grace period's most recent state transition (debugging).
@@ -41,14 +51,13 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
  * @holdouts_func: This flavor's holdout-list scan function (optional).
  * @postgp_func: This flavor's post-grace-period function (optional).
  * @call_func: This flavor's call_rcu()-equivalent function.
+ * @rtpcpu: This flavor's rcu_tasks_percpu structure.
  * @name: This flavor's textual name.
  * @kname: This flavor's kthread name.
  */
 struct rcu_tasks {
-	struct rcu_head *cbs_head;
-	struct rcu_head **cbs_tail;
 	struct wait_queue_head cbs_wq;
-	raw_spinlock_t cbs_lock;
+	raw_spinlock_t cbs_gbl_lock;
 	int gp_state;
 	int gp_sleep;
 	int init_fract;
@@ -65,20 +74,24 @@ struct rcu_tasks {
 	holdouts_func_t holdouts_func;
 	postgp_func_t postgp_func;
 	call_rcu_func_t call_func;
+	struct rcu_tasks_percpu __percpu *rtpcpu;
 	char *name;
 	char *kname;
 };
 
-#define DEFINE_RCU_TASKS(rt_name, gp, call, n)				\
-static struct rcu_tasks rt_name =					\
-{									\
-	.cbs_tail = &rt_name.cbs_head,					\
-	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),	\
-	.cbs_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_lock),		\
-	.gp_func = gp,							\
-	.call_func = call,						\
-	.name = n,							\
-	.kname = #rt_name,						\
+#define DEFINE_RCU_TASKS(rt_name, gp, call, n)						\
+static DEFINE_PER_CPU(struct rcu_tasks_percpu, rt_name ## __percpu) = {			\
+	.cbs_pcpu_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name ## __percpu.cbs_pcpu_lock),	\
+};											\
+static struct rcu_tasks rt_name =							\
+{											\
+	.cbs_wq = __WAIT_QUEUE_HEAD_INITIALIZER(rt_name.cbs_wq),			\
+	.cbs_gbl_lock = __RAW_SPIN_LOCK_UNLOCKED(rt_name.cbs_gbl_lock),			\
+	.gp_func = gp,									\
+	.call_func = call,								\
+	.rtpcpu = &rt_name ## __percpu,							\
+	.name = n,									\
+	.kname = #rt_name,								\
 }
 
 /* Track exiting tasks in order to allow them to be waited for. */
@@ -148,20 +161,51 @@ static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+// Initialize per-CPU callback lists for the specified flavor of
+// Tasks RCU.
+static void cblist_init_generic(struct rcu_tasks *rtp)
+{
+	int cpu;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
+	for_each_possible_cpu(cpu) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
+
+		WARN_ON_ONCE(!rtpcp);
+		if (cpu)
+			raw_spin_lock_init(&rtpcp->cbs_pcpu_lock);
+		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
+		if (!WARN_ON_ONCE(rtpcp->cbs_tail))
+			rtpcp->cbs_tail = &rtpcp->cbs_head;
+		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
+	}
+	raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
+
+}
+
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
 				   struct rcu_tasks *rtp)
 {
 	unsigned long flags;
 	bool needwake;
+	struct rcu_tasks_percpu *rtpcp;
 
 	rhp->next = NULL;
 	rhp->func = func;
-	raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
-	needwake = !rtp->cbs_head;
-	WRITE_ONCE(*rtp->cbs_tail, rhp);
-	rtp->cbs_tail = &rhp->next;
-	raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
+	local_irq_save(flags);
+	rtpcp = per_cpu_ptr(rtp->rtpcpu, 0 /* smp_processor_id() */);
+	raw_spin_lock(&rtpcp->cbs_pcpu_lock);
+	if (!rtpcp->cbs_tail) {
+		raw_spin_unlock(&rtpcp->cbs_pcpu_lock); // irqs remain disabled.
+		cblist_init_generic(rtp);
+		raw_spin_lock(&rtpcp->cbs_pcpu_lock); // irqs already disabled.
+	}
+	needwake = !rtpcp->cbs_head;
+	WRITE_ONCE(*rtpcp->cbs_tail, rhp);
+	rtpcp->cbs_tail = &rhp->next;
+	raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
 	/* We can't create the thread unless interrupts are enabled. */
 	if (needwake && READ_ONCE(rtp->kthread_ptr))
 		wake_up(&rtp->cbs_wq);
@@ -197,21 +241,23 @@ static int __noreturn rcu_tasks_kthread(void *arg)
 	 * This loop is terminated by the system going down.  ;-)
 	 */
 	for (;;) {
+		struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, 0);  // for_each...
+
 		set_tasks_gp_state(rtp, RTGS_WAIT_CBS);
 
 		/* Pick up any new callbacks. */
-		raw_spin_lock_irqsave(&rtp->cbs_lock, flags);
+		raw_spin_lock_irqsave(&rtpcp->cbs_pcpu_lock, flags);
 		smp_mb__after_spinlock(); // Order updates vs. GP.
-		list = rtp->cbs_head;
-		rtp->cbs_head = NULL;
-		rtp->cbs_tail = &rtp->cbs_head;
-		raw_spin_unlock_irqrestore(&rtp->cbs_lock, flags);
+		list = rtpcp->cbs_head;
+		rtpcp->cbs_head = NULL;
+		rtpcp->cbs_tail = &rtpcp->cbs_head;
+		raw_spin_unlock_irqrestore(&rtpcp->cbs_pcpu_lock, flags);
 
 		/* If there were none, wait a bit and start over. */
 		if (!list) {
 			wait_event_interruptible(rtp->cbs_wq,
-						 READ_ONCE(rtp->cbs_head));
-			if (!rtp->cbs_head) {
+						 READ_ONCE(rtpcp->cbs_head));
+			if (!rtpcp->cbs_head) {
 				WARN_ON(signal_pending(current));
 				set_tasks_gp_state(rtp, RTGS_WAIT_WAIT_CBS);
 				schedule_timeout_idle(HZ/10);
@@ -279,6 +325,7 @@ static void __init rcu_tasks_bootup_oddness(void)
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
+	struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, 0); // for_each...
 	pr_info("%s: %s(%d) since %lu g:%lu i:%lu/%lu %c%c %s\n",
 		rtp->kname,
 		tasks_gp_state_getname(rtp), data_race(rtp->gp_state),
@@ -286,7 +333,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		data_race(rtp->n_gps),
 		data_race(rtp->n_ipis_fails), data_race(rtp->n_ipis),
 		".k"[!!data_race(rtp->kthread_ptr)],
-		".C"[!!data_race(rtp->cbs_head)],
+		".C"[!!data_race(rtpcp->cbs_head)],
 		s);
 }
 #endif // #ifndef CONFIG_TINY_RCU
@@ -593,6 +640,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 
 static int __init rcu_spawn_tasks_kthread(void)
 {
+	cblist_init_generic(&rcu_tasks);
 	rcu_tasks.gp_sleep = HZ / 10;
 	rcu_tasks.init_fract = HZ / 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
@@ -731,6 +779,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_rude);
 
 static int __init rcu_spawn_tasks_rude_kthread(void)
 {
+	cblist_init_generic(&rcu_tasks_rude);
 	rcu_tasks_rude.gp_sleep = HZ / 10;
 	rcu_spawn_tasks_kthread_generic(&rcu_tasks_rude);
 	return 0;
@@ -1264,6 +1313,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks_trace);
 
 static int __init rcu_spawn_tasks_trace_kthread(void)
 {
+	cblist_init_generic(&rcu_tasks_trace);
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
 		rcu_tasks_trace.gp_sleep = HZ / 10;
 		rcu_tasks_trace.init_fract = HZ / 10;
-- 
2.31.1.189.g2e36527f23

