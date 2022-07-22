Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4557D7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 02:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbiGVArh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 20:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVAre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:47:34 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F223695C34;
        Thu, 21 Jul 2022 17:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658450854; x=1689986854;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HBJqZGyWi9totiLB0aQgThUb1NiiNeVNF5WEw5qkAzU=;
  b=Fc217rCG75hflZYUUaf+SXGKcNg8UGhS7SKodAsiEJ050oep+mrlLQCw
   0jbmB4i9TbG8QHgUdi8FeAidwGq1nUz48hESpFWY06X9n8mYau+aHAYRv
   rgKfqsr2UOvzyAXnD4plCA4WqSEJUqP2lO33BbiO5K1as2y1SLs6zEkzJ
   IthysamgPQNXGpJtQT6827K/9xyXdsZHqyk5H2dDLUhZ1oASGqP0YMGj/
   nqSM8chCsDvOL0BW0T7yYkXrPQ7e9CZaKgHxUY5YrV8qE7nUyrMhwzz6v
   bbmB9ghdftDn3iw6HUWaXGkV9rNco9iyEP5TTUDoy6A+rwQbrYz2kEODI
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288377322"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="288377322"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:47:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="656997021"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 17:47:23 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Only check tasks blocked on leaf rcu_nodes for PREEMPT_RCU
Date:   Fri, 22 Jul 2022 08:52:13 +0800
Message-Id: <20220722005213.3511188-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PREEMPT_RCU kernel, for multi-node rcu tree, if the RCU read
critical section is preempted, the current task are only queued
leaf rcu_node blkd list, for single-node rcu tree, the root node
is also leaf node.

This commit add rcu_is_leaf_node() to filter out checks for non-leaf
rcu_node.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b2219577fbe2..a9df11ec65af 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -693,6 +693,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	raw_lockdep_assert_held_rcu_node(rnp);
+	if (!rcu_is_leaf_node(rnp))
+		goto end;
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
@@ -703,6 +705,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 		trace_rcu_unlock_preempted_task(TPS("rcu_preempt-GPS"),
 						rnp->gp_seq, t->pid);
 	}
+end:
 	WARN_ON_ONCE(rnp->qsmask);
 }
 
@@ -1178,7 +1181,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
  */
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
-	rnp->boost_time = jiffies + RCU_BOOST_DELAY_JIFFIES;
+	if (rcu_is_leaf_node(rnp))
+		rnp->boost_time = jiffies + RCU_BOOST_DELAY_JIFFIES;
 }
 
 /*
-- 
2.25.1

