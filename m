Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BBF560AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 21:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiF2T4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 15:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiF2T4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 15:56:40 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBAF3D1E5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:56:38 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-101ec2d6087so22894960fac.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 12:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HFVsl/vtb0LtmJV9xGBJtt1ahNXRk67SK3EVKVh221Y=;
        b=2bDTaCV8ZCQCIRrnpkCX22dAcFMZJ7+gT8/WzMpC7HVM/PlpPLvKsmOrxKLKPRJJQk
         cuSzgF8DqV04X21l3rBpAbPC2VRaqrL+Y6LkSgiuTXGlNiummHLeCPVCOXGChm7MUVWL
         NwAvUjFmQox1LUPytEEKA/JKqqOft9xezoZmENyrijozNg5+MDFMu9jgFYi3Z/4Ml9yi
         9q4xGO/3jrWr8TM0KQsAQ8i40Kd3PEW2NJJ/1+5EceIVAZxaJRGf1UNd1Zb9CR8zK8KH
         /tg3LbNHkKWE/xxCWhqVrOnZzknXPXNWHF1NwpcDBdQmQzVyhZbA/LDVLS7/766IMiYH
         Ivyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFVsl/vtb0LtmJV9xGBJtt1ahNXRk67SK3EVKVh221Y=;
        b=P3yD3T8gulrdnSjkredhHUGZxispGSg9vU+d0YKVSmS0FsuWF0AEn/07IlQZ10A6Ki
         tjMjRKvOLwbFnkwFmOh+7zaEPXOxZ9L56YDCjzqft/OjpbT8/kEibc37w9/IhnBiqV5J
         R0/CY+Qgc9DiF1kd/+PYoVioDyd+L1a1TQCAmqBWEE1mcVw3G+SKfi+BU/KMWA5WaE48
         147Yx6KpgbCl2GW9oRVtwfeS1sRLALCLciIzr6NS6H7Ceh+X1Ta6d8hwlthlODmBKk0P
         2WA9/C0RxatUUnQmPlg0GROPDQPjNwzhp20ckqMSr81JPumLN+jLn8bEM5u8QzLQDki5
         5jnA==
X-Gm-Message-State: AJIora8HwjqZIfVYvYczYM4tjbFMnbkQgkeCyC4LysdcIEFGLCaRJNmT
        C3nxyGS2J74zvINE09XxrIVPaw==
X-Google-Smtp-Source: AGRyM1tdVlmyJFOkTxNm1ijpxn3o6ZeEXm82+gTn8R+BhZ7i9/hFTWVsYr3sigkQW2gU7Aycysy/Ow==
X-Received: by 2002:a05:6870:b627:b0:102:f25:a460 with SMTP id cm39-20020a056870b62700b001020f25a460mr2982361oab.193.1656532597945;
        Wed, 29 Jun 2022 12:56:37 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id o31-20020a056870911f00b000f5e33aaa66sm11573057oae.0.2022.06.29.12.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 12:56:37 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] hantro: Remove incorrect HEVC SPS validation
Date:   Wed, 29 Jun 2022 16:56:24 -0300
Message-Id: <20220629195624.45745-2-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220629195624.45745-1-ezequiel@vanguardiasur.com.ar>
References: <20220629195624.45745-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver tries to validat the HEVC SPS
against the CAPTURE queue format (i.e. the decoded format).
This is not correct, because typically the SPS control is set
before the CAPTURE queue is negotiated.

In addition to this, a format validation in hantro_hevc_dec_prepare_run()
is also suboptimal, because hantro_hevc_dec_prepare_run() runs in the context
of v4l2_m2m_ops.device_run, as part of a decoding job.

Format and control validations should happen before decoding starts,
in the context of ioctls such as S_CTRL, S_FMT, or STREAMON.

Remove the validation for now.

Fixes: 135ad96cb4d6b ("media: hantro: Be more accurate on pixel formats step_width constraints")
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/staging/media/hantro/hantro_drv.c  | 12 ++++-----
 drivers/staging/media/hantro/hantro_hevc.c | 30 ----------------------
 drivers/staging/media/hantro/hantro_hw.h   |  1 -
 3 files changed, 6 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index afddf7ac0731..2387ca85ab54 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -253,11 +253,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 
 static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct hantro_ctx *ctx;
-
-	ctx = container_of(ctrl->handler,
-			   struct hantro_ctx, ctrl_handler);
-
 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
 
@@ -273,7 +268,12 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 	} else if (ctrl->id == V4L2_CID_MPEG_VIDEO_HEVC_SPS) {
 		const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
 
-		return hantro_hevc_validate_sps(ctx, sps);
+		if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
+			/* Luma and chroma bit depth mismatch */
+			return -EINVAL;
+		if (sps->bit_depth_luma_minus8 != 0)
+			/* Only 8-bit is supported */
+			return -EINVAL;
 	} else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
 		const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
 
diff --git a/drivers/staging/media/hantro/hantro_hevc.c b/drivers/staging/media/hantro/hantro_hevc.c
index bd924896e409..f86c98e19177 100644
--- a/drivers/staging/media/hantro/hantro_hevc.c
+++ b/drivers/staging/media/hantro/hantro_hevc.c
@@ -154,32 +154,6 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 	return -ENOMEM;
 }
 
-int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
-{
-	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-		/* Luma and chroma bit depth mismatch */
-		return -EINVAL;
-	if (sps->bit_depth_luma_minus8 != 0)
-		/* Only 8-bit is supported */
-		return -EINVAL;
-
-	/*
-	 * for tile pixel format check if the width and height match
-	 * hardware constraints
-	 */
-	if (ctx->vpu_dst_fmt->fourcc == V4L2_PIX_FMT_NV12_4L4) {
-		if (ctx->dst_fmt.width !=
-		    ALIGN(sps->pic_width_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_width))
-			return -EINVAL;
-
-		if (ctx->dst_fmt.height !=
-		    ALIGN(sps->pic_height_in_luma_samples, ctx->vpu_dst_fmt->frmsize.step_height))
-			return -EINVAL;
-	}
-
-	return 0;
-}
-
 int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
 {
 	struct hantro_hevc_dec_hw_ctx *hevc_ctx = &ctx->hevc_dec;
@@ -203,10 +177,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx)
 	if (WARN_ON(!ctrls->sps))
 		return -EINVAL;
 
-	ret = hantro_hevc_validate_sps(ctx, ctrls->sps);
-	if (ret)
-		return ret;
-
 	ctrls->pps =
 		hantro_get_ctrl(ctx, V4L2_CID_MPEG_VIDEO_HEVC_PPS);
 	if (WARN_ON(!ctrls->pps))
diff --git a/drivers/staging/media/hantro/hantro_hw.h b/drivers/staging/media/hantro/hantro_hw.h
index a2e0f0836281..5edff0f0be20 100644
--- a/drivers/staging/media/hantro/hantro_hw.h
+++ b/drivers/staging/media/hantro/hantro_hw.h
@@ -359,7 +359,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
 void hantro_hevc_ref_init(struct hantro_ctx *ctx);
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, int poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
-int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
 
 
 static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
-- 
2.31.1

