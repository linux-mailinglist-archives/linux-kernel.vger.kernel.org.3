Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEFE53F79F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 09:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiFGHvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 03:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiFGHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:51:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE6C9664;
        Tue,  7 Jun 2022 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654588270; x=1686124270;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uK91ZcW1W7x+yvwxlB6uEa0V46hkzdc1gVduu3AMBJA=;
  b=GiLLI+0492aCiXaGYLkvYFSzIvGspTrsSwNeu3a+wsCL+5BRcaK349uu
   fzsCBBFgKck6Kt/44nB+cSBQU5JDSWadz/yMvaT17eDiWogXfnx7pBuF2
   CPxVBXGhvfUS7ipTG7t2qKmXbq2rTuXX2Gm1F7nBmCL5ec+eg/fBfSKLd
   p3M8hVOECBuE5yw6aNkATQTksMCZfZjJjbPKdrmc876d5ekQamTpXlXSV
   Zc5njEU6PF3vUNbK8kFwy8EySqqd29XhgQ1KMLq0UHHm96jgom01AuhLu
   /ItMgy+4LmlZomNq7DI99KIPVyrJYUn5sP9FrZ23WpOz95Rqt/wb9Uyrs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363054959"
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="363054959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:51:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="636008143"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 00:51:08 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list is empty
Date:   Tue,  7 Jun 2022 15:50:57 +0800
Message-Id: <20220607075057.909070-1-qiang1.zhang@intel.com>
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

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 Move rcu_nocb_poll flags check from rdp_offload_toggle() to
 rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of
 rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set
 the rdp_gp->nocb_gp_sleep is not used.

 kernel/rcu/tree_nocb.h | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..2a52c9abc681 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 				   TPS("WakeBypassIsDeferred"));
 	}
 	if (rcu_nocb_poll) {
-		/* Polling, so trace if first poll in the series. */
-		if (gotcbs)
-			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
-		schedule_timeout_idle(1);
+		if (list_empty(&my_rdp->nocb_head_rdp)) {
+			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
+		} else {
+			/* Polling, so trace if first poll in the series. */
+			if (gotcbs)
+				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
+			schedule_timeout_idle(1);
+		}
 	} else if (!needwait_gp) {
 		/* Wait for callbacks to appear. */
 		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
@@ -1030,7 +1034,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
 	if (rdp_gp->nocb_gp_kthread) {
-		if (wake_gp)
+		if (wake_gp || rcu_nocb_poll)
 			wake_up_process(rdp_gp->nocb_gp_kthread);
 
 		/*
@@ -1152,7 +1156,7 @@ static long rcu_nocb_rdp_offload(void *arg)
 	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
 	 */
 	wake_gp = rdp_offload_toggle(rdp, true, flags);
-	if (wake_gp)
+	if (wake_gp || rcu_nocb_poll)
 		wake_up_process(rdp_gp->nocb_gp_kthread);
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
-- 
2.25.1

