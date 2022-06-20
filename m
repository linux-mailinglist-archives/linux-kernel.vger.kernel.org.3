Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584855273D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345282AbiFTWzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344175AbiFTWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131969FFA;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4FB0B811EC;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E38C341C5;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=EkfWGhO1tBXS/2v6EUZPs8vr0Oh41TD7CtnPsJjhxTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fn9NZ6AXWeuChDST5PfrGL4Rjlbp1x5wYasx7ksYcoAe/iS0fbxwVD7Ce5TnTjtgu
         q+cDMZlZ2AmJopig19zUWNGNN/zPmHgRYpWu+jrb8V/y5giuKgVsK//Pd1X+9LBwwa
         5m2+YaVYidHh0RTc/sKuaIMZmaxUOEJ2V8t5SKMVzw4jXyDSwZDV5Tw5eJoMWJ62EY
         GyrXwm3OLHHbZIHZHOGYIPNyRvU6jB8cvoEtYFqNIB1lfT6o26L4oPFBv4bJr17p3w
         RNkgAJD6b5SxwLai4xubuhdcPB33SQ/J5GtEQ9Q9a/2zZh7Uhr6auHeEtYLQ41QPkk
         BAas0Iq0auyug==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3023C5C0ADC; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        KP Singh <kpsingh@kernel.org>
Subject: [PATCH rcu 05/32] rcu-tasks: Merge state into .b.need_qs and atomically update
Date:   Mon, 20 Jun 2022 15:53:44 -0700
Message-Id: <20220620225411.3842519-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
References: <20220620225402.GA3842369@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit gets rid of the task_struct structure's ->trc_reader_checked
field, making it instead be a bit within the task_struct structure's
existing ->trc_reader_special.b.need_qs field.  This commit also
atomically loads, stores, and checks the resulting combination of the
reader-checked and need-quiescent state flags.  This will in turn allow
significant simplification of the rcu_tasks_trace_postgp() function
as well as elimination of the trc_n_readers_need_end counter in later
commits.  These changes will in turn simplify later elimination of the
RCU Tasks Trace scan of the task list, which will make RCU Tasks Trace
grace periods less CPU-intensive.

[ paulmck: Apply kernel test robot feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 include/linux/rcupdate.h |  18 ++++---
 include/linux/sched.h    |   1 -
 kernel/rcu/tasks.h       | 103 +++++++++++++++++++++++++++------------
 3 files changed, 82 insertions(+), 40 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1a32036c918cd..1e728d544fc1e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -169,13 +169,17 @@ void synchronize_rcu_tasks(void);
 # endif
 
 # ifdef CONFIG_TASKS_TRACE_RCU
-# define rcu_tasks_trace_qs(t)						\
-	do {								\
-		if (!likely(READ_ONCE((t)->trc_reader_checked)) &&	\
-		    !unlikely(READ_ONCE((t)->trc_reader_nesting))) {	\
-			smp_store_release(&(t)->trc_reader_checked, true); \
-			smp_mb(); /* Readers partitioned by store. */	\
-		}							\
+// Bits for ->trc_reader_special.b.need_qs field.
+#define TRC_NEED_QS		0x1  // Task needs a quiescent state.
+#define TRC_NEED_QS_CHECKED	0x2  // Task has been checked for needing quiescent state.
+
+u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new);
+
+# define rcu_tasks_trace_qs(t)							\
+	do {									\
+		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
+		    likely(!READ_ONCE((t)->trc_reader_nesting)))		\
+			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
 	} while (0)
 # else
 # define rcu_tasks_trace_qs(t) do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758f..e6eb5871593e9 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -843,7 +843,6 @@ struct task_struct {
 	int				trc_reader_nesting;
 	int				trc_ipi_to_cpu;
 	union rcu_special		trc_reader_special;
-	bool				trc_reader_checked;
 	struct list_head		trc_holdout_list;
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index bd9f2e24f5c73..7bdc62606816b 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1208,6 +1208,39 @@ void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
 
+/* Load from ->trc_reader_special.b.need_qs with proper ordering. */
+static u8 rcu_ld_need_qs(struct task_struct *t)
+{
+	smp_mb(); // Enforce full grace-period ordering.
+	return smp_load_acquire(&t->trc_reader_special.b.need_qs);
+}
+
+/* Store to ->trc_reader_special.b.need_qs with proper ordering. */
+static void rcu_st_need_qs(struct task_struct *t, u8 v)
+{
+	smp_store_release(&t->trc_reader_special.b.need_qs, v);
+	smp_mb(); // Enforce full grace-period ordering.
+}
+
+/*
+ * Do a cmpxchg() on ->trc_reader_special.b.need_qs, allowing for
+ * the four-byte operand-size restriction of some platforms.
+ * Returns the old value, which is often ignored.
+ */
+u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
+{
+	union rcu_special ret;
+	union rcu_special trs_old = READ_ONCE(t->trc_reader_special);
+	union rcu_special trs_new = trs_old;
+
+	if (trs_old.b.need_qs != old)
+		return trs_old.b.need_qs;
+	trs_new.b.need_qs = new;
+	ret.s = cmpxchg(&t->trc_reader_special.s, trs_old.s, trs_new.s);
+	return ret.b.need_qs;
+}
+EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
+
 /*
  * This irq_work handler allows rcu_read_unlock_trace() to be invoked
  * while the scheduler locks are held.
@@ -1221,16 +1254,20 @@ static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
-	int nq = READ_ONCE(t->trc_reader_special.b.need_qs);
+	int nqs = (rcu_ld_need_qs(t) == (TRC_NEED_QS_CHECKED | TRC_NEED_QS));
 
-	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) &&
-	    t->trc_reader_special.b.need_mb)
+	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB) && t->trc_reader_special.b.need_mb)
 		smp_mb(); // Pairs with update-side barriers.
 	// Update .need_qs before ->trc_reader_nesting for irq/NMI handlers.
-	if (nq)
-		WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
+	if (nqs) {
+		u8 result = rcu_trc_cmpxchg_need_qs(t, TRC_NEED_QS_CHECKED | TRC_NEED_QS,
+						       TRC_NEED_QS_CHECKED);
+
+		WARN_ONCE(result != (TRC_NEED_QS_CHECKED | TRC_NEED_QS),
+			  "%s: result = %d", __func__, result);
+	}
 	WRITE_ONCE(t->trc_reader_nesting, 0);
-	if (nq && atomic_dec_and_test(&trc_n_readers_need_end))
+	if (nqs && atomic_dec_and_test(&trc_n_readers_need_end))
 		irq_work_queue(&rcu_tasks_trace_iw);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
@@ -1260,27 +1297,24 @@ static void trc_read_check_handler(void *t_in)
 	struct task_struct *texp = t_in;
 
 	// If the task is no longer running on this CPU, leave.
-	if (unlikely(texp != t)) {
+	if (unlikely(texp != t))
 		goto reset_ipi; // Already on holdout list, so will check later.
-	}
 
 	// If the task is not in a read-side critical section, and
 	// if this is the last reader, awaken the grace-period kthread.
 	if (likely(!READ_ONCE(t->trc_reader_nesting))) {
-		WRITE_ONCE(t->trc_reader_checked, true);
+		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 		goto reset_ipi;
 	}
 	// If we are racing with an rcu_read_unlock_trace(), try again later.
 	if (unlikely(READ_ONCE(t->trc_reader_nesting) < 0))
 		goto reset_ipi;
-	WRITE_ONCE(t->trc_reader_checked, true);
 
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
-	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
+	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED))
+		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
 
 reset_ipi:
 	// Allow future IPIs to be sent on CPU and for task.
@@ -1291,8 +1325,9 @@ static void trc_read_check_handler(void *t_in)
 }
 
 /* Callback function for scheduler to check locked-down task.  */
-static int trc_inspect_reader(struct task_struct *t, void *arg)
+static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 {
+	struct list_head *bhp = bhp_in;
 	int cpu = task_cpu(t);
 	int nesting;
 	bool ofl = cpu_is_offline(cpu);
@@ -1323,16 +1358,19 @@ static int trc_inspect_reader(struct task_struct *t, void *arg)
 	// If not exiting a read-side critical section, mark as checked
 	// so that the grace-period kthread will remove it from the
 	// holdout list.
-	t->trc_reader_checked = nesting >= 0;
-	if (nesting <= 0)
+	if (nesting <= 0) {
+		if (!nesting)
+			rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 		return nesting ? -EINVAL : 0;  // If in QS, done, otherwise try again later.
+	}
 
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
-	atomic_inc(&trc_n_readers_need_end); // One more to wait on.
-	WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs));
-	WRITE_ONCE(t->trc_reader_special.b.need_qs, true);
+	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED)) {
+		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+		trc_add_holdout(t, bhp);
+	}
 	return 0;
 }
 
@@ -1348,14 +1386,14 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 
 	// The current task had better be in a quiescent state.
 	if (t == current) {
-		t->trc_reader_checked = true;
+		rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 		WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
 		return;
 	}
 
 	// Attempt to nail down the task for inspection.
 	get_task_struct(t);
-	if (!task_call_func(t, trc_inspect_reader, NULL)) {
+	if (!task_call_func(t, trc_inspect_reader, bhp)) {
 		put_task_struct(t);
 		return;
 	}
@@ -1419,8 +1457,7 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 	if (unlikely(t == NULL))
 		return;
 
-	WRITE_ONCE(t->trc_reader_special.b.need_qs, false);
-	WRITE_ONCE(t->trc_reader_checked, false);
+	rcu_st_need_qs(t, 0);
 	t->trc_ipi_to_cpu = -1;
 	trc_wait_for_one_reader(t, hop);
 }
@@ -1442,7 +1479,8 @@ static void rcu_tasks_trace_postscan(struct list_head *hop)
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
 	synchronize_rcu();
-	// Any tasks that exit after this point will set ->trc_reader_checked.
+	// Any tasks that exit after this point will set
+	// TRC_NEED_QS_CHECKED in ->trc_reader_special.b.need_qs.
 }
 
 /* Communicate task state back to the RCU tasks trace stall warning request. */
@@ -1460,7 +1498,7 @@ static int trc_check_slow_task(struct task_struct *t, void *arg)
 		return false; // It is running, so decline to inspect it.
 	trc_rdrp->nesting = READ_ONCE(t->trc_reader_nesting);
 	trc_rdrp->ipi_to_cpu = READ_ONCE(t->trc_ipi_to_cpu);
-	trc_rdrp->needqs = READ_ONCE(t->trc_reader_special.b.need_qs);
+	trc_rdrp->needqs = rcu_ld_need_qs(t);
 	return true;
 }
 
@@ -1514,12 +1552,12 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
 		// If safe and needed, try to check the current task.
 		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
-		    !READ_ONCE(t->trc_reader_checked))
+		    !(rcu_ld_need_qs(t) & TRC_NEED_QS_CHECKED))
 			trc_wait_for_one_reader(t, hop);
 
 		// If check succeeded, remove this task from the list.
 		if (smp_load_acquire(&t->trc_ipi_to_cpu) == -1 &&
-		    READ_ONCE(t->trc_reader_checked))
+		    rcu_ld_need_qs(t) == TRC_NEED_QS_CHECKED)
 			trc_del_holdout(t);
 		else if (needreport)
 			show_stalled_task_trace(t, firstreport);
@@ -1574,12 +1612,12 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 		// Stall warning time, so make a list of the offenders.
 		rcu_read_lock();
 		for_each_process_thread(g, t)
-			if (READ_ONCE(t->trc_reader_special.b.need_qs))
+			if (rcu_ld_need_qs(t) & TRC_NEED_QS)
 				trc_add_holdout(t, &holdouts);
 		rcu_read_unlock();
 		firstreport = true;
 		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list) {
-			if (READ_ONCE(t->trc_reader_special.b.need_qs))
+			if (rcu_ld_need_qs(t) & TRC_NEED_QS)
 				show_stalled_task_trace(t, &firstreport);
 			trc_del_holdout(t); // Release task_struct reference.
 		}
@@ -1595,11 +1633,12 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 /* Report any needed quiescent state for this exiting task. */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t)
 {
-	WRITE_ONCE(t->trc_reader_checked, true);
+	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS_CHECKED);
 	WARN_ON_ONCE(READ_ONCE(t->trc_reader_nesting));
-	WRITE_ONCE(t->trc_reader_nesting, 0);
-	if (WARN_ON_ONCE(READ_ONCE(t->trc_reader_special.b.need_qs)))
+	if (WARN_ON_ONCE(rcu_ld_need_qs(t) & TRC_NEED_QS))
 		rcu_read_unlock_trace_special(t);
+	else
+		WRITE_ONCE(t->trc_reader_nesting, 0);
 }
 
 /**
-- 
2.31.1.189.g2e36527f23

