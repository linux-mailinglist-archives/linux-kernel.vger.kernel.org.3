Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71624D0DD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 03:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344327AbiCHCGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 21:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244793AbiCHCGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:06:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD57387BB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646705121; x=1678241121;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=EUxeudjMztn8aspF1JyaXCA8b1FfoMQZEDSG31wEBck=;
  b=FVGkod1WhB1e8NgXus0P1k2POTGiTCf6VxU/VrDiAzvW/FIZAxm2zEPg
   VMbH6m1qpoLhtqEYoM1pu6aPvQdYTYJ9ObmgtSxXXxHP5QaEaYKNXpDhj
   BQpq6YTNiFwZ0IN1R25cRqA2J7sJdV97ePFAVIef3rQDo/di+15FVeHqE
   GFjvYGCmga9HvWdm9DoW75qA+MR5x93sz9b8TsUWCX+eXoCO7B9A2Ts0V
   lQ2UKP91NrKilps8KWok7dxPYf3s8WV62nVk7bBVnkWDFsNrI2Z5yqtiG
   xfc1i3q69rU6P6nmFJaQ7xKh5jIV5f4hfbGc+rAvuwnOM2igDL1V0+y2Q
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242000776"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242000776"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 18:05:21 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="553424513"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 18:05:19 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH -V3 2/2 UPDATE] NUMA balancing: avoid to migrate task to
 CPU-less node
References: <20220214121553.582248-1-ying.huang@intel.com>
        <20220214121553.582248-2-ying.huang@intel.com>
Date:   Tue, 08 Mar 2022 10:05:16 +0800
In-Reply-To: <20220214121553.582248-2-ying.huang@intel.com> (Huang Ying's
        message of "Mon, 14 Feb 2022 20:15:53 +0800")
Message-ID: <87y21lkxlv.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

- Fix a boot crash for some uncovered marginal condition.  Thanks Qian
  Cai for reporting and testing the bug!

- Fix several missing places to use CPU-less nodes as migrating
  target.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Reported-and-tested-by: Qian Cai <quic_qiancai@quicinc.com> # boot crash
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
index 04968f3f9b6d..1fe7a4510cca 100644
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
+	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
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

