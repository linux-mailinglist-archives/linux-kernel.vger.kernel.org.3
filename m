Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20983584B80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbiG2GPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiG2GOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:14:38 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014097D1E4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 23:14:36 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26T6Bqr4019746;
        Fri, 29 Jul 2022 06:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=02Eyb4zC1pVNeQEbmkNdkdisYnA/zoMQr6Y9Hk5QTQM=;
 b=rkMvZdQkrL3LUkKzb0BpHoYZIl/bHBMmmYfae/2IG6nJLq30G367boWs+ColH+M1uL6n
 KX6JTWetBbfVzmivX3GLYELNLS1tjlZB6xu/d0rxJeSLjma/gexWpksLXS+PYsoyoJ/a
 rtuwJUI3oyoY4dq/3cSWBjQemE4GRoHxuDaaix9xO7P5dEfzHzNjDuzXjponSo9bMaxS
 dnHpYerrEHb4yq7+kZ/oULKg9cdl6xuk/NWfugOrVgnSzolCgpRNwclO1HAznOvCssaR
 S6A54h3Yh7f2jXABeN8w/Y0e6OW4jup4Q2wVDrc9k1JC6UA41jPgIrf8n5mQ4jBAl9+D zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma2m01yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:22 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26T6Dcet030574;
        Fri, 29 Jul 2022 06:14:21 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hma2m01y0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:21 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26T65oDB026532;
        Fri, 29 Jul 2022 06:14:20 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3hhfpj9dnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Jul 2022 06:14:20 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26T6EJ2p36372880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jul 2022 06:14:19 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63DE07805E;
        Fri, 29 Jul 2022 06:14:19 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C9767805C;
        Fri, 29 Jul 2022 06:14:14 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.86.244])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 29 Jul 2022 06:14:14 +0000 (GMT)
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
Subject: [PATCH v12 4/8] mm/demotion/dax/kmem: Set node's abstract distance to MEMTIER_ADISTANCE_PMEM
Date:   Fri, 29 Jul 2022 11:43:45 +0530
Message-Id: <20220729061349.968148-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
References: <20220729061349.968148-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: S54XRBUG3nolwtZxUGjiDjNOXeUQNSLa
X-Proofpoint-ORIG-GUID: Mxz7pcW5NKGeFFBti6nnZaJmV-zOgp4q
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
index eeb4b045e631..c25f385ff9a8 100644
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
@@ -14,12 +16,27 @@
 #define MEMTIER_ADISTANCE_PMEM	(1 << (MEMTIER_CHUNK_BITS + 3))
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
index 0a7a79cad2a0..0c4394975d1d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
@@ -21,16 +19,6 @@ struct memory_tier {
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
@@ -143,6 +131,22 @@ static void clear_node_memory_tier(int node)
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

