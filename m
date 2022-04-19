Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69185063B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346708AbiDSFKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiDSFKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:10:01 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E85165AB;
        Mon, 18 Apr 2022 22:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650344840; x=1681880840;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=2FooNwxL6FD03xqTPoWADwlxnfJDakdWFI6BhQQqKoM=;
  b=CmEYXE2M84Vw0lfLIVme967VxB1FBJISHJlTxKEoRnl0VgxnFb///q+0
   Zodf2gLzXOckIzzZNXmzB1HZwoBi8M2dnu3da41A4zTiZkJBMNmL/v7RC
   gB9N9V24ajU9J79qdB4OXbP3tH6y3UJRbZnnxecW5S1mVWO2bTk4nL6TX
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 18 Apr 2022 22:07:20 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 18 Apr 2022 22:07:17 -0700
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 19 Apr 2022 10:37:09 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id D35CE434D; Tue, 19 Apr 2022 10:37:07 +0530 (+0530)
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Cc:     linux-arm-msm@vger.kernel.org, ezequiel@collabora.com,
        stanimir.varbanov@linaro.org, quic_vgarodia@quicinc.com,
        quic_majja@quicinc.com, quic_jdas@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v5 1/2] media: v4l2-ctrls: Add intra-refresh type control
Date:   Tue, 19 Apr 2022 10:36:42 +0530
Message-Id: <1650344803-6884-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650344803-6884-1-git-send-email-quic_dikshita@quicinc.com>
References: <1650344803-6884-1-git-send-email-quic_dikshita@quicinc.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control to set intra-refresh type.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 22 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
 include/uapi/linux/v4l2-controls.h                 |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4cd7c54..c24977f 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1180,6 +1180,28 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     is set to non zero value.
     Applicable to H264, H263 and MPEG4 encoder.
 
+``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE (enum)``
+
+enum v4l2_mpeg_video_intra_refresh_period_type -
+    Sets the type of intra refresh. The period to refresh
+    the whole frame is specified by V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD.
+    Note that if this control is not present, then it is undefined what
+    refresh type is used and it is up to the driver to decide.
+    Applicable to H264 and HEVC encoders. Possible values are:
+
+.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM``
+      - The whole frame is completely refreshed randomly
+      after the specified period.
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC``
+      - The whole frame MBs are completely refreshed in cyclic order
+      after the specified period.
+
 ``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
     Intra macroblock refresh period. This sets the period to refresh
     the whole frame. In other words, this defines the number of frames
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 54ca4e6..16f42d2 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -572,6 +572,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"VBV/CPB Limit",
 		NULL,
 	};
+	static const char * const intra_refresh_period_type[] = {
+		"Random",
+		"Cyclic",
+		NULL,
+	};
 
 	switch (id) {
 	case V4L2_CID_MPEG_AUDIO_SAMPLING_FREQ:
@@ -705,6 +710,8 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_start_code;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
+		return intra_refresh_period_type;
 	default:
 		return NULL;
 	}
@@ -834,6 +841,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
 	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:	return "Intra Refresh Period Type";
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
 	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
 	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
@@ -1360,6 +1368,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE:
 		*type = V4L2_CTRL_TYPE_MENU;
 		break;
 	case V4L2_CID_LINK_FREQ:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c8e0f84..e7df4c5 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -443,6 +443,11 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
 #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
 #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
+#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE	(V4L2_CID_CODEC_BASE+237)
+enum v4l2_mpeg_video_intra_refresh_period_type {
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_RANDOM	= 0,
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD_TYPE_CYCLIC	= 1,
+};
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.7.4

