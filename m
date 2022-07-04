Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7D564E68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiGDHJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGDHI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:08:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695567663
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:08:12 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2646lSCN020206;
        Mon, 4 Jul 2022 07:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kCshwDR5ZogYTrpobosIp/kRpNpnP8mVfIYJFE0RrSk=;
 b=kxGJ92QW8Ei2hXLIL8HBVZFyfjeR7Ri3U1hNBwgTsz0hAsQaPqhP52fC6RTIEjWwhumh
 1hERyW2VhqFR9wGofJx0leUYnaf7VmdcukEEU8ed7uV3/IwXVOjSqg3oT2qK6NNrRO9I
 yab4m6DjfAfSi9pqbkoZtD52bZ27tlF+HCe1MAVrsbKnVjxXIANc+RIlT0egP9yNgu8H
 rQDVw5uu6u2qX0yyaIK0kkKqQIFrBCfxyey6XHsUHwyRl02ykeY4Y+1Tw+RlF/dEKV62
 U94ZXBYA90PZLNGEJy/l1OwgMxv4nw+BIsAuIej0auBbK54IETwbA8LJ4mzwN2EWBfVP 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3u860dr1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:54 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26474A26026316;
        Mon, 4 Jul 2022 07:07:53 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3u860dqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:53 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26475bAP029074;
        Mon, 4 Jul 2022 07:07:52 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01dal.us.ibm.com with ESMTP id 3h2dn9kmnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:07:52 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26477phe64684298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:07:51 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5418D124053;
        Mon,  4 Jul 2022 07:07:51 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 083A3124052;
        Mon,  4 Jul 2022 07:07:45 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:07:44 +0000 (GMT)
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
Subject: [PATCH v8 02/12] mm/demotion: Move memory demotion related code
Date:   Mon,  4 Jul 2022 12:36:02 +0530
Message-Id: <20220704070612.299585-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tDzl3GTaJVeOPxo6HBERbSJPnLQfPgH_
X-Proofpoint-ORIG-GUID: RVAWOyq7KTzALlLgt1TsSTuIghJkLX99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207040030
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This move memory demotion related code to mm/memory-tiers.c.
No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  7 ++++
 include/linux/migrate.h      |  2 --
 mm/memory-tiers.c            | 63 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 | 60 +---------------------------------
 mm/vmscan.c                  |  1 +
 5 files changed, 72 insertions(+), 61 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index a81dbc20e0d1..c47dbe381089 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_MEMORY_TIERS_H
 #define _LINUX_MEMORY_TIERS_H
 
+#include <linux/types.h>
+
 #ifdef CONFIG_NUMA
 
 #define MEMORY_TIER_HBM_GPU	300
@@ -11,5 +13,10 @@
 #define DEFAULT_MEMORY_TIER	MEMORY_TIER_DRAM
 #define MAX_MEMORY_TIER_ID	400
 
+extern bool numa_demotion_enabled;
+
+#else
+
+#define numa_demotion_enabled	false
 #endif	/* CONFIG_NUMA */
 #endif  /* _LINUX_MEMORY_TIERS_H */
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 069a89e847f3..43e737215f33 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -78,7 +78,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
 extern void set_migration_target_nodes(void);
 extern void migrate_on_reclaim_init(void);
-extern bool numa_demotion_enabled;
 extern int next_demotion_node(int node);
 #else
 static inline void set_migration_target_nodes(void) {}
@@ -87,7 +86,6 @@ static inline int next_demotion_node(int node)
 {
         return NUMA_NO_NODE;
 }
-#define numa_demotion_enabled  false
 #endif
 
 #ifdef CONFIG_COMPACTION
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 69a5d81c0a12..2dcf70802661 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <linux/device.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
@@ -76,3 +77,65 @@ static int __init memory_tier_init(void)
 	return 0;
 }
 subsys_initcall(memory_tier_init);
+
+bool numa_demotion_enabled = false;
+
+#ifdef CONFIG_MIGRATION
+#ifdef CONFIG_SYSFS
+static ssize_t numa_demotion_enabled_show(struct kobject *kobj,
+					  struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",
+			  numa_demotion_enabled ? "true" : "false");
+}
+
+static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &numa_demotion_enabled);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute numa_demotion_enabled_attr =
+	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
+	       numa_demotion_enabled_store);
+
+static struct attribute *numa_attrs[] = {
+	&numa_demotion_enabled_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group numa_attr_group = {
+	.attrs = numa_attrs,
+};
+
+static int __init numa_init_sysfs(void)
+{
+	int err;
+	struct kobject *numa_kobj;
+
+	numa_kobj = kobject_create_and_add("numa", mm_kobj);
+	if (!numa_kobj) {
+		pr_err("failed to create numa kobject\n");
+		return -ENOMEM;
+	}
+	err = sysfs_create_group(numa_kobj, &numa_attr_group);
+	if (err) {
+		pr_err("failed to register numa group\n");
+		goto delete_obj;
+	}
+	return 0;
+
+delete_obj:
+	kobject_put(numa_kobj);
+	return err;
+}
+subsys_initcall(numa_init_sysfs);
+#endif /* CONFIG_SYSFS */
+#endif
diff --git a/mm/migrate.c b/mm/migrate.c
index 6c1ea61f39d8..fce7d4a9e940 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2509,64 +2509,6 @@ void __init migrate_on_reclaim_init(void)
 	set_migration_target_nodes();
 	cpus_read_unlock();
 }
+#endif /* CONFIG_NUMA */
 
-bool numa_demotion_enabled = false;
-
-#ifdef CONFIG_SYSFS
-static ssize_t numa_demotion_enabled_show(struct kobject *kobj,
-					  struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%s\n",
-			  numa_demotion_enabled ? "true" : "false");
-}
-
-static ssize_t numa_demotion_enabled_store(struct kobject *kobj,
-					   struct kobj_attribute *attr,
-					   const char *buf, size_t count)
-{
-	ssize_t ret;
-
-	ret = kstrtobool(buf, &numa_demotion_enabled);
-	if (ret)
-		return ret;
-
-	return count;
-}
-
-static struct kobj_attribute numa_demotion_enabled_attr =
-	__ATTR(demotion_enabled, 0644, numa_demotion_enabled_show,
-	       numa_demotion_enabled_store);
-
-static struct attribute *numa_attrs[] = {
-	&numa_demotion_enabled_attr.attr,
-	NULL,
-};
-
-static const struct attribute_group numa_attr_group = {
-	.attrs = numa_attrs,
-};
-
-static int __init numa_init_sysfs(void)
-{
-	int err;
-	struct kobject *numa_kobj;
 
-	numa_kobj = kobject_create_and_add("numa", mm_kobj);
-	if (!numa_kobj) {
-		pr_err("failed to create numa kobject\n");
-		return -ENOMEM;
-	}
-	err = sysfs_create_group(numa_kobj, &numa_attr_group);
-	if (err) {
-		pr_err("failed to register numa group\n");
-		goto delete_obj;
-	}
-	return 0;
-
-delete_obj:
-	kobject_put(numa_kobj);
-	return err;
-}
-subsys_initcall(numa_init_sysfs);
-#endif /* CONFIG_SYSFS */
-#endif /* CONFIG_NUMA */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f7d9a683e3a7..3a8f78277f99 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -50,6 +50,7 @@
 #include <linux/printk.h>
 #include <linux/dax.h>
 #include <linux/psi.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
-- 
2.36.1

