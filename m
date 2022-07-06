Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C155691BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiGFS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiGFS1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:40 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8D2193D4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:39 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id u187so4618090vsb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=asP5WW1PtGLGLgC0vcc0NACNPp01Esm7Z0OiLq0F9GE=;
        b=e6E0l3l2m7wx9DfuBdN98IXo/uMT8eNuaVhyKairk07glycS6SudxNgAO1q4AusERU
         QqHy5C1dtQxgTSgXQlqQVF7geYlOnafE+9Rhmvfx7oEeqhL1sbONHn3w53Kpn+5SxlmH
         f20csUOIZN4FmseOzNRXO3LNHMPCp+5MRl4mucPDVJElmG9XKdMIlpA5IwzywZVhrpWY
         xeZTj644UAInFi3V5Co4thuUKWdNdGpNC6Jr+fjZi/hS/BS+p/POoGy+tT8Vo1vAUgLL
         VGGQC+jMLHxWYoJJ4Wt0u+wGV3cRHu+iz0yYBwGS/Tx9kEot903tHMWxK1a7xqP7lNzi
         TQZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=asP5WW1PtGLGLgC0vcc0NACNPp01Esm7Z0OiLq0F9GE=;
        b=oyn4i1lVm4+DMyoGIVJwdkerlMOW9oEBLMuCeU5lvlXJR4m+YtdktIkaN2ssDJV/6w
         hyueySfSrFv/XrR7KxRj4jMWZNJgxfjzhY39keNOTNs+jNY2RpAw7yMEjXLF3M4VX428
         8OhBOH30rUR6zpbvP3ekM64iIV3iKO80gWDIJyVOGGLAgQgWfnpRmvHuq7frjBsmR4ou
         IwoATiBF16sY1un1ykqT5Bx5Y/rzbRhDSN2glYNjS1aAu7GJcl0QeObmXWPQ8cpfxxcH
         LyyK0RVtmzF+0aiJKllcJef0feIlgbGO/aI9RzuNAOGd4JKozkLhX8lqRFxOmbqW/4BJ
         mlHw==
X-Gm-Message-State: AJIora+jY1j1YkbKOepnTQqxG5luxBEPcj0OADvRSXHc5HpKwtKNgxTS
        R/KxFN2W+fybIqv2Aon3nfQVKVy8XSc6tCjr
X-Google-Smtp-Source: AGRyM1sRmSJOnVT2Z9R7fyhZzK3ZT/63r3+D4BCtYWOheW/rx5RrOQ2VTSy0I31C9Jr/wNmHWAW39g==
X-Received: by 2002:a05:6102:ed3:b0:356:11c2:5ea3 with SMTP id m19-20020a0561020ed300b0035611c25ea3mr22570290vst.15.1657132058001;
        Wed, 06 Jul 2022 11:27:38 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:37 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 6/8] rkvdec: Use vb2_find_buffer
Date:   Wed,  6 Jul 2022 15:26:55 -0300
Message-Id: <20220706182657.210650-7-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
References: <20220706182657.210650-1-ezequiel@vanguardiasur.com.ar>
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

Use the newly introduced vb2_find_buffer API to get a vb2_buffer
given a buffer timestamp.

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 drivers/staging/media/rkvdec/rkvdec-h264.c | 41 ++++++++--------------
 drivers/staging/media/rkvdec/rkvdec-vp9.c  | 10 +++---
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/staging/media/rkvdec/rkvdec-h264.c
index 2992fb87cf72..4af5a831bde0 100644
--- a/drivers/staging/media/rkvdec/rkvdec-h264.c
+++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
@@ -109,7 +109,7 @@ struct rkvdec_h264_run {
 	const struct v4l2_ctrl_h264_sps *sps;
 	const struct v4l2_ctrl_h264_pps *pps;
 	const struct v4l2_ctrl_h264_scaling_matrix *scaling_matrix;
-	int ref_buf_idx[V4L2_H264_NUM_DPB_ENTRIES];
+	struct vb2_buffer *ref_buf[V4L2_H264_NUM_DPB_ENTRIES];
 };
 
 struct rkvdec_h264_ctx {
@@ -742,17 +742,16 @@ static void lookup_ref_buf_idx(struct rkvdec_ctx *ctx,
 		struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 		const struct v4l2_h264_dpb_entry *dpb = run->decode_params->dpb;
 		struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
-		int buf_idx = -1;
+		struct vb2_buffer *buf = NULL;
 
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE) {
-			buf_idx = vb2_find_timestamp(cap_q,
-						     dpb[i].reference_ts, 0);
-			if (buf_idx < 0)
+			buf = vb2_find_buffer(cap_q, dpb[i].reference_ts);
+			if (!buf)
 				pr_debug("No buffer for reference_ts %llu",
 					 dpb[i].reference_ts);
 		}
 
-		run->ref_buf_idx[i] = buf_idx;
+		run->ref_buf[i] = buf;
 	}
 }
 
@@ -805,7 +804,7 @@ static void assemble_hw_rps(struct rkvdec_ctx *ctx,
 			if (WARN_ON(ref->index >= ARRAY_SIZE(dec_params->dpb)))
 				continue;
 
-			dpb_valid = run->ref_buf_idx[ref->index] >= 0;
+			dpb_valid = run->ref_buf[ref->index] != NULL;
 			bottom = ref->fields == V4L2_H264_BOTTOM_FIELD_REF;
 
 			set_ps_field(hw_rps, DPB_INFO(i, j),
@@ -881,24 +880,6 @@ static const u32 poc_reg_tbl_bottom_field[16] = {
 	RKVDEC_REG_H264_POC_REFER2(1)
 };
 
-static struct vb2_buffer *
-get_ref_buf(struct rkvdec_ctx *ctx, struct rkvdec_h264_run *run,
-	    unsigned int dpb_idx)
-{
-	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
-	struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
-	int buf_idx = run->ref_buf_idx[dpb_idx];
-
-	/*
-	 * If a DPB entry is unused or invalid, address of current destination
-	 * buffer is returned.
-	 */
-	if (buf_idx < 0)
-		return &run->base.bufs.dst->vb2_buf;
-
-	return vb2_get_buffer(cap_q, buf_idx);
-}
-
 static void config_registers(struct rkvdec_ctx *ctx,
 			     struct rkvdec_h264_run *run)
 {
@@ -971,8 +952,14 @@ static void config_registers(struct rkvdec_ctx *ctx,
 
 	/* config ref pic address & poc */
 	for (i = 0; i < ARRAY_SIZE(dec_params->dpb); i++) {
-		struct vb2_buffer *vb_buf = get_ref_buf(ctx, run, i);
-
+		struct vb2_buffer *vb_buf = run->ref_buf[i];
+
+		/*
+		 * If a DPB entry is unused or invalid, address of current destination
+		 * buffer is returned.
+		 */
+		if (!vb_buf)
+			vb_buf = &dst_buf->vb2_buf;
 		refer_addr = vb2_dma_contig_plane_dma_addr(vb_buf, 0);
 
 		if (dpb[i].flags & V4L2_H264_DPB_ENTRY_FLAG_ACTIVE)
diff --git a/drivers/staging/media/rkvdec/rkvdec-vp9.c b/drivers/staging/media/rkvdec/rkvdec-vp9.c
index c2f42e76be10..d8c1c0db15c7 100644
--- a/drivers/staging/media/rkvdec/rkvdec-vp9.c
+++ b/drivers/staging/media/rkvdec/rkvdec-vp9.c
@@ -383,17 +383,17 @@ get_ref_buf(struct rkvdec_ctx *ctx, struct vb2_v4l2_buffer *dst, u64 timestamp)
 {
 	struct v4l2_m2m_ctx *m2m_ctx = ctx->fh.m2m_ctx;
 	struct vb2_queue *cap_q = &m2m_ctx->cap_q_ctx.q;
-	int buf_idx;
+	struct vb2_buffer *buf;
 
 	/*
 	 * If a ref is unused or invalid, address of current destination
 	 * buffer is returned.
 	 */
-	buf_idx = vb2_find_timestamp(cap_q, timestamp, 0);
-	if (buf_idx < 0)
-		return vb2_to_rkvdec_decoded_buf(&dst->vb2_buf);
+	buf = vb2_find_buffer(cap_q, timestamp);
+	if (!buf)
+		buf = &dst->vb2_buf;
 
-	return vb2_to_rkvdec_decoded_buf(vb2_get_buffer(cap_q, buf_idx));
+	return vb2_to_rkvdec_decoded_buf(buf);
 }
 
 static dma_addr_t get_mv_base_addr(struct rkvdec_decoded_buffer *buf)
-- 
2.34.3

