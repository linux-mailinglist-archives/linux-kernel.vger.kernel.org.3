Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1C564E63
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiGDHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233132AbiGDHJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:09:07 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E97A445
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:08:45 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2646Lv1w021158;
        Mon, 4 Jul 2022 07:08:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bUKtfnF5lp5n6saH/VnpP793cWjuWytUL0WlkyT0+FI=;
 b=KPrDzA4I9odNsEc1Xai0mj5c+XdP9lCGFvxtQDtSGfokHBAsdR/mOgOD7hMbPS5wjiuk
 a9GdtaecKLb2vWbPc92h+vyYDhEc55EBjAxc4zQfcg0UjhGnwFb+BWPaYbx64w3RzVBu
 bbqhF3sWIUMZx5g/MnqPulA2wM9nbg6BcOZAHAgZ2hMYYB8xk84IA+wMK85vukZO+FWk
 JQD4KpnIORLJN5TmIjWk4pgMH0Foic4sIoC/jXgzC2mugVY+JNMFDq386YtKNl9JWtcw
 mvfEMQ2OQut0utvsNkGFiR3KW5+5FgTpPc5ScmMLGA4jHDtKfo+791GukZLSfTUcB7+v HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3tva10xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:30 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646jZ3I028460;
        Mon, 4 Jul 2022 07:08:30 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3tva10xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:30 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26476Vpd001017;
        Mon, 4 Jul 2022 07:08:29 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3h2dn9haam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:29 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26478SwS25493806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:08:28 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E84AC124066;
        Mon,  4 Jul 2022 07:08:27 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12592124054;
        Mon,  4 Jul 2022 07:08:21 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:08:20 +0000 (GMT)
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
Subject: [PATCH v8 07/12] mm/demotion: Add per node memory tier attribute to sysfs
Date:   Mon,  4 Jul 2022 12:36:07 +0530
Message-Id: <20220704070612.299585-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aOEW1KYLC8uCLmkP_4ZdQzfdNl6ASTLn
X-Proofpoint-ORIG-GUID: U3SypYztW-2nITouAoURAKEE9FyUUbUc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
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

