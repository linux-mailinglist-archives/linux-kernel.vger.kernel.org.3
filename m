Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED13578D06
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbiGRVlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiGRVlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:41:50 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AB3FE9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:41:49 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id l9-20020a056830268900b006054381dd35so10326036otu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t9rytPmeqFH2Wd/U+2J6aAiKGTb8qjc+G9tILk4rL+o=;
        b=673izi6FaWIXaQo68kCVBWuqTcPy5bBNkPPzdma1NDcvK7749YkSbzUnfdnlghf6bE
         Rca1hsM88SFppUmKqJOgxd9VOoxIg2JqxKuAgyYXdTcMXCMiEUfFm7nH04VisShEbagV
         a/4W/hJIIVotOBnF5Ta01do9hoJ8BJWEEuyol2edXMzBwdOH4zae9707gyx3TQEknxQK
         LYbCEp91eyWJHbLvX9wmaIzNwngYh3GyVqhcJQKlGeXd3xPodgR/CWyQY0lAu/4UvijQ
         eVbGFGaHpRzvwgTSB6DF6s6q1NIyrui1U1D9dHLFCaH3svQ7rjchzpA8KhVnXj5ayAQf
         Pkjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t9rytPmeqFH2Wd/U+2J6aAiKGTb8qjc+G9tILk4rL+o=;
        b=aZAtGBqVk2hMjPhMXBlBJtG66c0sy2+kCRpDe6qkMRwDzefRRDbVTeP7F1KPVAcg4z
         jJzNjL6T6hI3e8ov+c7A8woaCNmoJWXQESgIwn1Xg//CQNKdpVtSd72jNMbxkHwzF/Dq
         xc5x4ShF9isOHT619+RAwuNoL5sY4nAXhrMCUbukfRIV3dSB6CTUg2HMfythjnlqfuUz
         epAMLz2T80YJcXYW5/my6TsaKgu7Zlh6+nEliZjeJrF+47SEs7ZPnr2khXvoYC11+IW1
         VGIrgGBmxVAoX4ihdsb/byz86vcevHXphimF16wlSNLaqlBPPA544KXiJbIw5uRMxr9b
         Px0w==
X-Gm-Message-State: AJIora/ZGQmRb5az7Km4AqZKlQlSXb2ISZeNPIoPoJ/XZVrz5mheaJeC
        i2ANvRPnJ9FC3dJX8RP9wKSlyg==
X-Google-Smtp-Source: AGRyM1usRheDKkJmw5DT01Vher5thRqL6rR/p6ppQ2UKZhBZAq7u/nV02+ke6ArbVzzlsO5ayv/GYg==
X-Received: by 2002:a9d:1919:0:b0:61c:930c:7db6 with SMTP id j25-20020a9d1919000000b0061c930c7db6mr5423814ota.19.1658180509059;
        Mon, 18 Jul 2022 14:41:49 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id a39-20020a056870a1a700b0010490c6b552sm6781283oaf.35.2022.07.18.14.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:41:48 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Chris Healy <cphealy@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH] hantro: Remove incorrect HEVC SPS validation
Date:   Mon, 18 Jul 2022 18:41:23 -0300
Message-Id: <20220718214123.73275-3-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
References: <20220718214123.73275-1-ezequiel@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the driver tries to validat the HEVC SPS
against the CAPTURE queue format (i.e. the decoded format).
This is not correct, because typically the SPS control is set
before the CAPTURE queue is negotiated.

Fixes: 135ad96cb4d6b ("media: hantro: Be more accurate on pixel formats step_width constraints")
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/media/platform/verisilicon/hantro_drv.c  | 12 ++++++------
 drivers/media/platform/verisilicon/hantro_hevc.c |  9 +--------
 drivers/media/platform/verisilicon/hantro_hw.h   |  1 -
 3 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index e5fc0a99b728..2036f72eeb4a 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
 
 static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 {
-	struct hantro_ctx *ctx;
-
-	ctx = container_of(ctrl->handler,
-			   struct hantro_ctx, ctrl_handler);
-
 	if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
 		const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
 
@@ -271,7 +266,12 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
 	} else if (ctrl->id == V4L2_CID_STATELESS_HEVC_SPS) {
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
 
diff --git a/drivers/media/platform/verisilicon/hantro_hevc.c b/drivers/media/platform/verisilicon/hantro_hevc.c
index 5984c5fa6f83..b990bc98164c 100644
--- a/drivers/media/platform/verisilicon/hantro_hevc.c
+++ b/drivers/media/platform/verisilicon/hantro_hevc.c
@@ -154,15 +154,8 @@ static int tile_buffer_reallocate(struct hantro_ctx *ctx)
 	return -ENOMEM;
 }
 
-int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
+static int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps)
 {
-	if (sps->bit_depth_luma_minus8 != sps->bit_depth_chroma_minus8)
-		/* Luma and chroma bit depth mismatch */
-		return -EINVAL;
-	if (sps->bit_depth_luma_minus8 != 0)
-		/* Only 8-bit is supported */
-		return -EINVAL;
-
 	/*
 	 * for tile pixel format check if the width and height match
 	 * hardware constraints
diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/media/platform/verisilicon/hantro_hw.h
index 762631d15fdc..e83f0c523a30 100644
--- a/drivers/media/platform/verisilicon/hantro_hw.h
+++ b/drivers/media/platform/verisilicon/hantro_hw.h
@@ -360,7 +360,6 @@ int hantro_hevc_dec_prepare_run(struct hantro_ctx *ctx);
 void hantro_hevc_ref_init(struct hantro_ctx *ctx);
 dma_addr_t hantro_hevc_get_ref_buf(struct hantro_ctx *ctx, s32 poc);
 int hantro_hevc_add_ref_buf(struct hantro_ctx *ctx, int poc, dma_addr_t addr);
-int hantro_hevc_validate_sps(struct hantro_ctx *ctx, const struct v4l2_ctrl_hevc_sps *sps);
 
 
 static inline unsigned short hantro_vp9_num_sbs(unsigned short dimension)
-- 
2.34.3

