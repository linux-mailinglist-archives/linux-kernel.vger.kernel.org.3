Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6DE584B84
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiG2GPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiG2GO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:14:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EAD7F51C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:14:42 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T6BqrD019746;
        Fri, 29 Jul 2022 06:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JRHjgmnrHFqY1Nptax3/7tOSsdR0bHrzoVmLnN8bMJg=;
 b=NKyCq4i6ksCMhNTypPS5pPBi4LGKVx669czSNF6ks9696ppucNl1TiQM0HbexNjPwFKF
 Z+qu7RWLlFgjZLR1mQ4ZrYpw081U85+PFhbW3YSQ26pJ6IAZ6QavoICqUV21wDpuMDXG
 NP9Ruia6FfQH/syaWpn2laLMgH/ku7Zqut0WkigPQjWRlcLz6XlD7+qLRLmXEcq3xT/N
 RaFf/UdVZ6EjS06a7ccGlBKqYMy6jcsqQHWKabUCP2W1azZ64dY2j/I9sD2btPy6pKVS
 VzPfTyMIyrszsgMPkEvIVqIOH1LYLsCQKaop8vDg1lnmxm+8kI1xRYzRAbOKybfe/TBp hA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma2m028k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:33 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T6C6bB020659;
        Fri, 29 Jul 2022 06:14:32 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma2m027j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:32 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T66WkJ011427;
        Fri, 29 Jul 2022 06:14:31 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b3xy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:31 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6EUNJ40370664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:14:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 566127805C;
        Fri, 29 Jul 2022 06:14:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80C1A78063;
        Fri, 29 Jul 2022 06:14:25 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.86.244])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:14:25 +0000 (GMT)
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
Subject: [PATCH v12 6/8] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Fri, 29 Jul 2022 11:43:47 +0530
Message-Id: <20220729061349.968148-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u1Q9LH7dMkJYm_23WxE3mareEoPfl9Z0
X-Proofpoint-ORIG-GUID: 3pkOxp9uwhlsEN48Vfo97uQE-46XRSRG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207290023
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
 mm/memory-tiers.c      | 39 +++++++++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 6 deletions(-)

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
index 97634337803c..44f6676bc2c8 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/kobject.h>
 #include <linux/memory.h>
 #include <linux/random.h>
+#include <linux/mmzone.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -144,12 +145,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
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
@@ -292,6 +299,7 @@ static inline void establish_demotion_targets(void) {}
 
 static void init_node_memory_tier(int node)
 {
+	pg_data_t *pgdat = NODE_DATA(node);
 	struct memory_tier *memtier;
 
 	mutex_lock(&memory_tier_lock);
@@ -313,8 +321,12 @@ static void init_node_memory_tier(int node)
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
 
@@ -326,13 +338,26 @@ static void destroy_memory_tier(struct memory_tier *memtier)
 
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
@@ -400,8 +425,10 @@ static int __init memory_tier_init(void)
 		panic("%s() failed to register memory tier: %ld\n",
 		      __func__, PTR_ERR(memtier));
 
-	for_each_node_state(node, N_MEMORY)
+	for_each_node_state(node, N_MEMORY) {
 		node_memory_types[node] = &default_dram_type;
+		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
+	}
 
 	mutex_unlock(&memory_tier_lock);
 #ifdef CONFIG_MIGRATION
-- 
2.37.1

