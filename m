Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6075691BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiGFS1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbiGFS11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:27:27 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0F9626F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 11:27:26 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id i186so15929951vsc.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 11:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Rmltu/GTnpTlLdYo/MNEstdQCKTczD8RA5cX6ipHd8=;
        b=JH9USA94gvmK6YDhHjP/yBAH+tHWm8x3rui4VYK208tU2ra7hucZaPpti6OZMAIMWS
         dLoCpU+k2a7mrNHQR281RLlfWO2g8e7ZL7YmuRjkVxoBZGZZPBwICVLLCs7di7kscvlq
         4+1N88SuSGO6COwuH1M4NLG13jIz+7rIAK2NiK7zxd3ukwDdNlJ1JS5SNhX5RBAXFi2i
         91P478sl5u6vmppzeI7R9EknYfBcNiahmHI9bmBpiTyQIrAGHAbdrtXVr7wJr5rfFH/V
         ZYFSU5+4CUjoE2QQPICx1DY664aZrTlxlk3AEal4tNoDv8sTLDxwDI9H7qJtjtJgUytl
         UV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Rmltu/GTnpTlLdYo/MNEstdQCKTczD8RA5cX6ipHd8=;
        b=PY3e6uySk6B5ejwcwpCFzSDiM8dxmvK7lYklbEMWxSrgOGE3E8lXTZ2N3skjt+FN87
         qS9V9QV5msjWVH06vmhbYkvZh0Aqi6N5X65JI9UfSnMA5ckqLUHYJWCQyNVTxlwKoOlX
         oMaKVFnVv2mwfb771bMJWQhVBFP/LCNgqsM8DbH7egGMmjptAqhZBl5CrTyz0LAqlwdA
         z+YvLcqFq5pUNHMWmJWQUsgd55TaEH4W7i1Kk+iCpjlcveKoMA5ghBNWf5Xh+AFNGsdB
         b9TAzbSe09M6XdgdrzZlwHtImjKjLJadl+AQ2Uj59hZWztblEZuLqGQKD9nzCFnaz107
         4T1Q==
X-Gm-Message-State: AJIora8GE/TK+0BbaSwphhTuETMZVq1ORKk899/HJLwlakjq/35JLCy4
        qjjS7pu2Ma3222VIKOfcYqMd0Q==
X-Google-Smtp-Source: AGRyM1vpu99IP7GL+Z3x58hcvIBYzKcSt0dLA4x5vkKQiAc1xWYkDpFs173Fs9G3yPfTdKIeL4x1Xw==
X-Received: by 2002:a67:b74c:0:b0:357:6c9:113 with SMTP id l12-20020a67b74c000000b0035706c90113mr4431618vsh.51.1657132045973;
        Wed, 06 Jul 2022 11:27:25 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id bl9-20020a056102508900b003563680212asm7445539vsb.27.2022.07.06.11.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:27:25 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH 2/8] mediatek: vcodec: Use vb2_find_buffer
Date:   Wed,  6 Jul 2022 15:26:51 -0300
Message-Id: <20220706182657.210650-3-ezequiel@vanguardiasur.com.ar>
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

Cc: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
---
 .../platform/mediatek/vcodec/vdec/vdec_h264_req_common.c  | 7 +++----
 .../media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c | 7 +++----
 .../platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c   | 8 ++++----
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
index ca628321d272..580ce979e2a3 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_common.c
@@ -51,7 +51,7 @@ void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
 	struct vb2_queue *vq;
 	struct vb2_buffer *vb;
 	struct vb2_v4l2_buffer *vb2_v4l2;
-	int index, vb2_index;
+	int index;
 
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 
@@ -62,8 +62,8 @@ void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
 			continue;
 		}
 
-		vb2_index = vb2_find_timestamp(vq, dpb->reference_ts, 0);
-		if (vb2_index < 0) {
+		vb = vb2_find_buffer(vq, dpb->reference_ts);
+		if (!vb) {
 			dev_err(&ctx->dev->plat_dev->dev,
 				"Reference invalid: dpb_index(%d) reference_ts(%lld)",
 				index, dpb->reference_ts);
@@ -76,7 +76,6 @@ void mtk_vdec_h264_fill_dpb_info(struct mtk_vcodec_ctx *ctx,
 		else
 			h264_dpb_info[index].reference_flag = 2;
 
-		vb = vq->bufs[vb2_index];
 		vb2_v4l2 = container_of(vb, struct vb2_v4l2_buffer, vb2_buf);
 		h264_dpb_info[index].field = vb2_v4l2->field;
 
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
index eef102f3f4f3..e1fe2603e92e 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_req_if.c
@@ -237,7 +237,7 @@ static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst
 	struct vb2_queue *vq;
 	struct vb2_buffer *vb;
 	u64 referenct_ts;
-	int index, vb2_index;
+	int index;
 
 	frame_header = vdec_vp8_slice_get_ctrl_ptr(inst->ctx, V4L2_CID_STATELESS_VP8_FRAME);
 	if (IS_ERR(frame_header))
@@ -246,8 +246,8 @@ static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst
 	vq = v4l2_m2m_get_vq(ctx->m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE);
 	for (index = 0; index < 3; index++) {
 		referenct_ts = vdec_vp8_slice_get_ref_by_ts(frame_header, index);
-		vb2_index = vb2_find_timestamp(vq, referenct_ts, 0);
-		if (vb2_index < 0) {
+		vb = vb2_find_buffer(vq, referenct_ts);
+		if (!vb) {
 			if (!V4L2_VP8_FRAME_IS_KEY_FRAME(frame_header))
 				mtk_vcodec_err(inst, "reference invalid: index(%d) ts(%lld)",
 					       index, referenct_ts);
@@ -256,7 +256,6 @@ static int vdec_vp8_slice_get_decode_parameters(struct vdec_vp8_slice_inst *inst
 		}
 		inst->vsi->vp8_dpb_info[index].reference_flag = 1;
 
-		vb = vq->bufs[vb2_index];
 		inst->vsi->vp8_dpb_info[index].y_dma_addr =
 			vb2_dma_contig_plane_dma_addr(vb, 0);
 		if (ctx->q_data[MTK_Q_DATA_DST].fmt->num_planes == 2)
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
index 81de876d5126..fb1c36a3592d 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_req_lat_if.c
@@ -1672,7 +1672,6 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
 	struct vdec_vp9_slice_reference *ref;
 	int plane;
 	int size;
-	int idx;
 	int w;
 	int h;
 	int i;
@@ -1715,15 +1714,16 @@ static int vdec_vp9_slice_setup_core_buffer(struct vdec_vp9_slice_instance *inst
 	 */
 	for (i = 0; i < 3; i++) {
 		ref = &vsi->frame.ref[i];
-		idx = vb2_find_timestamp(vq, pfc->ref_idx[i], 0);
-		if (idx < 0) {
+		vb = vb2_find_buffer(vq, pfc->ref_idx[i]);
+		if (!vb) {
 			ref->frame_width = w;
 			ref->frame_height = h;
 			memset(&vsi->ref[i], 0, sizeof(vsi->ref[i]));
 		} else {
+			int idx = vb->index;
+
 			ref->frame_width = instance->dpb[idx].width;
 			ref->frame_height = instance->dpb[idx].height;
-			vb = vq->bufs[idx];
 			vsi->ref[i].y.dma_addr =
 				vb2_dma_contig_plane_dma_addr(vb, 0);
 			if (plane == 1)
-- 
2.34.3

