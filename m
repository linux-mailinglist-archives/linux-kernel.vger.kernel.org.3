Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3A05362BE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243444AbiE0Mkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352135AbiE0Mjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:39:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732B9262D
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 05:27:44 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RBssO5011758;
        Fri, 27 May 2022 12:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k4WXuxqHLYtUs3nR7hNS9Y447qsMw5Ie+ESvXbW0TY4=;
 b=ktYMfB33insMRpZVSTP8+XlsFKc0bC2z4lhUtz/ua/DPmN6jG4q/SNhnntI+IlY0ssU6
 019mCvKYedwDieOwwllRZ1oerKQYnOiUBvI3qD1OnZl29os7VJWvApcu3IgveyTBIRnc
 tousejH+4QAXWWJCrQfao7JGagifq3KdiUyrTTiLFOxB5gr9OL1ld8/6ZT6wz1VV7d64
 se2Con8GYItSDL2az+zEMALdiuDHvt0fzj2USsJIG9GV51Klg9YkJDban8t7czo71ttZ
 lnQLlhjDBCGu09GnPvbDnEMTHgm1OA+Bx8XGYW5whuf3sshyZR+bN3wYKozLfI+gXC/i BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax6j0k8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:11 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24RBvdwV020349;
        Fri, 27 May 2022 12:27:10 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gax6j0k8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:10 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24RCKYv4004761;
        Fri, 27 May 2022 12:27:09 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01wdc.us.ibm.com with ESMTP id 3gaas1ew5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 12:27:09 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24RCR9Uo33948130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 12:27:09 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38705AE05F;
        Fri, 27 May 2022 12:27:09 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72BD9AE05C;
        Fri, 27 May 2022 12:27:02 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.91.191])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 27 May 2022 12:27:02 +0000 (GMT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     Huang Ying <ying.huang@intel.com>,
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
Subject: [RFC PATCH v4 6/7] mm/demotion: Add support for removing node from demotion memory tiers
Date:   Fri, 27 May 2022 17:55:27 +0530
Message-Id: <20220527122528.129445-7-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
References: <CAAPL-u-dFp7PwPH6DfbYdnY8xaGsHz3tRQ0CPGVkiqURvdN8=A@mail.gmail.com>
 <20220527122528.129445-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: dluQ2Up9Gb7xeJ3Rsrh0Pj-U_vb0eyY3
X-Proofpoint-GUID: DKqpbexucjAM265GtFPYEvLZhMR05igB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_03,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270057
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
 drivers/base/node.c     |  7 ++++++-
 include/linux/migrate.h |  1 +
 mm/migrate.c            | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 892f7c23c94e..5311cf1db500 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -578,10 +578,15 @@ static ssize_t memtier_store(struct device *dev,
 			     struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
+	int ret;
 	unsigned long tier;
 	int node = dev->id;
 
-	int ret = kstrtoul(buf, 10, &tier);
+	if (!strncmp(buf, "none", strlen("none"))) {
+		node_remove_from_memory_tier(node);
+		return count;
+	}
+	ret = kstrtoul(buf, 10, &tier);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index fd09fd009a69..77c581f47953 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -178,6 +178,7 @@ enum memory_tier_type {
 #define MAX_MEMORY_TIERS  3
 
 int next_demotion_node(int node);
+void node_remove_from_memory_tier(int node);
 int node_get_memory_tier_id(int node);
 int node_set_memory_tier_rank(int node, int tier);
 int node_reset_memory_tier(int node, int tier);
diff --git a/mm/migrate.c b/mm/migrate.c
index f013d14f77ed..114c7428b9f3 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2354,7 +2354,7 @@ static struct memory_tier *__get_memory_tier_from_id(int id)
 }
 
 
-static void node_remove_from_memory_tier(int node)
+void node_remove_from_memory_tier(int node)
 {
 	struct memory_tier *memtier;
 
@@ -2418,7 +2418,18 @@ int node_reset_memory_tier(int node, int tier)
 	mutex_lock(&memory_tier_lock);
 
 	current_tier = __node_get_memory_tier(node);
-	if (!current_tier || current_tier->dev.id == tier)
+	if (!current_tier) {
+		/*
+		 * If a N_MEMORY node doesn't have a tier index, then
+		 * we removed it from demotion earlier and we are trying
+		 * add it back. Just add the node to requested tier.
+		 */
+		if (node_state(node, N_MEMORY))
+			ret = __node_set_memory_tier(node, tier);
+		goto out;
+	}
+
+	if (current_tier->dev.id == tier)
 		goto out;
 
 	node_clear(node, current_tier->nodelist);
-- 
2.36.1

