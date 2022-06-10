Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4B45467D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349305AbiFJN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349396AbiFJN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:56:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3AFEBA89
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:55:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADSwkM014931;
        Fri, 10 Jun 2022 13:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FpxL9Ln0v69rC5KIlQJwCAYoGwImaAzWCPNQvJ60qXQ=;
 b=fdIxt0zxlEGhWffkJ34cWNH5xr9EFe2+k3oNYZwD4vh2vVfR8c4Y3UjTXcw+pjzuUz/C
 JTtvzr9lRGFeoYZ2OVgbF887Th06jUI2ci3bBeGZBy64Z7d6l3cL1raqTuaHP/WZokbX
 R0c0vLEig3nWevFtEoBEOjMNl9V2WbQ+zqqKNmTc7qvLRibRdoGvRKOkc/8HGOnoiCME
 3PkiOOA7J0m9nDz58MWRi/VS9F81BhAEQ2qfhXlz4xBFOsDAI6FX2LXVuwoBAq8bIMG9
 LWOMkHLq4d2fGWcsB+dd6VrcWT5wahURSiFzqJWVFSGyZzGB4yVLWu5L5kDDW8ePwYyU Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6vn0hny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:24 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADTVND016419;
        Fri, 10 Jun 2022 13:54:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6vn0hnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZUgA014203;
        Fri, 10 Jun 2022 13:54:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3gfy1bb4nu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:22 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADsLhV27787614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:54:21 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15B9C6A054;
        Fri, 10 Jun 2022 13:54:21 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A75976A051;
        Fri, 10 Jun 2022 13:54:12 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:54:12 +0000 (GMT)
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v6 10/13] mm/demotion: Demote pages according to allocation fallback order
Date:   Fri, 10 Jun 2022 19:22:26 +0530
Message-Id: <20220610135229.182859-11-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K2OOSuMIPyM457UvPbCNfWNYppAmgXji
X-Proofpoint-ORIG-GUID: uusJ_FgopAssqf6frHcE5ZCvfQ4kDUV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
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
 include/linux/memory-tiers.h |  9 ++++-
 mm/memory-tiers.c            | 75 +++++++++++++++++++++++++++++++++---
 mm/vmscan.c                  | 56 ++++++++++++++++++++-------
 3 files changed, 120 insertions(+), 20 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 53f3e4c7cba8..47841379553c 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -3,11 +3,12 @@
 #define _LINUX_MEMORY_TIERS_H
 
 #include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/mmzone.h>
 
 #ifdef CONFIG_TIERED_MEMORY
 
 #include <linux/device.h>
-#include <linux/nodemask.h>
 
 #define MEMORY_TIER_HBM_GPU	0
 #define MEMORY_TIER_DRAM	1
@@ -25,6 +26,7 @@ struct memory_tier {
 	struct list_head list;
 	struct device dev;
 	nodemask_t nodelist;
+	nodemask_t lower_tier_mask;
 	int rank;
 };
 
@@ -36,6 +38,7 @@ int node_get_memory_tier_id(int node);
 int node_reset_memory_tier(int node, int tier);
 struct memory_tier *node_get_memory_tier(int node);
 void node_put_memory_tier(struct memory_tier *memtier);
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 
 #else
 
@@ -45,6 +48,10 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 429aa864edb0..b2ed16dcfb03 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -425,6 +425,24 @@ void node_put_memory_tier(struct memory_tier *memtier)
 	put_device(&memtier->dev);
 }
 
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
@@ -473,10 +491,18 @@ int next_demotion_node(int node)
 /* Disable reclaim-based migration. */
 static void __disable_all_migrate_targets(void)
 {
+	pg_data_t *pgdat;
 	int node;
 
-	for_each_node_state(node, N_MEMORY)
+	for_each_node_state(node, N_MEMORY) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
+		/*
+		 * We are holding memory_tier_lock, it is safe
+		 * to access pgda->memtier.
+		 */
+		pgdat = NODE_DATA(node);
+		pgdat->memtier->lower_tier_mask = NODE_MASK_NONE;
+	}
 }
 
 static void disable_all_migrate_targets(void)
@@ -503,10 +529,26 @@ static void establish_migration_targets(void)
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
+		pg_data_t *pgdat;
+
+		for_each_node_state(node, N_MEMORY) {
+			/*
+			 * We are holding memory_tier_lock, it is safe
+			 * to access pgda->memtier.
+			 */
+			pgdat = NODE_DATA(node);
+			pgdat->memtier->lower_tier_mask = NODE_MASK_NONE;
+		}
+		/*
+		 * Wait for read side to work with old values
+		 * or see the updated NODE_MASK_NONE;
+		 */
+		synchronize_rcu();
+		goto build_lower_tier_mask;
+	}
 
 	disable_all_migrate_targets();
 
@@ -549,6 +591,29 @@ static void establish_migration_targets(void)
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
 
 /*
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

