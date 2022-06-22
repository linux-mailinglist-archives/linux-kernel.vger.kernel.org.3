Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A3D5548EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352649AbiFVI1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349929AbiFVI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:27:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BEB38BCE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:45 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M7k3Uf005004;
        Wed, 22 Jun 2022 08:26:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e9Dts75fjzBG7j4P9SOB7PqAbK3LJ1hlI0q5ixx2Vvo=;
 b=bAsW12hY4AAg1MJtw/DLwB+BlWcKK9BF36kTMCf1w6fPsklrUNFs9nGG7IkdpZKUWjSQ
 +kmZMsOYc4Oj6NTDnaXlpHc8q3reHqdvILdtL0TEKj7z4TZtiuO+ia8NEn/2CTdmqZIl
 YbwnSZ5FC5Dly//iOKbcMycgrs9oR4RPdMe5iuMwQBhBnnVOTK/Fs9LpzqoLBBiJD0r5
 5UfdEungLic7u2UGf/1PYfxzTbaMdcfXSMhzNAg2SHhymLJKbSRB3pmd5KvNVRGc/Ct1
 Hr9ApK5Xa2IG2zLjb3W/ETYSbVk9G7vrZ1LLYhBfZGSGeM5oWHL2Wu7Fs658FTmJkQNs tA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxyw12an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:30 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M8LO1V006458;
        Wed, 22 Jun 2022 08:26:29 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxyw12a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:29 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8LP9g006739;
        Wed, 22 Jun 2022 08:26:28 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3gs6bahbj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:28 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8QRCJ28180926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:26:27 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C325C6E056;
        Wed, 22 Jun 2022 08:26:27 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 359A56E050;
        Wed, 22 Jun 2022 08:26:22 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:26:21 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v7 09/12] mm/demotion: Demote pages according to allocation fallback order
Date:   Wed, 22 Jun 2022 13:55:10 +0530
Message-Id: <20220622082513.467538-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AwlJZJxNuIZ8H1UBNwZkWrbKJEB00keh
X-Proofpoint-GUID: xqiJNSbpLNllphAHKOiaha--Gun5yt6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya@linux.ibm.com>

Currently, a higher tier node can only be demoted to selected
nodes on the next lower tier as defined by the demotion path.
This strict, hard-coded demotion order does not work in all
use cases (e.g. some use cases may want to allow cross-socket
demotion to another node in the same demotion tier as a fallback
when the preferred demotion node is out of space). This demotion
order is also inconsistent with the page allocation fallback order
when all the nodes in a higher tier are out of space: The page
allocation can fall back to any node from any lower tier, whereas
the demotion order doesn't allow that currently.

This patch adds support to get all the allowed demotion targets
for a memory tier. demote_page_list() function is now modified
to utilize this allowed node mask as the fallback allocation mask.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

move allowed mask to memory tier
---
 include/linux/memory-tiers.h | 17 +++++++-
 mm/memory-tiers.c            | 76 +++++++++++++++++++++++++++++++++---
 mm/vmscan.c                  | 56 +++++++++++++++++++-------
 3 files changed, 128 insertions(+), 21 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 705b63ee31d5..335d21a30b2c 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -3,11 +3,12 @@
 #define _LINUX_MEMORY_TIERS_H
 
 #include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/mmzone.h>
 
 #ifdef CONFIG_NUMA
 
 #include <linux/device.h>
-#include <linux/nodemask.h>
 
 #define MEMORY_TIER_HBM_GPU	300
 #define MEMORY_TIER_DRAM	200
@@ -20,18 +21,25 @@ struct memory_tier {
 	struct list_head list;
 	struct device dev;
 	nodemask_t nodelist;
+	nodemask_t lower_tier_mask;
 };
 
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 #else
 static inline int next_demotion_node(int node)
 {
 	return NUMA_NO_NODE;
 }
-#endif
+
+static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
+#endif /* CONFIG_MIGRATION */
 int node_get_memory_tier_id(int node);
 int node_update_memory_tier(int node, int tier);
 struct memory_tier *node_get_memory_tier(int node);
@@ -49,5 +57,10 @@ static inline int next_demotion_node(int node)
 {
 	return NUMA_NO_NODE;
 }
+
+static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 6a2476faf13a..aecce987df7c 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -374,6 +374,24 @@ void node_put_memory_tier(struct memory_tier *memtier)
 }
 
 #ifdef CONFIG_MIGRATION
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+{
+	struct memory_tier *memtier;
+
+	/*
+	 * pg_data_t.memtier updates includes a synchronize_rcu()
+	 * which ensures that we either find NULL or a valid memtier
+	 * in NODE_DATA. protect the access via rcu_read_lock();
+	 */
+	rcu_read_lock();
+	memtier = rcu_dereference(pgdat->memtier);
+	if (memtier)
+		*targets = memtier->lower_tier_mask;
+	else
+		*targets = NODE_MASK_NONE;
+	rcu_read_unlock();
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -422,10 +440,19 @@ int next_demotion_node(int node)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
+	struct memory_tier *memtier;
 	int node;
 
-	for_each_node_state(node, N_MEMORY)
+	for_each_node_state(node, N_MEMORY) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
+		/*
+		 * We are holding memory_tier_lock, it is safe
+		 * to access pgda->memtier.
+		 */
+		memtier = rcu_dereference_check(NODE_DATA(node)->memtier,
+						lockdep_is_held(&memory_tier_lock));
+		memtier->lower_tier_mask = NODE_MASK_NONE;
+	}
 }
 
 static void disable_all_migrate_targets(void)
@@ -455,10 +482,26 @@ static void establish_migration_targets(void)
 	struct demotion_nodes *nd;
 	int target = NUMA_NO_NODE, node;
 	int distance, best_distance;
-	nodemask_t used;
-
-	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
-		return;
+	nodemask_t used, lower_tier = NODE_MASK_NONE;
+
+	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION)) {
+
+		for_each_node_state(node, N_MEMORY) {
+			/*
+			 * We are holding memory_tier_lock, it is safe
+			 * to access pgda->memtier.
+			 */
+			memtier = rcu_dereference_check(NODE_DATA(node)->memtier,
+							lockdep_is_held(&memory_tier_lock));
+			memtier->lower_tier_mask = NODE_MASK_NONE;
+		}
+		/*
+		 * Wait for read side to work with old values
+		 * or see the updated NODE_MASK_NONE;
+		 */
+		synchronize_rcu();
+		goto build_lower_tier_mask;
+	}
 
 	disable_all_migrate_targets();
 
@@ -501,6 +544,29 @@ static void establish_migration_targets(void)
 			}
 		} while (1);
 	}
+build_lower_tier_mask:
+	/*
+	 * Now build the lower_tier mask for each node collecting node mask from
+	 * all memory tier below it. This allows us to fallback demotion page
+	 * allocation to a set of nodes that is closer the above selected
+	 * perferred node.
+	 */
+	list_for_each_entry(memtier, &memory_tiers, list)
+		nodes_or(lower_tier, lower_tier, memtier->nodelist);
+	/*
+	 * Removes nodes not yet in N_MEMORY.
+	 */
+	nodes_and(lower_tier, node_states[N_MEMORY], lower_tier);
+
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		/*
+		 * Keep removing current tier from lower_tier nodes,
+		 * This will remove all nodes in current and above
+		 * memory tier from the lower_tier mask.
+		 */
+		nodes_andnot(lower_tier, lower_tier, memtier->nodelist);
+		memtier->lower_tier_mask = lower_tier;
+	}
 }
 
 static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3a8f78277f99..2b213248effa 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1460,19 +1460,32 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }
 
-static struct page *alloc_demote_page(struct page *page, unsigned long node)
+static struct page *alloc_demote_page(struct page *page, unsigned long private)
 {
-	struct migration_target_control mtc = {
-		/*
-		 * Allocate from 'node', or fail quickly and quietly.
-		 * When this happens, 'page' will likely just be discarded
-		 * instead of migrated.
-		 */
-		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
-			    __GFP_THISNODE  | __GFP_NOWARN |
-			    __GFP_NOMEMALLOC | GFP_NOWAIT,
-		.nid = node
-	};
+	struct page *target_page;
+	nodemask_t *allowed_mask;
+	struct migration_target_control *mtc;
+
+	mtc = (struct migration_target_control *)private;
+
+	allowed_mask = mtc->nmask;
+	/*
+	 * make sure we allocate from the target node first also trying to
+	 * reclaim pages from the target node via kswapd if we are low on
+	 * free memory on target node. If we don't do this and if we have low
+	 * free memory on the target memtier, we would start allocating pages
+	 * from higher memory tiers without even forcing a demotion of cold
+	 * pages from the target memtier. This can result in the kernel placing
+	 * hotpages in higher memory tiers.
+	 */
+	mtc->nmask = NULL;
+	mtc->gfp_mask |= __GFP_THISNODE;
+	target_page = alloc_migration_target(page, (unsigned long)&mtc);
+	if (target_page)
+		return target_page;
+
+	mtc->gfp_mask &= ~__GFP_THISNODE;
+	mtc->nmask = allowed_mask;
 
 	return alloc_migration_target(page, (unsigned long)&mtc);
 }
@@ -1487,6 +1500,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
+	nodemask_t allowed_mask;
+
+	struct migration_target_control mtc = {
+		/*
+		 * Allocate from 'node', or fail quickly and quietly.
+		 * When this happens, 'page' will likely just be discarded
+		 * instead of migrated.
+		 */
+		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) | __GFP_NOWARN |
+			__GFP_NOMEMALLOC | GFP_NOWAIT,
+		.nid = target_nid,
+		.nmask = &allowed_mask
+	};
 
 	if (list_empty(demote_pages))
 		return 0;
@@ -1494,10 +1520,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	if (target_nid == NUMA_NO_NODE)
 		return 0;
 
+	node_get_allowed_targets(pgdat, &allowed_mask);
+
 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_pages, alloc_demote_page, NULL,
-			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
-			    &nr_succeeded);
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+		      &nr_succeeded);
 
 	if (current_is_kswapd())
 		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
-- 
2.36.1

