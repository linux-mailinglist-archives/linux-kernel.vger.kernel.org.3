Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C150590BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 07:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237137AbiHLF64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 01:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237135AbiHLF6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 01:58:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F3A50D6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 22:58:27 -0700 (PDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C50Ae5015871;
        Fri, 12 Aug 2022 05:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=8MUECjGMQSujdaH/0eT6z2m/wiSwOVQCRwGN49PAYsU=;
 b=rjJCMrTHKGMSE0Y/C7BHsyGCnlRwEVakXLzbpkUg1Z0J+Vxtm9hAwc7c4+yJPgk6NacU
 sFHOQgxoL26/wYdzGAMEWB1X+b4AktRVaWdSjKZETIYQ0Am0G1KjRsp35xubwoJ11xjh
 RL3BNRLFb8XBc64GCMy3ODY1j34X/fgZByFcXTacfwN5c8cJoOuMTZuTIq/MuRFzwI/H
 UtN9PNAmDtAvOAGePiSBl5qJKaOUSkHSdI2lNb4sNHCNAGpkHTm0o+U3xDKC8Fbhv6+z
 LKhEXU8A6tZmiv0qq+TbppAdih8MOgb8MkSJFifKgPUsy/l3oiAOJa0ZayjITC+uJuFi 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwgb69ec1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:09 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27C5lTL5032173;
        Fri, 12 Aug 2022 05:58:09 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hwgb69eb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:08 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27C5aVlk028489;
        Fri, 12 Aug 2022 05:58:07 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04wdc.us.ibm.com with ESMTP id 3huww47c9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Aug 2022 05:58:07 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27C5w6Tx62849458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Aug 2022 05:58:06 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2849578063;
        Fri, 12 Aug 2022 05:58:06 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7C4F7805F;
        Fri, 12 Aug 2022 05:58:00 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.116.179])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 12 Aug 2022 05:58:00 +0000 (GMT)
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
Subject: [PATCH v14 07/10] mm/demotion: Drop memtier from memtype
Date:   Fri, 12 Aug 2022 11:27:06 +0530
Message-Id: <20220812055710.357820-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
References: <20220812055710.357820-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hWKKUk7g7nnxI1cxVL-RwTq-y2vreQAa
X-Proofpoint-ORIG-GUID: vHZqsdKczvJaMhBT17wCrLpA7DN7nj_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208120015
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we track node-specific memtier in pg_data_t, we can drop
memtier from memtype.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 -
 mm/memory-tiers.c            | 16 +++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index d0490ea4e35b..dd86323d2ba0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -25,7 +25,6 @@ struct memory_dev_type {
 	/* Nodes of same abstract distance */
 	nodemask_t nodes;
 	struct kref kref;
-	struct memory_tier *memtier;
 };
 
 #ifdef CONFIG_NUMA
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 315b9fe14c48..9d53d4c14a5e 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -100,17 +100,22 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 
 	lockdep_assert_held_once(&memory_tier_lock);
 
+	adistance = round_down(adistance, memtier_adistance_chunk_size);
 	/*
 	 * If the memtype is already part of a memory tier,
 	 * just return that.
 	 */
-	if (memtype->memtier)
-		return memtype->memtier;
+	if (!list_empty(&memtype->tier_sibiling)) {
+		list_for_each_entry(memtier, &memory_tiers, list) {
+			if (adistance == memtier->adistance_start)
+				return memtier;
+		}
+		WARN_ON(1);
+		return ERR_PTR(-EINVAL);
+	}
 
-	adistance = round_down(adistance, memtier_adistance_chunk_size);
 	list_for_each_entry(memtier, &memory_tiers, list) {
 		if (adistance == memtier->adistance_start) {
-			memtype->memtier = memtier;
 			list_add(&memtype->tier_sibiling, &memtier->memory_types);
 			return memtier;
 		} else if (adistance < memtier->adistance_start) {
@@ -130,7 +135,6 @@ static struct memory_tier *find_create_memory_tier(struct memory_dev_type *memty
 		list_add_tail(&new_memtier->list, &memtier->list);
 	else
 		list_add_tail(&new_memtier->list, &memory_tiers);
-	memtype->memtier = new_memtier;
 	list_add(&memtype->tier_sibiling, &new_memtier->memory_types);
 	return new_memtier;
 }
@@ -357,7 +361,6 @@ static bool clear_node_memory_tier(int node)
 		node_clear(node, memtype->nodes);
 		if (nodes_empty(memtype->nodes)) {
 			list_del(&memtype->tier_sibiling);
-			memtype->memtier = NULL;
 			if (list_empty(&memtier->memory_types))
 				destroy_memory_tier(memtier);
 		}
@@ -385,7 +388,6 @@ struct memory_dev_type *alloc_memory_type(int adistance)
 	memtype->adistance = adistance;
 	INIT_LIST_HEAD(&memtype->tier_sibiling);
 	memtype->nodes  = NODE_MASK_NONE;
-	memtype->memtier = NULL;
 	kref_init(&memtype->kref);
 	return memtype;
 }
-- 
2.37.1

