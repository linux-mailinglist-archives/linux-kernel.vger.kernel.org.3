Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A94D5362BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352301AbiE0Mk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352541AbiE0Mjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F2C64717
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:26:52 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RBN0fN031780;
        Fri, 27 May 2022 12:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=paC/N7Knk3u6wYpWG7QAYM+rQaDHntsIFqUghGL1LvM=;
 b=MjAXztzv9p7jcO6thbjlz5MKbKH5Ln112qdh8W8d5RMp5Aw3zgY7nJY5oIvwltQ6wnWF
 5s0Pi9AALbjShgIMImxdYCX/rfITRzPV5Ddgt6LVejpgo2EQ7wCDscfp19MzYDj1nw3G
 rm54kuX1XtmDftEi5f7mNsEfUsGdTR8epIYX8ut9bbPTTGchBW1i1Q1sjI9OWUSblrqZ
 6GNTKDY/YUm2LBjVlZg3IZwCCQemJtMEWKUcF7DWPPwx2yy5QQKCX4mM1AX4QLlFcmgK
 erb8UX2QB+weK96Cg9fLoeUex5Lx7HvjZoGX/vHENhWQHVwmbzigOK1q+swN45LKWJvX xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gawqkh281-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:34 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RCQYsd013344;
        Fri, 27 May 2022 12:26:34 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gawqkh26d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:33 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCGdOA015414;
        Fri, 27 May 2022 12:26:32 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03wdc.us.ibm.com with ESMTP id 3gabgmenq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:32 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCQVOS62849344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:26:31 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52ABBAE063;
        Fri, 27 May 2022 12:26:31 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75237AE05C;
        Fri, 27 May 2022 12:26:24 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:26:24 +0000 (GMT)
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH v4 1/7] mm/demotion: Add support for explicit memory tiers
Date:   Fri, 27 May 2022 17:55:22 +0530
Message-Id: <20220527122528.129445-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: y25MeBebACys8xuhofPP7J0B-QXnqQSh
X-Proofpoint-GUID: gCstOEmpGtR1srbWaaB6sMHh3EVmX2u8
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya@linux.ibm.com>

In the current kernel, memory tiers are defined implicitly via a
demotion path relationship between NUMA nodes, which is created
during the kernel initialization and updated when a NUMA node is
hot-added or hot-removed.  The current implementation puts all
nodes with CPU into the top tier, and builds the tier hierarchy
tier-by-tier by establishing the per-node demotion targets based
on the distances between nodes.

This current memory tier kernel interface needs to be improved for
several important use cases,

The current tier initialization code always initializes
each memory-only NUMA node into a lower tier.  But a memory-only
NUMA node may have a high performance memory device (e.g. a DRAM
device attached via CXL.mem or a DRAM-backed memory-only node on
a virtual machine) and should be put into a higher tier.

The current tier hierarchy always puts CPU nodes into the top
tier. But on a system with HBM or GPU devices, the
memory-only NUMA nodes mapping these devices should be in the
top tier, and DRAM nodes with CPUs are better to be placed into the
next lower tier.

With current kernel higher tier node can only be demoted to selected nodes on the
next lower tier as defined by the demotion path, not any other
node from any lower tier.  This strict, hard-coded demotion order
does not work in all use cases (e.g. some use cases may want to
allow cross-socket demotion to another node in the same demotion
tier as a fallback when the preferred demotion node is out of
space), This demotion order is also inconsistent with the page
allocation fallback order when all the nodes in a higher tier are
out of space: The page allocation can fall back to any node from
any lower tier, whereas the demotion order doesn't allow that.

The current kernel also don't provide any interfaces for the
userspace to learn about the memory tier hierarchy in order to
optimize its memory allocations.

This patch series address the above by defining memory tiers explicitly.

This patch adds below sysfs interface which is read-only and
can be used to read nodes available in specific tier.

/sys/devices/system/memtier/memtierN/nodelist

Tier 0 is the highest tier, while tier MAX_MEMORY_TIERS - 1 is the
lowest tier. The absolute value of a tier id number has no specific
meaning. what matters is the relative order of the tier id numbers.

All the tiered memory code is guarded by CONFIG_TIERED_MEMORY.
Default number of memory tiers are MAX_MEMORY_TIERS(3). All the
nodes are by default assigned to DEFAULT_MEMORY_TIER(1).

Default memory tier can be read from,
/sys/devices/system/memtier/default_tier

Max memory tier can be read from,
/sys/devices/system/memtier/max_tiers

This patch implements the RFC spec sent by Wei Xu <weixugc@google.com> at [1].

[1] https://lore.kernel.org/linux-mm/CAAPL-u-DGLcKRVDnChN9ZhxPkfxQvz9Sb93kVoX_4J2oiJSkUw@mail.gmail.com/

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/migrate.h |  38 ++++++++----
 mm/Kconfig              |  11 ++++
 mm/migrate.c            | 134 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+), 13 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 90e75d5a54d6..0ec653623565 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -47,17 +47,8 @@ void folio_migrate_copy(struct folio *newfolio, struct folio *folio);
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count);
 
-extern bool numa_demotion_enabled;
-extern void migrate_on_reclaim_init(void);
-#ifdef CONFIG_HOTPLUG_CPU
-extern void set_migration_target_nodes(void);
-#else
-static inline void set_migration_target_nodes(void) {}
-#endif
 #else
 
-static inline void set_migration_target_nodes(void) {}
-
 static inline void putback_movable_pages(struct list_head *l) {}
 static inline int migrate_pages(struct list_head *l, new_page_t new,
 		free_page_t free, unsigned long private, enum migrate_mode mode,
@@ -82,7 +73,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 	return -ENOSYS;
 }
 
-#define numa_demotion_enabled	false
 #endif /* CONFIG_MIGRATION */
 
 #ifdef CONFIG_COMPACTION
@@ -172,15 +162,37 @@ struct migrate_vma {
 int migrate_vma_setup(struct migrate_vma *args);
 void migrate_vma_pages(struct migrate_vma *migrate);
 void migrate_vma_finalize(struct migrate_vma *migrate);
-int next_demotion_node(int node);
+#endif /* CONFIG_MIGRATION */
+
+#ifdef CONFIG_TIERED_MEMORY
+
+extern bool numa_demotion_enabled;
+#define DEFAULT_MEMORY_TIER	1
+
+enum memory_tier_type {
+	MEMORY_TIER_HBM_GPU,
+	MEMORY_TIER_DRAM,
+	MEMORY_TIER_PMEM,
+	MAX_MEMORY_TIERS
+};
 
-#else /* CONFIG_MIGRATION disabled: */
+int next_demotion_node(int node);
 
+extern void migrate_on_reclaim_init(void);
+#ifdef CONFIG_HOTPLUG_CPU
+extern void set_migration_target_nodes(void);
+#else
+static inline void set_migration_target_nodes(void) {}
+#endif
+#else
+#define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
 {
 	return NUMA_NO_NODE;
 }
 
-#endif /* CONFIG_MIGRATION */
+static inline void set_migration_target_nodes(void) {}
+static inline void migrate_on_reclaim_init(void) {}
+#endif	/* CONFIG_TIERED_MEMORY */
 
 #endif /* _LINUX_MIGRATE_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index 034d87953600..7bfbddef46ed 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -258,6 +258,17 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 config ARCH_ENABLE_THP_MIGRATION
 	bool
 
+config TIERED_MEMORY
+	bool "Support for explicit memory tiers"
+	def_bool y
+	depends on MIGRATION && NUMA
+	help
+	  Support to split nodes into memory tiers explicitly and
+	  to demote pages on reclaim to lower tiers. This option
+	  also exposes sysfs interface to read nodes available in
+	  specific tier and to move specific node among different
+	  possible tiers.
+
 config HUGETLB_PAGE_SIZE_VARIABLE
 	def_bool n
 	help
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c31ee1e1c9b..f28ee93fb017 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2118,6 +2118,113 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 #endif /* CONFIG_NUMA_BALANCING */
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_TIERED_MEMORY
+
+struct memory_tier {
+	struct device dev;
+	nodemask_t nodelist;
+};
+
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
+
+static struct bus_type memory_tier_subsys = {
+	.name = "memtier",
+	.dev_name = "memtier",
+};
+
+static struct memory_tier *memory_tiers[MAX_MEMORY_TIERS];
+
+static ssize_t nodelist_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	int tier = dev->id;
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&memory_tiers[tier]->nodelist));
+
+}
+static DEVICE_ATTR_RO(nodelist);
+
+static struct attribute *memory_tier_dev_attrs[] = {
+	&dev_attr_nodelist.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_dev_group = {
+	.attrs = memory_tier_dev_attrs,
+};
+
+static const struct attribute_group *memory_tier_dev_groups[] = {
+	&memory_tier_dev_group,
+	NULL
+};
+
+static void memory_tier_device_release(struct device *dev)
+{
+	struct memory_tier *tier = to_memory_tier(dev);
+
+	kfree(tier);
+}
+
+static int register_memory_tier(int tier)
+{
+	int error;
+
+	memory_tiers[tier] = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!memory_tiers[tier])
+		return -ENOMEM;
+
+	memory_tiers[tier]->dev.id = tier;
+	memory_tiers[tier]->dev.bus = &memory_tier_subsys;
+	memory_tiers[tier]->dev.release = memory_tier_device_release;
+	memory_tiers[tier]->dev.groups = memory_tier_dev_groups;
+	error = device_register(&memory_tiers[tier]->dev);
+
+	if (error) {
+		put_device(&memory_tiers[tier]->dev);
+		memory_tiers[tier] = NULL;
+	}
+
+	return error;
+}
+
+static void unregister_memory_tier(int tier)
+{
+	device_unregister(&memory_tiers[tier]->dev);
+	memory_tiers[tier] = NULL;
+}
+
+static ssize_t
+max_tiers_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIERS);
+}
+
+static DEVICE_ATTR_RO(max_tiers);
+
+static ssize_t
+default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", DEFAULT_MEMORY_TIER);
+}
+
+static DEVICE_ATTR_RO(default_tier);
+
+static struct attribute *memoty_tier_attrs[] = {
+	&dev_attr_max_tiers.attr,
+	&dev_attr_default_tier.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_attr_group = {
+	.attrs = memoty_tier_attrs,
+};
+
+static const struct attribute_group *memory_tier_attr_groups[] = {
+	&memory_tier_attr_group,
+	NULL,
+};
+
 /*
  * node_demotion[] example:
  *
@@ -2569,3 +2676,30 @@ static int __init numa_init_sysfs(void)
 }
 subsys_initcall(numa_init_sysfs);
 #endif
+
+static int __init memory_tier_init(void)
+{
+	int ret;
+
+	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
+	if (ret)
+		panic("%s() failed to register subsystem: %d\n", __func__, ret);
+
+	/*
+	 * Register only default memory tier to hide all empty
+	 * memory tier from sysfs.
+	 */
+	ret = register_memory_tier(DEFAULT_MEMORY_TIER);
+	if (ret)
+		panic("%s() failed to register memory tier: %d\n", __func__, ret);
+
+	/*
+	 * CPU only nodes are not part of memoty tiers.
+	 */
+	memory_tiers[DEFAULT_MEMORY_TIER]->nodelist = node_states[N_MEMORY];
+
+	return 0;
+}
+subsys_initcall(memory_tier_init);
+
+#endif	/* CONFIG_TIERED_MEMORY */
-- 
2.36.1

