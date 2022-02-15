Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35404B6A1B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiBOLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:01:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236856AbiBOLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:01:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662AF956A;
        Tue, 15 Feb 2022 03:01:16 -0800 (PST)
Received: from benjamin-XPS-13-9310.. (unknown [IPv6:2a01:e0a:120:3210:6d7b:ae43:289b:7e7c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C3DFC1F444DB;
        Tue, 15 Feb 2022 11:01:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644922875;
        bh=ODVXA0uX/p8DeRwIksQn0HTLyWScZFsC5s3YshHcoQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgYF2uY0pSvRfN2IAUK8s1zive6bwkYCb9HAI/3nDLDOk7idEtzKS/2xyah5QoZAL
         8GZcYy45mMQPkbDVXIKpB6v5dJXN/tPmihdvq+EnL2LF/8UJ/2mQX3zVaYb2eFhjzJ
         exLlnbvXaRkpr76Gq1/G2SYR9diA4yJNd1NsO009vCqEoZB2EucED4/LtnrVD8DjqE
         Qgs4knFdB7jEDVinSDnQcgR/RybGTxuzf3X4BFfRupkF58bajVafbwf9FrO3zqsUxX
         pIbyMqOy3iZQrEux/Y5wBFOuoaDsPqqOnjyfIM1Qg2g3bkkwwSffY0Oz1oftR8xgli
         v501esn1732Vw==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     mchehab@kernel.org, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        jernej.skrabec@gmail.com, hverkuil-cisco@xs4all.nl,
        jonas@kwiboo.se, nicolas@ndufresne.ca
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        kernel@collabora.com, knaerzche@gmail.com, jc@kynesim.co.uk,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [RFC v2 4/8] media: uapi: Move HEVC stateless controls out of staging
Date:   Tue, 15 Feb 2022 12:00:59 +0100
Message-Id: <20220215110103.241297-5-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
References: <20220215110103.241297-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEVC stateless 'uAPI' was staging and marked explicitly in the
V4L2 specification that it will change and is unstable.

Note that these control IDs were never exported as a public API,
they were only defined in kernel-local headers (hevc-ctrls.h).

While moving the controls out of staging they are renamed and
control IDs get new numbers.
Drivers (Hantro, Cedrus) and Documentation are updated accordingly.

Hantro dedicated control is moving to hantro-media.h
Since hevc-ctrls.h content has been dispatched in others file, remove it.

fluster tests results on IMX8MQ is 77/147 for HEVC codec.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
version 2 :
- Do not include rkvdec needed fields in this patch
- Remove 'non-public' notice in hantro.rst
- Take care of cache-line boundary

 .../userspace-api/media/drivers/hantro.rst    |   5 -
 .../media/v4l/ext-ctrls-codec.rst             |  26 +-
 drivers/media/v4l2-core/v4l2-ctrls-defs.c     |  32 +--
 drivers/staging/media/hantro/hantro_drv.c     |  27 +-
 drivers/staging/media/hantro/hantro_hevc.c    |   8 +-
 drivers/staging/media/sunxi/cedrus/cedrus.c   |  24 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   |  10 +-
 include/linux/hantro-media.h                  |  17 ++
 include/media/hevc-ctrls.h                    | 250 ------------------
 include/media/v4l2-ctrls.h                    |   6 -
 include/uapi/linux/v4l2-controls.h            | 219 +++++++++++++++
 include/uapi/linux/videodev2.h                |   7 +
 12 files changed, 307 insertions(+), 324 deletions(-)
 create mode 100644 include/linux/hantro-media.h
 delete mode 100644 include/media/hevc-ctrls.h

diff --git a/Documentation/userspace-api/media/drivers/hantro.rst b/Documentation/userspace-api/media/drivers/hantro.rst
index cd9754b4e005..78dcd2a44a03 100644
--- a/Documentation/userspace-api/media/drivers/hantro.rst
+++ b/Documentation/userspace-api/media/drivers/hantro.rst
@@ -12,8 +12,3 @@ The Hantro video decoder driver implements the following driver-specific control
     to before syntax element "slice_temporal_mvp_enabled_flag".
     If IDR, the skipped bits are just "pic_output_flag"
     (separate_colour_plane_flag is not supported).
-
-.. note::
-
-        This control is not yet part of the public kernel API and
-        it is expected to change.
diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 4cd7c541fc30..4f3b3ba8319f 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -2639,7 +2639,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
 .. _v4l2-mpeg-hevc:
 
-``V4L2_CID_MPEG_VIDEO_HEVC_SPS (struct)``
+``V4L2_CID_STATELESS_HEVC_SPS (struct)``
     Specifies the Sequence Parameter Set fields (as extracted from the
     bitstream) for the associated HEVC slice data.
     These bitstream parameters are defined according to :ref:`hevc`.
@@ -2782,7 +2782,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
-``V4L2_CID_MPEG_VIDEO_HEVC_PPS (struct)``
+``V4L2_CID_STATELESS_HEVC_PPS (struct)``
     Specifies the Picture Parameter Set fields (as extracted from the
     bitstream) for the associated HEVC slice data.
     These bitstream parameters are defined according to :ref:`hevc`.
@@ -2932,7 +2932,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
-``V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS (struct)``
+``V4L2_CID_STATELESS_HEVC_SLICE_PARAMS (struct)``
     Specifies various slice-specific parameters, especially from the NAL unit
     header, general slice segment header and weighted prediction parameter
     parts of the bitstream.
@@ -3088,7 +3088,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
-``V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX (struct)``
+``V4L2_CID_STATELESS_HEVC_SCALING_MATRIX (struct)``
     Specifies the HEVC scaling matrix parameters used for the scaling process
     for transform coefficients.
     These matrix and parameters are defined according to :ref:`hevc`.
@@ -3238,7 +3238,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
-``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE (enum)``
+``V4L2_CID_STATELESS_HEVC_DECODE_MODE (enum)``
     Specifies the decoding mode to use. Currently exposes slice-based and
     frame-based decoding but new modes might be added later on.
     This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
@@ -3253,7 +3253,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
        This menu control is not yet part of the public kernel API and
        it is expected to change.
 
-.. c:type:: v4l2_mpeg_video_hevc_decode_mode
+.. c:type:: v4l2_stateless_hevc_decode_mode
 
 .. raw:: latex
 
@@ -3266,11 +3266,11 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
-    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED``
+    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED``
       - 0
       - Decoding is done at the slice granularity.
         The OUTPUT buffer must contain a single slice.
-    * - ``V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED``
+    * - ``V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED``
       - 1
       - Decoding is done at the frame granularity.
         The OUTPUT buffer must contain all slices needed to decode the
@@ -3280,7 +3280,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
 
     \normalsize
 
-``V4L2_CID_MPEG_VIDEO_HEVC_START_CODE (enum)``
+``V4L2_CID_STATELESS_HEVC_START_CODE (enum)``
     Specifies the HEVC slice start code expected for each slice.
     This control is used as a modifier for V4L2_PIX_FMT_HEVC_SLICE
     pixel format. Applications that support V4L2_PIX_FMT_HEVC_SLICE
@@ -3294,7 +3294,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
        This menu control is not yet part of the public kernel API and
        it is expected to change.
 
-.. c:type:: v4l2_mpeg_video_hevc_start_code
+.. c:type:: v4l2_stateless_hevc_start_code
 
 .. tabularcolumns:: |p{9.2cm}|p{0.6cm}|p{7.5cm}|
 
@@ -3303,13 +3303,13 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     :stub-columns: 0
     :widths:       1 1 2
 
-    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE``
+    * - ``V4L2_STATELESS_HEVC_START_CODE_NONE``
       - 0
       - Selecting this value specifies that HEVC slices are passed
         to the driver without any start code. The bitstream data should be
         according to :ref:`hevc` 7.3.1.1 General NAL unit syntax, hence
         contains emulation prevention bytes when required.
-    * - ``V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B``
+    * - ``V4L2_STATELESS_HEVC_START_CODE_ANNEX_B``
       - 1
       - Selecting this value specifies that HEVC slices are expected
         to be prefixed by Annex B start codes. According to :ref:`hevc`
@@ -3342,7 +3342,7 @@ enum v4l2_mpeg_video_hevc_size_of_length_field -
     This provides a bitmask which consists of bits [0, LTR_COUNT-1].
     This is applicable to the H264 and HEVC encoders.
 
-``V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS (struct)``
+``V4L2_CID_STATELESS_HEVC_DECODE_PARAMS (struct)``
     Specifies various decode parameters, especially the references picture order
     count (POC) for all the lists (short, long, before, current, after) and the
     number of entries for each of them.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls-defs.c b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
index 54ca4e6b820b..4b68cbe23309 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-defs.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-defs.c
@@ -699,9 +699,9 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 		return hevc_tier;
 	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
 		return hevc_loop_filter_mode;
-	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
+	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
 		return hevc_decode_mode;
-	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
+	case V4L2_CID_STATELESS_HEVC_START_CODE:
 		return hevc_start_code;
 	case V4L2_CID_CAMERA_ORIENTATION:
 		return camera_orientation;
@@ -995,13 +995,6 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:	return "HEVC Size of Length Field";
 	case V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES:	return "Reference Frames for a P-Frame";
 	case V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR:		return "Prepend SPS and PPS to IDR";
-	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:			return "HEVC Sequence Parameter Set";
-	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:			return "HEVC Picture Parameter Set";
-	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:		return "HEVC Slice Parameters";
-	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:		return "HEVC Scaling Matrix";
-	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
-	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
-	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:		return "HEVC Start Code";
 
 	/* CAMERA controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1180,6 +1173,13 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_STATELESS_MPEG2_QUANTISATION:		return "MPEG-2 Quantisation Matrices";
 	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:	return "VP9 Probabilities Updates";
 	case V4L2_CID_STATELESS_VP9_FRAME:			return "VP9 Frame Decode Parameters";
+	case V4L2_CID_STATELESS_HEVC_SPS:			return "HEVC Sequence Parameter Set";
+	case V4L2_CID_STATELESS_HEVC_PPS:			return "HEVC Picture Parameter Set";
+	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:		return "HEVC Slice Parameters";
+	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:		return "HEVC Scaling Matrix";
+	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:		return "HEVC Decode Parameters";
+	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:		return "HEVC Decode Mode";
+	case V4L2_CID_STATELESS_HEVC_START_CODE:		return "HEVC Start Code";
 
 	/* Colorimetry controls */
 	/* Keep the order of the 'case's the same as in v4l2-controls.h! */
@@ -1355,8 +1355,8 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_HEVC_SIZE_OF_LENGTH_FIELD:
 	case V4L2_CID_MPEG_VIDEO_HEVC_TIER:
 	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
-	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE:
-	case V4L2_CID_MPEG_VIDEO_HEVC_START_CODE:
+	case V4L2_CID_STATELESS_HEVC_DECODE_MODE:
+	case V4L2_CID_STATELESS_HEVC_START_CODE:
 	case V4L2_CID_STATELESS_H264_DECODE_MODE:
 	case V4L2_CID_STATELESS_H264_START_CODE:
 	case V4L2_CID_CAMERA_ORIENTATION:
@@ -1493,19 +1493,19 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_STATELESS_VP8_FRAME:
 		*type = V4L2_CTRL_TYPE_VP8_FRAME;
 		break;
-	case V4L2_CID_MPEG_VIDEO_HEVC_SPS:
+	case V4L2_CID_STATELESS_HEVC_SPS:
 		*type = V4L2_CTRL_TYPE_HEVC_SPS;
 		break;
-	case V4L2_CID_MPEG_VIDEO_HEVC_PPS:
+	case V4L2_CID_STATELESS_HEVC_PPS:
 		*type = V4L2_CTRL_TYPE_HEVC_PPS;
 		break;
-	case V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS:
+	case V4L2_CID_STATELESS_HEVC_SLICE_PARAMS:
 		*type = V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS;
 		break;
-	case V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX:
+	case V4L2_CID_STATELESS_HEVC_SCALING_MATRIX:
 		*type = V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX;
 		break;
-	case V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS:
+	case V4L2_CID_STATELESS_HEVC_DECODE_PARAMS:
 		*type = V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS;
 		break;
 	case V4L2_CID_STATELESS_VP9_COMPRESSED_HDR:
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index dc768884cb79..783a92a38c8e 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/hantro-media.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -255,7 +256,7 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 		if (sps->bit_depth_luma_minus8 != 0)
 			/* Only 8-bit is supported */
 			return -EINVAL;
-	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
+	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 
 		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
@@ -428,18 +429,18 @@ static const struct hantro_ctrl controls[] = {
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
-			.min = V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
-			.max = V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
-			.def = V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
+			.id = V4L2_CID_STATELESS_HEVC_DECODE_MODE,
+			.min = V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+			.max = V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+			.def = V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
-			.min = V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
-			.max = V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
-			.def = V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
+			.id = V4L2_CID_STATELESS_HEVC_START_CODE,
+			.min = V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+			.max = V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+			.def = V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
@@ -459,23 +460,23 @@ static const struct hantro_ctrl controls[] = {
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_SPS,
+			.id = V4L2_CID_STATELESS_HEVC_SPS,
 			.ops = &hantro_ctrl_ops,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_PPS,
+			.id = V4L2_CID_STATELESS_HEVC_PPS,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
+			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
+			.id = V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
 		},
 	}, {
 		.codec = HANTRO_HEVC_DECODER,
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index b49a41d7ae91..b6ec86d03d91 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -201,22 +201,22 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
 	hantro_start_prepare_run(ctx);
 
 	ctrls->decode_params =
-		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
+		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
 	if (WARN_ON(!ctrls->decode_params))
 		return -EINVAL;
 
 	ctrls->scaling =
-		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
+		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
 	if (WARN_ON(!ctrls->scaling))
 		return -EINVAL;
 
 	ctrls->sps =
-		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_SPS);
+		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_SPS);
 	if (WARN_ON(!ctrls->sps))
 		return -EINVAL;
 
 	ctrls->pps =
-		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
+		hantro_get_ctrl(ctx, V4L2_CID_STATELESS_HEVC_PPS);
 	if (WARN_ON(!ctrls->pps))
 		return -EINVAL;
 
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index 4a4b714b0f26..e0428163f82c 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -42,7 +42,7 @@ static int cedrus_try_ctrl(struct v4l2_ctrl *ctrl)
 		if (sps->bit_depth_luma_minus8 != 0)
 			/* Only 8-bit is supported */
 			return -EINVAL;
-	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
+	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 		struct cedrus_ctx *ctx = container_of(ctrl->handler, struct cedrus_ctx, hdl);
 
@@ -164,42 +164,42 @@ static const struct cedrus_control cedrus_controls[] = {
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SPS,
+			.id	= V4L2_CID_STATELESS_HEVC_SPS,
 			.ops	= &cedrus_ctrl_ops,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_PPS,
+			.id	= V4L2_CID_STATELESS_HEVC_PPS,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS,
+			.id	= V4L2_CID_STATELESS_HEVC_SLICE_PARAMS,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX,
+			.id	= V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE,
-			.max	= V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
-			.def	= V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
+			.id	= V4L2_CID_STATELESS_HEVC_DECODE_MODE,
+			.max	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
+			.def	= V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
 	{
 		.cfg = {
-			.id	= V4L2_CID_MPEG_VIDEO_HEVC_START_CODE,
-			.max	= V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
-			.def	= V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
+			.id	= V4L2_CID_STATELESS_HEVC_START_CODE,
+			.max	= V4L2_STATELESS_HEVC_START_CODE_NONE,
+			.def	= V4L2_STATELESS_HEVC_START_CODE_NONE,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
@@ -211,7 +211,7 @@ static const struct cedrus_control cedrus_controls[] = {
 	},
 	{
 		.cfg = {
-			.id = V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS,
+			.id = V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
 		},
 		.codec		= CEDRUS_CODEC_H265,
 	},
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index a16c1422558f..f6be4ae72ee2 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -65,15 +65,15 @@ void cedrus_device_run(void *priv)
 
 	case V4L2_PIX_FMT_HEVC_SLICE:
 		run.h265.sps = cedrus_find_control_data(ctx,
-			V4L2_CID_MPEG_VIDEO_HEVC_SPS);
+			V4L2_CID_STATELESS_HEVC_SPS);
 		run.h265.pps = cedrus_find_control_data(ctx,
-			V4L2_CID_MPEG_VIDEO_HEVC_PPS);
+			V4L2_CID_STATELESS_HEVC_PPS);
 		run.h265.slice_params = cedrus_find_control_data(ctx,
-			V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS);
+			V4L2_CID_STATELESS_HEVC_SLICE_PARAMS);
 		run.h265.decode_params = cedrus_find_control_data(ctx,
-			V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS);
+			V4L2_CID_STATELESS_HEVC_DECODE_PARAMS);
 		run.h265.scaling_matrix = cedrus_find_control_data(ctx,
-			V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX);
+			V4L2_CID_STATELESS_HEVC_SCALING_MATRIX);
 		break;
 
 	case V4L2_PIX_FMT_VP8_FRAME:
diff --git a/include/linux/hantro-media.h b/include/linux/hantro-media.h
new file mode 100644
index 000000000000..db2791ab7c3b
--- /dev/null
+++ b/include/linux/hantro-media.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef __LINUX_HANTRO_MEDIA_H__
+#define __LINUX_HANTRO_MEDIA_H__
+
+/*
+ * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
+ * the number of data (in bits) to skip in the
+ * slice segment header.
+ * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
+ * to before syntax element "slice_temporal_mvp_enabled_flag".
+ * If IDR, the skipped bits are just "pic_output_flag"
+ * (separate_colour_plane_flag is not supported).
+ */
+#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_USER_HANTRO_BASE + 0)
+
+#endif
diff --git a/include/media/hevc-ctrls.h b/include/media/hevc-ctrls.h
deleted file mode 100644
index 01ccda48d8c5..000000000000
--- a/include/media/hevc-ctrls.h
+++ /dev/null
@@ -1,250 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * These are the HEVC state controls for use with stateless HEVC
- * codec drivers.
- *
- * It turns out that these structs are not stable yet and will undergo
- * more changes. So keep them private until they are stable and ready to
- * become part of the official public API.
- */
-
-#ifndef _HEVC_CTRLS_H_
-#define _HEVC_CTRLS_H_
-
-#include <linux/videodev2.h>
-
-/* The pixel format isn't stable at the moment and will likely be renamed. */
-#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
-
-#define V4L2_CID_MPEG_VIDEO_HEVC_SPS		(V4L2_CID_CODEC_BASE + 1008)
-#define V4L2_CID_MPEG_VIDEO_HEVC_PPS		(V4L2_CID_CODEC_BASE + 1009)
-#define V4L2_CID_MPEG_VIDEO_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_BASE + 1010)
-#define V4L2_CID_MPEG_VIDEO_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_BASE + 1011)
-#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_BASE + 1012)
-#define V4L2_CID_MPEG_VIDEO_HEVC_DECODE_MODE	(V4L2_CID_CODEC_BASE + 1015)
-#define V4L2_CID_MPEG_VIDEO_HEVC_START_CODE	(V4L2_CID_CODEC_BASE + 1016)
-
-/* enum v4l2_ctrl_type type values */
-#define V4L2_CTRL_TYPE_HEVC_SPS 0x0120
-#define V4L2_CTRL_TYPE_HEVC_PPS 0x0121
-#define V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS 0x0122
-#define V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX 0x0123
-#define V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS 0x0124
-
-enum v4l2_mpeg_video_hevc_decode_mode {
-	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_SLICE_BASED,
-	V4L2_MPEG_VIDEO_HEVC_DECODE_MODE_FRAME_BASED,
-};
-
-enum v4l2_mpeg_video_hevc_start_code {
-	V4L2_MPEG_VIDEO_HEVC_START_CODE_NONE,
-	V4L2_MPEG_VIDEO_HEVC_START_CODE_ANNEX_B,
-};
-
-#define V4L2_HEVC_SLICE_TYPE_B	0
-#define V4L2_HEVC_SLICE_TYPE_P	1
-#define V4L2_HEVC_SLICE_TYPE_I	2
-
-#define V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE		(1ULL << 0)
-#define V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED			(1ULL << 1)
-#define V4L2_HEVC_SPS_FLAG_AMP_ENABLED				(1ULL << 2)
-#define V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET		(1ULL << 3)
-#define V4L2_HEVC_SPS_FLAG_PCM_ENABLED				(1ULL << 4)
-#define V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED		(1ULL << 5)
-#define V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT		(1ULL << 6)
-#define V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED		(1ULL << 7)
-#define V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED	(1ULL << 8)
-
-/* The controls are not stable at the moment and will likely be reworked. */
-struct v4l2_ctrl_hevc_sps {
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
-	__u16	pic_width_in_luma_samples;
-	__u16	pic_height_in_luma_samples;
-	__u8	bit_depth_luma_minus8;
-	__u8	bit_depth_chroma_minus8;
-	__u8	log2_max_pic_order_cnt_lsb_minus4;
-	__u8	sps_max_dec_pic_buffering_minus1;
-	__u8	sps_max_num_reorder_pics;
-	__u8	sps_max_latency_increase_plus1;
-	__u8	log2_min_luma_coding_block_size_minus3;
-	__u8	log2_diff_max_min_luma_coding_block_size;
-	__u8	log2_min_luma_transform_block_size_minus2;
-	__u8	log2_diff_max_min_luma_transform_block_size;
-	__u8	max_transform_hierarchy_depth_inter;
-	__u8	max_transform_hierarchy_depth_intra;
-	__u8	pcm_sample_bit_depth_luma_minus1;
-	__u8	pcm_sample_bit_depth_chroma_minus1;
-	__u8	log2_min_pcm_luma_coding_block_size_minus3;
-	__u8	log2_diff_max_min_pcm_luma_coding_block_size;
-	__u8	num_short_term_ref_pic_sets;
-	__u8	num_long_term_ref_pics_sps;
-	__u8	chroma_format_idc;
-	__u8	sps_max_sub_layers_minus1;
-
-	__u64	flags;
-};
-
-#define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
-#define V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT			(1ULL << 1)
-#define V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED		(1ULL << 2)
-#define V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT			(1ULL << 3)
-#define V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED		(1ULL << 4)
-#define V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED		(1ULL << 5)
-#define V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED			(1ULL << 6)
-#define V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT	(1ULL << 7)
-#define V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED			(1ULL << 8)
-#define V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED			(1ULL << 9)
-#define V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED		(1ULL << 10)
-#define V4L2_HEVC_PPS_FLAG_TILES_ENABLED			(1ULL << 11)
-#define V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED		(1ULL << 12)
-#define V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED	(1ULL << 13)
-#define V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 14)
-#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED	(1ULL << 15)
-#define V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER	(1ULL << 16)
-#define V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT		(1ULL << 17)
-#define V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT (1ULL << 18)
-#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT	(1ULL << 19)
-#define V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING			(1ULL << 20)
-
-struct v4l2_ctrl_hevc_pps {
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
-	__u8	num_extra_slice_header_bits;
-	__u8	num_ref_idx_l0_default_active_minus1;
-	__u8	num_ref_idx_l1_default_active_minus1;
-	__s8	init_qp_minus26;
-	__u8	diff_cu_qp_delta_depth;
-	__s8	pps_cb_qp_offset;
-	__s8	pps_cr_qp_offset;
-	__u8	num_tile_columns_minus1;
-	__u8	num_tile_rows_minus1;
-	__u8	column_width_minus1[20];
-	__u8	row_height_minus1[22];
-	__s8	pps_beta_offset_div2;
-	__s8	pps_tc_offset_div2;
-	__u8	log2_parallel_merge_level_minus2;
-
-	__u8	padding[4];
-	__u64	flags;
-};
-
-#define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
-
-#define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
-
-struct v4l2_hevc_dpb_entry {
-	__u64	timestamp;
-	__u8	flags;
-	__u8	field_pic;
-	__u16	pic_order_cnt[2];
-	__u8	padding[2];
-};
-
-struct v4l2_hevc_pred_weight_table {
-	__s8	delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-	__s8	chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-
-	__s8	delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
-
-	__u8	padding[6];
-
-	__u8	luma_log2_weight_denom;
-	__s8	delta_chroma_log2_weight_denom;
-};
-
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA		(1ULL << 0)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA		(1ULL << 1)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED	(1ULL << 2)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO			(1ULL << 3)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT			(1ULL << 4)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0		(1ULL << 5)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV		(1ULL << 6)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED (1ULL << 7)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
-#define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
-
-struct v4l2_ctrl_hevc_slice_params {
-	__u32	bit_size;
-	__u32	data_bit_offset;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
-	__u8	nal_unit_type;
-	__u8	nuh_temporal_id_plus1;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
-	__u8	slice_type;
-	__u8	colour_plane_id;
-	__u16	slice_pic_order_cnt;
-	__u8	num_ref_idx_l0_active_minus1;
-	__u8	num_ref_idx_l1_active_minus1;
-	__u8	collocated_ref_idx;
-	__u8	five_minus_max_num_merge_cand;
-	__s8	slice_qp_delta;
-	__s8	slice_cb_qp_offset;
-	__s8	slice_cr_qp_offset;
-	__s8	slice_act_y_qp_offset;
-	__s8	slice_act_cb_qp_offset;
-	__s8	slice_act_cr_qp_offset;
-	__s8	slice_beta_offset_div2;
-	__s8	slice_tc_offset_div2;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
-	__u8	pic_struct;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
-	__u32	slice_segment_addr;
-	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-
-	__u8	padding;
-
-	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
-	struct v4l2_hevc_pred_weight_table pred_weight_table;
-
-	__u64	flags;
-};
-
-#define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
-#define V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC		0x2
-#define V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR  0x4
-
-struct v4l2_ctrl_hevc_decode_params {
-	__s32	pic_order_cnt_val;
-	__u8	num_active_dpb_entries;
-	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	num_poc_st_curr_before;
-	__u8	num_poc_st_curr_after;
-	__u8	num_poc_lt_curr;
-	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
-	__u64	flags;
-};
-
-struct v4l2_ctrl_hevc_scaling_matrix {
-	__u8	scaling_list_4x4[6][16];
-	__u8	scaling_list_8x8[6][64];
-	__u8	scaling_list_16x16[6][64];
-	__u8	scaling_list_32x32[2][64];
-	__u8	scaling_list_dc_coef_16x16[6];
-	__u8	scaling_list_dc_coef_32x32[2];
-};
-
-/*  MPEG-class control IDs specific to the Hantro driver as defined by V4L2 */
-#define V4L2_CID_CODEC_HANTRO_BASE				(V4L2_CTRL_CLASS_CODEC | 0x1200)
-/*
- * V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP -
- * the number of data (in bits) to skip in the
- * slice segment header.
- * If non-IDR, the bits to be skipped go from syntax element "pic_output_flag"
- * to before syntax element "slice_temporal_mvp_enabled_flag".
- * If IDR, the skipped bits are just "pic_output_flag"
- * (separate_colour_plane_flag is not supported).
- */
-#define V4L2_CID_HANTRO_HEVC_SLICE_HEADER_SKIP	(V4L2_CID_CODEC_HANTRO_BASE + 0)
-
-#endif
diff --git a/include/media/v4l2-ctrls.h b/include/media/v4l2-ctrls.h
index f4105de8a8d2..00828a4f9404 100644
--- a/include/media/v4l2-ctrls.h
+++ b/include/media/v4l2-ctrls.h
@@ -13,12 +13,6 @@
 #include <linux/videodev2.h>
 #include <media/media-request.h>
 
-/*
- * Include the stateless codec compound control definitions.
- * This will move to the public headers once this API is fully stable.
- */
-#include <media/hevc-ctrls.h>
-
 /* forward references */
 struct file;
 struct poll_table_struct;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c8e0f84d204d..0e0ec2c61b80 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -218,6 +218,11 @@ enum v4l2_colorfx {
  * We reserve 16 controls for this driver.
  */
 #define V4L2_CID_USER_ALLEGRO_BASE		(V4L2_CID_USER_BASE + 0x1170)
+/*
+ * The base for Hantro driver controls.
+ * We reserve 128 controls for this driver.
+ */
+#define V4L2_CID_USER_HANTRO_BASE		(V4L2_CID_USER_BASE + 0x1180)
 
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
@@ -2302,6 +2307,220 @@ struct v4l2_ctrl_vp9_compressed_hdr {
 	struct v4l2_vp9_mv_probs mv;
 };
 
+#define V4L2_CID_STATELESS_HEVC_SPS		(V4L2_CID_CODEC_STATELESS_BASE + 400)
+#define V4L2_CID_STATELESS_HEVC_PPS		(V4L2_CID_CODEC_STATELESS_BASE + 401)
+#define V4L2_CID_STATELESS_HEVC_SLICE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 402)
+#define V4L2_CID_STATELESS_HEVC_SCALING_MATRIX	(V4L2_CID_CODEC_STATELESS_BASE + 403)
+#define V4L2_CID_STATELESS_HEVC_DECODE_PARAMS	(V4L2_CID_CODEC_STATELESS_BASE + 404)
+#define V4L2_CID_STATELESS_HEVC_DECODE_MODE	(V4L2_CID_CODEC_STATELESS_BASE + 405)
+#define V4L2_CID_STATELESS_HEVC_START_CODE	(V4L2_CID_CODEC_STATELESS_BASE + 406)
+
+enum v4l2_stateless_hevc_decode_mode {
+	V4L2_STATELESS_HEVC_DECODE_MODE_SLICE_BASED,
+	V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
+};
+
+enum v4l2_stateless_hevc_start_code {
+	V4L2_STATELESS_HEVC_START_CODE_NONE,
+	V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
+};
+
+#define V4L2_HEVC_SLICE_TYPE_B	0
+#define V4L2_HEVC_SLICE_TYPE_P	1
+#define V4L2_HEVC_SLICE_TYPE_I	2
+
+#define V4L2_HEVC_SPS_FLAG_SEPARATE_COLOUR_PLANE		(1ULL << 0)
+#define V4L2_HEVC_SPS_FLAG_SCALING_LIST_ENABLED			(1ULL << 1)
+#define V4L2_HEVC_SPS_FLAG_AMP_ENABLED				(1ULL << 2)
+#define V4L2_HEVC_SPS_FLAG_SAMPLE_ADAPTIVE_OFFSET		(1ULL << 3)
+#define V4L2_HEVC_SPS_FLAG_PCM_ENABLED				(1ULL << 4)
+#define V4L2_HEVC_SPS_FLAG_PCM_LOOP_FILTER_DISABLED		(1ULL << 5)
+#define V4L2_HEVC_SPS_FLAG_LONG_TERM_REF_PICS_PRESENT		(1ULL << 6)
+#define V4L2_HEVC_SPS_FLAG_SPS_TEMPORAL_MVP_ENABLED		(1ULL << 7)
+#define V4L2_HEVC_SPS_FLAG_STRONG_INTRA_SMOOTHING_ENABLED	(1ULL << 8)
+
+struct v4l2_ctrl_hevc_sps {
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Sequence parameter set */
+	__u16	pic_width_in_luma_samples;
+	__u16	pic_height_in_luma_samples;
+	__u8	bit_depth_luma_minus8;
+	__u8	bit_depth_chroma_minus8;
+	__u8	log2_max_pic_order_cnt_lsb_minus4;
+	__u8	sps_max_dec_pic_buffering_minus1;
+	__u8	sps_max_num_reorder_pics;
+	__u8	sps_max_latency_increase_plus1;
+	__u8	log2_min_luma_coding_block_size_minus3;
+	__u8	log2_diff_max_min_luma_coding_block_size;
+	__u8	log2_min_luma_transform_block_size_minus2;
+	__u8	log2_diff_max_min_luma_transform_block_size;
+	__u8	max_transform_hierarchy_depth_inter;
+	__u8	max_transform_hierarchy_depth_intra;
+	__u8	pcm_sample_bit_depth_luma_minus1;
+	__u8	pcm_sample_bit_depth_chroma_minus1;
+	__u8	log2_min_pcm_luma_coding_block_size_minus3;
+	__u8	log2_diff_max_min_pcm_luma_coding_block_size;
+	__u8	num_short_term_ref_pic_sets;
+	__u8	num_long_term_ref_pics_sps;
+	__u8	chroma_format_idc;
+	__u8	sps_max_sub_layers_minus1;
+
+	__u8	padding[6];
+	__u64	flags;
+	__u8	reserved[24];
+};
+
+#define V4L2_HEVC_PPS_FLAG_DEPENDENT_SLICE_SEGMENT_ENABLED	(1ULL << 0)
+#define V4L2_HEVC_PPS_FLAG_OUTPUT_FLAG_PRESENT			(1ULL << 1)
+#define V4L2_HEVC_PPS_FLAG_SIGN_DATA_HIDING_ENABLED		(1ULL << 2)
+#define V4L2_HEVC_PPS_FLAG_CABAC_INIT_PRESENT			(1ULL << 3)
+#define V4L2_HEVC_PPS_FLAG_CONSTRAINED_INTRA_PRED		(1ULL << 4)
+#define V4L2_HEVC_PPS_FLAG_TRANSFORM_SKIP_ENABLED		(1ULL << 5)
+#define V4L2_HEVC_PPS_FLAG_CU_QP_DELTA_ENABLED			(1ULL << 6)
+#define V4L2_HEVC_PPS_FLAG_PPS_SLICE_CHROMA_QP_OFFSETS_PRESENT	(1ULL << 7)
+#define V4L2_HEVC_PPS_FLAG_WEIGHTED_PRED			(1ULL << 8)
+#define V4L2_HEVC_PPS_FLAG_WEIGHTED_BIPRED			(1ULL << 9)
+#define V4L2_HEVC_PPS_FLAG_TRANSQUANT_BYPASS_ENABLED		(1ULL << 10)
+#define V4L2_HEVC_PPS_FLAG_TILES_ENABLED			(1ULL << 11)
+#define V4L2_HEVC_PPS_FLAG_ENTROPY_CODING_SYNC_ENABLED		(1ULL << 12)
+#define V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED	(1ULL << 13)
+#define V4L2_HEVC_PPS_FLAG_PPS_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 14)
+#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_OVERRIDE_ENABLED	(1ULL << 15)
+#define V4L2_HEVC_PPS_FLAG_PPS_DISABLE_DEBLOCKING_FILTER	(1ULL << 16)
+#define V4L2_HEVC_PPS_FLAG_LISTS_MODIFICATION_PRESENT		(1ULL << 17)
+#define V4L2_HEVC_PPS_FLAG_SLICE_SEGMENT_HEADER_EXTENSION_PRESENT (1ULL << 18)
+#define V4L2_HEVC_PPS_FLAG_DEBLOCKING_FILTER_CONTROL_PRESENT	(1ULL << 19)
+#define V4L2_HEVC_PPS_FLAG_UNIFORM_SPACING			(1ULL << 20)
+
+struct v4l2_ctrl_hevc_pps {
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture parameter set */
+	__u8	num_extra_slice_header_bits;
+	__u8	num_ref_idx_l0_default_active_minus1;
+	__u8	num_ref_idx_l1_default_active_minus1;
+	__s8	init_qp_minus26;
+	__u8	diff_cu_qp_delta_depth;
+	__s8	pps_cb_qp_offset;
+	__s8	pps_cr_qp_offset;
+	__u8	num_tile_columns_minus1;
+	__u8	num_tile_rows_minus1;
+	__u8	column_width_minus1[20];
+	__u8	row_height_minus1[22];
+	__s8	pps_beta_offset_div2;
+	__s8	pps_tc_offset_div2;
+	__u8	log2_parallel_merge_level_minus2;
+	__u8	padding[9];
+
+	__u64	flags;
+	__u8	reserved[56];
+};
+
+#define V4L2_HEVC_DPB_ENTRY_LONG_TERM_REFERENCE	0x01
+
+#define V4L2_HEVC_DPB_ENTRIES_NUM_MAX		16
+
+struct v4l2_hevc_dpb_entry {
+	__u64	timestamp;
+	__u8	flags;
+	__u8	field_pic;
+	__u16	pic_order_cnt[2];
+	__u8	padding[2];
+};
+
+struct v4l2_hevc_pred_weight_table {
+	__s8	delta_luma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	luma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	delta_chroma_weight_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+	__s8	chroma_offset_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+
+	__s8	delta_luma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	luma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__s8	delta_chroma_weight_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+	__s8	chroma_offset_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX][2];
+
+	__u8	padding[6];
+
+	__u8	luma_log2_weight_denom;
+	__s8	delta_chroma_log2_weight_denom;
+};
+
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_LUMA		(1ULL << 0)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_SAO_CHROMA		(1ULL << 1)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_TEMPORAL_MVP_ENABLED	(1ULL << 2)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_MVD_L1_ZERO			(1ULL << 3)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_CABAC_INIT			(1ULL << 4)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_COLLOCATED_FROM_L0		(1ULL << 5)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_USE_INTEGER_MV		(1ULL << 6)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_DEBLOCKING_FILTER_DISABLED (1ULL << 7)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_SLICE_LOOP_FILTER_ACROSS_SLICES_ENABLED (1ULL << 8)
+#define V4L2_HEVC_SLICE_PARAMS_FLAG_DEPENDENT_SLICE_SEGMENT	(1ULL << 9)
+
+struct v4l2_ctrl_hevc_slice_params {
+	__u32	bit_size;
+	__u32	data_bit_offset;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: NAL unit header */
+	__u8	nal_unit_type;
+	__u8	nuh_temporal_id_plus1;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
+	__u8	slice_type;
+	__u8	colour_plane_id;
+	__u16	slice_pic_order_cnt;
+	__u8	num_ref_idx_l0_active_minus1;
+	__u8	num_ref_idx_l1_active_minus1;
+	__u8	collocated_ref_idx;
+	__u8	five_minus_max_num_merge_cand;
+	__s8	slice_qp_delta;
+	__s8	slice_cb_qp_offset;
+	__s8	slice_cr_qp_offset;
+	__s8	slice_act_y_qp_offset;
+	__s8	slice_act_cb_qp_offset;
+	__s8	slice_act_cr_qp_offset;
+	__s8	slice_beta_offset_div2;
+	__s8	slice_tc_offset_div2;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Picture timing SEI message */
+	__u8	pic_struct;
+
+	__u8	reserved;
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: General slice segment header */
+	__u32	slice_segment_addr;
+	__u8	ref_idx_l0[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	ref_idx_l1[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+
+	/* ISO/IEC 23008-2, ITU-T Rec. H.265: Weighted prediction parameter */
+	struct v4l2_hevc_pred_weight_table pred_weight_table;
+
+	__u64	flags;
+	__u8	padding[48];
+};
+
+#define V4L2_HEVC_DECODE_PARAM_FLAG_IRAP_PIC		0x1
+#define V4L2_HEVC_DECODE_PARAM_FLAG_IDR_PIC		0x2
+#define V4L2_HEVC_DECODE_PARAM_FLAG_NO_OUTPUT_OF_PRIOR  0x4
+
+struct v4l2_ctrl_hevc_decode_params {
+	__s32	pic_order_cnt_val;
+	__u8	num_active_dpb_entries;
+	__u8	num_poc_st_curr_before;
+	__u8	num_poc_st_curr_after;
+	__u8	num_poc_lt_curr;
+	__u8	poc_st_curr_before[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	poc_st_curr_after[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u8	poc_lt_curr[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	struct	v4l2_hevc_dpb_entry dpb[V4L2_HEVC_DPB_ENTRIES_NUM_MAX];
+	__u64	flags;
+};
+
+struct v4l2_ctrl_hevc_scaling_matrix {
+	__u8	scaling_list_4x4[6][16];
+	__u8	scaling_list_8x8[6][64];
+	__u8	scaling_list_16x16[6][64];
+	__u8	scaling_list_32x32[2][64];
+	__u8	scaling_list_dc_coef_16x16[6];
+	__u8	scaling_list_dc_coef_32x32[2];
+};
+
 /* MPEG-compression definitions kept for backwards compatibility */
 #ifndef __KERNEL__
 #define V4L2_CTRL_CLASS_MPEG            V4L2_CTRL_CLASS_CODEC
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index e27c8eae78c9..9af1c2460148 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -708,6 +708,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Walsh Hadamard Transform (vicodec) */
 #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
+#define V4L2_PIX_FMT_HEVC_SLICE v4l2_fourcc('S', '2', '6', '5') /* HEVC parsed slices */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
@@ -1829,6 +1830,12 @@ enum v4l2_ctrl_type {
 
 	V4L2_CTRL_TYPE_VP9_COMPRESSED_HDR	= 0x0260,
 	V4L2_CTRL_TYPE_VP9_FRAME		= 0x0261,
+
+	V4L2_CTRL_TYPE_HEVC_SPS			= 0x0270,
+	V4L2_CTRL_TYPE_HEVC_PPS			= 0x0271,
+	V4L2_CTRL_TYPE_HEVC_SLICE_PARAMS	= 0x0272,
+	V4L2_CTRL_TYPE_HEVC_SCALING_MATRIX	= 0x0273,
+	V4L2_CTRL_TYPE_HEVC_DECODE_PARAMS	= 0x0274,
 };
 
 /*  Used in the VIDIOC_QUERYCTRL ioctl for querying controls */
-- 
2.32.0

