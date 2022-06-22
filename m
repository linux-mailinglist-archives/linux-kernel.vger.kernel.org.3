Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7E554862
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236755AbiFVI0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349141AbiFVI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727D538794
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:16 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M7Vlk5004726;
        Wed, 22 Jun 2022 08:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+PDy9N/grOL5ksV+lMfzpMQWbub5D2w8o7M+aMpzQxk=;
 b=MIVFYjpydaEgDECmS9+nhXbrDI3yXBQ/WDqGG+sz+Sxa7jPYAlCXxHrA3kyLrQB5TGst
 4MEM5/T+bfyRVJEDR137w1sc2ESf2hgl7UMEzX44uiVx9o4BDw9a7yKekCwdUUCeMO8Y
 9+Blgmz9wfACNyo/aIi0b4z+71kW6uLGZ9o7OGGezoq3+SttcTBY81X3fSR08lg8k0gH
 S+mK76275vQ9ZDcHTrf6g2AlHAcsmPOMvGrHhlmzHixuSTQijEvnCfiqul/QrBUKMG3Q
 pTR4XGT8ol8/GTWXDTITQDG44WUhKjoyLplTQkuO3fKjbMI1mXXyrq5sM1CmE3lN39IH fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxs5hdjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:53 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M7WE1P006111;
        Wed, 22 Jun 2022 08:25:53 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxs5hdje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:52 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8JxV7003300;
        Wed, 22 Jun 2022 08:25:51 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma02dal.us.ibm.com with ESMTP id 3gt0098r6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:51 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8Pow936438342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:25:50 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FFE76E053;
        Wed, 22 Jun 2022 08:25:50 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DE7B6E04E;
        Wed, 22 Jun 2022 08:25:45 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:25:44 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jagdish Gediya <jvgediya@linux.ibm.com>
Subject: [PATCH v7 03/12] mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
Date:   Wed, 22 Jun 2022 13:55:04 +0530
Message-Id: <20220622082513.467538-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bYd78G5jdARxa9bRQ2bhvt-dvDUIGiYy
X-Proofpoint-ORIG-GUID: bi9K2Ewvtx6cIE5FlH5NghdUw8JX-4nn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, all nodes are assigned to DEFAULT_MEMORY_TIER which
is the memory tier designated for nodes with DRAM

Set dax kmem device node's tier to MEMORY_TIER_PMEM. MEMORY_TIER_PMEM
appears below DEFAULT_MEMORY_TIER in demotion order.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c           |  6 ++-
 include/linux/memory-tiers.h |  5 +++
 mm/memory-tiers.c            | 79 ++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..0c03889286ac 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory-tiers.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -41,6 +42,9 @@ struct dax_kmem_data {
 	struct resource *res[];
 };
 
+static unsigned int dax_kmem_memtier = MEMORY_TIER_PMEM;
+module_param(dax_kmem_memtier, uint, 0644);
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
@@ -146,7 +150,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	}
 
 	dev_set_drvdata(dev, data);
-
+	node_create_and_set_memory_tier(numa_node, dax_kmem_memtier);
 	return 0;
 
 err_request_mem:
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c47dbe381089..9d36ff13c954 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -14,9 +14,14 @@
 #define MAX_MEMORY_TIER_ID	400
 
 extern bool numa_demotion_enabled;
+int node_create_and_set_memory_tier(int node, int tier);
 
 #else
 
 #define numa_demotion_enabled	false
+static inline int node_create_and_set_memory_tier(int node, int tier)
+{
+	return 0;
+}
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 2dcf70802661..fc404fcff7ff 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -51,6 +51,85 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
 	return memtier;
 }
 
+static void unregister_memory_tier(struct memory_tier *memtier)
+{
+	list_del(&memtier->list);
+	kfree(memtier);
+}
+
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
+static struct memory_tier *__get_memory_tier_from_id(int id)
+{
+	struct memory_tier *memtier;
+
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (memtier->id == id)
+			return memtier;
+	}
+	return NULL;
+}
+
+static int __node_create_and_set_memory_tier(int node, int tier)
+{
+	int ret = 0;
+	struct memory_tier *memtier;
+
+	memtier = __get_memory_tier_from_id(tier);
+	if (!memtier) {
+		memtier = register_memory_tier(tier);
+		if (IS_ERR(memtier)) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	node_set(node, memtier->nodelist);
+out:
+	return ret;
+}
+
+int node_create_and_set_memory_tier(int node, int tier)
+{
+	struct memory_tier *current_tier;
+	int ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+
+	current_tier = __node_get_memory_tier(node);
+	if (!current_tier) {
+		ret = __node_create_and_set_memory_tier(node, tier);
+		goto out;
+	}
+
+	if (current_tier->id == tier)
+		goto out;
+
+	node_clear(node, current_tier->nodelist);
+
+	ret = __node_create_and_set_memory_tier(node, tier);
+	if (ret) {
+		/* reset it back to older tier */
+		node_set(node, current_tier->nodelist);
+		goto out;
+	}
+	if (nodes_empty(current_tier->nodelist))
+		unregister_memory_tier(current_tier);
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
+
 static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
 core_param(default_memory_tier, default_memtier, uint, 0644);
 
-- 
2.36.1

