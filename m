Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3798A58C5A9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiHHJcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236299AbiHHJbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC212D36;
        Mon,  8 Aug 2022 02:31:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27870KnK005136;
        Mon, 8 Aug 2022 09:31:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=Z64gEbXhIUyJB1i41m/0rpOjV+n3dszOGykx64QPz98=;
 b=iOyv3+EN4SLpOy4y9vNJcEb0o+XQ9IrrSGsaAIQwLeDTzScmSBq60RK8vD3TxGWW1YeZ
 Kjvik78/oEGm8p/P6fZ1MGX1NxaiqMUIc+89rhC6ueLuncFHjlsUSWjgpBJiuSPjtdhk
 wsHKJBFBncpbl/VtaOD0mpr5UFClOBl01pFon9qfXPhCmlugKsvNUIpfPTUY3MZlmqoi
 OQhS7T4N9KpfEurD4KVO5GD6Yb6hOM8P3WWY+A2tcvIXhzDC5JuxE3fD6gkbTQw1QUTw
 65AHZjnUdTJ6eRMczDTnB4PoG5k7WnzKwkT0CPDUw3eXUFFpCwe0nnraieLfLIed5xOo EQ== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hshfttyt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:31:00 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789Uuu0018445;
        Mon, 8 Aug 2022 09:30:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpm7-1;
        Mon, 08 Aug 2022 09:30:56 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789UuAr018438;
        Mon, 8 Aug 2022 09:30:56 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789UuZN018437;
        Mon, 08 Aug 2022 09:30:56 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id D38D2900883; Mon,  8 Aug 2022 15:00:55 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH V2 3/7] venus : CAPTURE Plane width/height alignment with OUT plane.
Date:   Mon,  8 Aug 2022 14:58:30 +0530
Message-Id: <20220808092834.29775-4-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Jj5hsZA_lNWyAmfVpN0zdlHKPvjSJrvg
X-Proofpoint-GUID: Jj5hsZA_lNWyAmfVpN0zdlHKPvjSJrvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_06,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxlogscore=748 mlxscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208080047
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

V4l2 encoder compliance set-format test cases failing as Capture plane
width/height not aligned to OUT plane .

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 21bff25e3f814..b56960d7f6c89 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -192,10 +192,8 @@ venc_try_fmt_common(struct venus_inst *inst, struct v4l2_format *f)
 	pixmp->height = clamp(pixmp->height, frame_height_min(inst),
 			      frame_height_max(inst));
 
-	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-		pixmp->width = ALIGN(pixmp->width, 128);
-		pixmp->height = ALIGN(pixmp->height, 32);
-	}
+	pixmp->width = ALIGN(pixmp->width, 128);
+	pixmp->height = ALIGN(pixmp->height, 32);
 
 	pixmp->width = ALIGN(pixmp->width, 2);
 	pixmp->height = ALIGN(pixmp->height, 2);
-- 
2.17.1

