Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13DD56810B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbiGFIW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbiGFIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:12 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B8DE23BE4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:07 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id o18so12263507pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GvRRDYqEkMGUNjOmIJGO6n6V02vc9/KKxf+1pjh9Zs8=;
        b=mMNHROOZvx/4+XvWmilhnTi0zkXfcba1Cb96RUkWD+EOI3g5HwO8zv8RCVWas0rI4e
         pnSTPuUxcDYyuyAMu8fstIKi6V+HabyrvPeP5HRhU8On4vyKryKb0Rbbj9yrZnuPBwdn
         4s57NqnP97/im14QDQ/ZxUpriE3z+gc9StARA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvRRDYqEkMGUNjOmIJGO6n6V02vc9/KKxf+1pjh9Zs8=;
        b=KF+OGHeuf6JT+uuVuSiBFNPTFI9wKF77J/8wvb5aDSaDt2faTlm4gCgdnqUArUWXaN
         JtByYb8CHsVtFUiHMhekMCZQLG1oVWZiFc0W5xT6kgclaHqyfg30D9Ibdfg78nHpDJ+b
         /pY466NFcJ0CO82IiqiGdbUIw6HljTb4Jzl8orMb7FYRIqOYyhNctO8/5pV4j5NhxL6M
         ejnO9zxzSYHEIsEI/fPQYtl7Gx0clqWnlsix3/6Z/CwV7wMCxMqfTmvq7/sUrgbhWubU
         7jt1+1zo7HNxikQLL9go3olg+g4jQJiM0DGSYYVoCODg2cA3akFa/lkQScypk0mcqC7d
         qtxA==
X-Gm-Message-State: AJIora8PYmEQQ7KHe1uK6Rvnut1tEtInNEOKSt5z/kBbfOyhGM/qkdVS
        aTHqZK+s5Jddoz+lzK2+Kn5E6A==
X-Google-Smtp-Source: AGRyM1vNdPQJg7xronj1vBrOljaWiZtr91rqWTVN0G7OMmVPrmO+T5ZPNpjfodcW+lSrp+a6pTNHjA==
X-Received: by 2002:a62:1508:0:b0:528:be70:2f69 with SMTP id 8-20020a621508000000b00528be702f69mr1173866pfv.42.1657095726798;
        Wed, 06 Jul 2022 01:22:06 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:22:06 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 4/6] media: mediatek: vcodec: decoder: Fix resolution clamping in TRY_FMT
Date:   Wed,  6 Jul 2022 16:21:36 +0800
Message-Id: <20220706082138.2668163-5-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
References: <20220706082138.2668163-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit b018be06f3c7 ("media: mediatek: vcodec: Read max resolution
from dec_capability"), TRY_FMT clamps the resolution to the maximum
that was previously set either by default 1080p or the limit set by a
previous S_FMT call. This does not make sense when doing TRY_FMT for
the output side, which may have different capabilities.

Instead, for the output side, find the maximum resolution based on the
pixel format requested. For the capture side, find the maximum
resolution based on the currently set output format.

The maximum resolution is found from the list of per-format frame
sizes, so the patch "media: mediatek: vcodec: dec: Fix 4K frame size
enumeration" is needed.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 48 ++++++++++++++-----
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 4a64877bcd8f..cdd07fa612ee 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -263,17 +263,44 @@ static int vidioc_vdec_subscribe_evt(struct v4l2_fh *fh,
 	}
 }
 
+static const struct v4l2_frmsize_stepwise *mtk_vdec_get_frmsize(struct mtk_vcodec_ctx *ctx,
+								u32 pixfmt)
+{
+	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
+	int i;
+
+	for (i = 0; i < *dec_pdata->num_framesizes; ++i)
+		if (pixfmt == dec_pdata->vdec_framesizes[i].fourcc)
+			return &dec_pdata->vdec_framesizes[i].stepwise;
+
+	/*
+	 * This should never happen since vidioc_try_fmt_vid_out_mplane()
+	 * always passes through a valid format for the output side, and
+	 * for the capture side, a valid output format should already have
+	 * been set.
+	 */
+	WARN_ONCE(1, "Unsupported format requested.\n");
+	return &dec_pdata->vdec_framesizes[0].stepwise;
+}
+
 static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
+	const struct v4l2_frmsize_stepwise *frmsize;
+	u32 fourcc;
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
-	pix_fmt_mp->width =
-		clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, ctx->max_width);
-	pix_fmt_mp->height =
-		clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, ctx->max_height);
+	/* Always apply frame size constraints from the coded side */
+	if (V4L2_TYPE_IS_OUTPUT(f->type))
+		fourcc = f->fmt.pix_mp.pixelformat;
+	else
+		fourcc = ctx->q_data[MTK_Q_DATA_SRC].fmt->fourcc;
+
+	frmsize = mtk_vdec_get_frmsize(ctx, fourcc);
+	pix_fmt_mp->width = clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, frmsize->max_width);
+	pix_fmt_mp->height = clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, frmsize->max_height);
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		pix_fmt_mp->num_planes = 1;
@@ -289,18 +316,15 @@ static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 		 */
 		tmp_w = pix_fmt_mp->width;
 		tmp_h = pix_fmt_mp->height;
-		v4l_bound_align_image(&pix_fmt_mp->width,
-					MTK_VDEC_MIN_W,
-					ctx->max_width, 6,
-					&pix_fmt_mp->height,
-					MTK_VDEC_MIN_H,
-					ctx->max_height, 6, 9);
+		v4l_bound_align_image(&pix_fmt_mp->width, MTK_VDEC_MIN_W, frmsize->max_width, 6,
+				      &pix_fmt_mp->height, MTK_VDEC_MIN_H, frmsize->max_height, 6,
+				      9);
 
 		if (pix_fmt_mp->width < tmp_w &&
-			(pix_fmt_mp->width + 64) <= ctx->max_width)
+		    (pix_fmt_mp->width + 64) <= frmsize->max_width)
 			pix_fmt_mp->width += 64;
 		if (pix_fmt_mp->height < tmp_h &&
-			(pix_fmt_mp->height + 64) <= ctx->max_height)
+		    (pix_fmt_mp->height + 64) <= frmsize->max_height)
 			pix_fmt_mp->height += 64;
 
 		mtk_v4l2_debug(0,
-- 
2.37.0.rc0.161.g10f37bed90-goog

