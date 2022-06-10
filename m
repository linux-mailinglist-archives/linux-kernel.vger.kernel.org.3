Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2ED5467CE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349403AbiFJNzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349350AbiFJNy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EC5BD24
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:54:35 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADoGpJ016533;
        Fri, 10 Jun 2022 13:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Kd0wMNzxttpCi5E/zfEkRFMTVjdfKDndNDT6ciUBrfI=;
 b=S5s/+eH864Oejunle40mFuQNcJCf/kdZp2UTc7RnuzdxKD2l76iqQvMLk9nsPX4ie8ab
 Fj5DE3hvRh+iw6IRqg2Sb5QVJrIvq+O9eRpC0WpGsbn3menuxy/PtQdfESJXIFbuIaet
 Ko1GfMBQChBmY/hEJJB7haNCgDNRmLT+oxqL+augQlRxvkarsaGLuPQdBA+wpmITqs2A
 hYwocUCx8njCHvcmq3MeAjn70WQDPjdamEWXkS5nLBM4WQ0guezBFnzckUj3VydMm7Pl
 t1KJT3ugnZARgl9QV9AZ0NWglWaz2uHKN970Q+jWjlKEN1iK4vlwB37wsoZKi1jW24qS bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gjd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:14 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADoiOI021768;
        Fri, 10 Jun 2022 13:54:13 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6q9gjcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:13 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADaauJ016202;
        Fri, 10 Jun 2022 13:54:13 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3gfy1a900u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:12 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADsBHE28508624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:54:12 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDBA86A054;
        Fri, 10 Jun 2022 13:54:11 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A7646A047;
        Fri, 10 Jun 2022 13:54:03 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:54:02 +0000 (GMT)
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
Subject: [PATCH v6 09/13] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Fri, 10 Jun 2022 19:22:25 +0530
Message-Id: <20220610135229.182859-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pp6MvJVh_iMGCNUYlGb2QF7EzkPXNxmh
X-Proofpoint-GUID: eXBoSX6qARFNOI30Yq99TzeI299l3-Vm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also update different helpes to use NODE_DATA()->memtier. Since
node specific memtier can change based on the reassignment of
NUMA node to a different memory tiers, accessing NODE_DATA()->memtier
needs to under an rcu read lock of memory_tier_lock.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  14 +++++
 include/linux/mmzone.h       |   3 ++
 mm/memory-tiers.c            | 102 ++++++++++++++++++++++++++---------
 3 files changed, 94 insertions(+), 25 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 52896f5970b7..53f3e4c7cba8 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -6,6 +6,9 @@
 
 #ifdef CONFIG_TIERED_MEMORY
 
+#include <linux/device.h>
+#include <linux/nodemask.h>
+
 #define MEMORY_TIER_HBM_GPU	0
 #define MEMORY_TIER_DRAM	1
 #define MEMORY_TIER_PMEM	2
@@ -18,13 +21,24 @@
 #define MAX_STATIC_MEMORY_TIERS  3
 #define MAX_MEMORY_TIERS  (MAX_STATIC_MEMORY_TIERS + 2)
 
+struct memory_tier {
+	struct list_head list;
+	struct device dev;
+	nodemask_t nodelist;
+	int rank;
+};
+
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
 int next_demotion_node(int node);
 int node_set_memory_tier(int node, int tier);
 int node_get_memory_tier_id(int node);
 int node_reset_memory_tier(int node, int tier);
+struct memory_tier *node_get_memory_tier(int node);
+void node_put_memory_tier(struct memory_tier *memtier);
+
 #else
+
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
 {
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..c4fcfd2b9980 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -928,6 +928,9 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+#ifdef CONFIG_TIERED_MEMORY
+	struct memory_tier *memtier;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index de3b7403ae6f..429aa864edb0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,22 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
-#include <linux/device.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/memory-tiers.h>
 #include <linux/random.h>
 #include <linux/memory.h>
 #include <linux/idr.h>
+#include <linux/rcupdate.h>
 
 #include "internal.h"
 
-struct memory_tier {
-	struct list_head list;
-	struct device dev;
-	nodemask_t nodelist;
-	int rank;
-};
-
 struct demotion_nodes {
 	nodemask_t preferred;
 };
@@ -212,13 +204,17 @@ static void unregister_memory_tier(struct memory_tier *memtier)
 
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
+	return pgdat->memtier;
 }
 
 static struct memory_tier *__get_memory_tier_from_id(int id)
@@ -232,6 +228,32 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
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
+	current_memtier = rcu_dereference(pgdat->memtier);
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
@@ -252,7 +274,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
 			goto out;
 		}
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -274,12 +296,10 @@ int node_create_and_set_memory_tier(int node, int tier)
 	if (current_tier->dev.id == tier)
 		goto out;
 
-	node_clear(node, current_tier->nodelist);
-
 	ret = __node_create_and_set_memory_tier(node, tier);
 	if (ret) {
 		/* reset it back to older tier */
-		node_set(node, current_tier->nodelist);
+		memtier_node_set(node, current_tier);
 		goto out;
 	}
 
@@ -304,7 +324,7 @@ static int __node_set_memory_tier(int node, int tier)
 		ret = -EINVAL;
 		goto out;
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -360,12 +380,10 @@ int node_reset_memory_tier(int node, int tier)
 	if (!current_tier || current_tier->dev.id == tier)
 		goto out;
 
-	node_clear(node, current_tier->nodelist);
-
 	ret = __node_set_memory_tier(node, tier);
 	if (ret) {
 		/* reset it back to older tier */
-		node_set(node, current_tier->nodelist);
+		memtier_node_set(node, current_tier);
 		goto out;
 	}
 
@@ -379,6 +397,34 @@ int node_reset_memory_tier(int node, int tier)
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
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
@@ -641,7 +687,7 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
 
 static int __init memory_tier_init(void)
 {
-	int ret;
+	int ret, node;
 	struct memory_tier *memtier;
 
 	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
@@ -660,7 +706,13 @@ static int __init memory_tier_init(void)
 		      __func__, PTR_ERR(memtier));
 
 	/* CPU only nodes are not part of memory tiers. */
-	memtier->nodelist = node_states[N_MEMORY];
+	for_each_node_state(node, N_MEMORY) {
+		/*
+		 * Should be safe to do this early in the boot.
+		 */
+		NODE_DATA(node)->memtier = memtier;
+		node_set(node, memtier->nodelist);
+	}
 	migrate_on_reclaim_init();
 
 	return 0;
-- 
2.36.1

