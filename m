Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A758C5A6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiHHJcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242534AbiHHJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98F6120AB;
        Mon,  8 Aug 2022 02:31:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2787vJLD025525;
        Mon, 8 Aug 2022 09:31:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=zl3irBg/z4QGb3+uNSvVLIDcLrd8/VEmoZftPBxEvME=;
 b=HPFb2ZjMhRtVnSV7Jc63IwgXafJeC0L3Xv1i33lBkSSe4mZi+HPYy7mje9LUG+JegVQ/
 2CPixXk7da1ule21/X8Z2y6N5TUnJsaT3+l6c+JiB/ndj5rkcAhjv+QFxtYGPcLSOqj9
 OhZ+Dsx6qsUdKUwEtUZkf8erqOlL3nnrP+ijNwhukl8mw682ENmBmDYm0f+ZWkLFvpBk
 WhVvBNzAj8k0XHfFg8U1Kl7/b9rqbBkaopXbCjhuFrfEk8MT7fBSRFYNMYvjB1aC7H4v
 g7Ih/SadWsbKmImkefyoGJv/Fyp4W0WSJucpRwJTnFhhdFh60CTx5VKMQ4s2jn4hKXyn rA== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hsh2n31ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:31:02 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UsJj018419;
        Mon, 8 Aug 2022 09:30:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpmn-1;
        Mon, 08 Aug 2022 09:30:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789Uxtl018470;
        Mon, 8 Aug 2022 09:30:59 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789Ux2n018469;
        Mon, 08 Aug 2022 09:30:59 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 69CA3900883; Mon,  8 Aug 2022 15:00:58 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH V2 5/7] venus : Addition of support for VIDIOC_TRY_ENCODER_CMD
Date:   Mon,  8 Aug 2022 14:58:32 +0530
Message-Id: <20220808092834.29775-6-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _7phCRHd4R5DvCsqv5BfHST2P1a7TR3x
X-Proofpoint-ORIG-GUID: _7phCRHd4R5DvCsqv5BfHST2P1a7TR3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208080047
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

v4l2 compliance expecting support for vidioc_try_encoder_cmd .

error details : test VIDIOC_(TRY_)ENCODER_CMD: FAIL

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 drivers/media/platform/qcom/venus/venc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 17312d316f93d..966f41f3603ec 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -588,6 +588,7 @@ static const struct v4l2_ioctl_ops venc_ioctl_ops = {
 	.vidioc_subscribe_event = venc_subscribe_event,
 	.vidioc_unsubscribe_event = v4l2_event_unsubscribe,
 	.vidioc_encoder_cmd = venc_encoder_cmd,
+	.vidioc_try_encoder_cmd = v4l2_m2m_ioctl_try_encoder_cmd,
 };
 
 static int venc_pm_get(struct venus_inst *inst)
-- 
2.17.1

