Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2C94D7965
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiCNCdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCNCdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:33:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309E117D;
        Sun, 13 Mar 2022 19:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647225157; x=1678761157;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g+d+0vkJ280Um9PBunX28S1AWKf8utX9VSmKKBxPK0A=;
  b=nGVfIb237zpKRLugnu6aiDIxorRTEv4BDxyPvtcWWLR06+H6dJqw3QXI
   TJzOHJc1vanjJg2bD6X2kwul1JQFo5Sv+PIHt5uy+Njz2OhvxGv+JawD5
   rXc8Mx8CghjjGZnI8coOS6lM6kVygcxJZMHEf0G/Wj0h4gK4QRHCAmCP8
   DIl62W6dUbNqB+It9d8U1CtO6NnG4TPrtiCezyCMA7SCXk7u+KlecyG1D
   YfSdXX2b8lgr711BUYeM0+F1LfQZsv6i+0j99hejO8GHSB8nq+NmfhYkB
   4F4Y15Ozuahn8f3dFLfPJ0/Ha5nt5CvVJcnuZqxeCY6dcs9aVMW4kmGZH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="235867972"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="235867972"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:32:37 -0700
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="539767163"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 19:32:32 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     frederic@kernel.org, paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Deoffload rdp if rcuop/rcuog kthreads spawn failed
Date:   Mon, 14 Mar 2022 10:33:14 +0800
Message-Id: <20220314023314.795253-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the rcuop
and rcuog kthreads is created. however the rcuop or rcuog kthreads
creation may fail, if failed, deoffload per-cpu rdp which belong
to rcu_nocb_mask.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Invert the locking dependency order between
 rcu_state.barrier_mutex and hotplug lock.
 
 Holding nocb_gp_kthread_mutex, ensure that
 the nocb_gp_kthread exists.
 
 kernel/rcu/tree_nocb.h | 63 +++++++++++++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 46694e13398a..4ec96d0c11de 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -972,10 +972,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	}
 	raw_spin_unlock_irqrestore(&rdp_gp->nocb_gp_lock, flags);
 
-	if (wake_gp)
-		wake_up_process(rdp_gp->nocb_gp_kthread);
-
-	return 0;
+	return wake_gp;
 }
 
 static long rcu_nocb_rdp_deoffload(void *arg)
@@ -984,11 +981,18 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
+	/*
+	 *When rcuog or rcuop spawn fail, direct call rcu_nocb_rdp_deoffload().
+	 *due to the target CPU(rdp->cpu) is not online(cpu_online(rdp->cpu)
+	 *return false) yet. this warning will be triggered.
+	 */
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	rcu_nocb_lock_irqsave(rdp, flags);
 	/*
 	 * Flush once and for all now. This suffices because we are
@@ -1010,9 +1014,19 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	invoke_rcu_core();
 	ret = rdp_offload_toggle(rdp, false, flags);
-	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
+
+	if (rdp_gp->nocb_gp_kthread) {
+		if (ret)
+			wake_up_process(rdp_gp->nocb_gp_kthread);
+		swait_event_exclusive(rdp->nocb_state_wq,
+				!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
+	} else {
+		rcu_nocb_lock_irqsave(rdp, flags);
+		rcu_segcblist_clear_flags(&rdp->cblist,
+				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+	}
 	/* Stop nocb_gp_wait() from iterating over this structure. */
 	list_del_rcu(&rdp->nocb_entry_rdp);
 	/*
@@ -1030,12 +1044,12 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * rcu_nocb_unlock_irqrestore() anymore.
 	 */
 	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
-
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
 	/* Sanity check */
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 
 
-	return ret;
+	return 0;
 }
 
 int rcu_nocb_cpu_deoffload(int cpu)
@@ -1043,8 +1057,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
@@ -1055,8 +1069,8 @@ int rcu_nocb_cpu_deoffload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1068,6 +1082,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
 	int ret;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
@@ -1077,6 +1092,12 @@ static long rcu_nocb_rdp_offload(void *arg)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
+	if (!rdp_gp->nocb_gp_kthread) {
+		mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+		return -EINVAL;
+	}
+
 	pr_info("Offloading %d\n", rdp->cpu);
 
 	/*
@@ -1112,6 +1133,8 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
 	 */
 	ret = rdp_offload_toggle(rdp, true, flags);
+	if (ret)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
@@ -1123,8 +1146,8 @@ static long rcu_nocb_rdp_offload(void *arg)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
-
-	return ret;
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+	return 0;
 }
 
 int rcu_nocb_cpu_offload(int cpu)
@@ -1132,8 +1155,8 @@ int rcu_nocb_cpu_offload(int cpu)
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	int ret = 0;
 
-	mutex_lock(&rcu_state.barrier_mutex);
 	cpus_read_lock();
+	mutex_lock(&rcu_state.barrier_mutex);
 	if (!rcu_rdp_is_offloaded(rdp)) {
 		if (cpu_online(cpu)) {
 			ret = work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
@@ -1144,8 +1167,8 @@ int rcu_nocb_cpu_offload(int cpu)
 			ret = -EINVAL;
 		}
 	}
-	cpus_read_unlock();
 	mutex_unlock(&rcu_state.barrier_mutex);
+	cpus_read_unlock();
 
 	return ret;
 }
@@ -1246,7 +1269,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 				"rcuog/%d", rdp_gp->cpu);
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
 			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
-			return;
+			goto end;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 		if (kthread_prio)
@@ -1258,12 +1281,20 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 	t = kthread_run(rcu_nocb_cb_kthread, rdp,
 			"rcuo%c/%d", rcu_state.abbr, cpu);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is now expected behavior\n", __func__))
-		return;
+		goto end;
 
 	if (kthread_prio)
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	WRITE_ONCE(rdp->nocb_cb_kthread, t);
 	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
+	return;
+end:
+	mutex_lock(&rcu_state.barrier_mutex);
+	if (rcu_rdp_is_offloaded(rdp)) {
+		rcu_nocb_rdp_deoffload(rdp);
+		cpumask_clear_cpu(cpu, rcu_nocb_mask);
+	}
+	mutex_unlock(&rcu_state.barrier_mutex);
 }
 
 /* How many CB CPU IDs per GP kthread?  Default of -1 for sqrt(nr_cpu_ids). */
-- 
2.25.1

