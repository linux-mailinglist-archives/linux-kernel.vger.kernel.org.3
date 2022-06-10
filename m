Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689305467D2
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349358AbiFJN4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiFJNzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:55:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377EB12FB21
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:54:58 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADDjen032541;
        Fri, 10 Jun 2022 13:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=E8x/yh96TqC956iIz99rLchksQSqqOP2r9I9Ns2lU6U=;
 b=taKkK7F75PuCp32ofRyxChUYraLZW1q4rwICekYwVPCe/LIf3qhw94TNygI+SMbSqLyn
 msOiPC/wyHACvZFYBTV3GnLE2YWOnihQqvXMquJM0ZZ5x6SmovjyeAqO5nPn45/uCPui
 VX9zOAPvOEEi2KYRGQiWose6qmT6HGEYlw6VsYbaU2+NDU3MhSkTQx+I4C14X3fsINc0
 gCGuLstWKMPRjeaK44KoRYiZYvjHamuEHib5S/E19x46QNlEgJ4iPgFtVxhbzmF/E1oB
 4Oy+zYt3MdFiFBDGVPV+8JCibHCdJHbSHBuyu1bPrcFI5byeCU+RCF8CtzVoBo+x6nXM CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6na0s6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:04 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADEZZr002211;
        Fri, 10 Jun 2022 13:54:04 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6na0s6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:04 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZRnF004832;
        Fri, 10 Jun 2022 13:54:03 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04wdc.us.ibm.com with ESMTP id 3gfy1a91y2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:54:03 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADs2SQ39059824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:54:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9BE6A047;
        Fri, 10 Jun 2022 13:54:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E6DB66A054;
        Fri, 10 Jun 2022 13:53:53 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:53:53 +0000 (GMT)
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
Subject: [PATCH v6 08/13] mm/demotion: Add support for memory tier creation from userspace
Date:   Fri, 10 Jun 2022 19:22:24 +0530
Message-Id: <20220610135229.182859-9-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9V-4J5ghCf3E5erXmEax8vOzO2KdxVXG
X-Proofpoint-ORIG-GUID: lmUY9NtnGV2mAsJ6OWZHXEZ55nrrCO5M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206100056
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to create memory tiers with specific rank
value from userspace. To avoid race while creating memory tiers
/sys/devices/system/memtier/create_tier_from_rank file is provided.
Writing to this file with a specific rank value creates a new memory
tier with the specified rank value.

Memory tiers created from userspace gets destroyed when the memory
tier nodelist becomes empty.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  3 +-
 mm/memory-tiers.c            | 74 ++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index e70f0040d845..52896f5970b7 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -15,7 +15,8 @@
 #define MEMORY_RANK_PMEM	100
 
 #define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
-#define MAX_MEMORY_TIERS  3
+#define MAX_STATIC_MEMORY_TIERS  3
+#define MAX_MEMORY_TIERS  (MAX_STATIC_MEMORY_TIERS + 2)
 
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7bfdfac4d43e..de3b7403ae6f 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -6,6 +6,7 @@
 #include <linux/memory-tiers.h>
 #include <linux/random.h>
 #include <linux/memory.h>
+#include <linux/idr.h>
 
 #include "internal.h"
 
@@ -126,9 +127,12 @@ static const struct attribute_group *memory_tier_dev_groups[] = {
 	NULL
 };
 
+static DEFINE_IDA(memtier_dev_id);
 static void memory_tier_device_release(struct device *dev)
 {
 	struct memory_tier *tier = to_memory_tier(dev);
+	if (tier->dev.id >= MAX_STATIC_MEMORY_TIERS)
+		ida_free(&memtier_dev_id, tier->dev.id);
 
 	kfree(tier);
 }
@@ -195,6 +199,17 @@ static struct memory_tier *register_memory_tier(unsigned int tier,
 	return memtier;
 }
 
+static void unregister_memory_tier(struct memory_tier *memtier)
+{
+	/*
+	 * Don't destroy static memory tiers.
+	 */
+	if (memtier->dev.id < MAX_STATIC_MEMORY_TIERS)
+		return;
+	list_del(&memtier->list);
+	device_unregister(&memtier->dev);
+}
+
 static struct memory_tier *__node_get_memory_tier(int node)
 {
 	struct memory_tier *memtier;
@@ -267,6 +282,10 @@ int node_create_and_set_memory_tier(int node, int tier)
 		node_set(node, current_tier->nodelist);
 		goto out;
 	}
+
+	if (nodes_empty(current_tier->nodelist))
+		unregister_memory_tier(current_tier);
+
 	establish_migration_targets();
 out:
 	mutex_unlock(&memory_tier_lock);
@@ -350,6 +369,9 @@ int node_reset_memory_tier(int node, int tier)
 		goto out;
 	}
 
+	if (nodes_empty(current_tier->nodelist))
+		unregister_memory_tier(current_tier);
+
 	establish_migration_targets();
 out:
 	mutex_unlock(&memory_tier_lock);
@@ -550,9 +572,61 @@ default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
 }
 static DEVICE_ATTR_RO(default_tier);
 
+static inline int memtier_alloc_id(void)
+{
+	return ida_alloc_range(&memtier_dev_id,
+			       MAX_STATIC_MEMORY_TIERS,
+			       MAX_MEMORY_TIERS - 1, GFP_KERNEL);
+}
+
+static ssize_t create_tier_from_rank_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf, size_t count)
+{
+	int ret, tier, rank;
+	struct memory_tier *memtier;
+
+	ret = kstrtouint(buf, 10, &rank);
+	if (ret)
+		return ret;
+
+	if (rank == MEMORY_RANK_HBM_GPU ||
+	    rank == MEMORY_RANK_DRAM ||
+	    rank == MEMORY_RANK_PMEM)
+		return -EINVAL;
+
+	mutex_lock(&memory_tier_lock);
+	/*
+	 * We don't support multiple tiers with same rank value
+	 */
+	list_for_each_entry(memtier, &memory_tiers, list) {
+		if (memtier->rank == rank) {
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	tier = memtier_alloc_id();
+	if (tier < 0) {
+		ret = -ENOSPC;
+		goto out;
+	}
+	memtier = register_memory_tier(tier, rank);
+	if (IS_ERR(memtier)) {
+		ret = PTR_ERR(memtier);
+		goto out;
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&memory_tier_lock);
+	return ret;
+}
+static DEVICE_ATTR_WO(create_tier_from_rank);
+
 static struct attribute *memory_tier_attrs[] = {
 	&dev_attr_max_tier.attr,
 	&dev_attr_default_tier.attr,
+	&dev_attr_create_tier_from_rank.attr,
 	NULL
 };
 
-- 
2.36.1

