Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32B49776E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236092AbiAXCgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:36:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:17323 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232730AbiAXCgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:36:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642991803; x=1674527803;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4W/6d6ox9WDAH5pYObFQvG8KomKWbqV8TpEAHOtdqSw=;
  b=llVH3448d1WZcoI5jl3tbnLDRByBPBwRnZ2DamfbAMXUkzUf3QQ09X2d
   hfuAgQmfbvwV9JYi0js4ivgN+g/BhUaHRf0c8CUSOOWYdPGe79HZOmTjG
   LiVb7PNBNsC3RpUNrokrBEFnsWnO861sM/vlY/SedUcouDtNgKnXSQPF2
   dkbZququiJ3YJ9hCZ6ot897VhCQGWioYQKio0w2RJ/a0VU5olbSfK69y5
   vYC9AaWrkIMgFmDrUl4VWW5NOF4B3zNIIS/8uBy63jtr3C/Cia7kyYNyc
   Iy7OSMKW6epPY/cda5RoE6m1SsMUyuFIaBKoIvbBZPG1Ptd5TJMfTngr1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243542702"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243542702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 18:36:43 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="627328890"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 18:36:41 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, qiang1.zhang@intel.com
Subject: [PATCH v2] rcu: Add per-CPU rcuc task info to RCU CPU stall warnings
Date:   Mon, 24 Jan 2022 18:36:37 +0800
Message-Id: <20220124103637.4001386-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the 'use_softirq' be set zero, all RCU_SOFTIRQ processing
be moved to per-CPU rcuc kthreads, if the rcuc kthreads is
being starved, quiescent state can not report in time. the
RCU stall may be triggered. this commit adds a stack trace of
this CPU and dump rcuc kthreads stack to help analyze what
prevents rcuc kthreads from running.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Avoid print anything when CPU is offline or idle. 

 kernel/rcu/tree.c        |  3 +++
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h |  3 +++
 kernel/rcu/tree_stall.h  | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a4c25a6283b0..e3fc31a0f546 100644
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
index 486fc901bd08..4e0fdebb62e8 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -237,6 +237,7 @@ struct rcu_data {
 					/* rcuc per-CPU kthread or NULL. */
 	unsigned int rcu_cpu_kthread_status;
 	char rcu_cpu_has_work;
+	unsigned long rcuc_activity;
 
 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c5b45c2f68a1..327bbfd79cc6 100644
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
index 21bebf7c9030..739a2d87ea5e 100644
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
@@ -430,6 +439,30 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 }
 
+static void rcuc_kthread_dump(struct rcu_data *rdp)
+{
+	int cpu;
+	unsigned long j;
+	struct task_struct *rcuc = rdp->rcu_cpu_kthread_task;
+
+	if (rcu_is_rcuc_kthread_starving(rdp, &j)) {
+		cpu = rcuc ? task_cpu(rcuc) : -1;
+
+		if (rcuc) {
+			pr_err("%s kthread starved for %ld jiffies, stack dump:\n",
+									rcuc->comm, j);
+			sched_show_task(rcuc);
+			if (cpu >= 0) {
+				if (cpu_online(cpu) && !idle_cpu(cpu)) {
+					pr_err("Dump current CPU stack:\n");
+					if (!trigger_single_cpu_backtrace(cpu))
+						dump_cpu_task(cpu);
+				}
+			}
+		}
+	}
+}
+
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -601,6 +634,9 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
+	if (!use_softirq)
+		rcuc_kthread_dump(rdp);
+
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.25.1

