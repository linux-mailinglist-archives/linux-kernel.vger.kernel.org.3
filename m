Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E250DB0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 10:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiDYI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 04:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiDYI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 04:26:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6FFB;
        Mon, 25 Apr 2022 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650874974; x=1682410974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fs5r7SCejOS8+tb4FKodBTpfeoXJa+CK9exRh/wfoag=;
  b=aaOcFtzBKT6kmB5vvjeKATgy+IU4nU1IlWJKb34a2HDjDhdklAZ9eyN/
   tohtH4vRcGDrvt82pqfJDaEEU3cMIVFhOmfP8ZoKC8MgzrFxnAHVI3mYB
   SCUQxtNKuyl7C5J/YQZcVSTkSe1N/G+kiE8i73axq3QSzjOKgeB80Gq9N
   voFHFRlXJ7QLaXYXnv36YmeXr/WdrJh0CXy7h/oTR+2u9/3Tl9J7wB5wl
   L4bK4qaFquJrgSq7yZ95gufOtYfidUiSQ7pdv995xOlOXczQ6l8Jov3ms
   MW7IXW0yoPQX4UYa2tlLngZQE+c8XXGLoK9sp8vGfQC6oqOEktyDEk0sV
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264699113"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="264699113"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 01:22:54 -0700
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="557613746"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 01:22:52 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Add nocb_cb_kthread check to rcu_is_callbacks_kthread()
Date:   Mon, 25 Apr 2022 16:23:09 +0800
Message-Id: <20220425082309.3328723-1-qiang1.zhang@intel.com>
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
callback function be exected in the rcuop kthreads.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 971bb6a00ede..845dbfc876a2 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1157,7 +1157,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
  */
 static bool rcu_is_callbacks_kthread(void)
 {
-	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
+	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current ||
+		__this_cpu_read(rcu_data.nocb_cb_kthread) == current;
 }
 
 #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
-- 
2.25.1

