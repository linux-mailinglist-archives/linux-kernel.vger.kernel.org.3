Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6314EBA80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 07:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243106AbiC3GBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 02:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243093AbiC3GB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 02:01:26 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB081C93C;
        Tue, 29 Mar 2022 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648619981; x=1680155981;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ElgECvvne75KCEb89B216f0A/fNr2d3Nf37alzV6+x8=;
  b=jU/nKNKTkuth0ITLgxaI2Tt3BgEL4eyIq40F0NY2XYw+wKfSKYJNWZE4
   f8NDvqbywQ0oFvs09jN3A+3wI8EmcY5flvh3Nr3otxirQjHZa/AmQNRiJ
   9gSNkhr7VQ0xVnEeC8Aqtt9xbK2jWTt+9mPrIfepp7Ci0Qe0sBlSZTPPR
   N8X2uqaBNXRPuTRp518mRE0dfFaXUIcTGVLwiFE5CNDha+jlXQzXWiZou
   JwA0oOzXaVuVg+ePRZWT2e5PtGOrTR3ZdJXph8ergHmbdxWVbB+3TDtKc
   e63UnKLFLs99tmeN7picGp5ELTOBAIDordfhs4FbbxpxzJBnFSsHTTEXt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322635004"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322635004"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:59:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="565306371"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 22:59:39 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Put the irq work into hard interrupt context for execution
Date:   Wed, 30 Mar 2022 14:00:12 +0800
Message-Id: <20220330060012.2470054-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PREEMPT_RT kernel, if irq work flags is not set, it will be
executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags
to irq work, put it in the context of hard interrupt execution,
accelerate scheduler to re-evaluate.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c        | 2 +-
 kernel/rcu/tree_plugin.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e2ffbeceba69..a69587773a85 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work *work)
 }
 
 static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =
-	IRQ_WORK_INIT(late_wakeup_func);
+	IRQ_WORK_INIT_HARD(late_wakeup_func);
 
 /*
  * If either:
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 3037c2536e1f..cf7bd28af8ef 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
-				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
+				rdp->defer_qs_iw = IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
 				rdp->defer_qs_iw_pending = true;
 				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
 			}
-- 
2.25.1

