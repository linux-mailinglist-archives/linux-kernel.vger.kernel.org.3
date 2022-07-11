Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD12570C78
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiGKVME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiGKVLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:11:55 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7256E32DA5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:54 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-10c0d96953fso8252823fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 14:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rKGgcE4D53nz5yukyjdYatlUUVmoyTwfHEisyp8wQM8=;
        b=bmedWoIZpXFzm5DN3AUodSCGdcB/l7svD47pCNTTiaopxVTSpEn1l5EEDTOZudmU0X
         zQcsYY08SMCuH8JxNpuV4ud23nwCTPg+i4yi2AYAvjbIYPxsvBZXC4m8ogAr5E7tWoT8
         AUWgAuFxH7Qd55xCp+v+gp3Qd3xoXNTFcN90DJs1fobIt3qRSu/c5bJHGWR7J4VcNVMW
         FIz0KL2GWmClQCe7zV3q0I/Ocs99qxtSg/n8v60VnmOmYK0iSnnC8fbqS2qfyuyFQau4
         6Ok+yBBFHTOF9ZDEwL1dJPnSeJcIx0WCDCU0Fty/TC/3vvix7g7RjpTKWvdihpX9ZoN0
         RFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKGgcE4D53nz5yukyjdYatlUUVmoyTwfHEisyp8wQM8=;
        b=fAlGhcoE2glX/2m9/V36rLvm9yBrEytYf6zXFm+y1XWplkp7cCPnepn46jafLz5IJ6
         QlfOo37Tp8Sivx0jHbO/UNroSPNLlc4992Jes4de4Ohl8VxyJCNGBcaVfx7U01uYvjIH
         g6sN86g+rjchwJOdhCYypWNIbQSC8t5Vdk+Pl/CLRt69YXsx7w/QDCmG889H5KAsN586
         HMd3sXPrWpvNk20lG5ybwEf0x9Kz2hqR1nEEsetvDT/lF1gPgFMN8JLnyxZH05bXavlG
         O/7cHsPYYXJI4RztjNzIOWV86e2Qvni5TWndEPl+7PoFkPbjfBkX1LFJN9naLoxdSH5z
         RNdQ==
X-Gm-Message-State: AJIora/hAPPYE2W7frnHT+UFe1LFR5IXLPoGETRnqPV5w8mpKcuulToH
        4GBitRhVwmlWjbMqVootddPItg==
X-Google-Smtp-Source: AGRyM1vQoTHx4g9p2QF2jwTbasjG4At+dY5PWBP9r4Esr44vJuaofMz7Dp/pOq+UBM1aPk1oRLpr5A==
X-Received: by 2002:a05:6870:b38f:b0:10c:f54:c7fa with SMTP id w15-20020a056870b38f00b0010c0f54c7famr162620oap.153.1657573913773;
        Mon, 11 Jul 2022 14:11:53 -0700 (PDT)
Received: from zeta-build.. ([190.190.187.68])
        by smtp.gmail.com with ESMTPSA id c128-20020aca3586000000b00338869042fdsm3198817oia.32.2022.07.11.14.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:11:53 -0700 (PDT)
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomasz Figa <tfiga@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Subject: [PATCH v2 2/8] mediatek: vcodec: Use vb2_find_buffer
Date:   Mon, 11 Jul 2022 18:11:35 -0300
Message-Id: <20220711211141.349902-3-ezequiel@vanguardiasur.com.ar>
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

Cc: Tiffany Lin <tiffany.lin@mediatek.com>
Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>
Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Acked-by: Tomasz Figa <tfiga@chromium.org>
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

