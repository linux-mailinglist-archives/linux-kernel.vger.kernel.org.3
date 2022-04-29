Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB745149B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358700AbiD2Mpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiD2Mpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:45:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003366E56E;
        Fri, 29 Apr 2022 05:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651236136; x=1682772136;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kif4J8NHyKPwG1Wd4hFuBZVz+W+IBHoB7a1ZfZURwl8=;
  b=nZ8BQbW9EI39ib0ULG/Q+EUfpRIQjMi2GStL55czdSndxolaEeyzdNv/
   s8KNbNv/Yg/7r8/r4hLeEdReaEZ+EsEwNrmoZCcWdHBLt02nih0hX+7ux
   Ot4BclIkplZCABat99uVIgPJSXhBoUCsaJUq5GEZPW8Ukgsf38oMQtcWl
   m0oekyKKfJMzSQDsS9ngdNML0+3y3ybhI63erfPVjSYt+mJlKVB9FeTky
   VIKsjSXfjddM3zfshnKa6UYGowUBavdhzGu1TTkWo51o8J/R6GpWO/V29
   cYUtEVlM4eu8pJecotNrHN20BKS0f/MTyIcKCvI4feFzazct7E2Hcgbki
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="247192037"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="247192037"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:42:16 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="582106612"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 05:42:11 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3] rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
Date:   Fri, 29 Apr 2022 20:42:22 +0800
Message-Id: <20220429124222.1288501-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At present, there are two situations which the rcu callback function
be exectued in the kthreads, one is if the use_softirq is set to zero,
the RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads,
for non-offload rdp, the rdp's rcu callback function be exectued in rcuc
kthreads. another one is if the rdp is set to offloaded, the rdp's rcu
callback function be exectued in the rcuop kthreads.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 fix compilation error when CONFIG_RCU_NOCB_CPU is no define
 v2->v3:
 define a function that tests "nocb_cb_kthread == current"
 in CONFIG_RCU_NOCB_CPU=y kernels and just returns "false" otherwise
 
 let rcu_is_callbacks_kthread() not depend on CONFIG_RCU_BOOST

 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 33 +++++++++++++++++++--------------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 5c587e00811c..9dc4c4e82db6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2610,7 +2610,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 		trace_rcu_batch_end(rcu_state.name, 0,
 				    !rcu_segcblist_empty(&rdp->cblist),
 				    need_resched(), is_idle_task(current),
-				    rcu_is_callbacks_kthread());
+				    rcu_is_callbacks_kthread(rdp));
 		return;
 	}
 
@@ -2688,7 +2688,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	rcu_nocb_lock_irqsave(rdp, flags);
 	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
-			    is_idle_task(current), rcu_is_callbacks_kthread());
+			    is_idle_task(current), rcu_is_callbacks_kthread(rdp));
 
 	/* Update counts and requeue any remaining callbacks. */
 	rcu_segcblist_insert_done_cbs(&rdp->cblist, &rcl);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 996387962de3..3cdc18997a38 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -433,7 +433,7 @@ static void rcu_flavor_sched_clock_irq(int user);
 static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
-static bool rcu_is_callbacks_kthread(void);
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 440d9e02a26e..99cde4c94769 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1012,6 +1012,25 @@ static void rcu_cpu_kthread_setup(unsigned int cpu)
 	WRITE_ONCE(rdp->rcuc_activity, jiffies);
 }
 
+static bool rcu_is_callbacks_nocb_kthread(struct rcu_data *rdp)
+{
+#ifdef CONFIG_RCU_NOCB_CPU
+	return rdp->nocb_cb_kthread == current;
+#else
+	return false;
+#endif
+}
+
+/*
+ * Is the current CPU running the RCU-callbacks kthread?
+ * Caller must have preemption disabled.
+ */
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
+{
+	return rdp->rcu_cpu_kthread_task == current ||
+			rcu_is_callbacks_nocb_kthread(rdp);
+}
+
 #ifdef CONFIG_RCU_BOOST
 
 /*
@@ -1151,15 +1170,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	}
 }
 
-/*
- * Is the current CPU running the RCU-callbacks kthread?
- * Caller must have preemption disabled.
- */
-static bool rcu_is_callbacks_kthread(void)
-{
-	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
-}
-
 #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
 
 /*
@@ -1242,11 +1252,6 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
-static bool rcu_is_callbacks_kthread(void)
-{
-	return false;
-}
-
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
 }
-- 
2.25.1

