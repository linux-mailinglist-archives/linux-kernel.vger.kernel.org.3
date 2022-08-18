Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F635983E3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244962AbiHRNOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244980AbiHRNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:14:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2568F62AB8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:13:49 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ICxohl026681;
        Thu, 18 Aug 2022 13:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XmLg6OLOMq6BKTRPoejiLXiFZksM5cUcBPKRSS+HmWI=;
 b=Mf/a2ILdJP/m9tEdXU8wXm58B7HzZ8VvuijI35e3LzHfXVSH3ywfkbzvPgnQ6CedUFtv
 UYjAS1uRX/VgMstJqPW4sLuSRya1Z6FEegKBPOwT2YTzuah9vcMnSmCQWNtHuSs8k5yA
 PtEcoxWWUMjvvv2nR66CGn3t+m9OoPc5M9w68bw+UHJGP82KmRQFdu4gKp5nlDhw+kaF
 QG1nVzUjHoaFxKPU0UiSSYYV63dnpkuVa6FDBH5ojsQ1G560196/6zXge9JD1PKWjxmC
 zXrWsL6/wN2L3+l/Bpv7C2x8+qfZdbUWP3ddpLFe+uLT7xUgU/rqDMxiYm1P9uSfbmmd 3Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1nx0rhu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:12 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ICxoYA026692;
        Thu, 18 Aug 2022 13:11:11 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1nx0rhtr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:11 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID5dqu002960;
        Thu, 18 Aug 2022 13:11:10 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3hx3kaehs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:10 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDB97764618834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:11:09 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B5A124058;
        Thu, 18 Aug 2022 13:11:09 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4279124054;
        Thu, 18 Aug 2022 13:11:00 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.111.107])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:11:00 +0000 (GMT)
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
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v15 02/10] mm/demotion: Move memory demotion related code
Date:   Thu, 18 Aug 2022 18:40:34 +0530
Message-Id: <20220818131042.113280-3-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CpO2Oa9ZtExkPCTLe1HWPdhlpl4JKX3p
X-Proofpoint-ORIG-GUID: h7FhnIlYQ17fQbTDnNq1nnY-3Ql-oF1h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208180045
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

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  8 +++++
 include/linux/migrate.h      |  2 --
 mm/memory-tiers.c            | 64 ++++++++++++++++++++++++++++++++++++
 mm/migrate.c                 | 60 +--------------------------------
 mm/vmscan.c                  |  1 +
 5 files changed, 74 insertions(+), 61 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 5206568f34ed..c82a1abefca0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -15,4 +15,12 @@
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
 
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
index 22c0a0cf5e0c..96f8c84413fe 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -103,7 +103,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
 #if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
 extern void set_migration_target_nodes(void);
 extern void migrate_on_reclaim_init(void);
-extern bool numa_demotion_enabled;
 extern int next_demotion_node(int node);
 #else
 static inline void set_migration_target_nodes(void) {}
@@ -112,7 +111,6 @@ static inline int next_demotion_node(int node)
 {
         return NUMA_NO_NODE;
 }
-#define numa_demotion_enabled  false
 #endif
 
 #ifdef CONFIG_COMPACTION
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 1f494e69776a..f3dc3318d931 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -3,6 +3,8 @@
 #include <linux/nodemask.h>
 #include <linux/slab.h>
 #include <linux/lockdep.h>
+#include <linux/sysfs.h>
+#include <linux/kobject.h>
 #include <linux/memory-tiers.h>
 
 struct memory_tier {
@@ -127,3 +129,65 @@ static int __init memory_tier_init(void)
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
index 6a1597c92261..5d7fb417edbf 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2562,64 +2562,6 @@ void __init migrate_on_reclaim_init(void)
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
index b2b1431352dc..224de380ac88 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -49,6 +49,7 @@
 #include <linux/printk.h>
 #include <linux/dax.h>
 #include <linux/psi.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
-- 
2.37.2

