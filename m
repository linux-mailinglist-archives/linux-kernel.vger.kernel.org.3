Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E063584B82
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiG2GPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbiG2GO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:14:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF17F535
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:14:52 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T61MAp019048;
        Fri, 29 Jul 2022 06:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dDkVJpfVuHGzgCIvLNsdy2VYyWK+HP3LW0HoqQURJaU=;
 b=rk5tR9cFDubr3IwUU3Vxp/1V2BtWFWORvhrQ51XyV917J0BXgauMBM8JZROJZRUunDFH
 qksTcCCVIruLw9lxCcHXsZGIuJ1ibH48WGV0kDnFuv+UaMUm8ODP4+KV1xh7kpnTv5U8
 f1yO74jI+3vMywDMT6+J4CdOZMbwrYZYI5LRkuizpqVMOttH/hVb6VqY9FeNCPcYw0kr
 ST8obcbEHmnD3oiXQq1/Rlk07jJj8hsajpv06liDCV0RyWJBpWoS5/gdiPWLm4eHgLuf
 wnNwocvhNW0ze1v7aSuBR1E0l9md7cyItcFQ9/J19t4e2o/ttimbUOpmBTJLwSh86HW7 ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm9wv0bd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:39 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T62P1j021891;
        Fri, 29 Jul 2022 06:14:38 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm9wv0bce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:38 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T65oLq026529;
        Fri, 29 Jul 2022 06:14:37 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3hhfpj9dq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6EalP39059862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:14:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E68CB78063;
        Fri, 29 Jul 2022 06:14:35 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D23067805E;
        Fri, 29 Jul 2022 06:14:30 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.86.244])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:14:30 +0000 (GMT)
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v12 7/8] mm/demotion: Demote pages according to allocation fallback order
Date:   Fri, 29 Jul 2022 11:43:48 +0530
Message-Id: <20220729061349.968148-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6nJPblwXv_Vu51JdDypOYDterMsQuCnO
X-Proofpoint-GUID: ebBJg1837J3U_6U1UElOdl5qyOBZwdqF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya.oss@gmail.com>

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
---
 include/linux/memory-tiers.h | 12 ++++++++
 mm/memory-tiers.c            | 50 +++++++++++++++++++++++++++++--
 mm/vmscan.c                  | 58 ++++++++++++++++++++++++++----------
 3 files changed, 102 insertions(+), 18 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c825d99adace..6be1c9fca01f 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/nodemask.h>
+#include <linux/mmzone.h>
 /*
  * Each tier cover a abstrace distance chunk size of 128
  */
@@ -32,11 +33,17 @@ extern bool numa_demotion_enabled;
 struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
 #else
 static inline int next_demotion_node(int node)
 {
 	return NUMA_NO_NODE;
 }
+
+static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
 #endif
 
 #else
@@ -51,5 +58,10 @@ static inline int next_demotion_node(int node)
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
index 44f6676bc2c8..82556f8e76e0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,7 +5,6 @@
 #include <linux/kobject.h>
 #include <linux/memory.h>
 #include <linux/random.h>
-#include <linux/mmzone.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -21,6 +20,8 @@ struct memory_tier {
 	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
 	 */
 	int adistance_start;
+	/* All the nodes that are part of all the lower memory tiers. */
+	nodemask_t lower_tier_mask;
 };
 
 struct demotion_nodes {
@@ -160,6 +161,24 @@ static struct memory_tier *__node_get_memory_tier(int node)
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
@@ -207,10 +226,18 @@ int next_demotion_node(int node)
 
 static void disable_all_demotion_targets(void)
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
+		memtier = __node_get_memory_tier(node);
+		memtier->lower_tier_mask = NODE_MASK_NONE;
+	}
 	/*
 	 * Ensure that the "disable" is visible across the system.
 	 * Readers will see either a combination of before+disable
@@ -242,7 +269,7 @@ static void establish_demotion_targets(void)
 	struct demotion_nodes *nd;
 	int target = NUMA_NO_NODE, node;
 	int distance, best_distance;
-	nodemask_t tier_nodes;
+	nodemask_t tier_nodes, lower_tier;
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -290,6 +317,23 @@ static void establish_demotion_targets(void)
 			}
 		} while (1);
 	}
+	/*
+	 * Now build the lower_tier mask for each node collecting node mask from
+	 * all memory tier below it. This allows us to fallback demotion page
+	 * allocation to a set of nodes that is closer the above selected
+	 * perferred node.
+	 */
+	lower_tier = node_states[N_MEMORY];
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		/*
+		 * Keep removing current tier from lower_tier nodes,
+		 * This will remove all nodes in current and above
+		 * memory tier from the lower_tier mask.
+		 */
+		tier_nodes = get_memtier_nodemask(memtier);
+		nodes_andnot(lower_tier, lower_tier, tier_nodes);
+		memtier->lower_tier_mask = lower_tier;
+	}
 }
 
 #else
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 3a8f78277f99..303c93958371 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1460,21 +1460,34 @@ static void folio_check_dirty_writeback(struct folio *folio,
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
+	 * demote or reclaim pages from the target node via kswapd if we are
+	 * low on free memory on target node. If we don't do this and if
+	 * we have free memory on the slower(lower) memtier, we would start
+	 * allocating pages from slower(lower) memory tiers without even forcing
+	 * a demotion of cold pages from the target memtier. This can result
+	 * in the kernel placing hot pages in slower(lower) memory tiers.
+	 */
+	mtc->nmask = NULL;
+	mtc->gfp_mask |= __GFP_THISNODE;
+	target_page = alloc_migration_target(page, (unsigned long)mtc);
+	if (target_page)
+		return target_page;
 
-	return alloc_migration_target(page, (unsigned long)&mtc);
+	mtc->gfp_mask &= ~__GFP_THISNODE;
+	mtc->nmask = allowed_mask;
+
+	return alloc_migration_target(page, (unsigned long)mtc);
 }
 
 /*
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
2.37.1

