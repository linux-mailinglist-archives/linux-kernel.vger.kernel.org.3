Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE128526B80
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 22:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384572AbiEMUbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 16:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384437AbiEMUap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 16:30:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914697A457;
        Fri, 13 May 2022 13:29:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id B18A31F46481
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652473788;
        bh=6VfvBHSE6A+IDfkNG2Ci8I/HmRwNsgBMdcwXJyxIJpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7qCUdIwoDGpQAAqigEm1APjRXaASTGnbn5nOFjTBCdFuJz8mlySsv2OIM9VhI2ED
         wj9K4t4Ts12HDTTUVDQNy26TP2jtl4kIwsCC5pE+V3Z6RjnaXFutyUv7HjO0iIhpj+
         Dd8ku4PfAunrnTznMqnLhUjzbrqEocEE6gDMTpUPEx4O5oYWyzFlTP4v5Rwwao6v57
         9Mx/yBKY/nS5D7VoBYfJCukfy3n9EiBm90VdGG/i8FDOgevmcMDJfZc5dpL626gg8k
         gj5hAzmxO86pJO7zRDf+2rER/vzoG3vzB7tLtMcM/tllpBgXv3eLTU8X9MmxgonOwQ
         3Agta1u7fLoDA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/20] media: rkvdec: h264: Fix dpb_valid implementation
Date:   Fri, 13 May 2022 16:29:11 -0400
Message-Id: <20220513202922.13846-10-nicolas.dufresne@collabora.com>
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

The ref builder only provided references that are marked as valid in the
dpb. Thus the current implementation of dpb_valid would always set the
flag to 1. This is not representing missing frames (this is called
'non-existing' pictures in the spec). In some context, these non-existing
pictures still need to occupy a slot in the reference list according to
the spec.

Fixes: cd33c830448ba ("media: rkvdec: Add the rkvdec driver")
Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
Reviewed-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 33 ++++++++++++++++------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index dff89732ddd0..bcde37d72244 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -112,6 +112,7 @@ struct rkvdec_h264_run {
 	const struct v4l2_ctrl_h264_sps *sps;
 	const struct v4l2_ctrl_h264_pps *pps;
 	const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
+	int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
 };
 
 struct rkvdec_h264_ctx {
@@ -725,6 +726,26 @@ static void assemble_hw_pps(struct rkvdec_ctx *ctx,
 	}
 }
 
+static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
+			       struct rkvdec_h264_run *run)
+{
+	const struct v4l2_ctrl_h264_decode_params *dec_params = run->decode_params;
+	u32 i;
+
+	for (i = 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
+		struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
+		const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
+		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
+		int buf_idx = -1;
+
+		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
+			buf_idx = vb2_find_timestamp(cap_q,
+						     dpb[i].reference_ts, 0);
+
+		run->ref_buf_idx[i] = buf_idx;
+	}
+}
+
 static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 			    struct rkvdec_h264_run *run)
 {
@@ -762,7 +783,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 
 	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
 		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
-			u8 dpb_valid = 0;
+			bool dpb_valid = run->ref_buf_idx[i] >= 0;
 			u8 idx = 0;
 
 			switch (j) {
@@ -779,8 +800,6 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 
 			if (idx >= ARRAY_SIZE(dec_params->dpb))
 				continue;
-			dpb_valid = !!(dpb[idx].flags &
-				       V4L2_H264_DPB_ENTRY_FLAG_ACTIVE);
 
 			set_ps_field(hw_rps, DPB_INFO(i, j),
 				     idx | dpb_valid << 4);
@@ -859,13 +878,8 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_h264_run *run,
 	    unsigned int dpb_idx)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
-	const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
 	struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
-	int buf_idx = -1;
-
-	if (dpb[dpb_idx].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
-		buf_idx = vb2_find_timestamp(cap_q,
-					     dpb[dpb_idx].reference_ts, 0);
+	int buf_idx = run->ref_buf_idx[dpb_idx];
 
 	/*
 	 * If a DPB entry is unused or invalid, address of current destination
@@ -1102,6 +1116,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 
 	assemble_hw_scaling_list(ctx, &run);
 	assemble_hw_pps(ctx, &run);
+	lookup_ref_buf_idx(ctx, &run);
 	assemble_hw_rps(ctx, &run);
 	config_registers(ctx, &run);
 
-- 
2.34.3

