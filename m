Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D053E231
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiFFGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiFFGwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:52:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94FDEEBE;
        Sun,  5 Jun 2022 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654498315; x=1686034315;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lWJayWC+staOdZ40XU6uHst+Ynull2hx6DziD79g4Ug=;
  b=KXVvlVAELobOmZdYOyE70j/Y3PvNT3nHNn7HhZ9J7FPgiNzGEr/3TA4J
   Q56v2uKc4M87xmKLLBzX/+UJ0l/ARzyHwvCJ+9JWGMtiJ8AtlWqct6JeR
   +fEdDBJ/mR/yzvwaiMUqnnbLliqjvMCq33+usKQhG9ymeRtnuMkdnas9e
   dw9RR5cLr3R1TzmWowR+VffWhQv9mFJA/D9CK/G2nX5v2Sxz94wXvxnIc
   lpHFOeJ/QRyq1YLP//E4mDSXXKiY32GoGV7xW0sondWOIIP986SRlM9u2
   yJEE2ekufXT1d2RqTPQzHOSENryHSocR+etaVFm/d/Lvyae/FI5UlSr8t
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="276804680"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="276804680"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 23:51:54 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="906405442"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 23:51:53 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list is empty
Date:   Mon,  6 Jun 2022 14:51:43 +0800
Message-Id: <20220606065143.3159643-1-qiang1.zhang@intel.com>
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
 kernel/rcu/tree_nocb.h | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fa8e4f82e60c..c25c3e3dd22d 100644
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
@@ -980,7 +984,7 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
 	// Queue this rdp for add/del to/from the list to iterate on rcuog
 	WRITE_ONCE(rdp_gp->nocb_toggling_rdp, rdp);
-	if (rdp_gp->nocb_gp_sleep) {
+	if (rcu_nocb_poll || rdp_gp->nocb_gp_sleep) {
 		rdp_gp->nocb_gp_sleep = false;
 		wake_gp = true;
 	}
-- 
2.25.1

