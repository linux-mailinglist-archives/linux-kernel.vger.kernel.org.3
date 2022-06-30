Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109B9560EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiF3B7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 21:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiF3B7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:59:43 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2847437AB8;
        Wed, 29 Jun 2022 18:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656554382; x=1688090382;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zWWEIZVtQ+BCKbZLvrh8c4Jxk/iLItsP+t8Dcx8I6uY=;
  b=Kpvtfits6miRLq0L/h2Kt5QUpLnBGYL82dGe08xRcYP/zXj34i4MIUXr
   mR4C8lpzmeZLGAamB/U+2nB3CkfoNJ4oArRa8T1zRWt7RwaOW34mv49HA
   ihvUkuDAXxwZ6u2s825zVWHN5qL8n+XDeVNzyHtTFdUKpqGuoQyrdgtD5
   fSjoTdEz9xiVJrhl7jNHSI/7C2rFqm2hpg4FdJqIT/aBFuGOQPWMgS/jd
   0C/4QpkTKy4MxOrbfW6ZD/1phYHn6qoODAckuhv/rn9SMUEAnUCyRodr2
   aSAuHSRflH+fiYUVOXYcoNwWr3ASxMwH3QgSBA5zmQHXLvkGqZHDtKlWF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="282949776"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="282949776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 18:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="647668394"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 18:59:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Make tiny RCU support leak callbacks for debug-object errors
Date:   Thu, 30 Jun 2022 09:59:13 +0800
Message-Id: <20220630015913.1828916-1-qiang1.zhang@intel.com>
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

Currently, only tree RCU support leak callbacks setting when do
duplicate call_rcu(). this commit add leak callbacks setting when
fo duplicate call_rcu() for tiny RCU.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tiny.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index f0561ee16b9c..b3c64cee0313 100644
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
@@ -165,9 +169,18 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
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
+		WRITE_ONCE(head->func, tiny_rcu_leak_callback);
+		return;
+	}
+
 	head->func = func;
 	head->next = NULL;
 
-- 
2.25.1

