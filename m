Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788714DD5CE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 09:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbiCRIIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 04:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiCRIIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 04:08:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954A23575B;
        Fri, 18 Mar 2022 01:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647590806; x=1679126806;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J/A+swafAWcLd7I4r60PvjBlylBDBrndxd23714fhpg=;
  b=Z5BbommqlzEEG1hDX84IBVJhKtzEyyMzOyDORy5eHPmRNlC9nO//d6tl
   7PxaGM2bRDdcdUnZBC2S5X6l8+HC3Aidp+WDPbspHBk+yGSwZNxZFIgU+
   aH7/eAvPqDHfoBPANwAWm5W/csmUv551+gpR6x6JO/X9kH7AxX1zoheUC
   hz8NwG67kiTDSr0RbHh9J6srWoPCDZiSqeebaFUCsKnTYPKO9vJNxt3lm
   i6wa52mwnqn+6mDnTcJlOHke7lBAuAjTQn/GTJmQY06c+fWrFcd5wpktB
   WBjjNoQRr7YN42g6LUWyPtIFetmGOZ7bpONxSZJqph5oG56Glzu6ALFTb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="255917338"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="255917338"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="541734771"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 01:06:41 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] rcu: Call rcu_nocb_rdp_deoffload() directly after rcuog/op kthreads spawn failed
Date:   Fri, 18 Mar 2022 16:07:18 +0800
Message-Id: <20220318080719.1501471-2-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220318080719.1501471-1-qiang1.zhang@intel.com>
References: <20220318080719.1501471-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the rcuog/op kthreads spawn failed, the offload rdp need to
be deoffload, otherwise because target rdp is considered offloaded
but nothing actually handles the callbacks.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_nocb.h | 75 +++++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 46694e13398a..e8265e4ec5ee 100644
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
@@ -983,9 +980,18 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
-	int ret;
+	int wake_gp;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
+	int condition;
 
-	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
+	/*
+	 * The rcu_nocb_rdp_deoffload() will be called directly when
+	 * rcuog/op spawn failed, because at this time the rdp->cpu
+	 * is not online(cpu_online(rdp->cpu) return false), the deoffload
+	 * operation was not performed on rdp->cpu, to avoid warnings
+	 * add cpu_online(rdp->cpu) condition judgment.
+	 */
+	WARN_ON_ONCE((rdp->cpu != raw_smp_processor_id()) && cpu_online(rdp->cpu));
 
 	pr_info("De-offloading %d\n", rdp->cpu);
 
@@ -1009,10 +1015,33 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	invoke_rcu_core();
-	ret = rdp_offload_toggle(rdp, false, flags);
-	swait_event_exclusive(rdp->nocb_state_wq,
-			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
-							SEGCBLIST_KTHREAD_GP));
+	wake_gp = rdp_offload_toggle(rdp, false, flags);
+
+	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
+	if (rdp_gp->nocb_gp_kthread) {
+		if (wake_gp)
+			wake_up_process(rdp_gp->nocb_gp_kthread);
+
+		if (rdp->nocb_cb_kthread) {
+			condition = SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP;
+		} else {
+			/*
+			 *If rcuop kthread spawn failed, direct remove SEGCBLIST_KTHREAD_CB
+			 *just wait SEGCBLIST_KTHREAD_GP to be cleared.
+			 */
+			condition = SEGCBLIST_KTHREAD_GP;
+			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_KTHREAD_CB);
+		}
+		swait_event_exclusive(rdp->nocb_state_wq,
+					!rcu_segcblist_test_flags(cblist, condition));
+	} else {
+		rcu_nocb_lock_irqsave(rdp, flags);
+		rcu_segcblist_clear_flags(&rdp->cblist,
+				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+	}
+	mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
+
 	/* Stop nocb_gp_wait() from iterating over this structure. */
 	list_del_rcu(&rdp->nocb_entry_rdp);
 	/*
@@ -1035,7 +1064,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 
 
-	return ret;
+	return 0;
 }
 
 int rcu_nocb_cpu_deoffload(int cpu)
@@ -1067,7 +1096,8 @@ static long rcu_nocb_rdp_offload(void *arg)
 	struct rcu_data *rdp = arg;
 	struct rcu_segcblist *cblist = &rdp->cblist;
 	unsigned long flags;
-	int ret;
+	int wake_gp;
+	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 
 	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
 	/*
@@ -1077,6 +1107,9 @@ static long rcu_nocb_rdp_offload(void *arg)
 	if (!rdp->nocb_gp_rdp)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!rdp_gp->nocb_gp_kthread))
+		return -EINVAL;
+
 	pr_info("Offloading %d\n", rdp->cpu);
 
 	/*
@@ -1111,7 +1144,9 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 *      WRITE flags               READ callbacks
 	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
 	 */
-	ret = rdp_offload_toggle(rdp, true, flags);
+	wake_gp = rdp_offload_toggle(rdp, true, flags);
+	if (wake_gp)
+		wake_up_process(rdp_gp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
@@ -1124,7 +1159,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
-	return ret;
+	return 0;
 }
 
 int rcu_nocb_cpu_offload(int cpu)
@@ -1246,7 +1281,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
 				"rcuog/%d", rdp_gp->cpu);
 		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM is now expected behavior\n", __func__)) {
 			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
-			return;
+			goto end;
 		}
 		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
 		if (kthread_prio)
@@ -1258,12 +1293,20 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
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

