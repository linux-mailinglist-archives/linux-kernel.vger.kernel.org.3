Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57E65A42F3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiH2GIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2GIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:08:45 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBE843304
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:08:43 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T5mfSa030420;
        Mon, 29 Aug 2022 06:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=HbPn7F0Ldv91uizyuWDRbG50WBgjbWdlhxnIXimJ3+k=;
 b=KpGP/vVn4yyRFC0QWd56Icu4ylLQhazccqQpUK9X6SykcrKnMNbNxVHVuvbZG9CFOl66
 oVGtq2y5/wdYErobtnBUizgPYXojD9WMvAJohewq8flbbjq72JgQ96fU4PLkwSf3ntEQ
 YCPRO1dIbaXgjyjFOVvJYEQuMx74zp61U9t/iV/4unpgYUh36Ui9FHFVyfgoorNqNQge
 ChXLlvtSCVOzOprLJtdmTFxHDMZ9FzvYj7RdFmZZK97WGFjoTaDUnvjgszoKRGfrowAn
 MCuFW75uQoWqccPEzshz4JmhOIaTu3kM6qHj3egIQ0j+tRAYLONiDBoBR4h4FcoEXJSn 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qmv8fkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 06:08:18 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T5pah6005477;
        Mon, 29 Aug 2022 06:08:18 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j8qmv8fk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 06:08:17 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27T5pCNr010359;
        Mon, 29 Aug 2022 06:08:16 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3j7aw9e4yc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 06:08:16 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27T68Fw146793024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 06:08:15 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73CD5C6057;
        Mon, 29 Aug 2022 06:08:15 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EADAAC6055;
        Mon, 29 Aug 2022 06:08:08 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.118.176])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 29 Aug 2022 06:08:08 +0000 (GMT)
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
Subject: [PATCH v2] mm/demotion: Expose memory tier details via sysfs
Date:   Mon, 29 Aug 2022 11:37:45 +0530
Message-Id: <20220829060745.287468-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _dZnQRYLZEQWDN7Wf4o7VVPgAUsuv4Ey
X-Proofpoint-GUID: aqmB5EWCI9X7XOosyl4XGm1G5YjaJ9TW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
related details can be found. All allocated memory tiers will be listed
there as /sys/devices/virtual/memory_tiering/memory_tierN/

The nodes which are part of a specific memory tier can be listed via
/sys/devices/virtual/memory_tiering/memory_tierN/nodes

The abstract distance range value of a specific memory tier can be listed via
/sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance

A directory hierarchy looks like
:/sys/devices/virtual/memory_tiering$ tree memory_tier4/
memory_tier4/
├── abstract_distance
├── nodes
├── subsystem -> ../../../../bus/memory_tiering
└── uevent

All toptier nodes are listed via
/sys/devices/virtual/memory_tiering/toptier_nodes

:/sys/devices/virtual/memory_tiering$ cat toptier_nodes
0,2
:/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
0,2
:/sys/devices/virtual/memory_tiering$ cat memory_tier4/abstract_distance
512 - 639

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 .../ABI/testing/sysfs-kernel-mm-memory-tiers  |  41 +++++
 mm/memory-tiers.c                             | 155 +++++++++++++++---
 2 files changed, 174 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
new file mode 100644
index 000000000000..6955f69a4423
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
@@ -0,0 +1,41 @@
+What:		/sys/devices/virtual/memory_tiering/
+Date:		August 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	A collection of all the memory tiers allocated.
+
+		Individual memory tier details are contained in subdirectories
+		named by the abstract distance of the memory tier.
+
+		/sys/devices/virtual/memory_tiering/memory_tierN/
+
+
+What:		/sys/devices/virtual/memory_tiering/memory_tierN/
+		/sys/devices/virtual/memory_tiering/memory_tierN/abstract_distance
+		/sys/devices/virtual/memory_tiering/memory_tierN/nodes
+Date:		August 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Directory with details of a specific memory tier
+
+		This is the directory containing information about a particular
+		memory tier, memtierN, where N is derived based on abstract distance.
+
+		A smaller value of N implies a higher (faster) memory tier in the
+		hierarchy.
+
+		abstract_distance: The abstract distance range this specific memory
+		tier maps to.
+
+		nodes: NUMA nodes that are part of this memory tier.
+
+
+What:		/sys/devices/virtual/memory_tiering/toptier_nodes
+Date:		August 2022
+Contact:	Linux memory management mailing list <linux-mm@kvack.org>
+Description:	Toptier node mask
+
+		A toptier is defined as the memory tier from which memory promotion
+		is not done by the kernel.
+
+		toptier_nodes: NUMA nodes that are part of all the memory tiers
+		above a topier tier.
+
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c4bd6d052a33..d4648d4e4d54 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -19,6 +19,7 @@ struct memory_tier {
 	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
 	 */
 	int adistance_start;
+	struct device dev;
 	/* All the nodes that are part of all the lower memory tiers. */
 	nodemask_t lower_tier_mask;
 };
@@ -36,6 +37,13 @@ static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
 static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
 static struct memory_dev_type *default_dram_type;
+
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
+static struct bus_type memory_tier_subsys = {
+	.name = "memory_tiering",
+	.dev_name = "memory_tier",
+};
+
 #ifdef CONFIG_MIGRATION
 static int top_tier_adistance;
 /*
@@ -98,8 +106,73 @@ static int top_tier_adistance;
 static struct demotion_nodes *node_demotion __read_mostly;
 #endif /* CONFIG_MIGRATION */
 
+static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
+{
+	nodemask_t nodes = NODE_MASK_NONE;
+	struct memory_dev_type *memtype;
+
+	list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
+		nodes_or(nodes, nodes, memtype->nodes);
+
+	return nodes;
+}
+
+static void memory_tier_device_release(struct device *dev)
+{
+	struct memory_tier *tier = to_memory_tier(dev);
+	/*
+	 * synchronize_rcu in clear_node_memory_tier makes sure
+	 * we don't have rcu access to this memory tier.
+	 */
+	kfree(tier);
+}
+
+static ssize_t nodes_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	int ret;
+	nodemask_t nmask;
+
+	mutex_lock(&memory_tier_lock);
+	nmask = get_memtier_nodemask(to_memory_tier(dev));
+	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&nmask));
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_RO(nodes);
+
+static ssize_t abstract_distance_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	int ret;
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	mutex_lock(&memory_tier_lock);
+	ret = sysfs_emit(buf, "%d - %d\n", memtier->adistance_start,
+			 memtier->adistance_start + MEMTIER_CHUNK_SIZE - 1);
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_RO(abstract_distance);
+
+static struct attribute *memtier_dev_attrs[] = {
+	&dev_attr_nodes.attr,
+	&dev_attr_abstract_distance.attr,
+	NULL
+};
+
+static const struct attribute_group memtier_dev_group = {
+	.attrs = memtier_dev_attrs,
+};
+
+static const struct attribute_group *memtier_dev_groups[] = {
+	&memtier_dev_group,
+	NULL
+};
+
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
+	int ret;
 	bool found_slot = false;
 	struct memory_tier *memtier, *new_memtier;
 	int adistance = memtype->adistance;
@@ -123,15 +196,14 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		if (adistance == memtier->adistance_start) {
-			list_add(&memtype->tier_sibiling, &memtier->memory_types);
-			return memtier;
+			goto link_memtype;
 		} else if (adistance < memtier->adistance_start) {
 			found_slot = true;
 			break;
 		}
 	}
 
-	new_memtier = kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
 	if (!new_memtier)
 		return ERR_PTR(-ENOMEM);
 
@@ -142,8 +214,23 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		list_add_tail(&new_memtier->list, &memtier->list);
 	else
 		list_add_tail(&new_memtier->list, &memory_tiers);
-	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
-	return new_memtier;
+
+	new_memtier->dev.id = adistance >> MEMTIER_CHUNK_BITS;
+	new_memtier->dev.bus = &memory_tier_subsys;
+	new_memtier->dev.release = memory_tier_device_release;
+	new_memtier->dev.groups = memtier_dev_groups;
+
+	ret = device_register(&new_memtier->dev);
+	if (ret) {
+		list_del(&memtier->list);
+		put_device(&memtier->dev);
+		return ERR_PTR(ret);
+	}
+	memtier = new_memtier;
+
+link_memtype:
+	list_add(&memtype->tier_sibiling, &memtier->memory_types);
+	return memtier;
 }
 
 static struct memory_tier *__node_get_memory_tier(int node)
@@ -275,17 +362,6 @@ static void disable_all_demotion_targets(void)
 	synchronize_rcu();
 }
 
-static __always_inline nodemask_t get_memtier_nodemask(struct memory_tier *memtier)
-{
-	nodemask_t nodes = NODE_MASK_NONE;
-	struct memory_dev_type *memtype;
-
-	list_for_each_entry(memtype, &memtier->memory_types, tier_sibiling)
-		nodes_or(nodes, nodes, memtype->nodes);
-
-	return nodes;
-}
-
 /*
  * Find an automatic demotion target for all memory
  * nodes. Failing here is OK.  It might just indicate
@@ -432,11 +508,7 @@ static struct memory_tier *set_node_memory_tier(int node)
 static void destroy_memory_tier(struct memory_tier *memtier)
 {
 	list_del(&memtier->list);
-	/*
-	 * synchronize_rcu in clear_node_memory_tier makes sure
-	 * we don't have rcu access to this memory tier.
-	 */
-	kfree(memtier);
+	device_unregister(&memtier->dev);
 }
 
 static bool clear_node_memory_tier(int node)
@@ -563,11 +635,50 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
 	return notifier_from_errno(0);
 }
 
+static ssize_t toptier_nodes_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	int ret;
+	nodemask_t nmask, top_tier_mask = NODE_MASK_NONE;
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	mutex_lock(&memory_tier_lock);
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (memtier->adistance_start >= top_tier_adistance)
+			break;
+		nmask = get_memtier_nodemask(memtier);
+		nodes_or(top_tier_mask, top_tier_mask, nmask);
+	}
+
+	ret = sysfs_emit(buf, "%*pbl\n", nodemask_pr_args(&top_tier_mask));
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_RO(toptier_nodes);
+
+static struct attribute *memtier_subsys_attrs[] = {
+	&dev_attr_toptier_nodes.attr,
+	NULL
+};
+
+static const struct attribute_group memtier_subsys_group = {
+	.attrs = memtier_subsys_attrs,
+};
+
+static const struct attribute_group *memtier_subsys_groups[] = {
+	&memtier_subsys_group,
+	NULL
+};
+
 static int __init memory_tier_init(void)
 {
-	int node;
+	int ret, node;
 	struct memory_tier *memtier;
 
+	ret = subsys_virtual_register(&memory_tier_subsys, memtier_subsys_groups);
+	if (ret)
+		panic("%s() failed to register memory tier subsystem\n", __func__);
+
 #ifdef CONFIG_MIGRATION
 	node_demotion = kcalloc(nr_node_ids, sizeof(struct demotion_nodes),
 				GFP_KERNEL);
-- 
2.37.2

