Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B9590BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237085AbiHLF6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237078AbiHLF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:58:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C8BA4B16
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:58:17 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5kiZ2017849;
        Fri, 12 Aug 2022 05:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=e4xek80MAEoZ3xcv9+JTaXI9AFJduVTHtY7Vpz3D/kQ=;
 b=WuCFWxAoQYsk020J7Blkk2AIQTr11RvJ5vL0LmU25DsQiNx0liqd1q+ShZ5p+LLeKJN2
 lzAK0BGDu2JSb7u5q1ymFNsgNjFsIAtsonQSmqhgkKK7wKfrYQN8U/tkhfESEVXi3/zG
 EyAzo3AqP00t9yauDBSlbtYYZb6IqtaxMUrIFdFhHkDJSbw3fID1ybYOewHt9n9tGW5q
 6DgJsycZYZfRLVVwKJPVwPV78awW4zkZyqukK1BHjDidPeom0yOEEPjHmMNGxGYEYhJL
 Raj/3hM32J7HvlUgSuUMZbJtcNy1JLQ+Cgx1UgSwt0pTko+M97PoESgGKJpMuzpG4Oha Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh0rr7a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:49 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5vnDo025340;
        Fri, 12 Aug 2022 05:57:49 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh0rr7a2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:49 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5Zx0h029144;
        Fri, 12 Aug 2022 05:57:48 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma01wdc.us.ibm.com with ESMTP id 3huwvqqf57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:48 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5vlrP52101562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:57:47 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F717805C;
        Fri, 12 Aug 2022 05:57:47 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2F58B7805E;
        Fri, 12 Aug 2022 05:57:42 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:57:41 +0000 (GMT)
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
Subject: [PATCH v14 04/10] mm/demotion/dax/kmem: Set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE
Date:   Fri, 12 Aug 2022 11:27:03 +0530
Message-Id: <20220812055710.357820-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nyrLuR72e4jHmp6XvZkr4LJWXAoRQhmK
X-Proofpoint-ORIG-GUID: GLUJdk83DgjjHh04OLZnEbTFRdVIJSMH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, all nodes are assigned to the default memory tier which
is the memory tier designated for nodes with DRAM

Set dax kmem device node's tier to slower memory tier by assigning
abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE. Low-level drivers
like papr_scm or ACPI NFIT can initialize memory device type to a
more accurate value based on device tree details or HMAT. If the
kernel doesn't find the memory type initialized, a default slower
memory type is assigned by the kmem driver.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c           | 42 +++++++++++++++--
 include/linux/memory-tiers.h | 42 ++++++++++++++++-
 mm/memory-tiers.c            | 91 +++++++++++++++++++++++++++---------
 3 files changed, 149 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..d88814f1c414 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,9 +11,17 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory-tiers.h>
 #include "dax-private.h"
 #include "bus.h"
 
+/*
+ * Default abstract distance assigned to the NUMA node onlined
+ * by DAX/kmem if the low level platform driver didn't initialize
+ * one for this NUMA node.
+ */
+#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 2)
+
 /* Memory resource name used for add_memory_driver_managed(). */
 static const char *kmem_name;
 /* Set if any memory will remain added when the driver will be unloaded. */
@@ -41,6 +49,7 @@ struct dax_kmem_data {
 	struct resource *res[];
 };
 
+static struct memory_dev_type *dax_slowmem_type;
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -79,11 +88,13 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	init_node_memory_type(numa_node, dax_slowmem_type);
+
+	rc = -ENOMEM;
 	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
 	if (!data)
-		return -ENOMEM;
+		goto err_dax_kmem_data;
 
-	rc = -ENOMEM;
 	data->res_name = kstrdup(dev_name(dev), GFP_KERNEL);
 	if (!data->res_name)
 		goto err_res_name;
@@ -155,6 +166,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	kfree(data->res_name);
 err_res_name:
 	kfree(data);
+err_dax_kmem_data:
+	clear_node_memory_type(numa_node, dax_slowmem_type);
 	return rc;
 }
 
@@ -162,6 +175,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	int i, success = 0;
+	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
@@ -198,6 +212,14 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		kfree(data->res_name);
 		kfree(data);
 		dev_set_drvdata(dev, NULL);
+		/*
+		 * Clear the memtype association on successful unplug.
+		 * If not, we have memory blocks left which can be
+		 * offlined/onlined later. We need to keep memory_dev_type
+		 * for that. This implies this reference will be around
+		 * till next reboot.
+		 */
+		clear_node_memory_type(node, dax_slowmem_type);
 	}
 }
 #else
@@ -228,9 +250,22 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
+	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
+	if (IS_ERR(dax_slowmem_type)) {
+		rc = PTR_ERR(dax_slowmem_type);
+		goto err_dax_slowmem_type;
+	}
+
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
-		kfree_const(kmem_name);
+		goto error_dax_driver;
+
+	return rc;
+
+error_dax_driver:
+	destroy_memory_type(dax_slowmem_type);
+err_dax_slowmem_type:
+	kfree_const(kmem_name);
 	return rc;
 }
 
@@ -239,6 +274,7 @@ static void __exit dax_kmem_exit(void)
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
+	destroy_memory_type(dax_slowmem_type);
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index cc89876899a6..0c739508517a 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -2,6 +2,9 @@
 #ifndef _LINUX_MEMORY_TIERS_H
 #define _LINUX_MEMORY_TIERS_H
 
+#include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/kref.h>
 /*
  * Each tier cover a abstrace distance chunk size of 128
  */
@@ -13,12 +16,49 @@
 #define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
 #define MEMTIER_HOTPLUG_PRIO	100
 
+struct memory_tier;
+struct memory_dev_type {
+	/* list of memory types that are part of same tier as this type */
+	struct list_head tier_sibiling;
+	/* abstract distance for this specific memory type */
+	int adistance;
+	/* Nodes of same abstract distance */
+	nodemask_t nodes;
+	struct kref kref;
+	struct memory_tier *memtier;
+};
+
 #ifdef CONFIG_NUMA
-#include <linux/types.h>
 extern bool numa_demotion_enabled;
+struct memory_dev_type *alloc_memory_type(int adistance);
+void destroy_memory_type(struct memory_dev_type *memtype);
+void init_node_memory_type(int node, struct memory_dev_type *default_type);
+void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 
 #else
 
 #define numa_demotion_enabled	false
+/*
+ * CONFIG_NUMA implementation returns non NULL error.
+ */
+static inline struct memory_dev_type *alloc_memory_type(int adistance)
+{
+	return NULL;
+}
+
+static inline void destroy_memory_type(struct memory_dev_type *memtype)
+{
+
+}
+
+static inline void init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+
+}
+
+static inline void clear_node_memory_type(int node, struct memory_dev_type *memtype)
+{
+
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 05f05395468a..e52ccbcb2b27 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
@@ -21,27 +19,10 @@ struct memory_tier {
 	int adistance_start;
 };
 
-struct memory_dev_type {
-	/* list of memory types that are part of same tier as this type */
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
 static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
-/*
- * For now we can have 4 faster memory tiers with smaller adistance
- * than default DRAM tier.
- */
-static struct memory_dev_type default_dram_type  = {
-	.adistance = MEMTIER_ADISTANCE_DRAM,
-	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
-};
+static struct memory_dev_type *default_dram_type;
 
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
@@ -87,6 +68,14 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	return new_memtier;
 }
 
+static inline void __init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+	if (!node_memory_types[node]) {
+		node_memory_types[node] = default_type;
+		kref_get(&default_type->kref);
+	}
+}
+
 static struct memory_tier *set_node_memory_tier(int node)
 {
 	struct memory_tier *memtier;
@@ -97,8 +86,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 	if (!node_state(node, N_MEMORY))
 		return ERR_PTR(-EINVAL);
 
-	if (!node_memory_types[node])
-		node_memory_types[node] = &default_dram_type;
+	__init_node_memory_type(node, default_dram_type);
 
 	memtype = node_memory_types[node];
 	node_set(node, memtype->nodes);
@@ -144,6 +132,57 @@ static bool clear_node_memory_tier(int node)
 	return cleared;
 }
 
+static void release_memtype(struct kref *kref)
+{
+	struct memory_dev_type *memtype;
+
+	memtype = container_of(kref, struct memory_dev_type, kref);
+	kfree(memtype);
+}
+
+struct memory_dev_type *alloc_memory_type(int adistance)
+{
+	struct memory_dev_type *memtype;
+
+	memtype = kmalloc(sizeof(*memtype), GFP_KERNEL);
+	if (!memtype)
+		return ERR_PTR(-ENOMEM);
+
+	memtype->adistance = adistance;
+	INIT_LIST_HEAD(&memtype->tier_sibiling);
+	memtype->nodes  = NODE_MASK_NONE;
+	memtype->memtier = NULL;
+	kref_init(&memtype->kref);
+	return memtype;
+}
+EXPORT_SYMBOL_GPL(alloc_memory_type);
+
+void destroy_memory_type(struct memory_dev_type *memtype)
+{
+	kref_put(&memtype->kref, release_memtype);
+}
+EXPORT_SYMBOL_GPL(destroy_memory_type);
+
+void init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+
+	mutex_lock(&memory_tier_lock);
+	__init_node_memory_type(node, default_type);
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(init_node_memory_type);
+
+void clear_node_memory_type(int node, struct memory_dev_type *memtype)
+{
+	mutex_lock(&memory_tier_lock);
+	if (node_memory_types[node] == memtype) {
+		node_memory_types[node] = NULL;
+		kref_put(&memtype->kref, release_memtype);
+	}
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(clear_node_memory_type);
+
 static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 					      unsigned long action, void *_arg)
 {
@@ -178,6 +217,14 @@ static int __init memory_tier_init(void)
 	struct memory_tier *memtier;
 
 	mutex_lock(&memory_tier_lock);
+	/*
+	 * For now we can have 4 faster memory tiers with smaller adistance
+	 * than default DRAM tier.
+	 */
+	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
+	if (!default_dram_type)
+		panic("%s() failed to allocate default DRAM tier\n", __func__);
+
 	/*
 	 * Look at all the existing N_MEMORY nodes and add them to
 	 * default memory tier or to a tier if we already have memory
-- 
2.37.1

