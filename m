Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FCC58C5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242438AbiHHJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242532AbiHHJbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 05:31:08 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6633665A9;
        Mon,  8 Aug 2022 02:31:07 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2786wNv9021703;
        Mon, 8 Aug 2022 09:30:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=feaQMUU/dIwodf77cnnO/x5t97/zBR762ziYG1gb9wQ=;
 b=EOWx67QUM+i/uzki7WFdo2Gc3dptHNjIhfwiFqmGfAmtpd76cN4LSa8DqiUT2EW9Cac3
 rRgduRTnGCDcB2I1n62wu/76mOXKJ1ZCi1XTFjFfwSBZBCedLal8RT+KpC5q6jUXuH6C
 6rvu1chwecBFhvKiZovmZn8yBEPWwrqGI9DZ0j5gxjZgRdrg9Iz5SstjtYdYfzK1XJls
 XYZT4UKaKGjChhXee8WprtsHLNqRhzrkzEN8eTpycgTAim4y0lXisGBb4IJIJI/J5sk+
 IzrjWXp30ZeG1txnn4Fj7uHU9cZkm0gqwJlvb5iiYi/cPti10vf/IB36tI93G0WxYIsQ Gg== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3hse0nu8yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Aug 2022 09:30:58 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 2789UtUA018432;
        Mon, 8 Aug 2022 09:30:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3hshckgpm1-1;
        Mon, 08 Aug 2022 09:30:55 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2789UtWj018426;
        Mon, 8 Aug 2022 09:30:55 GMT
Received: from vboma-linux.qualcomm.com (vboma-linux.qualcomm.com [10.204.65.94])
        by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 2789UtPi018425;
        Mon, 08 Aug 2022 09:30:55 +0000
Received: by vboma-linux.qualcomm.com (Postfix, from userid 72083)
        id 8A4B3900883; Mon,  8 Aug 2022 15:00:54 +0530 (IST)
From:   quic_vboma@quicinc.com
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Viswanath Boma <quic_vboma@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH V2 2/7] venus : Addition of control support - V4L2_CID_MIN_BUFFERS_FOR_OUTPUT
Date:   Mon,  8 Aug 2022 14:58:29 +0530
Message-Id: <20220808092834.29775-3-quic_vboma@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220808092834.29775-1-quic_vboma@quicinc.com>
References: <20220712122347.6781-1-quic_vboma@quicinc.com>
 <20220808092834.29775-1-quic_vboma@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lckIVm8S9YiDmDbsINqOokdvyFa1xN6I
X-Proofpoint-ORIG-GUID: lckIVm8S9YiDmDbsINqOokdvyFa1xN6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-08_05,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999 impostorscore=0
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

From: Viswanath Boma <quic_vboma@quicinc.com>

V4l2 encoder compliance expecting minimum buffers support for 
the application to allocate buffers as per the control support values.

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../media/platform/qcom/venus/venc_ctrls.c    | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index aa44c0b3ceb57..b4437cf598ff1 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -8,6 +8,7 @@
 
 #include "core.h"
 #include "venc.h"
+#include "helpers.h"
 
 #define BITRATE_MIN		32000
 #define BITRATE_MAX		160000000
@@ -345,8 +346,29 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int venc_op_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct venus_inst *inst = ctrl_to_inst(ctrl);
+	struct hfi_buffer_requirements bufreq;
+	enum hfi_version ver = inst->core->res->hfi_version;
+	int ret;
+
+	switch (ctrl->id) {
+	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
+		ret = venus_helper_get_bufreq(inst, HFI_BUFFER_INPUT, &bufreq);
+		if (!ret)
+			ctrl->val = HFI_BUFREQ_COUNT_MIN(&bufreq, ver);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops venc_ctrl_ops = {
 	.s_ctrl = venc_op_s_ctrl,
+	.g_volatile_ctrl = venc_op_g_volatile_ctrl,
 };
 
 int venc_ctrl_init(struct venus_inst *inst)
@@ -357,7 +379,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 		{ 16000, 34500, 3000 }, 15635, 16450, 10000000, 500,
 	};
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 58);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 59);
 	if (ret)
 		return ret;
 
@@ -437,6 +459,9 @@ int venc_ctrl_init(struct venus_inst *inst)
 		V4L2_MPEG_VIDEO_VP8_PROFILE_3,
 		0, V4L2_MPEG_VIDEO_VP8_PROFILE_0);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 4, 11, 1, 4);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 		V4L2_CID_MPEG_VIDEO_BITRATE, BITRATE_MIN, BITRATE_MAX,
 		BITRATE_STEP, BITRATE_DEFAULT);
-- 
2.17.1

