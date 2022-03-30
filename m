Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26F4EBB7F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbiC3HM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiC3HMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:12:17 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16DC1017DF;
        Wed, 30 Mar 2022 00:10:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a02:3030:d:7e3f:91e1:4be5:4001:fd80])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5C4D41F4393C;
        Wed, 30 Mar 2022 08:10:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648624230;
        bh=Ky14EMhLs84Jm426CqymN8f+VXlw/yhjhgyFuJMtXJY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bzXlUh00yEYU8wd0Fa2fSi6DNHm+PmbZkl5f3xI/8xqCu7zzqJvGO8dfLkSvS48Fb
         Uwf/ieTRLCJVwDe8lbyOdp1NNpGfqkZ3wORV5EygTmoW5n8HCAngZwbEoPQ1mXctzP
         /Z3QmivNgnE5S6fml5qxX+6WcCbV9FImKpuaYadjbgWCu7e3xvDkDoqazIijNsn20C
         CSBcu0XamQ7zECoRJyTsLoA93ZtzLIYlvjS2VXosRlPKFDVjvLTpNKuYYN5pMrkdIh
         6LJhQslq3kfnl7k64YBS9vPEURRlpI5R99ndGOx2g/Oo9Ri/tbLNthuL2uvEhJn91n
         xg0t91PK8UeKg==
Date:   Wed, 30 Mar 2022 09:10:27 +0200
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel@collabora.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 19/24] media: rkvdec-h264: Add field decoding support
Message-ID: <20220330071027.kp6ryruntpysmjau@basti-XPS-13-9310>
References: <20220328195936.82552-1-nicolas.dufresne@collabora.com>
 <20220328195936.82552-20-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20220328195936.82552-20-nicolas.dufresne@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Nicolas,

On 28.03.2022 15:59, Nicolas Dufresne wrote:
>This makes use of the new feature in the reference builder to program
>up to 32 references when doing field decoding. It also signals the
>parity (top of bottom) of the field to the hardware.

s/top of bottom/top or bottom/

>
>Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Reviewed-by: Sebastian Fricke <sebastian.fricke@collabora.com>

Greetings,
Sebastian

>---
> drivers/staging/media/rkvdec/rkvdec-h264.c | 48 ++++++++++------------
> 1 file changed, 21 insertions(+), 27 deletions(-)
>
>diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
>index ec52b195bbd7..891c48bf6a51 100644
>--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
>+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
>@@ -97,13 +97,10 @@ struct rkvdec_h264_priv_tbl {
> 	u8 err_info[RKV_ERROR_INFO_SIZE];
> };
>
>-#define RKVDEC_H264_DPB_SIZE 16
>-
> struct rkvdec_h264_reflists {
> 	struct v4l2_h264_reference p[V4L2_H264_REF_LIST_LEN];
> 	struct v4l2_h264_reference b0[V4L2_H264_REF_LIST_LEN];
> 	struct v4l2_h264_reference b1[V4L2_H264_REF_LIST_LEN];
>-	u8 num_valid;
> };
>
> struct rkvdec_h264_run {
>@@ -738,23 +735,26 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
> 		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
> 		int buf_idx = -1;
>
>-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
>+		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
> 			buf_idx = vb2_find_timestamp(cap_q,
> 						     dpb[i].reference_ts, 0);
>+			if (buf_idx < 0)
>+				pr_debug("No buffer for reference_ts %llu",
>+					 dpb[i].reference_ts);
>+		}
>
> 		run->ref_buf_idx[i] = buf_idx;
> 	}
> }
>
> static void assemble_hw_rps(struct rkvdec_ctx *ctx,
>+			    struct v4l2_h264_reflist_builder *builder,
> 			    struct rkvdec_h264_run *run)
> {
> 	const struct v4l2_ctrl_h264_decode_params *dec_params = run->decode_params;
> 	const struct v4l2_h264_dpb_entry *dpb = dec_params->dpb;
> 	struct rkvdec_h264_ctx *h264_ctx = ctx->priv;
>-	const struct v4l2_ctrl_h264_sps *sps = run->sps;
> 	struct rkvdec_h264_priv_tbl *priv_tbl = h264_ctx->priv_tbl.cpu;
>-	u32 max_frame_num = 1 << (sps->log2_max_frame_num_minus4 + 4);
>
> 	u32 *hw_rps = priv_tbl->rps;
> 	u32 i, j;
>@@ -772,37 +772,36 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
> 		if (!(dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE))
> 			continue;
>
>-		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_LONG_TERM ||
>-		    dpb[i].frame_num <= dec_params->frame_num) {
>-			p[i] = dpb[i].frame_num;
>-			continue;
>-		}
>-
>-		p[i] = dpb[i].frame_num - max_frame_num;
>+		p[i] = builder->refs[i].frame_num;
> 	}
>
> 	for (j = 0; j < RKVDEC_NUM_REFLIST; j++) {
>-		for (i = 0; i < h264_ctx->reflists.num_valid; i++) {
>-			u8 dpb_valid = run->ref_buf_idx[i] >= 0;
>-			u8 idx = 0;
>+		for (i = 0; i < builder->num_valid; i++) {
>+			struct v4l2_h264_reference *ref;
>+			u8 dpb_valid;
>+			u8 bottom;
>
> 			switch (j) {
> 			case 0:
>-				idx = h264_ctx->reflists.p[i].index;
>+				ref = &h264_ctx->reflists.p[i];
> 				break;
> 			case 1:
>-				idx = h264_ctx->reflists.b0[i].index;
>+				ref = &h264_ctx->reflists.b0[i];
> 				break;
> 			case 2:
>-				idx = h264_ctx->reflists.b1[i].index;
>+				ref = &h264_ctx->reflists.b1[i];
> 				break;
> 			}
>
>-			if (idx >= ARRAY_SIZE(dec_params->dpb))
>+			if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
> 				continue;
>
>+			dpb_valid = run->ref_buf_idx[ref->index] >= 0;
>+			bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
>+
> 			set_ps_field(hw_rps, DPB_INFO(i, j),
>-				     idx | dpb_valid << 4);
>+				     ref->index | dpb_valid << 4);
>+			set_ps_field(hw_rps, BOTTOM_FLAG(i, j), bottom);
> 		}
> 	}
> }
>@@ -990,10 +989,6 @@ static void config_registers(struct rkvdec_ctx *ctx,
> 				       rkvdec->regs + RKVDEC_REG_H264_BASE_REFER15);
> 	}
>
>-	/*
>-	 * Since support frame mode only
>-	 * top_field_order_cnt is the same as bottom_field_order_cnt
>-	 */
> 	reg = RKVDEC_CUR_POC(dec_params->top_field_order_cnt);
> 	writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_CUR_POC0);
>
>@@ -1109,7 +1104,6 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
> 	/* Build the P/B{0,1} ref lists. */
> 	v4l2_h264_init_reflist_builder(&reflist_builder, run.decode_params,
> 				       run.sps, run.decode_params->dpb);
>-	h264_ctx->reflists.num_valid = reflist_builder.num_valid;
> 	v4l2_h264_build_p_ref_list(&reflist_builder, h264_ctx->reflists.p);
> 	v4l2_h264_build_b_ref_lists(&reflist_builder, h264_ctx->reflists.b0,
> 				    h264_ctx->reflists.b1);
>@@ -1117,7 +1111,7 @@ static int rkvdec_h264_run(struct rkvdec_ctx *ctx)
> 	assemble_hw_scaling_list(ctx, &run);
> 	assemble_hw_pps(ctx, &run);
> 	lookup_ref_buf_idx(ctx, &run);
>-	assemble_hw_rps(ctx, &run);
>+	assemble_hw_rps(ctx, &reflist_builder, &run);
> 	config_registers(ctx, &run);
>
> 	rkvdec_run_postamble(ctx, &run.base);
>-- 
>2.34.1
>
