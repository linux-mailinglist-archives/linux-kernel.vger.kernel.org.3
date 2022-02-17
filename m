Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC94BA904
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbiBQS5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244715AbiBQS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C91F5D677;
        Thu, 17 Feb 2022 10:56:55 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBiiPgn306sx/WT8q1jLcKd/StsV4JxTYp9CRAuANlY=;
        b=V7zt69gRwx9uUcpoRKxrDVzD1d8f+7wxNuUpm2uQe4ZprtYaIBYMyIvm/vI2f2F9SD7+cu
        TAHAX4bKKWIKdcFzNxGl4iGZ7pohtDUFwZ3cbw/Ot0w0t8P9RRuO2ZJsrA6miQTHEQcDrI
        lvwNTuQprt7TI6M8B1y1MEIVHnUsuUa8T6PjtpFx0/5JbLWD3dmQoyvqrJnP9UhDi8wMVA
        5svdZXpMgYZ2lUjbljLgh/Svf4bxVvXmr19SMYOP4sGQRybrrMKPM55nwDqof/k3N9diUK
        2X1aQtKjVXM/kCoHIq4NxrTvH0yQxfrUIvmX6j6py0dWIKHvqsXIiMdccc6z7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124213;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RBiiPgn306sx/WT8q1jLcKd/StsV4JxTYp9CRAuANlY=;
        b=bPHZrtMUSvp8FUJf0z9SpjLhz11gfLu1ZT/hr++H5H0lQW9/cG3dnJAzXRTu9n0qtBKinn
        13f1AJX3GYiwz5Aw==
From:   "tip-bot2 for Huang Ying" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Avoid migrating task to CPU-less node
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214121553.582248-2-ying.huang@intel.com>
References: <20220214121553.582248-2-ying.huang@intel.com>
MIME-Version: 1.0
Message-ID: <164512421264.16921.689831789198253265.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5c7b1aaf139dab5072311853bacc40fc3457d1f9
Gitweb:        https://git.kernel.org/tip/5c7b1aaf139dab5072311853bacc40fc3457d1f9
Author:        Huang Ying <ying.huang@intel.com>
AuthorDate:    Mon, 14 Feb 2022 20:15:53 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:53 +01:00

sched/numa: Avoid migrating task to CPU-less node

In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
nodes.  But if the number of the hint page faults on a PMEM node is
the max for a task, The current NUMA balancing policy may try to place
the task on the PMEM node instead of DRAM node.  This is unreasonable,
because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
nodes are ignored when searching the migration target node for a task
in this patch.

To test the patch, we run a workload that accesses more memory in PMEM
node than memory in DRAM node.  Without the patch, the PMEM node will
be chosen as preferred node in task_numa_placement().  While the DRAM
node will be chosen instead with the patch.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220214121553.582248-2-ying.huang@intel.com
---
 kernel/sched/fair.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da3230b..11a72e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1989,7 +1989,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	ng = deref_curr_numa_group(p);
 	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
-		for_each_online_node(nid) {
+		for_each_node_state(nid, N_CPU) {
 			if (nid == env.src_nid || nid == p->numa_preferred_nid)
 				continue;
 
@@ -2087,13 +2087,13 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
 	unsigned long faults, max_faults = 0;
 	int nid, active_nodes = 0;
 
-	for_each_online_node(nid) {
+	for_each_node_state(nid, N_CPU) {
 		faults = group_faults_cpu(numa_group, nid);
 		if (faults > max_faults)
 			max_faults = faults;
 	}
 
-	for_each_online_node(nid) {
+	for_each_node_state(nid, N_CPU) {
 		faults = group_faults_cpu(numa_group, nid);
 		if (faults * ACTIVE_NODE_FRACTION > max_faults)
 			active_nodes++;
@@ -2247,7 +2247,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 
 		dist = sched_max_numa_distance;
 
-		for_each_online_node(node) {
+		for_each_node_state(node, N_CPU) {
 			score = group_weight(p, node, dist);
 			if (score > max_score) {
 				max_score = score;
@@ -2266,7 +2266,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 	 * inside the highest scoring group of nodes. The nodemask tricks
 	 * keep the complexity of the search down.
 	 */
-	nodes = node_online_map;
+	nodes = node_states[N_CPU];
 	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
 		unsigned long max_faults = 0;
 		nodemask_t max_group = NODE_MASK_NONE;
@@ -2405,6 +2405,21 @@ static void task_numa_placement(struct task_struct *p)
 		}
 	}
 
+	/* Cannot migrate task to CPU-less node */
+	if (!node_state(max_nid, N_CPU)) {
+		int near_nid = max_nid;
+		int distance, near_distance = INT_MAX;
+
+		for_each_node_state(nid, N_CPU) {
+			distance = node_distance(max_nid, nid);
+			if (distance < near_distance) {
+				near_nid = nid;
+				near_distance = distance;
+			}
+		}
+		max_nid = near_nid;
+	}
+
 	if (ng) {
 		numa_group_count_active_nodes(ng);
 		spin_unlock_irq(group_lock);
