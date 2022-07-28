Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1E258464C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 21:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiG1TFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 15:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiG1TFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 15:05:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E482733341
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 12:05:27 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SJ2vpU007517;
        Thu, 28 Jul 2022 19:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MYjCoNay1r368gChTs21KO0Bpf66/k6EEnGmtXI3wP4=;
 b=CX5jxO0cFcfndCqvWE/YPKN7+hA8stNVxt6KCN7fd/XtjOZop5jOoBgnuG0sFesmR0l9
 HRads/i8w6mQuz+KQodMP6vntx4M6Bz8h43fMmUi4+VFR3VdSSkuCePl0WepGESq9/mp
 D7kYmOkEhUmE2KTpsfepd9KHpOdCgRqF0TybTk5oHLB4UHGHko3ILuP6Hl6ofvTl57G5
 I5txvhoNrGf46Fa7ggELH9/WVrmQPwN/vLzUNIDSHAjnI/0FoHVMK6dwI5iYaks3fyQi
 ujWH/M20/iBSSaNF2W1avp/+EfBOlMeVOTMr968Ruu4F0umqi8wyYYWOP2tEURd5d73i QA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm097r29m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:10 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26SJ59g7017815;
        Thu, 28 Jul 2022 19:05:09 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hm097r28t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:09 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26SJ2CqJ018209;
        Thu, 28 Jul 2022 19:05:08 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 3hhfpj63fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 19:05:08 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26SJ57JL33096054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jul 2022 19:05:07 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4025F6A04D;
        Thu, 28 Jul 2022 19:05:07 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E6E26A047;
        Thu, 28 Jul 2022 19:05:01 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.25.218])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jul 2022 19:05:01 +0000 (GMT)
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
Subject: [PATCH v11 2/8] mm/demotion: Move memory demotion related code
Date:   Fri, 29 Jul 2022 00:34:30 +0530
Message-Id: <20220728190436.858458-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
References: <20220728190436.858458-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NPjpWOj_lKAFhxSJdIOxsJojmKM3kTX1
X-Proofpoint-ORIG-GUID: QaVtC0VuAJfO0msP6BNjLRcmLMMFRFjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207280086
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This move memory demotion related code to mm/memory-tiers.c.
No functional change in this patch.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  8 +++++
 include/linux/migrate.h      |  2 --
 mm/memory-tiers.c            | 62 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 | 60 +---------------------------------
 mm/vmscan.c                  |  1 +
 5 files changed, 72 insertions(+), 61 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 8d7884b7a3f0..b85901c0caba 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -14,4 +14,12 @@
 /* leave one tier below this slow pmem */
 #define MEMTIER_ADISTANCE_PMEM	(1 << MEMTIER_CHUNK_BITS)
 
+#ifdef CONFIG_NUMA
+#include <linux/types.h>
+extern bool numa_demotion_enabled;
+
+#else
+
+#define numa_demotion_enabled	false
+#endif	/* CONFIG_NUMA */
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
index 01cfd514c192..03e43f3dc942 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -100,3 +100,65 @@ static int __init memory_tier_init(void)
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
2.37.1

