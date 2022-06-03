Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B4E53CAD2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 15:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbiFCNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 09:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238131AbiFCNoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 09:44:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3983A5CF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 06:44:22 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253CFKio002787;
        Fri, 3 Jun 2022 13:44:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D5i6K4ZN5mUiBnlrxfjgVIkpayfc1VEiR533YidgkH8=;
 b=aj4+6juGm3/ikZRfPPsKDQtK0/2ru3EB22pWXsjlQZs/JC+e597EjxTZgmPZolYYrZcG
 f/H96qt5U/52vYdO/RIydksVVefboRzQIRg3oeuOfCfDv6KTLEct9BB3g21l4G0BorT3
 N9Y/LFrxbRhJJz7obb81RXkgHrkKOaVQJdzoTVttC440OTaW8XWpxYmVNy9Q7sjynqrM
 vUE6IcJq7XU2zDI6SxJsPASguUUOb66T4+RBumL1yT/9AJakzs6+cw81OSgSfbOs/ciE
 qmDDUz6z4bK70waeOOmqdUfNdb93v/ZH5zKieQuUPBEsrkWuNto16s4Y9ncifIMi6rzI YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfgg8b912-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:10 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 253DNhoT008644;
        Fri, 3 Jun 2022 13:44:10 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfgg8b90r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:10 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253DZ5eh008331;
        Fri, 3 Jun 2022 13:44:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3gd1adht8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 13:44:09 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253Di8OL34734366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 13:44:08 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 021E5112063;
        Fri,  3 Jun 2022 13:44:08 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1D58E112062;
        Fri,  3 Jun 2022 13:44:00 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.93.173])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 Jun 2022 13:43:59 +0000 (GMT)
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
Subject: [PATCH v5 6/9] mm/demotion: Add support for removing node from demotion memory tiers
Date:   Fri,  3 Jun 2022 19:12:34 +0530
Message-Id: <20220603134237.131362-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
References: <20220603134237.131362-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1MPPeNNf2X6BKdTqRxMT25SHQ8oKwC9E
X-Proofpoint-GUID: pnAm_g5t95g4B-34eM7X5D2EouxevYVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_04,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206030059
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the special string "none" as a supported memtier value
that we can use to remove a specific node from being using as demotion target.

For ex:
:/sys/devices/system/node/node1# cat memtier
1
:/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
1-3
:/sys/devices/system/node/node1# echo none > memtier
:/sys/devices/system/node/node1#
:/sys/devices/system/node/node1# cat memtier
:/sys/devices/system/node/node1# cat ../../memtier/memtier1/nodelist
2-3
:/sys/devices/system/node/node1#

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 drivers/base/node.c          |  4 ++++
 include/linux/memory-tiers.h |  1 +
 mm/memory-tiers.c            | 18 +++++++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 599ed64d910f..344786290149 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -582,6 +582,10 @@ static ssize_t memtier_store(struct device *dev,
 	int node = dev->id;
 	int ret;
 
+	if (!strncmp(buf, "none", strlen("none"))) {
+		node_remove_from_memory_tier(node);
+		return count;
+	}
 	ret = kstrtoul(buf, 10, &tier);
 	if (ret)
 		return ret;
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index adc2cb3bf5f8..79bd8d26feb2 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -17,6 +17,7 @@
 
 extern bool numa_demotion_enabled;
 int next_demotion_node(int node);
+void node_remove_from_memory_tier(int node);
 int node_get_memory_tier_id(int node);
 int node_set_memory_tier(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 9c82cf4c4bca..b4e72b672d4d 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -253,8 +253,7 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
 	return NULL;
 }
 
-__maybe_unused // temporay to prevent warnings during bisects
-static void node_remove_from_memory_tier(int node)
+void node_remove_from_memory_tier(int node)
 {
 	struct memory_tier *memtier;
 
@@ -320,7 +319,20 @@ int node_reset_memory_tier(int node, int tier)
 	mutex_lock(&memory_tier_lock);
 
 	current_tier = __node_get_memory_tier(node);
-	if (!current_tier || current_tier->dev.id == tier)
+	if (!current_tier) {
+		/*
+		 * If a N_MEMORY node doesn't have a tier index, then
+		 * we removed it from demotion earlier and we are trying
+		 * add it back. Just add the node to requested tier.
+		 */
+		if (node_state(node, N_MEMORY)) {
+			ret = __node_set_memory_tier(node, tier);
+			establish_migration_targets();
+		}
+		goto out;
+	}
+
+	if (current_tier->dev.id == tier)
 		goto out;
 
 	node_clear(node, current_tier->nodelist);
-- 
2.36.1

