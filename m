Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A19F5286A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiEPOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244421AbiEPOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:11:57 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B63B017;
        Mon, 16 May 2022 07:11:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: benjamin.gaignard)
        with ESMTPSA id 693C01F422E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652710314;
        bh=k40ixcsxMC8Y+D2lQZwWqCFh63ClSVbIKMAB6CPq48U=;
        h=From:To:Cc:Subject:Date:From;
        b=JxB0zCLto3QVH933VKjN+2TbUeTL9dsFHgLdoRiVAdSbUhvjx9Q570fJGznF29Rl0
         UtEIJdYYeA4VVEsF5a2Ejtd9OvKivW0QDxoetiA5mj1AmJroWwXP5w6d+iQSUGYam6
         DexR7zTK29wUJE5C8iQI+MpEfE9ndQSuecmIyzHC2+Sh4s93ddt255rUvLG0fVhdjY
         IWg4eXl14gi1ZtYNrLkpzz0fNosKRM2iYOT/+0JOGd19snNVirMvhFPphN8E9LN5n9
         Ew1F7s7/aG8xeMAwkAq3bXz+iy8QuPQrAf/cE7loTecBv4jtsUeqULBYu+8iR4Ma3R
         yefBQ55HiXX0w==
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, gregkh@linuxfoundation.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, heiko@sntech.de, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     kernel@pengutronix.de, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] media: hantro: Be more accurate on pixel formats step_width constraints
Date:   Mon, 16 May 2022 16:11:42 +0200
Message-Id: <20220516141142.591549-1-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Hantro G2 decoder on IMX8MQ strides requirements aren't the same
for NV12_4L4 and NV12 pixel formats. The first one use a 4 bytes padding
while the last one needs 8 bytes.
To be sure to provide the correct stride in all cases we need:
- to relax the constraints on codec formats so set step_width to 4
- use capture queue format and not the output queue format when applying
  the pixel format constraints.
- put the correct step_width constraints on each pixel format.

With this SAODBLK_A_MainConcept_4 and SAODBLK_B_MainConcept_4 conformance
tests files are correctly decoded with both NV12 and NV12_4L4 pixel formats.
These two files have a resolution of 1016x760.
If step_width = 16 for the both pixel formats the selected capture
resolution is 1024x768 which is wrong for NV12_4L4 (which expect 1016x760)
on Hantro G2 on IMX8MQ (but correct for NV12).

For other variants than Hantro G2 on IMX8M keep the same step_width to avoid
regressions.

Fluster HEVC test score is now 128/147 vs 126/147 with the both pixel
formats as decoder output.
Fluster VP9 test score stay at 147/303.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
 drivers/staging/media/hantro/imx8m_vpu_hw.c   | 40 +++++++++++++++++--
 .../staging/media/hantro/rockchip_vpu_hw.c    | 32 +++++++++++++++
 .../staging/media/hantro/sama5d4_vdec_hw.c    | 16 ++++++++
 drivers/staging/media/hantro/sunxi_vpu_hw.c   | 16 ++++++++
 5 files changed, 101 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 71a6279750bf..93d0dcf69f4a 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -260,7 +260,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 	} else if (ctx->is_encoder) {
 		vpu_fmt = ctx->vpu_dst_fmt;
 	} else {
-		vpu_fmt = ctx->vpu_src_fmt;
+		vpu_fmt = fmt;
 		/*
 		 * Width/height on the CAPTURE end of a decoder are ignored and
 		 * replaced by the OUTPUT ones.
diff --git a/drivers/staging/media/hantro/imx8m_vpu_hw.c b/drivers/staging/media/hantro/imx8m_vpu_hw.c
index 9802508bade2..b6b2bf65e56d 100644
--- a/drivers/staging/media/hantro/imx8m_vpu_hw.c
+++ b/drivers/staging/media/hantro/imx8m_vpu_hw.c
@@ -83,6 +83,14 @@ static const struct hantro_fmt imx8m_vpu_postproc_fmts[] = {
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = MB_DIM,
+		},
 	},
 };
 
@@ -90,6 +98,14 @@ static const struct hantro_fmt imx8m_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = MB_DIM,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_MPEG2_SLICE,
@@ -137,6 +153,14 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = MB_DIM,
+		},
 	},
 };
 
@@ -144,6 +168,14 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12_4L4,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = 4,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = 4,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_HEVC_SLICE,
@@ -152,10 +184,10 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] = {
 		.frmsize = {
 			.min_width = 48,
 			.max_width = 3840,
-			.step_width = MB_DIM,
+			.step_width = 4,
 			.min_height = 48,
 			.max_height = 2160,
-			.step_height = MB_DIM,
+			.step_height = 4,
 		},
 	},
 	{
@@ -165,10 +197,10 @@ static const struct hantro_fmt imx8m_vpu_g2_dec_fmts[] = {
 		.frmsize = {
 			.min_width = 48,
 			.max_width = 3840,
-			.step_width = MB_DIM,
+			.step_width = 4,
 			.min_height = 48,
 			.max_height = 2160,
-			.step_height = MB_DIM,
+			.step_height = 4,
 		},
 	},
 };
diff --git a/drivers/staging/media/hantro/rockchip_vpu_hw.c b/drivers/staging/media/hantro/rockchip_vpu_hw.c
index fc96501f3bc8..efba7fcdf207 100644
--- a/drivers/staging/media/hantro/rockchip_vpu_hw.c
+++ b/drivers/staging/media/hantro/rockchip_vpu_hw.c
@@ -63,6 +63,14 @@ static const struct hantro_fmt rockchip_vpu1_postproc_fmts[] = {
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 1920,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 1088,
+			.step_height = MB_DIM,
+		},
 	},
 };
 
@@ -70,6 +78,14 @@ static const struct hantro_fmt rk3066_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 1920,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 1088,
+			.step_height = MB_DIM,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_H264_SLICE,
@@ -116,6 +132,14 @@ static const struct hantro_fmt rk3288_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 4096,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 2304,
+			.step_height = MB_DIM,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_H264_SLICE,
@@ -162,6 +186,14 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 1920,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 1088,
+			.step_height = MB_DIM,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_H264_SLICE,
diff --git a/drivers/staging/media/hantro/sama5d4_vdec_hw.c b/drivers/staging/media/hantro/sama5d4_vdec_hw.c
index b2fc1c5613e1..07ee804e706b 100644
--- a/drivers/staging/media/hantro/sama5d4_vdec_hw.c
+++ b/drivers/staging/media/hantro/sama5d4_vdec_hw.c
@@ -16,6 +16,14 @@ static const struct hantro_fmt sama5d4_vdec_postproc_fmts[] = {
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 1280,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 720,
+			.step_height = MB_DIM,
+		},
 	},
 };
 
@@ -23,6 +31,14 @@ static const struct hantro_fmt sama5d4_vdec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 1280,
+			.step_width = MB_DIM,
+			.min_height = 48,
+			.max_height = 720,
+			.step_height = MB_DIM,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_MPEG2_SLICE,
diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
index c0edd5856a0c..c2392c08febb 100644
--- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -14,6 +14,14 @@ static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
 		.fourcc = V4L2_PIX_FMT_NV12,
 		.codec_mode = HANTRO_MODE_NONE,
 		.postprocessed = true,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = 32,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = 32,
+		},
 	},
 };
 
@@ -21,6 +29,14 @@ static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12_4L4,
 		.codec_mode = HANTRO_MODE_NONE,
+		.frmsize = {
+			.min_width = 48,
+			.max_width = 3840,
+			.step_width = 32,
+			.min_height = 48,
+			.max_height = 2160,
+			.step_height = 32,
+		},
 	},
 	{
 		.fourcc = V4L2_PIX_FMT_VP9_FRAME,
-- 
2.32.0

