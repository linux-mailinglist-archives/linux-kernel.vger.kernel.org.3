Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563D154EB0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378573AbiFPUZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378535AbiFPUZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF605B89B;
        Thu, 16 Jun 2022 13:25:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id d14so3650377eda.12;
        Thu, 16 Jun 2022 13:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c51uSHfgqT7k2tNIUrV7H5ZGpfbVeRCQDNTR1sStdEU=;
        b=L3+y2cfgiuRhq96BHGnNqyeRx/XMEpL25x9wgJBvclTYkGg6RYjrl24zyj7C6tiims
         P5UbFV4B7IDi9KpQII6HsfbAiGMzC22pGi4uiUki5jUZng/DyyJhIPdtkZiG8YZfB6rH
         ygK07BDIOlVhdv+t5ti+eE5UFeVOE1s/zJQw96954cxFqsApxnhfTkB1/ano10RP2qRX
         Cu13FWKRzCgMIr6RVAofZBx2hveQnNiItEnO0N80Ik/OnGdfj5DmMUtc/ByjIcONEAHC
         NzP4Aw9c+RuqXhWDmjmWWBrmFkUwVLKZg31F+pr1LgN2AyEId5MyFIRSlamBwHEzxYRP
         Mljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c51uSHfgqT7k2tNIUrV7H5ZGpfbVeRCQDNTR1sStdEU=;
        b=bok8jpE1BUDnHneVH3iUSdXFCu1B5LRwT4qKX0yjcGta4b+khWCCJN5omTA6T9/gpk
         CfGggEhmjfXXfZh/3PkZIf8K9lcPt3asP0CYLn+7O2Y0Qh5RLwPQSpIccQ3741aC6IPX
         HNG71pPew753b8XU19adnqfNkkHwZss3jHQLob7hFbnQSR3twRvA4rkRSCzWWUZ6yaj/
         Gvzg6wv9KdA88ac+yFnijT9WPbjadBCq5xvc9jdtSSWPRFaa1ZIIZ+9GqGFv9Cy6pIMc
         RCzitB6kKkBcSNUrhd0T/GGNfgV3fRx12qy2Wzfd9q6Rd1yWwfql881FjcVRtlH5b00n
         jdOQ==
X-Gm-Message-State: AJIora/Ejyysl7BaNxLEv5cNT2/+6VUIvqPwQAV0c5KsaQRJJrWTt0ay
        R5nuqqmErs7k/jxvIFGDQT8=
X-Google-Smtp-Source: AGRyM1vh9C1ul0iScKiaQcmQyapU/KGOT+AQ/VECIth2VmkKurQiB4c5R1Voce8qZyY8LUBvHM6tHg==
X-Received: by 2002:a05:6402:3907:b0:431:6776:64e7 with SMTP id fe7-20020a056402390700b00431677664e7mr8718052edb.0.1655411122500;
        Thu, 16 Jun 2022 13:25:22 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:22 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 3/7] media: hantro: postproc: Fix buffer size calculation
Date:   Thu, 16 Jun 2022 22:25:09 +0200
Message-Id: <20220616202513.351039-4-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
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

When allocating aux buffers for postprocessing, it's assumed that base
buffer size is the same as that of output. Coincidentally, that's true
most of the time, but not always. 10-bit source also needs aux buffer
size which is appropriate for 10-bit native format, even if the output
format is 8-bit. Similarly, mv sizes and other extra buffer size also
depends on source width/height, not destination.

Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../staging/media/hantro/hantro_postproc.c    | 24 +++++++++++++------
 drivers/staging/media/hantro/hantro_v4l2.c    |  2 +-
 drivers/staging/media/hantro/hantro_v4l2.h    |  2 ++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_postproc.c b/drivers/staging/media/hantro/hantro_postproc.c
index ab168c1c0d28..b77cc55e43ea 100644
--- a/drivers/staging/media/hantro/hantro_postproc.c
+++ b/drivers/staging/media/hantro/hantro_postproc.c
@@ -12,6 +12,7 @@
 #include "hantro_hw.h"
 #include "hantro_g1_regs.h"
 #include "hantro_g2_regs.h"
+#include "hantro_v4l2.h"
 
 #define HANTRO_PP_REG_WRITE(vpu, reg_name, val) \
 { \
@@ -174,18 +175,27 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 	struct vb2_queue *cap_queue = &m2m_ctx->cap_q_ctx.q;
 	unsigned int num_buffers = cap_queue->num_buffers;
+	struct v4l2_pix_format_mplane pix_mp;
+	const struct hantro_fmt *fmt;
 	unsigned int i, buf_size;
 
-	buf_size = ctx->dst_fmt.plane_fmt[0].sizeimage;
+	/* this should always pick native format */
+	fmt = hantro_get_default_fmt(ctx, false);
+	if (!fmt)
+		return -EINVAL;
+	v4l2_fill_pixfmt_mp(&pix_mp, fmt->fourcc, ctx->src_fmt.width,
+			    ctx->src_fmt.height);
+
+	buf_size = pix_mp.plane_fmt[0].sizeimage;
 	if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_H264_SLICE)
-		buf_size += hantro_h264_mv_size(ctx->dst_fmt.width,
-						ctx->dst_fmt.height);
+		buf_size += hantro_h264_mv_size(pix_mp.width,
+						pix_mp.height);
 	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_VP9_FRAME)
-		buf_size += hantro_vp9_mv_size(ctx->dst_fmt.width,
-					       ctx->dst_fmt.height);
+		buf_size += hantro_vp9_mv_size(pix_mp.width,
+					       pix_mp.height);
 	else if (ctx->vpu_src_fmt->fourcc == V4L2_PIX_FMT_HEVC_SLICE)
-		buf_size += hantro_hevc_mv_size(ctx->dst_fmt.width,
-						ctx->dst_fmt.height);
+		buf_size += hantro_hevc_mv_size(pix_mp.width,
+						pix_mp.height);
 
 	for (i = 0; i < num_buffers; ++i) {
 		struct hantro_aux_buf *priv = &ctx->postproc.dec_q[i];
diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index 334f18a4120d..2c7a805289e7 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -118,7 +118,7 @@ hantro_find_format(const struct hantro_ctx *ctx, u32 fourcc)
 	return NULL;
 }
 
-static const struct hantro_fmt *
+const struct hantro_fmt *
 hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream)
 {
 	const struct hantro_fmt *formats;
diff --git a/drivers/staging/media/hantro/hantro_v4l2.h b/drivers/staging/media/hantro/hantro_v4l2.h
index b17e84c82582..64f6f57e9d7a 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.h
+++ b/drivers/staging/media/hantro/hantro_v4l2.h
@@ -23,5 +23,7 @@ extern const struct vb2_ops hantro_queue_ops;
 
 void hantro_reset_fmts(struct hantro_ctx *ctx);
 int hantro_get_format_depth(u32 fourcc);
+const struct hantro_fmt *
+hantro_get_default_fmt(const struct hantro_ctx *ctx, bool bitstream);
 
 #endif /* HANTRO_V4L2_H_ */
-- 
2.36.1

