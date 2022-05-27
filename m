Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD375362BB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbiE0Mkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351334AbiE0Mjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:53 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F76622D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:26:55 -0700 (PDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RBMwkb031744;
        Fri, 27 May 2022 12:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Fh5UEeLMRf9EalXd/ZXawnSYAxXK72SmlA1AxC/jnKQ=;
 b=SFxbpfsA36+1KJnWb5Oq/sT1yblIVxYRYJbkEc04sgQmxc4nKdIk15O/tGdS2a8YPYTL
 7RfAwv3iVeyCS5IdVAjYBjVnKm2bZOv8mCaI0u5UOD6jLbES+hGKj4MyFgYMutR3Pr02
 60kH/Zwwct9CnngQglrrQfTqQVmxEbGfsD271sdaNBlrqb1HlD9PwEYLd78z6R9xIKhX
 ySsiUvOwak0L+rFE0HaTcyvlLmATq3LCSq7qvxhxM2N9PclL5VgDMFLksvHwXLsr6W+S
 eazzhGIgEGS0ZHeavZPoSErTwuq+eBIxduP0ohZwaN9K7x4RpSv2UoCZOLoEy54CtEOB Rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gawqkh2dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:42 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RCHRN3007895;
        Fri, 27 May 2022 12:26:41 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gawqkh2bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:41 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCKrWQ006323;
        Fri, 27 May 2022 12:26:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3gagpkvfht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:26:39 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCQcsh62849384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:26:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B8FCAE05F;
        Fri, 27 May 2022 12:26:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA8AAE05C;
        Fri, 27 May 2022 12:26:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:26:31 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH v4 2/7] mm/demotion: Expose per node memory tier to sysfs
Date:   Fri, 27 May 2022 17:55:23 +0530
Message-Id: <20220527122528.129445-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ThGXRwmPJYT5png8VQtIpgnBlOi_4uEG
X-Proofpoint-GUID: j9QyA_In8oQWT8ZqeyLEGRg3tUQl6tqQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270057
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagdish Gediya <jvgediya@linux.ibm.com>

Add support to read/write the memory tierindex for a NUMA node.

/sys/devices/system/node/nodeN/memtier

where N = node id

When read, It list the memory tier that the node belongs to.

When written, the kernel moves the node into the specified
memory tier, the tier assignment of all other nodes are not
affected.

If the memory tier does not exist, writing to the above file
create the tier and assign the NUMA node to that tier.

mutex memory_tier_lock is introduced to protect memory tier
related chanegs as it can happen from sysfs as well on hot
plug events.

Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c     |  35 ++++++++++++++
 include/linux/migrate.h |   4 +-
 mm/migrate.c            | 103 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index ec8bb24a5a22..cf4a58446d8c 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/migrate.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -560,11 +561,45 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+#ifdef CONFIG_TIERED_MEMORY
+static ssize_t memtier_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	int node = dev->id;
+
+	return sysfs_emit(buf, "%d\n", node_get_memory_tier(node));
+}
+
+static ssize_t memtier_store(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf, size_t count)
+{
+	unsigned long tier;
+	int node = dev->id;
+
+	int ret = kstrtoul(buf, 10, &tier);
+	if (ret)
+		return ret;
+
+	ret = node_reset_memory_tier(node, tier);
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
+#ifdef CONFIG_TIERED_MEMORY
+	&dev_attr_memtier.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 0ec653623565..d37d1d5dee82 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -177,13 +177,15 @@ enum memory_tier_type {
 };
 
 int next_demotion_node(int node);
-
 extern void migrate_on_reclaim_init(void);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void set_migration_target_nodes(void);
 #else
 static inline void set_migration_target_nodes(void) {}
 #endif
+int node_get_memory_tier(int node);
+int node_set_memory_tier(int node, int tier);
+int node_reset_memory_tier(int node, int tier);
 #else
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
diff --git a/mm/migrate.c b/mm/migrate.c
index f28ee93fb017..304559ba3372 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2132,6 +2132,7 @@ static struct bus_type memory_tier_subsys = {
 	.dev_name = "memtier",
 };
 
+DEFINE_MUTEX(memory_tier_lock);
 static struct memory_tier *memory_tiers[MAX_MEMORY_TIERS];
 
 static ssize_t nodelist_show(struct device *dev,
@@ -2225,6 +2226,108 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
 	NULL,
 };
 
+static int __node_get_memory_tier(int node)
+{
+	int tier;
+
+	for (tier = 0; tier < MAX_MEMORY_TIERS; tier++) {
+		if (memory_tiers[tier] && node_isset(node, memory_tiers[tier]->nodelist))
+			return tier;
+	}
+
+	return -1;
+}
+
+int node_get_memory_tier(int node)
+{
+	int tier;
+
+	/*
+	 * Make sure memory tier is not unregistered
+	 * while it is being read.
+	 */
+	mutex_lock(&memory_tier_lock);
+
+	tier = __node_get_memory_tier(node);
+
+	mutex_unlock(&memory_tier_lock);
+
+	return tier;
+}
+
+int __node_set_memory_tier(int node, int tier)
+{
+	int ret = 0;
+	/*
+	 * As register_memory_tier() for new tier can fail,
+	 * try it before modifying existing tier. register
+	 * tier makes tier visible in sysfs.
+	 */
+	if (!memory_tiers[tier]) {
+		ret = register_memory_tier(tier);
+		if (ret) {
+			goto out;
+		}
+	}
+
+	node_set(node, memory_tiers[tier]->nodelist);
+
+out:
+	return ret;
+}
+
+int node_reset_memory_tier(int node, int tier)
+{
+	int current_tier, ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+
+	current_tier = __node_get_memory_tier(node);
+	if (current_tier == tier)
+		goto out;
+
+	if (current_tier != -1 )
+		node_clear(node, memory_tiers[current_tier]->nodelist);
+
+	ret = __node_set_memory_tier(node, tier);
+
+	if (!ret) {
+		if (nodes_empty(memory_tiers[current_tier]->nodelist))
+			unregister_memory_tier(current_tier);
+	} else {
+		/* reset it back to older tier */
+		ret = __node_set_memory_tier(node, current_tier);
+	}
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
+int node_set_memory_tier(int node, int tier)
+{
+	int current_tier, ret = 0;
+
+	if (tier >= MAX_MEMORY_TIERS)
+		return -EINVAL;
+
+	mutex_lock(&memory_tier_lock);
+	current_tier = __node_get_memory_tier(node);
+	/*
+	 * if node is already part of the tier proceed with the
+	 * current tier value, because we might want to establish
+	 * new migration paths now. The node might be added to a tier
+	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
+	 * will have skipped this node.
+	 */
+	if (current_tier != -1)
+		tier = current_tier;
+	ret = __node_set_memory_tier(node, tier);
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
 /*
  * node_demotion[] example:
  *
-- 
2.36.1

