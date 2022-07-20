Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835557AE31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiGTDAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiGTDAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40B65FAF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:11 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2gIlE001948;
        Wed, 20 Jul 2022 02:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=e1Fo4W63FPOVMdgBK4/L/AqPqNHPfqCxBMqMcpU0GFI=;
 b=gfum23MnX7lMibNvA1+U01Rcx+JM5osyKLc9oAOGr4MaJODiR2uxoQFBSIGtgebXR+Y2
 sfnuF1F/+VMXrQ5KzLx/G2EoR3kzYZuTd83Q6ef65yKa6Ya4VRwoS8Sm4fgk2U9kfCNH
 KKlhzQS/vejauyxFrDH8uNfKGx/azWCLF4ewu/hQ5San+Z0SkuqQ+XcRXV6mam6SKxc2
 fQk7WwNgiqpHzZXvqq/BNiIHUEXYR1l9q8KePNLdaUZAuqTTMJZmO/RXT6PhOtTVi4DJ
 HGwkaC5QMTngmsl5Y9Uy1Yu0Nc3LHrNsWaWAZBZfVvTfRDEjD+DDys+6VDyIhhNdF4ES CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598c38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 02:59:51 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K2uMdh018654;
        Wed, 20 Jul 2022 02:59:51 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598c2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 02:59:51 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K2pRde015591;
        Wed, 20 Jul 2022 02:59:50 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 3hbmy9ct4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 02:59:50 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K2xmH041222538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:59:48 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 96446136053;
        Wed, 20 Jul 2022 02:59:48 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 126C313604F;
        Wed, 20 Jul 2022 02:59:42 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.15.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 02:59:41 +0000 (GMT)
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
Subject: [PATCH v10 1/8] mm/demotion: Add support for explicit memory tiers
Date:   Wed, 20 Jul 2022 08:29:13 +0530
Message-Id: <20220720025920.1373558-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5iLDHiCkcrrpI0OaU4KW2ieuq4ndEiHU
X-Proofpoint-ORIG-GUID: Q2qjYVECBqXhP_sAkW44QdMpt7lsdxNw
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Linux kernel presents memory devices as NUMA nodes and each memory device is of
a specific type. The memory type of a device is represented by its performance
level. A memory tier corresponds to a range of performance levels. This allows
for classifying memory devices with a specific performance range into a memory
tier.

This patch configures the range/chunk size to be 128. The default DRAM
performance level is 512. We can have 4 memory tiers below the default DRAM
performance level which cover the range 0 - 127, 127 - 255, 256- 383, 384 - 511.
Slower memory devices like persistent memory will have performance levels below
the default DRAM level and hence will be placed in these 4 lower tiers.

While reclaim we migrate pages from fast(higher) tiers to slow(lower) tiers when
the fast(higher) tier is under memory pressure.

A kernel parameter is provided to override the default memory tier.

Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com
Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  18 +++++++
 include/linux/node.h         |   6 +++
 mm/Makefile                  |   1 +
 mm/memory-tiers.c            | 101 +++++++++++++++++++++++++++++++++++
 4 files changed, 126 insertions(+)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
new file mode 100644
index 000000000000..f28f9910a4e7
--- /dev/null
+++ b/include/linux/memory-tiers.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_TIERS_H
+#define _LINUX_MEMORY_TIERS_H
+
+#ifdef CONFIG_NUMA
+/*
+ * Each tier cover a performance level chunk size of 128
+ */
+#define MEMTIER_CHUNK_BITS	7
+/*
+ * For now let's have 4 memory tier below default DRAM tier.
+ */
+#define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
+/* leave one tier below this slow pmem */
+#define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
+
+#endif	/* CONFIG_NUMA */
+#endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/node.h b/include/linux/node.h
index 40d641a8bfb0..a2a16d4104fd 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -92,6 +92,12 @@ struct node {
 	struct list_head cache_attrs;
 	struct device *cache_dev;
 #endif
+	/*
+	 * For memory devices, perf_level describes
+	 * the device performance and how it should be used
+	 * while building a memory hierarchy.
+	 */
+	int perf_level;
 };
 
 struct memory_block;
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
index 000000000000..61bb84c54091
--- /dev/null
+++ b/mm/memory-tiers.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/slab.h>
+#include <linux/lockdep.h>
+#include <linux/moduleparam.h>
+#include <linux/node.h>
+#include <linux/memory-tiers.h>
+
+struct memory_tier {
+	struct list_head list;
+	int perf_level;
+	nodemask_t nodelist;
+};
+
+static LIST_HEAD(memory_tiers);
+static DEFINE_MUTEX(memory_tier_lock);
+
+/*
+ * For now let's have 4 memory tier below default DRAM tier.
+ */
+static unsigned int default_memtier_perf_level = MEMTIER_PERF_LEVEL_DRAM;
+core_param(default_memory_tier_perf_level, default_memtier_perf_level, uint, 0644);
+/*
+ * performance levels are grouped into memtiers each of chunk size
+ * memtier_perf_chunk
+ */
+static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
+{
+	bool found_slot = false;
+	struct list_head *ent;
+	struct memory_tier *memtier, *new_memtier;
+	unsigned int memtier_perf_chunk_size = 1 << MEMTIER_CHUNK_BITS;
+	/*
+	 * zero is special in that it indicates uninitialized
+	 * perf level by respective driver. Pick default memory
+	 * tier perf level for that.
+	 */
+	if (!perf_level)
+		perf_level = default_memtier_perf_level;
+
+	lockdep_assert_held_once(&memory_tier_lock);
+
+	perf_level = round_down(perf_level, memtier_perf_chunk_size);
+	list_for_each(ent, &memory_tiers) {
+		memtier = list_entry(ent, struct memory_tier, list);
+		if (perf_level == memtier->perf_level) {
+			return memtier;
+		} else if (perf_level < memtier->perf_level) {
+			found_slot = true;
+			break;
+		}
+	}
+
+	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!new_memtier)
+		return ERR_PTR(-ENOMEM);
+
+	new_memtier->perf_level = perf_level;
+	if (found_slot)
+		list_add_tail(&new_memtier->list, ent);
+	else
+		list_add_tail(&new_memtier->list, &memory_tiers);
+	return new_memtier;
+}
+
+static int __init memory_tier_init(void)
+{
+	int node;
+	struct memory_tier *memtier;
+
+	/*
+	 * Since this is early during  boot, we could avoid
+	 * holding memtory_tier_lock. But keep it simple by
+	 * holding locks. So we can add lock held debug checks
+	 * in other functions.
+	 */
+	mutex_lock(&memory_tier_lock);
+	memtier = find_create_memory_tier(default_memtier_perf_level);
+	if (IS_ERR(memtier))
+		panic("%s() failed to register memory tier: %ld\n",
+		      __func__, PTR_ERR(memtier));
+
+	/* CPU only nodes are not part of memory tiers. */
+	memtier->nodelist = node_states[N_MEMORY];
+
+	/*
+	 * nodes that are already online and that doesn't
+	 * have perf level assigned is assigned a default perf
+	 * level.
+	 */
+	for_each_node_state(node, N_MEMORY) {
+		struct node *node_property = node_devices[node];
+
+		if (!node_property->perf_level)
+			node_property->perf_level = default_memtier_perf_level;
+	}
+	mutex_unlock(&memory_tier_lock);
+	return 0;
+}
+subsys_initcall(memory_tier_init);
-- 
2.36.1

