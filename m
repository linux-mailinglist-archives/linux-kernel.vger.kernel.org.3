Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818724AA44B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378186AbiBDXYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbiBDXYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:24:14 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14323DFC1802;
        Fri,  4 Feb 2022 15:24:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 631BFCE24C7;
        Fri,  4 Feb 2022 23:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F89C340F9;
        Fri,  4 Feb 2022 23:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017048;
        bh=mMQC49huRwtBjDgnnc/hOD/p12a3Ew3u3sUoYjyRRDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i1ksoy/EeSrokEKzsbaaIoEqUxGZYddBUlWaVRa/JzOfrP/ejrTGjeI/YSOZy3Hi9
         26s2YQYLlR14Zb6b+bdStjwh2r6CIHLbvwLMGxfMP8af3u6ff1PSETCtRJp6youaJX
         7/eRDhRzRHq9BLAqQRb3VwI+7UrxesZ1L6J/QEGNhStwnscxcSb4ptc7jaySy2KUFK
         NpiuJH8i988wUh+NLkBZ1IQG7DAnQ4akmGkD2eprcg61fb/G/i0Ok9xBEX6OPKDqEi
         CLBfAR37xbdjyk0+Jdfr3gZYuAPwPeqQYkhQmiRTyv/lcrnNWhZimoBXvmj/Iq89wZ
         lIydMp1zf61EQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D0ED45C0BCB; Fri,  4 Feb 2022 15:24:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Zqiang <qiang1.zhang@intel.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/10] rcu: Add per-CPU rcuc task dumps to RCU CPU stall warnings
Date:   Fri,  4 Feb 2022 15:24:06 -0800
Message-Id: <20220204232406.814-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232355.GA728@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang1.zhang@intel.com>

When the rcutree.use_softirq kernel boot parameter is set to zero, all
RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads.
If these kthreads are being starved, quiescent states will not be
reported, which in turn means that the grace period will not end, which
can in turn trigger RCU CPU stall warnings.  This commit therefore dumps
stack traces of stalled CPUs' rcuc kthreads, which can help identify
what is preventing those kthreads from running.

Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  3 +++
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h |  3 +++
 kernel/rcu/tree_stall.h  | 35 +++++++++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9e4c5b281f003..bd9b2af247abd 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2850,10 +2850,12 @@ static void rcu_cpu_kthread(unsigned int cpu)
 {
 	unsigned int *statusp = this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status);
 	char work, *workp = this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
+	unsigned long *j = this_cpu_ptr(&rcu_data.rcuc_activity);
 	int spincnt;
 
 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
 	for (spincnt = 0; spincnt < 10; spincnt++) {
+		WRITE_ONCE(*j, jiffies);
 		local_bh_disable();
 		*statusp = RCU_KTHREAD_RUNNING;
 		local_irq_disable();
@@ -2874,6 +2876,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
 	schedule_timeout_idle(2);
 	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
 	*statusp = RCU_KTHREAD_WAITING;
+	WRITE_ONCE(*j, jiffies);
 }
 
 static struct smp_hotplug_thread rcu_cpu_thread_spec = {
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9990945483f1..b84cc5742c317 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -239,6 +239,7 @@ struct rcu_data {
 					/* rcuc per-CPU kthread or NULL. */
 	unsigned int rcu_cpu_kthread_status;
 	char rcu_cpu_has_work;
+	unsigned long rcuc_activity;
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 02ac057ba3f83..8167cab1bffc8 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -996,12 +996,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
  */
 static void rcu_cpu_kthread_setup(unsigned int cpu)
 {
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 #ifdef CONFIG_RCU_BOOST
 	struct sched_param sp;
 
 	sp.sched_priority = kthread_prio;
 	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
 #endif /* #ifdef CONFIG_RCU_BOOST */
+
+	WRITE_ONCE(rdp->rcuc_activity, jiffies);
 }
 
 #ifdef CONFIG_RCU_BOOST
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 21bebf7c9030b..0c5d8516516af 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -379,6 +379,15 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
 	return j > 2 * HZ;
 }
 
+static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
+{
+	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
+
+	if (jp)
+		*jp = j;
+	return j > 2 * HZ;
+}
+
 /*
  * Print out diagnostic information for the specified stalled CPU.
  *
@@ -430,6 +439,29 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 }
 
+static void rcuc_kthread_dump(struct rcu_data *rdp)
+{
+	int cpu;
+	unsigned long j;
+	struct task_struct *rcuc;
+
+	rcuc = rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return;
+
+	cpu = task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return;
+
+	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
+		return;
+
+	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
+	sched_show_task(rcuc);
+	if (!trigger_single_cpu_backtrace(cpu))
+		dump_cpu_task(cpu);
+}
+
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -601,6 +633,9 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	if (!use_softirq)
+		rcuc_kthread_dump(rdp);
+
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.31.1.189.g2e36527f23

