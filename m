Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F94590BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbiHLF6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbiHLF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:58:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38922A50D7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:58:27 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5lBKh000673;
        Fri, 12 Aug 2022 05:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yCKqTfh5fUF02yRp6rqjGhYyJCjq5J5SuJ5FIqJ2xVU=;
 b=X59wFeOhFkBGObJWxUagxl4v0xgHLSplRN3iXl6/3WxD05TELYdOgNdggANACJ/XAhIG
 YpzPohEywYqMwvttxj1ea48YMXlyEELH39LIugAHq+J5O9fZIT3jtiwHaVgKUpHghOS4
 pSvwugziYebpQXdYnIw8zHYB31AsQIbHXXTLi3Yvqp5gjywb1nnBObUHQgTLIlfWqYfg
 PubDso07dPnPDi5GobX1FMgd3a03/8UdXUu4uwYD2uFKzi5dkfSC8HE1/CWS9XxOxFD9
 sq+KqOqM3JhhAa0k55TMh0LdI10kIIyTAn6jfiKf7E23Q2OH0eNGszOt8UaonEKzHPt0 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh1787a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5mQcv004183;
        Fri, 12 Aug 2022 05:58:02 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh17879b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:02 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5adob012235;
        Fri, 12 Aug 2022 05:58:01 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma03wdc.us.ibm.com with ESMTP id 3huww6fcuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5w0qK11993754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:58:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344467805C;
        Fri, 12 Aug 2022 05:58:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B9BD778060;
        Fri, 12 Aug 2022 05:57:54 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:57:54 +0000 (GMT)
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
Subject: [PATCH v14 06/10] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Fri, 12 Aug 2022 11:27:05 +0530
Message-Id: <20220812055710.357820-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9TkL8M-VImBBROV9hG9MfC5KLRZCRdGD
X-Proofpoint-ORIG-GUID: w2wZ-S437vUYEYge-KO-5YK6XAvcrmUk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120015
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
index 41a0bc06d169..315b9fe14c48 100644
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
2.37.1

