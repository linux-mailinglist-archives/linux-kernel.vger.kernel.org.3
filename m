Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434B5983DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiHRNOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiHRNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:14:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F337F40BF7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:13:46 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ICBtSt006495;
        Thu, 18 Aug 2022 13:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=DxxrFOycvBHQk5/4QI1h0OEG5diEikgeH+qCa3Uf3eI=;
 b=ojC9LQDd5lsUqZ16jKWK/Yody57nBuglYb83ImLtmsQAIPMIpadzYSTTe+T9kPcpBjLR
 gwsySZ8mqqHSfeR54gyQvY672X3cSeiG84FWKItL2gQXKGz94Jd/RbpkHtfJWbn2o52N
 5UBrAzw9R3YxnGKDa76UcoiWK3YDN7hILrRIx46NfEQiYrEi7Smi8+64uGX5GnV6EL7H
 bHHeOwPTKdslGsVFCN2PM2Q0BoO0eKK1mLIvRaesjdW49EB80XcMVo3xBM5A+lF2npWH
 DwDvOSQaFHj2I4NnQOWgFcOzd7tza94YTePZ7/Nh8DUi7FL3aQuZ6g54aaKdD0SUZUM5 Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1n7cj53g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:18 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ICDAFu009666;
        Thu, 18 Aug 2022 13:11:17 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1n7cj51v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:17 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID5cDD002945;
        Thu, 18 Aug 2022 13:11:16 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma03dal.us.ibm.com with ESMTP id 3hx3kaehsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:15 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDBFUI6423158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:11:15 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05C73124052;
        Thu, 18 Aug 2022 13:11:15 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14032124055;
        Thu, 18 Aug 2022 13:11:10 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.111.107])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:11:09 +0000 (GMT)
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
Subject: [PATCH v15 03/10] mm/demotion: Add hotplug callbacks to handle new numa node onlined
Date:   Thu, 18 Aug 2022 18:40:35 +0530
Message-Id: <20220818131042.113280-4-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tELrMvoFiCSu17nbcBUc6ZVRIvn7mR_T
X-Proofpoint-ORIG-GUID: lScm0d_d-SkSpiUOKWETZzOpgiZm_JbL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180045
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

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 68 ++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index c82a1abefca0..17b41e592be6 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -14,6 +14,7 @@
  * the same memory tier.
  */
 #define MEMTIER_ADISTANCE_DRAM	((4 * MEMTIER_CHUNK_SIZE) + (MEMTIER_CHUNK_SIZE >> 1))
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
2.37.2

