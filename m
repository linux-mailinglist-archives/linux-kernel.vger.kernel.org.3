Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD9B570C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbiGKVMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbiGKVMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:12:08 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED288050D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:12:03 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w184so1945146oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J842dPfS98pOzE3Un07UlioU9tGxPmHO38YZQY1HP2s=;
        b=P3gQ44mE07AhPN5AIifhi/MCViL7rTm94zbC3lBfyQGQs6w3zj0Pr2iIG12cgtRnzQ
         pzMo0EIonB91at2zx8DuEwwaNnPLLtqlqKqg6r4FTrc8qX301XBQIR9VLdtpsQo/S2Dp
         4pW8wlpGg0X2mWFm1RrNflDtpSktK+cUM/JW4vEgU6WaeV3jUFWzcQdUXTtYwpkpW8TI
         ZLheprW6sDAIALQkMMpgx1dpBM7RnrljPsOW1fOlCIL1P35najBKk915BkYX6WOaz3Uv
         ROQzXE7cNSjfhVD34312rOOGi4AuMaetm/Ltls/14f9DiaS6pQGkKaJsDv3wgRLZ/lAw
         YuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J842dPfS98pOzE3Un07UlioU9tGxPmHO38YZQY1HP2s=;
        b=CptLyc8vF2FhjLXe1nikCjCP6Kmdj2seVS71KEag2dODc2vGrVPWLmrg+ty7r+XEaD
         8FzxyYd1clpr19oN100HdzGadSqf0T+YdNteRuxo/aBQSxAnFXqnmiOsmaMOmzYk+9rk
         naYYoyAZlR+OCU9YRx9OtJOzdunc46Cozww1kyob0JwMDL/yXFcaceA2QksUNgnYRp8A
         loj04QUZqxSeYJeGZ6wUXwppq+ULgEfc3kn7cg+3CwoxKdoufqfLicYpmJu6474srlFk
         rrx3kN40v91S6hssYY8YPr65CIIOkxlVvxGkaU97QlKRM6qYlul7tiD84+lmPyQZcT8L
         ryjA==
X-Gm-Message-State: AJIora9VpqwUmYbID78zUrJarUriuqsvBR11EQSX9y5poo1qZVoLDtNK
        hY5cnjkMGjc/Mn4/wy48EU7p7Q==
X-Google-Smtp-Source: AGRyM1uh69mg9uNn3E3mHaaHtwi54SyyhFS3QYiIqFsrwm48Yb+fTNiTBfZrPCRr3dKSw9wmB+E2MQ==
X-Received: by 2002:a05:6808:138b:b0:339:bbff:8054 with SMTP id c11-20020a056808138b00b00339bbff8054mr190364oiw.266.1657573922811;
        Mon, 11 Jul 2022 14:12:02 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:12:02 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v2 6/8] rkvdec: Use vb2_find_buffer
Date:   Mon, 11 Jul 2022 18:11:39 -0300
Message-Id: <20220711211141.349902-7-ezequiel@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
References: <20220711211141.349902-1-ezequiel@vanguardiasur.com.ar>
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
Acked-by: Tomasz Figa <tfiga@chromium.org>
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

