Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C5955478F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352116AbiFVI1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350140AbiFVI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292538795
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:36 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M87Ns6005522;
        Wed, 22 Jun 2022 08:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bUKtfnF5lp5n6saH/VnpP793cWjuWytUL0WlkyT0+FI=;
 b=PZf1B45LzunNfHXChAdQFqx1ipoQmMvJ+cGMaCoEeaP0EUsrxllI4HpqtwehgEa28JNf
 kxIEq9XyksmlMDM89cKbb30YuNXVrCPClrwP3J5BBBWKt9hSUgtXnb7JyPn/ubSqTwaZ
 Obgq3bWhklyw8DISTt+YN/3vKoU5NrztiXPdY6anqCnb0ItQshfrkBtKfINKkVkUxjoL
 SChu8E5ROo5eSqg0CqIinNEiI+OYf8dTEM4eqXoVZJhmy1uxreiG4LZM58IoFdtYmEJD
 fQR7DflaKMlwHJPACBHBSMMqHuy7Dj8RHOWXKjMo/fWySpwymemMndHU55wSblG/7+NP eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxfs1paw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:21 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M87rVO009673;
        Wed, 22 Jun 2022 08:26:20 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxfs1p9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:20 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8LYXR009059;
        Wed, 22 Jun 2022 08:26:16 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02wdc.us.ibm.com with ESMTP id 3gs6ba9b86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:26:16 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8QFet31654154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:26:15 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A35416E052;
        Wed, 22 Jun 2022 08:26:15 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B08D36E04E;
        Wed, 22 Jun 2022 08:26:09 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:26:09 +0000 (GMT)
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
Subject: [PATCH v7 07/12] mm/demotion: Add per node memory tier attribute to sysfs
Date:   Wed, 22 Jun 2022 13:55:08 +0530
Message-Id: <20220622082513.467538-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0YdBwUUsaz4ZRLw-J9z8Uzn5kDBksQdl
X-Proofpoint-GUID: 8_fWbKy7kZW7cxuAx2OFLGe300MdV-vJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to modify the memory tier for a NUMA node.

/sys/devices/system/node/nodeN/memtier

where N = node id

When read, It list the memory tier that the node belongs to.

When written, the kernel moves the node into the specified
memory tier, the tier assignment of all other nodes are not
affected.

If the memory tier does not exist, it is created.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c          | 42 ++++++++++++++++++++++++++++++++++++
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..667f37eecf3a 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/memory-tiers.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -560,11 +561,52 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+#ifdef CONFIG_NUMA
+static ssize_t memtier_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	int node = dev->id;
+	int tier_index = node_get_memory_tier_id(node);
+
+	/*
+	 * CPU only NUMA node is not part of memory tiers.
+	 */
+	if (tier_index != -1)
+		return sysfs_emit(buf, "%d\n", tier_index);
+	return 0;
+}
+
+static ssize_t memtier_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned long tier;
+	int node = dev->id;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &tier);
+	if (ret)
+		return ret;
+
+	ret = node_update_memory_tier(node, tier);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(memtier);
+#endif
+
 static struct attribute *node_dev_attrs[] = {
 	&dev_attr_meminfo.attr,
 	&dev_attr_numastat.attr,
 	&dev_attr_distance.attr,
 	&dev_attr_vmstat.attr,
+#ifdef CONFIG_NUMA
+	&dev_attr_memtier.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 3234301c2537..453f6e5d357c 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -23,6 +23,8 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }
 #endif
+int node_get_memory_tier_id(int node);
+int node_update_memory_tier(int node, int tier);
 
 #else
 
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 4acf7570ae1b..b7cb368cb9c0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -288,6 +288,48 @@ static int node_set_memory_tier(int node, int tier)
 	return ret;
 }
 
+int node_get_memory_tier_id(int node)
+{
+	int tier = -1;
+	struct memory_tier *memtier;
+	/*
+	 * Make sure memory tier is not unregistered
+	 * while it is being read.
+	 */
+	mutex_lock(&memory_tier_lock);
+	memtier = __node_get_memory_tier(node);
+	if (memtier)
+		tier = memtier->dev.id;
+	mutex_unlock(&memory_tier_lock);
+
+	return tier;
+}
+
+int node_update_memory_tier(int node, int tier)
+{
+	struct memory_tier *current_tier;
+	int ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+
+	current_tier = __node_get_memory_tier(node);
+	if (!current_tier || current_tier->dev.id == tier)
+		goto out;
+
+	node_clear(node, current_tier->nodelist);
+
+	ret = __node_create_and_set_memory_tier(node, tier);
+
+	if (nodes_empty(current_tier->nodelist))
+		unregister_memory_tier(current_tier);
+
+	establish_migration_targets();
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
 #ifdef CONFIG_MIGRATION
 /**
  * next_demotion_node() - Get the next node in the demotion path
-- 
2.36.1

