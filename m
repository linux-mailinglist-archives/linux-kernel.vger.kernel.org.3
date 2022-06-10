Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5F95467C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiFJNyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349292AbiFJNyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9926440939
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:53:57 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADL5El010719;
        Fri, 10 Jun 2022 13:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OfOtYtxNYGgQJvNxkt1FZF9nJGnGnNOp0iR/2yZPrFg=;
 b=pwKZBOLSNGPHsi3Bt5mXZE90k1sz5KiKhoneA+KEIY/PxthBC2BfoMRvLmjQIsm1HB6U
 EAAMMteoNLBlLydaWwT7US+QddIdDG5bWvbSseb6k0f37jovfcR5Amo+3bO21xF9a8Dm
 JlLZ8MxmWTzKThHJBaRJ+i/LqrEFHbDcOQ+8gkIfwm4yqnYtxGkDPpD7ydz9wi3xh2hl
 /qcbqP07FwEgubY29jrlxGZlUpusd5hOd34Tu/VbuUkFXAGZ8dxLMRgMIZQ7keMtduWs
 kJ4K/cfCSgJSXFk0abpwrTrsBv7UBA5vZrhPJ/asQYShF+kFr6yRCuOV6I7jhdcu4UCf zw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6rngkfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:38 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADRZWL004471;
        Fri, 10 Jun 2022 13:53:37 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6rngkfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:37 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZ831008986;
        Fri, 10 Jun 2022 13:53:36 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3gfy1bk6fj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:36 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADrZVY28115384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:53:35 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 020DC6A054;
        Fri, 10 Jun 2022 13:53:35 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D94166A047;
        Fri, 10 Jun 2022 13:53:25 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:53:25 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v6 05/13] mm/demotion: Build demotion targets based on explicit memory tiers
Date:   Fri, 10 Jun 2022 19:22:21 +0530
Message-Id: <20220610135229.182859-6-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b0ErQ_RSBOInVU2EOtrbD7crdc0FSa7F
X-Proofpoint-ORIG-GUID: pP-xg5SqKFpu9VbLO-6tuPrJkbIiQzLV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switch the demotion target building logic to use memory tiers
instead of NUMA distance. All N_MEMORY NUMA nodes will be placed in the
default tier 1 and additional memory tiers will be added by drivers like
dax kmem.

This patch builds the demotion target for a NUMA node by looking at all
memory tiers below the tier to which the NUMA node belongs. The closest node
in the immediately following memory tier is used as a demotion target.

Since we are now only building demotion target for N_MEMORY NUMA nodes
the CPU hotplug calls are removed in this patch.

The rank approach allows us to keep memory tier device IDs stable even if there
is a need to change the tier ordering among different memory tiers. e.g. DRAM
nodes with CPUs will always be on memtier1, no matter how many tiers are higher
or lower than these nodes. A new memory tier can be inserted into the tier
hierarchy for a new set of nodes without affecting the node assignment of any
existing memtier, provided that there is enough gap in the rank values for the
new memtier.

The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
Its value relative to other memtiers decides the level of this memtier in the tier
hierarchy.

For now, This patch supports hardcoded rank values which are 300, 200, & 100 for
memory tiers 0,1 & 2 respectively.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Below is the sysfs interface to read the rank values of memory tier,
/sys/devices/system/memtier/memtierN/rank

This interface is read only for now. Write support can be added when there is
a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
requirement among them.
---
 include/linux/memory-tiers.h |   5 +
 include/linux/migrate.h      |  13 --
 mm/memory-tiers.c            | 291 ++++++++++++++++++++++++++
 mm/migrate.c                 | 394 -----------------------------------
 mm/vmstat.c                  |   4 -
 5 files changed, 296 insertions(+), 411 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index e102ec73ab80..18dd1ab7b96e 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -19,8 +19,13 @@
 
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
+int next_demotion_node(int node);
 #else
 #define numa_demotion_enabled	false
+static inline int next_demotion_node(int node)
+{
+	return NUMA_NO_NODE;
+}
 
 #endif	/* CONFIG_TIERED_MEMORY */
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 43e737215f33..93fab62e6548 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -75,19 +75,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 
 #endif /* CONFIG_MIGRATION */
 
-#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
-extern void set_migration_target_nodes(void);
-extern void migrate_on_reclaim_init(void);
-extern int next_demotion_node(int node);
-#else
-static inline void set_migration_target_nodes(void) {}
-static inline void migrate_on_reclaim_init(void) {}
-static inline int next_demotion_node(int node)
-{
-        return NUMA_NO_NODE;
-}
-#endif
-
 #ifdef CONFIG_COMPACTION
 extern int PageMovable(struct page *page);
 extern void __SetPageMovable(struct page *page, struct address_space *mapping);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 00d393a5a628..2f116912de43 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -4,6 +4,10 @@
 #include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/memory-tiers.h>
+#include <linux/random.h>
+#include <linux/memory.h>
+
+#include "internal.h"
 
 struct memory_tier {
 	struct list_head list;
@@ -12,9 +16,76 @@ struct memory_tier {
 	int rank;
 };
 
+struct demotion_nodes {
+	nodemask_t preferred;
+};
+
+static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 
+/*
+ * node_demotion[] examples:
+ *
+ * Example 1:
+ *
+ * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
+ *
+ * node distances:
+ * node   0    1    2    3
+ *    0  10   20   30   40
+ *    1  20   10   40   30
+ *    2  30   40   10   40
+ *    3  40   30   40   10
+ *
+ * memory_tiers[0] = <empty>
+ * memory_tiers[1] = 0-1
+ * memory_tiers[2] = 2-3
+ *
+ * node_demotion[0].preferred = 2
+ * node_demotion[1].preferred = 3
+ * node_demotion[2].preferred = <empty>
+ * node_demotion[3].preferred = <empty>
+ *
+ * Example 2:
+ *
+ * Node 0 & 1 are CPU + DRAM nodes, node 2 is memory-only DRAM node.
+ *
+ * node distances:
+ * node   0    1    2
+ *    0  10   20   30
+ *    1  20   10   30
+ *    2  30   30   10
+ *
+ * memory_tiers[0] = <empty>
+ * memory_tiers[1] = 0-2
+ * memory_tiers[2] = <empty>
+ *
+ * node_demotion[0].preferred = <empty>
+ * node_demotion[1].preferred = <empty>
+ * node_demotion[2].preferred = <empty>
+ *
+ * Example 3:
+ *
+ * Node 0 is CPU + DRAM nodes, Node 1 is HBM node, node 2 is PMEM node.
+ *
+ * node distances:
+ * node   0    1    2
+ *    0  10   20   30
+ *    1  20   10   40
+ *    2  30   40   10
+ *
+ * memory_tiers[0] = 1
+ * memory_tiers[1] = 0
+ * memory_tiers[2] = 2
+ *
+ * node_demotion[0].preferred = 2
+ * node_demotion[1].preferred = 0
+ * node_demotion[2].preferred = <empty>
+ *
+ */
+static struct demotion_nodes *node_demotion __read_mostly;
+
 /*
  * Keep it simple by having  direct mapping between
  * tier index and rank value.
@@ -124,6 +195,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 	current_tier = __node_get_memory_tier(node);
 	if (!current_tier) {
 		ret = __node_create_and_set_memory_tier(node, tier);
+		establish_migration_targets();
 		goto out;
 	}
 
@@ -138,6 +210,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 		node_set(node, current_tier->nodelist);
 		goto out;
 	}
+	establish_migration_targets();
 out:
 	mutex_unlock(&memory_tier_lock);
 
@@ -145,6 +218,223 @@ int node_create_and_set_memory_tier(int node, int tier)
 }
 EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
 
+static int __node_set_memory_tier(int node, int tier)
+{
+	int ret = 0;
+	struct memory_tier *memtier;
+
+	memtier = __get_memory_tier_from_id(tier);
+	if (!memtier) {
+		ret = -EINVAL;
+		goto out;
+	}
+	node_set(node, memtier->nodelist);
+out:
+	return ret;
+}
+
+int node_set_memory_tier(int node, int tier)
+{
+	struct memory_tier *memtier;
+	int ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+	memtier = __node_get_memory_tier(node);
+	/*
+	 * if node is already part of the tier proceed with the
+	 * current tier value, because we might want to establish
+	 * new migration paths now. The node might be added to a tier
+	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
+	 * will have skipped this node.
+	 */
+	if (!memtier)
+		ret = __node_set_memory_tier(node, tier);
+	establish_migration_targets();
+
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
+/**
+ * next_demotion_node() - Get the next node in the demotion path
+ * @node: The starting node to lookup the next node
+ *
+ * Return: node id for next memory node in the demotion path hierarchy
+ * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
+ * @node online or guarantee that it *continues* to be the next demotion
+ * target.
+ */
+int next_demotion_node(int node)
+{
+	struct demotion_nodes *nd;
+	int target;
+
+	if (!node_demotion)
+		return NUMA_NO_NODE;
+
+	nd = &node_demotion[node];
+
+	/*
+	 * node_demotion[] is updated without excluding this
+	 * function from running.
+	 *
+	 * Make sure to use RCU over entire code blocks if
+	 * node_demotion[] reads need to be consistent.
+	 */
+	rcu_read_lock();
+	/*
+	 * If there are multiple target nodes, just select one
+	 * target node randomly.
+	 *
+	 * In addition, we can also use round-robin to select
+	 * target node, but we should introduce another variable
+	 * for node_demotion[] to record last selected target node,
+	 * that may cause cache ping-pong due to the changing of
+	 * last target node. Or introducing per-cpu data to avoid
+	 * caching issue, which seems more complicated. So selecting
+	 * target node randomly seems better until now.
+	 */
+	target = node_random(&nd->preferred);
+	rcu_read_unlock();
+
+	return target;
+}
+
+/* Disable reclaim-based migration. */
+static void __disable_all_migrate_targets(void)
+{
+	int node;
+
+	for_each_node_state(node, N_MEMORY)
+		node_demotion[node].preferred = NODE_MASK_NONE;
+}
+
+static void disable_all_migrate_targets(void)
+{
+	__disable_all_migrate_targets();
+
+	/*
+	 * Ensure that the "disable" is visible across the system.
+	 * Readers will see either a combination of before+disable
+	 * state or disable+after.  They will never see before and
+	 * after state together.
+	 */
+	synchronize_rcu();
+}
+
+/*
+ * Find an automatic demotion target for all memory
+ * nodes. Failing here is OK.  It might just indicate
+ * being at the end of a chain.
+ */
+static void establish_migration_targets(void)
+{
+	struct memory_tier *memtier;
+	struct demotion_nodes *nd;
+	int target = NUMA_NO_NODE, node;
+	int distance, best_distance;
+	nodemask_t used;
+
+	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
+		return;
+
+	disable_all_migrate_targets();
+
+	for_each_node_state(node, N_MEMORY) {
+		best_distance = -1;
+		nd = &node_demotion[node];
+
+		memtier = __node_get_memory_tier(node);
+		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
+			continue;
+		/*
+		 * Get the next memtier to find the  demotion node list.
+		 */
+		memtier = list_next_entry(memtier, list);
+
+		/*
+		 * find_next_best_node, use 'used' nodemask as a skip list.
+		 * Add all memory nodes except the selected memory tier
+		 * nodelist to skip list so that we find the best node from the
+		 * memtier nodelist.
+		 */
+		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
+
+		/*
+		 * Find all the nodes in the memory tier node list of same best distance.
+		 * add them to the preferred mask. We randomly select between nodes
+		 * in the preferred mask when allocating pages during demotion.
+		 */
+		do {
+			target = find_next_best_node(node, &used);
+			if (target == NUMA_NO_NODE)
+				break;
+
+			distance = node_distance(node, target);
+			if (distance == best_distance || best_distance == -1) {
+				best_distance = distance;
+				node_set(target, nd->preferred);
+			} else {
+				break;
+			}
+		} while (1);
+	}
+}
+
+/*
+ * This runs whether reclaim-based migration is enabled or not,
+ * which ensures that the user can turn reclaim-based migration
+ * at any time without needing to recalculate migration targets.
+ */
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *_arg)
+{
+	struct memory_notify *arg = _arg;
+
+	/*
+	 * Only update the node migration order when a node is
+	 * changing status, like online->offline.
+	 */
+	if (arg->status_change_nid < 0)
+		return notifier_from_errno(0);
+
+	switch (action) {
+	case MEM_OFFLINE:
+		/*
+		 * In case we are moving out of N_MEMORY. Keep the node
+		 * in the memory tier so that when we bring memory online,
+		 * they appear in the right memory tier. We still need
+		 * to rebuild the demotion order.
+		 */
+		mutex_lock(&memory_tier_lock);
+		establish_migration_targets();
+		mutex_unlock(&memory_tier_lock);
+		break;
+	case MEM_ONLINE:
+		/*
+		 * We ignore the error here, if the node already have the tier
+		 * registered, we will continue to use that for the new memory
+		 * we are adding here.
+		 */
+		node_set_memory_tier(arg->status_change_nid, DEFAULT_MEMORY_TIER);
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static void __init migrate_on_reclaim_init(void)
+{
+
+	if (IS_ENABLED(CONFIG_MIGRATION)) {
+		node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
+					GFP_KERNEL);
+		WARN_ON(!node_demotion);
+	}
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+}
+
 static int __init memory_tier_init(void)
 {
 	struct memory_tier *memtier;
@@ -162,6 +452,7 @@ static int __init memory_tier_init(void)
 
 	/* CPU only nodes are not part of memory tiers. */
 	memtier->nodelist = node_states[N_MEMORY];
+	migrate_on_reclaim_init();
 
 	return 0;
 }
diff --git a/mm/migrate.c b/mm/migrate.c
index 29cacc217e38..0b554625a219 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2116,398 +2116,4 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	return 0;
 }
 #endif /* CONFIG_NUMA_BALANCING */
-
-/*
- * node_demotion[] example:
- *
- * Consider a system with two sockets.  Each socket has
- * three classes of memory attached: fast, medium and slow.
- * Each memory class is placed in its own NUMA node.  The
- * CPUs are placed in the node with the "fast" memory.  The
- * 6 NUMA nodes (0-5) might be split among the sockets like
- * this:
- *
- *	Socket A: 0, 1, 2
- *	Socket B: 3, 4, 5
- *
- * When Node 0 fills up, its memory should be migrated to
- * Node 1.  When Node 1 fills up, it should be migrated to
- * Node 2.  The migration path start on the nodes with the
- * processors (since allocations default to this node) and
- * fast memory, progress through medium and end with the
- * slow memory:
- *
- *	0 -> 1 -> 2 -> stop
- *	3 -> 4 -> 5 -> stop
- *
- * This is represented in the node_demotion[] like this:
- *
- *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
- *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
- *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
- *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
- *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
- *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
- *
- * Moreover some systems may have multiple slow memory nodes.
- * Suppose a system has one socket with 3 memory nodes, node 0
- * is fast memory type, and node 1/2 both are slow memory
- * type, and the distance between fast memory node and slow
- * memory node is same. So the migration path should be:
- *
- *	0 -> 1/2 -> stop
- *
- * This is represented in the node_demotion[] like this:
- *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
- *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
- *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
- */
-
-/*
- * Writes to this array occur without locking.  Cycles are
- * not allowed: Node X demotes to Y which demotes to X...
- *
- * If multiple reads are performed, a single rcu_read_lock()
- * must be held over all reads to ensure that no cycles are
- * observed.
- */
-#define DEFAULT_DEMOTION_TARGET_NODES 15
-
-#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
-#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
-#else
-#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
-#endif
-
-struct demotion_nodes {
-	unsigned short nr;
-	short nodes[DEMOTION_TARGET_NODES];
-};
-
-static struct demotion_nodes *node_demotion __read_mostly;
-
-/**
- * next_demotion_node() - Get the next node in the demotion path
- * @node: The starting node to lookup the next node
- *
- * Return: node id for next memory node in the demotion path hierarchy
- * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
- * @node online or guarantee that it *continues* to be the next demotion
- * target.
- */
-int next_demotion_node(int node)
-{
-	struct demotion_nodes *nd;
-	unsigned short target_nr, index;
-	int target;
-
-	if (!node_demotion)
-		return NUMA_NO_NODE;
-
-	nd = &node_demotion[node];
-
-	/*
-	 * node_demotion[] is updated without excluding this
-	 * function from running.  RCU doesn't provide any
-	 * compiler barriers, so the READ_ONCE() is required
-	 * to avoid compiler reordering or read merging.
-	 *
-	 * Make sure to use RCU over entire code blocks if
-	 * node_demotion[] reads need to be consistent.
-	 */
-	rcu_read_lock();
-	target_nr = READ_ONCE(nd->nr);
-
-	switch (target_nr) {
-	case 0:
-		target = NUMA_NO_NODE;
-		goto out;
-	case 1:
-		index = 0;
-		break;
-	default:
-		/*
-		 * If there are multiple target nodes, just select one
-		 * target node randomly.
-		 *
-		 * In addition, we can also use round-robin to select
-		 * target node, but we should introduce another variable
-		 * for node_demotion[] to record last selected target node,
-		 * that may cause cache ping-pong due to the changing of
-		 * last target node. Or introducing per-cpu data to avoid
-		 * caching issue, which seems more complicated. So selecting
-		 * target node randomly seems better until now.
-		 */
-		index = get_random_int() % target_nr;
-		break;
-	}
-
-	target = READ_ONCE(nd->nodes[index]);
-
-out:
-	rcu_read_unlock();
-	return target;
-}
-
-/* Disable reclaim-based migration. */
-static void __disable_all_migrate_targets(void)
-{
-	int node, i;
-
-	if (!node_demotion)
-		return;
-
-	for_each_online_node(node) {
-		node_demotion[node].nr = 0;
-		for (i = 0; i < DEMOTION_TARGET_NODES; i++)
-			node_demotion[node].nodes[i] = NUMA_NO_NODE;
-	}
-}
-
-static void disable_all_migrate_targets(void)
-{
-	__disable_all_migrate_targets();
-
-	/*
-	 * Ensure that the "disable" is visible across the system.
-	 * Readers will see either a combination of before+disable
-	 * state or disable+after.  They will never see before and
-	 * after state together.
-	 *
-	 * The before+after state together might have cycles and
-	 * could cause readers to do things like loop until this
-	 * function finishes.  This ensures they can only see a
-	 * single "bad" read and would, for instance, only loop
-	 * once.
-	 */
-	synchronize_rcu();
-}
-
-/*
- * Find an automatic demotion target for 'node'.
- * Failing here is OK.  It might just indicate
- * being at the end of a chain.
- */
-static int establish_migrate_target(int node, nodemask_t *used,
-				    int best_distance)
-{
-	int migration_target, index, val;
-	struct demotion_nodes *nd;
-
-	if (!node_demotion)
-		return NUMA_NO_NODE;
-
-	nd = &node_demotion[node];
-
-	migration_target = find_next_best_node(node, used);
-	if (migration_target == NUMA_NO_NODE)
-		return NUMA_NO_NODE;
-
-	/*
-	 * If the node has been set a migration target node before,
-	 * which means it's the best distance between them. Still
-	 * check if this node can be demoted to other target nodes
-	 * if they have a same best distance.
-	 */
-	if (best_distance != -1) {
-		val = node_distance(node, migration_target);
-		if (val > best_distance)
-			goto out_clear;
-	}
-
-	index = nd->nr;
-	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
-		      "Exceeds maximum demotion target nodes\n"))
-		goto out_clear;
-
-	nd->nodes[index] = migration_target;
-	nd->nr++;
-
-	return migration_target;
-out_clear:
-	node_clear(migration_target, *used);
-	return NUMA_NO_NODE;
-}
-
-/*
- * When memory fills up on a node, memory contents can be
- * automatically migrated to another node instead of
- * discarded at reclaim.
- *
- * Establish a "migration path" which will start at nodes
- * with CPUs and will follow the priorities used to build the
- * page allocator zonelists.
- *
- * The difference here is that cycles must be avoided.  If
- * node0 migrates to node1, then neither node1, nor anything
- * node1 migrates to can migrate to node0. Also one node can
- * be migrated to multiple nodes if the target nodes all have
- * a same best-distance against the source node.
- *
- * This function can run simultaneously with readers of
- * node_demotion[].  However, it can not run simultaneously
- * with itself.  Exclusion is provided by memory hotplug events
- * being single-threaded.
- */
-static void __set_migration_target_nodes(void)
-{
-	nodemask_t next_pass;
-	nodemask_t this_pass;
-	nodemask_t used_targets = NODE_MASK_NONE;
-	int node, best_distance;
-
-	/*
-	 * Avoid any oddities like cycles that could occur
-	 * from changes in the topology.  This will leave
-	 * a momentary gap when migration is disabled.
-	 */
-	disable_all_migrate_targets();
-
-	/*
-	 * Allocations go close to CPUs, first.  Assume that
-	 * the migration path starts at the nodes with CPUs.
-	 */
-	next_pass = node_states[N_CPU];
-again:
-	this_pass = next_pass;
-	next_pass = NODE_MASK_NONE;
-	/*
-	 * To avoid cycles in the migration "graph", ensure
-	 * that migration sources are not future targets by
-	 * setting them in 'used_targets'.  Do this only
-	 * once per pass so that multiple source nodes can
-	 * share a target node.
-	 *
-	 * 'used_targets' will become unavailable in future
-	 * passes.  This limits some opportunities for
-	 * multiple source nodes to share a destination.
-	 */
-	nodes_or(used_targets, used_targets, this_pass);
-
-	for_each_node_mask(node, this_pass) {
-		best_distance = -1;
-
-		/*
-		 * Try to set up the migration path for the node, and the target
-		 * migration nodes can be multiple, so doing a loop to find all
-		 * the target nodes if they all have a best node distance.
-		 */
-		do {
-			int target_node =
-				establish_migrate_target(node, &used_targets,
-							 best_distance);
-
-			if (target_node == NUMA_NO_NODE)
-				break;
-
-			if (best_distance == -1)
-				best_distance = node_distance(node, target_node);
-
-			/*
-			 * Visit targets from this pass in the next pass.
-			 * Eventually, every node will have been part of
-			 * a pass, and will become set in 'used_targets'.
-			 */
-			node_set(target_node, next_pass);
-		} while (1);
-	}
-	/*
-	 * 'next_pass' contains nodes which became migration
-	 * targets in this pass.  Make additional passes until
-	 * no more migrations targets are available.
-	 */
-	if (!nodes_empty(next_pass))
-		goto again;
-}
-
-/*
- * For callers that do not hold get_online_mems() already.
- */
-void set_migration_target_nodes(void)
-{
-	get_online_mems();
-	__set_migration_target_nodes();
-	put_online_mems();
-}
-
-/*
- * This leaves migrate-on-reclaim transiently disabled between
- * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
- * whether reclaim-based migration is enabled or not, which
- * ensures that the user can turn reclaim-based migration at
- * any time without needing to recalculate migration targets.
- *
- * These callbacks already hold get_online_mems().  That is why
- * __set_migration_target_nodes() can be used as opposed to
- * set_migration_target_nodes().
- */
-#ifdef CONFIG_MEMORY_HOTPLUG
-static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
-						 unsigned long action, void *_arg)
-{
-	struct memory_notify *arg = _arg;
-
-	/*
-	 * Only update the node migration order when a node is
-	 * changing status, like online->offline.  This avoids
-	 * the overhead of synchronize_rcu() in most cases.
-	 */
-	if (arg->status_change_nid < 0)
-		return notifier_from_errno(0);
-
-	switch (action) {
-	case MEM_GOING_OFFLINE:
-		/*
-		 * Make sure there are not transient states where
-		 * an offline node is a migration target.  This
-		 * will leave migration disabled until the offline
-		 * completes and the MEM_OFFLINE case below runs.
-		 */
-		disable_all_migrate_targets();
-		break;
-	case MEM_OFFLINE:
-	case MEM_ONLINE:
-		/*
-		 * Recalculate the target nodes once the node
-		 * reaches its final state (online or offline).
-		 */
-		__set_migration_target_nodes();
-		break;
-	case MEM_CANCEL_OFFLINE:
-		/*
-		 * MEM_GOING_OFFLINE disabled all the migration
-		 * targets.  Reenable them.
-		 */
-		__set_migration_target_nodes();
-		break;
-	case MEM_GOING_ONLINE:
-	case MEM_CANCEL_ONLINE:
-		break;
-	}
-
-	return notifier_from_errno(0);
-}
-#endif
-
-void __init migrate_on_reclaim_init(void)
-{
-	node_demotion = kcalloc(nr_node_ids,
-				sizeof(struct demotion_nodes),
-				GFP_KERNEL);
-	WARN_ON(!node_demotion);
-#ifdef CONFIG_MEMORY_HOTPLUG
-	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
-#endif
-	/*
-	 * At this point, all numa nodes with memory/CPus have their state
-	 * properly set, so we can build the demotion order now.
-	 * Let us hold the cpu_hotplug lock just, as we could possibily have
-	 * CPU hotplug events during boot.
-	 */
-	cpus_read_lock();
-	set_migration_target_nodes();
-	cpus_read_unlock();
-}
 #endif /* CONFIG_NUMA */
-
-
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 373d2730fcf2..35c6ff97cf29 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -28,7 +28,6 @@
 #include <linux/mm_inline.h>
 #include <linux/page_ext.h>
 #include <linux/page_owner.h>
-#include <linux/migrate.h>
 
 #include "internal.h"
 
@@ -2060,7 +2059,6 @@ static int vmstat_cpu_online(unsigned int cpu)
 
 	if (!node_state(cpu_to_node(cpu), N_CPU)) {
 		node_set_state(cpu_to_node(cpu), N_CPU);
-		set_migration_target_nodes();
 	}
 
 	return 0;
@@ -2085,7 +2083,6 @@ static int vmstat_cpu_dead(unsigned int cpu)
 		return 0;
 
 	node_clear_state(node, N_CPU);
-	set_migration_target_nodes();
 
 	return 0;
 }
@@ -2118,7 +2115,6 @@ void __init init_mm_internals(void)
 
 	start_shepherd_timer();
 #endif
-	migrate_on_reclaim_init();
 #ifdef CONFIG_PROC_FS
 	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
 	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
-- 
2.36.1

