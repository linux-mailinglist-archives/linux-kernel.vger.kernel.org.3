Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60C95A443D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiH2Hyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiH2Hys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:54:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F015819;
        Mon, 29 Aug 2022 00:54:41 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7KUOO008292;
        Mon, 29 Aug 2022 07:54:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id; s=qcppdkim1;
 bh=mSNL2H0decErmIQPzyx2yynJ3rX6kVbXcPJeGbUDOfE=;
 b=nfbcHDEbLA0pihPMA/qtMz8fRi9QAgy46PR9lEDdvdxsJGeQtwhvyxVUZsdvWAPCR8As
 4aHOsemKsYZtO4R0wHhRDV3yGjHWMS3X+Hwb36yUOjtiFbda7kq8ZOIwp3Be1mKtD9Kr
 Jdpm487oxLYM4EeDgxDKvGxETBxh3d5o0HdtXJI4/IkRkGABoYvll14g0/hWtmSq/2YN
 8AWEEEp9OnvV/bYV0SljMU5IlX6PJyWVJh3XbsTPfvDMTQYGH/YrQ4ryoGC1FVpg8CX9
 1zW39EghCiQ8/fNXuHElw0lZQEbg7IXTh/68U4PHZIUOtUTLtF+cxldtmaus1mIaPJ91 DA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3j7bc1bxu1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 07:54:40 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 27T7saqv010194;
        Mon, 29 Aug 2022 07:54:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3j7cbkg5dn-1;
        Mon, 29 Aug 2022 07:54:36 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27T7saTj010188;
        Mon, 29 Aug 2022 07:54:36 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 27T7sZ7W010187;
        Mon, 29 Aug 2022 07:54:36 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 4811F4857; Mon, 29 Aug 2022 13:24:35 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] Allow S/G_PARM for stateful decoder
Date:   Mon, 29 Aug 2022 13:24:30 +0530
Message-Id: <1661759670-19902-1-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: jgUeQlTTCWxNfhTq1X3XvFiKMPWcaqNl
X-Proofpoint-GUID: jgUeQlTTCWxNfhTq1X3XvFiKMPWcaqNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=525 mlxscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290038
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some stateful decoder supports S/G_PARM similar to a
stateful encoder. S_PARM(OUTPUT) reserves hardware decoder
resources, and G_PARM(CAPTURE) returns the embedded
frame interval. Allow the same with this change.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 utils/v4l2-compliance/v4l2-test-formats.cpp | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/utils/v4l2-compliance/v4l2-test-formats.cpp b/utils/v4l2-compliance/v4l2-test-formats.cpp
index 269a383..e996558 100644
--- a/utils/v4l2-compliance/v4l2-test-formats.cpp
+++ b/utils/v4l2-compliance/v4l2-test-formats.cpp
@@ -64,8 +64,6 @@ static int testEnumFrameIntervals(struct node *node, __u32 pixfmt,
 		ret = doioctl(node, VIDIOC_ENUM_FRAMEINTERVALS, &frmival);
 		if (ret == ENOTTY)
 			return ret;
-		// M2M devices don't support this, except for stateful encoders
-		fail_on_test(node->is_m2m && !(node->codec_mask & STATEFUL_ENCODER));
 		if (f == 0 && ret == EINVAL) {
 			if (type == V4L2_FRMSIZE_TYPE_DISCRETE)
 				warn("found framesize %dx%d, but no frame intervals\n", w, h);
@@ -1367,8 +1365,6 @@ static int testParmType(struct node *node, unsigned type)
 	}
 	if (ret == ENOTTY)
 		return ret;
-	// M2M devices don't support this, except for stateful encoders
-	fail_on_test(node->is_m2m && !is_stateful_enc);
 	if (ret == EINVAL)
 		return ENOTTY;
 	if (ret)
-- 
2.7.4

