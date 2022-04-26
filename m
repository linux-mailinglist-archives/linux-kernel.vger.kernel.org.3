Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC0A50FE22
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350537AbiDZNCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350401AbiDZNBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:01:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFF217B39C;
        Tue, 26 Apr 2022 05:58:34 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id CDA921F4399D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650977913;
        bh=dZLY5A5SJIWQWpJ/gOaUMK4w2rzl/JljG8yfzL7NyHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U+8pjgSzvqCzEEZreu22RuqA2NH9VJNkmR7y6PYxSdjioGUS+WP7LoQIgWgysclSJ
         shE+gSMTTqRSucz2lQni/PQQ02CQ1yyNWaZ/l2o1Q65kIIBrvruTKcauIJXLFHPYDf
         v82GLbYC5ca7DfVCj6HJKy6LZDYCsfYP14D7UjjH90s9EA7P/mGEXh9ZKNItEzCo5W
         hGMVC/BaX6c/bZY+n+PAPKk52I0TOZExvDIm4J+3Ujl/JvFvYn6eqJsyUVrNszZ4h9
         GHW2APLlSJaOQBGfLZuURGPj8w7+UPzUXiXri1VJoc7WZSTBFvB22VS7xpUJO/hFsi
         W8GPnwn2/JBXg==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     nicolas@ndufresne.ca, linux-media@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 19/24] media: rkvdec-h264: Add field decoding support
Date:   Tue, 26 Apr 2022 08:57:45 -0400
Message-Id: <20220426125751.108293-20-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
References: <20220426125751.108293-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes use of the new feature in the reference builder to program
up to 32 references when doing field decoding. It also signals the
parity (top or bottom) of the field to the hardware.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 48 ++++++++++------------
 1 file changed, 21 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 7011b66c1aab..fbe23d598720 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -97,13 +97,10 @@ struct rkvdec_h264_priv_tbl {
 	u8 err_info[RKV_ERROR_INFO_SIZE];
 };
 
-#define RKVDEC_H264_DPB_SIZE 16
-
 struct rkvdec_h264_reflists {
 	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
 	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
 	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
-	u8 num_valid;
 };
 
 struct rkvdec_h264_run {
@@ -747,23 +744,26 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
 		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
 		int buf_idx = -1;
 
-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
+		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
 			buf_idx = vb2_find_timestamp(cap_q,
 						     dpb[i].reference_ts, 0);
+			if (buf_idx < 0)
+				pr_debug("No buffer for reference_ts %llu",
+					 dpb[i].reference_ts);
+		}
 
 		run->ref_buf_idx[i] = buf_idx;
 	}
 }
 
 static void assemble_hw_rps(struct rkvdec_ctx *ctx,
+			    struct v4l2_h264_reflist_builder *builder,
 			    struct rkvdec_h264_run *run)
 {
 	const struct v4l2_ctrl_h264_decode_params *dec_params = run->decode_params;
 	const struct v4l2_h264_dpb_entry *dpb = dec_params->dpb;
 	struct rkvdec_h264_ctx *h264_ctx = ctx->priv;
-	const struct v4l2_ctrl_h264_sps *sps = run->sps;
 	struct rkvdec_h264_priv_tbl *priv_tbl = h264_ctx->priv_tbl.cpu;
-	u32 max_frame_num = 1 << (sps->log2_max_frame_num_minus4 + 4);
 
 	u32 *hw_rps = priv_tbl->rps;
 	u32 i, j;
@@ -781,37 +781,36 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
 			continue;
 
-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
-		    dpb[i].frame_num <= dec_params->frame_num) {
-			p[i] = dpb[i].frame_num;
-			continue;
-		}
-
-		p[i] = dpb[i].frame_num - max_frame_num;
+		p[i] = builder->refs[i].frame_num;
 	}
 
 	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
-		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
-			bool dpb_valid = run->ref_buf_idx[i] >= 0;
-			u8 idx = 0;
+		for (i = 0; i < builder->num_valid; i++) {
+			struct v4l2_h264_reference *ref;
+			bool dpb_valid;
+			bool bottom;
 
 			switch (j) {
 			case 0:
-				idx = h264_ctx->reflists.p[i].index;
+				ref = &h264_ctx->reflists.p[i];
 				break;
 			case 1:
-				idx = h264_ctx->reflists.b0[i].index;
+				ref = &h264_ctx->reflists.b0[i];
 				break;
 			case 2:
-				idx = h264_ctx->reflists.b1[i].index;
+				ref = &h264_ctx->reflists.b1[i];
 				break;
 			}
 
-			if (idx >= ARRAY_SIZE(dec_params->dpb))
+			if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
 				continue;
 
+			dpb_valid = run->ref_buf_idx[ref->index] >= 0;
+			bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
+
 			set_ps_field(hw_rps, DPB_INFO(i, j),
-				     idx | dpb_valid << 4);
+				     ref->index | dpb_valid << 4);
+			set_ps_field(hw_rps, BOTTOM_FLAG(i, j), bottom);
 		}
 	}
 }
@@ -999,10 +998,6 @@ static void config_registers(struct rkvdec_ctx *ctx,
 				       rkvdec->regs + RKVDEC_REG_H264_BASE_REFER15);
 	}
 
-	/*
-	 * Since support frame mode only
-	 * top_field_order_cnt is the same as bottom_field_order_cnt
-	 */
 	reg = RKVDEC_CUR_POC(dec_params->top_field_order_cnt);
 	writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_CUR_POC0);
 
@@ -1166,7 +1161,6 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 	/* Build the P/B{0,1} ref lists. */
 	v4l2_h264_init_reflist_builder(&reflist_builder, run.decode_params,
 				       run.sps, run.decode_params->dpb);
-	h264_ctx->reflists.num_valid = reflist_builder.num_valid;
 	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
 	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
 				    h264_ctx->reflists.b1);
@@ -1174,7 +1168,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
 	assemble_hw_scaling_list(ctx, &run);
 	assemble_hw_pps(ctx, &run);
 	lookup_ref_buf_idx(ctx, &run);
-	assemble_hw_rps(ctx, &run);
+	assemble_hw_rps(ctx, &reflist_builder, &run);
 	config_registers(ctx, &run);
 
 	rkvdec_run_postamble(ctx, &run.base);
-- 
2.34.1

