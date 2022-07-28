Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE9C584688
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiG1TGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiG1TGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:06:12 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD6476979
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:06:04 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIqXdI032623;
        Thu, 28 Jul 2022 19:05:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mPrEfIzYWCgV0qzubnulyxPvGetkG71CddTv8QD7Zvc=;
 b=gP/pAGGs4Vk6uS1VqJZqfPgHLbFaAZT5chwlC3lteL2Xkgas1uD5Gmx/Khkm2CuYiEeK
 lj4nOQOKk4fMU2CNxlNBfIZs3wD4+tk8vfEYHTokfh60ChpacbtvqvO2S6DqmCLkzNs3
 Rj5Ty8ilGOBZlN5fe3qY3ZvrEkZnl+lCdRMYSPblFCVjpgUFhAqz9RGj5V8UZrCclt/j
 6Rag5c97Ay8db5M4xgiWFtpE273/6TRewEOWs2KWOteU5kbdecQTCB1cRmiHwP0XFNw5
 +N6JpZKOwtNJFPp03GzyY6+LYagTDK7Fm8crbRvD6sAXvrv/EYGg9OyskkMH6/Tta0ks Vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm04c0ca3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:47 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SIqjPM033072;
        Thu, 28 Jul 2022 19:05:46 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm04c0c97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:46 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ2bIK017352;
        Thu, 28 Jul 2022 19:05:45 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b199b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ5itV20185760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:44 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C49846A04D;
        Thu, 28 Jul 2022 19:05:44 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A0E56A047;
        Thu, 28 Jul 2022 19:05:39 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:05:38 +0000 (GMT)
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
Subject: [PATCH v11 8/8] mm/demotion: Update node_is_toptier to work with memory tiers
Date:   Fri, 29 Jul 2022 00:34:36 +0530
Message-Id: <20220728190436.858458-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8r_HMX3UjmrC3pvsKphI6B8_UTWSYyxP
X-Proofpoint-GUID: HstupbENr-Ytfr1O3Y22LWMDV2cIksJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280086
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
index f8dbeda617a7..bc9fb9d39b2c 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -35,6 +35,7 @@ struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
 void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
+bool node_is_toptier(int node);
 #else
 static inline int next_demotion_node(int node)
 {
@@ -45,6 +46,11 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
@@ -64,5 +70,10 @@ static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *target
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
index 84e2be31a853..36d87dc422ab 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -30,6 +30,7 @@ static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 struct memory_dev_type *node_memory_types[MAX_NUMNODES];
 #ifdef CONFIG_MIGRATION
+static int top_tier_adistance;
 /*
  * node_demotion[] examples:
  *
@@ -159,6 +160,31 @@ static struct memory_tier *__node_get_memory_tier(int node)
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
+	if (memtier->adistance_start >= top_tier_adistance)
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
@@ -315,6 +341,22 @@ static void establish_demotion_targets(void)
 			}
 		} while (1);
 	}
+	/*
+	 * Promotion is allowed from a memory tier to higher
+	 * memory tier only if the memory tier doesn't include
+	 * compute. We want to  skip promotion from a memory tier,
+	 * if any node that is  part of the memory tier have CPUs.
+	 * Once we detect such a memory tier, we consider that tier
+	 * as top tiper from which promotion on is not allowed.
+	 */
+	list_for_each_entry(memtier, &memory_tiers, list) {
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

