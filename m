Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDAA573B4D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237236AbiGMQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiGMQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:32:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8597C2CDEA;
        Wed, 13 Jul 2022 09:32:45 -0700 (PDT)
Received: from localhost (dynamic-002-247-252-243.2.247.pool.telefonica.de [2.247.252.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EA4F9660191C;
        Wed, 13 Jul 2022 17:32:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657729964;
        bh=CtMDQU5Rl7w4k3vdufuEIThSkeTfJG6tKC5YQsVp1HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7X7PfDkc+hZ1f2XHto4cpy0UH89XxDdmLj0Ti7BFrkFWH7znIArv+eo2ik6wBNpW
         VhhxOdz3d+/YoqzFpVunEMwhiJ4O/3cYJWLKc+Z3sBGYa72C/rc6W1kRetOAPWUL8L
         u0JOjtV/5s2GSGuiAJR20gCc4l2KmLxeOxfqPsmeW30U2XElck3j5VtOMV3urbPUwJ
         hDf0Uz6VUKIXMezm5vuFfkKPBgEsHJPLKyvuK1jSwwu8PV+WRlomO0bKXUCfNVTsSK
         n8YgUnRFPACdDgCJun8CLB26pYKIWDWoK1ovC9eqBU0cj45A5rLOcDB68+m9t+pFxA
         /sfdRBCY8Y15g==
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
Subject: [PATCH 4/6] staging: media: rkvdec: Add valid pixel format check
Date:   Wed, 13 Jul 2022 18:32:01 +0200
Message-Id: <20220713163201.136202-2-sebastian.fricke@collabora.com>
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

Provide a callback for codec variant drivers to indicate the correct
output pixel-format after receiving the SPS of the byte-stream, on the
initial s_ctrl ioctl call from user-space.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/TODO     |  2 ++
 drivers/staging/media/rkvdec/rkvdec.c | 45 +++++++++++++++++++++++----
 drivers/staging/media/rkvdec/rkvdec.h |  2 ++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/media/rkvdec/TODO b/drivers/staging/media/rkvdec/TODO
index 2c0779383276..44e1e06ee6e4 100644
--- a/drivers/staging/media/rkvdec/TODO
+++ b/drivers/staging/media/rkvdec/TODO
@@ -9,3 +9,5 @@
   code in rkvdec_request_validate and cedrus_request_validate.
   The helper needs to the driver private data associated with
   the videobuf2 queue, from a media request.
+
+* Implement the valid_fmt callback for H264 and VP9
diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/media/rkvdec/rkvdec.c
index 7bab7586918c..2625e0a736f4 100644
--- a/drivers/staging/media/rkvdec/rkvdec.c
+++ b/drivers/staging/media/rkvdec/rkvdec.c
@@ -27,6 +27,23 @@
 #include "rkvdec.h"
 #include "rkvdec-regs.h"
 
+/*
+ * Fetch the optimal pixel-format directly from the codec variation. If the
+ * valid_fmt callback is not implemented, then the context variable valid_fmt
+ * will be unset.
+ * When the `valid_fmt` variable is not set, the default pixel_format (the first
+ * entry of the decoded_fmts) is used and `enum_capture_fmt` will return all
+ * available formats for the current coded format.
+ */
+static int rkvdec_get_valid_fmt(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl)
+{
+	const struct rkvdec_coded_fmt_desc *coded_desc = ctx->coded_fmt_desc;
+
+	if (coded_desc->ops->valid_fmt)
+		return coded_desc->ops->valid_fmt(ctx, ctrl);
+	return 0;
+}
+
 static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 {
 	struct rkvdec_ctx *ctx = container_of(ctrl->handler, struct rkvdec_ctx, ctrl_hdl);
@@ -35,6 +52,9 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
 	if (desc->ops->try_ctrl)
 		return desc->ops->try_ctrl(ctx, ctrl);
 
+	if (ctx->valid_fmt && ctx->valid_fmt != rkvdec_get_valid_fmt(ctx, ctrl))
+		/* Only allow the current valid format */
+		return -EINVAL;
 	return 0;
 }
 
@@ -190,6 +210,7 @@ static void rkvdec_reset_decoded_fmt(struct rkvdec_ctx *ctx)
 {
 	struct v4l2_format *f = &ctx->decoded_fmt;
 
+	ctx->valid_fmt = 0;
 	rkvdec_reset_fmt(ctx, f, ctx->coded_fmt_desc->decoded_fmts[0]);
 	f->type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
 	v4l2_fill_pixfmt_mp(&f->fmt.pix_mp,
@@ -249,14 +270,17 @@ static int rkvdec_try_capture_fmt(struct file *file, void *priv,
 	if (WARN_ON(!coded_desc))
 		return -EINVAL;
 
-	for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
-		if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
-			break;
+	if (ctx->valid_fmt) {
+		pix_mp->pixelformat = ctx->valid_fmt;
+	} else {
+		for (i = 0; i < coded_desc->num_decoded_fmts; i++) {
+			if (coded_desc->decoded_fmts[i] == pix_mp->pixelformat)
+				break;
+		}
+		if (i == coded_desc->num_decoded_fmts)
+			pix_mp->pixelformat = coded_desc->decoded_fmts[0];
 	}
 
-	if (i == coded_desc->num_decoded_fmts)
-		pix_mp->pixelformat = coded_desc->decoded_fmts[0];
-
 	/* Always apply the frmsize constraint of the coded end. */
 	pix_mp->width = max(pix_mp->width, ctx->coded_fmt.fmt.pix_mp.width);
 	pix_mp->height = max(pix_mp->height, ctx->coded_fmt.fmt.pix_mp.height);
@@ -325,6 +349,7 @@ static int rkvdec_s_capture_fmt(struct file *file, void *priv,
 		return ret;
 
 	ctx->decoded_fmt = *f;
+	ctx->valid_fmt = f->fmt.pix_mp.pixelformat;
 	return 0;
 }
 
@@ -428,6 +453,14 @@ static int rkvdec_enum_capture_fmt(struct file *file, void *priv,
 	if (WARN_ON(!ctx->coded_fmt_desc))
 		return -EINVAL;
 
+	if (ctx->valid_fmt) {
+		if (f->index)
+			return -EINVAL;
+
+		f->pixelformat = ctx->valid_fmt;
+		return 0;
+	}
+
 	if (f->index >= ctx->coded_fmt_desc->num_decoded_fmts)
 		return -EINVAL;
 
diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
index 633335ebb9c4..b9e219438bc9 100644
--- a/drivers/staging/media/rkvdec/rkvdec.h
+++ b/drivers/staging/media/rkvdec/rkvdec.h
@@ -66,6 +66,7 @@ vb2_to_rkvdec_decoded_buf(struct vb2_buffer *buf)
 struct rkvdec_coded_fmt_ops {
 	int (*adjust_fmt)(struct rkvdec_ctx *ctx,
 			  struct v4l2_format *f);
+	u32 (*valid_fmt)(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ctrl);
 	int (*start)(struct rkvdec_ctx *ctx);
 	void (*stop)(struct rkvdec_ctx *ctx);
 	int (*run)(struct rkvdec_ctx *ctx);
@@ -101,6 +102,7 @@ struct rkvdec_ctx {
 	struct v4l2_fh fh;
 	struct v4l2_format coded_fmt;
 	struct v4l2_format decoded_fmt;
+	u32 valid_fmt;
 	const struct rkvdec_coded_fmt_desc *coded_fmt_desc;
 	struct v4l2_ctrl_handler ctrl_hdl;
 	struct rkvdec_dev *dev;
-- 
2.25.1

