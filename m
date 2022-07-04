Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1DE564E61
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiGDHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGDHJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:09:35 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB8E765B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:09:07 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2645KfAe003077;
        Mon, 4 Jul 2022 07:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=hUyi/Ewdwg0NlA1nQkTma+so8NWcD0GJt0NyJpTGi2A=;
 b=KOsHwmqA5RTgfZE5wfm/FuijQCvnsufL9KZ5NBK/lWjWq/qPq9ob8k0U5RE2Hd0vWw9o
 hXHuJKnrau6IycZCBWJoWDd++zgrTZWzMAlE61i+/iv1lG/f7vX1UIviIywPqrCo23Q+
 p8LVwQLFQ5Yz/lCR+UbZfVw4Ia3GO4S2xJEz/eC95vE1n4aGJxokjdxzD9vzXJv+WWHk
 8o207pBtOcEjHXeJSLwnimx/Bhq7aFR1YqhxnOXM3vN6BNqpqzKirHLm69ZitgRrXidW
 KWkUr21waJcQCzJINHVoDP2byTtriRq5lrYde/hPYgrFj2V42dNc3U9hJhSHQaXJNFUU UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3pd0dx41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:53 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646iX8S013680;
        Mon, 4 Jul 2022 07:08:52 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3pd0dx3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:52 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26475sSr029158;
        Mon, 4 Jul 2022 07:08:51 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 3h2dn9kmqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:51 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26478oWa8192940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:08:50 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45DDE124052;
        Mon,  4 Jul 2022 07:08:50 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10787124053;
        Mon,  4 Jul 2022 07:08:44 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:08:43 +0000 (GMT)
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
Subject: [PATCH v8 10/12] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Mon,  4 Jul 2022 12:36:10 +0530
Message-Id: <20220704070612.299585-11-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: K21_444ex2KrAbodTZq-HdtbKBnCVsKC
X-Proofpoint-GUID: hxcYd6TCiWH1BHKWODV3MJIAtj_w4oQR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/memory-tiers.h |  6 ++++++
 include/linux/node.h         |  5 -----
 mm/huge_memory.c             |  1 +
 mm/memory-tiers.c            | 41 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 |  1 +
 mm/mprotect.c                |  1 +
 6 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 335d21a30b2c..ff1a08933575 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -44,6 +44,7 @@ int node_get_memory_tier_id(int node);
 int node_update_memory_tier(int node, int tier);
 struct memory_tier *node_get_memory_tier(int node);
 void node_put_memory_tier(struct memory_tier *memtier);
+bool node_is_toptier(int node);
 
 #else
 
@@ -62,5 +63,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
index aecce987df7c..7204f7381a15 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -18,6 +18,7 @@ struct demotion_nodes {
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
+static int top_tier_id;
 /*
  * node_demotion[] examples:
  *
@@ -373,6 +374,31 @@ void node_put_memory_tier(struct memory_tier *memtier)
 	put_device(&memtier->dev);
 }
 
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
+	if (memtier->dev.id >= top_tier_id)
+		toptier = true;
+	else
+		toptier = false;
+out:
+	rcu_read_unlock();
+	return toptier;
+}
+
 #ifdef CONFIG_MIGRATION
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 {
@@ -545,6 +571,21 @@ static void establish_migration_targets(void)
 		} while (1);
 	}
 build_lower_tier_mask:
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
+			top_tier_id = memtier->dev.id;
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

