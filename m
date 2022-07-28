Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3414584644
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbiG1TGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbiG1TGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:06:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5917646F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:06:40 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIliAL018459;
        Thu, 28 Jul 2022 19:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zzhE+RvouT8p2JfoZVaQmykIDMKRiQC78ntSkjMqxsc=;
 b=sI6fGeGkLdmjQmizPk7HnBqGvCD7T7ljMlv+QTdMDHCQpdjAh0EE/IWkArg8Gt/9aJ+R
 k+EYgV6R5qPCDANy0ntH3as+YGI6OITBw4KzNSDzIYr6MyvAxYDaTOW1LhkLJf5lJwVS
 wFdIBSs2AB068NUbwUKiwKyHxUPt7UE5+DkQU5mH/q/ukOba8ulLtw2UtRT8abkn/99i
 kFMI0nV2/zRJIqthJg2CvCpx6Ve81Qq8MvCY0bgjux6lXYft9l60wlNBGtBIvcooOdP5
 7u2viAMXLu7FtCnT/sHLkGLPuhgpaPfc9d+VrSQXfS5dTFDwgGJkl8zlQgeFLhD2EhlU Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238tyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:06:28 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SIlm0W018645;
        Thu, 28 Jul 2022 19:05:51 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238ssh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:51 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ1rB9003472;
        Thu, 28 Jul 2022 19:05:33 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3hg9791g6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:33 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ5WKt32768494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:32 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8186A04D;
        Thu, 28 Jul 2022 19:05:32 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE7FB6A047;
        Thu, 28 Jul 2022 19:05:26 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:05:26 +0000 (GMT)
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
Subject: [PATCH v11 6/8] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Fri, 29 Jul 2022 00:34:34 +0530
Message-Id: <20220728190436.858458-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6-ABJ5C95z-5uZN1ltf0ItmuyL_8y0-r
X-Proofpoint-ORIG-GUID: BIVOSYjHFr3bfuYsWQRk-dAMeORsPqiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/mmzone.h |  3 +++
 mm/memory-tiers.c      | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

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
index 60845aa74afc..f982ca6b3559 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -3,6 +3,7 @@
 #include <linux/lockdep.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/mmzone.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -142,12 +143,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 static struct memory_tier *__node_get_memory_tier(int node)
 {
-	struct memory_dev_type *memtype;
+	pg_data_t *pgdat;
 
-	memtype = node_memory_types[node];
-	if (memtype)
-		return memtype->memtier;
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
 
 #ifdef CONFIG_MIGRATION
@@ -290,6 +297,7 @@ static inline void establish_demotion_targets(void) {}
 
 static void init_node_memory_tier(int node)
 {
+	pg_data_t *pgdat = NODE_DATA(node);
 	struct memory_tier *memtier;
 
 	mutex_lock(&memory_tier_lock);
@@ -311,8 +319,12 @@ static void init_node_memory_tier(int node)
 		}
 		memtype = node_memory_types[node];
 		memtier = find_create_memory_tier(memtype);
+		if (IS_ERR(memtier))
+			goto err_out;
+		rcu_assign_pointer(pgdat->memtier, memtier);
 	}
 	establish_demotion_targets();
+err_out:
 	mutex_unlock(&memory_tier_lock);
 }
 
@@ -324,13 +336,26 @@ static void destroy_memory_tier(struct memory_tier *memtier)
 
 static void clear_node_memory_tier(int node)
 {
+	pg_data_t *pgdat;
 	struct memory_tier *current_memtier;
 
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return;
+
 	mutex_lock(&memory_tier_lock);
+	/*
+	 * Make sure that anybody looking at NODE_DATA who finds
+	 * a valid memtier finds memory_dev_types with nodes still
+	 * linked to the memtier. We achieve this by waiting for
+	 * rcu read section to finish using synchronize_rcu.
+	 */
 	current_memtier = __node_get_memory_tier(node);
 	if (current_memtier) {
 		struct memory_dev_type *memtype;
 
+		rcu_assign_pointer(pgdat->memtier, NULL);
+		synchronize_rcu();
 		memtype = node_memory_types[node];
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
@@ -386,6 +411,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 
 static int __init memory_tier_init(void)
 {
+	int node;
 	struct memory_tier *memtier;
 
 	mutex_lock(&memory_tier_lock);
@@ -396,6 +422,10 @@ static int __init memory_tier_init(void)
 	if (IS_ERR(memtier))
 		panic("%s() failed to register memory tier: %ld\n",
 		      __func__, PTR_ERR(memtier));
+
+	for_each_node_state(node, N_MEMORY)
+		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
+
 	mutex_unlock(&memory_tier_lock);
 #ifdef CONFIG_MIGRATION
 	node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
-- 
2.37.1

