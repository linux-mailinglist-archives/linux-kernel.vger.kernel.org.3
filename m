Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F92B58467D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiG1TFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiG1TFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:05:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F24A371BB
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:05:29 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIqXCu032622;
        Thu, 28 Jul 2022 19:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lFenJdsVELNWeajF2epdtoWy5bSL9jInArYw6QYM9Rc=;
 b=siMfNBHbU0L8W3O0l3aNeqfenbmGUr9Q1LDaGIFLYYfP2qKvEZ3x6EuHY0RSSQBSD6sp
 jbxN+I8ap/g/P9NHUgtiJ7KICwbIm4sAlTGJjDIq2FCfWu272HO/+cg5vhM6/7XKygEb
 7V3Kv0P9E1Hx9zrxgmGCuCRfhv8q+PP3Yqagph01Z7pUy840q35NI7zt25gcT2olV5KM
 /F1fDgHjlAngtVORZbRxN9gJyVuBcthDAC43OPXbvs9PCQM2144ARRZMQLYitwb2tHf4
 OZgSOZpsCDNLYyHDy7+OrB16e1Hn45T/cwUWjkU+fhhChr902KdOwxZMsIgblPF3R7pD wg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm04c0brc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:15 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SIr2eC035826;
        Thu, 28 Jul 2022 19:05:15 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm04c0bqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:15 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ2VAk017301;
        Thu, 28 Jul 2022 19:05:14 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 3hg94b196e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:14 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ5DXf36962772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:13 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C59C6A057;
        Thu, 28 Jul 2022 19:05:13 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD3856A047;
        Thu, 28 Jul 2022 19:05:07 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:05:07 +0000 (GMT)
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
Subject: [PATCH v11 3/8] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Fri, 29 Jul 2022 00:34:31 +0530
Message-Id: <20220728190436.858458-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: r1htYXv7501eBYj7l7SnioIOfDv-vXHi
X-Proofpoint-GUID: Nat__jd6zEOrK0m-YntgAhvHpM2kA7gg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the new NUMA node onlined doesn't have a abstract distance assigned,
the kernel adds the NUMA node to default memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 83 ++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index b85901c0caba..976f43a5e3be 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -13,6 +13,7 @@
 #define MEMTIER_ADISTANCE_DRAM	(1 << (MEMTIER_CHUNK_BITS + 2))
 /* leave one tier below this slow pmem */
 #define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
+#define MEMTIER_HOTPLUG_PRIO	100
 
 #ifdef CONFIG_NUMA
 #include <linux/types.h>
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 03e43f3dc942..c9854a394d9b 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -3,6 +3,7 @@
 #include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
+#include <linux/memory.h>
 #include <linux/memory-tiers.h>
 
 struct memory_tier {
@@ -83,6 +84,87 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 	return new_memtier;
 }
 
+static struct memory_tier *__node_get_memory_tier(int node)
+{
+	struct memory_dev_type *memtype;
+
+	memtype = node_memory_types[node];
+	if (memtype)
+		return memtype->memtier;
+	return NULL;
+}
+
+static void init_node_memory_tier(int node)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+
+	memtier = __node_get_memory_tier(node);
+	if (!memtier) {
+		struct memory_dev_type *memtype;
+
+		if (!node_memory_types[node]) {
+			node_memory_types[node] = &default_dram_type;
+			node_set(node, default_dram_type.nodes);
+		}
+		memtype = node_memory_types[node];
+		memtier = find_create_memory_tier(memtype);
+	}
+	mutex_unlock(&memory_tier_lock);
+}
+
+static void destroy_memory_tier(struct memory_tier *memtier)
+{
+	list_del(&memtier->list);
+	kfree(memtier);
+}
+
+static void clear_node_memory_tier(int node)
+{
+	struct memory_tier *current_memtier;
+
+	mutex_lock(&memory_tier_lock);
+	current_memtier = __node_get_memory_tier(node);
+	if (current_memtier) {
+		struct memory_dev_type *memtype;
+
+		memtype = node_memory_types[node];
+		node_clear(node, memtype->nodes);
+		if (nodes_empty(memtype->nodes)) {
+			list_del(&memtype->tier_sibiling);
+			memtype->memtier = NULL;
+			if (list_empty(&current_memtier->memory_types))
+				destroy_memory_tier(current_memtier);
+		}
+	}
+	mutex_unlock(&memory_tier_lock);
+}
+
+static int __meminit memtier_hotplug_callback(struct notifier_block *self,
+					      unsigned long action, void *_arg)
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
 static int __init memory_tier_init(void)
 {
 	struct memory_tier *memtier;
@@ -97,6 +179,7 @@ static int __init memory_tier_init(void)
 		      __func__, PTR_ERR(memtier));
 	mutex_unlock(&memory_tier_lock);
 
+	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRIO);
 	return 0;
 }
 subsys_initcall(memory_tier_init);
-- 
2.37.1

