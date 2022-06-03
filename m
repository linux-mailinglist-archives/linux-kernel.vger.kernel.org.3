Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F24253CAD5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244809AbiFCNop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244829AbiFCNod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:44:33 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAAB39690
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:44:30 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253Cugre026540;
        Fri, 3 Jun 2022 13:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZOQN208AaTMt4Y+rjYXoDEA9HvNVnabUjL2wDLR89+M=;
 b=SVwRTlydakEiEI2ExzaCjiQoCkbSDUJbzD0j/unXVRqXFXBRHUDGJUZxCVucIU27iRRT
 tWGPNpYzTDXSNYMBI8ySXFb/lw+4xmYpOSYhANF00fgiIkyg6DYPK7fDDZIQB7sfCGCO
 klc6fW7m1CsB65Pp3TUUDwh7r0axd8pThyKWDVrgcza207YDyDict+Nh6bBZjxmwSkPP
 GhTkBW8oFo/RccO3OciudbM0czOPgrPDFdPPOfc0WjXiPXhmOXVMlheE71BA0qUSvZ/T
 cuf1h/V19n8oRnbat1Ibvakw5EkQlHH3Qbrt76BIqDAQFKqzkz6RogjgnsEDNXnqzmFn wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfjrgrwnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:19 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253D0hf7010880;
        Fri, 3 Jun 2022 13:44:18 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfjrgrwn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:18 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DamLW010706;
        Fri, 3 Jun 2022 13:44:17 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma03dal.us.ibm.com with ESMTP id 3gd3yn8t3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:17 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DiG6k17498544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:44:16 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E96D112065;
        Fri,  3 Jun 2022 13:44:16 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9920112063;
        Fri,  3 Jun 2022 13:44:08 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:44:08 +0000 (GMT)
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
Subject: [PATCH v5 7/9] mm/demotion: Demote pages according to allocation fallback order
Date:   Fri,  3 Jun 2022 19:12:35 +0530
Message-Id: <20220603134237.131362-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mX0Gsxn3vtIVcf4XO3jJ852AA3picwmx
X-Proofpoint-GUID: B5_lxBaSxwSVGbsYsGyLNsySyo553IWv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206030059
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
 include/linux/memory-tiers.h |  5 ++++
 mm/memory-tiers.c            | 49 ++++++++++++++++++++++++++++++++++--
 mm/vmscan.c                  | 38 +++++++++++++---------------
 3 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 79bd8d26feb2..cd6e71f702ad 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -21,6 +21,7 @@ void node_remove_from_memory_tier(int node);
 int node_get_memory_tier_id(int node);
 int node_set_memory_tier(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
+void node_get_allowed_targets(int node, nodemask_t *targets);
 #else
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
@@ -28,6 +29,10 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 
+static inline void node_get_allowed_targets(int node, nodemask_t *targets)
+{
+	*targets = NODE_MASK_NONE;
+}
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index b4e72b672d4d..592d939ec28d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -18,6 +18,7 @@ struct memory_tier {
 
 struct demotion_nodes {
 	nodemask_t preferred;
+	nodemask_t allowed;
 };
 
 #define to_memory_tier(device) container_of(device, struct memory_tier, dev)
@@ -378,6 +379,25 @@ int node_set_memory_tier(int node, int tier)
 }
 EXPORT_SYMBOL_GPL(node_set_memory_tier);
 
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
@@ -437,8 +457,10 @@ static void __disable_all_migrate_targets(void)
 {
 	int node;
 
-	for_each_node_mask(node, node_states[N_MEMORY])
+	for_each_node_mask(node, node_states[N_MEMORY]) {
 		node_demotion[node].preferred = NODE_MASK_NONE;
+		node_demotion[node].allowed = NODE_MASK_NONE;
+	}
 }
 
 static void disable_all_migrate_targets(void)
@@ -465,7 +487,7 @@ static void establish_migration_targets(void)
 	struct demotion_nodes *nd;
 	int target = NUMA_NO_NODE, node;
 	int distance, best_distance;
-	nodemask_t used;
+	nodemask_t used, allowed = NODE_MASK_NONE;
 
 	if (!node_demotion)
 		return;
@@ -511,6 +533,29 @@ static void establish_migration_targets(void)
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
index 3a8f78277f99..d424b7af2f26 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1460,23 +1460,6 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
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
@@ -1487,6 +1470,19 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
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
@@ -1494,10 +1490,12 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
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

