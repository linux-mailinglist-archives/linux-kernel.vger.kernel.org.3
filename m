Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4A487808
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347506AbiAGNMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:12:30 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:65434 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiAGNM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641561148; x=1673097148;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lELRMbaae1MDrByiI2DpifmQm298m0NFohpEVy3ojzs=;
  b=oULxQuI5aNxSx7yeHSGCFqY2+D14sbZr06L2WBH9InXN3r10Q7tsj4Q9
   NRPHjOuRq36jddgbuq8Sac8Rzt960JF1RAwnKif2YdQUpFtOzugyN48Ms
   w5FcIMdfHMCNhHffVoZN2y/47nF4tUBAH60EGtsxb8Oyg2me13WVfydIF
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Jan 2022 05:12:28 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 07 Jan 2022 05:12:26 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 07 Jan 2022 18:42:24 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 40116422C; Fri,  7 Jan 2022 18:42:23 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH 2/2] venus: venc: Add support for intra-refresh mode
Date:   Fri,  7 Jan 2022 18:42:04 +0530
Message-Id: <1641561124-19476-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1641561124-19476-1-git-send-email-quic_dikshita@quicinc.com>
References: <1641561124-19476-1-git-send-email-quic_dikshita@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for intra-refresh type v4l2 control.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h       |  1 +
 drivers/media/platform/qcom/venus/venc.c       |  3 ++-
 drivers/media/platform/qcom/venus/venc_ctrls.c | 10 ++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index 7c3bac0..814ec3c 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -260,6 +260,7 @@ struct venc_controls {
 
 	u32 header_mode;
 	bool aud_enable;
+	u32 intra_refresh_mode;
 	u32 intra_refresh_period;
 
 	struct {
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 84bafc3..e8b8135 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -893,8 +893,9 @@ static int venc_set_properties(struct venus_inst *inst)
 				mbs++;
 			mbs /= ctr->intra_refresh_period;
 
-			intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
 			intra_refresh.cir_mbs = mbs;
+			if (ctr->intra_refresh_mode == V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM)
+				intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
 		}
 
 		ptype = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH;
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 1ada42d..da5e54f 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -316,6 +316,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY:
 		ctr->mastering = *ctrl->p_new.p_hdr10_mastering;
 		break;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
+		ctr->intra_refresh_mode = ctrl->val;
+		break;
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
 		ctr->intra_refresh_period = ctrl->val;
 		break;
@@ -582,6 +585,13 @@ int venc_ctrl_init(struct venus_inst *inst)
 				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
 				   v4l2_ctrl_ptr_create(NULL));
 
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_NONE,
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM,
+		~((1 << V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_NONE) |
+		  (1 << V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM)),
+		V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
 			  ((4096 * 2304) >> 8), 1, 0);
-- 
2.7.4

