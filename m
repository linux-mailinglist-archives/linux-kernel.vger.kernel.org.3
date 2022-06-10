Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549DD5467C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349460AbiFJNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349284AbiFJNyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:54:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0450B34
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 06:54:21 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25AD7kOW030120;
        Fri, 10 Jun 2022 13:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mCkQY9eq8ljfIN+4+Uneh6vfxHdvwScC98u2nmNKZr0=;
 b=UwlQHqVnyqOTTD5Oj94N7FHv21odR8jCf02WhNc+cXWr8fvxQn2WbYtXYCqHuyc/2l1J
 /fSiVSDq0D+pkH9UDVZPEaoAQ0R/JK4j7coa6uqcN39JQLODQErTIG4abhEA7f5tPz7l
 /2z70vMPf1htUbs8PNDR57NfgkZZBLHPGZuj+FxX9Aw9gZHanyFd0ZCeYmjzfOSWnYFs
 fPlgGy6lpbarokUNEfhQ7RNVYGNGqLo3azc6fi8LN/k3uyRfI8Dn/RgHcC+EpcaQ9HyO
 IFpXwUxkSaOFwYmqxn18GYEtFP/BSukFVfg68FB5wrrL6uffOqdnJr6KGVR/dz1IIgVk gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm4vaaxxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:56 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25ADPKNW032120;
        Fri, 10 Jun 2022 13:53:55 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gm4vaaxxj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:55 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25ADZS9o014172;
        Fri, 10 Jun 2022 13:53:54 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3gfy1bb4kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jun 2022 13:53:54 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25ADrrun32702788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jun 2022 13:53:53 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1643B6A057;
        Fri, 10 Jun 2022 13:53:53 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A7C6A04D;
        Fri, 10 Jun 2022 13:53:45 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.90.151])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jun 2022 13:53:44 +0000 (GMT)
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
Subject: [PATCH v6 07/13] mm/demotion: Add per node memory tier attribute to sysfs
Date:   Fri, 10 Jun 2022 19:22:23 +0530
Message-Id: <20220610135229.182859-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
References: <20220610135229.182859-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lpIccryA9ZlRNWpkgFKmSLojMXjMgkGq
X-Proofpoint-GUID: 4ZtrkFZg1m4-wH4m24WbekH28Sqg_6ZZ
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
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

If the memory tier does not exist an error is returned.

Suggested-by: Wei Xu <weixugc@google.com>
Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c          | 39 ++++++++++++++++++++++++++++++++
 include/linux/memory-tiers.h |  3 +++
 mm/memory-tiers.c            | 44 ++++++++++++++++++++++++++++++++++++
 3 files changed, 86 insertions(+)

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
index 18dd1ab7b96e..e70f0040d845 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -20,6 +20,9 @@
 extern bool numa_demotion_enabled;
 int node_create_and_set_memory_tier(int node, int tier);
 int next_demotion_node(int node);
+int node_set_memory_tier(int node, int tier);
+int node_get_memory_tier_id(int node);
+int node_reset_memory_tier(int node, int tier);
 #else
 #define numa_demotion_enabled	false
 static inline int next_demotion_node(int node)
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 51210f5efc1f..7bfdfac4d43e 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -313,6 +313,50 @@ int node_set_memory_tier(int node, int tier)
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
+	establish_migration_targets();
+out:
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
 /**
  * next_demotion_node() - Get the next node in the demotion path
  * @node: The starting node to lookup the next node
-- 
2.36.1

