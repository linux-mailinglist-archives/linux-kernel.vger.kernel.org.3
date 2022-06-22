Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1546A554691
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351599AbiFVI0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348272AbiFVI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 04:26:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D286387A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 01:26:17 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25M8AV1d000657;
        Wed, 22 Jun 2022 08:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VynPHaB44iwLNm1NI/jimLhyT7ZD9Z8XYUiK5QEqD2Y=;
 b=eAbhHZJYQhz7YtUctC/KVm8r/kqOaDR5eA8qAmHG9yHO5SUH2N7TZMZOHgOeCKb3hQb2
 Wp8iJzVaOKJ+cotVHsbiVyYFaXZ9b9aHxKUiZ6iTxJC8Gz0QxnvAy1EcW6E4IXUXGlQH
 vEU/cWd7VslxFdftUOpr9fpUAxtQd8b/ZlfLaHeOo5iSKSZLtNi5ULv/EHSpX5bR/bbe
 Ufod7mhZZTHWqKBSy1VdkNsSgHW01rfezSfQgdhuoIaCbRNQr6HzZqk3zejX737MS3ss
 VuQ9T3shmhjLrfotfsarfbS6jbpfjqxsrEumHT6iGm6uqSvGCob+38sfXtXaraHaGvCL aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxxeru62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:59 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 25M8ORcm002989;
        Wed, 22 Jun 2022 08:25:59 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3guxxeru5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:59 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25M8LcEi002840;
        Wed, 22 Jun 2022 08:25:58 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03dal.us.ibm.com with ESMTP id 3gs6b9rqxx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jun 2022 08:25:57 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25M8PuAg8520130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jun 2022 08:25:56 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A33216E059;
        Wed, 22 Jun 2022 08:25:56 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DE156E053;
        Wed, 22 Jun 2022 08:25:51 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.69.226])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jun 2022 08:25:50 +0000 (GMT)
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
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v7 04/12] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Wed, 22 Jun 2022 13:55:05 +0530
Message-Id: <20220622082513.467538-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
References: <20220622082513.467538-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yeXRvffaooIxMKEbbhC9rYaowq3ts_g9
X-Proofpoint-ORIG-GUID: RjTjphhgxogDLAs6b07dhTL5g0LNEfSq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-21_11,2022-06-21_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206220039
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the new NUMA node onlined doesn't have a memory tier assigned,
the kernel adds the NUMA node to default memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fc404fcff7ff..2147112981a6 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/lockdep.h>
 #include <linux/moduleparam.h>
+#include <linux/memory.h>
 #include <linux/memory-tiers.h>
 
 struct memory_tier {
@@ -130,8 +131,73 @@ int node_create_and_set_memory_tier(int node, int tier)
 }
 EXPORT_SYMBOL_GPL(node_create_and_set_memory_tier);
 
+static int __node_set_memory_tier(int node, int tier)
+{
+	int ret = 0;
+	struct memory_tier *memtier;
+
+	memtier = __get_memory_tier_from_id(tier);
+	if (!memtier) {
+		ret = -EINVAL;
+		goto out;
+	}
+	node_set(node, memtier->nodelist);
+out:
+	return ret;
+}
+
+static int node_set_memory_tier(int node, int tier)
+{
+	struct memory_tier *memtier;
+	int ret = 0;
+
+	mutex_lock(&memory_tier_lock);
+	memtier = __node_get_memory_tier(node);
+	if (!memtier)
+		ret = __node_set_memory_tier(node, tier);
+
+	mutex_unlock(&memory_tier_lock);
+
+	return ret;
+}
+
 static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
 core_param(default_memory_tier, default_memtier, uint, 0644);
+/*
+ * This runs whether reclaim-based migration is enabled or not,
+ * which ensures that the user can turn reclaim-based migration
+ * at any time without needing to recalculate migration targets.
+ */
+static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
+						 unsigned long action, void *_arg)
+{
+	struct memory_notify *arg = _arg;
+
+	/*
+	 * Only update the node migration order when a node is
+	 * changing status, like online->offline.
+	 */
+	if (arg->status_change_nid < 0)
+		return notifier_from_errno(0);
+
+	switch (action) {
+	case MEM_ONLINE:
+		/*
+		 * We ignore the error here, if the node already have the tier
+		 * registered, we will continue to use that for the new memory
+		 * we are adding here.
+		 */
+		node_set_memory_tier(arg->status_change_nid, default_memtier);
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
+static void __init migrate_on_reclaim_init(void)
+{
+	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
+}
 
 static int __init memory_tier_init(void)
 {
@@ -153,6 +219,8 @@ static int __init memory_tier_init(void)
 	/* CPU only nodes are not part of memory tiers. */
 	memtier->nodelist = node_states[N_MEMORY];
 	mutex_unlock(&memory_tier_lock);
+
+	migrate_on_reclaim_init();
 	return 0;
 }
 subsys_initcall(memory_tier_init);
-- 
2.36.1

