Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8684153CACC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbiFCNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238572AbiFCNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:43:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4330E39690
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:43:47 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253DSsxV011341;
        Fri, 3 Jun 2022 13:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/oA9LGIP88Gpnp11nljD/CJTAamm36Hcf8YkiGAoLxU=;
 b=C613BK2CafRGr2nma/5h7BHrCcz0tHTrcYyHed1gt6SyQhMs0hMfZG1j6xf3AK4qNCEM
 k8xSUqxGmCa1Qdb7e0fSe5fnMLTSpXPshrX47VsPUojnyheI/1tH1D8be6ibK5eAA2tx
 EnENdJ77hzr8RwW7nMz7vu+xxtDgnQv71n//frIe3X0UBOpKNLzrDL2P3Ct+CWhyrn0p
 r1XC3ceX/Js6FCZsyzdfDdEN5y/0mHb667hUveotZYghzCATJb/yQTEIK1PAvLJo/qjA
 Ev0dTQEuY21bc6odP2AHJmCdhzfjiXN3171KFGD2erBXx07rcQldAGHD5M58wIeVS6sZ dQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk7kr8et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:27 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253DZQq3003156;
        Fri, 3 Jun 2022 13:43:26 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk7kr8ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:26 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DaXQ2027627;
        Fri, 3 Jun 2022 13:43:25 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma04dal.us.ibm.com with ESMTP id 3gd4n68dhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:25 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DhOXm6030034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:43:24 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 903F5112064;
        Fri,  3 Jun 2022 13:43:24 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0291E112065;
        Fri,  3 Jun 2022 13:43:17 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:43:16 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
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
Subject: [PATCH v5 1/9] mm/demotion: Add support for explicit memory tiers
Date:   Fri,  3 Jun 2022 19:12:29 +0530
Message-Id: <20220603134237.131362-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A_gPILNQDguDnqU3jwfkNfGenZR6HMNq
X-Proofpoint-GUID: hm4m7ynA733JJRgb55UsFu1ziIMX7G9v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

This patch introduce explicity memory tiers with ranks. The rank
value of a memory tier is used to derive the demotion order between
NUMA nodes. The memory tiers present in a system can be found at

/sys/devices/system/memtier/memtierN/

The nodes which are part of a specific memory tier can be listed
via
/sys/devices/system/memtier/memtierN/nodelist

"Rank" is an opaque value. Its absolute value doesn't have any
special meaning. But the rank values of different memtiers can be
compared with each other to determine the memory tier order.

For example, if we have 3 memtiers: memtier0, memtier1, memiter2, and
their rank values are 300, 200, 100, then the memory tier order is:
memtier0 -> memtier2 -> memtier1, where memtier0 is the highest tier
and memtier1 is the lowest tier.

The rank value of each memtier should be unique.

A higher rank memory tier will appear first in the demotion order
than a lower rank memory tier. ie. while reclaim we choose a node
in higher rank memory tier to demote pages to as compared to a node
in a lower rank memory tier.

For now we are not adding the dynamic number of memory tiers.
But a future series supporting that is possible. Currently
number of tiers supported is limitted to MAX_MEMORY_TIERS(3).
When doing memory hotplug, if not added to a memory tier, the NUMA
node gets added to DEFAULT_MEMORY_TIER(1).

This patch is based on the proposal sent by Wei Xu <weixugc@google.com> at [1].

[1] https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  20 ++++
 mm/Kconfig                   |  11 ++
 mm/Makefile                  |   1 +
 mm/memory-tiers.c            | 188 +++++++++++++++++++++++++++++++++++
 4 files changed, 220 insertions(+)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
new file mode 100644
index 000000000000..e17f6b4ee177
--- /dev/null
+++ b/include/linux/memory-tiers.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_TIERS_H
+#define _LINUX_MEMORY_TIERS_H
+
+#ifdef CONFIG_TIERED_MEMORY
+
+#define MEMORY_TIER_HBM_GPU	0
+#define MEMORY_TIER_DRAM	1
+#define MEMORY_TIER_PMEM	2
+
+#define MEMORY_RANK_HBM_GPU	300
+#define MEMORY_RANK_DRAM	200
+#define MEMORY_RANK_PMEM	100
+
+#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
+#define MAX_MEMORY_TIERS  3
+
+#endif	/* CONFIG_TIERED_MEMORY */
+
+#endif
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..08a3d330740b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -614,6 +614,17 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 config ARCH_ENABLE_THP_MIGRATION
 	bool
 
+config TIERED_MEMORY
+	bool "Support for explicit memory tiers"
+	def_bool n
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
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..482557fbc9d1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_TIERED_MEMORY) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
new file mode 100644
index 000000000000..7de18d94a08d
--- /dev/null
+++ b/mm/memory-tiers.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/nodemask.h>
+#include <linux/slab.h>
+#include <linux/memory-tiers.h>
+
+struct memory_tier {
+	struct list_head list;
+	struct device dev;
+	nodemask_t nodelist;
+	int rank;
+};
+
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
+
+static struct bus_type memory_tier_subsys = {
+	.name = "memtier",
+	.dev_name = "memtier",
+};
+
+static DEFINE_MUTEX(memory_tier_lock);
+static LIST_HEAD(memory_tiers);
+
+
+static ssize_t nodelist_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&memtier->nodelist));
+}
+static DEVICE_ATTR_RO(nodelist);
+
+static ssize_t rank_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	return sysfs_emit(buf, "%d\n", memtier->rank);
+}
+static DEVICE_ATTR_RO(rank);
+
+static struct attribute *memory_tier_dev_attrs[] = {
+	&dev_attr_nodelist.attr,
+	&dev_attr_rank.attr,
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
+/*
+ * Keep it simple by having  direct mapping between
+ * tier index and rank value.
+ */
+static inline int get_rank_from_tier(unsigned int tier)
+{
+	switch (tier) {
+	case MEMORY_TIER_HBM_GPU:
+		return MEMORY_RANK_HBM_GPU;
+	case MEMORY_TIER_DRAM:
+		return MEMORY_RANK_DRAM;
+	case MEMORY_TIER_PMEM:
+		return MEMORY_RANK_PMEM;
+	}
+
+	return 0;
+}
+
+static void insert_memory_tier(struct memory_tier *memtier)
+{
+	struct list_head *ent;
+	struct memory_tier *tmp_memtier;
+
+	list_for_each(ent, &memory_tiers) {
+		tmp_memtier = list_entry(ent, struct memory_tier, list);
+		if (tmp_memtier->rank < memtier->rank) {
+			list_add_tail(&memtier->list, ent);
+			return;
+		}
+	}
+	list_add_tail(&memtier->list, &memory_tiers);
+}
+
+static struct memory_tier *register_memory_tier(unsigned int tier)
+{
+	int error;
+	struct memory_tier *memtier;
+
+	if (tier >= MAX_MEMORY_TIERS)
+		return NULL;
+
+	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!memtier)
+		return NULL;
+
+	memtier->dev.id = tier;
+	memtier->rank = get_rank_from_tier(tier);
+	memtier->dev.bus = &memory_tier_subsys;
+	memtier->dev.release = memory_tier_device_release;
+	memtier->dev.groups = memory_tier_dev_groups;
+
+	insert_memory_tier(memtier);
+
+	error = device_register(&memtier->dev);
+	if (error) {
+		list_del(&memtier->list);
+		put_device(&memtier->dev);
+		return NULL;
+	}
+	return memtier;
+}
+
+__maybe_unused // temporay to prevent warnings during bisects
+static void unregister_memory_tier(struct memory_tier *memtier)
+{
+	list_del(&memtier->list);
+	device_unregister(&memtier->dev);
+}
+
+static ssize_t
+max_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIERS);
+}
+static DEVICE_ATTR_RO(max_tier);
+
+static ssize_t
+default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "memtier%d\n", DEFAULT_MEMORY_TIER);
+}
+static DEVICE_ATTR_RO(default_tier);
+
+static struct attribute *memory_tier_attrs[] = {
+	&dev_attr_max_tier.attr,
+	&dev_attr_default_tier.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_attr_group = {
+	.attrs = memory_tier_attrs,
+};
+
+static const struct attribute_group *memory_tier_attr_groups[] = {
+	&memory_tier_attr_group,
+	NULL,
+};
+
+static int __init memory_tier_init(void)
+{
+	int ret;
+	struct memory_tier *memtier;
+
+	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
+	if (ret)
+		panic("%s() failed to register subsystem: %d\n", __func__, ret);
+
+	/*
+	 * Register only default memory tier to hide all empty
+	 * memory tier from sysfs.
+	 */
+	memtier = register_memory_tier(DEFAULT_MEMORY_TIER);
+	if (!memtier)
+		panic("%s() failed to register memory tier: %d\n", __func__, ret);
+
+	/* CPU only nodes are not part of memory tiers. */
+	memtier->nodelist = node_states[N_MEMORY];
+
+	return 0;
+}
+subsys_initcall(memory_tier_init);
+
-- 
2.36.1

