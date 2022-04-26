Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F38950F19E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiDZHDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343583AbiDZHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:03:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD165A7;
        Tue, 26 Apr 2022 00:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650956420; x=1682492420;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9I1hHVxk/98J86IJBuypvXdSk+3wv9Y4DMZ0GVE3jy4=;
  b=Xhby8Fq1Btgib//VT9f/q1O7Wkbe44DJ5IBOg/3+Uk6EK2Jin1s4f2i7
   Mlfu0Cw6KGhbKogU3ktsB+FYH/Y+OVbGco9Xzq0nQWfIzzXQQ0ByYAtf0
   3F9RbpliBooGUSix9Ss16vjZ9D8RvwlzVSMoG2/6K7Lt4wIdnZqPL5qtP
   +fZr/1XK+YecncZDmB/UBA+asJGPf+1nZmwYQfzTF6Nlh8DM+zUdF6pxD
   SGKcSQTqKwgzTUpTl7mQAd5i3ZnH2B4NcPpt60pye/fWcVWpY79OYXL+t
   I5Aes4rkifmynhSETxD5e+YZdphrpG/mvyXngBLT2SbnQHgAXUq+DRQd4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264999090"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264999090"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:00:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579722327"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:00:16 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
Date:   Tue, 26 Apr 2022 15:00:31 +0800
Message-Id: <20220426070031.3759998-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

 kernel/rcu/tree.c        |  4 ++--
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 12 +++++++++---
 3 files changed, 12 insertions(+), 6 deletions(-)

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
index 971bb6a00ede..120bade40e02 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1155,9 +1155,15 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
  * Is the current CPU running the RCU-callbacks kthread?
  * Caller must have preemption disabled.
  */
-static bool rcu_is_callbacks_kthread(void)
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
 {
-	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
+	bool ret;
+#ifdef CONFIG_RCU_NOCB_CPU
+	ret = rdp->rcu_cpu_kthread_task == current || rdp->nocb_cb_kthread == current;
+#else
+	ret = rdp->rcu_cpu_kthread_task == current;
+#endif
+	return ret;
 }
 
 #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
@@ -1242,7 +1248,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
-static bool rcu_is_callbacks_kthread(void)
+static bool rcu_is_callbacks_kthread(struct rcu_data *rdp)
 {
 	return false;
 }
-- 
2.25.1

