Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33224C5C72
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231461AbiB0OvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiB0OvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:51:11 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297185D5EC;
        Sun, 27 Feb 2022 06:50:34 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a8so20043623ejc.8;
        Sun, 27 Feb 2022 06:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvrOVZNjXQyBUoPy6U7DgZ3tOvIxB5qxIwEMbzSMThQ=;
        b=LS8iUC/yQ7XC7WOXpHLYu3ehoe12LzROQTpkmx9FVArheOQ/gQsb54Gu9Gj9md2OFN
         HAiZRU0mjPKQvGEOGNF6khsmywBQZef1GfBBq4zRgRjeKczgJP8qJUYaWBHedupTzo7M
         O4h6nX2XKZnmRQdcgtaq+Le8lWkI0SU+zB+5ePIrfp/TKOKMpLdvWwuYSBEA8IZ+qaWj
         O5NMKnB6+LtlNCTlFzGfUoWL3wOlUnYwnK669ux4i9bVkq+jcWO52b3erMfiM6kaEhHG
         19PFMLhcEAGWw+RpOeEjrJEumDWMZ47oU64F3MHIjWP6a3CctBcXQWtSFqB2Z19N/oXP
         JO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvrOVZNjXQyBUoPy6U7DgZ3tOvIxB5qxIwEMbzSMThQ=;
        b=2eQo4f1KwVc/5yXugQClSWLADR4/63shuoJIXG9VUpMFZcu2Zlw0P3l9tQZB+8GSk5
         +MXSICA1GerJ5Q/1cGeCXUIWDNeEnUYlRjG7TqJQ3H20KIU5yxSLqfkTcWcaprSyNwfJ
         8/lWz7TV8rYO1jjS7HobnY6zF0m9t5eDfUAA0j0vMkXUixt3BqjU0UYlUuXc0M5w1dAG
         CgfmEjzG9BXS8ngDLwR0Y0KL5Odw4P7Kn8t8+x4GGoYUq3N85epgrCOjgKr7TtVhkW15
         s/K+aGBeQFgMQX7w5Wd8Xc7708a0x/1NQF3PQ49fXmqqfASgI2gUrqsDfGaOZ3yJf7Au
         GSXg==
X-Gm-Message-State: AOAM531+BYq1iIaPvNAjhN13arc0Nrun9a0d13rRn0zTQL/1sjzRUCWj
        IEKAhIIzuZj1a1FsmpTFiYE=
X-Google-Smtp-Source: ABdhPJzkK0ZwrCSbOnr9zXlDGIC2dvBZjaNz6tG92sdPu2oQhHwSzUvuErAG+ybhThg47RBrJvQCwg==
X-Received: by 2002:a17:906:b052:b0:6ce:88a5:e42a with SMTP id bj18-20020a170906b05200b006ce88a5e42amr12468891ejb.237.1645973432598;
        Sun, 27 Feb 2022 06:50:32 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm3501887ejj.142.2022.02.27.06.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 06:50:32 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [RFC PATCH 3/8] media: hantro: Support format filtering by depth
Date:   Sun, 27 Feb 2022 15:49:21 +0100
Message-Id: <20220227144926.3006585-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting 10-bit formats, add mechanism which will
filter formats based on pixel depth.

Hantro G2 supports only one decoding format natively and that is based
on bit depth of current video frame. Additionally, it makes no sense to
upconvert bitness, so filter those out too.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro.h      |  4 ++
 drivers/staging/media/hantro/hantro_v4l2.c | 48 ++++++++++++++++++++--
 drivers/staging/media/hantro/hantro_v4l2.h |  1 +
 3 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 06d0f3597694..c6525ee8d89a 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -227,6 +227,7 @@ struct hantro_dev {
  *
  * @ctrl_handler:	Control handler used to register controls.
  * @jpeg_quality:	User-specified JPEG compression quality.
+ * @bit_depth:		Bit depth of current frame
  *
  * @codec_ops:		Set of operations related to codec mode.
  * @postproc:		Post-processing context.
@@ -252,6 +253,7 @@ struct hantro_ctx {
 
 	struct v4l2_ctrl_handler ctrl_handler;
 	int jpeg_quality;
+	int bit_depth;
 
 	const struct hantro_codec_ops *codec_ops;
 	struct hantro_postproc_ctx postproc;
@@ -278,6 +280,7 @@ struct hantro_ctx {
  * @enc_fmt:	Format identifier for encoder registers.
  * @frmsize:	Supported range of frame sizes (only for bitstream formats).
  * @postprocessed: Indicates if this format needs the post-processor.
+ * @match_depth: Indicates if format bit depth must match video bit depth
  */
 struct hantro_fmt {
 	char *name;
@@ -288,6 +291,7 @@ struct hantro_fmt {
 	enum hantro_enc_fmt enc_fmt;
 	struct v4l2_frmsize_stepwise frmsize;
 	bool postprocessed;
+	bool match_depth;
 };
 
 struct hantro_reg {
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index e595905b3bd7..1214fa2f64ae 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -64,6 +64,42 @@ hantro_get_postproc_formats(const struct hantro_ctx *ctx,
 	return ctx->dev->variant->postproc_fmts;
 }
 
+int hantro_get_formath_depth(u32 fourcc)
+{
+	switch (fourcc) {
+	case V4L2_PIX_FMT_P010:
+	case V4L2_PIX_FMT_P010_4L4:
+		return 10;
+	default:
+		return 8;
+	}
+}
+
+static bool
+hantro_check_depth_match(const struct hantro_ctx *ctx,
+			 const struct hantro_fmt *fmt)
+{
+	int fmt_depth, ctx_depth = 8;
+
+	if (!fmt->match_depth && !fmt->postprocessed)
+		return true;
+
+	/* 0 means default depth, which is 8 */
+	if (ctx->bit_depth)
+		ctx_depth = ctx->bit_depth;
+
+	fmt_depth = hantro_get_formath_depth(fmt->fourcc);
+
+	/*
+	 * Allow only downconversion for postproc formats for now.
+	 * It may be possible to relax that on some HW.
+	 */
+	if (!fmt->match_depth)
+		return fmt_depth <= ctx_depth;
+
+	return fmt_depth == ctx_depth;
+}
+
 static const struct hantro_fmt *
 hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 {
@@ -91,7 +127,8 @@ hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
 	formats = hantro_get_formats(ctx, &num_fmts);
 	for (i = 0; i < num_fmts; i++) {
 		if (bitstream == (formats[i].codec_mode !=
-				  HANTRO_MODE_NONE))
+				  HANTRO_MODE_NONE) &&
+		    hantro_check_depth_match(ctx, &formats[i]))
 			return &formats[i];
 	}
 	return NULL;
@@ -163,11 +200,13 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
 	formats = hantro_get_formats(ctx, &num_fmts);
 	for (i = 0; i < num_fmts; i++) {
 		bool mode_none = formats[i].codec_mode == HANTRO_MODE_NONE;
+		fmt = &formats[i];
 
 		if (skip_mode_none == mode_none)
 			continue;
+		if (!hantro_check_depth_match(ctx, fmt))
+			continue;
 		if (j == f->index) {
-			fmt = &formats[i];
 			f->pixelformat = fmt->fourcc;
 			return 0;
 		}
@@ -183,8 +222,11 @@ static int vidioc_enum_fmt(struct file *file, void *priv,
 		return -EINVAL;
 	formats = hantro_get_postproc_formats(ctx, &num_fmts);
 	for (i = 0; i < num_fmts; i++) {
+		fmt = &formats[i];
+
+		if (!hantro_check_depth_match(ctx, fmt))
+			continue;
 		if (j == f->index) {
-			fmt = &formats[i];
 			f->pixelformat = fmt->fourcc;
 			return 0;
 		}
diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
index 18bc682c8556..f4a5905ed518 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.h
+++ b/drivers/staging/media/hantro/hantro_v4l2.h
@@ -22,5 +22,6 @@ extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
 extern const struct vb2_ops hantro_queue_ops;
 
 void hantro_reset_fmts(struct hantro_ctx *ctx);
+int hantro_get_formath_depth(u32 fourcc);
 
 #endif /* HANTRO_V4L2_H_ */
-- 
2.35.1

