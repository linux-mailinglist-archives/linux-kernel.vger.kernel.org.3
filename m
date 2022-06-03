Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE10B53CACD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbiFCNn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244747AbiFCNny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:43:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D15339806
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:43:51 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253DUkP8016766;
        Fri, 3 Jun 2022 13:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=K1VdzzCOxCgpv74NdzVcO4YxHjbdKq+GNt2rMe64fVs=;
 b=EmGsS21hZwH1jPIIYT7eBSKfIkOvpy/S/1/Y8s6hZUYqmgds/pmV44LbXZWnbWaVKLvE
 M1ZKxuV/qRpb3hVbZb/KIGzzCRy8cT00hDPsftf9NPZpEPRel9SHjdGdnEYCdREaetDc
 +1W45wLwozoie8/t++XBSFKITl6jbsVlit+HJ19knad1Mga3xtg45lTqJazICpAlHBOX
 1u9pplOM3sjWCCx1PczCyBB9fy1JVh2pFz+X3FF046jYJ4HvFlkwY1qCQvFzGNdWUs9o
 3n1sNjOs6GoODPIinVezuBPG62E4Rtgb0UcDX21CsjZak7aYwki6Bajp14c8tf5+y4Xi LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk8h08wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:35 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253DUpN3016953;
        Fri, 3 Jun 2022 13:43:35 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfk8h08wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:35 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253Da8S9005529;
        Fri, 3 Jun 2022 13:43:34 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3gcxt62ygh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:43:34 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253DhXAi31850762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:43:33 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F0BBE112064;
        Fri,  3 Jun 2022 13:43:32 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B677112063;
        Fri,  3 Jun 2022 13:43:25 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:43:24 +0000 (GMT)
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
Subject: [PATCH v5 2/9] mm/demotion: Expose per node memory tier to sysfs
Date:   Fri,  3 Jun 2022 19:12:30 +0530
Message-Id: <20220603134237.131362-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: w-kEa5wmFAHsGWYIrUkC23cIWnbXumAg
X-Proofpoint-ORIG-GUID: z_canjlGlQrqFBIESd2oOLNFbxerRxsS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
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

If the memory tier does not exist, writing to the above file
creates the tier and assign the NUMA node to that tier.

mutex memory_tier_lock is introduced to protect memory tier
related chanegs as it can happen from sysfs as well on hot
plug events.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c          |  39 +++++++++++
 include/linux/memory-tiers.h |   3 +
 mm/memory-tiers.c            | 123 ++++++++++++++++++++++++++++++++++-
 3 files changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 0ac6376ef7a1..599ed64d910f 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/swap.h>
 #include <linux/slab.h>
+#include <linux/memory-tiers.h>
 
 static struct bus_type node_subsys = {
 	.name = "node",
@@ -560,11 +561,49 @@ static ssize_t node_read_distance(struct device *dev,
 }
 static DEVICE_ATTR(distance, 0444, node_read_distance, NULL);
 
+#ifdef CONFIG_TIERED_MEMORY
+static ssize_t memtier_show(struct device *dev,
+			    struct device_attribute *attr,
+			    char *buf)
+{
+	int node = dev->id;
+	int tier_index = node_get_memory_tier_id(node);
+
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
 
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index e17f6b4ee177..91f071804476 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -15,6 +15,9 @@
 #define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
 #define MAX_MEMORY_TIERS  3
 
+int node_get_memory_tier_id(int node);
+int node_set_memory_tier(int node, int tier);
+int node_reset_memory_tier(int node, int tier);
 #endif	/* CONFIG_TIERED_MEMORY */
 
 #endif
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 7de18d94a08d..9c78c47ad030 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -126,7 +126,6 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
 	return memtier;
 }
 
-__maybe_unused // temporay to prevent warnings during bisects
 static void unregister_memory_tier(struct memory_tier *memtier)
 {
 	list_del(&memtier->list);
@@ -162,6 +161,128 @@ static const struct attribute_group *memory_tier_attr_groups[] = {
 	NULL,
 };
 
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
+		if (memtier->dev.id == id)
+			return memtier;
+	}
+	return NULL;
+}
+
+__maybe_unused // temporay to prevent warnings during bisects
+static void node_remove_from_memory_tier(int node)
+{
+	struct memory_tier *memtier;
+
+	mutex_lock(&memory_tier_lock);
+
+	memtier = __node_get_memory_tier(node);
+	if (!memtier)
+		goto out;
+	/*
+	 * Remove node from tier, if tier becomes
+	 * empty then unregister it to make it invisible
+	 * in sysfs.
+	 */
+	node_clear(node, memtier->nodelist);
+	if (nodes_empty(memtier->nodelist))
+		unregister_memory_tier(memtier);
+
+out:
+	mutex_unlock(&memory_tier_lock);
+}
+
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
+static int __node_set_memory_tier(int node, int tier)
+{
+	int ret = 0;
+	struct memory_tier *memtier;
+
+	memtier = __get_memory_tier_from_id(tier);
+	if (!memtier) {
+		memtier = register_memory_tier(tier);
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
+int node_reset_memory_tier(int node, int tier)
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
+	ret = __node_set_memory_tier(node, tier);
+	if (ret) {
+		/* reset it back to older tier */
+		node_set(node, current_tier->nodelist);
+		goto out;
+	}
+
+	if (nodes_empty(current_tier->nodelist))
+		unregister_memory_tier(current_tier);
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
+int node_set_memory_tier(int node, int tier)
+{
+	struct memory_tier *memtier;
+	int ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+	memtier = __node_get_memory_tier(node);
+	if (!memtier)
+		ret = __node_set_memory_tier(node, tier);
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
 static int __init memory_tier_init(void)
 {
 	int ret;
-- 
2.36.1

