Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3587F5467CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbiFJNzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349363AbiFJNyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C88B47544
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:54:10 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25ADSwk9014931;
        Fri, 10 Jun 2022 13:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=dDKqIfopwnXr6PuIPbN3tqtguXFEUdVD0LR6XZqxlbc=;
 b=HRuYDjZWC2cApnGXqBLPUfqa3acVvk4qqme9jQ8OSf1H5uG9RzC4TBnq+uztPvPn9sUR
 wF8J3/RL29LKfj0lLlR6f6d3H7WuofL4lRgA37XylIzAugGhDDEqwygZspFQV5JSsDIh
 /xobRaH+brGwSKVsaY89vbnmb+/wkGbjAeyr/1lsfg3ogakAn04DFGBfqy0ArRHJ6PmL
 qKJouoENkp0Jpg+qCPA1ucdNNrUPne8YQUo3YxGzRjActvj6HAlEFLLzSma9ONxhAC9k
 SksTSzRDcyZ7yl+ONeTfKlDNtCAcuO11WyxYZvxwP4LVRBbnhwALM89SSwjFgzitR1AM 5Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6vn0hd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADUDcW019136;
        Fri, 10 Jun 2022 13:53:46 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm6vn0hcp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:46 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZRaQ010073;
        Fri, 10 Jun 2022 13:53:45 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 3gfy1au77d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:45 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADriwi32833824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:53:44 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 372C86A051;
        Fri, 10 Jun 2022 13:53:44 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C88546A047;
        Fri, 10 Jun 2022 13:53:35 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:53:35 +0000 (GMT)
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
Subject: [PATCH v6 06/13] mm/demotion: Expose memory tier details via sysfs
Date:   Fri, 10 Jun 2022 19:22:22 +0530
Message-Id: <20220610135229.182859-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -mmRbWxBQy5VxIBwmRO7wr0XFrpI03gF
X-Proofpoint-ORIG-GUID: MO1LcfSE9H5le05nc_sA0wsH95q8-xF3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-10_06,2022-06-09_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

This patch adds /sys/devices/system/memtier/ where all memory tier
related details can be found. All created memory tiers will be
listed there as /sys/devices/system/memtier/memtierN/

The nodes which are part of a specific memory tier can be listed
via /sys/devices/system/memtier/memtierN/nodelist

The rank value of a memory tier can be listed via
via /sys/devices/system/memtier/memtierN/rank

/sys/devices/system/memtier/max_tier shows the maximum number of memory
tiers that can be created.

/sys/devices/system/memtier/default_tier shows the memory tier to which
NUMA nodes get added by default if not assigned a specific memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 99 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 4 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 2f116912de43..51210f5efc1f 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -11,8 +11,8 @@
 
 struct memory_tier {
 	struct list_head list;
+	struct device dev;
 	nodemask_t nodelist;
-	int id;
 	int rank;
 };
 
@@ -20,6 +20,7 @@ struct demotion_nodes {
 	nodemask_t preferred;
 };
 
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
 static void establish_migration_targets(void);
 static DEFINE_MUTEX(memory_tier_lock);
 static LIST_HEAD(memory_tiers);
@@ -86,6 +87,52 @@ static LIST_HEAD(memory_tiers);
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
+static ssize_t rank_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
+{
+	struct memory_tier *memtier = to_memory_tier(dev);
+
+	return sysfs_emit(buf, "%d\n", memtier->rank);
+}
+static DEVICE_ATTR_RO(rank);
+
+static struct attribute *memory_tier_dev_attrs[] = {
+	&dev_attr_nodelist.attr,
+	&dev_attr_rank.attr,
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
 /*
  * Keep it simple by having  direct mapping between
  * tier index and rank value.
@@ -121,6 +168,7 @@ static void insert_memory_tier(struct memory_tier *memtier)
 static struct memory_tier *register_memory_tier(unsigned int tier,
 						unsigned int rank)
 {
+	int error;
 	struct memory_tier *memtier;
 
 	if (tier >= MAX_MEMORY_TIERS)
@@ -130,11 +178,20 @@ static struct memory_tier *register_memory_tier(unsigned int tier,
 	if (!memtier)
 		return ERR_PTR(-ENOMEM);
 
-	memtier->id   = tier;
+	memtier->dev.id = tier;
 	memtier->rank = rank;
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
 
@@ -154,7 +211,7 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
 	struct memory_tier *memtier;
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
-		if (memtier->id == id)
+		if (memtier->dev.id == id)
 			return memtier;
 	}
 	return NULL;
@@ -199,7 +256,7 @@ int node_create_and_set_memory_tier(int node, int tier)
 		goto out;
 	}
 
-	if (current_tier->id == tier)
+	if (current_tier->dev.id == tier)
 		goto out;
 
 	node_clear(node, current_tier->nodelist);
@@ -435,10 +492,44 @@ static void __init migrate_on_reclaim_init(void)
 	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
 }
 
+static ssize_t
+max_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", MAX_MEMORY_TIERS);
+}
+static DEVICE_ATTR_RO(max_tier);
+
+static ssize_t
+default_tier_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "memtier%d\n", DEFAULT_MEMORY_TIER);
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
 	 * memory tier from sysfs.
-- 
2.36.1

