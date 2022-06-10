Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C42E5467C5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349432AbiFJNye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349275AbiFJNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:00 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3744F3F33D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:53:50 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AD7h80030097;
        Fri, 10 Jun 2022 13:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cr7oU8eRYwQT2y9i+Jcicbl+Lj5x+BxH7cJX0SuAD4g=;
 b=Ex0ifdz0s8jre+ogcBMoRlKpJAR3C8TRsLQ09FpbvhvfLZkyFbcosU8BLxbedfh6nBwj
 ukU4vMpWPKyVKh0VFAnAnTiLsLDG2eteTrLVcCxA2zsT1SnIomKWx8z5BLDLtvOmhIRS
 +HYVKvVe+8Zh5ZNZLFBLprAH7A6ufvRgjJj//1R6B9ECb2qAJcfKiiZWzP3HqQ+mAIje
 FWTGmM16KvD+gn4aauk0QPjP/ZmRvkUANylMJXS4VdYL41KtGfU2cazLuEYuoe0+orwL
 fN3/EuN4xrD2tWRJb8pCNyenIJdLKnEjCiEZI4m7wuSjB4lBiHnChu4LxOhN4NUlTOwQ DA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm4vaaxpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:28 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADNxk4029470;
        Fri, 10 Jun 2022 13:53:27 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm4vaaxpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:27 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZTm8014175;
        Fri, 10 Jun 2022 13:53:26 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3gfy1bb4he-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:26 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADrPU328246490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:53:25 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A656A047;
        Fri, 10 Jun 2022 13:53:25 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A86206A04D;
        Fri, 10 Jun 2022 13:53:16 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:53:16 +0000 (GMT)
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
Subject: [PATCH v6 04/13] mm/demotion/dax/kmem: Set node's memory tier to MEMORY_TIER_PMEM
Date:   Fri, 10 Jun 2022 19:22:20 +0530
Message-Id: <20220610135229.182859-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1I7VJeRFTIOzEt8THFTv0rHuFQF9BBsv
X-Proofpoint-GUID: 6rZIckOcuaQhy2dYIT0FVzzTXQjG5Xnm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
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
is assigned a default rank value of 100 and appears below DEFAULT_MEMORY_TIER
in demotion order.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/dax/kmem.c           |  4 ++
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 78 ++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index a37622060fff..0cb3de3d138f 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
+#include <linux/memory-tiers.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -147,6 +148,9 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 
 	dev_set_drvdata(dev, data);
 
+#ifdef CONFIG_TIERED_MEMORY
+	node_create_and_set_memory_tier(numa_node, MEMORY_TIER_PMEM);
+#endif
 	return 0;
 
 err_request_mem:
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 44c3c3b16a36..e102ec73ab80 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -18,6 +18,7 @@
 #define MAX_MEMORY_TIERS  3
 
 extern bool numa_demotion_enabled;
+int node_create_and_set_memory_tier(int node, int tier);
 #else
 #define numa_demotion_enabled	false
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c3123a457d90..00d393a5a628 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -67,6 +67,84 @@ static struct memory_tier *register_memory_tier(unsigned int tier,
 	return memtier;
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
+		int rank;
+
+		rank = get_rank_from_tier(tier);
+		if (rank == -1) {
+			ret = -EINVAL;
+			goto out;
+		}
+		memtier = register_memory_tier(tier, rank);
+		if (!memtier) {
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
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
+
 static int __init memory_tier_init(void)
 {
 	struct memory_tier *memtier;
-- 
2.36.1

