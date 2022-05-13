Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC0525909
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359772AbiEMAnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359748AbiEMAmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:42:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3E606CF;
        Thu, 12 May 2022 17:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652402573; x=1683938573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=f0Bj2hl1ZLW1ooL5JR+fXxS9kZj/CvEAmF8lk44pGEQ=;
  b=S9gJlVHB46R2JI1Y+nFNIH02KeCvJev2v8WvrGtasSsvoie/ZtKBp2yB
   igye8QY/9naEvhMbRZZLN1+FS66SPNJ5Cqp5kQDmN8vBPIcbiOW87Gu9l
   0mvoq+eSdSY//2sBEXr577RibuEhPlcwmQzknDK5KxuBR4DoDDyUMLwGB
   2xyDebH6CVmUIz0n2hZp1M88G7mrmkqvZ+XINPYYcygwrpgcXA60pGWfV
   ysF0KPOXSEyBpkOMKXNt2YFEI6szbe9xag964efYiFFM103JFu0gvxpY2
   sUaq5cLmx3DFgCFrk/vxWnl/uSUAVydjvBsN5lxLvxeqUzLYRJWTmK+09
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="250707258"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="250707258"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:42:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="594954182"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 17:42:50 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Date:   Fri, 13 May 2022 08:42:55 +0800
Message-Id: <20220513004256.465233-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal grace
period will be treated as expedited grace period, the gp_tasks that block
current grace period needs to be boosted unconditionally, therefore this
commit adds Kconfig check in rcu_initiate_boost().

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 99cde4c94769..a60f2edf8e59 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
+	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
+			IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
 		if (rnp->exp_tasks == NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-- 
2.25.1

