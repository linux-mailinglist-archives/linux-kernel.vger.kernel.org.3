Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63DB526B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384449AbiEMUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384523AbiEMUbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:31:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B85B7A45E;
        Fri, 13 May 2022 13:30:24 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id E733F1F46488
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473809;
        bh=OIhbnD+GYKGESjhoWfLHkSeEKZZ1mESH1BJd09/VI6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGgZSkmlNeEq1zqsBAQ6J/QOV0+EU2s34r7sIdcuq7QFsqawbnepKngMCh61jgJhb
         N4QzmDr5jRBoOubx6Jot6ecXLzlAHuRNlkxCLgae9AB+779PwnWuU14zbXr7HhLxnV
         7UVERLCsKPqD9oJ9j6+525Q0QScfBxvmXp7S512qpp0xna7bFwb1jMCHjGeo5FtB+6
         8dxVa9nBvkioolmbl9Xavcft1MohKl9Ieg2cSKWVt6zmRbuBZahPNa/hm7R8B6EynC
         NAk2Wr4eqyUb5MjnAyINxTahI9gwHZ5/I20f9sHKDUs8Hq026Va/QJ1pYd+OB1lyY2
         cRYhzAVQ8w1Pg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 20/20] media: hantro: Enable HOLD_CAPTURE_BUF for H.264
Date:   Fri, 13 May 2022 16:29:22 -0400
Message-Id: <20220513202922.13846-21-nicolas.dufresne@collabora.com>
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

This is needed to optimize field decoding. Each field will be
decoded into the same capture buffer. To be able to queue multiple
buffers, we need to be able to ask the driver to hold the capture
buffer.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index ed458866257a..22ad182ee972 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -408,6 +408,30 @@ hantro_update_requires_request(struct hantro_ctx *ctx, u32 fourcc)
 	}
 }
 
+static void
+hantro_update_requires_hold_capture_buf(struct hantro_ctx *ctx, u32 fourcc)
+{
+	struct vb2_queue *vq;
+
+	vq = v4l2_m2m_get_vq(ctx->fh.m2m_ctx,
+			     V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
+
+	switch (fourcc) {
+	case V4L2_PIX_FMT_JPEG:
+	case V4L2_PIX_FMT_MPEG2_SLICE:
+	case V4L2_PIX_FMT_VP8_FRAME:
+	case V4L2_PIX_FMT_HEVC_SLICE:
+	case V4L2_PIX_FMT_VP9_FRAME:
+		vq->subsystem_flags &= ~(VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF);
+		break;
+	case V4L2_PIX_FMT_H264_SLICE:
+		vq->subsystem_flags |= VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
+		break;
+	default:
+		break;
+	}
+}
+
 static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 			      struct v4l2_pix_format_mplane *pix_mp)
 {
@@ -471,6 +495,7 @@ static int hantro_set_fmt_out(struct hantro_ctx *ctx,
 	ctx->dst_fmt.quantization = pix_mp->quantization;
 
 	hantro_update_requires_request(ctx, pix_mp->pixelformat);
+	hantro_update_requires_hold_capture_buf(ctx, pix_mp->pixelformat);
 
 	vpu_debug(0, "OUTPUT codec mode: %d\n", ctx->vpu_src_fmt->codec_mode);
 	vpu_debug(0, "fmt - w: %d, h: %d\n",
-- 
2.34.3

