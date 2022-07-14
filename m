Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E607C574418
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiGNFAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbiGNE7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:59:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268A10E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:55:22 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E4ofkD004046;
        Thu, 14 Jul 2022 04:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=PaVBmRBx3ekTLglmbSEQ37GP/EmSrFFjktnbeHWmIDk=;
 b=TOXP+SBNEN49UkD4SUm89CK9a+hR0tqDGDRz4Q1XMKXrm3pKDRqQKE3WpW0K1m/5VnQ4
 ktlKVZTIf/SqMnRbs6jZUbPH15+WiHz8xNKEOmv/4mR5SqYztT7mhzOdfkbYsdqjAre8
 weDks1Qcf3GN5bBhxSeVcWvCZIfUMrgovtzch+difP8Xlqy4t5Q7rsiGHL9fDZdCynF7
 0QNIXYsyd2Gb6QjNR+AZ++bL8iNs9xtxXkCAZd+CbfQlsT4s5kv0P7+nRJoj/UyypKZE
 BanjfIHl7y7+7XYrB84GzMnGo+IshZjyWjGg/b3vK1TvINnrtjdzVuYcMPwresA5jHBO kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hacfng1q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:55:09 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26E4q55f007438;
        Thu, 14 Jul 2022 04:55:08 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hacfng1pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:55:08 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26E4qm7q013516;
        Thu, 14 Jul 2022 04:55:07 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 3ha4qxtu8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:55:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26E4t55K20054352
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:55:05 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69D517805C;
        Thu, 14 Jul 2022 04:55:05 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90AAA7805E;
        Thu, 14 Jul 2022 04:54:58 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.119.34])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 04:54:58 +0000 (GMT)
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
Subject: [PATCH v9 6/8] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Thu, 14 Jul 2022 10:23:49 +0530
Message-Id: <20220714045351.434957-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -Kuz_O6lUhAAVkXRfOuEcYgvWbprOZxK
X-Proofpoint-GUID: oSHUyDQJwqtDGTIKAT-BYKjlQPsuikLj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_02,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140019
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
 include/linux/mmzone.h |  3 ++
 mm/memory-tiers.c      | 64 +++++++++++++++++++++++++++++++-----------
 2 files changed, 50 insertions(+), 17 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index aab70355d64f..353812495a70 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -928,6 +928,9 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+#ifdef CONFIG_NUMA
+	struct memory_tier __rcu *memtier;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index e951f54ce56c..bab4700bf58d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -7,6 +7,7 @@
 #include <linux/moduleparam.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/rcupdate.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -124,18 +125,23 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
 static void unregister_memory_tier(struct memory_tier *memtier)
 {
 	list_del(&memtier->list);
-	kfree(memtier);
+	kfree_rcu(memtier);
 }
 
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
@@ -149,6 +155,33 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
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
@@ -162,7 +195,7 @@ static int __node_create_and_set_memory_tier(int node, int tier)
 			goto out;
 		}
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -184,14 +217,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 	if (current_tier->id == tier)
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
 
@@ -213,7 +239,7 @@ static int __node_set_memory_tier(int node, int tier)
 		ret = -EINVAL;
 		goto out;
 	}
-	node_set(node, memtier->nodelist);
+	memtier_node_set(node, memtier);
 out:
 	return ret;
 }
@@ -428,6 +454,7 @@ static void __init migrate_on_reclaim_init(void)
 
 static int __init memory_tier_init(void)
 {
+	int node;
 	struct memory_tier *memtier;
 
 	/*
@@ -444,7 +471,10 @@ static int __init memory_tier_init(void)
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

