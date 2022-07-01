Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DD95628D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGACX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiGACXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:23:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16255724A;
        Thu, 30 Jun 2022 19:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656642233; x=1688178233;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dm2Kp7rTBGRDnHsVsTlv/r6TP0GI5km2NCGCtxEZEXU=;
  b=Ek9m7I49vUsXf37af07JoyjE/JOpf+Wx+5wrieLw/NnNkyG45kDpU2VT
   CoV0/rkTN1yYs/ZyTswgbmab7fdaLT0PSu5UETSQeZaKHuo8y0L0aMIpV
   3V8TYSksPDRm01gaAMzzADCstbI3S5vzLXscEDhVbC8S/ci3SpXI+XsNe
   tZxFYNcmnjzpPH1/Q2aDPrslhE0vyH2HnlzxzeUof+5DoaMzjWOlomLZ2
   G+4t/S0u3yH9Y+rVSobodZ9JlHPLdWUs0PxZta9rOgBevjiu43S48rgQt
   6XRSKJ3W33+wOLGj/ide+aVpItGCNY4iz1kudVFSVX5uyFWrHXhLM5g8+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="262932430"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="262932430"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:23:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="596063726"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:23:52 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Make tiny RCU support leak callbacks for debug-object errors
Date:   Fri,  1 Jul 2022 10:23:25 +0800
Message-Id: <20220701022325.2228233-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, only tree RCU support leak callbacks setting when do
duplicate call_rcu(). this commit add leak callbacks setting when
fo duplicate call_rcu() for tiny RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tiny.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c..943d431b908f 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -158,6 +158,10 @@ void synchronize_rcu(void)
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu);
 
+static void tiny_rcu_leak_callback(struct rcu_head *rhp)
+{
+}
+
 /*
  * Post an RCU callback to be invoked after the end of an RCU grace
  * period.  But since we have but one CPU, that would be after any
@@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
+	static atomic_t doublefrees;
 	unsigned long flags;
 
-	debug_rcu_head_queue(head);
+	if (debug_rcu_head_queue(head)) {
+		if (atomic_inc_return(&doublefrees) < 4) {
+			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
+			mem_dump_obj(head);
+		}
+
+		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
+			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
+		return;
+	}
+
 	head->func = func;
 	head->next = NULL;
 
-- 
2.25.1

