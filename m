Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E21B590BA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbiHLF6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiHLF56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:57:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BAEA3D7B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:57:57 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C5j8OU015534;
        Fri, 12 Aug 2022 05:57:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nW3GgvEjDYwVNglSmbqBQ4XObxtKCvF3A9NIZtVz+ZA=;
 b=mEI7ptY3EwtLVOmRJYeTT9eCyntxPQl7fBQjzFEDVFrEm5tpvkS0WH016XNjrfiXS/4m
 hxrHFhSyUV7xy3s3yw8IWqRkeetOxujT0IGTg1n5LHnzc1k0QFaIPw+VxHfRsAhRXOvG
 BZA/gs5eQLwwPFaYkcFvZAXUxnfNc7XdnJ64AqYxboniBjxoqOxU3BFsu6H3DXtnyQWM
 yLRn2JKqLEvoFviJC5OCkMVa4yW2hrN1MaMicXeND1ORfoR79U85F175qHII58mSaQpz
 vbSgBNFmRcMMtOIyfn1KII1cVJ4hlZRnG9sThnTlI8dM2uG09Q01JnI18iQWk990HU6E pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh05897m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:44 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5pcZc010930;
        Fri, 12 Aug 2022 05:57:43 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwh058976-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:43 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5Zx0g029144;
        Fri, 12 Aug 2022 05:57:42 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01wdc.us.ibm.com with ESMTP id 3huwvqqf4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:57:42 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5vfpL40305066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:57:41 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF2D78064;
        Fri, 12 Aug 2022 05:57:41 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27E6A7805E;
        Fri, 12 Aug 2022 05:57:36 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:57:35 +0000 (GMT)
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
Subject: [PATCH v14 03/10] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Fri, 12 Aug 2022 11:27:02 +0530
Message-Id: <20220812055710.357820-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zb4r_fvljeXydlg66XRY-dQoVDUkNAUJ
X-Proofpoint-GUID: 3aVFs9fNWbqvaAl5zUgX2_6xmozWdORk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the new NUMA node onlined doesn't have a abstract distance assigned,
the kernel adds the NUMA node to default memory tier.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 68 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 9fdd9572fdf9..cc89876899a6 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -11,6 +11,7 @@
  * Smaller abstract distance value imply faster(higher) memory tiers.
  */
 #define MEMTIER_ADISTANCE_DRAM	(4 * MEMTIER_CHUNK_SIZE)
+#define MEMTIER_HOTPLUG_PRIO	100
 
 #ifdef CONFIG_NUMA
 #include <linux/types.h>
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index f3dc3318d931..05f05395468a 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -5,6 +5,7 @@
 #include <linux/lockdep.h>
 #include <linux/sysfs.h>
 #include <linux/kobject.h>
+#include <linux/memory.h>
 #include <linux/memory-tiers.h>
 
 struct memory_tier {
@@ -105,6 +106,72 @@ static struct memory_tier *set_node_memory_tier(int node)
 	return memtier;
 }
 
+static struct memory_tier *__node_get_memory_tier(int node)
+{
+	struct memory_dev_type *memtype;
+
+	memtype = node_memory_types[node];
+	if (memtype && node_isset(node, memtype->nodes))
+		return memtype->memtier;
+	return NULL;
+}
+
+static void destroy_memory_tier(struct memory_tier *memtier)
+{
+	list_del(&memtier->list);
+	kfree(memtier);
+}
+
+static bool clear_node_memory_tier(int node)
+{
+	bool cleared = false;
+	struct memory_tier *memtier;
+
+	memtier = __node_get_memory_tier(node);
+	if (memtier) {
+		struct memory_dev_type *memtype;
+
+		memtype = node_memory_types[node];
+		node_clear(node, memtype->nodes);
+		if (nodes_empty(memtype->nodes)) {
+			list_del(&memtype->tier_sibiling);
+			memtype->memtier = NULL;
+			if (list_empty(&memtier->memory_types))
+				destroy_memory_tier(memtier);
+		}
+		cleared = true;
+	}
+	return cleared;
+}
+
+static int __meminit memtier_hotplug_callback(struct notifier_block *self,
+					      unsigned long action, void *_arg)
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
+	case MEM_OFFLINE:
+		mutex_lock(&memory_tier_lock);
+		clear_node_memory_tier(arg->status_change_nid);
+		mutex_unlock(&memory_tier_lock);
+		break;
+	case MEM_ONLINE:
+		mutex_lock(&memory_tier_lock);
+		set_node_memory_tier(arg->status_change_nid);
+		mutex_unlock(&memory_tier_lock);
+		break;
+	}
+
+	return notifier_from_errno(0);
+}
+
 static int __init memory_tier_init(void)
 {
 	int node;
@@ -126,6 +193,7 @@ static int __init memory_tier_init(void)
 	}
 	mutex_unlock(&memory_tier_lock);
 
+	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRIO);
 	return 0;
 }
 subsys_initcall(memory_tier_init);
-- 
2.37.1

