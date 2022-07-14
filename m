Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324F2574413
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 07:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbiGNFAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 01:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbiGNE7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 00:59:13 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650401CA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 21:54:47 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26E4PXa4009052;
        Thu, 14 Jul 2022 04:54:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=/euUoNkPo/REsCw8mINu0TfXcX1H0UMv0CFE1cE4n4s=;
 b=W1VS/2dAhnncI91D8rt7QQz0nfJaAdv/w2OSVTgL9Js1es2FrN48mQ8NNHWbr8ysjhai
 1Lh/I9XQKoc4kw7wlfoLW+grNOJCGjx0e2PLXXU8oX+kcqAaZAsy6UGo4dNuN4d/VPZI
 OqOXFoxEFAXotTLDc+cC48yvnNe/7lW2epXESm3x4nB8fyzQX0c/nzTCCUa9mRMjW7Mt
 PTOQS/GwGaffEv0DQusxVghcS8XN44zHnAVLRM9UWek4sQncQCkT9J+MFKnpmCOWB/Ps
 PGOQLhmut1yDmiNiZjUZn443Ak0sXYlH3OsZRitWQXl3YSBb56UCp4kGlTNC6qaI1H3t 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hac3h0p9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:54:32 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26E4Sa5b028113;
        Thu, 14 Jul 2022 04:54:32 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hac3h0p97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:54:32 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26E4qAZk013167;
        Thu, 14 Jul 2022 04:54:31 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04dal.us.ibm.com with ESMTP id 3h9e04uk2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 04:54:31 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26E4sTi423462244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jul 2022 04:54:29 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BEB878060;
        Thu, 14 Jul 2022 04:54:29 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1EDE7805C;
        Thu, 14 Jul 2022 04:54:22 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.119.34])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jul 2022 04:54:22 +0000 (GMT)
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
Subject: [PATCH v9 1/8] mm/demotion: Add support for explicit memory tiers
Date:   Thu, 14 Jul 2022 10:23:44 +0530
Message-Id: <20220714045351.434957-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bbSzpaiV2dWGrVqHS793n7JQaA9J3yq7
X-Proofpoint-ORIG-GUID: 0f-b6t9s5Ytg3oLYjQLvWlNXlGswE7r5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-14_02,2022-07-13_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207140019
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
Link: https://lore.kernel.org/linux-mm/7b72ccf4-f4ae-cb4e-f411-74d055482026@linux.ibm.com

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
index 000000000000..011877b6dbb9
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
+	int id;
+	nodemask_t nodelist;
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

