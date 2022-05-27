Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A668C5362C1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348090AbiE0MlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352087AbiE0Mjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D07108AB4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:27:29 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RBmhkI008032;
        Fri, 27 May 2022 12:27:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PyERyMAgw05gN1oOCqQVYLFbKQwtDSBRFZSi5AKtpig=;
 b=mk+1j8pxMIFT375bRSGQRHWyTZmov8IXMe69DhlfsyVa/U0sHxSbS/QthT3/AI6ke1zY
 6n48+mFknpuiPrslkELppqNPIJmPDWEBzSA4fsO+CStKMJaK1F93Jnve8oGKcto5jmO8
 CekD181DqUR702EuOHSr3X9LlJxK5zFeBHhobEgFJhcPpt7mieLrjf+aftgAmOrfchOs
 ohk1bF+bcjcHGHK6YfiWNk4yOqjyg4oPwUbE0/v9RpUWvHgxTdnZVL3LLagHRAEJHIgj
 P6C7L/P04RYXMvbyMwr1vHJlFeL/SEgmF6td0/UfLxD5vZsvg3iV2nkpcpkTWC9q0kLT vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax3n0n4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:19 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RCH7CP013652;
        Fri, 27 May 2022 12:27:18 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax3n0n4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:18 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCL6uh006940;
        Fri, 27 May 2022 12:27:17 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3gaenbn8h4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:17 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCRGKq29688218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:27:16 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5AC7AE05F;
        Fri, 27 May 2022 12:27:16 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E68A9AE05C;
        Fri, 27 May 2022 12:27:09 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:27:09 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
Subject: [RFC PATCH v4 7/7] mm/demotion: Demote pages according to allocation fallback order
Date:   Fri, 27 May 2022 17:55:28 +0530
Message-Id: <20220527122528.129445-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: T0dnHSiKJMe451gjRMRD22uPyDWVz9Iv
X-Proofpoint-ORIG-GUID: LYhF5tD3ead4QJs9SC9dSF5F2YdO1B24
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya@linux.ibm.com>

currently, a higher tier node can only be demoted to selected
nodes on the next lower tier as defined by the demotion path,
not any other node from any lower tier.  This strict, hard-coded
demotion order does not work in all use cases (e.g. some use cases
may want to allow cross-socket demotion to another node in the same
demotion tier as a fallback when the preferred demotion node is out
of space). This demotion order is also inconsistent with the page
allocation fallback order when all the nodes in a higher tier are
out of space: The page allocation can fall back to any node from any
lower tier, whereas the demotion order doesn't allow that currently.

This patch adds support to get all the allowed demotion targets mask
for node, also demote_page_list() function is modified to utilize this
allowed node mask by filling it in migration_target_control structure
before passing it to migrate_pages().

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/migrate.h |  5 ++++
 mm/migrate.c            | 52 +++++++++++++++++++++++++++++++++++++----
 mm/vmscan.c             | 38 ++++++++++++++----------------
 3 files changed, 71 insertions(+), 24 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 77c581f47953..1f3cbd5185ca 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -182,6 +182,7 @@ void node_remove_from_memory_tier(int node);
 int node_get_memory_tier_id(int node);
 int node_set_memory_tier_rank(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
+void node_get_allowed_targets(int node, nodemask_t *targets);
 #else
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
@@ -189,6 +190,10 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline void node_get_allowed_targets(int node, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif /* _LINUX_MIGRATE_H */
diff --git a/mm/migrate.c b/mm/migrate.c
index 114c7428b9f3..84fac477538c 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2129,6 +2129,7 @@ struct memory_tier {
 
 struct demotion_nodes {
 	nodemask_t preferred;
+	nodemask_t allowed;
 };
 
 #define to_memory_tier(device) container_of(device, struct memory_tier, dev)
@@ -2475,6 +2476,25 @@ int node_set_memory_tier_rank(int node, int rank)
 }
 EXPORT_SYMBOL_GPL(node_set_memory_tier_rank);
 
+void node_get_allowed_targets(int node, nodemask_t *targets)
+{
+	/*
+	 * node_demotion[] is updated without excluding this
+	 * function from running.
+	 *
+	 * If any node is moving to lower tiers then modifications
+	 * in node_demotion[] are still valid for this node, if any
+	 * node is moving to higher tier then moving node may be
+	 * used once for demotion which should be ok so rcu should
+	 * be enough here.
+	 */
+	rcu_read_lock();
+
+	*targets = node_demotion[node].allowed;
+
+	rcu_read_unlock();
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -2534,8 +2554,10 @@ static void __disable_all_migrate_targets(void)
 {
 	int node;
 
-	for_each_node_mask(node, node_states[N_MEMORY])
+	for_each_node_mask(node, node_states[N_MEMORY]) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
+		node_demotion[node].allowed = NODE_MASK_NONE;
+	}
 }
 
 static void disable_all_migrate_targets(void)
@@ -2558,12 +2580,11 @@ static void disable_all_migrate_targets(void)
 */
 static void establish_migration_targets(void)
 {
-	struct list_head *ent;
 	struct memory_tier *memtier;
 	struct demotion_nodes *nd;
-	int tier, target = NUMA_NO_NODE, node;
+	int target = NUMA_NO_NODE, node;
 	int distance, best_distance;
-	nodemask_t used;
+	nodemask_t used, allowed = NODE_MASK_NONE;
 
 	if (!node_demotion)
 		return;
@@ -2603,6 +2624,29 @@ static void establish_migration_targets(void)
 			}
 		} while (1);
 	}
+	/*
+	 * Now build the allowed mask for each node collecting node mask from
+	 * all memory tier below it. This allows us to fallback demotion page
+	 * allocation to a set of nodes that is closer the above selected
+	 * perferred node.
+	 */
+	list_for_each_entry(memtier, &memory_tiers, list)
+		nodes_or(allowed, allowed, memtier->nodelist);
+	/*
+	 * Removes nodes not yet in N_MEMORY.
+	 */
+	nodes_and(allowed, node_states[N_MEMORY], allowed);
+
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		/*
+		 * Keep removing current tier from allowed nodes,
+		 * This will remove all nodes in current and above
+		 * memory tier from the allowed mask.
+		 */
+		nodes_andnot(allowed, allowed, memtier->nodelist);
+		for_each_node_mask(node, memtier->nodelist)
+			node_demotion[node].allowed = allowed;
+	}
 }
 
 /*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 1678802e03e7..feb994589481 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1454,23 +1454,6 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(&folio->page, dirty, writeback);
 }
 
-static struct page *alloc_demote_page(struct page *page, unsigned long node)
-{
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
-
-	return alloc_migration_target(page, (unsigned long)&mtc);
-}
-
 /*
  * Take pages on @demote_list and attempt to demote them to
  * another node.  Pages which are not demoted are left on
@@ -1481,6 +1464,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
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
@@ -1488,10 +1484,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 	if (target_nid == NUMA_NO_NODE)
 		return 0;
 
+	node_get_allowed_targets(pgdat->node_id, &allowed_mask);
+
 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_pages, alloc_demote_page, NULL,
-			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
-			    &nr_succeeded);
+	migrate_pages(demote_pages, alloc_migration_target, NULL,
+		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+		      &nr_succeeded);
 
 	if (current_is_kswapd())
 		__count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
-- 
2.36.1

