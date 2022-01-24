Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C0C497CCC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiAXKMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:12:35 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:2744 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235405AbiAXKMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qcdkim; t=1643019154; x=1674555154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vgLmwElmAS6vy5TdUlWhO3uZmoe8mt51RUwxmufcEWU=;
  b=VC77LbmoFIVkow1fPL/8vj4rI71mNTNbENMuo7wH3R+Ue1g5jeFaSDow
   iqX3U50jiqhdRuCGJlWSveSv4luRh9zsdwYHe50kP9pQKi/debXqabbmz
   AdXin3ar37FA+LzVfutCEzVycs2I/lkRexjn5x0tBJ5T67LlTJFwe7dEQ
   8=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 Jan 2022 02:12:34 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 24 Jan 2022 02:12:32 -0800
X-QCInternal: smtphost
Received: from hu-dikshita-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.110.13])
  by ironmsg01-blr.qualcomm.com with ESMTP; 24 Jan 2022 15:42:19 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
        id 5151F44ED; Mon, 24 Jan 2022 15:42:18 +0530 (+0530)
From:   Dikshita Agarwal <dikshita@qti.qualcomm.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     hverkuil-cisco@xs4all.nl, ezequiel@collabora.com,
        vgarodia@codeaurora.org, stanimir.varbanov@linaro.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v1 1/2] media: v4l2-ctrls: Add intra-refresh type control
Date:   Mon, 24 Jan 2022 15:41:58 +0530
Message-Id: <1643019119-8309-2-git-send-email-dikshita@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643019119-8309-1-git-send-email-dikshita@qti.qualcomm.com>
References: <1643019119-8309-1-git-send-email-dikshita@qti.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dikshita Agarwal <quic_dikshita@quicinc.com>

Add a control to set intra-refresh type.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst    | 23 ++++++++++++++++++++++
 drivers/media/v4l2-core/v4l2-ctrls-defs.c          |  9 +++++++++
 include/uapi/linux/v4l2-controls.h                 |  5 +++++
 3 files changed, 37 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index e141f0e..54b42e1 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -1180,6 +1180,29 @@ enum v4l2_mpeg_video_h264_entropy_mode -
     is set to non zero value.
     Applicable to H264, H263 and MPEG4 encoder.
 
+``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE (enum)``
+
+enum v4l2_mpeg_video_intra_refresh_type -
+    Sets the type of intra refresh. The period to refresh
+    the whole frame is specified by V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD.
+    Note if the client sets this control to either ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
+    or ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC`` the ``V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB``
+    control shall be ignored.
+    Applicable to H264, H263 and MPEG4 encoder. Possible values are:
+
+.. tabularcolumns:: |p{9.6cm}|p{7.9cm}|
+
+.. flat-table::
+    :header-rows:  0
+    :stub-columns: 0
+
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_RANDOM``
+      - The whole frame is completely refreshed randomly
+      after the specified period.
+    * - ``V4L2_MPEG_VIDEO_INTRA_REFRESH_CYCLIC``
+      - The whole frame MBs are completely refreshed in cyclic order
+      after the specified period.
+
 ``V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD (integer)``
     Intra macroblock refresh period. This sets the period to refresh
     the whole frame. In other words, this defines the number of frames
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 54ca4e6..f13f587 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -572,6 +572,11 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		"VBV/CPB Limit",
 		NULL,
 	};
+	static const char * const intra_refresh_type[] = {
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
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
+		return intra_refresh_type;
 	default:
 		return NULL;
 	}
@@ -834,6 +841,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_DECODER_SLICE_INTERFACE:	return "Decoder Slice Interface";
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:	return "MPEG4 Loop Filter Enable";
 	case V4L2_CID_MPEG_VIDEO_CYCLIC_INTRA_REFRESH_MB:	return "Number of Intra Refresh MBs";
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:		return "Intra Refresh Type";
 	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:		return "Intra Refresh Period";
 	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:		return "Frame Level Rate Control Enable";
 	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:			return "H264 MB Level Rate Control";
@@ -1360,6 +1368,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE:
 		*type = V4L2_CTRL_TYPE_MENU;
 		break;
 	case V4L2_CID_LINK_FREQ:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c8e0f84..9650b71 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -443,6 +443,11 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_USE_LTR_FRAMES		(V4L2_CID_CODEC_BASE+234)
 #define V4L2_CID_MPEG_VIDEO_DEC_CONCEAL_COLOR		(V4L2_CID_CODEC_BASE+235)
 #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+236)
+#define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_TYPE		(V4L2_CID_CODEC_BASE+237)
+enum v4l2_mpeg_video_intra_refresh_type {
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_RANDOM	= 0,
+	V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_CYCLIC	= 1,
+};
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.7.4

