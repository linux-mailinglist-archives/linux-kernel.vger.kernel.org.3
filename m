Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911A5983DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244737AbiHRNNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244548AbiHRNMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:12:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC69B2493
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:12:47 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ID0jUx004836;
        Thu, 18 Aug 2022 13:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SgB1OBJ+aT4fKrCirlggMMGrMcGU1lu023bf/o8Sw4M=;
 b=Wlv78d4F+GU0V4YStCFHd5GtSHDiHSgU8ovslbjVH7A6swQTUkOfQLAXqDVylDzP7gfN
 W6yM/gGjBYoMmR1lNBkMs4e6LDwMay+CY7a0koX+x8T6uzRdvSgKdnFl41pD3bxTm7Xe
 /RIFZLwV02L2aOFPdUn2QBua3ElmahtYhM3OTIifT5d4N60WHB7vPCN61OLInJBzM0Cq
 K+WrO4ppXhlw3US8FDSwpffKX6m37kZgQTd5por4EvnI/rnPntwXV2YIhdT8RxKoV4nX
 UARoawmgwlthWy5VreaxP9ZTi6QgBtdhshnVpTDvNf1pTpnuOhigat7Npw/B6S8XkCkO Ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1nxerf3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:35 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ID1DvF006707;
        Thu, 18 Aug 2022 13:11:34 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1nxerf2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:33 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID5dD3002954;
        Thu, 18 Aug 2022 13:11:32 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03dal.us.ibm.com with ESMTP id 3hx3kaehtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:32 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDBVIV1311356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:11:32 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DCED5124053;
        Thu, 18 Aug 2022 13:11:31 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DAA8F124052;
        Thu, 18 Aug 2022 13:11:26 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.111.107])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:11:26 +0000 (GMT)
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
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v15 06/10] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Thu, 18 Aug 2022 18:40:38 +0530
Message-Id: <20220818131042.113280-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: v9nEluJdfDt2HY6hBTW5UjrvGDtDlk4J
X-Proofpoint-ORIG-GUID: iRErj2z7V2Pqzx7rEKjNCSlj6_HoxJMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180045
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

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/mmzone.h |  3 +++
 mm/memory-tiers.c      | 40 +++++++++++++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index e24b40c52468..7d78133fe8dd 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1012,6 +1012,9 @@ typedef struct pglist_data {
 	/* Per-node vmstats */
 	struct per_cpu_nodestat __percpu *per_cpu_nodestats;
 	atomic_long_t		vm_stat[NR_VM_NODE_STAT_ITEMS];
+#ifdef CONFIG_NUMA
+	struct memory_tier __rcu *memtier;
+#endif
 } pg_data_t;
 
 #define node_present_pages(nid)	(NODE_DATA(nid)->node_present_pages)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c29bb24449b8..2b7e91b45a75 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -4,6 +4,7 @@
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
 #include <linux/memory.h>
+#include <linux/mmzone.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -136,12 +137,18 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 static struct memory_tier *__node_get_memory_tier(int node)
 {
-	struct memory_dev_type *memtype;
+	pg_data_t *pgdat;
 
-	memtype = node_memory_types[node];
-	if (memtype && node_isset(node, memtype->nodes))
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
@@ -294,6 +301,8 @@ static struct memory_tier *set_node_memory_tier(int node)
 {
 	struct memory_tier *memtier;
 	struct memory_dev_type *memtype;
+	pg_data_t *pgdat = NODE_DATA(node);
+
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
@@ -305,24 +314,45 @@ static struct memory_tier *set_node_memory_tier(int node)
 	memtype = node_memory_types[node];
 	node_set(node, memtype->nodes);
 	memtier = find_create_memory_tier(memtype);
+	if (!IS_ERR(memtier))
+		rcu_assign_pointer(pgdat->memtier, memtier);
 	return memtier;
 }
 
 static void destroy_memory_tier(struct memory_tier *memtier)
 {
 	list_del(&memtier->list);
+	/*
+	 * synchronize_rcu in clear_node_memory_tier makes sure
+	 * we don't have rcu access to this memory tier.
+	 */
 	kfree(memtier);
 }
 
 static bool clear_node_memory_tier(int node)
 {
 	bool cleared = false;
+	pg_data_t *pgdat;
 	struct memory_tier *memtier;
 
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return false;
+
+	/*
+	 * Make sure that anybody looking at NODE_DATA who finds
+	 * a valid memtier finds memory_dev_types with nodes still
+	 * linked to the memtier. We achieve this by waiting for
+	 * rcu read section to finish using synchronize_rcu.
+	 * This also enables us to free the destroyed memory tier
+	 * with kfree instead of kfree_rcu
+	 */
 	memtier = __node_get_memory_tier(node);
 	if (memtier) {
 		struct memory_dev_type *memtype;
 
+		rcu_assign_pointer(pgdat->memtier, NULL);
+		synchronize_rcu();
 		memtype = node_memory_types[node];
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
-- 
2.37.2

