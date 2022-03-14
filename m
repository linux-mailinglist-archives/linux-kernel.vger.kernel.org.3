Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4F64D7C45
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 08:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbiCNHyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 03:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236591AbiCNHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:54:42 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0752932EDD;
        Mon, 14 Mar 2022 00:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647244413; x=1678780413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vm5DiUTCEYkRlWg/Yqxo3brxvgvVfzsEds8Oz6/FlS0=;
  b=Yqz/FP6blyrpJzyKdE8R5lOb6hLnDKcA4f8fjmm940HiDuX6gBwypSNP
   Yd7S71lfnwjcplorlyUtAlzswAR9pv3BKR4bRRcfbfyBUjPvpAgHn0TsW
   8v5j2+0MbS5q1AaoOaOhzGGaGFV/aUUnAPkfxUjJOgcwypcuVFMl1z/Kx
   A=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 14 Mar 2022 00:53:33 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 14 Mar 2022 00:53:31 -0700
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg02-blr.qualcomm.com with ESMTP; 14 Mar 2022 13:23:22 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 80A004679; Mon, 14 Mar 2022 13:23:21 +0530 (+0530)
From:   quic_dikshita@quicinc.com
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 2/2] venus: venc: Add support for intra-refresh mode
Date:   Mon, 14 Mar 2022 13:23:04 +0530
Message-Id: <1647244384-19918-3-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647244384-19918-1-git-send-email-quic_dikshita@quicinc.com>
References: <1647244384-19918-1-git-send-email-quic_dikshita@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add support for intra-refresh type v4l2 control.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/core.h       | 1 +
 drivers/media/platform/qcom/venus/venc.c       | 3 ++-
 drivers/media/platform/qcom/venus/venc_ctrls.c | 8 ++++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

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
index 1ada42d..c54b46f 100644
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
@@ -582,6 +585,11 @@ int venc_ctrl_init(struct venus_inst *inst)
 				   V4L2_CID_COLORIMETRY_HDR10_MASTERING_DISPLAY,
 				   v4l2_ctrl_ptr_create(NULL));
 
+	v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
+			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE,
+			       V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM,
+			       0, V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM);
+
 	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
 			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
 			  ((4096 * 2304) >> 8), 1, 0);
-- 
2.7.4

