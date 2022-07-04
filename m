Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29EC564E69
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGDHJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbiGDHI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:08:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29323958F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:08:32 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26476HC6010034;
        Mon, 4 Jul 2022 07:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=yVE3XSpytCkYQ52S13vmXw5vKPuMgBybUJqrbPR+cPc=;
 b=CSa0Z4xm4/PK45aUXNYZ4BYCNrLUmrHpebghlKM3YAI9/PWi4Iy/UTB1uwV6Sx3Fv7Z7
 PrXYfCaTSIFXhh+cDs1MxaHEGXDPmo2bLcKy253OaPEqG1KlrQfcOVqBs4ILkt7miaX5
 Xcxq2+NhR85Kx9i585XNei8TRPrZJIs3/z/dIUA47R5n72/VvHhA9n5UNmhAQ4Ahfa8D
 aY7cLzjJ2Z22n0Zv6Pf6VRGgOdYagyjkUBJ5CUvSvvYIBj9Li10jZh/g+5u7ETfhtO5f
 s6qcGMk2pVQcce6HSNNrCCPxYXPOOtj4iopXSBlIbMO7r3l97h7oxgUM5uX3PM/sI5/o 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyhwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:22 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26478MAK027899;
        Mon, 4 Jul 2022 07:08:22 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3n2kyhw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:22 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26475Htp031799;
        Mon, 4 Jul 2022 07:08:20 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3h2dn8u52m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:20 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26478KKW36045160
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:08:20 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C5BE124054;
        Mon,  4 Jul 2022 07:08:20 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4873124053;
        Mon,  4 Jul 2022 07:08:13 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:08:13 +0000 (GMT)
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
Subject: [PATCH v8 06/12] mm/demotion: Expose memory tier details via sysfs
Date:   Mon,  4 Jul 2022 12:36:06 +0530
Message-Id: <20220704070612.299585-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t15EEGhTStporIZ46pRCd8UUhn2OP7ey
X-Proofpoint-ORIG-GUID: 5jJhGHHY6PJ8rPVZzOO5qwyitj-mfw0t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds /sys/devices/system/memtier/ where all memory tier
related details can be found. All created memory tiers will be
listed there as /sys/devices/system/memtier/memtierN/

The nodes which are part of a specific memory tier can be listed
via /sys/devices/system/memtier/memtierN/nodelist

/sys/devices/system/memtier/max_tier shows the max tier ID value
supported.

/sys/devices/system/memtier/default_tier shows the memory tier to which
NUMA nodes get added by default if not assigned a specific memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 93 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 87 insertions(+), 6 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 0596f0b11065..4acf7570ae1b 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -13,14 +13,15 @@
 
 struct memory_tier {
 	struct list_head list;
+	struct device dev;
 	nodemask_t nodelist;
-	int id;
 };
 
 struct demotion_nodes {
 	nodemask_t preferred;
 };
 
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
@@ -86,6 +87,42 @@ static LIST_HEAD(memory_tiers);
  */
 static struct demotion_nodes *node_demotion __read_mostly;
 
+static struct bus_type memory_tier_subsys = {
+	.name = "memtier",
+	.dev_name = "memtier",
+};
+
+static ssize_t nodelist_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	return sysfs_emit(buf, "%*pbl\n",
+			  nodemask_pr_args(&memtier->nodelist));
+}
+static DEVICE_ATTR_RO(nodelist);
+
+static struct attribute *memory_tier_dev_attrs[] = {
+	&dev_attr_nodelist.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_dev_group = {
+	.attrs = memory_tier_dev_attrs,
+};
+
+static const struct attribute_group *memory_tier_dev_groups[] = {
+	&memory_tier_dev_group,
+	NULL
+};
+
+static void memory_tier_device_release(struct device *dev)
+{
+	struct memory_tier *tier = to_memory_tier(dev);
+
+	kfree(tier);
+}
+
 static void insert_memory_tier(struct memory_tier *memtier)
 {
 	struct list_head *ent;
@@ -95,7 +132,7 @@ static void insert_memory_tier(struct memory_tier *memtier)
 
 	list_for_each(ent, &memory_tiers) {
 		tmp_memtier = list_entry(ent, struct memory_tier, list);
-		if (tmp_memtier->id < memtier->id) {
+		if (tmp_memtier->dev.id < memtier->dev.id) {
 			list_add_tail(&memtier->list, ent);
 			return;
 		}
@@ -105,6 +142,7 @@ static void insert_memory_tier(struct memory_tier *memtier)
 
 static struct memory_tier *register_memory_tier(unsigned int tier)
 {
+	int error;
 	struct memory_tier *memtier;
 
 	if (tier > MAX_MEMORY_TIER_ID)
@@ -114,17 +152,26 @@ static struct memory_tier *register_memory_tier(unsigned int tier)
 	if (!memtier)
 		return ERR_PTR(-ENOMEM);
 
-	memtier->id   = tier;
+	memtier->dev.id = tier;
+	memtier->dev.bus = &memory_tier_subsys;
+	memtier->dev.release = memory_tier_device_release;
+	memtier->dev.groups = memory_tier_dev_groups;
 
 	insert_memory_tier(memtier);
 
+	error = device_register(&memtier->dev);
+	if (error) {
+		list_del(&memtier->list);
+		put_device(&memtier->dev);
+		return ERR_PTR(error);
+	}
 	return memtier;
 }
 
 static void unregister_memory_tier(struct memory_tier *memtier)
 {
 	list_del(&memtier->list);
-	kfree(memtier);
+	device_unregister(&memtier->dev);
 }
 
 static struct memory_tier *__node_get_memory_tier(int node)
@@ -143,7 +190,7 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
 	struct memory_tier *memtier;
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
-		if (memtier->id == id)
+		if (memtier->dev.id == id)
 			return memtier;
 	}
 	return NULL;
@@ -181,7 +228,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 		goto out;
 	}
 
-	if (current_tier->id == tier)
+	if (current_tier->dev.id == tier)
 		goto out;
 
 	node_clear(node, current_tier->nodelist);
@@ -426,10 +473,44 @@ static void __init migrate_on_reclaim_init(void)
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
 }
 
+static ssize_t
+max_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIER_ID);
+}
+static DEVICE_ATTR_RO(max_tier);
+
+static ssize_t
+default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "memtier%d\n", default_memtier);
+}
+static DEVICE_ATTR_RO(default_tier);
+
+static struct attribute *memory_tier_attrs[] = {
+	&dev_attr_max_tier.attr,
+	&dev_attr_default_tier.attr,
+	NULL
+};
+
+static const struct attribute_group memory_tier_attr_group = {
+	.attrs = memory_tier_attrs,
+};
+
+static const struct attribute_group *memory_tier_attr_groups[] = {
+	&memory_tier_attr_group,
+	NULL,
+};
+
 static int __init memory_tier_init(void)
 {
+	int ret;
 	struct memory_tier *memtier;
 
+	ret = subsys_system_register(&memory_tier_subsys, memory_tier_attr_groups);
+	if (ret)
+		pr_err("%s() failed to register subsystem: %d\n", __func__, ret);
+
 	/*
 	 * Register only default memory tier to hide all empty
 	 * memory tier from sysfs. Since this is early during
-- 
2.36.1

