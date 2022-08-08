Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E78058C34F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbiHHG2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbiHHG1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:27:41 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E2D13CC6
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:27:25 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2786C77u002741;
        Mon, 8 Aug 2022 06:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Vq7NtUTGJv/Btzc/7iihSXrYrrCuEc0Ypk+wO/4fJgU=;
 b=soa81K6XdewrUquilSEzClnmi/ZW8Kdv6mDGIpoNcg+UtQsxSSaOP7omH61HiP4L1bGw
 +yKLWlrRBdK9GaGWhv3AXCivi1Y1Jz7u5QTO5DKVEXtrJNUnAO99Qxwfv3D6xWTnNfcG
 Wrpl6pT9HjOf5i24mYT8fqstIgbN4o6Jk+cCsBO35r6RisBnJTN+9P8j7QpZTzMs83VC
 k0VkYdyM8KSgAwMiZ71LA+VUn0+ChjYcaKtp8uYh/OYBonvC83Y0tQM9itBqAtufi37Z
 zctPMurlfQCT+cen8QCVgHgjs0SwsU48VVys0mjIU5J9gw398NGz5ApNFPimIlYt1HgK 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3htw0mrbeh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:27:15 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2786Dqh5012289;
        Mon, 8 Aug 2022 06:27:14 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3htw0mrbdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:27:14 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2786KJNs015604;
        Mon, 8 Aug 2022 06:27:13 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3hsfx9wh2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 06:27:13 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2786RCoB36372986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Aug 2022 06:27:12 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3802C7805E;
        Mon,  8 Aug 2022 06:27:12 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6050C7805F;
        Mon,  8 Aug 2022 06:27:06 +0000 (GMT)
Received: from skywalker.ibmuc.com (unknown [9.43.19.76])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  8 Aug 2022 06:27:06 +0000 (GMT)
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
Subject: [PATCH v13 9/9] lib/nodemask: Optimize node_random for nodemask with single NUMA node
Date:   Mon,  8 Aug 2022 11:56:01 +0530
Message-Id: <20220808062601.836025-10-aneesh.kumar@linux.ibm.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
References: <20220808062601.836025-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: t1KZaO_Yul7vT8aqZ_tnU9bCL67z8lYx
X-Proofpoint-ORIG-GUID: qk0acrlX4inmpnQSAoP_SET7g4Q8bi1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_03,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The most common case for certain node_random usage (demotion nodemask) is with
nodemask weight 1. We can avoid calling get_random_init() in that case and
always return the only node set in the nodemask.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 lib/nodemask.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/lib/nodemask.c b/lib/nodemask.c
index e22647f5181b..c91a6b0404a5 100644
--- a/lib/nodemask.c
+++ b/lib/nodemask.c
@@ -20,12 +20,21 @@ EXPORT_SYMBOL(__next_node_in);
  */
 int node_random(const nodemask_t *maskp)
 {
-	int w, bit = NUMA_NO_NODE;
+	int w, bit;
 
 	w = nodes_weight(*maskp);
-	if (w)
+	switch (w) {
+	case 0:
+		bit = NUMA_NO_NODE;
+		break;
+	case 1:
+		bit = __first_node(maskp);
+		break;
+	default:
 		bit = bitmap_ord_to_pos(maskp->bits,
-			get_random_int() % w, MAX_NUMNODES);
+					get_random_int() % w, MAX_NUMNODES);
+		break;
+	}
 	return bit;
 }
 #endif
-- 
2.37.1

