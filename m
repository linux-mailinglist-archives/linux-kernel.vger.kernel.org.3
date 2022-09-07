Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E1A5AFE63
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiIGICM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbiIGIBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:01:35 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49862A9C0B
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:01:32 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2877icrp014506;
        Wed, 7 Sep 2022 08:01:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=kVGBhnmmVLaHsutvMDyoZ6zUGI/cfItdEBWL5jrgzrs=;
 b=NXJOwgjwrnnfvpccDtjCSByUVZtHx318iPVit2cn155g4PrFJS5BVvmchTZo0l/eWDdb
 qlwET6ewxg7dpu4FGk+ZOyJQnbI+L+gJMBXI5+cplbMFaOaKg/YOhstTBCGfdfZajFfI
 W6RbaqOfRQ0Z6BrVmhpA0JXWbbc/byn1DRlTW2iJXBmgUUnu0koZdsr+7lx2CSicgbxd
 4kXTL8hRBhGE6YOaRldsE/cBnP/MJTHqZ7kroMQnYtZEM+ww1bRVIGQFGX5Pz1mIwyyX
 uOtps3otqvZ1PeH+O2NJ/tfH5MefLM044TeHc8YTHJA4rbkV6IMLTdx74o+g41Iycr4H LQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3je25nukps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Sep 2022 08:01:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28781SMD031449
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 08:01:28 GMT
Received: from zhenhuah-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 7 Sep 2022 01:01:26 -0700
From:   Zhenhua Huang <quic_zhenhuah@quicinc.com>
To:     <akpm@linux-foundation.org>
CC:     Zhenhua Huang <quic_zhenhuah@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] mm/page_owner.c: remove redudant drain_all_pages
Date:   Wed, 7 Sep 2022 16:01:13 +0800
Message-ID: <1662537673-9392-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xnoyN8B2iXRIzLILMg82jI9AAG_v1Rxu
X-Proofpoint-GUID: xnoyN8B2iXRIzLILMg82jI9AAG_v1Rxu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-07_04,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0 mlxlogscore=887
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209070034
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page owner info of pages in pcp list have already been reset:
	free_unref_page
		-> free_unref_page_prepare
			-> free_pcp_prepare
				-> free_pages_prepare which do page owner
				reset
		-> free_unref_page_commit which add pages into pcp list
It can also be confirmed from dump that page owner info of pcp pages are
correct. Hence there is no more need to drain when reading.

Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
---
 mm/page_owner.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 90023f9..54f3e03 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -524,8 +524,6 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	while (!pfn_valid(pfn) && (pfn & (MAX_ORDER_NR_PAGES - 1)) != 0)
 		pfn++;
 
-	drain_all_pages(NULL);
-
 	/* Find an allocated page */
 	for (; pfn < max_pfn; pfn++) {
 		/*
-- 
2.7.4

