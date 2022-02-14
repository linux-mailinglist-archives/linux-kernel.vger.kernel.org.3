Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9E4B4FD9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352828AbiBNMRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:17:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352782AbiBNMRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:17:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8553488B4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644841051; x=1676377051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WNcZp4uku3WfwnM4/G/GcJDbdhFAcwmSC9YYrXd0/og=;
  b=S6RL+FrmITITg6PvfYnqXIomvaeF+ta+aor5LXUjW2et6cLHmMmDQbRq
   D111NrlbIwcF3OzMd8pbch1bvUxOsAqtA+f0CL/+1lMzwUyNlg423f7qR
   KdplclpTeusj8ogs1FodUpGRmu7t5mxy55NaZbLXP6wvL71hco+F3ROMM
   /lwJ872s6wU6OI0MyOWiObZmHGkoPlc4ZfzPAMFAhqSTOTdhwT0+CiUCN
   DuZ2ywhWYUtYmKm4zPXC1e9ANRxSY/CoUwfvqiDlm8TIcnrkEU9ZK/LcO
   R9DYnYg6yQq+LKV/OKxLGjGQBrEvv7Pg1eY4WMluAJ3yZSPMba4W3KFW2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="247672899"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="247672899"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:17:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="528135824"
Received: from yhuang6-desk2.sh.intel.com ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 04:17:29 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH -V3 2/2] NUMA balancing: avoid to migrate task to CPU-less node
Date:   Mon, 14 Feb 2022 20:15:53 +0800
Message-Id: <20220214121553.582248-2-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214121553.582248-1-ying.huang@intel.com>
References: <20220214121553.582248-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Known issue: I don't have systems to test complex NUMA topology type,
for example, NUMA_BACKPLANE or NUMA_GLUELESS_MESH.

v3:

- Fix several missing places to use CPU-less nodes as migrating
  target.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
 kernel/sched/fair.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04968f3f9b6d..a3f0ea216ccb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1988,7 +1988,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 */
 	ng = deref_curr_numa_group(p);
 	if (env.best_cpu == -1 || (ng && ng->active_nodes > 1)) {
-		for_each_online_node(nid) {
+		for_each_node_state(nid, N_CPU) {
 			if (nid == env.src_nid || nid == p->numa_preferred_nid)
 				continue;
 
@@ -2086,13 +2086,13 @@ static void numa_group_count_active_nodes(struct numa_group *numa_group)
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
@@ -2246,7 +2246,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 
 		dist = sched_max_numa_distance;
 
-		for_each_online_node(node) {
+		for_each_node_state(node, N_CPU) {
 			score = group_weight(p, node, dist);
 			if (score > max_score) {
 				max_score = score;
@@ -2265,7 +2265,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 	 * inside the highest scoring group of nodes. The nodemask tricks
 	 * keep the complexity of the search down.
 	 */
-	nodes = node_online_map;
+	nodes = node_states[N_CPU];
 	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
 		unsigned long max_faults = 0;
 		nodemask_t max_group = NODE_MASK_NONE;
@@ -2404,6 +2404,21 @@ static void task_numa_placement(struct task_struct *p)
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
-- 
2.30.2

