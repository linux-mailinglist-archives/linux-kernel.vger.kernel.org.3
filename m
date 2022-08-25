Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3246E5A0C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 11:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239727AbiHYJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 05:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiHYJYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 05:24:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41890A9C3E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 02:24:17 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27P9GUBA018022;
        Thu, 25 Aug 2022 09:23:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=X7s1R2edoGHobonvf5SDINGwSZCVZM7N9IyraazotsQ=;
 b=l8F9wuKGg3+y5hD+Q5ZBC0+/Z6FKBbdeTF3UEMPgefM/PKVa+BDvt52i4X97JtTKlk51
 U6qpCwkl/sqN/V580ml+W+K/QclHp4Bymo3+916b4tK00EvZwtSeZjhR0X7BNFUtqcnL
 r3aS9pxkAwxCvOYjvwsdni828LsWTWdvV60jkQ4SBUmWRzFi6vyF1jx5buUuBQnd2f4h
 3c49Bv9QkKe23ZT3WmFSi9DtOtIR/wMWRAEYA2wmxqzUBdonjo2epE9grAZ6pIgHLVQs
 e5jPNPNDRrxkf/3LtDXp53cu3o29x3AISIyju97GE/+PixG65+njuUWgLce/JxaG0a6C Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j66ab0brk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:54 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27P9K7P5026733;
        Thu, 25 Aug 2022 09:23:54 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j66ab0bqk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:53 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27P9KFKc031688;
        Thu, 25 Aug 2022 09:23:53 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 3j2q8aenkk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 09:23:53 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27P9NqAL2163434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Aug 2022 09:23:52 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D9A713604F;
        Thu, 25 Aug 2022 09:23:52 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D995313605D;
        Thu, 25 Aug 2022 09:23:45 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.112.25])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Aug 2022 09:23:45 +0000 (GMT)
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
Subject: [RFC PATCH 2/2] mm/demotion: Expose memory tier details via sysfs
Date:   Thu, 25 Aug 2022 14:53:25 +0530
Message-Id: <20220825092325.381517-2-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
References: <20220825092325.381517-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CfOm5ZXVUAj_3-qYYNfb2PirpQdNuulp
X-Proofpoint-ORIG-GUID: V9gQKqZzFXge2-eO-h-6a-lpTiKAK6L7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_03,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208250034
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All allocated memory tiers will be listed as
/sys/devices/virtual/memtier/memtierN/

Each memtier directory contains symbolic link for the memory types
that are part of the memory tier. A directory hierarchy looks like

:/sys/devices/virtual/memtier# tree memtier512/
memtier512/
├── memtype1 -> ../memtype1
├── memtype2 -> ../memtype2
├── subsystem -> ../../../../bus/memtier
└── uevent

The nodes which are part of a specific memory type can be listed via
/sys/devices/system/memtier/memtypeN/nodes.

The adistance value of a specific memory type can be listed via
/sys/devices/system/memtier/memtypeN/adistance.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 62 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 9eef3bd8d134..4005c3124ff0 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -20,6 +20,7 @@ struct memory_tier {
 	 * adistance_start .. adistance_start + MEMTIER_CHUNK_SIZE
 	 */
 	int adistance_start;
+	struct device dev;
 	/* All the nodes that are part of all the lower memory tiers. */
 	nodemask_t lower_tier_mask;
 };
@@ -36,6 +37,7 @@ static struct memory_dev_type *default_dram_type;
 #define MAX_MEMORY_TYPE_ID	20
 static DEFINE_IDR(memory_type_idr);
 #define to_memory_type(device) container_of(device, struct memory_dev_type, dev)
+#define to_memory_tier(device) container_of(device, struct memory_tier, dev)
 static struct bus_type memory_tier_subsys = {
 	.name = "memtier",
 	.dev_name = "memtier",
@@ -103,8 +105,25 @@ static int top_tier_adistance;
 static struct demotion_nodes *node_demotion __read_mostly;
 #endif /* CONFIG_MIGRATION */
 
+static void memory_tier_device_release(struct device *dev)
+{
+	struct memory_tier *tier = to_memory_tier(dev);
+	/*
+	 * synchronize_rcu in clear_node_memory_tier makes sure
+	 * we don't have rcu access to this memory tier.
+	 */
+	kfree(tier);
+}
+
+static void destroy_memory_tier(struct memory_tier *memtier)
+{
+	list_del(&memtier->list);
+	device_unregister(&memtier->dev);
+}
+
 static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memtype)
 {
+	int ret;
 	bool found_slot = false;
 	struct memory_tier *memtier, *new_memtier;
 	int adistance = memtype->adistance;
@@ -128,15 +147,14 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		if (adistance == memtier->adistance_start) {
-			list_add(&memtype->tier_sibiling, &memtier->memory_types);
-			return memtier;
+			goto link_memtype;
 		} else if (adistance < memtier->adistance_start) {
 			found_slot = true;
 			break;
 		}
 	}
 
-	new_memtier = kmalloc(sizeof(struct memory_tier), GFP_KERNEL);
+	new_memtier = kzalloc(sizeof(struct memory_tier), GFP_KERNEL);
 	if (!new_memtier)
 		return ERR_PTR(-ENOMEM);
 
@@ -147,8 +165,30 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		list_add_tail(&new_memtier->list, &memtier->list);
 	else
 		list_add_tail(&new_memtier->list, &memory_tiers);
-	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
-	return new_memtier;
+
+	new_memtier->dev.id = adistance;
+	new_memtier->dev.bus = &memory_tier_subsys;
+	new_memtier->dev.release = memory_tier_device_release;
+
+	ret = device_register(&new_memtier->dev);
+	if (ret) {
+		list_del(&memtier->list);
+		put_device(&memtier->dev);
+		return ERR_PTR(ret);
+	}
+	memtier = new_memtier;
+
+link_memtype:
+	list_add(&memtype->tier_sibiling, &memtier->memory_types);
+	/*
+	 * ignore error below because the driver creating the device can get
+	 * unloaded and hence the below sysfs create link can fail. We continue
+	 * with the in memory representation.
+	 */
+	ret = sysfs_create_link(&memtier->dev.kobj,
+				&memtype->dev.kobj, kobject_name(&memtype->dev.kobj));
+
+	return memtier;
 }
 
 static struct memory_tier *__node_get_memory_tier(int node)
@@ -424,16 +464,6 @@ static struct memory_tier *set_node_memory_tier(int node)
 	return memtier;
 }
 
-static void destroy_memory_tier(struct memory_tier *memtier)
-{
-	list_del(&memtier->list);
-	/*
-	 * synchronize_rcu in clear_node_memory_tier makes sure
-	 * we don't have rcu access to this memory tier.
-	 */
-	kfree(memtier);
-}
-
 static bool clear_node_memory_tier(int node)
 {
 	bool cleared = false;
@@ -462,6 +492,8 @@ static bool clear_node_memory_tier(int node)
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
 			list_del_init(&memtype->tier_sibiling);
+			sysfs_delete_link(&memtier->dev.kobj,
+					  &memtype->dev.kobj, kobject_name(&memtype->dev.kobj));
 			if (list_empty(&memtier->memory_types))
 				destroy_memory_tier(memtier);
 		}
-- 
2.37.2

