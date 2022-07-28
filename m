Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF38A584653
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbiG1TGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiG1TGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:06:21 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B715176970
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:06:20 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIlmNv018629;
        Thu, 28 Jul 2022 19:06:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=donn9f9OyDlvKkxd3kbeRn/TBljkOOfnH5TovPnfwlU=;
 b=Biz6XjWRMlzVT+5hy1MPkRbbmmK0LpR2iqgRHB6PE1aVse1xoAjMgQlBAQwRGnUCbm8u
 lgIzQf5oMLBduONPfDm2Ek0QeDYwd2qi7MufTmV6L90DMAAgi3VYFfqt7mNHwedTgfem
 Hd1kqa7ByUFMF40Kyr8RVU1ZR/5zCddhxHH5Pcv3zHhOeHq6BX9jkJ4QZ7BTcoUmytKl
 aaVbC4g0E77esld1DAsfVcysqa8hRe6i7aIEX20fnnrLEl8bLGef3WVmGowK8rHx3Dsk
 zqOB2VYk75C8jQd7CWMJ88yDTe3Qc1pFGIRDwK8QIrDH7UJYJz3Ce1Q/UPKAJAkeOOFX VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238suv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:06:06 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SIpDKe029798;
        Thu, 28 Jul 2022 19:05:34 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238s15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:34 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ5HZd003793;
        Thu, 28 Jul 2022 19:05:21 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 3hg98shehf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:20 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ5JQV34931180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:19 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3C8F6A047;
        Thu, 28 Jul 2022 19:05:19 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D53B6A04D;
        Thu, 28 Jul 2022 19:05:14 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:05:13 +0000 (GMT)
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
Subject: [PATCH v11 4/8] mm/demotion/dax/kmem: Set node's abstract distance to MEMTIER_ADISTANCE_PMEM
Date:   Fri, 29 Jul 2022 00:34:32 +0530
Message-Id: <20220728190436.858458-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bfrT-tiO2ZblNXq2-UMQiu6skOp8YqYG
X-Proofpoint-ORIG-GUID: Ypt4IbU8PiVovesu1XT-nRNVpzAaJ7hM
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

By default, all nodes are assigned to the default memory tier which
is the memory tier designated for nodes with DRAM

Set dax kmem device node's tier to slower memory tier by assigning
abstract distance to MEMTIER_ADISTANCE_PMEM. PMEM tier
appears below the default memory tier in demotion order.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c           |  9 +++++++++
 include/linux/memory-tiers.h | 19 ++++++++++++++++++-
 mm/memory-tiers.c            | 28 ++++++++++++++++------------
 3 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..6b0d5de9a3e9 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory-tiers.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -41,6 +42,12 @@ struct dax_kmem_data {
 	struct resource *res[];
 };
 
+static struct memory_dev_type default_pmem_type  = {
+	.adistance = MEMTIER_ADISTANCE_PMEM,
+	.tier_sibiling = LIST_HEAD_INIT(default_pmem_type.tier_sibiling),
+	.nodes  = NODE_MASK_NONE,
+};
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -62,6 +69,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	init_node_memory_type(numa_node, &default_pmem_type);
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 976f43a5e3be..4f4baf0bf430 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MEMORY_TIERS_H
 #define _LINUX_MEMORY_TIERS_H
 
+#include <linux/types.h>
+#include <linux/nodemask.h>
 /*
  * Each tier cover a abstrace distance chunk size of 128
  */
@@ -15,12 +17,27 @@
 #define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
 #define MEMTIER_HOTPLUG_PRIO	100
 
+struct memory_tier;
+struct memory_dev_type {
+	/* list of memory types that are are part of same tier as this type */
+	struct list_head tier_sibiling;
+	/* abstract distance for this specific memory type */
+	int adistance;
+	/* Nodes of same abstract distance */
+	nodemask_t nodes;
+	struct memory_tier *memtier;
+};
+
 #ifdef CONFIG_NUMA
-#include <linux/types.h>
 extern bool numa_demotion_enabled;
+struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type);
 
 #else
 
 #define numa_demotion_enabled	false
+static inline struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c9854a394d9b..109be75fa554 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/memory.h>
@@ -19,16 +17,6 @@ struct memory_tier {
 	int adistance_start;
 };
 
-struct memory_dev_type {
-	/* list of memory types that are are part of same tier as this type */
-	struct list_head tier_sibiling;
-	/* abstract distance for this specific memory type */
-	int adistance;
-	/* Nodes of same abstract distance */
-	nodemask_t nodes;
-	struct memory_tier *memtier;
-};
-
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 struct memory_dev_type *node_memory_types[MAX_NUMNODES];
@@ -141,6 +129,22 @@ static void clear_node_memory_tier(int node)
 	mutex_unlock(&memory_tier_lock);
 }
 
+struct memory_dev_type *init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+	struct memory_dev_type *mem_type;
+
+	mutex_lock(&memory_tier_lock);
+	if (node_memory_types[node]) {
+		mem_type = node_memory_types[node];
+	} else {
+		node_memory_types[node] = default_type;
+		node_set(node, default_type->nodes);
+		mem_type = default_type;
+	}
+	mutex_unlock(&memory_tier_lock);
+	return mem_type;
+}
+
 static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 					      unsigned long action, void *_arg)
 {
-- 
2.37.1

