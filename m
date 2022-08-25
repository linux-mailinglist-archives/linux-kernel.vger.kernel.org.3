Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2995A0C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239731AbiHYJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239700AbiHYJYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:24:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4E9A9C26
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:24:11 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P8kfb9028852;
        Thu, 25 Aug 2022 09:23:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=/3HZdqo3/9MmZqqTy+mTYaXdrdbmOPa2CDTlqVxHdNY=;
 b=SWX1CcZMi4KUm7VlwL+0PEVV21P1HaGVDI5UkTi96MpMHd0dZHel2f3BXTGpd6SZJ6yY
 uBEsl40AIf4tThTb2Nk7LmEwyAukSmdSWYJsCXFmKMHV8KK8Vubd4K5fX2xePQnef8Pk
 gIjN3BXPaBD7ozss+E4IP000oAfCdr6zHlvpv2I2+EcwrhRDSk40RreRg5ozy3yhBp/F
 jhOXizCTAjedX20w1YFD8z5Rr9ZYFUwbrvKjR6k6fN0BMqJShcxVBzVrvdttpLbC0Ouw
 hi2DChjsnqsVDaXneuBq+3UGxxbrR1w/n7Zgqy1g/cICaF3oAOzWVWQQ2F6U+Fsu2Tyo 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j65vb9yhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:48 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27P8ms3I005261;
        Thu, 25 Aug 2022 09:23:48 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j65vb9yfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:48 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27P9KpAI010630;
        Thu, 25 Aug 2022 09:23:46 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma01wdc.us.ibm.com with ESMTP id 3j2q896pt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:46 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27P9Nj5b10289756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 09:23:45 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 447DC136053;
        Thu, 25 Aug 2022 09:23:45 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344EE136051;
        Thu, 25 Aug 2022 09:23:39 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.112.25])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 09:23:38 +0000 (GMT)
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
Subject: [RFC PATCH 1/2] mm/demotion: Expose memory type details via sysfs
Date:   Thu, 25 Aug 2022 14:53:24 +0530
Message-Id: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bOSZGVN6wNReS-4JkG-MDBMc_ymk-p91
X-Proofpoint-ORIG-GUID: E41C2q33Hup9psnMxsI9t5Rna_7gjusW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208250034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds /sys/devices/virtual/memtier/ where all memory tier related
details can be found. All allocated memory types will be listed there as
/sys/devices/virtual/memtier/memtypeN/

The nodes which are part of a specific memory type can be listed via
/sys/devices/system/memtier/memtypeN/nodes.

The adistance value of a specific memory type can be listed via
/sys/devices/system/memtier/memtypeN/adistance.

A directory listing looks like:
:/sys/devices/virtual/memtier# tree memtype1
memtype1
├── adistance
├── nodes
├── subsystem -> ../../../../bus/memtier
└── uevent

Since we will be using struct device to expose details via sysfs, drop struct
kref and use struct device for refcounting the memtype.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  3 +-
 mm/memory-tiers.c            | 97 +++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index ecd865922707..487209a572b2 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -6,6 +6,7 @@
 #include <linux/nodemask.h>
 #include <linux/kref.h>
 #include <linux/mmzone.h>
+#include <linux/device.h>
 /*
  * Each tier cover a abstrace distance chunk size of 128
  */
@@ -28,7 +29,7 @@ struct memory_dev_type {
 	int adistance;
 	/* Nodes of same abstract distance */
 	nodemask_t nodes;
-	struct kref kref;
+	struct device dev;
 };
 
 #ifdef CONFIG_NUMA
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index ba844fe9cc8c..9eef3bd8d134 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -4,6 +4,7 @@
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
 #include <linux/memory.h>
+#include <linux/idr.h>
 #include <linux/memory-tiers.h>
 
 #include "internal.h"
@@ -31,6 +32,15 @@ static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
 static struct memory_dev_type *default_dram_type;
+
+#define MAX_MEMORY_TYPE_ID	20
+static DEFINE_IDR(memory_type_idr);
+#define to_memory_type(device) container_of(device, struct memory_dev_type, dev)
+static struct bus_type memory_tier_subsys = {
+	.name = "memtier",
+	.dev_name = "memtier",
+};
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
@@ -388,7 +398,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
 {
 	if (!node_memory_types[node]) {
 		node_memory_types[node] = memtype;
-		kref_get(&memtype->kref);
+		get_device(&memtype->dev);
 	}
 }
 
@@ -460,33 +470,87 @@ static bool clear_node_memory_tier(int node)
 	return cleared;
 }
 
-static void release_memtype(struct kref *kref)
+static ssize_t nodes_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
-	struct memory_dev_type *memtype;
+	int ret;
+	struct memory_dev_type *memtype = to_memory_type(dev);
 
-	memtype = container_of(kref, struct memory_dev_type, kref);
+	mutex_lock(&memory_tier_lock);
+	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&memtype->nodes));
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_RO(nodes);
+
+static ssize_t adistance_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct memory_dev_type *memtype = to_memory_type(dev);
+
+	mutex_lock(&memory_tier_lock);
+	ret = sysfs_emit(buf, "%d\n", memtype->adistance);
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_RO(adistance);
+
+static struct attribute *memtype_dev_attrs[] = {
+	&dev_attr_nodes.attr,
+	&dev_attr_adistance.attr,
+	NULL
+};
+
+static const struct attribute_group memtype_dev_group = {
+	.attrs = memtype_dev_attrs,
+};
+
+static const struct attribute_group *memtype_dev_groups[] = {
+	&memtype_dev_group,
+	NULL
+};
+
+static void memtype_device_release(struct device *dev)
+{
+	struct memory_dev_type *memtype = to_memory_type(dev);
+
+	idr_remove(&memory_type_idr, memtype->dev.id);
 	kfree(memtype);
 }
 
 struct memory_dev_type *alloc_memory_type(int adistance)
 {
+	int ret;
 	struct memory_dev_type *memtype;
 
-	memtype = kmalloc(sizeof(*memtype), GFP_KERNEL);
+	memtype = kzalloc(sizeof(*memtype), GFP_KERNEL);
 	if (!memtype)
 		return ERR_PTR(-ENOMEM);
 
 	memtype->adistance = adistance;
 	INIT_LIST_HEAD(&memtype->tier_sibiling);
 	memtype->nodes  = NODE_MASK_NONE;
-	kref_init(&memtype->kref);
+	memtype->dev.id = idr_alloc(&memory_type_idr, NULL,
+				 1, MAX_MEMORY_TYPE_ID + 1, GFP_KERNEL);
+	memtype->dev.bus = &memory_tier_subsys;
+	memtype->dev.release = memtype_device_release;
+	memtype->dev.groups = memtype_dev_groups;
+	dev_set_name(&memtype->dev, "%s%d", "memtype", memtype->dev.id);
+
+	ret = device_register(&memtype->dev);
+	if (ret) {
+		put_device(&memtype->dev);
+		return ERR_PTR(ret);
+	}
+
 	return memtype;
 }
 EXPORT_SYMBOL_GPL(alloc_memory_type);
 
 void destroy_memory_type(struct memory_dev_type *memtype)
 {
-	kref_put(&memtype->kref, release_memtype);
+	device_unregister(&memtype->dev);
 }
 EXPORT_SYMBOL_GPL(destroy_memory_type);
 
@@ -504,7 +568,7 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 	mutex_lock(&memory_tier_lock);
 	if (node_memory_types[node] == memtype) {
 		node_memory_types[node] = NULL;
-		kref_put(&memtype->kref, release_memtype);
+		put_device(&memtype->dev);
 	}
 	mutex_unlock(&memory_tier_lock);
 }
@@ -582,6 +646,23 @@ static int __init memory_tier_init(void)
 }
 subsys_initcall(memory_tier_init);
 
+/*
+ * initialize sysfs subsys in core_initcall so that
+ * other kernel components can do alloc_memory_type
+ * before memory_tier_init
+ */
+static int __init memory_tier_sysfs_init(void)
+{
+	int err;
+
+	err = subsys_virtual_register(&memory_tier_subsys, NULL);
+	if (err)
+		return err;
+
+	return 0;
+}
+core_initcall(memory_tier_sysfs_init);
+
 bool numa_demotion_enabled = false;
 
 #ifdef CONFIG_MIGRATION
-- 
2.37.2

