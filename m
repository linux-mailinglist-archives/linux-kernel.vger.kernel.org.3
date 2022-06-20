Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F106855233C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 19:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237185AbiFTRzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 13:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243937AbiFTRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 13:55:37 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F8F15A12;
        Mon, 20 Jun 2022 10:55:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i10so11943738wrc.0;
        Mon, 20 Jun 2022 10:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v1dAKvkkLglJ9uDTaYyQQ++nei7aPjDhg2NRvQrXzs4=;
        b=PXCuyOY2oGeqe/2u5291BK7g8iwGzcFWgQdxNTLpEHH5MebO0ENGpfV/osCNwwbFLr
         PKswyNH2KUJXyRp8MkFMIHG3szK5meQQGQxkkmkDvj5tkGmFM3Nfm3qEs1lWk3xvEbko
         X5yzXkjjtxNIX06ku0aHcKOIl9CcOCA8Q21DfiNxHRy2VsjOIZqYBLKYJtP7mU+AzgpP
         pxtvWwWsggyw6c4kkQtrSVDbmQrWL9XTalf5tj2tZZzir0tbyoxC7pY1Z9Q/M1biDvGt
         SGAUEuBoS1obEqxsf+jhO5uTNI8LbSb+MrgIonIyKDgKdZD4FO5nAwYqGNDK1odGUyj3
         GDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v1dAKvkkLglJ9uDTaYyQQ++nei7aPjDhg2NRvQrXzs4=;
        b=tQcoYahw2kK1bdClDw3XOievBYUvuTgiOBMgVLo2oDdvA4hxkH7eGcwa5fzQw+eOh4
         WTVN/xtuzRR6VnLIcVqkRol21wzxnaZk0Y0YC0IQEd7cF4HW87sby5Ml+5x5d2cQC65n
         gLpIjDxDbSm+bEV7xDUCETwx7UShYWkNQepxsiWCA7qaw5lZ4dY1uiTos8VlakHNNkjk
         QbytuehRJDmZgs3SsV+fvVFEFUfrMHEEhxmwkD9HpwkuSQRAzV2YBb2T5EFsprTtX7gv
         ReM/HlX7Wwg2U2nuQH/Ug8cV9KtdsD1E/r1tW6FyfrE9uNPEeFHeXx9Ir2rdwa5XzmOY
         eVfg==
X-Gm-Message-State: AJIora88pKmPnuBGAK2O6cvDUixQ+UjFOUUIXFA+6AQBJHIMAQwuqNMA
        IUBqmS7Rz9DERijuzRm9QIQ=
X-Google-Smtp-Source: AGRyM1vyZHQwsEYRHeXGomkhfnEuVX5Kk/SEGY68XLVA2CO6m/m9uFmxMRCt3nyAUTLTrl4yqMbXuA==
X-Received: by 2002:a05:6000:ca:b0:21b:8082:7518 with SMTP id q10-20020a05600000ca00b0021b80827518mr17634297wrx.124.1655747734550;
        Mon, 20 Jun 2022 10:55:34 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 184-20020a1c02c1000000b0039db31f6372sm19620752wmc.2.2022.06.20.10.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 10:55:34 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, paul.kocialkowski@bootlin.com, wens@csie.org,
        samuel@sholland.org
Cc:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 4/7] media: cedrus: Add error handling for failed setup
Date:   Mon, 20 Jun 2022 19:55:14 +0200
Message-Id: <20220620175517.648767-5-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620175517.648767-1-jernej.skrabec@gmail.com>
References: <20220620175517.648767-1-jernej.skrabec@gmail.com>
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

During decoding setup stage for complex codecs like HEVC driver can
detect inconsistent values in controls or some other task, like
allocating memory, can fail.

Currently setup stage has no way of signalling error. Change return type
of setup callback to int and if returned value is not zero, skip
decoding and finish job immediately with error flag.

While currently there is only one place when setup can fail, it's
expected that there will be more such cases in the future, when HEVC
decoding is improved.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  2 +-
 .../staging/media/sunxi/cedrus/cedrus_dec.c   | 21 ++++++++++++++-----
 .../staging/media/sunxi/cedrus/cedrus_h264.c  |  5 +++--
 .../staging/media/sunxi/cedrus/cedrus_h265.c  |  8 +++----
 .../staging/media/sunxi/cedrus/cedrus_mpeg2.c |  4 +++-
 .../staging/media/sunxi/cedrus/cedrus_vp8.c   |  5 +++--
 6 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/staging/media/sunxi/cedrus/cedrus.h
index 3bc094eb497f..d2b697a9ded2 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.h
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
@@ -162,7 +162,7 @@ struct cedrus_dec_ops {
 	void (*irq_clear)(struct cedrus_ctx *ctx);
 	void (*irq_disable)(struct cedrus_ctx *ctx);
 	enum cedrus_irq_status (*irq_status)(struct cedrus_ctx *ctx);
-	void (*setup)(struct cedrus_ctx *ctx, struct cedrus_run *run);
+	int (*setup)(struct cedrus_ctx *ctx, struct cedrus_run *run);
 	int (*start)(struct cedrus_ctx *ctx);
 	void (*stop)(struct cedrus_ctx *ctx);
 	void (*trigger)(struct cedrus_ctx *ctx);
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
index aabe6253078e..b0944abaacbd 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
@@ -28,6 +28,7 @@ void cedrus_device_run(void *priv)
 	struct cedrus_dev *dev = ctx->dev;
 	struct cedrus_run run = {};
 	struct media_request *src_req;
+	int error;
 
 	run.src = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	run.dst = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
@@ -89,16 +90,26 @@ void cedrus_device_run(void *priv)
 
 	cedrus_dst_format_set(dev, &ctx->dst_fmt);
 
-	dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
+	error = dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
+	if (error)
+		v4l2_err(&ctx->dev->v4l2_dev,
+			 "Failed to setup decoding job: %d\n", error);
 
 	/* Complete request(s) controls if needed. */
 
 	if (src_req)
 		v4l2_ctrl_request_complete(src_req, &ctx->hdl);
 
-	dev->dec_ops[ctx->current_codec]->trigger(ctx);
+	/* Trigger decoding if setup went well, bail out otherwise. */
+	if (!error) {
+		dev->dec_ops[ctx->current_codec]->trigger(ctx);
 
-	/* Start the watchdog timer. */
-	schedule_delayed_work(&dev->watchdog_work,
-			      msecs_to_jiffies(2000));
+		/* Start the watchdog timer. */
+		schedule_delayed_work(&dev->watchdog_work,
+				      msecs_to_jiffies(2000));
+	} else {
+		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
+						 ctx->fh.m2m_ctx,
+						 VB2_BUF_STATE_ERROR);
+	}
 }
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
index d8fb93035470..c345e67ba9bc 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
@@ -493,8 +493,7 @@ static void cedrus_h264_irq_disable(struct cedrus_ctx *ctx)
 		     reg & ~VE_H264_CTRL_INT_MASK);
 }
 
-static void cedrus_h264_setup(struct cedrus_ctx *ctx,
-			      struct cedrus_run *run)
+static int cedrus_h264_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	struct cedrus_dev *dev = ctx->dev;
 
@@ -510,6 +509,8 @@ static void cedrus_h264_setup(struct cedrus_ctx *ctx,
 	cedrus_write_frame_list(ctx, run);
 
 	cedrus_set_params(ctx, run);
+
+	return 0;
 }
 
 static int cedrus_h264_start(struct cedrus_ctx *ctx)
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
index 46119912c387..cfde4ccf6011 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_h265.c
@@ -326,8 +326,7 @@ static int cedrus_h265_is_low_delay(struct cedrus_run *run)
 	return 0;
 }
 
-static void cedrus_h265_setup(struct cedrus_ctx *ctx,
-			      struct cedrus_run *run)
+static int cedrus_h265_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	struct cedrus_dev *dev = ctx->dev;
 	const struct v4l2_ctrl_hevc_sps *sps;
@@ -385,8 +384,7 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 					GFP_KERNEL, DMA_ATTR_NO_KERNEL_MAPPING);
 		if (!ctx->codec.h265.mv_col_buf) {
 			ctx->codec.h265.mv_col_buf_size = 0;
-			// TODO: Abort the process here.
-			return;
+			return -ENOMEM;
 		}
 	}
 
@@ -703,6 +701,8 @@ static void cedrus_h265_setup(struct cedrus_ctx *ctx,
 
 	/* Enable appropriate interruptions. */
 	cedrus_write(dev, VE_DEC_H265_CTRL, VE_DEC_H265_CTRL_IRQ_MASK);
+
+	return 0;
 }
 
 static int cedrus_h265_start(struct cedrus_ctx *ctx)
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
index 5dad2f296c6d..4cfc4a3c8a7f 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_mpeg2.c
@@ -48,7 +48,7 @@ static void cedrus_mpeg2_irq_disable(struct cedrus_ctx *ctx)
 	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
 }
 
-static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
+static int cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	const struct v4l2_ctrl_mpeg2_sequence *seq;
 	const struct v4l2_ctrl_mpeg2_picture *pic;
@@ -185,6 +185,8 @@ static void cedrus_mpeg2_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 	      VE_DEC_MPEG_CTRL_MC_CACHE_EN;
 
 	cedrus_write(dev, VE_DEC_MPEG_CTRL, reg);
+
+	return 0;
 }
 
 static void cedrus_mpeg2_trigger(struct cedrus_ctx *ctx)
diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
index f4016684b32d..3f750d1795b6 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus_vp8.c
@@ -651,8 +651,7 @@ static void cedrus_vp8_irq_disable(struct cedrus_ctx *ctx)
 		     reg & ~VE_H264_CTRL_INT_MASK);
 }
 
-static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
-			     struct cedrus_run *run)
+static int cedrus_vp8_setup(struct cedrus_ctx *ctx, struct cedrus_run *run)
 {
 	const struct v4l2_ctrl_vp8_frame *slice = run->vp8.frame_params;
 	struct vb2_queue *cap_q = &ctx->fh.m2m_ctx->cap_q_ctx.q;
@@ -855,6 +854,8 @@ static void cedrus_vp8_setup(struct cedrus_ctx *ctx,
 		ctx->codec.vp8.last_sharpness_level =
 			slice->lf.sharpness_level;
 	}
+
+	return 0;
 }
 
 static int cedrus_vp8_start(struct cedrus_ctx *ctx)
-- 
2.36.1

