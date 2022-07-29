Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DF5584B83
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbiG2GP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbiG2GO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88877C1B6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:14:56 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T6DcCQ037411;
        Fri, 29 Jul 2022 06:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ihDSNqc+mrTfemNnrHJsO9nvs/AbV0Z1flG5zdRFI1I=;
 b=d7dnFj4SXv+k7jIrC9UonXfeMbV+vKXYLFa6xqVZehD+ALFP3a9+JR3y0NukkXKmUi/g
 xZOrJEXxt1E+r7VibxbnHrZ/MlewIy/W2JyA1+PBMwEL0bLMqbUuSx3rIFZuLC0XKWt3
 2apm4zsQbel8e17t3pwFhuOl0myMhbLYXJTgHNNOq7wnr03E7Q8r+ewFR1f8a/jdja2N
 J0EGqlwfSWGqIbY7yyp8/OjVE/pkl3knc6Tucl3N/9ruX8zqE37THvUauQIFFrJpdWRS
 TOvpBobWG6xNu0yJdUYDNLB2Pm0LrTD7fJDM7pTqH8MSss5SPHDdmWYBMicss8zJUgTX Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma3bg0q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:43 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T6EhEA003297;
        Fri, 29 Jul 2022 06:14:43 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma3bg0pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:42 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T66U2l011418;
        Fri, 29 Jul 2022 06:14:42 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b3y02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:42 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6EfVf38732268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:14:41 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AE37805E;
        Fri, 29 Jul 2022 06:14:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E59478060;
        Fri, 29 Jul 2022 06:14:36 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.86.244])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:14:36 +0000 (GMT)
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
Subject: [PATCH v12 8/8] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Fri, 29 Jul 2022 11:43:49 +0530
Message-Id: <20220729061349.968148-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xIOrblx1FhfU37JUCahrI7n7XX5VG2zm
X-Proofpoint-GUID: a6o7aIHrKSHp7NUkVM93M5PHabrHpyHN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207290023
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
 include/linux/memory-tiers.h | 11 ++++++++++
 include/linux/node.h         |  5 -----
 mm/huge_memory.c             |  1 +
 mm/memory-tiers.c            | 42 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 |  1 +
 mm/mprotect.c                |  1 +
 6 files changed, 56 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 6be1c9fca01f..5553461978f7 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -34,6 +34,7 @@ struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
+bool node_is_toptier(int node);
 #else
 static inline int next_demotion_node(int node)
 {
@@ -44,6 +45,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
@@ -63,5 +69,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
index 82556f8e76e0..4b442bd61973 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -32,6 +32,7 @@ static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 struct memory_dev_type *node_memory_types[MAX_NUMNODES];
 #ifdef CONFIG_MIGRATION
+static int top_tier_adistance;
 /*
  * node_demotion[] examples:
  *
@@ -161,6 +162,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
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
+	if (memtier->adistance_start <= top_tier_adistance)
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
@@ -317,6 +343,22 @@ static void establish_demotion_targets(void)
 			}
 		} while (1);
 	}
+	/*
+	 * Promotion is allowed from a memory tier to higher
+	 * memory tier only if the memory tier doesn't include
+	 * compute. We want to skip promotion from a memory tier,
+	 * if any node that is part of the memory tier have CPUs.
+	 * Once we detect such a memory tier, we consider that tier
+	 * as top tiper from which promotion is not allowed.
+	 */
+	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
+		tier_nodes = get_memtier_nodemask(memtier);
+		nodes_and(tier_nodes, node_states[N_CPU], tier_nodes);
+		if (!nodes_empty(tier_nodes)) {
+			top_tier_adistance = memtier->adistance_start;
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
2.37.1

