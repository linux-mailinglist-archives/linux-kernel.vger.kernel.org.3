Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196CC564E5A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiGDHJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiGDHI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:08:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404C8A19B
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:08:13 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2645pGwT003978;
        Mon, 4 Jul 2022 07:07:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=VROdRSEQ/S0c3jBZGx05uszC//GrM1Yj8D2HDfideE0=;
 b=HWb+xpVpe8c47xCwArfvoa8K6+1DbGsK+hZakH7BrZznZatQeov7TEzkaL1X53WUtUDv
 HXHBVi43LW5Ugs7httMIhr9Zrhhh5PQLQSMxeTVUBSxq501BmIMYtwFAApsNvNIkJLCa
 eKKxAPIchVEIpKT/HNXaNT03eOBNolZo532eZQu85LC5Bmb6pC7Oz2k4DF+70cHrvJi1
 BOt96/VHPlWitcBR5tQT8pO2CM5KxRQhkGdC8vRY6Vj3/DQCzApEcSKQFvAkNx/PUZ+3
 Yq37/Lzvia6oUoNH5VKoaM1Bb5tFM/r42/hAHKgcgm0IORdDmpZowjgrJ+RJVKKKciEz DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3te31fxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:47 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646jTXm028984;
        Mon, 4 Jul 2022 07:07:46 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3te31fxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:46 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 264769GF007084;
        Mon, 4 Jul 2022 07:07:45 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 3h2dn9hakx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:45 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26477itb65798614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:07:44 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5147F124058;
        Mon,  4 Jul 2022 07:07:44 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10972124053;
        Mon,  4 Jul 2022 07:07:38 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:07:37 +0000 (GMT)
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
Subject: [PATCH v8 01/12] mm/demotion: Add support for explicit memory tiers
Date:   Mon,  4 Jul 2022 12:36:01 +0530
Message-Id: <20220704070612.299585-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -W6Ne9n39Qj_PtAwy1qJxyQ3QufGhdL5
X-Proofpoint-ORIG-GUID: L_Phx5VKpLsfSGtCbqPrFp6rRQqL0ko5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207040030
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

This patch introduce explicity memory tiers. The tier ID value
of a memory tier is used to derive the demotion order between
NUMA nodes.

For example, if we have 3 memtiers: memtier100, memtier200, memiter300
then the memory tier order is: memtier300 -> memtier200 -> memtier100
where memtier300 is the highest tier and memtier100 is the lowest tier.

While reclaim we migrate pages from fast(higher) tiers to slow(lower)
tiers when the fast(higher) tier is under memory pressure.

This patchset introduce 3 memory tiers (memtier100, memtier200 and memtier300)
which are created by different kernel subsystems. The default memory
tier created by the kernel is memtier200. A kernel parameter is provided
to override the default memory tier.

Link: https://lore.kernel.org/linux-mm/CAAPL-u9Wv+nH1VOZTj=9p9S70Y3Qz3+63EkqncRDdHfubsrjfw@mail.gmail.com

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h | 15 +++++++
 mm/Makefile                  |  1 +
 mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 include/linux/memory-tiers.h
 create mode 100644 mm/memory-tiers.c

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
new file mode 100644
index 000000000000..a81dbc20e0d1
--- /dev/null
+++ b/include/linux/memory-tiers.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_TIERS_H
+#define _LINUX_MEMORY_TIERS_H
+
+#ifdef CONFIG_NUMA
+
+#define MEMORY_TIER_HBM_GPU	300
+#define MEMORY_TIER_DRAM	200
+#define MEMORY_TIER_PMEM	100
+
+#define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
+#define MAX_MEMORY_TIER_ID	400
+
+#endif	/* CONFIG_NUMA */
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
index 000000000000..69a5d81c0a12
--- /dev/null
+++ b/mm/memory-tiers.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/nodemask.h>
+#include <linux/slab.h>
+#include <linux/lockdep.h>
+#include <linux/moduleparam.h>
+#include <linux/memory-tiers.h>
+
+struct memory_tier {
+	struct list_head list;
+	nodemask_t nodelist;
+	int id;
+};
+
+static DEFINE_MUTEX(memory_tier_lock);
+static LIST_HEAD(memory_tiers);
+
+static void insert_memory_tier(struct memory_tier *memtier)
+{
+	struct list_head *ent;
+	struct memory_tier *tmp_memtier;
+
+	lockdep_assert_held_once(&memory_tier_lock);
+
+	list_for_each(ent, &memory_tiers) {
+		tmp_memtier = list_entry(ent, struct memory_tier, list);
+		if (tmp_memtier->id < memtier->id) {
+			list_add_tail(&memtier->list, ent);
+			return;
+		}
+	}
+	list_add_tail(&memtier->list, &memory_tiers);
+}
+
+static struct memory_tier *register_memory_tier(unsigned int tier)
+{
+	struct memory_tier *memtier;
+
+	if (tier > MAX_MEMORY_TIER_ID)
+		return ERR_PTR(-EINVAL);
+
+	memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	if (!memtier)
+		return ERR_PTR(-ENOMEM);
+
+	memtier->id   = tier;
+
+	insert_memory_tier(memtier);
+
+	return memtier;
+}
+
+static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
+core_param(default_memory_tier, default_memtier, uint, 0644);
+
+static int __init memory_tier_init(void)
+{
+	struct memory_tier *memtier;
+
+	/*
+	 * Register only default memory tier to hide all empty
+	 * memory tier from sysfs. Since this is early during
+	 * boot, we could avoid holding memtory_tier_lock. But
+	 * keep it simple by holding locks. So we can add lock
+	 * held debug checks in other functions.
+	 */
+	mutex_lock(&memory_tier_lock);
+	memtier = register_memory_tier(default_memtier);
+	if (IS_ERR(memtier))
+		panic("%s() failed to register memory tier: %ld\n",
+		      __func__, PTR_ERR(memtier));
+
+	/* CPU only nodes are not part of memory tiers. */
+	memtier->nodelist = node_states[N_MEMORY];
+	mutex_unlock(&memory_tier_lock);
+	return 0;
+}
+subsys_initcall(memory_tier_init);
-- 
2.36.1

