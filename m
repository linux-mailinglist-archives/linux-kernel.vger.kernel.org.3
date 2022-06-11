Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0960654740D
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 13:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiFKLBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 07:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiFKLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 07:01:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6245D13EB2;
        Sat, 11 Jun 2022 04:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654945259; x=1686481259;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4leKXDQUXZ64qSpn4lsd80iVr7ZStmm6WSA/DgDjVYE=;
  b=nTT04OQvu7SZd0AxGxVXDknnrH11IrH7FfQwkXp4TEnaSIvU04uUGDVO
   nJzOmEUgx6N4MU7l2c4oJZkS+8WJGI4cIUHf2XQoGaGGMOc+jzFAfDMyz
   yBUiqIwdtl5WXYGsyYSP4JcZ3SnUJF91dKh893AiYT+nEhPrta/WvO/pN
   oHgx2aga/iM4mWDPumsd8thrJjfpQuiIlCAVImvr+JBlnM2Gf6GYq+yNs
   bOAnDF1Us2Uwo3LyZ0GNIUbyPBhzvpYxfCoM1XGNQTjVA13YtR1eCELQ9
   +tBH72hCgUr8kTt2OGHqONUYYzseqFyopxothMdf4UAlEDV2IUzQFUUEd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="364197859"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="364197859"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 04:00:59 -0700
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="638653264"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 04:00:57 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list is empty
Date:   Sat, 11 Jun 2022 19:00:44 +0800
Message-Id: <20220611110044.2999157-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog kthreads
enter polling mode. however, due to only insert CPU's rdp which belong to
rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp served by rcuog
kthread have been de-offloaded, these cause the 'nocb_head_rdp' list
served by rcuog kthread is empty, when the 'nocb_head_rdp' is empty,
the rcuog kthread in polling mode not actually do anything. fix it by
exiting polling mode when the 'nocb_head_rdp'list is empty, otherwise
entering polling mode.

Co-developed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Move rcu_nocb_poll flags check from rdp_offload_toggle() to 
 rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of 
 rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the 
 rdp_gp->nocb_gp_sleep is not used.
 
 v2->v3:
 When nocb_head_rdp list is empty. put rcuog kthreads in nocb_gp_wq
 waitqueue to wait offloading.

 kernel/rcu/tree_nocb.h | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..a8f574d8850d 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -584,6 +584,14 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
 	return ret;
 }
 
+static void nocb_gp_sleep(struct rcu_data *my_rdp, int cpu)
+{
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
+	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
+					!READ_ONCE(my_rdp->nocb_gp_sleep));
+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+}
+
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
  * or for grace periods to end.
@@ -701,13 +709,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		/* Polling, so trace if first poll in the series. */
 		if (gotcbs)
 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_idle(1);
+		if (list_empty(&my_rdp->nocb_head_rdp)) {
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			if (!my_rdp->nocb_toggling_rdp)
+				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+			/* Wait for any offloading rdp */
+			nocb_gp_sleep(my_rdp, cpu);
+		} else {
+			schedule_timeout_idle(1);
+		}
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
-				!READ_ONCE(my_rdp->nocb_gp_sleep));
-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
+		nocb_gp_sleep(my_rdp, cpu);
 	} else {
 		rnp = my_rdp->mynode;
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
-- 
2.25.1

