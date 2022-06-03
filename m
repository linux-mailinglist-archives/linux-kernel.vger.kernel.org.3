Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E1D53CAD4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244773AbiFCNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244819AbiFCNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:44:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B933A5D6
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:44:45 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253CFLgN002903;
        Fri, 3 Jun 2022 13:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BUCn0BY2ZXsWri4dRdU95JjN/8kb3U+L/F9XlYqa2Bg=;
 b=BVnWdjjulZzHbLLJyBuVL9VJJrL5p7elwwnZV1I9qfuEPb78HGwg8g7g0KD6NX1rarjq
 9qjNMLIwKb0RIrS5nNaHca8k78ZVCHLQ8UDKstvqXGXStThoW9crb6NyCYXUCVV/8bka
 OB3d55aXErE9cfaAdwDxqTijwxoiRq/45WXA+FnJSVjE/rm44Pq50a/CU+MRsqjJyW90
 YySszjPwPz0HZ1eP1MxJwKLzIzuE+XYxSSyCOeKXXdLaBzDqyeH3hQN0kkwc8Qs30sYY
 eVN1TZCHKm0067GYxYT+DlTtyX1psgvifpxlXWehSaq3qrw5t95OfOlIfTfQo/dCdGXq zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfgg8b99f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:36 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253Cwqok004481;
        Fri, 3 Jun 2022 13:44:36 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfgg8b996-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:36 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DaUVL027611;
        Fri, 3 Jun 2022 13:44:35 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3gd4n68dq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:35 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DiYHU9830668
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:44:34 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 190F0112063;
        Fri,  3 Jun 2022 13:44:34 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84AC2112062;
        Fri,  3 Jun 2022 13:44:26 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:44:26 +0000 (GMT)
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
Subject: [PATCH v5 9/9] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Fri,  3 Jun 2022 19:12:37 +0530
Message-Id: <20220603134237.131362-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h6x5ag3c0QcohwVDA3Yn5j1SGQueDgDx
X-Proofpoint-GUID: xxrlc1sSbC-F3CxfgTlo2b9hGvdng3ck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With memory tiers support we can have memory on NUMA nodes
in the top tier from which we want to avoid promotion tracking NUMA
faults. Update node_is_toptier to work with memory tiers. To
avoid taking locks, a nodemask is maintained for all demotion
targets. All NUMA nodes are by default top tier nodes and as
we add new lower memory tiers NUMA nodes get added to the
demotion targets thereby moving them out of the top tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h | 16 ++++++++++++++++
 include/linux/node.h         |  5 -----
 mm/huge_memory.c             |  1 +
 mm/memory-tiers.c            | 10 ++++++++++
 mm/migrate.c                 |  1 +
 mm/mprotect.c                |  1 +
 6 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index cd6e71f702ad..32e0e6fabf02 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -16,12 +16,23 @@
 #define MAX_MEMORY_TIERS  3
 
 extern bool numa_demotion_enabled;
+extern nodemask_t demotion_target_mask;
 int next_demotion_node(int node);
 void node_remove_from_memory_tier(int node);
 int node_get_memory_tier_id(int node);
 int node_set_memory_tier(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
 void node_get_allowed_targets(int node, nodemask_t *targets);
+
+/*
+ * By default all nodes are top tiper. As we create new memory tiers
+ * we below top tiers we add them to NON_TOP_TIER state.
+ */
+static inline bool node_is_toptier(int node)
+{
+	return !node_isset(node, demotion_target_mask);
+}
+
 #else
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
@@ -33,6 +44,11 @@ static inline void node_get_allowed_targets(int node, nodemask_t *targets)
 {
 	*targets = NODE_MASK_NONE;
 }
+
+static inline bool node_is_toptier(int node)
+{
+	return true;
+}
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif
diff --git a/include/linux/node.h b/include/linux/node.h
index 40d641a8bfb0..9ec680dd607f 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -185,9 +185,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
-static inline bool node_is_toptier(int node)
-{
-	return node_state(node, N_CPU);
-}
-
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a77c78a2b6b5..294873d4be2b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -35,6 +35,7 @@
 #include <linux/numa.h>
 #include <linux/page_owner.h>
 #include <linux/sched/sysctl.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlb.h>
 #include <asm/pgalloc.h>
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 592d939ec28d..df8e9910165a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -31,6 +31,7 @@ static struct bus_type memory_tier_subsys = {
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
+nodemask_t demotion_target_mask;
 
 /*
  * node_demotion[] examples:
@@ -541,6 +542,15 @@ static void establish_migration_targets(void)
 	 */
 	list_for_each_entry(memtier, &memory_tiers, list)
 		nodes_or(allowed, allowed, memtier->nodelist);
+	/*
+	 * Add nodes to demotion target mask so that we can find
+	 * top tier easily.
+	 */
+	memtier = list_first_entry(&memory_tiers, struct memory_tier, list);
+	if (memtier)
+		nodes_andnot(demotion_target_mask, allowed, memtier->nodelist);
+	else
+		demotion_target_mask = NODE_MASK_NONE;
 	/*
 	 * Removes nodes not yet in N_MEMORY.
 	 */
diff --git a/mm/migrate.c b/mm/migrate.c
index 0b554625a219..78615c48fc0f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -50,6 +50,7 @@
 #include <linux/memory.h>
 #include <linux/random.h>
 #include <linux/sched/sysctl.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlbflush.h>
 
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ba5592655ee3..92a2fc0fa88b 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -31,6 +31,7 @@
 #include <linux/pgtable.h>
 #include <linux/sched/sysctl.h>
 #include <linux/userfaultfd_k.h>
+#include <linux/memory-tiers.h>
 #include <asm/cacheflush.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
-- 
2.36.1

