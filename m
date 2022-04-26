Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC1D50FE0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350492AbiDZNCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350388AbiDZNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044D17B39C;
        Tue, 26 Apr 2022 05:58:28 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 67CE51F4398D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977907;
        bh=0J+46psvSTuyS1wejcCrG3atoNuCwZAAyNkbTjDMFsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aeiO2ufbvhFNYb7zVWgxzT+dtqF3tl7RyjAsaf8KVsW60NFm4QkISfL9a12zsEYle
         jA5BgytAjoyMdKIVIBVxxaJCwyvW+Doi+iLHXdGa8ZOsDMwxLXq5Dw27QRO9EyRnCu
         i6IPmh8a6W26TEeWalrLgOoVyFvNBD6Na9c+tWGE90XED+IfZGudpMYlKko4q1dVuw
         TwKI2T194dTmEohVKjaaRS5uwYzF/3zpslBwroYj1IByMcEFDoidltpPOkXEV2wFgH
         FqpjjuNIEWv4xLOOb2EcmI0gKiO7+Gg23oICPHN2qO5sv8vIjpnkJ5WaHUmnn9qt0j
         poaAaDreu9YVQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v4 16/24] media: rkvdec: h264: Validate and use pic width and height in mbs
Date:   Tue, 26 Apr 2022 08:57:42 -0400
Message-Id: <20220426125751.108293-17-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonas Karlman <jonas@kwiboo.se>

The width and height in macroblocks is currently configured based on OUTPUT
buffer resolution, this works for frame pictures but can cause issues for
field pictures.

When frame_mbs_only_flag is 0 the height in mbs should be height of
the field instead of height of frame.

Validate pic_width_in_mbs_minus1 and pic_height_in_map_units_minus1
against OUTPUT buffer resolution and use these values to configure HW.
The validation is happening in both try_ctrt() and start() since it is
otherwise possible to trick the driver during initialization by changing
the OUTPUT format after having set a valid control.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 81 +++++++++++++++++-----
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 0dcbcb1bac80..d5ac0285f36f 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -672,8 +672,17 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 		  LOG2_MAX_PIC_ORDER_CNT_LSB_MINUS4);
 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_DELTA_PIC_ORDER_ALWAYS_ZERO),
 		  DELTA_PIC_ORDER_ALWAYS_ZERO_FLAG);
-	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.width, 16), PIC_WIDTH_IN_MBS);
-	WRITE_PPS(DIV_ROUND_UP(ctx->coded_fmt.fmt.pix_mp.height, 16), PIC_HEIGHT_IN_MBS);
+
+	/*
+	 * Use the SPS values since they are already in macroblocks
+	 * dimensions, height can be field height (halved) if
+	 * V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY is not set and also it allows
+	 * decoding smaller images into larger allocation which can be used
+	 * to implementing SVC spatial layer support.
+	 */
+	WRITE_PPS(sps->pic_width_in_mbs_minus1 + 1, PIC_WIDTH_IN_MBS);
+	WRITE_PPS(sps->pic_height_in_map_units_minus1 + 1, PIC_HEIGHT_IN_MBS);
+
 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY),
 		  FRAME_MBS_ONLY_FLAG);
 	WRITE_PPS(!!(sps->flags & V4L2_H264_SPS_FLAG_MB_ADAPTIVE_FRAME_FIELD),
@@ -1035,13 +1044,61 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec_ctx *ctx,
 	return 0;
 }
 
+static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
+				    const struct v4l2_ctrl_h264_sps *sps)
+{
+	unsigned int width, height;
+
+	/*
+	 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
+	 * but it's currently broken in the driver.
+	 * Reject them for now, until it's fixed.
+	 */
+	if (sps->chroma_format_idc > 1)
+		/* Only 4:0:0 and 4:2:0 are supported */
+		return -EINVAL;
+	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+		/* Luma and chroma bit depth mismatch */
+		return -EINVAL;
+	if (sps->bit_depth_luma_minus8 != 0)
+		/* Only 8-bit is supported */
+		return -EINVAL;
+
+	width = (sps->pic_width_in_mbs_minus1 + 1) * 16;
+	height = (sps->pic_height_in_map_units_minus1 + 1) * 16;
+
+	/*
+	 * when frame_mbs_only_flag is not set, this is field height,
+	 * which is half the final height (see (7-18) in the
+	 * specification)
+	 */
+	if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
+		height *= 2;
+
+	if (width > ctx->coded_fmt.fmt.pix_mp.width ||
+	    height > ctx->coded_fmt.fmt.pix_mp.height)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int rkvdec_h264_start(struct rkvdec_ctx *ctx)
 {
 	struct rkvdec_dev *rkvdec = ctx->dev;
 	struct rkvdec_h264_priv_tbl *priv_tbl;
 	struct rkvdec_h264_ctx *h264_ctx;
+	struct v4l2_ctrl *ctrl;
 	int ret;
 
+	ctrl = v4l2_ctrl_find(&ctx->ctrl_hdl,
+			      V4L2_CID_STATELESS_H264_SPS);
+	if (!ctrl)
+		return -EINVAL;
+
+	ret = rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
+	if (ret)
+		return ret;
+
 	h264_ctx = kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
 	if (!h264_ctx)
 		return -ENOMEM;
@@ -1139,23 +1196,9 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 {
-	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
-		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
-		/*
-		 * TODO: The hardware supports 10-bit and 4:2:2 profiles,
-		 * but it's currently broken in the driver.
-		 * Reject them for now, until it's fixed.
-		 */
-		if (sps->chroma_format_idc > 1)
-			/* Only 4:0:0 and 4:2:0 are supported */
-			return -EINVAL;
-		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-			/* Luma and chroma bit depth mismatch */
-			return -EINVAL;
-		if (sps->bit_depth_luma_minus8 != 0)
-			/* Only 8-bit is supported */
-			return -EINVAL;
-	}
+	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS)
+		return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
+
 	return 0;
 }
 
-- 
2.34.1

