Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1B552747
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345298AbiFTWzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344753AbiFTWyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E2BCB5;
        Mon, 20 Jun 2022 15:54:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AD10B8164C;
        Mon, 20 Jun 2022 22:54:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA456C341CF;
        Mon, 20 Jun 2022 22:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765653;
        bh=MmSAflpPPlTEqinw5rOI6w8ljGycvc7qO4CjP+NI4Z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ImEwlwmhNG52NCe/4einZ27mDFBOXTQMIS4nnlhcJtTKFahQEe7RMQmmI9Fw4XmxQ
         v6c8G2LytaxA4hP/F1BvpCydZ3/xtBDyB3XK4gknK7U9rgc7oYVbW6ZzwjfotRiQZz
         53ebt/MeFS3CTUoB//AHorKiSOmYoAP1FJg22/spxQWeCLkJdlIixt74jsBECO+SDs
         RWatNePVaRk2NnVCsHuPF9WzZwdrHzJabjxwWYy9MJQvSUt4X83FX7TcVWtHxVCcWe
         DMGOMAjgct1kn7PwkQZfe9VY7hCqbf6VZ9mDwQbztmwWRrB32e43tXgt32v63Q8TZ8
         qUhY33DHAjmEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3273F5C0B06; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 06/32] rcu-tasks: Remove rcu_tasks_trace_postgp() wait for counter
Date:   Mon, 20 Jun 2022 15:53:45 -0700
Message-Id: <20220620225411.3842519-6-paulmck@kernel.org>
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

Now that tasks are not removed from the list until they have responded to
any needed request for a quiescent state, it is no longer necessary to
wait for the trc_n_readers_need_end counter to go to zero.  This commit
therefore removes that waiting code.

It is therefore also no longer necessary for rcu_tasks_trace_postgp() to
do the final decrement of this counter, so that code is also removed.
This in turn means that trc_n_readers_need_end counter itself can
be removed, as can the rcu_tasks_trace_iw irq_work structure and the
rcu_read_unlock_iw() function.

[ paulmck: Apply feedback from Zqiang. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 62 +++-------------------------------------------
 1 file changed, 3 insertions(+), 59 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 7bdc62606816b..561d24f7f73cc 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1192,9 +1192,6 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-static atomic_t trc_n_readers_need_end;		// Number of waited-for readers.
-static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
-
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
@@ -1241,16 +1238,6 @@ u8 rcu_trc_cmpxchg_need_qs(struct task_struct *t, u8 old, u8 new)
 }
 EXPORT_SYMBOL_GPL(rcu_trc_cmpxchg_need_qs);
 
-/*
- * This irq_work handler allows rcu_read_unlock_trace() to be invoked
- * while the scheduler locks are held.
- */
-static void rcu_read_unlock_iw(struct irq_work *iwp)
-{
-	wake_up(&trc_wait);
-}
-static DEFINE_IRQ_WORK(rcu_tasks_trace_iw, rcu_read_unlock_iw);
-
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
@@ -1267,8 +1254,6 @@ void rcu_read_unlock_trace_special(struct task_struct *t)
 			  "%s: result = %d", __func__, result);
 	}
 	WRITE_ONCE(t->trc_reader_nesting, 0);
-	if (nqs && atomic_dec_and_test(&trc_n_readers_need_end))
-		irq_work_queue(&rcu_tasks_trace_iw);
 }
 EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);
 
@@ -1313,8 +1298,7 @@ static void trc_read_check_handler(void *t_in)
 	// Get here if the task is in a read-side critical section.  Set
 	// its state so that it will awaken the grace-period kthread upon
 	// exit from that critical section.
-	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED))
-		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED);
 
 reset_ipi:
 	// Allow future IPIs to be sent on CPU and for task.
@@ -1367,10 +1351,8 @@ static int trc_inspect_reader(struct task_struct *t, void *bhp_in)
 	// The task is in a read-side critical section, so set up its
 	// state so that it will awaken the grace-period kthread upon exit
 	// from that critical section.
-	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED)) {
-		atomic_inc(&trc_n_readers_need_end); // One more to wait on.
+	if (!rcu_trc_cmpxchg_need_qs(t, 0, TRC_NEED_QS | TRC_NEED_QS_CHECKED))
 		trc_add_holdout(t, bhp);
-	}
 	return 0;
 }
 
@@ -1436,9 +1418,6 @@ static void rcu_tasks_trace_pregp_step(void)
 {
 	int cpu;
 
-	// Allow for fast-acting IPIs.
-	atomic_set(&trc_n_readers_need_end, 1);
-
 	// There shouldn't be any old IPIs, but...
 	for_each_possible_cpu(cpu)
 		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
@@ -1581,10 +1560,6 @@ static void rcu_tasks_trace_empty_fn(void *unused)
 static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
 	int cpu;
-	bool firstreport;
-	struct task_struct *g, *t;
-	LIST_HEAD(holdouts);
-	long ret;
 
 	// Wait for any lingering IPI handlers to complete.  Note that
 	// if a CPU has gone offline or transitioned to userspace in the
@@ -1595,37 +1570,6 @@ static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 		if (WARN_ON_ONCE(smp_load_acquire(per_cpu_ptr(&trc_ipi_to_cpu, cpu))))
 			smp_call_function_single(cpu, rcu_tasks_trace_empty_fn, NULL, 1);
 
-	// Remove the safety count.
-	smp_mb__before_atomic();  // Order vs. earlier atomics
-	atomic_dec(&trc_n_readers_need_end);
-	smp_mb__after_atomic();  // Order vs. later atomics
-
-	// Wait for readers.
-	set_tasks_gp_state(rtp, RTGS_WAIT_READERS);
-	for (;;) {
-		ret = wait_event_idle_exclusive_timeout(
-				trc_wait,
-				atomic_read(&trc_n_readers_need_end) == 0,
-				READ_ONCE(rcu_task_stall_timeout));
-		if (ret)
-			break;  // Count reached zero.
-		// Stall warning time, so make a list of the offenders.
-		rcu_read_lock();
-		for_each_process_thread(g, t)
-			if (rcu_ld_need_qs(t) & TRC_NEED_QS)
-				trc_add_holdout(t, &holdouts);
-		rcu_read_unlock();
-		firstreport = true;
-		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list) {
-			if (rcu_ld_need_qs(t) & TRC_NEED_QS)
-				show_stalled_task_trace(t, &firstreport);
-			trc_del_holdout(t); // Release task_struct reference.
-		}
-		if (firstreport)
-			pr_err("INFO: rcu_tasks_trace detected stalls? (Counter/taskslist mismatch?)\n");
-		show_stalled_ipi_trace();
-		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
-	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
 		  // Pairs with pretty much every ordering primitive.
 }
@@ -1725,7 +1669,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
-	sprintf(buf, "N%d h:%lu/%lu/%lu", atomic_read(&trc_n_readers_need_end),
+	sprintf(buf, "h:%lu/%lu/%lu",
 		data_race(n_heavy_reader_ofl_updates),
 		data_race(n_heavy_reader_updates),
 		data_race(n_heavy_reader_attempts));
-- 
2.31.1.189.g2e36527f23

