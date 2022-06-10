Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCCD545C29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243835AbiFJGXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238058AbiFJGXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:23:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C638B;
        Thu,  9 Jun 2022 23:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654842186; x=1686378186;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PnXBQqxy9yzsBXKrhBQsOZS87hCxSeJlHsctj92hs2s=;
  b=Np9ybPLGs1bGYvukTzkKaLQsagQESiGpi7iRF+Kbnwm4aGYePvA0Jhiz
   hU5SCxAy9jxgv/a4Mmlu7AN8xJYoSHVwvwTR4yFpPzbDxY+mxmyohjijX
   2BZbj68k7rBb+4Vo4V60W/T++gE5/yeh0+mf5I8XLomQUy+5/Uo49q7u0
   RXPZl9Yw8bLsZH7bHPHERU4N7E9pEGKjgjqsjBgYvEsHvsO2CG0PJwP3L
   yR3Zkdcd9fnGvFg+W/hu+vFT3dSgFA/VvC1g+IDMHkxtB8afuu7uRHwhe
   px6gtiqkQA60i+v0stsTA6ZkXNQoNPrHGnhpTmO/tMXKCOkmzwKVHr8p1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="339285050"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="339285050"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:22:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="828069426"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 23:22:41 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu-tasks: Remove unused trc_wait and holdouts
Date:   Fri, 10 Jun 2022 14:22:28 +0800
Message-Id: <20220610062228.2185104-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused trc_wait waitqueue and local holdouts list.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tasks.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 55e76db8b0d3..fcbd0ec33c86 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1190,8 +1190,6 @@ EXPORT_SYMBOL_GPL(rcu_trace_lock_map);
 
 #ifdef CONFIG_TASKS_TRACE_RCU
 
-static DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
-
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
@@ -1641,7 +1639,6 @@ static void rcu_tasks_trace_empty_fn(void *unused)
 static void rcu_tasks_trace_postgp(struct rcu_tasks *rtp)
 {
 	int cpu;
-	LIST_HEAD(holdouts);
 
 	// Wait for any lingering IPI handlers to complete.  Note that
 	// if a CPU has gone offline or transitioned to userspace in the
-- 
2.25.1

