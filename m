Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1DC5362C8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbiE0MlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350776AbiE0Mjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:55 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78F3106342
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:27:26 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RCJVWo001386;
        Fri, 27 May 2022 12:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dSL5o6tQgRnfr1+Kx7mXPPAdiylCVwGNvI4tvH+fN1A=;
 b=gbjYviGObuXq7RMXs3vLE0HUQksS5UYSnOEnugp1bnUFWyPiVJJJVx0ukesOlgkXuDTu
 7h1TnPFJlNibwq7tr2c8fkFCtlLVTlxLGnWn8714Tk+KR1P90g+sXyeuRXqn0dLUmGha
 U1rAhgU6Ih95Bhq5IXV/OhScAeW/6BLd1gEfQOxogvybAh6PUVufK5qlHo5J/tWOTDd/
 4PWJMTWAuOtEaBFNqSe+/vfaV9n4BE+hrq6mNuGKOuU6YeTmTHYdmNwsk3vN0ql1Py/D
 kEIApP44KYNYytLWSiXdnm7bBuZQqmWfNP65KOi5oeESltKfwqxMEbdYFv4lOHAVig/i Ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaxhqr4ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:04 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RCR4IV023291;
        Fri, 27 May 2022 12:27:04 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gaxhqr4a0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:03 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCL6TO006945;
        Fri, 27 May 2022 12:27:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3gaenbn8g3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:02 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCR1eo38470130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:27:01 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1862AE060;
        Fri, 27 May 2022 12:27:01 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12956AE05F;
        Fri, 27 May 2022 12:26:55 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:26:54 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
        Greg Thelen <gthelen@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        David Rientjes <rientjes@google.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH v4 5/7] mm/demotion: Add support to associate rank with memory tier
Date:   Fri, 27 May 2022 17:55:26 +0530
Message-Id: <20220527122528.129445-6-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DH0zbHA1Sr2N4oQwiSfySCGa-tVQslhC
X-Proofpoint-ORIG-GUID: j75_7h0jbo2EMtK6aCawQ8gTdR7jd3s6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2205270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rank approach allows us to keep memory tier device IDs stable even if there
is a need to change the tier ordering among different memory tiers. e.g. DRAM
nodes with CPUs will always be on memtier1, no matter how many tiers are higher
or lower than these nodes. A new memory tier can be inserted into the tier
hierarchy for a new set of nodes without affecting the node assignment of any
existing memtier, provided that there is enough gap in the rank values for the
new memtier.

The absolute value of "rank" of a memtier doesn't necessarily carry any meaning.
Its value relative to other memtiers decides the level of this memtier in the tier
hierarchy.

For now, This patch supports hardcoded rank values which are 100, 200, & 300 for
memory tiers 0,1 & 2 respectively.

Below is the sysfs interface to read the rank values of memory tier,
/sys/devices/system/memtier/memtierN/rank

This interface is read only for now, write support can be added when there is
a need of flexibility of more number of memory tiers(> 3) with flexibile ordering
requirement among them, rank can be utilized there as rank decides now memory
tiering ordering and not memory tier device ids.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c     |   5 +-
 drivers/dax/kmem.c      |   2 +-
 include/linux/migrate.h |  17 ++--
 mm/migrate.c            | 218 ++++++++++++++++++++++++----------------
 4 files changed, 144 insertions(+), 98 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index cf4a58446d8c..892f7c23c94e 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -567,8 +567,11 @@ static ssize_t memtier_show(struct device *dev,
 			    char *buf)
 {
 	int node = dev->id;
+	int tier_index = node_get_memory_tier_id(node);
 
-	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
+	if (tier_index != -1)
+		return sysfs_emit(buf, "%d\n", tier_index);
+	return 0;
 }
 
 static ssize_t memtier_store(struct device *dev,
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index 991782aa2448..79953426ddaf 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -149,7 +149,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	dev_set_drvdata(dev, data);
 
 #ifdef CONFIG_TIERED_MEMORY
-	node_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
+	node_set_memory_tier_rank(numa_node, MEMORY_RANK_PMEM);
 #endif
 	return 0;
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index cbef71a499c1..fd09fd009a69 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -167,18 +167,19 @@ void migrate_vma_finalize(struct migrate_vma *migrate);
 #ifdef CONFIG_TIERED_MEMORY
 
 extern bool numa_demotion_enabled;
-#define DEFAULT_MEMORY_TIER	1
-
 enum memory_tier_type {
-	MEMORY_TIER_HBM_GPU,
-	MEMORY_TIER_DRAM,
-	MEMORY_TIER_PMEM,
-	MAX_MEMORY_TIERS
+	MEMORY_RANK_HBM_GPU,
+	MEMORY_RANK_DRAM,
+	DEFAULT_MEMORY_RANK = MEMORY_RANK_DRAM,
+	MEMORY_RANK_PMEM
 };
 
+#define DEFAULT_MEMORY_TIER 1
+#define MAX_MEMORY_TIERS  3
+
 int next_demotion_node(int node);
-int node_get_memory_tier(int node);
-int node_set_memory_tier(int node, int tier);
+int node_get_memory_tier_id(int node);
+int node_set_memory_tier_rank(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
 #else
 #define numa_demotion_enabled	false
diff --git a/mm/migrate.c b/mm/migrate.c
index 59d8558dd2ee..f013d14f77ed 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2121,8 +2121,10 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 #ifdef CONFIG_TIERED_MEMORY
 
 struct memory_tier {
+	struct list_head list;
 	struct device dev;
 	nodemask_t nodelist;
+	int rank;
 };
 
 struct demotion_nodes {
@@ -2139,7 +2141,7 @@ static struct bus_type memory_tier_subsys = {
 static void establish_migration_targets(void);
 
 DEFINE_MUTEX(memory_tier_lock);
-static struct memory_tier *memory_tiers[MAX_MEMORY_TIERS];
+static LIST_HEAD(memory_tiers);
 
 /*
  * node_demotion[] examples:
@@ -2206,16 +2208,25 @@ static struct demotion_nodes *node_demotion __read_mostly;
 static ssize_t nodelist_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
-	int tier = dev->id;
+	struct memory_tier *memtier = to_memory_tier(dev);
 
 	return sysfs_emit(buf, "%*pbl\n",
-			  nodemask_pr_args(&memory_tiers[tier]->nodelist));
-
+			  nodemask_pr_args(&memtier->nodelist));
 }
 static DEVICE_ATTR_RO(nodelist);
 
+static ssize_t rank_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	return sysfs_emit(buf, "%d\n", memtier->rank);
+}
+static DEVICE_ATTR_RO(rank);
+
 static struct attribute *memory_tier_dev_attrs[] = {
 	&dev_attr_nodelist.attr,
+	&dev_attr_rank.attr,
 	NULL
 };
 
@@ -2235,53 +2246,79 @@ static void memory_tier_device_release(struct device *dev)
 	kfree(tier);
 }
 
-static int register_memory_tier(int tier)
+static void insert_memory_tier(struct memory_tier *memtier)
+{
+	struct list_head *ent;
+	struct memory_tier *tmp_memtier;
+
+	list_for_each(ent, &memory_tiers) {
+		tmp_memtier = list_entry(ent, struct memory_tier, list);
+		if (tmp_memtier->rank > memtier->rank) {
+			list_add_tail(&memtier->list, ent);
+			return;
+		}
+	}
+	list_add_tail(&memtier->list, &memory_tiers);
+}
+
+static struct memory_tier *register_memory_tier(unsigned int tier)
 {
 	int error;
+	struct memory_tier *memtier;
 
-	memory_tiers[tier] = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
-	if (!memory_tiers[tier])
-		return -ENOMEM;
+	if (tier >= MAX_MEMORY_TIERS)
+		return NULL;
 
-	memory_tiers[tier]->dev.id = tier;
-	memory_tiers[tier]->dev.bus = &memory_tier_subsys;
-	memory_tiers[tier]->dev.release = memory_tier_device_release;
-	memory_tiers[tier]->dev.groups = memory_tier_dev_groups;
-	error = device_register(&memory_tiers[tier]->dev);
+	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!memtier)
+		return NULL;
 
+	memtier->dev.id = tier;
+	/*
+	 * For now we only supported hardcoded rank value which
+	 * 100, 200, 300 with no special meaning.
+	 */
+	memtier->rank = 100 + 100 * tier;
+	memtier->dev.bus = &memory_tier_subsys;
+	memtier->dev.release = memory_tier_device_release;
+	memtier->dev.groups = memory_tier_dev_groups;
+
+	insert_memory_tier(memtier);
+
+	error = device_register(&memtier->dev);
 	if (error) {
-		put_device(&memory_tiers[tier]->dev);
-		memory_tiers[tier] = NULL;
+		list_del(&memtier->list);
+		put_device(&memtier->dev);
+		return NULL;
 	}
-
-	return error;
+	return memtier;
 }
 
-static void unregister_memory_tier(int tier)
+static void unregister_memory_tier(struct memory_tier *memtier)
 {
-	device_unregister(&memory_tiers[tier]->dev);
-	memory_tiers[tier] = NULL;
+	list_del(&memtier->list);
+	device_unregister(&memtier->dev);
 }
 
 static ssize_t
-max_tiers_show(struct device *dev, struct device_attribute *attr, char *buf)
+max_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIERS);
 }
 
-static DEVICE_ATTR_RO(max_tiers);
+static DEVICE_ATTR_RO(max_tier);
 
 static ssize_t
-default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+default_rank_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", DEFAULT_MEMORY_TIER);
+	return sysfs_emit(buf, "%d\n",  100 + 100 * DEFAULT_MEMORY_TIER);
 }
 
-static DEVICE_ATTR_RO(default_tier);
+static DEVICE_ATTR_RO(default_rank);
 
 static struct attribute *memoty_tier_attrs[] = {
-	&dev_attr_max_tiers.attr,
-	&dev_attr_default_tier.attr,
+	&dev_attr_max_tier.attr,
+	&dev_attr_default_rank.attr,
 	NULL
 };
 
@@ -2294,52 +2331,61 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
 	NULL,
 };
 
-static int __node_get_memory_tier(int node)
+static struct memory_tier *__node_get_memory_tier(int node)
 {
-	int tier;
+	struct memory_tier *memtier;
 
-	for (tier = 0; tier < MAX_MEMORY_TIERS; tier++) {
-		if (memory_tiers[tier] && node_isset(node, memory_tiers[tier]->nodelist))
-			return tier;
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (node_isset(node, memtier->nodelist))
+			return memtier;
 	}
+	return NULL;
+}
 
-	return -1;
+static struct memory_tier *__get_memory_tier_from_id(int id)
+{
+	struct memory_tier *memtier;
+
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (memtier->dev.id == id)
+			return memtier;
+	}
+	return NULL;
 }
 
+
 static void node_remove_from_memory_tier(int node)
 {
-	int tier;
+	struct memory_tier *memtier;
 
 	mutex_lock(&memory_tier_lock);
 
-	tier = __node_get_memory_tier(node);
-
+	memtier = __node_get_memory_tier(node);
 	/*
 	 * Remove node from tier, if tier becomes
 	 * empty then unregister it to make it invisible
 	 * in sysfs.
 	 */
-	node_clear(node, memory_tiers[tier]->nodelist);
-	if (nodes_empty(memory_tiers[tier]->nodelist))
-		unregister_memory_tier(tier);
+	node_clear(node, memtier->nodelist);
+	if (nodes_empty(memtier->nodelist))
+		unregister_memory_tier(memtier);
 
 	establish_migration_targets();
-
 	mutex_unlock(&memory_tier_lock);
 }
 
-int node_get_memory_tier(int node)
+int node_get_memory_tier_id(int node)
 {
-	int tier;
-
+	int tier = -1;
+	struct memory_tier *memtier;
 	/*
 	 * Make sure memory tier is not unregistered
 	 * while it is being read.
 	 */
 	mutex_lock(&memory_tier_lock);
-
-	tier = __node_get_memory_tier(node);
-
+	memtier = __node_get_memory_tier(node);
+	if (memtier)
+		tier = memtier->dev.id;
 	mutex_unlock(&memory_tier_lock);
 
 	return tier;
@@ -2348,46 +2394,43 @@ int node_get_memory_tier(int node)
 int __node_set_memory_tier(int node, int tier)
 {
 	int ret = 0;
-	/*
-	 * As register_memory_tier() for new tier can fail,
-	 * try it before modifying existing tier. register
-	 * tier makes tier visible in sysfs.
-	 */
-	if (!memory_tiers[tier]) {
-		ret = register_memory_tier(tier);
-		if (ret) {
+	struct memory_tier *memtier;
+
+	memtier = __get_memory_tier_from_id(tier);
+	if (!memtier) {
+		memtier = register_memory_tier(tier);
+		if (!memtier) {
+			ret = -EINVAL;
 			goto out;
 		}
 	}
-
-	node_set(node, memory_tiers[tier]->nodelist);
+	node_set(node, memtier->nodelist);
 	establish_migration_targets();
-
 out:
 	return ret;
 }
 
 int node_reset_memory_tier(int node, int tier)
 {
-	int current_tier, ret = 0;
+	struct memory_tier *current_tier;
+	int ret = 0;
 
 	mutex_lock(&memory_tier_lock);
 
 	current_tier = __node_get_memory_tier(node);
-	if (current_tier == tier)
+	if (!current_tier || current_tier->dev.id == tier)
 		goto out;
 
-	if (current_tier != -1 )
-		node_clear(node, memory_tiers[current_tier]->nodelist);
+	node_clear(node, current_tier->nodelist);
 
 	ret = __node_set_memory_tier(node, tier);
 
 	if (!ret) {
-		if (nodes_empty(memory_tiers[current_tier]->nodelist))
+		if (nodes_empty(current_tier->nodelist))
 			unregister_memory_tier(current_tier);
 	} else {
 		/* reset it back to older tier */
-		ret = __node_set_memory_tier(node, current_tier);
+		node_set(node, current_tier->nodelist);
 	}
 out:
 	mutex_unlock(&memory_tier_lock);
@@ -2395,15 +2438,13 @@ int node_reset_memory_tier(int node, int tier)
 	return ret;
 }
 
-int node_set_memory_tier(int node, int tier)
+int node_set_memory_tier_rank(int node, int rank)
 {
-	int current_tier, ret = 0;
-
-	if (tier >= MAX_MEMORY_TIERS)
-		return -EINVAL;
+	struct memory_tier *memtier;
+	int ret = 0;
 
 	mutex_lock(&memory_tier_lock);
-	current_tier = __node_get_memory_tier(node);
+	memtier = __node_get_memory_tier(node);
 	/*
 	 * if node is already part of the tier proceed with the
 	 * current tier value, because we might want to establish
@@ -2411,15 +2452,17 @@ int node_set_memory_tier(int node, int tier)
 	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
 	 * will have skipped this node.
 	 */
-	if (current_tier != -1)
-		tier = current_tier;
-	ret = __node_set_memory_tier(node, tier);
+	if (memtier)
+		establish_migration_targets();
+	else {
+		/* For now rank value and tier value is same. */
+		ret = __node_set_memory_tier(node, rank);
+	}
 	mutex_unlock(&memory_tier_lock);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(node_set_memory_tier);
-
+EXPORT_SYMBOL_GPL(node_set_memory_tier_rank);
 
 /**
  * next_demotion_node() - Get the next node in the demotion path
@@ -2504,6 +2547,8 @@ static void disable_all_migrate_targets(void)
 */
 static void establish_migration_targets(void)
 {
+	struct list_head *ent;
+	struct memory_tier *memtier;
 	struct demotion_nodes *nd;
 	int tier, target = NUMA_NO_NODE, node;
 	int distance, best_distance;
@@ -2518,19 +2563,15 @@ static void establish_migration_targets(void)
 		best_distance = -1;
 		nd = &node_demotion[node];
 
-		tier = __node_get_memory_tier(node);
+		memtier = __node_get_memory_tier(node);
+		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
+			continue;
 		/*
-		 * Find next tier to demote.
+		 * Get the next memtier to find the  demotion node list.
 		 */
-		while (++tier < MAX_MEMORY_TIERS) {
-			if (memory_tiers[tier])
-				break;
-		}
+		memtier = list_next_entry(memtier, list);
 
-		if (tier >= MAX_MEMORY_TIERS)
-			continue;
-
-		nodes_andnot(used, node_states[N_MEMORY], memory_tiers[tier]->nodelist);
+		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
 
 		/*
 		 * Find all the nodes in the memory tier node list of same best distance.
@@ -2588,7 +2629,7 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
 		 * registered, we will continue to use that for the new memory
 		 * we are adding here.
 		 */
-		node_set_memory_tier(arg->status_change_nid, DEFAULT_MEMORY_TIER);
+		node_set_memory_tier_rank(arg->status_change_nid, DEFAULT_MEMORY_RANK);
 		break;
 	}
 
@@ -2668,6 +2709,7 @@ subsys_initcall(numa_init_sysfs);
 static int __init memory_tier_init(void)
 {
 	int ret;
+	struct memory_tier *memtier;
 
 	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
 	if (ret)
@@ -2677,14 +2719,14 @@ static int __init memory_tier_init(void)
 	 * Register only default memory tier to hide all empty
 	 * memory tier from sysfs.
 	 */
-	ret = register_memory_tier(DEFAULT_MEMORY_TIER);
-	if (ret)
+	memtier = register_memory_tier(DEFAULT_MEMORY_TIER);
+	if (!memtier)
 		panic("%s() failed to register memory tier: %d\n", __func__, ret);
 
 	/*
 	 * CPU only nodes are not part of memoty tiers.
 	 */
-	memory_tiers[DEFAULT_MEMORY_TIER]->nodelist = node_states[N_MEMORY];
+	memtier->nodelist = node_states[N_MEMORY];
 	migrate_on_reclaim_init();
 
 	return 0;
-- 
2.36.1

