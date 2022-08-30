Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4C5A5DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiH3IP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH3IP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:15:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521166446
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:15:27 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U7wqp1032408;
        Tue, 30 Aug 2022 08:15:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Nvw7+EdkkyhknysMScLPafiaExuYZPA4g6Y9MtEHr5M=;
 b=qlUiuD8Q4Jv10lvMd4u93MQ3B6vjRFqUcbIGxT5LcUDA1K+tot+jcvGwejvd/5y0wN+V
 yrMoYFioNKQzJ7/hvB7nZx1ihtM5Zlj7Kmb/qlMq3JTeEFXzv4xwecTFPmaJEyrLxLA+
 43lUafnSSCvVNBTuqUYXO/maKutx9gT9MG2bkam73k8LcPcO2LhEdLP862mpVFDU9wP6
 0E1Nao9n9ZvIEmiGyz3GSZxKJL0bP1emexkiGzYgQ/Egeb2DU673Wvw9d1wNucedsZQl
 4ERpO9quxVRXtIXfOM+HL8ByEzY+g0ZPTxp7xvsWdWqbW+7tYcdKFjUYGROfU16POU3a aA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9emx8q1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 08:15:12 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27U800uK005045;
        Tue, 30 Aug 2022 08:15:12 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j9emx8q10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 08:15:11 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U850md006503;
        Tue, 30 Aug 2022 08:15:10 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 3j7aw9pyje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 08:15:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U8F9Cm53543354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 08:15:10 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4A902805A;
        Tue, 30 Aug 2022 08:15:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2CCF28059;
        Tue, 30 Aug 2022 08:15:03 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.77.247])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 08:15:03 +0000 (GMT)
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
Subject: [PATCH mm-unstable] mm/demotion: Make toptier_distance inclusive upper bound of toptiers
Date:   Tue, 30 Aug 2022 13:44:57 +0530
Message-Id: <20220830081457.118960-1-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gXQk2Br2uqwkmmQA3QUipJeTwT080boP
X-Proofpoint-ORIG-GUID: WQC1rrHFjpPZSua_uVPsc-G3TLmEbjwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208300038
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on suggestion from Wei Xu <weixugc@google.com>, having an
inclusive upper bound is found simpler.

Fixes: mm/demotion: Update node_is_toptier to work with memory tiers
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 mm/memory-tiers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c4bd6d052a33..c82eb0111383 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -179,7 +179,7 @@ bool node_is_toptier(int node)
 		toptier = true;
 		goto out;
 	}
-	if (memtier->adistance_start < top_tier_adistance)
+	if (memtier->adistance_start <= top_tier_adistance)
 		toptier = true;
 	else
 		toptier = false;
@@ -361,7 +361,8 @@ static void establish_demotion_targets(void)
 			 * abstract distance below the max value of this memtier
 			 * is considered toptier.
 			 */
-			top_tier_adistance = memtier->adistance_start + MEMTIER_CHUNK_SIZE;
+			top_tier_adistance = memtier->adistance_start +
+						MEMTIER_CHUNK_SIZE - 1;
 			break;
 		}
 	}
-- 
2.37.2

