Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8C57AE33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240988AbiGTDAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240344AbiGTDA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:00:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5306433
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:00:24 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2tcVF009739;
        Wed, 20 Jul 2022 03:00:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TOqzPn2YLz1Y8ysnYylImZnW1OJnHJTjryVGOSd1RE8=;
 b=jDJ29vPBCMYcXZVJHyBqsGnsPNU1qBmWK3k2FJo+oxW6sij2TX2yJG5dvbxmwNdiAxTH
 jvlj1APxRmzgEbtogkGUFEOh11mVQCj2cGSnNleIPwCsHLRDSv8NoFglO8f/UMRAJKTY
 MV2ws937mH6rkNeETXOTHiMsyyrqbIqkDNW1g5nME6lxRiIx2Acaz447KQdCNtCEfUfO
 m834hhn1lSszZIvi0LSs/u3HVmKhixZ3FXTfY/lDh61UUOCai3qKU1mf0YSxvZIgTJ3P
 0tWlcmeOJOw5fKhKbehITZAYf1wFbS0LYHVz7s6DwkPGv0tXF5kX+kJpPmxHFCHvvTcf vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9bsr3bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:14 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K2upS6018571;
        Wed, 20 Jul 2022 03:00:13 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9bsr3ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:13 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K2phI3010779;
        Wed, 20 Jul 2022 03:00:12 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma02dal.us.ibm.com with ESMTP id 3hbmy9ms5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:00:12 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K30ApM38470110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:00:11 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D9C6713604F;
        Wed, 20 Jul 2022 03:00:10 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612CB136059;
        Wed, 20 Jul 2022 03:00:04 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.15.129])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 03:00:04 +0000 (GMT)
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
Subject: [PATCH v10 4/8] mm/demotion/dax/kmem: Set node's performance level to MEMTIER_PERF_LEVEL_PMEM
Date:   Wed, 20 Jul 2022 08:29:16 +0530
Message-Id: <20220720025920.1373558-5-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zvG1MzLRgBMzfwyym8kNHOGIQn3O2wnN
X-Proofpoint-ORIG-GUID: 4-N5HJDyapfuv0NGvi71b9_FK8alNmqz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, all nodes are assigned to the default memory tier which
is the memory tier designated for nodes with DRAM

Set dax kmem device node's tier to slower memory tier by assigning
performance level to MEMTIER_PERF_LEVEL_PMEM. PMEM tier
appears below the default memory tier in demotion order.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/papr_scm.c | 41 ++++++++++++++++++++---
 drivers/acpi/nfit/core.c                  | 41 ++++++++++++++++++++++-
 2 files changed, 76 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/papr_scm.c b/arch/powerpc/platforms/pseries/papr_scm.c
index 82cae08976bc..3b6164418d6f 100644
--- a/arch/powerpc/platforms/pseries/papr_scm.c
+++ b/arch/powerpc/platforms/pseries/papr_scm.c
@@ -14,6 +14,8 @@
 #include <linux/delay.h>
 #include <linux/seq_buf.h>
 #include <linux/nd.h>
+#include <linux/memory.h>
+#include <linux/memory-tiers.h>
 
 #include <asm/plpar_wrappers.h>
 #include <asm/papr_pdsm.h>
@@ -98,6 +100,7 @@ struct papr_scm_priv {
 	bool hcall_flush_required;
 
 	uint64_t bound_addr;
+	int target_node;
 
 	struct nvdimm_bus_descriptor bus_desc;
 	struct nvdimm_bus *bus;
@@ -1278,6 +1281,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	p->bus_desc.module = THIS_MODULE;
 	p->bus_desc.of_node = p->pdev->dev.of_node;
 	p->bus_desc.provider_name = kstrdup(p->pdev->name, GFP_KERNEL);
+	p->target_node = dev_to_node(&p->pdev->dev);
 
 	/* Set the dimm command family mask to accept PDSMs */
 	set_bit(NVDIMM_FAMILY_PAPR, &p->bus_desc.dimm_family_mask);
@@ -1322,7 +1326,7 @@ static int papr_scm_nvdimm_init(struct papr_scm_priv *p)
 	mapping.size = p->blocks * p->block_size; // XXX: potential overflow?
 
 	memset(&ndr_desc, 0, sizeof(ndr_desc));
-	target_nid = dev_to_node(&p->pdev->dev);
+	target_nid = p->target_node;
 	online_nid = numa_map_to_online_node(target_nid);
 	ndr_desc.numa_node = online_nid;
 	ndr_desc.target_node = target_nid;
@@ -1582,15 +1586,42 @@ static struct platform_driver papr_scm_driver = {
 	},
 };
 
+static int papr_scm_callback(struct notifier_block *self,
+			     unsigned long action, void *arg)
+{
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+	struct papr_scm_priv *p;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	mutex_lock(&papr_ndr_lock);
+	list_for_each_entry(p, &papr_nd_regions, region_list) {
+		if (p->target_node == nid) {
+			node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
+			break;
+		}
+	}
+
+	mutex_unlock(&papr_ndr_lock);
+	return NOTIFY_OK;
+}
+
 static int __init papr_scm_init(void)
 {
 	int ret;
 
 	ret = platform_driver_register(&papr_scm_driver);
-	if (!ret)
-		mce_register_notifier(&mce_ue_nb);
-
-	return ret;
+	if (ret)
+		return ret;
+	mce_register_notifier(&mce_ue_nb);
+	/*
+	 * register a memory hotplug notifier at prio 2 so that we
+	 * can update the perf level for the node.
+	 */
+	hotplug_memory_notifier(papr_scm_callback, MEMTIER_HOTPLUG_PRIO + 1);
+	return 0;
 }
 module_init(papr_scm_init);
 
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index ae5f4acf2675..7ea1017ef790 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -15,6 +15,8 @@
 #include <linux/sort.h>
 #include <linux/io.h>
 #include <linux/nd.h>
+#include <linux/memory.h>
+#include <linux/memory-tiers.h>
 #include <asm/cacheflush.h>
 #include <acpi/nfit.h>
 #include "intel.h"
@@ -3470,6 +3472,39 @@ static struct acpi_driver acpi_nfit_driver = {
 	},
 };
 
+static int nfit_callback(struct notifier_block *self,
+			 unsigned long action, void *arg)
+{
+	bool found = false;
+	struct memory_notify *mnb = arg;
+	int nid = mnb->status_change_nid;
+	struct nfit_spa *nfit_spa;
+	struct acpi_nfit_desc *acpi_desc;
+
+	if (nid == NUMA_NO_NODE || action != MEM_ONLINE)
+		return NOTIFY_OK;
+
+	mutex_lock(&acpi_desc_lock);
+	list_for_each_entry(acpi_desc, &acpi_descs, list) {
+		mutex_lock(&acpi_desc->init_mutex);
+		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
+			struct acpi_nfit_system_address *spa = nfit_spa->spa;
+			int target_node = pxm_to_node(spa->proximity_domain);
+
+			if (target_node == nid) {
+				node_devices[nid]->perf_level = MEMTIER_PERF_LEVEL_PMEM;
+				found = true;
+				break;
+			}
+		}
+		mutex_unlock(&acpi_desc->init_mutex);
+		if (found)
+			break;
+	}
+	mutex_unlock(&acpi_desc_lock);
+	return NOTIFY_OK;
+}
+
 static __init int nfit_init(void)
 {
 	int ret;
@@ -3509,7 +3544,11 @@ static __init int nfit_init(void)
 		nfit_mce_unregister();
 		destroy_workqueue(nfit_wq);
 	}
-
+	/*
+	 * register a memory hotplug notifier at prio 2 so that we
+	 * can update the perf level for the node.
+	 */
+	hotplug_memory_notifier(nfit_callback, MEMTIER_HOTPLUG_PRIO + 1);
 	return ret;
 
 }
-- 
2.36.1

