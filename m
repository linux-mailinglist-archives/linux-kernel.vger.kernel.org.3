Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DBA526B83
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384437AbiEMUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384484AbiEMUat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3607A81C;
        Fri, 13 May 2022 13:30:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id B57C31F4648B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473794;
        bh=OwoOPzI0oWG8z/kV0ov2jyP52XLRugG702kjNP9bzdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q7eq3aSvGlkLfDeGPaYMdLh30T2S2rDV0GycIPESgZWoNx5zSVVAcpf2H/KF5doRZ
         gmwkc0ZTK8Mf2+h1tNvV0xc4fQLYuu2oX8+gNkudSv2vZR27p5q31MZaqybHuXKApr
         wxCGuaqrfVVPGZhOHr4C3yr+UtghJvZ+WmiwO1pfZGsM04frRUMrpqsRlZ1Nxbw7pv
         sCKW+/G6lyeO09+SbiMwnghbESL0ML40Kq3q+G5vAibBTxeEOKDOl4hzoIileCKI6T
         5CnUEuUiWi8/FJT0NleaEvpNYyzQ+TIO6O4Xw6Qeqo261C+OUMOTNO0VG6p9pckk+0
         XtXSf0MBGIenw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, Jonas Karlman <jonas@kwiboo.se>,
        linux-media@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 12/20] media: rkvdec: h264: Validate and use pic width and height in mbs
Date:   Fri, 13 May 2022 16:29:14 -0400
Message-Id: <20220513202922.13846-13-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
References: <20220513202922.13846-1-nicolas.dufresne@collabora.com>
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
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
[hverkuil: when -> When (first word in a comment block)]
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 81 +++++++++++++++++-----
 1 file changed, 62 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 0dcbcb1bac80..fb41e2fd8359 100644
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
+	 * When frame_mbs_only_flag is not set, this is field height,
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
2.34.3

