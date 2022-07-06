Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7DF568104
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiGFIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiGFIWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9271237DF
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:02 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id s206so13461744pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu0K2f455RiKxumx5vD+/pZBXQChYIagGzSjzSngBm0=;
        b=IkoTUqFiTmQZXtRFGpGLXQ4ml/3Z6/OBUz2WSlHak9MOD3hgcxye6EFaXNayZrAqrD
         DL4w3r4d5R16hnZEiRzcpl55Yl71jz0rLwHdPu3psiEANvb4Ak8I8a9b7vGQul864/v+
         uK8Nm/r9LKUBqk/NQBwElbsdhHk/454R/QlVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu0K2f455RiKxumx5vD+/pZBXQChYIagGzSjzSngBm0=;
        b=enmwmauJXnLg+B6W/zAz+FSa134xGfA8Wmau/zsFEjTfqOekBwsDjhDAebmCjYpNUi
         7XJlEDF9MoG4uFCktG+UtpWfYty2dnGndOemua1b0/OCYaiEFf0L0K1gYFfIrgGkUKS4
         EGyE2l+wMj5+jDP3nLvLmwkmvivl5S1vmhSARjbPZfNgKqbiW2YumbIdju/cPHrs0yqM
         hV4zc5EFyjtL5Y3BWiB86UGKvS4YKUNu5CqQqoEqO+mJPvWIxpFI+RKheppM16eNMaVF
         iuRDR5UMyXdeP/fMvfDOwKvy+Uk8bP1zIxPLUXB/qcyPvdoDF06owLTWmC+GsfW2SnHD
         DXmA==
X-Gm-Message-State: AJIora82cB+5bZAsj18AV11tal2dtjeOR4QbGz3jqgKZDde4FbtmUyo0
        VnhDSXoaZXMcYztv1xfBslp8hA==
X-Google-Smtp-Source: AGRyM1vHLjJtUAAMKtGVRWIY3QAluyKTCS5Lmqxp1AvtumrW0o/Cqy6NG/Xj5zwHDstMtEEaF4H9qg==
X-Received: by 2002:a63:6984:0:b0:40d:9ebe:5733 with SMTP id e126-20020a636984000000b0040d9ebe5733mr33885451pgc.170.1657095722163;
        Wed, 06 Jul 2022 01:22:02 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:22:01 -0700 (PDT)
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
Subject: [PATCH v2 2/6] media: mediatek: vcodec: decoder: Fix 4K frame size enumeration
Date:   Wed,  6 Jul 2022 16:21:34 +0800
Message-Id: <20220706082138.2668163-3-wenst@chromium.org>
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

This partially reverts commit b018be06f3c7 ("media: mediatek: vcodec:
Read max resolution from dec_capability"). In this commit, the maximum
resolution ended up being a function of both the firmware capability and
the current set format.

However, frame size enumeration for output (coded) formats should not
depend on the format set, but should return supported resolutions for
the format requested by userspace.

Fix this so that the driver returns the supported resolutions correctly,
even if the instance only has default settings, or if the output format
is currently set to VP8F, which does not support 4K.

This adds an copy of special casing for !VP8 and 4K support. The other
existing copy will be removed when .max_{width,height} are removed from
|struct mtk_vcodec_ctx| in a subsequent patch.

Fixes: b018be06f3c7 ("media: mediatek: vcodec: Read max resolution from dec_capability")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c    | 2 --
 .../platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c    | 7 +++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 5d6fdf18c3a6..fcb4b8131c49 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -595,8 +595,6 @@ static int vidioc_enum_framesizes(struct file *file, void *priv,
 		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
 		fsize->stepwise = dec_pdata->vdec_framesizes[i].stepwise;
 
-		fsize->stepwise.max_width = ctx->max_width;
-		fsize->stepwise.max_height = ctx->max_height;
 		mtk_v4l2_debug(1, "%x, %d %d %d %d %d %d",
 				ctx->dev->dec_capability,
 				fsize->stepwise.min_width,
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index f1c0276c9026..5da9901e93a3 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -360,6 +360,13 @@ static void mtk_vcodec_add_formats(unsigned int fourcc,
 
 		mtk_vdec_framesizes[count_framesizes].fourcc = fourcc;
 		mtk_vdec_framesizes[count_framesizes].stepwise = stepwise_fhd;
+		if (!(ctx->dev->dec_capability & VCODEC_CAPABILITY_4K_DISABLED) &&
+		    fourcc != V4L2_PIX_FMT_VP8_FRAME) {
+			mtk_vdec_framesizes[count_framesizes].stepwise.max_width =
+				VCODEC_DEC_4K_CODED_WIDTH;
+			mtk_vdec_framesizes[count_framesizes].stepwise.max_height =
+				VCODEC_DEC_4K_CODED_HEIGHT;
+		}
 		num_framesizes++;
 		break;
 	case V4L2_PIX_FMT_MM21:
-- 
2.37.0.rc0.161.g10f37bed90-goog

