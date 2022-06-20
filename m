Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6E1552752
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiFTW4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbiFTWy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7223A1F618;
        Mon, 20 Jun 2022 15:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1473FB8165D;
        Mon, 20 Jun 2022 22:54:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D223C341EF;
        Mon, 20 Jun 2022 22:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765654;
        bh=giwal7B0Xhnd3dcOKf57ftlTXh3Gk11OBNYUshIKnIQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ozWMv9pZ0LLjrTfBJxkyuGmozDFWx8bjp/1nJ4iyZKDKo5ZOiwxf60P4Q/9aRVT7i
         TlwaK7PqGtgPy50n1lWTg6aAQ0z88kX/0dod6Eeg3sD9s2QomG45U7dMqBynZBKAai
         0yyh9M3q4r5XIYEEBsJUdRm8PfuVYc6lcdjRkZYsNXnFLaKtKPShFQBR/RfbNnyYq2
         2GzjTqRx63oetGc3EWtELVzD6PI+PMu4mcExtB9Mb9qy930KZg8opTN6c3gpWrH6JJ
         JWw3da+4rxe+xkeEecFR8naTFHuOjYasULChM6eH5JQbyiK65/4eVlSIFQHQEhEMX1
         bhorOu+Qw/d9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5413A5C13B9; Mon, 20 Jun 2022 15:54:13 -0700 (PDT)
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
Subject: [PATCH rcu 23/32] rcu-tasks: Scan running tasks for RCU Tasks Trace readers
Date:   Mon, 20 Jun 2022 15:54:02 -0700
Message-Id: <20220620225411.3842519-23-paulmck@kernel.org>
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

A running task might be within an RCU Tasks Trace read-side critical
section for any length of time, but will not be placed on any of the
per-CPU rcu_tasks_percpu structure's ->rtp_blkd_tasks lists.  Therefore
any RCU Tasks Trace grace-period processing that does not scan the full
task list must interact with the running tasks.

This commit therefore causes the rcu_tasks_trace_pregp_step() function
to IPI each CPU in order to place the corresponding task on the holdouts
list and to record whether or not it was in an RCU Tasks Trace read-side
critical section.  Yes, it is possible to avoid adding it to that list
if it is not a reader, but that would prevent the system from remembering
that this task was in a quiescent state.  Which is why the running tasks
are unconditionally added to the holdout list.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <kafai@fb.com>
Cc: KP Singh <kpsingh@kernel.org>
---
 kernel/rcu/tasks.h | 51 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 1aa6a24a9bc2b..a8f95864c921a 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -14,7 +14,7 @@
 
 struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
-typedef void (*pregp_func_t)(void);
+typedef void (*pregp_func_t)(struct list_head *hop);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
 typedef void (*postscan_func_t)(struct list_head *hop);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
@@ -661,7 +661,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	struct task_struct *t;
 
 	set_tasks_gp_state(rtp, RTGS_PRE_WAIT_GP);
-	rtp->pregp_func();
+	rtp->pregp_func(&holdouts);
 
 	/*
 	 * There were callbacks, so we need to wait for an RCU-tasks
@@ -791,7 +791,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 // disabling.
 
 /* Pre-grace-period preparation. */
-static void rcu_tasks_pregp_step(void)
+static void rcu_tasks_pregp_step(struct list_head *hop)
 {
 	/*
 	 * Wait for all pre-existing t->on_rq and t->nvcsw transitions
@@ -1449,24 +1449,48 @@ static void trc_wait_for_one_reader(struct task_struct *t,
 	}
 }
 
-/* Do first-round processing for the specified task. */
-static void rcu_tasks_trace_pertask(struct task_struct *t,
-				    struct list_head *hop)
+/*
+ * Initialize for first-round processing for the specified task.
+ * Return false if task is NULL or already taken care of, true otherwise.
+ */
+static bool rcu_tasks_trace_pertask_prep(struct task_struct *t, bool notself)
 {
 	// During early boot when there is only the one boot CPU, there
 	// is no idle task for the other CPUs.	Also, the grace-period
 	// kthread is always in a quiescent state.  In addition, just return
 	// if this task is already on the list.
-	if (unlikely(t == NULL) || t == current || !list_empty(&t->trc_holdout_list))
-		return;
+	if (unlikely(t == NULL) || (t == current && notself) || !list_empty(&t->trc_holdout_list))
+		return false;
 
 	rcu_st_need_qs(t, 0);
 	t->trc_ipi_to_cpu = -1;
-	trc_wait_for_one_reader(t, hop);
+	return true;
+}
+
+/* Do first-round processing for the specified task. */
+static void rcu_tasks_trace_pertask(struct task_struct *t, struct list_head *hop)
+{
+	if (rcu_tasks_trace_pertask_prep(t, true))
+		trc_wait_for_one_reader(t, hop);
+}
+
+/*
+ * Get the current CPU's current task on the holdout list.
+ * Calls to this function must be serialized.
+ */
+static void rcu_tasks_trace_pertask_handler(void *hop_in)
+{
+	struct list_head *hop = hop_in;
+	struct task_struct *t = current;
+
+	// Pull in the currently running task, but only if it is currently
+	// in an RCU tasks trace read-side critical section.
+	if (rcu_tasks_trace_pertask_prep(t, false))
+		trc_add_holdout(t, hop);
 }
 
 /* Initialize for a new RCU-tasks-trace grace period. */
-static void rcu_tasks_trace_pregp_step(void)
+static void rcu_tasks_trace_pregp_step(struct list_head *hop)
 {
 	int cpu;
 
@@ -1474,9 +1498,14 @@ static void rcu_tasks_trace_pregp_step(void)
 	for_each_possible_cpu(cpu)
 		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
 
-	// Disable CPU hotplug across the tasklist scan.
+	// Disable CPU hotplug across the CPU scan.
 	// This also waits for all readers in CPU-hotplug code paths.
 	cpus_read_lock();
+
+	// These smp_call_function_single() calls are serialized to
+	// allow safe access to the hop list.
+	for_each_online_cpu(cpu)
+		smp_call_function_single(cpu, rcu_tasks_trace_pertask_handler, hop, 1);
 }
 
 /*
-- 
2.31.1.189.g2e36527f23

