Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD48573B52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237257AbiGMQdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbiGMQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:33:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C63A2CE3D;
        Wed, 13 Jul 2022 09:33:13 -0700 (PDT)
Received: from localhost (dynamic-002-247-252-243.2.247.pool.telefonica.de [2.247.252.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C3D46601926;
        Wed, 13 Jul 2022 17:33:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657729992;
        bh=H45vKIVxYSOqYRL43Uz5XTwJe8yBD2CscZqG1frIUiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DVP/8OabOAVdwWtbUamryVmHMiU9imIDdQD/mdYFbP8mAUCazpTc1qPjmeSrtqx8n
         jvq9kx5xIFzHL0H/6OXZYYq/GRnrRpR+JTL6f3ZKEoEiV4JjwFmlV1P3NpHfTP8iR4
         5k4qcpDN4g4Xp5sTt4ajt8Z6i4t4ex7Iq2RqgD7wpBf5wY9Y0SzpqGDSSMuu28shk6
         QgdZop99S4uetfY/+iAuSL/kt5tUpgR8Ndzfn0F/hMr5bTyz/qSRBzdk/X9cv7kkPd
         54G4ehGJLgUHFJx/pNLCXkdzEBdlgWTqNUpswi11hLSwTz5kSS1XuG1OIarDAE5iAi
         qi1IxfylXDNcw==
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     jernej.skrabec@gmail.com, knaerzche@gmail.com,
        kernel@collabora.com, bob.beckett@collabora.com,
        ezequiel@vanguardiasur.com.ar, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        nicolas.dufresne@collabora.com,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 5/6] staging: media: rkvdec: Enable S_CTRL IOCTL
Date:   Wed, 13 Jul 2022 18:32:03 +0200
Message-Id: <20220713163201.136202-3-sebastian.fricke@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713163201.136202-1-sebastian.fricke@collabora.com>
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable user-space to set the SPS of the current byte-stream on the
decoder. This action will trigger the decoder to pick the optimal
pixel-format for the capture queue.

Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/staging/media/rkvdec/rkvdec.c | 60 ++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 2625e0a736f4..f84579f764ab 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,17 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+static void rkvdec_fill_decoded_pixfmt(struct rkvdec_ctx *ctx,
+				       struct v4l2_pix_format_mplane *pix_mp)
+{
+	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
+			    pix_mp->width, pix_mp->height);
+	pix_mp->plane_fmt[0].sizeimage += 128 *
+		DIV_ROUND_UP(pix_mp->width, 16) *
+		DIV_ROUND_UP(pix_mp->height, 16);
+	pix_mp->field = V4L2_FIELD_NONE;
+}
+
 /*
  * Fetch the optimal pixel-format directly from the codec variation. If the
  * valid_fmt callback is not implemented, then the context variable valid_fmt
@@ -44,6 +55,27 @@ static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int rkvdec_set_valid_fmt(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
+{
+	struct v4l2_pix_format_mplane *pix_mp;
+
+	switch (ctrl->id) {
+	case V4L2_CID_STATELESS_H264_SPS:
+	case V4L2_CID_STATELESS_VP9_FRAME:
+	case V4L2_CID_STATELESS_HEVC_SPS:
+		ctx->valid_fmt = rkvdec_get_valid_fmt(ctx, ctrl);
+
+		pix_mp = &ctx->decoded_fmt.fmt.pix_mp;
+		pix_mp->pixelformat = ctx->valid_fmt;
+		rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
+		break;
+	default:
+		dev_err(ctx->dev->dev, "Unsupported stateless control ID: %x\n", ctrl->id);
+		return -EINVAL;
+	};
+	return 0;
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -58,8 +90,18 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 	return 0;
 }
 
+static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
+{
+	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
+
+	if (!ctx->valid_fmt)
+		return rkvdec_set_valid_fmt(ctx, ctrl);
+	return 0;
+}
+
 static const struct v4l2_ctrl_ops rkvdec_ctrl_ops = {
 	.try_ctrl = rkvdec_try_ctrl,
+	.s_ctrl = rkvdec_s_ctrl,
 };
 
 static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] = {
@@ -213,13 +255,9 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
 	ctx->valid_fmt = 0;
 	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
 	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
-	v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
-			    ctx->coded_fmt_desc->decoded_fmts[0],
-			    ctx->coded_fmt.fmt.pix_mp.width,
-			    ctx->coded_fmt.fmt.pix_mp.height);
-	f->fmt.pix_mp.plane_fmt[0].sizeimage += 128 *
-		DIV_ROUND_UP(f->fmt.pix_mp.width, 16) *
-		DIV_ROUND_UP(f->fmt.pix_mp.height, 16);
+	f->fmt.pix_mp.width = ctx->coded_fmt.fmt.pix_mp.width;
+	f->fmt.pix_mp.height = ctx->coded_fmt.fmt.pix_mp.height;
+	rkvdec_fill_decoded_pixfmt(ctx, &f->fmt.pix_mp);
 }
 
 static int rkvdec_enum_framesizes(struct file *file, void *priv,
@@ -288,13 +326,7 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 				       &pix_mp->height,
 				       &coded_desc->frmsize);
 
-	v4l2_fill_pixfmt_mp(pix_mp, pix_mp->pixelformat,
-			    pix_mp->width, pix_mp->height);
-	pix_mp->plane_fmt[0].sizeimage +=
-		128 *
-		DIV_ROUND_UP(pix_mp->width, 16) *
-		DIV_ROUND_UP(pix_mp->height, 16);
-	pix_mp->field = V4L2_FIELD_NONE;
+	rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
 
 	return 0;
 }
-- 
2.25.1

