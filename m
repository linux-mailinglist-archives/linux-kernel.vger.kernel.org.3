Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FED157AF87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbiGTDid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbiGTDi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:38:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F11D67C9B
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 20:38:28 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K3Uumm020633;
        Wed, 20 Jul 2022 03:38:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=gsR6I8osL8eAXg8fLVzTijKxucAs899OVQY/ZsjyLjA=;
 b=SC++uzGNH+AzTOSwUVyWaGF+DRTKmEodnD2RuCrK7t/yfYE1n3hpoApvhJdetJdutBQh
 1KAo/qmwSQClmjVOD+oiltex8Qk1g0PzaEsxwy7UApnQqoSQfKi24ZQRXrgYMDS67psE
 mu599VMBBr+/FpVAIoIZ6AkzgNPsP2p7nDcWbcTzE8YW0h/ZMbs9KU8gpXEGxU9DJM7N
 8J2rooc13vzodopdWQghdPRP0BDncRY+ufg8ATWQcBKuNadARrAgs4V05l9Lela71ZcC
 0jsm9V+sA3c1vQgults5WbHRVtATLugRDsEiOQ4ymomPKfpAffKVL7l66RU4hWUvnegL tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9va05gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:38:16 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 26K3cFVq003248;
        Wed, 20 Jul 2022 03:38:15 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3he9va05ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:38:15 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26K3ZSlT027791;
        Wed, 20 Jul 2022 03:38:14 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 3hbmy9myx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Jul 2022 03:38:14 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26K3cDad2097732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 03:38:13 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 979C9B2064;
        Wed, 20 Jul 2022 03:38:13 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3149FB2066;
        Wed, 20 Jul 2022 03:38:08 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.15.129])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Jul 2022 03:38:07 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
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
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v10 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
In-Reply-To: <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
References: <20220720025920.1373558-1-aneesh.kumar@linux.ibm.com>
 <20220720025920.1373558-6-aneesh.kumar@linux.ibm.com>
Date:   Wed, 20 Jul 2022 09:08:02 +0530
Message-ID: <874jzch2sl.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xqM7KWL0D-bB-oAoGQTN5bHYolLwwGk4
X-Proofpoint-ORIG-GUID: dZAGHiSBRZIQkkxutx9ZDUMA6Km7mElT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1015 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200013
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I missed folding a list walking fix. Use this diff on top
for testing.

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index b2da34a1f06c..f3d720b7dc6c 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -300,12 +300,12 @@ static void establish_migration_targets(void)
 		nd = &node_demotion[node];
 
 		memtier = __node_get_memory_tier(node);
-		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
+		if (!memtier || list_is_first(&memtier->list, &memory_tiers))
 			continue;
 		/*
 		 * Get the next memtier to find the  demotion node list.
 		 */
-		memtier = list_next_entry(memtier, list);
+		memtier = list_prev_entry(memtier, list);
 
 		/*
 		 * find_next_best_node, use 'used' nodemask as a skip list.
@@ -342,7 +342,7 @@ static void establish_migration_targets(void)
 	 * Once we detect such a memory tier, we consider that tier
 	 * as top tiper from which promotion is not allowed.
 	 */
-	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
+	list_for_each_entry(memtier, &memory_tiers, list) {
 		nodes_and(used, node_states[N_CPU], memtier->nodelist);
 		if (!nodes_empty(used)) {
 			top_tier_id = memtier->id;
@@ -364,7 +364,7 @@ static void establish_migration_targets(void)
 	 */
 	nodes_and(lower_tier, node_states[N_MEMORY], lower_tier);
 
-	list_for_each_entry(memtier, &memory_tiers, list) {
+	list_for_each_entry_reverse(memtier, &memory_tiers, list) {
 		/*
 		 * Keep removing current tier from lower_tier nodes,
 		 * This will remove all nodes in current and above

