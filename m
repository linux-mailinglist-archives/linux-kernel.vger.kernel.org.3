Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85EA458C59E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242297AbiHHJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiHHJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6106912753;
        Mon,  8 Aug 2022 02:31:08 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2788RxEe029097;
        Mon, 8 Aug 2022 09:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=vZsfSM9/j6i7CNVMZjN+f/cqj1ACxwXTGFg+hp5We/M=;
 b=HKo3edkRcggEaQBCfGnspp6oqks75BK08dRiUV7RXQmom5AUBW5mKRdnnTjqafSVSOiR
 kPiebKRqSNIBK6hS5mlPv6EYVZYGbZMnq2qoyLew3fCDAME0aZmjSaOEEVvDjqFj5Z/b
 JnxqELdqCGX0EDVQzDHpl34O94NJnD2c0ycj9vJjJiCV4g6seaLAZ2jyV5ZSoPUBBUIl
 7asuNSGAJLVltnPA+ncAxWjbdxHtzzXT2FqTMOZXkd8H9hj59bPsr3+Ch5N3/g0BVGNw
 +WTUSEcO4qYNCHpFXBmRthia17TXJGHSGVsHVhsTBxCd282nB7F/rlIR/UG+EEiist30 2Q== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hshkeb076-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:31:05 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UsJl018419;
        Mon, 8 Aug 2022 09:31:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpn4-1;
        Mon, 08 Aug 2022 09:31:02 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789V2cb018521;
        Mon, 8 Aug 2022 09:31:02 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789V1gm018516;
        Mon, 08 Aug 2022 09:31:02 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 1064B900883; Mon,  8 Aug 2022 15:01:01 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vikash Garodia <vgarodia@qti.qualcomm.com>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH V2 7/7] venus : Allow MIN/MAX settings for the v4l2 encoder controls defined range.
Date:   Mon,  8 Aug 2022 14:58:34 +0530
Message-Id: <20220808092834.29775-8-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZULtPtI96q0rRhdlsUJwnYtde13FM1Dk
X-Proofpoint-GUID: ZULtPtI96q0rRhdlsUJwnYtde13FM1Dk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_06,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=803 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
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

From: Vikash Garodia <vgarodia@qti.qualcomm.com>

Control MIN/MAX range defined as 0 to 1, as MIN value setting enabled
for V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM.

error details: fail: v4l2-test-controls.cpp(516): 
invalid maximum range check

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Vikash Garodia <vgarodia@qti.qualcomm.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc_ctrls.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index b4437cf598ff1..e55f7a0b39608 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -334,8 +334,6 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 		 * if we disable 8x8 transform for HP.
 		 */
 
-		if (ctrl->val == 0)
-			return -EINVAL;
 
 		ctr->h264_8x8_transform = ctrl->val;
 		break;
-- 
2.17.1

