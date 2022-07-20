Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2557AE3A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiGTDCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240751AbiGTDA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06202C641
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:53 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2gQKg002780;
        Wed, 20 Jul 2022 03:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CoWRC8zLpfrq8J5yaBXe8uR3c59RwBfJjTSs16zKYno=;
 b=aOUVI6bG0fRGC71i3Gjm/a+YdSYnxHdf0O/xVTegxer8iAC8V7oy6s4+Nf1BbMoELFR/
 HaxIPZbVpL6FrBmquh1pRNV6o93LKots8/2Goi1zP/drC1+Xmnv94gDIX5efJMQUKooh
 TZ88WUXyOueDr4DLcC7KImRcuN8eWJDZSEYkS78wEP0LVyyEWLppeOqKbN0w7kXFqcqp
 teoLRYwkWzmIH/0mapY/UJrsgFCJzUJbhW49NGF4m1SHSJGU3NQXxrHznRGBq4rdAqFx
 Rc0115IkJCwKGxSPe0YsauhI6V9U/EHzDIS8NKgLvkmJedIgmpcI9fxvwEoN478pmJpS Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598d35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:42 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K2xsqr022449;
        Wed, 20 Jul 2022 03:00:41 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598d2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:41 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K2p0J1027798;
        Wed, 20 Jul 2022 03:00:40 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3hbmy9vt1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:40 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K30dsS11010588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:00:39 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA80213605E;
        Wed, 20 Jul 2022 03:00:38 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A04E136066;
        Wed, 20 Jul 2022 03:00:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.15.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 03:00:31 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v10 8/8] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Wed, 20 Jul 2022 08:29:20 +0530
Message-Id: <20220720025920.1373558-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jC0zOs31DDl7MnCGEYeteHwwZw2sOjUA
X-Proofpoint-ORIG-GUID: TCbzbyk4VwdzNTjq3ayFAyVUkK2vGQcb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With memory tiers support we can have memory only NUMA nodes
in the top tier from which we want to avoid promotion tracking NUMA
faults. Update node_is_toptier to work with memory tiers.
All NUMA nodes are by default top tier nodes. With lower memory
tiers added we consider all memory tiers above a memory tier having
CPU NUMA nodes as a top memory tier

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h | 11 +++++++++
 include/linux/node.h         |  5 -----
 mm/huge_memory.c             |  1 +
 mm/memory-tiers.c            | 43 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 |  1 +
 mm/mprotect.c                |  1 +
 6 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 0e58588fa066..085dd815bf73 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -20,6 +20,7 @@ extern bool numa_demotion_enabled;
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
+bool node_is_toptier(int node);
 #else
 static inline int next_demotion_node(int node)
 {
@@ -30,6 +31,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
 {
 	*targets = NODE_MASK_NONE;
 }
+
+static inline bool node_is_toptier(int node)
+{
+	return true;
+}
 #endif
 
 #else
@@ -44,5 +50,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
 {
 	*targets = NODE_MASK_NONE;
 }
+
+static inline bool node_is_toptier(int node)
+{
+	return true;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index a2a16d4104fd..d0432db18094 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -191,9 +191,4 @@ static inline void register_hugetlbfs_with_node(node_registration_func_t reg,
 
 #define to_node(device) container_of(device, struct node, dev)
 
-static inline bool node_is_toptier(int node)
-{
-	return node_state(node, N_CPU);
-}
-
 #endif /* _LINUX_NODE_H_ */
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 834f288b3769..8405662646e9 100644
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
index 4a96e4213d66..f0515bfd4051 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -13,6 +13,7 @@
 
 struct memory_tier {
 	struct list_head list;
+	int id;
 	int perf_level;
 	nodemask_t nodelist;
 	nodemask_t lower_tier_mask;
@@ -26,6 +27,7 @@ static LIST_HEAD(memory_tiers);
 static DEFINE_MUTEX(memory_tier_lock);
 
 #ifdef CONFIG_MIGRATION
+static int top_tier_id;
 /*
  * node_demotion[] examples:
  *
@@ -129,6 +131,7 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
 	if (!new_memtier)
 		return ERR_PTR(-ENOMEM);
 
+	new_memtier->id = perf_level >> MEMTIER_CHUNK_BITS;
 	new_memtier->perf_level = perf_level;
 	if (found_slot)
 		list_add_tail(&new_memtier->list, ent);
@@ -154,6 +157,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
 }
 
 #ifdef CONFIG_MIGRATION
+bool node_is_toptier(int node)
+{
+	bool toptier;
+	pg_data_t *pgdat;
+	struct memory_tier *memtier;
+
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return false;
+
+	rcu_read_lock();
+	memtier = rcu_dereference(pgdat->memtier);
+	if (!memtier) {
+		toptier = true;
+		goto out;
+	}
+	if (memtier->id >= top_tier_id)
+		toptier = true;
+	else
+		toptier = false;
+out:
+	rcu_read_unlock();
+	return toptier;
+}
+
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
 	struct memory_tier *memtier;
@@ -304,6 +332,21 @@ static void establish_migration_targets(void)
 			}
 		} while (1);
 	}
+	/*
+	 * Promotion is allowed from a memory tier to higher
+	 * memory tier only if the memory tier doesn't include
+	 * compute. We want to  skip promotion from a memory tier,
+	 * if any node that is  part of the memory tier have CPUs.
+	 * Once we detect such a memory tier, we consider that tier
+	 * as top tiper from which promotion is not allowed.
+	 */
+	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
+		nodes_and(used, node_states[N_CPU], memtier->nodelist);
+		if (!nodes_empty(used)) {
+			top_tier_id = memtier->id;
+			break;
+		}
+	}
 	/*
 	 * Now build the lower_tier mask for each node collecting node mask from
 	 * all memory tier below it. This allows us to fallback demotion page
diff --git a/mm/migrate.c b/mm/migrate.c
index c758c9c21d7d..1da81136eaaa 100644
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

