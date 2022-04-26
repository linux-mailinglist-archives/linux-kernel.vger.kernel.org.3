Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4934B50F222
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbiDZHXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343875AbiDZHW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:22:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FA19E9E3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650957577; x=1682493577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KjdZ9sLvwUhspvBYug4UddZSRsJxEvbnnMgw+nWf/mM=;
  b=D4GDZdmSFIhygjQPH9yUdbXxDminAgA3Xq7Lwj4I3v102Zbd/8kHOFfa
   ASFvEDrbfeeaa6/dHA6DhKBTDa2HszcbgH0s9L88hDXJaoruLTQqv4N8T
   dWLih5ziAEu1Cv8Twq7YyTAcPr9hPVTbbXQwA1J/sQKxSf/DvUsEeK0o6
   ha191UDsgKvrZF0lUkACrZmGxnKdWkJ6Q9Rg9gWLXCv8E3lPS48FiYp8z
   iDho1LeILf/gnPs+0uNLT44A60Vq7D4UI1zRNHG3eUA9hvRtGBwfy28zZ
   NBqxTE2CjDPBv3WuoJIFBtQhwHFLuTHJrUMwqkNMj3l7ntTLNaVbetonS
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="265648054"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="265648054"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:19:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="558157277"
Received: from yyu16-mobl.ccr.corp.intel.com (HELO yhuang6-mobl1.ccr.corp.intel.com) ([10.254.212.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 00:19:33 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: [PATCH -V3] sched,topology: Update sched topology atomically
Date:   Tue, 26 Apr 2022 15:19:16 +0800
Message-Id: <20220426071916.56075-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Peter Zijlstra reviewed commit 0fb3978b0aac ("sched/numa: Fix
NUMA topology for systems with CPU-less nodes") [1], he pointed out
that sched_domains_numa_distance and sched_domains_numa_masks are made
separate RCU variables.  That could go side-ways if there were a
function using both, although there isn't for now.

So we update sched_domains_numa_distance and sched_domains_numa_masks
and some other related sched topology parameters atomically to address
the potential issues.

[1] https://lkml.kernel.org/r/20220214121553.582248-1-ying.huang@intel.com

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Changelog:

v3:

- Fixed a bug to use sched_domain_topology_default as default and
  white space issue per comments from Valentin Schneider, Thanks!

v2:

- Addressed comments from Valentin Schneider, Thanks!
---
 kernel/sched/fair.c     |  33 ++---
 kernel/sched/sched.h    |   3 +-
 kernel/sched/topology.c | 261 ++++++++++++++++++++++------------------
 3 files changed, 161 insertions(+), 136 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..6204efca2b56 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1294,17 +1294,17 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 					int lim_dist, bool task)
 {
 	unsigned long score = 0;
-	int node, max_dist;
+	int node, max_dist, type;
+
+	sched_fetch_numa_topology(&type, &max_dist);
 
 	/*
 	 * All nodes are directly connected, and the same distance
 	 * from each other. No need for fancy placement algorithms.
 	 */
-	if (sched_numa_topology_type == NUMA_DIRECT)
+	if (type == NUMA_DIRECT)
 		return 0;
 
-	/* sched_max_numa_distance may be changed in parallel. */
-	max_dist = READ_ONCE(sched_max_numa_distance);
 	/*
 	 * This code is called for each node, introducing N^2 complexity,
 	 * which should be ok given the number of nodes rarely exceeds 8.
@@ -1327,7 +1327,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * "hoplimit", only nodes closer by than "hoplimit" are part
 		 * of each group. Skip other nodes.
 		 */
-		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
+		if (type == NUMA_BACKPLANE && dist >= lim_dist)
 			continue;
 
 		/* Add up the faults from nearby nodes. */
@@ -1344,7 +1344,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * The further away a node is, the less the faults count.
 		 * This seems to result in good task placement.
 		 */
-		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
+		if (type == NUMA_GLUELESS_MESH) {
 			faults *= (max_dist - dist);
 			faults /= (max_dist - LOCAL_DISTANCE);
 		}
@@ -1971,7 +1971,9 @@ static int task_numa_migrate(struct task_struct *p)
 	long taskimp, groupimp;
 	struct numa_group *ng;
 	struct rq *best_rq;
-	int nid, ret, dist;
+	int nid, ret, dist, type;
+
+	sched_fetch_numa_topology(&type, NULL);
 
 	/*
 	 * Pick the lowest SD_NUMA domain, as that would have the smallest
@@ -2026,8 +2028,7 @@ static int task_numa_migrate(struct task_struct *p)
 				continue;
 
 			dist = node_distance(env.src_nid, env.dst_nid);
-			if (sched_numa_topology_type == NUMA_BACKPLANE &&
-						dist != env.dist) {
+			if (type == NUMA_BACKPLANE && dist != env.dist) {
 				taskweight = task_weight(p, env.src_nid, dist);
 				groupweight = group_weight(p, env.src_nid, dist);
 			}
@@ -2262,10 +2263,12 @@ static u64 numa_get_avg_runtime(struct task_struct *p, u64 *period)
 static int preferred_group_nid(struct task_struct *p, int nid)
 {
 	nodemask_t nodes;
-	int dist;
+	int dist, max_dist, type;
+
+	sched_fetch_numa_topology(&type, &max_dist);
 
 	/* Direct connections between all NUMA nodes. */
-	if (sched_numa_topology_type == NUMA_DIRECT)
+	if (type == NUMA_DIRECT)
 		return nid;
 
 	/*
@@ -2273,14 +2276,12 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 	 * scores nodes according to the number of NUMA hinting faults on
 	 * both the node itself, and on nearby nodes.
 	 */
-	if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
+	if (type == NUMA_GLUELESS_MESH) {
 		unsigned long score, max_score = 0;
 		int node, max_node = nid;
 
-		dist = sched_max_numa_distance;
-
 		for_each_node_state(node, N_CPU) {
-			score = group_weight(p, node, dist);
+			score = group_weight(p, node, max_dist);
 			if (score > max_score) {
 				max_score = score;
 				max_node = node;
@@ -2299,7 +2300,7 @@ static int preferred_group_nid(struct task_struct *p, int nid)
 	 * keep the complexity of the search down.
 	 */
 	nodes = node_states[N_CPU];
-	for (dist = sched_max_numa_distance; dist > LOCAL_DISTANCE; dist--) {
+	for (dist = max_dist; dist > LOCAL_DISTANCE; dist--) {
 		unsigned long max_faults = 0;
 		nodemask_t max_group = NODE_MASK_NONE;
 		int a, b;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..547918e08939 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1638,9 +1638,8 @@ enum numa_topology_type {
 	NUMA_GLUELESS_MESH,
 	NUMA_BACKPLANE,
 };
-extern enum numa_topology_type sched_numa_topology_type;
-extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
+extern void sched_fetch_numa_topology(int *type, int *max_distance);
 extern void sched_init_numa(int offline_node);
 extern void sched_update_numa(int cpu, bool online);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 810750e62118..d6eaca6b2b50 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1483,14 +1483,19 @@ static void claim_allocations(int cpu, struct sched_domain *sd)
 }
 
 #ifdef CONFIG_NUMA
-enum numa_topology_type sched_numa_topology_type;
+struct sched_numa_topology {
+	enum numa_topology_type	type;
+	int			nr_levels;
+	int			max_distance;
+	int			*distances;
+	struct cpumask		***masks;
+	struct rcu_head		rcu;
+};
 
-static int			sched_domains_numa_levels;
-static int			sched_domains_curr_level;
+static struct sched_numa_topology default_numa_topology;
+static struct sched_numa_topology __rcu *sched_numa_topology = &default_numa_topology;
 
-int				sched_max_numa_distance;
-static int			*sched_domains_numa_distance;
-static struct cpumask		***sched_domains_numa_masks;
+static int sched_domains_curr_level;
 #endif
 
 /*
@@ -1597,11 +1602,13 @@ sd_init(struct sched_domain_topology_level *tl,
 
 #ifdef CONFIG_NUMA
 	} else if (sd->flags & SD_NUMA) {
+		lockdep_assert_cpus_held();
+
 		sd->cache_nice_tries = 2;
 
 		sd->flags &= ~SD_PREFER_SIBLING;
 		sd->flags |= SD_SERIALIZE;
-		if (sched_domains_numa_distance[tl->numa_level] > node_reclaim_distance) {
+		if (sched_numa_topology->distances[tl->numa_level] > node_reclaim_distance) {
 			sd->flags &= ~(SD_BALANCE_EXEC |
 				       SD_BALANCE_FORK |
 				       SD_WAKE_AFFINE);
@@ -1648,7 +1655,8 @@ static struct sched_domain_topology_level default_topology[] = {
 
 static struct sched_domain_topology_level *sched_domain_topology =
 	default_topology;
-static struct sched_domain_topology_level *sched_domain_topology_saved;
+static struct sched_domain_topology_level *sched_domain_topology_default =
+	default_topology;
 
 #define for_each_sd_topology(tl)			\
 	for (tl = sched_domain_topology; tl->mask; tl++)
@@ -1659,14 +1667,16 @@ void set_sched_topology(struct sched_domain_topology_level *tl)
 		return;
 
 	sched_domain_topology = tl;
-	sched_domain_topology_saved = NULL;
+	sched_domain_topology_default = tl;
 }
 
 #ifdef CONFIG_NUMA
 
 static const struct cpumask *sd_numa_mask(int cpu)
 {
-	return sched_domains_numa_masks[sched_domains_curr_level][cpu_to_node(cpu)];
+	lockdep_assert_cpus_held();
+
+	return sched_numa_topology->masks[sched_domains_curr_level][cpu_to_node(cpu)];
 }
 
 static void sched_numa_warn(const char *str)
@@ -1697,27 +1707,38 @@ static void sched_numa_warn(const char *str)
 bool find_numa_distance(int distance)
 {
 	bool found = false;
-	int i, *distances;
+	int i;
+	struct sched_numa_topology *topology;
 
 	if (distance == node_distance(0, 0))
 		return true;
 
 	rcu_read_lock();
-	distances = rcu_dereference(sched_domains_numa_distance);
-	if (!distances)
-		goto unlock;
-	for (i = 0; i < sched_domains_numa_levels; i++) {
-		if (distances[i] == distance) {
+	topology = rcu_dereference(sched_numa_topology);
+	for (i = 0; i < topology->nr_levels; i++) {
+		if (topology->distances[i] == distance) {
 			found = true;
 			break;
 		}
 	}
-unlock:
 	rcu_read_unlock();
 
 	return found;
 }
 
+void sched_fetch_numa_topology(int *type, int *max_distance)
+{
+	struct sched_numa_topology *topology;
+
+	rcu_read_lock();
+	topology = rcu_dereference(sched_numa_topology);
+	if (type)
+		*type = topology->type;
+	if (max_distance)
+		*max_distance = topology->max_distance;
+	rcu_read_unlock();
+}
+
 #define for_each_cpu_node_but(n, nbut)		\
 	for_each_node_state(n, N_CPU)		\
 		if (n == nbut)			\
@@ -1743,14 +1764,15 @@ bool find_numa_distance(int distance)
  *   there is an intermediary node C, which is < N hops away from both
  *   nodes A and B, the system is a glueless mesh.
  */
-static void init_numa_topology_type(int offline_node)
+static void init_numa_topology_type(int offline_node,
+				    struct sched_numa_topology *topology)
 {
 	int a, b, c, n;
 
-	n = sched_max_numa_distance;
+	n = topology->max_distance;
 
-	if (sched_domains_numa_levels <= 2) {
-		sched_numa_topology_type = NUMA_DIRECT;
+	if (topology->nr_levels <= 2) {
+		topology->type = NUMA_DIRECT;
 		return;
 	}
 
@@ -1764,32 +1786,77 @@ static void init_numa_topology_type(int offline_node)
 			for_each_cpu_node_but(c, offline_node) {
 				if (node_distance(a, c) < n &&
 				    node_distance(b, c) < n) {
-					sched_numa_topology_type =
-							NUMA_GLUELESS_MESH;
+					topology->type = NUMA_GLUELESS_MESH;
 					return;
 				}
 			}
 
-			sched_numa_topology_type = NUMA_BACKPLANE;
+			topology->type = NUMA_BACKPLANE;
 			return;
 		}
 	}
 
 	pr_err("Failed to find a NUMA topology type, defaulting to DIRECT\n");
-	sched_numa_topology_type = NUMA_DIRECT;
+	topology->type = NUMA_DIRECT;
 }
 
+static void sched_numa_topology_free(struct sched_numa_topology *topology)
+{
+	int i, j;
+
+	if (!topology)
+		return;
+
+	kfree(topology->distances);
+	for (i = 0; i < topology->nr_levels && topology->masks; i++) {
+		if (!topology->masks[i])
+			continue;
+		for_each_node(j)
+			kfree(topology->masks[i][j]);
+		kfree(topology->masks[i]);
+	}
+	kfree(topology->masks);
+	kfree(topology);
+}
+
+static void sched_numa_topology_free_rcu(struct rcu_head *head)
+{
+	struct sched_numa_topology *topology;
+
+	topology = container_of(head, struct sched_numa_topology, rcu);
+	sched_numa_topology_free(topology);
+}
+
+static void sched_numa_topology_switch(struct sched_numa_topology *topology,
+				       struct sched_domain_topology_level *tl)
+{
+	struct sched_numa_topology *old_topology = sched_numa_topology;
+	struct sched_domain_topology_level *old_tl = sched_domain_topology;
+
+	rcu_assign_pointer(sched_numa_topology, topology);
+	sched_domain_topology = tl;
+
+	if (old_topology == &default_numa_topology)
+		return;
+
+	init_rcu_head(&old_topology->rcu);
+	call_rcu(&old_topology->rcu, sched_numa_topology_free_rcu);
+	kfree(old_tl);
+}
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
 void sched_init_numa(int offline_node)
 {
 	struct sched_domain_topology_level *tl;
-	unsigned long *distance_map;
+	unsigned long *distance_map = NULL;
 	int nr_levels = 0;
 	int i, j;
-	int *distances;
-	struct cpumask ***masks;
+	struct sched_numa_topology *topology;
+
+	topology = kzalloc(sizeof(*topology), GFP_KERNEL);
+	if (!topology)
+		goto out;
 
 	/*
 	 * O(nr_nodes^2) deduplicating selection sort -- in order to find the
@@ -1797,7 +1864,7 @@ void sched_init_numa(int offline_node)
 	 */
 	distance_map = bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
 	if (!distance_map)
-		return;
+		goto free_topology;
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for_each_cpu_node_but(i, offline_node) {
@@ -1806,8 +1873,7 @@ void sched_init_numa(int offline_node)
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
-				bitmap_free(distance_map);
-				return;
+				goto free_bitmap;
 			}
 
 			bitmap_set(distance_map, distance, 1);
@@ -1818,20 +1884,19 @@ void sched_init_numa(int offline_node)
 	 * allocate memory accordingly.
 	 */
 	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
+	topology->nr_levels = nr_levels;
 
-	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!distances) {
-		bitmap_free(distance_map);
-		return;
-	}
+	topology->distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
+	if (!topology->distances)
+		goto free_bitmap;
 
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
-		distances[i] = j;
+		topology->distances[i] = j;
 	}
-	rcu_assign_pointer(sched_domains_numa_distance, distances);
 
 	bitmap_free(distance_map);
+	distance_map = NULL;
 
 	/*
 	 * 'nr_levels' contains the number of unique distances
@@ -1840,65 +1905,53 @@ void sched_init_numa(int offline_node)
 	 * numbers.
 	 */
 
-	/*
-	 * Here, we should temporarily reset sched_domains_numa_levels to 0.
-	 * If it fails to allocate memory for array sched_domains_numa_masks[][],
-	 * the array will contain less then 'nr_levels' members. This could be
-	 * dangerous when we use it to iterate array sched_domains_numa_masks[][]
-	 * in other functions.
-	 *
-	 * We reset it to 'nr_levels' at the end of this function.
-	 */
-	sched_domains_numa_levels = 0;
-
-	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
-	if (!masks)
-		return;
+	topology->masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
+	if (!topology->masks)
+		goto free_bitmap;
 
 	/*
 	 * Now for each level, construct a mask per node which contains all
 	 * CPUs of nodes that are that many hops away from us.
 	 */
 	for (i = 0; i < nr_levels; i++) {
-		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
-		if (!masks[i])
-			return;
+		topology->masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
+		if (!topology->masks[i])
+			goto free_bitmap;
 
 		for_each_cpu_node_but(j, offline_node) {
 			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
 			int k;
 
 			if (!mask)
-				return;
+				goto free_bitmap;
 
-			masks[i][j] = mask;
+			topology->masks[i][j] = mask;
 
 			for_each_cpu_node_but(k, offline_node) {
 				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				if (node_distance(j, k) > topology->distances[i])
 					continue;
 
 				cpumask_or(mask, mask, cpumask_of_node(k));
 			}
 		}
 	}
-	rcu_assign_pointer(sched_domains_numa_masks, masks);
 
 	/* Compute default topology size */
-	for (i = 0; sched_domain_topology[i].mask; i++);
+	for (i = 0; sched_domain_topology_default[i].mask; i++);
 
 	tl = kzalloc((i + nr_levels + 1) *
 			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
-		return;
+		goto free_bitmap;
 
 	/*
 	 * Copy the default topology bits..
 	 */
-	for (i = 0; sched_domain_topology[i].mask; i++)
-		tl[i] = sched_domain_topology[i];
+	for (i = 0; sched_domain_topology_default[i].mask; i++)
+		tl[i] = sched_domain_topology_default[i];
 
 	/*
 	 * Add the NUMA identity distance, aka single NODE.
@@ -1922,48 +1975,19 @@ void sched_init_numa(int offline_node)
 		};
 	}
 
-	sched_domain_topology_saved = sched_domain_topology;
-	sched_domain_topology = tl;
+	topology->max_distance = topology->distances[nr_levels - 1];
+	init_numa_topology_type(offline_node, topology);
 
-	sched_domains_numa_levels = nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
+	sched_numa_topology_switch(topology, tl);
 
-	init_numa_topology_type(offline_node);
-}
-
-
-static void sched_reset_numa(void)
-{
-	int nr_levels, *distances;
-	struct cpumask ***masks;
-
-	nr_levels = sched_domains_numa_levels;
-	sched_domains_numa_levels = 0;
-	sched_max_numa_distance = 0;
-	sched_numa_topology_type = NUMA_DIRECT;
-	distances = sched_domains_numa_distance;
-	rcu_assign_pointer(sched_domains_numa_distance, NULL);
-	masks = sched_domains_numa_masks;
-	rcu_assign_pointer(sched_domains_numa_masks, NULL);
-	if (distances || masks) {
-		int i, j;
-
-		synchronize_rcu();
-		kfree(distances);
-		for (i = 0; i < nr_levels && masks; i++) {
-			if (!masks[i])
-				continue;
-			for_each_node(j)
-				kfree(masks[i][j]);
-			kfree(masks[i]);
-		}
-		kfree(masks);
-	}
-	if (sched_domain_topology_saved) {
-		kfree(sched_domain_topology);
-		sched_domain_topology = sched_domain_topology_saved;
-		sched_domain_topology_saved = NULL;
-	}
+	return;
+free_bitmap:
+	bitmap_free(distance_map);
+free_topology:
+	sched_numa_topology_free(topology);
+out:
+	sched_numa_topology_switch(&default_numa_topology,
+				   sched_domain_topology_default);
 }
 
 /*
@@ -1981,7 +2005,6 @@ void sched_update_numa(int cpu, bool online)
 	if (cpumask_weight(cpumask_of_node(node)) != 1)
 		return;
 
-	sched_reset_numa();
 	sched_init_numa(online ? NUMA_NO_NODE : node);
 }
 
@@ -1990,14 +2013,17 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	int i, j;
 
-	for (i = 0; i < sched_domains_numa_levels; i++) {
+	lockdep_assert_cpus_held();
+
+	for (i = 0; i < sched_numa_topology->nr_levels; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
 			if (!node_state(j, N_CPU))
 				continue;
 
 			/* Set ourselves in the remote node's masks */
-			if (node_distance(j, node) <= sched_domains_numa_distance[i])
-				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
+			if (node_distance(j, node) <=
+			    sched_numa_topology->distances[i])
+				cpumask_set_cpu(cpu, sched_numa_topology->masks[i][j]);
 		}
 	}
 }
@@ -2006,10 +2032,12 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 {
 	int i, j;
 
-	for (i = 0; i < sched_domains_numa_levels; i++) {
+	lockdep_assert_cpus_held();
+
+	for (i = 0; i < sched_numa_topology->nr_levels; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
-			if (sched_domains_numa_masks[i][j])
-				cpumask_clear_cpu(cpu, sched_domains_numa_masks[i][j]);
+			if (sched_numa_topology->masks[i][j])
+				cpumask_clear_cpu(cpu, sched_numa_topology->masks[i][j]);
 		}
 	}
 }
@@ -2025,22 +2053,19 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 {
 	int i, j = cpu_to_node(cpu), found = nr_cpu_ids;
-	struct cpumask ***masks;
+	struct sched_numa_topology *topology;
 
 	rcu_read_lock();
-	masks = rcu_dereference(sched_domains_numa_masks);
-	if (!masks)
-		goto unlock;
-	for (i = 0; i < sched_domains_numa_levels; i++) {
-		if (!masks[i][j])
+	topology = rcu_dereference(sched_numa_topology);
+	for (i = 0; i < topology->nr_levels; i++) {
+		if (!topology->masks[i][j])
 			break;
-		cpu = cpumask_any_and(cpus, masks[i][j]);
+		cpu = cpumask_any_and(cpus, topology->masks[i][j]);
 		if (cpu < nr_cpu_ids) {
 			found = cpu;
 			break;
 		}
 	}
-unlock:
 	rcu_read_unlock();
 
 	return found;
-- 
2.30.2

