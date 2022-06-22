Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0945548A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353086AbiFVI1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349499AbiFVI0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC5C387A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:41 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M8O6Yd011338;
        Wed, 22 Jun 2022 08:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GUM9IUyra2xqLNoWXRxcJA+XK8OOsj1AeyAJRnC3H24=;
 b=tSZO0/MXAM3e9E26PEXOmAIfj2SPvjigRIYfrxTqbInRGfKdHr5hXsx/4fjs+6esfFHh
 3SoRFnIN93rv6XlK8rT33oJtAFUIbWhoPKo8ycIR5IZlksS8vrs8U5aB3ohQ4FMt5GtO
 S/u1jh1/pTVNFXqbz5fTXAFVsCAda8VYK+KbRxLD9dSJJmrZLq8urIeP0AtrdbkQvRgN
 gJq41emV2otnYW3vBNj+uqVgCLqI4KH1ZOX151GhNUTJAIjaaWVLZ6sV8FqXdUkCr24T
 dP6yBt9+V1dZQMRClKrEEyDmwPm6pgmzAFTJ1YjyraVhNfG0iIFu2PbFUWwmOhOVFIHY DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guyhm0129-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:24 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M8QNET024825;
        Wed, 22 Jun 2022 08:26:23 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guyhm0121-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:23 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8Jx0i003295;
        Wed, 22 Jun 2022 08:26:22 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3gt0098ra7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:22 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8QLoP32112958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:26:21 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D60D6E04E;
        Wed, 22 Jun 2022 08:26:21 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D3636E056;
        Wed, 22 Jun 2022 08:26:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:26:15 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v7 08/12] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Wed, 22 Jun 2022 13:55:09 +0530
Message-Id: <20220622082513.467538-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QAiM8DYuD_JA0Ci7YHG_07JMsJfFCyu2
X-Proofpoint-ORIG-GUID: 2j7BOf9Y61w8SnE13wd3gpJ-4xYXlAnX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also update different helpes to use NODE_DATA()->memtier. Since
node specific memtier can change based on the reassignment of
NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
needs to happen under an rcu read lock or memory_tier_lock.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  11 ++++
 include/linux/mmzone.h       |   3 +
 mm/memory-tiers.c            | 104 +++++++++++++++++++++++++----------
 3 files changed, 89 insertions(+), 29 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 453f6e5d357c..705b63ee31d5 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -6,6 +6,9 @@
 
 #ifdef CONFIG_NUMA
 
+#include <linux/device.h>
+#include <linux/nodemask.h>
+
 #define MEMORY_TIER_HBM_GPU	300
 #define MEMORY_TIER_DRAM	200
 #define MEMORY_TIER_PMEM	100
@@ -13,6 +16,12 @@
 #define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
 #define MAX_MEMORY_TIER_ID	400
 
+struct memory_tier {
+	struct list_head list;
+	struct device dev;
+	nodemask_t nodelist;
+};
+
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
 #ifdef CONFIG_MIGRATION
@@ -25,6 +34,8 @@ static inline int next_demotion_node(int node)
 #endif
 int node_get_memory_tier_id(int node);
 int node_update_memory_tier(int node, int tier);
+struct memory_tier *node_get_memory_tier(int node);
+void node_put_memory_tier(struct memory_tier *memtier);
 
 #else
 
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..1f846cb723fd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -928,6 +928,9 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+#ifdef CONFIG_NUMA
+	struct memory_tier *memtier;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index b7cb368cb9c0..6a2476faf13a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,22 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
-#include <linux/device.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/moduleparam.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
 
-struct memory_tier {
-	struct list_head list;
-	struct device dev;
-	nodemask_t nodelist;
-};
-
 struct demotion_nodes {
 	nodemask_t preferred;
 };
@@ -120,7 +113,7 @@ static void memory_tier_device_release(struct device *dev)
 {
 	struct memory_tier *tier = to_memory_tier(dev);
 
-	kfree(tier);
+	kfree_rcu(tier);
 }
 
 static void insert_memory_tier(struct memory_tier *memtier)
@@ -176,13 +169,18 @@ static void unregister_memory_tier(struct memory_tier *memtier)
 
 static struct memory_tier *__node_get_memory_tier(int node)
 {
-	struct memory_tier *memtier;
+	pg_data_t *pgdat;
 
-	list_for_each_entry(memtier, &memory_tiers, list) {
-		if (node_isset(node, memtier->nodelist))
-			return memtier;
-	}
-	return NULL;
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return NULL;
+	/*
+	 * Since we hold memory_tier_lock, we can avoid
+	 * RCU read locks when accessing the details. No
+	 * parallel updates are possible here.
+	 */
+	return rcu_dereference_check(pgdat->memtier,
+				     lockdep_is_held(&memory_tier_lock));
 }
 
 static struct memory_tier *__get_memory_tier_from_id(int id)
@@ -196,6 +194,33 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
 	return NULL;
 }
 
+/*
+ * Called with memory_tier_lock. Hence the device references cannot
+ * be dropped during this function.
+ */
+static void memtier_node_set(int node, struct memory_tier *memtier)
+{
+	pg_data_t *pgdat;
+	struct memory_tier *current_memtier;
+
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return;
+	/*
+	 * Make sure we mark the memtier NULL before we assign the new memory tier
+	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
+	 * finds a NULL memtier or the one which is still valid.
+	 */
+	current_memtier = rcu_dereference_check(pgdat->memtier,
+						lockdep_is_held(&memory_tier_lock));
+	rcu_assign_pointer(pgdat->memtier, NULL);
+	if (current_memtier)
+		node_clear(node, current_memtier->nodelist);
+	synchronize_rcu();
+	node_set(node, memtier->nodelist);
+	rcu_assign_pointer(pgdat->memtier, memtier);
+}
+
 static int __node_create_and_set_memory_tier(int node, int tier)
 {
 	int ret = 0;
@@ -209,7 +234,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
 			goto out;
 		}
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -231,14 +256,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 	if (current_tier->dev.id == tier)
 		goto out;
 
-	node_clear(node, current_tier->nodelist);
-
 	ret = __node_create_and_set_memory_tier(node, tier);
-	if (ret) {
-		/* reset it back to older tier */
-		node_set(node, current_tier->nodelist);
-		goto out;
-	}
 	if (nodes_empty(current_tier->nodelist))
 		unregister_memory_tier(current_tier);
 
@@ -260,7 +278,7 @@ static int __node_set_memory_tier(int node, int tier)
 		ret = -EINVAL;
 		goto out;
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -316,10 +334,7 @@ int node_update_memory_tier(int node, int tier)
 	if (!current_tier || current_tier->dev.id == tier)
 		goto out;
 
-	node_clear(node, current_tier->nodelist);
-
 	ret = __node_create_and_set_memory_tier(node, tier);
-
 	if (nodes_empty(current_tier->nodelist))
 		unregister_memory_tier(current_tier);
 
@@ -330,6 +345,34 @@ int node_update_memory_tier(int node, int tier)
 	return ret;
 }
 
+/*
+ * lockless access to memory tier of a NUMA node.
+ */
+struct memory_tier *node_get_memory_tier(int node)
+{
+	pg_data_t *pgdat;
+	struct memory_tier *memtier;
+
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return NULL;
+
+	rcu_read_lock();
+	memtier = rcu_dereference(pgdat->memtier);
+	if (!memtier)
+		goto out;
+
+	get_device(&memtier->dev);
+out:
+	rcu_read_unlock();
+	return memtier;
+}
+
+void node_put_memory_tier(struct memory_tier *memtier)
+{
+	put_device(&memtier->dev);
+}
+
 #ifdef CONFIG_MIGRATION
 /**
  * next_demotion_node() - Get the next node in the demotion path
@@ -546,7 +589,7 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
 
 static int __init memory_tier_init(void)
 {
-	int ret;
+	int ret, node;
 	struct memory_tier *memtier;
 
 	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
@@ -567,7 +610,10 @@ static int __init memory_tier_init(void)
 		      __func__, PTR_ERR(memtier));
 
 	/* CPU only nodes are not part of memory tiers. */
-	memtier->nodelist = node_states[N_MEMORY];
+	for_each_node_state(node, N_MEMORY) {
+		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
+		node_set(node, memtier->nodelist);
+	}
 	mutex_unlock(&memory_tier_lock);
 
 	migrate_on_reclaim_init();
-- 
2.36.1

