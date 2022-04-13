Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3F64FF0C1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiDMHqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiDMHqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:46:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03932E69C;
        Wed, 13 Apr 2022 00:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649835829; x=1681371829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9LnT73jUESFVZOk+Ffoh5evZ5ZtPW8CwyMo+B2FIm2w=;
  b=av3yyfp1BfjByYv/XvOuhIrXsZ/hb/C9DvCo/CTt/acArZAlMF9Uuczj
   isOBV1vImuXI4ggs3aLzy1RCrRdX2TcCylqEuA36ro3qdvDvTuX/wiThh
   Y6KVZ5ydBccTJSp+/rEXbA266Y/qYegF+Y3vp1Jlajyl7MfyDL+4cnp4U
   Lv4i2GfW7kNnuWEszeAgF9V5ghcJiheVhCZSlcsQC0/Vih1WogRSGUowN
   HBhpeqCG8z945BuDyTGdl7gJpYE9Ad3WK4oUA7m3wrYd6GM+RJq/4SGKE
   w+ajfBeiNYip7wh3qx0m67qw0m+6hu67gWZb7LFA3kxrdRnjOJfbmhe9q
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="323044265"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="323044265"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="573159281"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 00:43:47 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not report quiescent state
Date:   Wed, 13 Apr 2022 15:44:11 +0800
Message-Id: <20220413074411.2369623-1-qiang1.zhang@intel.com>
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

If the rcutree.use_softirq is configured, when RCU Stall event
happened, dump status of all rcuc kthreads who due to starvation
prevented grace period ends on CPUs that not report quiescent
state.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_stall.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd..e6ecc32cfe23 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -348,6 +348,7 @@ static int rcu_print_task_stall(struct rcu_node *rnp, unsigned long flags)
 }
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
+static void rcuc_kthread_dump(struct rcu_data *rdp);
 /*
  * Dump stacks of all tasks running on stalled CPUs.  First try using
  * NMIs, but fall back to manual remote stack tracing on architectures
@@ -368,6 +369,7 @@ static void rcu_dump_cpu_stacks(void)
 					pr_err("Offline CPU %d blocking current GP.\n", cpu);
 				else if (!trigger_single_cpu_backtrace(cpu))
 					dump_cpu_task(cpu);
+				rcuc_kthread_dump(per_cpu_ptr(&rcu_data, cpu));
 			}
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
@@ -471,6 +473,9 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
 	unsigned long j;
 	struct task_struct *rcuc;
 
+	if (use_softirq)
+		return;
+
 	rcuc = rdp->rcu_cpu_kthread_task;
 	if (!rcuc)
 		return;
@@ -659,9 +664,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.25.1

