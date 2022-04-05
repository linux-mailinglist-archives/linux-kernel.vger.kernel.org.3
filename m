Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A74F51FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849082AbiDFCdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444178AbiDEWVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:21:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148BB8D693;
        Tue,  5 Apr 2022 13:45:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nicolas)
        with ESMTPSA id 7D5031F44840
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649191502;
        bh=qqGKTdK+BoJvGXzu5rDFgeoUxEBT3Njqv5q7sTj6RAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nTBbsEIN+ODGAbyDvj4hk9G4suUl/XG2DaUFATQ6ssrFhqtSjFBWvcK+lJeQsEWXz
         uovYAnTDm+UVwBIBYJnHOCoD1UxniLw3i8PdiluH0S+NcL1VlDueL5SdFY1xCs1OXL
         ecWsv+tlLJl11xCmzpZ4Pq0IR2Qp9+8T+osmj8X2FypbyuXa8KLhYhyK9U/If4YpdO
         9/2k5nQ1o2lPG3bGYXc6itCe2YUV60P85qnAPEl+Qa+DrKrCdg5ox+k68MEVE6+qFh
         dyVbbxtSOti4xekLHuwv1uWC6CMeDVexz84vAtV6/UTlzH5VJrgtDKqhT6Np1dNUUF
         l/yl6hvvmi/8g==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v3 13/24] media: rkvdec: h264: Fix dpb_valid implementation
Date:   Tue,  5 Apr 2022 16:44:14 -0400
Message-Id: <20220405204426.259074-14-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
References: <20220405204426.259074-1-nicolas.dufresne@collabora.com>
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
2.34.1

