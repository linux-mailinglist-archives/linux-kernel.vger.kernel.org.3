Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA4590BA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237064AbiHLF6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237040AbiHLF6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:58:01 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A687CA3D7F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:57:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5lwCi024806;
        Fri, 12 Aug 2022 05:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mPbKfYK6YwezdZ6rEc7R5V2G5nXd0mbXuKj54CWNCIE=;
 b=Ewn62wi9yh5FgyivXKKho5EJP7f2e1pCjv4At/K9LKnoYCWdpBECEaDJ/9GFx5Z1qsSk
 tnHMWIZQVOxXTlymoK+pmFIpPRbwu72tO8NqM8CbraXwWT5wwb1FEgoHa+wganN3akT/
 HGkfbz02GgZTBneSHwSAdR2e/+gkFr6aBVb6+oGs+aEyGuBNGmEdQ2F6C9G4B3e4hEqy
 278r11VbAd0A6dqWzPlKhddHA8QgYbpRM0Y78HefGNdG0zALFO8QN24vRkq1Fznm4SCo
 i+4gTOtsCjAR+9LHUqPsgyYrrKy4/Hehf9OxavDXoENOQM5Ofvyd7Fr0D0BL6ruWNlsJ xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh1a04x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:32 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5v2sX023922;
        Fri, 12 Aug 2022 05:57:31 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh1a04wt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:31 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5ab0R012228;
        Fri, 12 Aug 2022 05:57:30 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03wdc.us.ibm.com with ESMTP id 3huww6fcrw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:30 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5vTVA9700000
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:57:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87E5A7805E;
        Fri, 12 Aug 2022 05:57:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16B2978060;
        Fri, 12 Aug 2022 05:57:24 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:57:23 +0000 (GMT)
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
Subject: [PATCH v14 01/10] mm/demotion: Add support for explicit memory tiers
Date:   Fri, 12 Aug 2022 11:27:00 +0530
Message-Id: <20220812055710.357820-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: X-n_sVRUi_DNaZH14roB2mFRiPdNp6Ur
X-Proofpoint-ORIG-GUID: xfTz3nsxSCofZla01YaXTFmo-tQh3fpU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current kernel, memory tiers are defined implicitly via a demotion path
relationship between NUMA nodes, which is created during the kernel
initialization and updated when a NUMA node is hot-added or hot-removed. The
current implementation puts all nodes with CPU into the highest tier, and builds
the tier hierarchy by establishing the per-node demotion targets based on the
distances between nodes.

This current memory tier kernel implementation needs to be improved for several
important use cases,

The current tier initialization code always initializes each memory-only NUMA
node into a lower tier. But a memory-only NUMA node may have a high performance
memory device (e.g. a DRAM-backed memory-only node on a virtual machine) that
should be put into a higher tier.

The current tier hierarchy always puts CPU nodes into the top tier. But on a
system with HBM or GPU devices, the memory-only NUMA nodes mapping these devices
should be in the top tier, and DRAM nodes with CPUs are better to be placed into
the next lower tier.

With current kernel higher tier node can only be demoted to nodes with shortest
distance on the next lower tier as defined by the demotion path, not any other
node from any lower tier. This strict, demotion order does not work in all use
cases (e.g. some use cases may want to allow cross-socket demotion to another
node in the same demotion tier as a fallback when the preferred demotion node is
out of space), This demotion order is also inconsistent with the page allocation
fallback order when all the nodes in a higher tier are out of space: The page
allocation can fall back to any node from any lower tier, whereas the demotion
order doesn't allow that.

This patch series address the above by defining memory tiers explicitly.

Linux kernel presents memory devices as NUMA nodes and each memory device is of
a specific type. The memory type of a device is represented by its abstract
distance. A memory tier corresponds to a range of abstract distance. This allows
for classifying memory devices with a specific performance range into a memory
tier.

This patch configures the range/chunk size to be 128. The default DRAM abstract
distance is 512. We can have 4 memory tiers below the default DRAM with abstract
distance range 0 - 127, 127 - 255, 256- 383, 384 - 511. Faster memory devices
can be placed in these faster(higher) memory tiers. Slower memory devices like
persistent memory will have abstract distance higher than the default DRAM
level.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  15 ++++
 mm/Makefile                  |   1 +
 mm/memory-tiers.c            | 129 +++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
new file mode 100644
index 000000000000..bc7c1b799bef
--- /dev/null
+++ b/include/linux/memory-tiers.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_TIERS_H
+#define _LINUX_MEMORY_TIERS_H
+
+/*
+ * Each tier cover a abstrace distance chunk size of 128
+ */
+#define MEMTIER_CHUNK_BITS	7
+#define MEMTIER_CHUNK_SIZE	(1 << MEMTIER_CHUNK_BITS)
+/*
+ * Smaller abstract distance value imply faster(higher) memory tiers.
+ */
+#define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
+
+#endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/Makefile b/mm/Makefile
index 9a564f836403..488f604e77e0 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
+obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
new file mode 100644
index 000000000000..1f494e69776a
--- /dev/null
+++ b/mm/memory-tiers.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/slab.h>
+#include <linux/lockdep.h>
+#include <linux/memory-tiers.h>
+
+struct memory_tier {
+	/* hierarchy of memory tiers */
+	struct list_head list;
+	/* list of all memory types part of this tier */
+	struct list_head memory_types;
+	/*
+	 * start value of abstract distance. memory tier maps
+	 * an abstract distance  range,
+	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
+	 */
+	int adistance_start;
+};
+
+struct memory_dev_type {
+	/* list of memory types that are part of same tier as this type */
+	struct list_head tier_sibiling;
+	/* abstract distance for this specific memory type */
+	int adistance;
+	/* Nodes of same abstract distance */
+	nodemask_t nodes;
+	struct memory_tier *memtier;
+};
+
+static DEFINE_MUTEX(memory_tier_lock);
+static LIST_HEAD(memory_tiers);
+static struct memory_dev_type *node_memory_types[MAX_NUMNODES];
+/*
+ * For now we can have 4 faster memory tiers with smaller adistance
+ * than default DRAM tier.
+ */
+static struct memory_dev_type default_dram_type  = {
+	.adistance = MEMTIER_ADISTANCE_DRAM,
+	.tier_sibiling = LIST_HEAD_INIT(default_dram_type.tier_sibiling),
+};
+
+static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
+{
+	bool found_slot = false;
+	struct memory_tier *memtier, *new_memtier;
+	int adistance = memtype->adistance;
+	unsigned int memtier_adistance_chunk_size = MEMTIER_CHUNK_SIZE;
+
+	lockdep_assert_held_once(&memory_tier_lock);
+
+	/*
+	 * If the memtype is already part of a memory tier,
+	 * just return that.
+	 */
+	if (memtype->memtier)
+		return memtype->memtier;
+
+	adistance = round_down(adistance, memtier_adistance_chunk_size);
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (adistance == memtier->adistance_start) {
+			memtype->memtier = memtier;
+			list_add(&memtype->tier_sibiling, &memtier->memory_types);
+			return memtier;
+		} else if (adistance < memtier->adistance_start) {
+			found_slot = true;
+			break;
+		}
+	}
+
+	new_memtier = kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!new_memtier)
+		return ERR_PTR(-ENOMEM);
+
+	new_memtier->adistance_start = adistance;
+	INIT_LIST_HEAD(&new_memtier->list);
+	INIT_LIST_HEAD(&new_memtier->memory_types);
+	if (found_slot)
+		list_add_tail(&new_memtier->list, &memtier->list);
+	else
+		list_add_tail(&new_memtier->list, &memory_tiers);
+	memtype->memtier = new_memtier;
+	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
+	return new_memtier;
+}
+
+static struct memory_tier *set_node_memory_tier(int node)
+{
+	struct memory_tier *memtier;
+	struct memory_dev_type *memtype;
+
+	lockdep_assert_held_once(&memory_tier_lock);
+
+	if (!node_state(node, N_MEMORY))
+		return ERR_PTR(-EINVAL);
+
+	if (!node_memory_types[node])
+		node_memory_types[node] = &default_dram_type;
+
+	memtype = node_memory_types[node];
+	node_set(node, memtype->nodes);
+	memtier = find_create_memory_tier(memtype);
+	return memtier;
+}
+
+static int __init memory_tier_init(void)
+{
+	int node;
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	/*
+	 * Look at all the existing N_MEMORY nodes and add them to
+	 * default memory tier or to a tier if we already have memory
+	 * types assigned.
+	 */
+	for_each_node_state(node, N_MEMORY) {
+		memtier = set_node_memory_tier(node);
+		if (IS_ERR(memtier))
+			/*
+			 * Continue with memtiers we are able to setup
+			 */
+			break;
+	}
+	mutex_unlock(&memory_tier_lock);
+
+	return 0;
+}
+subsys_initcall(memory_tier_init);
-- 
2.37.1

