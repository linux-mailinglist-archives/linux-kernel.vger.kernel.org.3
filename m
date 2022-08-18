Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD1E5983DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244954AbiHRNNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244802AbiHRNMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:12:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67E2B2D8D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:12:49 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27ICijSP025680;
        Thu, 18 Aug 2022 13:11:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LIDo6CqydH8lG4GOng8n1y97XLjFtFkKiq31uguX6/0=;
 b=nMKsU+ARNQiYqZvXpnW/kzFMz06fu9QR913yYDC6tDT8r8RxlToakrdHy1Fu9MdbIOF3
 2BALmMSwVlCEBbd5uzntqIOe2MMbpHxN2tZeeVxhVFhmbQEZXXbs13szjASn6c7s0Gsn
 ajGP3KqzPDOmaxx7KQ6YhSmEOpvpkWDriAOFPgmUKi53KtPFDGop3uXsoG9+RNVOllxx
 CWWzU7c+UhkCn5Z6hV3gc3sOg50sarfHt0DigNkeELZWdIYtsA8/Qd6S3aFX70wtvpw9
 X2J8uTnytXNh86th3etjQhksW/SEt8Ud4dqzDtKW3IiozDf+vydGE3GtdXHNtKspamGS mA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1npxgxrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:40 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27ICnQhJ039833;
        Thu, 18 Aug 2022 13:11:39 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j1npxgxqr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:39 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27ID6iTt000651;
        Thu, 18 Aug 2022 13:11:37 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3hx3k9y180-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 13:11:37 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27IDBbNS262846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 13:11:37 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7920E124053;
        Thu, 18 Aug 2022 13:11:37 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84B19124052;
        Thu, 18 Aug 2022 13:11:32 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.111.107])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 18 Aug 2022 13:11:32 +0000 (GMT)
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
Subject: [PATCH v15 07/10] mm/demotion: Drop memtier from memtype
Date:   Thu, 18 Aug 2022 18:40:39 +0530
Message-Id: <20220818131042.113280-8-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
References: <20220818131042.113280-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LppKjg5JzG-s2wSh-KGKpU7kVJGuptNi
X-Proofpoint-GUID: kXSCFxrp07fCnSLcM_3IuSn8kxNCc6_X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_12,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180045
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

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 include/linux/memory-tiers.h |  1 -
 mm/memory-tiers.c            | 16 +++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 548e69f23727..108083d74557 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -28,7 +28,6 @@ struct memory_dev_type {
 	/* Nodes of same abstract distance */
 	nodemask_t nodes;
 	struct kref kref;
-	struct memory_tier *memtier;
 };
 
 #ifdef CONFIG_NUMA
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index 2b7e91b45a75..455c104fab5d 100644
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
2.37.2

