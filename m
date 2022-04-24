Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730E550CF19
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiDXEUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiDXEUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:20:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5115AE76;
        Sat, 23 Apr 2022 21:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650773852; x=1682309852;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4eLsnr31MDsj0J1PFOknqybgQNzJjiQTO0d6RLgoahg=;
  b=oFoERbTtpzM6fgUffFxJwhPSrItIlqAVRJWOR4SCThyQHn9IeyQ7Z112
   8Wk33SQ2cSJbVC4JwzR0gG1G9gfQ3WFB8r5eAMoetKlJ8Aj+JJJjarwXd
   6dM0bOO0dajnFQQYY8J58plGacB5gylAxuDwkfb3EnSikECHvY2I4MQ37
   gOC7uG+2v79j7za4XgPInQw5+KO1VpIy3CZhhl9t01R7aRcSszuGmgZrw
   yh6zNxupi3Z2oG1/u8wQd969o/pllIbxhu5eLtc/RJXtutZePsm5mpmpz
   ulL/ZvPxIN8OfLnvoZH37M9fyPweYz5kIAAW36R7bFm7enKL4bJbWU6Li
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="327915547"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="327915547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:17:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="557115507"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:17:30 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu: Dump all rcuc kthreads status for CPUs that not report quiescent state
Date:   Sun, 24 Apr 2022 12:17:47 +0800
Message-Id: <20220424041747.3172671-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rcutree.use_softirq is configured, when RCU Stall event
happened, dump status of all rcuc kthreads who due to starvation
prevented grace period ends on CPUs that not report quiescent
state.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 rework rcuc_kthread_dump function
 v2->v3:
 merge this rcuc-stalled information into print_cpu_stall_info()

 kernel/rcu/tree_stall.h | 46 ++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd..3482e37d2e3e 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned long *jp)
 
 static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned long *jp)
 {
-	unsigned long j = jiffies - READ_ONCE(rdp->rcuc_activity);
+	int cpu;
+	struct task_struct *rcuc;
+	unsigned long j;
+
+	rcuc = rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return false;
+
+	cpu = task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return false;
+
+	j = jiffies - READ_ONCE(rdp->rcuc_activity);
 
 	if (jp)
 		*jp = j;
@@ -432,6 +444,8 @@ static void print_cpu_stall_info(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
+	bool rcuc_starved;
+	unsigned long j;
 
 	/*
 	 * We could be printing a lot while holding a spinlock.  Avoid
@@ -449,7 +463,8 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld rcuc=%ld jiffies(%s) %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -462,32 +477,10 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       j, rcuc_starved ? "starved" : "",
 	       falsepositive ? " (false positive?)" : "");
 }
 
-static void rcuc_kthread_dump(struct rcu_data *rdp)
-{
-	int cpu;
-	unsigned long j;
-	struct task_struct *rcuc;
-
-	rcuc = rdp->rcu_cpu_kthread_task;
-	if (!rcuc)
-		return;
-
-	cpu = task_cpu(rcuc);
-	if (cpu_is_offline(cpu) || idle_cpu(cpu))
-		return;
-
-	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
-		return;
-
-	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
-	sched_show_task(rcuc);
-	if (!trigger_single_cpu_backtrace(cpu))
-		dump_cpu_task(cpu);
-}
-
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -659,9 +652,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.25.1

