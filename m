Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD5F4BA8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 19:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiBQS5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 13:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244719AbiBQS5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 13:57:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F855D648;
        Thu, 17 Feb 2022 10:56:56 -0800 (PST)
Date:   Thu, 17 Feb 2022 18:56:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645124214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG/tY+fChOe9YufrhIs/HCkqKjfTSIEaYcCrgmJQ2J0=;
        b=GhZsy9PkHs0oOkT4lRZuQrUPMHloJehgi6LMM03jUg5fw+kmAEowWUNf2M9guVSgWfePYS
        jie+qGztgNB3GeHHJNZGp/BvKV9bRf+U1isNUi4FA3w/DMGus8Kih2Vr1DtSasetd3Z/uo
        LCU2RnIGVSLfXB3eTwTf7BaJlQw2jqvhjMLfvzcpZXaKzd7GtQFeE5Sq8as3U50AJNt0xl
        OBaTVeftC6R3PDeNzzNeZtoRgXLZRSmq/745qVMjuqHtWSFpdwxoYTvN8sG7/4HSiVM8AL
        Eci/5g9miE33f4FQ7T+YEH1JNiOGPfwWyxpI8slpvDAqmR2JM31kq/8oYmDJqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645124214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bG/tY+fChOe9YufrhIs/HCkqKjfTSIEaYcCrgmJQ2J0=;
        b=i63FXX7GDDqNJhzi/AVro13qXL/URfXXHelIJ0SyqtF2cWnn9AdAmh9AQBBCJeSCSCOK9f
        qosB+Gyvt1c3VrBA==
From:   "tip-bot2 for Huang Ying" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Fix NUMA topology for systems with
 CPU-less nodes
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214121553.582248-1-ying.huang@intel.com>
References: <20220214121553.582248-1-ying.huang@intel.com>
MIME-Version: 1.0
Message-ID: <164512421364.16921.5335814634807541713.tip-bot2@tip-bot2>
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

Commit-ID:     0fb3978b0aac3a5c08637aed03cc2d65f793508f
Gitweb:        https://git.kernel.org/tip/0fb3978b0aac3a5c08637aed03cc2d65f793508f
Author:        Huang Ying <ying.huang@intel.com>
AuthorDate:    Mon, 14 Feb 2022 20:15:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Feb 2022 15:57:53 +01:00

sched/numa: Fix NUMA topology for systems with CPU-less nodes

The NUMA topology parameters (sched_numa_topology_type,
sched_domains_numa_levels, and sched_max_numa_distance, etc.)
identified by scheduler may be wrong for systems with CPU-less nodes.

For example, the ACPI SLIT of a system with CPU-less persistent
memory (Intel Optane DCPMM) nodes is as follows,

[000h 0000   4]                    Signature : "SLIT"    [System Locality Information Table]
[004h 0004   4]                 Table Length : 0000042C
[008h 0008   1]                     Revision : 01
[009h 0009   1]                     Checksum : 59
[00Ah 0010   6]                       Oem ID : "XXXX"
[010h 0016   8]                 Oem Table ID : "XXXXXXX"
[018h 0024   4]                 Oem Revision : 00000001
[01Ch 0028   4]              Asl Compiler ID : "INTL"
[020h 0032   4]        Asl Compiler Revision : 20091013

[024h 0036   8]                   Localities : 0000000000000004
[02Ch 0044   4]                 Locality   0 : 0A 15 11 1C
[030h 0048   4]                 Locality   1 : 15 0A 1C 11
[034h 0052   4]                 Locality   2 : 11 1C 0A 1C
[038h 0056   4]                 Locality   3 : 1C 11 1C 0A

While the `numactl -H` output is as follows,

available: 4 nodes (0-3)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71
node 0 size: 64136 MB
node 0 free: 5981 MB
node 1 cpus: 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
node 1 size: 64466 MB
node 1 free: 10415 MB
node 2 cpus:
node 2 size: 253952 MB
node 2 free: 253920 MB
node 3 cpus:
node 3 size: 253952 MB
node 3 free: 253951 MB
node distances:
node   0   1   2   3
  0:  10  21  17  28
  1:  21  10  28  17
  2:  17  28  10  28
  3:  28  17  28  10

In this system, there are only 2 sockets.  In each memory controller,
both DRAM and PMEM DIMMs are installed.  Although the physical NUMA
topology is simple, the logical NUMA topology becomes a little
complex.  Because both the distance(0, 1) and distance (1, 3) are less
than the distance (0, 3), it appears that node 1 sits between node 0
and node 3.  And the whole system appears to be a glueless mesh NUMA
topology type.  But it's definitely not, there is even no CPU in node 3.

This isn't a practical problem now yet.  Because the PMEM nodes (node
2 and node 3 in example system) are offlined by default during system
boot.  So init_numa_topology_type() called during system boot will
ignore them and set sched_numa_topology_type to NUMA_DIRECT.  And
init_numa_topology_type() is only called at runtime when a CPU of a
never-onlined-before node gets plugged in.  And there's no CPU in the
PMEM nodes.  But it appears better to fix this to make the code more
robust.

To test the potential problem.  We have used a debug patch to call
init_numa_topology_type() when the PMEM node is onlined (in
__set_migration_target_nodes()).  With that, the NUMA parameters
identified by scheduler is as follows,

sched_numa_topology_type:	NUMA_GLUELESS_MESH
sched_domains_numa_levels:	4
sched_max_numa_distance:	28

To fix the issue, the CPU-less nodes are ignored when the NUMA topology
parameters are identified.  Because a node may become CPU-less or not
at run time because of CPU hotplug, the NUMA topology parameters need
to be re-initialized at runtime for CPU hotplug too.

With the patch, the NUMA parameters identified for the example system
above is as follows,

sched_numa_topology_type:	NUMA_DIRECT
sched_domains_numa_levels:	2
sched_max_numa_distance:	21

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220214121553.582248-1-ying.huang@intel.com
---
 kernel/sched/core.c     |   5 +-
 kernel/sched/fair.c     |  15 +--
 kernel/sched/sched.h    |   6 +-
 kernel/sched/topology.c | 206 ++++++++++++++++++++++-----------------
 4 files changed, 137 insertions(+), 95 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c620aab..b222692 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9052,6 +9052,7 @@ int sched_cpu_activate(unsigned int cpu)
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
+		sched_update_numa(cpu, true);
 		sched_domains_numa_masks_set(cpu);
 		cpuset_cpu_active();
 	}
@@ -9130,10 +9131,12 @@ int sched_cpu_deactivate(unsigned int cpu)
 	if (!sched_smp_initialized)
 		return 0;
 
+	sched_update_numa(cpu, false);
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
+		sched_update_numa(cpu, true);
 		return ret;
 	}
 	sched_domains_numa_masks_clear(cpu);
@@ -9236,7 +9239,7 @@ int sched_cpu_dying(unsigned int cpu)
 
 void __init sched_init_smp(void)
 {
-	sched_init_numa();
+	sched_init_numa(NUMA_NO_NODE);
 
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5c4bfff..da3230b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1259,10 +1259,10 @@ static bool numa_is_active_node(int nid, struct numa_group *ng)
 
 /* Handle placement on systems where not all nodes are directly connected. */
 static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
-					int maxdist, bool task)
+					int lim_dist, bool task)
 {
 	unsigned long score = 0;
-	int node;
+	int node, max_dist;
 
 	/*
 	 * All nodes are directly connected, and the same distance
@@ -1271,6 +1271,8 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 	if (sched_numa_topology_type == NUMA_DIRECT)
 		return 0;
 
+	/* sched_max_numa_distance may be changed in parallel. */
+	max_dist = READ_ONCE(sched_max_numa_distance);
 	/*
 	 * This code is called for each node, introducing N^2 complexity,
 	 * which should be ok given the number of nodes rarely exceeds 8.
@@ -1283,7 +1285,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * The furthest away nodes in the system are not interesting
 		 * for placement; nid was already counted.
 		 */
-		if (dist == sched_max_numa_distance || node == nid)
+		if (dist >= max_dist || node == nid)
 			continue;
 
 		/*
@@ -1293,8 +1295,7 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * "hoplimit", only nodes closer by than "hoplimit" are part
 		 * of each group. Skip other nodes.
 		 */
-		if (sched_numa_topology_type == NUMA_BACKPLANE &&
-					dist >= maxdist)
+		if (sched_numa_topology_type == NUMA_BACKPLANE && dist >= lim_dist)
 			continue;
 
 		/* Add up the faults from nearby nodes. */
@@ -1312,8 +1313,8 @@ static unsigned long score_nearby_nodes(struct task_struct *p, int nid,
 		 * This seems to result in good task placement.
 		 */
 		if (sched_numa_topology_type == NUMA_GLUELESS_MESH) {
-			faults *= (sched_max_numa_distance - dist);
-			faults /= (sched_max_numa_distance - LOCAL_DISTANCE);
+			faults *= (max_dist - dist);
+			faults /= (max_dist - LOCAL_DISTANCE);
 		}
 
 		score += faults;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9b33ba9..3da5718 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1662,12 +1662,14 @@ enum numa_topology_type {
 extern enum numa_topology_type sched_numa_topology_type;
 extern int sched_max_numa_distance;
 extern bool find_numa_distance(int distance);
-extern void sched_init_numa(void);
+extern void sched_init_numa(int offline_node);
+extern void sched_update_numa(int cpu, bool online);
 extern void sched_domains_numa_masks_set(unsigned int cpu);
 extern void sched_domains_numa_masks_clear(unsigned int cpu);
 extern int sched_numa_find_closest(const struct cpumask *cpus, int cpu);
 #else
-static inline void sched_init_numa(void) { }
+static inline void sched_init_numa(int offline_node) { }
+static inline void sched_update_numa(int cpu, bool online) { }
 static inline void sched_domains_numa_masks_set(unsigned int cpu) { }
 static inline void sched_domains_numa_masks_clear(unsigned int cpu) { }
 static inline int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1c84b48..5db322c 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1492,8 +1492,6 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
-
-static unsigned long __read_mostly *sched_numa_onlined_nodes;
 #endif
 
 /*
@@ -1651,6 +1649,7 @@ static struct sched_domain_topology_level default_topology[] = {
 
 static struct sched_domain_topology_level *sched_domain_topology =
 	default_topology;
+static struct sched_domain_topology_level *sched_domain_topology_saved;
 
 #define for_each_sd_topology(tl)			\
 	for (tl = sched_domain_topology; tl->mask; tl++)
@@ -1661,6 +1660,7 @@ void set_sched_topology(struct sched_domain_topology_level *tl)
 		return;
 
 	sched_domain_topology = tl;
+	sched_domain_topology_saved = NULL;
 }
 
 #ifdef CONFIG_NUMA
@@ -1684,8 +1684,12 @@ static void sched_numa_warn(const char *str)
 
 	for (i = 0; i < nr_node_ids; i++) {
 		printk(KERN_WARNING "  ");
-		for (j = 0; j < nr_node_ids; j++)
-			printk(KERN_CONT "%02d ", node_distance(i,j));
+		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_state(i, N_CPU) || !node_state(j, N_CPU))
+				printk(KERN_CONT "(%02d) ", node_distance(i,j));
+			else
+				printk(KERN_CONT " %02d  ", node_distance(i,j));
+		}
 		printk(KERN_CONT "\n");
 	}
 	printk(KERN_WARNING "\n");
@@ -1693,19 +1697,34 @@ static void sched_numa_warn(const char *str)
 
 bool find_numa_distance(int distance)
 {
-	int i;
+	bool found = false;
+	int i, *distances;
 
 	if (distance == node_distance(0, 0))
 		return true;
 
+	rcu_read_lock();
+	distances = rcu_dereference(sched_domains_numa_distance);
+	if (!distances)
+		goto unlock;
 	for (i = 0; i < sched_domains_numa_levels; i++) {
-		if (sched_domains_numa_distance[i] == distance)
-			return true;
+		if (distances[i] == distance) {
+			found = true;
+			break;
+		}
 	}
+unlock:
+	rcu_read_unlock();
 
-	return false;
+	return found;
 }
 
+#define for_each_cpu_node_but(n, nbut)		\
+	for_each_node_state(n, N_CPU)		\
+		if (n == nbut)			\
+			continue;		\
+		else
+
 /*
  * A system can have three types of NUMA topology:
  * NUMA_DIRECT: all nodes are directly connected, or not a NUMA system
@@ -1725,7 +1744,7 @@ bool find_numa_distance(int distance)
  *   there is an intermediary node C, which is < N hops away from both
  *   nodes A and B, the system is a glueless mesh.
  */
-static void init_numa_topology_type(void)
+static void init_numa_topology_type(int offline_node)
 {
 	int a, b, c, n;
 
@@ -1736,14 +1755,14 @@ static void init_numa_topology_type(void)
 		return;
 	}
 
-	for_each_online_node(a) {
-		for_each_online_node(b) {
+	for_each_cpu_node_but(a, offline_node) {
+		for_each_cpu_node_but(b, offline_node) {
 			/* Find two nodes furthest removed from each other. */
 			if (node_distance(a, b) < n)
 				continue;
 
 			/* Is there an intermediary node between a and b? */
-			for_each_online_node(c) {
+			for_each_cpu_node_but(c, offline_node) {
 				if (node_distance(a, c) < n &&
 				    node_distance(b, c) < n) {
 					sched_numa_topology_type =
@@ -1756,17 +1775,22 @@ static void init_numa_topology_type(void)
 			return;
 		}
 	}
+
+	pr_err("Failed to find a NUMA topology type, defaulting to DIRECT\n");
+	sched_numa_topology_type = NUMA_DIRECT;
 }
 
 
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
 
-void sched_init_numa(void)
+void sched_init_numa(int offline_node)
 {
 	struct sched_domain_topology_level *tl;
 	unsigned long *distance_map;
 	int nr_levels = 0;
 	int i, j;
+	int *distances;
+	struct cpumask ***masks;
 
 	/*
 	 * O(nr_nodes^2) deduplicating selection sort -- in order to find the
@@ -1777,12 +1801,13 @@ void sched_init_numa(void)
 		return;
 
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
-	for (i = 0; i < nr_node_ids; i++) {
-		for (j = 0; j < nr_node_ids; j++) {
+	for_each_cpu_node_but(i, offline_node) {
+		for_each_cpu_node_but(j, offline_node) {
 			int distance = node_distance(i, j);
 
 			if (distance < LOCAL_DISTANCE || distance >= NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
+				bitmap_free(distance_map);
 				return;
 			}
 
@@ -1795,16 +1820,17 @@ void sched_init_numa(void)
 	 */
 	nr_levels = bitmap_weight(distance_map, NR_DISTANCE_VALUES);
 
-	sched_domains_numa_distance = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!sched_domains_numa_distance) {
+	distances = kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
+	if (!distances) {
 		bitmap_free(distance_map);
 		return;
 	}
 
 	for (i = 0, j = 0; i < nr_levels; i++, j++) {
 		j = find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
-		sched_domains_numa_distance[i] = j;
+		distances[i] = j;
 	}
+	rcu_assign_pointer(sched_domains_numa_distance, distances);
 
 	bitmap_free(distance_map);
 
@@ -1826,8 +1852,8 @@ void sched_init_numa(void)
 	 */
 	sched_domains_numa_levels = 0;
 
-	sched_domains_numa_masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
-	if (!sched_domains_numa_masks)
+	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
+	if (!masks)
 		return;
 
 	/*
@@ -1835,31 +1861,20 @@ void sched_init_numa(void)
 	 * CPUs of nodes that are that many hops away from us.
 	 */
 	for (i = 0; i < nr_levels; i++) {
-		sched_domains_numa_masks[i] =
-			kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
-		if (!sched_domains_numa_masks[i])
+		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
+		if (!masks[i])
 			return;
 
-		for (j = 0; j < nr_node_ids; j++) {
+		for_each_cpu_node_but(j, offline_node) {
 			struct cpumask *mask = kzalloc(cpumask_size(), GFP_KERNEL);
 			int k;
 
 			if (!mask)
 				return;
 
-			sched_domains_numa_masks[i][j] = mask;
-
-			for_each_node(k) {
-				/*
-				 * Distance information can be unreliable for
-				 * offline nodes, defer building the node
-				 * masks to its bringup.
-				 * This relies on all unique distance values
-				 * still being visible at init time.
-				 */
-				if (!node_online(j))
-					continue;
+			masks[i][j] = mask;
 
+			for_each_cpu_node_but(k, offline_node) {
 				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
@@ -1870,6 +1885,7 @@ void sched_init_numa(void)
 			}
 		}
 	}
+	rcu_assign_pointer(sched_domains_numa_masks, masks);
 
 	/* Compute default topology size */
 	for (i = 0; sched_domain_topology[i].mask; i++);
@@ -1907,59 +1923,67 @@ void sched_init_numa(void)
 		};
 	}
 
+	sched_domain_topology_saved = sched_domain_topology;
 	sched_domain_topology = tl;
 
 	sched_domains_numa_levels = nr_levels;
-	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
-
-	init_numa_topology_type();
-
-	sched_numa_onlined_nodes = bitmap_alloc(nr_node_ids, GFP_KERNEL);
-	if (!sched_numa_onlined_nodes)
-		return;
+	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels - 1]);
 
-	bitmap_zero(sched_numa_onlined_nodes, nr_node_ids);
-	for_each_online_node(i)
-		bitmap_set(sched_numa_onlined_nodes, i, 1);
+	init_numa_topology_type(offline_node);
 }
 
-static void __sched_domains_numa_masks_set(unsigned int node)
-{
-	int i, j;
-
-	/*
-	 * NUMA masks are not built for offline nodes in sched_init_numa().
-	 * Thus, when a CPU of a never-onlined-before node gets plugged in,
-	 * adding that new CPU to the right NUMA masks is not sufficient: the
-	 * masks of that CPU's node must also be updated.
-	 */
-	if (test_bit(node, sched_numa_onlined_nodes))
-		return;
 
-	bitmap_set(sched_numa_onlined_nodes, node, 1);
-
-	for (i = 0; i < sched_domains_numa_levels; i++) {
-		for (j = 0; j < nr_node_ids; j++) {
-			if (!node_online(j) || node == j)
-				continue;
+static void sched_reset_numa(void)
+{
+	int nr_levels, *distances;
+	struct cpumask ***masks;
 
-			if (node_distance(j, node) > sched_domains_numa_distance[i])
+	nr_levels = sched_domains_numa_levels;
+	sched_domains_numa_levels = 0;
+	sched_max_numa_distance = 0;
+	sched_numa_topology_type = NUMA_DIRECT;
+	distances = sched_domains_numa_distance;
+	rcu_assign_pointer(sched_domains_numa_distance, NULL);
+	masks = sched_domains_numa_masks;
+	rcu_assign_pointer(sched_domains_numa_masks, NULL);
+	if (distances || masks) {
+		int i, j;
+
+		synchronize_rcu();
+		kfree(distances);
+		for (i = 0; i < nr_levels && masks; i++) {
+			if (!masks[i])
 				continue;
-
-			/* Add remote nodes in our masks */
-			cpumask_or(sched_domains_numa_masks[i][node],
-				   sched_domains_numa_masks[i][node],
-				   sched_domains_numa_masks[0][j]);
+			for_each_node(j)
+				kfree(masks[i][j]);
+			kfree(masks[i]);
 		}
+		kfree(masks);
 	}
+	if (sched_domain_topology_saved) {
+		kfree(sched_domain_topology);
+		sched_domain_topology = sched_domain_topology_saved;
+		sched_domain_topology_saved = NULL;
+	}
+}
+
+/*
+ * Call with hotplug lock held
+ */
+void sched_update_numa(int cpu, bool online)
+{
+	int node;
 
+	node = cpu_to_node(cpu);
 	/*
-	 * A new node has been brought up, potentially changing the topology
-	 * classification.
-	 *
-	 * Note that this is racy vs any use of sched_numa_topology_type :/
+	 * Scheduler NUMA topology is updated when the first CPU of a
+	 * node is onlined or the last CPU of a node is offlined.
 	 */
-	init_numa_topology_type();
+	if (cpumask_weight(cpumask_of_node(node)) != 1)
+		return;
+
+	sched_reset_numa();
+	sched_init_numa(online ? NUMA_NO_NODE : node);
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)
@@ -1967,11 +1991,9 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	int i, j;
 
-	__sched_domains_numa_masks_set(node);
-
 	for (i = 0; i < sched_domains_numa_levels; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
-			if (!node_online(j))
+			if (!node_state(j, N_CPU))
 				continue;
 
 			/* Set ourselves in the remote node's masks */
@@ -1986,8 +2008,10 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
 	int i, j;
 
 	for (i = 0; i < sched_domains_numa_levels; i++) {
-		for (j = 0; j < nr_node_ids; j++)
-			cpumask_clear_cpu(cpu, sched_domains_numa_masks[i][j]);
+		for (j = 0; j < nr_node_ids; j++) {
+			if (sched_domains_numa_masks[i][j])
+				cpumask_clear_cpu(cpu, sched_domains_numa_masks[i][j]);
+		}
 	}
 }
 
@@ -2001,14 +2025,26 @@ void sched_domains_numa_masks_clear(unsigned int cpu)
  */
 int sched_numa_find_closest(const struct cpumask *cpus, int cpu)
 {
-	int i, j = cpu_to_node(cpu);
+	int i, j = cpu_to_node(cpu), found = nr_cpu_ids;
+	struct cpumask ***masks;
 
+	rcu_read_lock();
+	masks = rcu_dereference(sched_domains_numa_masks);
+	if (!masks)
+		goto unlock;
 	for (i = 0; i < sched_domains_numa_levels; i++) {
-		cpu = cpumask_any_and(cpus, sched_domains_numa_masks[i][j]);
-		if (cpu < nr_cpu_ids)
-			return cpu;
+		if (!masks[i][j])
+			break;
+		cpu = cpumask_any_and(cpus, masks[i][j]);
+		if (cpu < nr_cpu_ids) {
+			found = cpu;
+			break;
+		}
 	}
-	return nr_cpu_ids;
+unlock:
+	rcu_read_unlock();
+
+	return found;
 }
 
 #endif /* CONFIG_NUMA */
