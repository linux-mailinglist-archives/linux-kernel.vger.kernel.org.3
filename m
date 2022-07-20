Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADF57AE32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240746AbiGTDAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240379AbiGTDAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB00DFD9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:16 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2gLxl002427;
        Wed, 20 Jul 2022 03:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=d4hY5T8h3P3yTciiyzpijA0CASBqERoWzYtXZLunFso=;
 b=THJC44wwLL0G9sige+dbgiZNLp4L0cZnciRBFmZa/oRkMxbHF7uCbbaMR4yH/XbECygd
 7qBuMU7kMcu0dsZ9JdkBRRk9uZc07i6+fSaEuwCxzk1G3GcXW2Xk3ytiX1Uk2vINOc9j
 GpOn3dT6umke+NAXJ81lCMZQXLK5qen39RrmSGfZzJkoKrGdOyJYLxJpTJCvo5gLNX8N
 g+pYPOsan/TDOLC80GOUWvCgsR3lptZ8Pwjg0f4eJ9IWu0yfYcXspRNCWt2J4M1/c6JF
 +IheeiBWP/z+kXoG3fJgTrwydqQasM05pZcguhqfbPyg2sLf3eOt3r5YeRR+BQmQP9Mf bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598cby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:06 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K2hrPc014361;
        Wed, 20 Jul 2022 03:00:06 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9598cax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:06 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K2o6i3008114;
        Wed, 20 Jul 2022 03:00:04 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3hbmy9f3ha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:04 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K303DL32440782
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:00:03 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7A12136053;
        Wed, 20 Jul 2022 03:00:03 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A077F136059;
        Wed, 20 Jul 2022 02:59:56 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.15.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 02:59:56 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v10 3/8] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Wed, 20 Jul 2022 08:29:15 +0530
Message-Id: <20220720025920.1373558-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: h8jquO0PXY5vgSZO0D5eDCWeDZAYq7iw
X-Proofpoint-ORIG-GUID: VFjEaa-UFAw1Ak6cWfSa5C6JOMAjoyHJ
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

If the new NUMA node onlined doesn't have a performance level assigned,
the kernel adds the NUMA node to default memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 75 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index ef380a39db3a..3d5f14d57ae6 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -14,6 +14,7 @@
 #define MEMTIER_PERF_LEVEL_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
 /* leave one tier below this slow pmem */
 #define MEMTIER_PERF_LEVEL_PMEM	(1 << MEMTIER_CHUNK_BITS)
+#define MEMTIER_HOTPLUG_PRIO	100
 
 extern bool numa_demotion_enabled;
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 41a21cc5ae55..cc3a47ec18e4 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/lockdep.h>
 #include <linux/moduleparam.h>
 #include <linux/node.h>
+#include <linux/memory.h>
 #include <linux/memory-tiers.h>
 
 struct memory_tier {
@@ -64,6 +65,78 @@ static struct memory_tier *find_create_memory_tier(unsigned int perf_level)
 	return new_memtier;
 }
 
+static struct memory_tier *__node_get_memory_tier(int node)
+{
+	struct memory_tier *memtier;
+
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (node_isset(node, memtier->nodelist))
+			return memtier;
+	}
+	return NULL;
+}
+
+static void init_node_memory_tier(int node)
+{
+	int perf_level;
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+
+	memtier = __node_get_memory_tier(node);
+	if (!memtier) {
+		perf_level = node_devices[node]->perf_level;
+		memtier = find_create_memory_tier(perf_level);
+		node_set(node, memtier->nodelist);
+	}
+	mutex_unlock(&memory_tier_lock);
+}
+
+static void clear_node_memory_tier(int node)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+	memtier = __node_get_memory_tier(node);
+	if (memtier)
+		node_clear(node, memtier->nodelist);
+	mutex_unlock(&memory_tier_lock);
+}
+
+/*
+ * This runs whether reclaim-based migration is enabled or not,
+ * which ensures that the user can turn reclaim-based migration
+ * at any time without needing to recalculate migration targets.
+ */
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *_arg)
+{
+	struct memory_notify *arg = _arg;
+
+	/*
+	 * Only update the node migration order when a node is
+	 * changing status, like online->offline.
+	 */
+	if (arg->status_change_nid < 0)
+		return notifier_from_errno(0);
+
+	switch (action) {
+	case MEM_OFFLINE:
+		clear_node_memory_tier(arg->status_change_nid);
+		break;
+	case MEM_ONLINE:
+		init_node_memory_tier(arg->status_change_nid);
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static void __init migrate_on_reclaim_init(void)
+{
+	hotplug_memory_notifier(migrate_on_reclaim_callback, MEMTIER_HOTPLUG_PRIO);
+}
+
 static int __init memory_tier_init(void)
 {
 	int node;
@@ -96,6 +169,8 @@ static int __init memory_tier_init(void)
 			node_property->perf_level = default_memtier_perf_level;
 	}
 	mutex_unlock(&memory_tier_lock);
+
+	migrate_on_reclaim_init();
 	return 0;
 }
 subsys_initcall(memory_tier_init);
-- 
2.36.1

