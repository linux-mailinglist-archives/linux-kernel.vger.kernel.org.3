Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B072F55C615
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiF0LZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbiF0LZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:25:15 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9A8659E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:05 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l2so7786495pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2+1y0LCJVkrfpHsQlRGxEvdnIAFt/zhTxrdy/ouAhU=;
        b=FRaInAGaTCaXwvPDQiOiybyVs1ZTq7aqp376IA6xTXMeo48fL1QiC0oNsa5/HetL55
         9HUHwrtKWYZ1Pn3nxng6Lr66Ut1zka2dTP94nT+yTufd+icL2WJ59mHZ/iaNZK4dkxE7
         7+g5zJGUIdsmMd22pGGmiLmu4Xk3PdkamGcOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2+1y0LCJVkrfpHsQlRGxEvdnIAFt/zhTxrdy/ouAhU=;
        b=PdcnPR7BQE1bo4oeMpwGFsFceaLqtZ+ULs215ceHj9Ktjog9PyaH2FU0mOQC2QzcEB
         Cz66Y75/u38RWli+NqqxhF9bxQrx+Fv7Y6+ClqPLIDAOmBXzC1sr6E+hj7gUKYyyc+lb
         B4TENhGKvvoejoenwWW0Tc8zlGLgbQb1jP1pVYGAgU+QG+zEMKMstUfCixybDi6T3I5g
         6xm9OhvD9MTfo5XJ9yYhV24hzgRcnXYh4CIniQRJZ49s7K8kQYXAbnaYLsScHb2deFrH
         CaHpktsTjzaTjhj0E/U90cZgoz7G7UwKFHO4xJT/LVDmyz55zT/rkoudEKnE+Be5reAL
         0gHQ==
X-Gm-Message-State: AJIora+a2wRr0HiaAo7JVSbJyFB3rBZSYB+onOTjWOeFETnSNH7q14PO
        y+Daw8YraQ47yGOFSg9Nd6jDKg==
X-Google-Smtp-Source: AGRyM1vq1tIU8x5lkBrW/7ilQI/Txpt0kSZaL6oXEJkTV+khkTTmLOcOfrxjLLVXkYCHw9PaRKrIdA==
X-Received: by 2002:a17:902:c2c6:b0:168:d8ce:90b2 with SMTP id c6-20020a170902c2c600b00168d8ce90b2mr14451592pla.110.1656329105228;
        Mon, 27 Jun 2022 04:25:05 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:2dc1:c31b:b5ed:f3aa])
        by smtp.gmail.com with ESMTPSA id lj4-20020a17090b344400b001ece32cbec9sm9246889pjb.24.2022.06.27.04.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 04:25:04 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH 3/4] media: mediatek: vcodec: dec: Fix resolution clamping in TRY_FMT
Date:   Mon, 27 Jun 2022 19:24:01 +0800
Message-Id: <20220627112402.2332046-4-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220627112402.2332046-1-wenst@chromium.org>
References: <20220627112402.2332046-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
pixel format requested. For the capture side, continue to use the
maximum resolution set by default or by a previous S_FMT call.

The maximum resolution is found from the list of per-format frame
sizes, so the patch "media: mediatek: vcodec: dec: Fix 4K frame size
enumeration" is needed.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 28 +++++++++++++++----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index f1b82d4c5be5..ea951cb3b927 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -282,13 +282,29 @@ static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 			  const struct mtk_video_fmt *fmt)
 {
 	struct v4l2_pix_format_mplane *pix_fmt_mp = &f->fmt.pix_mp;
+	const struct mtk_vcodec_dec_pdata *dec_pdata = ctx->dev->vdec_pdata;
+	unsigned int max_width, max_height;
+	int i;
+
+	if (V4L2_TYPE_IS_OUTPUT(f->type)) {
+		max_width = MTK_VDEC_MAX_W;
+		max_height = MTK_VDEC_MAX_H;
+		for (i = 0; i < *dec_pdata->num_framesizes; ++i)
+			if (f->fmt.pix_mp.pixelformat == dec_pdata->vdec_framesizes[i].fourcc) {
+				max_width = dec_pdata->vdec_framesizes[i].stepwise.max_width;
+				max_height = dec_pdata->vdec_framesizes[i].stepwise.max_height;
+			}
+	} else {
+		max_width = ctx->max_width;
+		max_height = ctx->max_height;
+	}
 
 	pix_fmt_mp->field = V4L2_FIELD_NONE;
 
 	pix_fmt_mp->width =
-		clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, ctx->max_width);
+		clamp(pix_fmt_mp->width, MTK_VDEC_MIN_W, max_width);
 	pix_fmt_mp->height =
-		clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, ctx->max_height);
+		clamp(pix_fmt_mp->height, MTK_VDEC_MIN_H, max_height);
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
 		pix_fmt_mp->num_planes = 1;
@@ -306,16 +322,16 @@ static int vidioc_try_fmt(struct mtk_vcodec_ctx *ctx, struct v4l2_format *f,
 		tmp_h = pix_fmt_mp->height;
 		v4l_bound_align_image(&pix_fmt_mp->width,
 					MTK_VDEC_MIN_W,
-					ctx->max_width, 6,
+					max_width, 6,
 					&pix_fmt_mp->height,
 					MTK_VDEC_MIN_H,
-					ctx->max_height, 6, 9);
+					max_height, 6, 9);
 
 		if (pix_fmt_mp->width < tmp_w &&
-			(pix_fmt_mp->width + 64) <= ctx->max_width)
+			(pix_fmt_mp->width + 64) <= max_width)
 			pix_fmt_mp->width += 64;
 		if (pix_fmt_mp->height < tmp_h &&
-			(pix_fmt_mp->height + 64) <= ctx->max_height)
+			(pix_fmt_mp->height + 64) <= max_height)
 			pix_fmt_mp->height += 64;
 
 		mtk_v4l2_debug(0,
-- 
2.37.0.rc0.161.g10f37bed90-goog

