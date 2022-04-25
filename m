Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3F150D671
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiDYBGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDYBGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:06:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80A072440;
        Sun, 24 Apr 2022 18:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650848629; x=1682384629;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iZS+98Xl33K6rmKKZ7NI1zRHdkd/31tlWUvecI4w6Rs=;
  b=B9QjH8/9VczX0n3ZiV3wrxf+s378mB0FxiFgX9ZNvnlKpNGF0f34/KKx
   D+qUj3qggJ4qFpMvt+4kIeV+QcCDpPpC0QXzGcQJA1jvtbG431KXCuSV+
   Iz9gqoqlL3I3lrRqZEcs/K16eqo+9o00b9DyLxOREPS7jfDj4CP1kR/Z1
   A5tTdvO5lz0/ZR8weDjDjBe8P8WrXOTo8XKLsGL6GoArUM2EbVdru0r7z
   6xE6CmlWy3SoF2/UbTTFTyKOJaHx6YM0mzbreCi49+a9dZDuYaYhX5Ar2
   RBwFvypBYlTyk08mIKZCpvg1UTKlgeqHXzOpiQPHvZfJnMEXheHcdRVpK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245032855"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245032855"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 18:03:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="531858966"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 18:03:47 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not report quiescent state
Date:   Mon, 25 Apr 2022 09:04:04 +0800
Message-Id: <20220425010404.3249118-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 v3->v4:
 print rcuc info only when rcuc kthread is starved

 kernel/rcu/tree_stall.h | 49 ++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd..a3d33c471cbb 100644
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
@@ -432,6 +444,9 @@ static void print_cpu_stall_info(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
+	bool rcuc_starved;
+	unsigned long j;
+	char buf[32];
 
 	/*
 	 * We could be printing a lot while holding a spinlock.  Avoid
@@ -449,7 +464,10 @@ static void print_cpu_stall_info(int cpu)
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive = rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
+	if (rcuc_starved)
+		sprintf(buf, "rcuc=%ld jiffies(starved)", j);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -462,32 +480,10 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       rcuc_starved ? buf : "",
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
@@ -659,9 +655,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.25.1

