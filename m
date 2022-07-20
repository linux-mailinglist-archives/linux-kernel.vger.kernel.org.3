Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AC757AE39
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbiGTDBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241044AbiGTDAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C73F329
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:43 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2mnxv001933;
        Wed, 20 Jul 2022 03:00:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FuOtZSr8KoRXEeUwczPYyLcJHjQ8n/U557lGv6Ad/2Q=;
 b=W/vxl+ACQsvxPzBgNKwXK3E5ho758I/NGk4lxYi9Ufhv6txl1x/1m/VFzOoCBblMtU8c
 wb4cahuugNpnwNBcUgbHmxqMs9WZ1gHP+k5o8Ej/26E7XDeBq4vCQm4tdjOb9etjCVd2
 wdrJQx+/EeRgjmTrDcSf/uwVp6qsSD1fekIgUx+9gXIcMcHthTfY5t9UizG+fYbFXRW6
 jB/5wQ60EKzUtLdnxMJMflXIrt501E2QjNw+YKZ9KT19T1WfuBEV87Ym9New2UwU+2tY
 i04IZWtYa/bIQwcp02MwzsMovBjx/5l5n39c4tkQ/s1cf/2jCr9vH8sGfWNdKfgyCiHU vA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he98kr7jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:27 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K2uOQL003467;
        Wed, 20 Jul 2022 03:00:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he98kr7hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K2pQFR015586;
        Wed, 20 Jul 2022 03:00:25 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3hbmy9ctas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:25 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K30Okb38470138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:00:24 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B006136061;
        Wed, 20 Jul 2022 03:00:24 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F201113605D;
        Wed, 20 Jul 2022 03:00:18 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.15.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 03:00:18 +0000 (GMT)
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
Subject: [PATCH v10 6/8] mm/demotion: Add pg_data_t member to track node memory tier details
Date:   Wed, 20 Jul 2022 08:29:18 +0530
Message-Id: <20220720025920.1373558-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mnoErwtpBcVIvJixFDrbKn0hgAgvvcYR
X-Proofpoint-ORIG-GUID: sWCGTEv4EguCla7l9lLVxz9zEQdkDjDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
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
 include/linux/mmzone.h |  3 ++
 mm/memory-tiers.c      | 65 +++++++++++++++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 11 deletions(-)

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
index a8cfe2ca3903..4715f9b96a44 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -138,13 +138,18 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
 
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
 
 #ifdef CONFIG_MIGRATION
@@ -277,6 +282,29 @@ static inline void disable_all_migrate_targets(void) {}
 static inline void establish_migration_targets(void) {}
 #endif /* CONFIG_MIGRATION */
 
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
+	synchronize_rcu();
+	if (current_memtier)
+		node_clear(node, current_memtier->nodelist);
+	node_set(node, memtier->nodelist);
+	rcu_assign_pointer(pgdat->memtier, memtier);
+}
+
 static void init_node_memory_tier(int node)
 {
 	int perf_level;
@@ -295,7 +323,7 @@ static void init_node_memory_tier(int node)
 	if (!memtier) {
 		perf_level = node_devices[node]->perf_level;
 		memtier = find_create_memory_tier(perf_level);
-		node_set(node, memtier->nodelist);
+		memtier_node_set(node, memtier);
 	}
 	establish_migration_targets();
 	mutex_unlock(&memory_tier_lock);
@@ -303,12 +331,25 @@ static void init_node_memory_tier(int node)
 
 static void clear_node_memory_tier(int node)
 {
-	struct memory_tier *memtier;
+	pg_data_t *pgdat;
+	struct memory_tier *current_memtier;
+
+	pgdat = NODE_DATA(node);
+	if (!pgdat)
+		return;
 
 	mutex_lock(&memory_tier_lock);
-	memtier = __node_get_memory_tier(node);
-	if (memtier) {
-		node_clear(node, memtier->nodelist);
+	/*
+	 * Make sure we mark the memtier NULL before we assign the new memory tier
+	 * to the NUMA node. This make sure that anybody looking at NODE_DATA
+	 * finds a NULL memtier or the one which is still valid.
+	 */
+	current_memtier = rcu_dereference_check(pgdat->memtier,
+						lockdep_is_held(&memory_tier_lock));
+	rcu_assign_pointer(pgdat->memtier, NULL);
+	synchronize_rcu();
+	if (current_memtier) {
+		node_clear(node, current_memtier->nodelist);
 		establish_migration_targets();
 	}
 	mutex_unlock(&memory_tier_lock);
@@ -383,6 +424,8 @@ static int __init memory_tier_init(void)
 
 		if (!node_property->perf_level)
 			node_property->perf_level = default_memtier_perf_level;
+
+		rcu_assign_pointer(NODE_DATA(node)->memtier, memtier);
 	}
 	mutex_unlock(&memory_tier_lock);
 
-- 
2.36.1

