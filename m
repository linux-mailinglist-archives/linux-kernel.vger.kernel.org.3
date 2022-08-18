Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222C5983E2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbiHRNOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiHRNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:14:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD4E642FE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:13:49 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ICBt1L006499;
        Thu, 18 Aug 2022 13:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fH58GLDZU2WeWZkq6YRNl4Y4y3kC8OPowjQaO6LlzkQ=;
 b=WQ+ZIBTvV0WhbFWV9a78P5fhvKR6zhQive+THRr8Ng+2DAyyV5ij0QMOoH1aYuh31IP7
 5a/KtLdfWs7zzaZNycQM2IH4lhHW/n9+Xf5HLVhffHHufYK0pKkTrOmcYhq92+FbfjQB
 8l07yzC25XpV0LYiIL7TbVmaG0OxVvEZEsOzv0WTMIWUG1PHnCitf2xUT6hjty45qTmg
 ceQWjfAppksCIhCaC7E42HxzfRkhdaZvqfgPezI1KquB385iAxTfQF25JTBqoROP0Yz1
 hW6Ozi8Mq/+kCw66TGv8thhgNW7K10tIc/Bi3gYeBIL9gh2V/KlQudQAqVZOpTPsvwgh +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1n7cj58u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:23 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ICCCPg006971;
        Thu, 18 Aug 2022 13:11:22 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1n7cj57k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID5VHc002393;
        Thu, 18 Aug 2022 13:11:21 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 3hx3kaexyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:21 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDBK3u3211938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:11:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CDD5124052;
        Thu, 18 Aug 2022 13:11:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C67A124053;
        Thu, 18 Aug 2022 13:11:15 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.111.107])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:11:15 +0000 (GMT)
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
Subject: [PATCH v15 04/10] mm/demotion/dax/kmem: Set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE
Date:   Thu, 18 Aug 2022 18:40:36 +0530
Message-Id: <20220818131042.113280-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gQLVWZOKJyTCBgbEDICuLfrsaZdruVDd
X-Proofpoint-ORIG-GUID: M7YE5VNrYOmXd492QHsmU4pLrMKSSxqW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180045
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

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c           | 42 +++++++++++++++--
 include/linux/memory-tiers.h | 42 ++++++++++++++++-
 mm/memory-tiers.c            | 91 +++++++++++++++++++++++++++---------
 3 files changed, 149 insertions(+), 26 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..4852a2dbdb27 100644
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
+#define MEMTIER_DEFAULT_DAX_ADISTANCE	(MEMTIER_ADISTANCE_DRAM * 5)
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
index 17b41e592be6..30aecff9ae79 100644
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
@@ -16,12 +19,49 @@
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
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
index 05f05395468a..3ddf305df7d1 100644
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
 
+static inline void __init_node_memory_type(int node, struct memory_dev_type *memtype)
+{
+	if (!node_memory_types[node]) {
+		node_memory_types[node] = memtype;
+		kref_get(&memtype->kref);
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
+void init_node_memory_type(int node, struct memory_dev_type *memtype)
+{
+
+	mutex_lock(&memory_tier_lock);
+	__init_node_memory_type(node, memtype);
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
2.37.2

