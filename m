Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7715458C346
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiHHG1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbiHHG07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:26:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB83E031
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:26:55 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2784pfBS020969;
        Mon, 8 Aug 2022 06:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4OqbboYNuzFkDfdQOpnppRNomrd/ePIQBxSb2+g6JBw=;
 b=dxMjj0bPCwqjLRHCLLMOSU/VoPNFO1lY8hRBhNPeXsAdnK83Vs5pGmerLP1p+ydx28+H
 9a3cBP6WFmLeYo+t7mdJfFrW72SKLc4lGd4d9TmMFoHIqY1ivW8aoe0YeByEE4+JpR1l
 eOL9KMRBJJpzPRmcoyP9avnia4H3O18BZ/FEp8v94p/Yn6ggbTBXthLwYDY5RuTALPQy
 XEXvDzYqNE/p4dNsnK/O3GL4hfCJCv4zv3OowyXKiF/HXeiMzIhTmj6TgNg0B+yTGaxs
 Vv8haPxhQ1Se9Hs+wqElmPRIFIRbRjI472cS6M/m2LWIAI4bl+MHht0cqyRj6FDAVCZ5 EQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3htutut4bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:26:42 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2785GUsG032417;
        Mon, 8 Aug 2022 06:26:41 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3htutut4bh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:26:41 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2786KWRf028615;
        Mon, 8 Aug 2022 06:26:40 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 3hsfx92v76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:26:40 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2786QeeT40108350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 06:26:40 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AAA77805F;
        Mon,  8 Aug 2022 06:26:40 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21B717805E;
        Mon,  8 Aug 2022 06:26:34 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.19.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 06:26:33 +0000 (GMT)
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
Subject: [PATCH v13 4/9] mm/demotion/dax/kmem: Set node's abstract distance to MEMTIER_DEFAULT_DAX_ADISTANCE
Date:   Mon,  8 Aug 2022 11:55:56 +0530
Message-Id: <20220808062601.836025-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nNXIQDMKDPxeqLO_l5s4uOBmiFiL9fRr
X-Proofpoint-GUID: 2FNQdhzcTDT1VLCGPLSJDZHo--Z_b43p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_03,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080031
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
 drivers/dax/kmem.c           | 40 ++++++++++++++++++-
 include/linux/memory-tiers.h | 26 ++++++++++++-
 mm/memory-tiers.c            | 74 +++++++++++++++++++++++++-----------
 3 files changed, 115 insertions(+), 25 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..b5cb03307af8 100644
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
@@ -62,6 +71,8 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	init_node_memory_type(numa_node, dax_slowmem_type);
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
@@ -162,6 +173,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 {
 	int i, success = 0;
+	int node = dev_dax->target_node;
 	struct device *dev = &dev_dax->dev;
 	struct dax_kmem_data *data = dev_get_drvdata(dev);
 
@@ -198,6 +210,14 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
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
@@ -228,9 +248,27 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
+	dax_slowmem_type = kmalloc(sizeof(*dax_slowmem_type), GFP_KERNEL);
+	if (!dax_slowmem_type) {
+		rc = -ENOMEM;
+		goto kmem_name_free;
+	}
+	dax_slowmem_type->adistance = MEMTIER_DEFAULT_DAX_ADISTANCE;
+	INIT_LIST_HEAD(&dax_slowmem_type->tier_sibiling);
+	dax_slowmem_type->nodes  = NODE_MASK_NONE;
+	dax_slowmem_type->memtier = NULL;
+	kref_init(&dax_slowmem_type->kref);
+
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
-		kfree_const(kmem_name);
+		goto error_out;
+
+	return rc;
+
+error_out:
+	kfree(dax_slowmem_type);
+kmem_name_free:
+	kfree_const(kmem_name);
 	return rc;
 }
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index cc89876899a6..7bf6f47d581a 100644
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
@@ -13,12 +15,34 @@
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
+void init_node_memory_type(int node, struct memory_dev_type *default_type);
+void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 
 #else
 
 #define numa_demotion_enabled	false
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
index 2caa5ab446b8..e07dffb67567 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#include <linux/types.h>
-#include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
@@ -21,26 +19,10 @@ struct memory_tier {
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
- * For now let's have 4 memory tier below default DRAM tier.
- */
-static struct memory_dev_type default_dram_type  = {
-	.adistance = MEMTIER_ADISTANCE_DRAM,
-	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
-};
+static struct memory_dev_type *default_dram_type;
 
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
@@ -96,6 +78,14 @@ static struct memory_tier *__node_get_memory_tier(int node)
 	return NULL;
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
@@ -107,7 +97,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 		return ERR_PTR(-EINVAL);
 
 	if (!node_memory_types[node])
-		node_memory_types[node] = &default_dram_type;
+		__init_node_memory_type(node, default_dram_type);
 
 	memtype = node_memory_types[node];
 	node_set(node, memtype->nodes);
@@ -143,6 +133,34 @@ static bool clear_node_memory_tier(int node)
 	return cleared;
 }
 
+void init_node_memory_type(int node, struct memory_dev_type *default_type)
+{
+
+	mutex_lock(&memory_tier_lock);
+	__init_node_memory_type(node, default_type);
+	mutex_unlock(&memory_tier_lock);
+}
+EXPORT_SYMBOL_GPL(init_node_memory_type);
+
+static void release_memtype(struct kref *kref)
+{
+	struct memory_dev_type *memtype;
+
+	memtype = container_of(kref, struct memory_dev_type, kref);
+	kfree(memtype);
+}
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
@@ -176,17 +194,27 @@ static int __init memory_tier_init(void)
 	int node;
 	struct memory_tier *memtier;
 
+	default_dram_type = kmalloc(sizeof(*default_dram_type), GFP_KERNEL);
+	if (!default_dram_type)
+		panic("%s() failed to allocate default DRAM tier\n", __func__);
+
 	mutex_lock(&memory_tier_lock);
+
+	/* For now let's have 4 memory tier below default DRAM tier. */
+	default_dram_type->adistance = MEMTIER_ADISTANCE_DRAM;
+	INIT_LIST_HEAD(&default_dram_type->tier_sibiling);
+	default_dram_type->memtier = NULL;
+	kref_init(&default_dram_type->kref);
 	/* CPU only nodes are not part of memory tiers. */
-	default_dram_type.nodes = node_states[N_MEMORY];
+	default_dram_type->nodes = node_states[N_MEMORY];
 
-	memtier = find_create_memory_tier(&default_dram_type);
+	memtier = find_create_memory_tier(default_dram_type);
 	if (IS_ERR(memtier))
 		panic("%s() failed to register memory tier: %ld\n",
 		      __func__, PTR_ERR(memtier));
 
 	for_each_node_state(node, N_MEMORY)
-		node_memory_types[node] = &default_dram_type;
+		__init_node_memory_type(node, default_dram_type);
 
 	mutex_unlock(&memory_tier_lock);
 
-- 
2.37.1

