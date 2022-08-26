Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3995A2563
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbiHZKFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245166AbiHZKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:05:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE05DABB5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:04:20 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q9ssqN015394;
        Fri, 26 Aug 2022 10:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=qtGOveAZGHqntea80eUXt48fNigwR9RxX3Zy07zwieI=;
 b=e/md9rTTap3868LvPoYs4WFodRJTJJq4RoXUByhqUSFFx7sHwswjeTakaAUB1Veb3Ipz
 +BEZpVLJMBkeBRRBX8nYmyYRq+tPzQWf6MIiyvTmxFflv+x8peEsZ9t2gYOP/R2RgR/2
 aq1ose/NF1gVTeCyFWsRbf4NIMKAb8tDsGGjokLPTLrufb5uplhLB4GLbW+cZZafvGFo
 /i+DRcYsqXxJmAcxHKPwwncmIH3892aiaWqkU9IQ4rdCqPCSPHLlrUhYIDQ/PZtJkYlv
 2vGAPbA2Qu1HkqDdCM8REpZn4xlrPL4rJv2ZBs71Lomf1YrlK7cRg94Sw2a78XcpAtjA hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6uyag8g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 10:02:43 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27Q9u53O024298;
        Fri, 26 Aug 2022 10:02:43 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j6uyag8f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 10:02:43 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27Q9nuKV007490;
        Fri, 26 Aug 2022 10:02:41 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3j2q8add0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 10:02:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27QA2fF744040670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 10:02:41 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16152AE060;
        Fri, 26 Aug 2022 10:02:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2ADEBAE05C;
        Fri, 26 Aug 2022 10:02:35 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.10.139])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 26 Aug 2022 10:02:34 +0000 (GMT)
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
Subject: [PATCH mm-unstable] mm/demotion: Assign correct memory type for multiple dax devices with the same node affinity
Date:   Fri, 26 Aug 2022 15:32:24 +0530
Message-Id: <20220826100224.542312-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: beGUxM7NooPWd3VMHfktpWJsfFRRDf7v
X-Proofpoint-ORIG-GUID: OAWi3D-VOM8w0nUHJFXiIc5l81NUCMUC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With multiple dax devices having the same node affinity, the kernel wrongly assigned
default_dram memory type to some devices after the memory hotplug operation. Fix this by
not clearing node_memory_types on the dax device remove.

The current kernel cleared node_memory_type on successful removal of a dax device.
But then we can have multiple dax devices with the same node affinity. Clearing the
node_memory_type results in assigning other dax devices to the default dram type when
we bring them online.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index ba844fe9cc8c..c4bd6d052a33 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -27,9 +27,14 @@ struct demotion_nodes {
 	nodemask_t preferred;
 };
 
+struct node_memory_type_map {
+	struct memory_dev_type *memtype;
+	int map_count;
+};
+
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
-static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
+static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 static struct memory_dev_type *default_dram_type;
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
@@ -386,9 +391,19 @@ static inline void establish_demotion_targets(void) {}
 
 static inline void __init_node_memory_type(int node, struct memory_dev_type *memtype)
 {
-	if (!node_memory_types[node]) {
-		node_memory_types[node] = memtype;
-		kref_get(&memtype->kref);
+	if (!node_memory_types[node].memtype)
+		node_memory_types[node].memtype = memtype;
+	/*
+	 * for each device getting added in the same NUMA node
+	 * with this specific memtype, bump the map count. We
+	 * Only take memtype device reference once, so that
+	 * changing a node memtype can be done by droping the
+	 * only reference count taken here.
+	 */
+
+	if (node_memory_types[node].memtype == memtype) {
+		if (!node_memory_types[node].map_count++)
+			kref_get(&memtype->kref);
 	}
 }
 
@@ -406,7 +421,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 
 	__init_node_memory_type(node, default_dram_type);
 
-	memtype = node_memory_types[node];
+	memtype = node_memory_types[node].memtype;
 	node_set(node, memtype->nodes);
 	memtier = find_create_memory_tier(memtype);
 	if (!IS_ERR(memtier))
@@ -448,7 +463,7 @@ static bool clear_node_memory_tier(int node)
 
 		rcu_assign_pointer(pgdat->memtier, NULL);
 		synchronize_rcu();
-		memtype = node_memory_types[node];
+		memtype = node_memory_types[node].memtype;
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
 			list_del_init(&memtype->tier_sibiling);
@@ -502,8 +517,14 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 {
 	mutex_lock(&memory_tier_lock);
-	if (node_memory_types[node] == memtype) {
-		node_memory_types[node] = NULL;
+	if (node_memory_types[node].memtype == memtype)
+		node_memory_types[node].map_count--;
+	/*
+	 * If we umapped all the attached devices to this node,
+	 * clear the node memory type.
+	 */
+	if (!node_memory_types[node].map_count) {
+		node_memory_types[node].memtype = NULL;
 		kref_put(&memtype->kref, release_memtype);
 	}
 	mutex_unlock(&memory_tier_lock);
-- 
2.37.2

