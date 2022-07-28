Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E47584682
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbiG1TGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbiG1TGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:06:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE5576974
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:06:20 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIloKW018672;
        Thu, 28 Jul 2022 19:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=uTJDX5S3TUopqT6N3AIdKKSI+mqbGEFWWY/1SYf1XMU=;
 b=BfCBa6Ri4r4wepH1CxPYCwmLspilQmTwtgzY3Vu62y0YkC5/rbCLrbJ6PqaPVc95BH9O
 wSvwBf5NB7D5JbBypq7YADV57R0LxWENbmNh5PfurbOvgZdOsrSRea3cnWkbXvjQvGK0
 URjEsOf8ljYS2cWK9ynG/1e+pjtlWUTGXq8irNGOP/pj1GBsx4+o/WsM1BRBNBN82TsT
 hb4xOfZA40jidKS+eFrW5+XH+ddB4qNBlADmQV/Xdcz2k+0BN3lai7JBix9JU1tRoH0w
 ggBJRlGP6Wq4zLrE9+gOvdpIjOfmmffIxotOl+7psJxCuq3g7RDZ8xAcVeckPOu+HNOw nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238sem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:53 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SIlsKw018778;
        Thu, 28 Jul 2022 19:05:28 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm0238qqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:27 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ2B7l018194;
        Thu, 28 Jul 2022 19:05:02 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3hhfpj63f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:02 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ51vR39452940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:01 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D4746A054;
        Thu, 28 Jul 2022 19:05:01 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D45016A04D;
        Thu, 28 Jul 2022 19:04:54 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:04:54 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v11 1/8] mm/demotion: Add support for explicit memory tiers
Date:   Fri, 29 Jul 2022 00:34:29 +0530
Message-Id: <20220728190436.858458-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Z1w32zoRkLjpVRSMY3eUyjA4weG8iv1n
X-Proofpoint-ORIG-GUID: pE09Hj9K4GLlc_Q8_Ci0p3aPWfuGMvd-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current kernel, memory tiers are defined implicitly via a demotion path
relationship between NUMA nodes, which is created during the kernel
initialization and updated when a NUMA node is hot-added or hot-removed. The
current implementation puts all nodes with CPU into the highest tier, and builds
the tier hierarchy tier-by-tier by establishing the per-node demotion targets
based on the distances between nodes.

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

This patch configures the range/chunk size to be 128. The default DRAM
abstract distance is 512. We can have 4 memory tiers below the default DRAM
abstract distance which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
Slower memory devices like persistent memory will have abstract distance below
the default DRAM level and hence will be placed in these 4 lower tiers.

A kernel parameter is provided to override the default memory tier.

Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  17 ++++++
 mm/Makefile                  |   1 +
 mm/memory-tiers.c            | 102 +++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
new file mode 100644
index 000000000000..8d7884b7a3f0
--- /dev/null
+++ b/include/linux/memory-tiers.h
@@ -0,0 +1,17 @@
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
+ * For now let's have 4 memory tier below default DRAM tier.
+ */
+#define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
+/* leave one tier below this slow pmem */
+#define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
+
+#endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/Makefile b/mm/Makefile
index 6f9ffa968a1a..d30acebc2164 100644
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
index 000000000000..01cfd514c192
--- /dev/null
+++ b/mm/memory-tiers.c
@@ -0,0 +1,102 @@
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
+	/* list of memory types that are are part of same tier as this type */
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
+struct memory_dev_type *node_memory_types[MAX_NUMNODES];
+/*
+ * For now let's have 4 memory tier below default DRAM tier.
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
+	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
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
+static int __init memory_tier_init(void)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	/* CPU only nodes are not part of memory tiers. */
+	default_dram_type.nodes = node_states[N_MEMORY];
+
+	memtier = find_create_memory_tier(&default_dram_type);
+	if (IS_ERR(memtier))
+		panic("%s() failed to register memory tier: %ld\n",
+		      __func__, PTR_ERR(memtier));
+	mutex_unlock(&memory_tier_lock);
+
+	return 0;
+}
+subsys_initcall(memory_tier_init);
-- 
2.37.1

