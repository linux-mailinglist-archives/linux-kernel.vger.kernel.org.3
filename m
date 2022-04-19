Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81515063E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348525AbiDSFgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDSFgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:36:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4711EC62;
        Mon, 18 Apr 2022 22:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650346448; x=1681882448;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+zbUjugiM1tJbmssTWitl6+JjBeRVYQBOIfAGM9/pb8=;
  b=Hf/N2j70qYPX0Egmh+TxkK+8U1fMsortqJzz+gjrZYSKV+YLDme1F+2P
   6kAY33GPYS7GmNfW6OtJrBBLT5mUjVKJQvE90Ag8xw43pSzPBNQdYq3qf
   BnDa43nQ3jvXV/rcXNngy+LK0LCOCfZ8mhTrLAS62IiY0CDjTjnesa3JN
   GQOBgo+Et2Vib6T2vrSAyUeMBOIhJ5QgHlQapYK5p8ixKOG5d9b+GfFb2
   Y9ncnqJ7qtJqhubTgSbN4V31/9FaloCMSJWow5xNELc93F776jM7OS29v
   mRXFaUSUETr8Ps2I0Klq7Dc6dfWVJbw+iABaxpXa2Y5s+ROMoutgkKjNJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262539918"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262539918"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:34:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="529170199"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.125])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:34:06 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Dump all rcuc kthreads status for CPUs that not report quiescent state
Date:   Tue, 19 Apr 2022 13:34:26 +0800
Message-Id: <20220419053426.2820350-1-qiang1.zhang@intel.com>
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

If the rcutree.use_softirq is configured, when RCU Stall event
happened, dump status of all rcuc kthreads who due to starvation
prevented grace period ends on CPUs that not report quiescent
state.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 v1->v2:
 rework rcuc_kthread_dump function

 kernel/rcu/tree_stall.h | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd..fcf0b2e1a71c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -465,11 +465,13 @@ static void print_cpu_stall_info(int cpu)
 	       falsepositive ? " (false positive?)" : "");
 }
 
-static void rcuc_kthread_dump(struct rcu_data *rdp)
+static void __rcuc_kthread_dump(int cpu)
 {
-	int cpu;
-	unsigned long j;
+	struct rcu_data *rdp;
 	struct task_struct *rcuc;
+	unsigned long j;
+
+	rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	rcuc = rdp->rcu_cpu_kthread_task;
 	if (!rcuc)
@@ -488,6 +490,21 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
 		dump_cpu_task(cpu);
 }
 
+static void rcuc_kthread_dump(void)
+{
+	int cpu;
+	struct rcu_node *rnp;
+	unsigned long flags;
+
+	rcu_for_each_leaf_node(rnp) {
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		for_each_leaf_node_possible_cpu(rnp, cpu)
+			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
+				__rcuc_kthread_dump(cpu);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	}
+}
+
 /* Complain about starvation of grace-period kthread.  */
 static void rcu_check_gp_kthread_starvation(void)
 {
@@ -597,6 +614,9 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
 
+		if (!use_softirq)
+			rcuc_kthread_dump();
+
 		/* Complain about tasks blocking the grace period. */
 		rcu_for_each_leaf_node(rnp)
 			rcu_print_detail_task_stall_rnp(rnp);
@@ -659,11 +679,11 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
 
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
 
+	if (!use_softirq)
+		rcuc_kthread_dump();
+
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	/* Rewrite if needed in case of slow consoles. */
 	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
-- 
2.25.1

