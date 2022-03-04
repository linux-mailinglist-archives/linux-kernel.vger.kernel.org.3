Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F44CD101
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 10:25:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236558AbiCDJ0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 04:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236515AbiCDJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 04:26:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D3BEACA0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 01:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646385945; x=1677921945;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rf20lH8dvSrKzCQZ7qSNwerDjNaEqtoBaCfeHoZI2t8=;
  b=QzhgmT0v4XTMkUHJ06iyk+Lx4MswsxkHUcP8XAUy2q4ENzXCaMTxjjwz
   ++9cp8f+mVkDiSLjZ1arUOss/mxLw5hfwaDTgF4VZy/g9WcIX9XhVVhgH
   SJmb3R5Xdu3OjQhZK/frt2WsA7TKpdFMaEHmdeK8SuiDLWs1UaInqcbP+
   jwuMr2F5q84+dwSsA8zw9/bflw4gpEgbInLH7tHt7AZT1Qj+Cqre6+Mcq
   vmkOLvzXIbRrPj3WQThR0uc995UXeOV/HbR0LxIcfy+uq4skn9UwS/GPz
   ECu0LE9lzECT5PtW/7uPuiYcDVaI4c5wMmtATMtSqsNr0KGYxxCquRm0V
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10275"; a="241359425"
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="241359425"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 01:25:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,154,1643702400"; 
   d="scan'208";a="552156638"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 01:25:43 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Only boost rcu reader tasks with lower priority than boost kthreads
Date:   Fri,  4 Mar 2022 17:26:31 +0800
Message-Id: <20220304092631.4123188-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When RCU_BOOST is enabled, the boost kthreads will boosting readers
who are blocking a given grace period, if the current reader tasks
have a higher priority than boost kthreads(the boost kthreads priority
not always 1, if the kthread_prio is set), boosting is useless, skip
current task and select next task to boosting, reduce the time for a
given grace period.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c3d212bc5338..d35b6da66bbd 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -12,6 +12,7 @@
  */
 
 #include "../locking/rtmutex_common.h"
+#include <linux/sched/deadline.h>
 
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
 {
@@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
 	 * section.
 	 */
 	t = container_of(tb, struct task_struct, rcu_node_entry);
+	if (!rnp->exp_tasks && (dl_task(t) || t->prio <= current->prio)) {
+		tb = rcu_next_node_entry(t, rnp);
+		WRITE_ONCE(rnp->boost_tasks, tb);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		goto end;
+	}
+
 	rt_mutex_init_proxy_locked(&rnp->boost_mtx.rtmutex, t);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
 	rnp->n_boosts++;
-
+end:
 	return READ_ONCE(rnp->exp_tasks) != NULL ||
 	       READ_ONCE(rnp->boost_tasks) != NULL;
 }
-- 
2.25.1

