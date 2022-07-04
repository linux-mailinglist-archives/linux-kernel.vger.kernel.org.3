Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DB7564E60
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiGDHJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiGDHIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:08:54 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE70CE44
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:08:25 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2645ok7M020145;
        Mon, 4 Jul 2022 07:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=VynPHaB44iwLNm1NI/jimLhyT7ZD9Z8XYUiK5QEqD2Y=;
 b=arAGugfnK+sZGy+OTe08BErvi5QURoAsTLl/lxWzH+lpZ375eT1SerSAvMdDU9Vx8V3J
 AC6T8HX4hpAP0mqkeNIA4ZvrMDwUvj/4sXZC7iqJFoIzq2EHhPzn6dyK92efVjUUhaRT
 3PSBh+Kqm8MPz6tu6szC6Ec8GIro+VvorrA9rVp82z9vuwWd3cAT5cuJOTwQEIC6w20X
 V5/SaafFik448tVhdYA96TFpXdDcRTYMLP6WIKSvstEp2MkGrnYc4KmX7jtIALykKIU2
 g9zJt8QZVjStnc7/xvIklI9bri7tNvd5QXFqHkkHcI7A0n+AHND6QkosPC47sesWhkBe 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3tdw1jqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:07 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2646TDaT018292;
        Mon, 4 Jul 2022 07:08:07 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h3tdw1jqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:06 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26475TmZ030738;
        Mon, 4 Jul 2022 07:08:06 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 3h2dn9b4es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Jul 2022 07:08:06 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 264785rR64684344
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 4 Jul 2022 07:08:05 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 701A312405A;
        Mon,  4 Jul 2022 07:08:05 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EBD0124052;
        Mon,  4 Jul 2022 07:07:59 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.74.198])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  4 Jul 2022 07:07:58 +0000 (GMT)
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
Subject: [PATCH v8 04/12] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Mon,  4 Jul 2022 12:36:04 +0530
Message-Id: <20220704070612.299585-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
References: <20220704070612.299585-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: u4SUYerLbGMNatFRZwC6xBmkxPhOHZMb
X-Proofpoint-ORIG-GUID: opr2ipzNiIAs3eU8bJubdp00sqfbHjGo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-04_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2207040030
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

