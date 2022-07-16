Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF93A576D1C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbiGPJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiGPJiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:38:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262C286DC;
        Sat, 16 Jul 2022 02:38:19 -0700 (PDT)
X-UUID: 48ea9e3010ea45a5a9b7a1fca6c15188-20220716
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:3fcfd6d5-9384-42b0-bc7d-b1d7b2d29260,OB:0,LO
        B:40,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:3fcfd6d5-9384-42b0-bc7d-b1d7b2d29260,OB:0,LOB:
        40,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:a6947464-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:80d515a82a3f,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 48ea9e3010ea45a5a9b7a1fca6c15188-20220716
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1156806650; Sat, 16 Jul 2022 17:38:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sat, 16 Jul 2022 17:38:12 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:38:11 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Yong Wu <yong.wu@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH 1/5] media: mediatek: vcodec: Add encoder driver support for 34-bit iova
Date:   Sat, 16 Jul 2022 17:38:04 +0800
Message-ID: <20220716093808.29894-2-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716093808.29894-1-irui.wang@mediatek.com>
References: <20220716093808.29894-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Encoder driver got iova from IOMMU is 34-bit, for example:

Here is the sample code:
encoder input frame buffer dma address is:
frm_buf =
    vb2_dma_contig_plane_dma_addr(&vb2_v4l2_buffer->vb2_buf, 0);
the value of frm_buf is 0x1_ff30_0000.

encoder driver got the frm_buf and send the iova to SCP firmware
through SCP IPI message, then write to encoder hardware in SCP.
The iova is stored in IPI message as uint32_t data type, so the
value will be truncated from *0x1_ff30_0000* to *0xff30_0000*,
and then *0xff30_0000* will be written to encoder hardware, but
IOMMU will help to add the high *0x1_* bit back, so IOMMU can
translate the iova to PA correctly, encoder hardware can access
the correct memory for encoding.
Another reason to do this is the encoder hardware can't access
the 34-bit iova, IOMMU will help to add the remaining high bits
of iova. But for mt8188, encoder hardware can access 34-bit iova
directly, and encoder driver need write all 34-bit iova because
IOMMU can't help driver do this if the hardware support access
34-bit iova.
For the reasons above, this patch is added to support transfer
34-bit iova between kernel and SCP encoder driver. Use uint64_t
data type to store the iova, for compatibility with old chipsets,
add some new struct definitions for 34-bit.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   3 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 200 +++++++++++++++---
 .../platform/mediatek/vcodec/venc_ipi_msg.h   |  24 +++
 .../platform/mediatek/vcodec/venc_vpu_if.c    |  34 ++-
 4 files changed, 227 insertions(+), 34 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index ef4584a46417..ab80e1b1979e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -401,6 +401,7 @@ struct mtk_vcodec_dec_pdata {
  * @output_formats: array of supported output formats
  * @num_output_formats: number of entries in output_formats
  * @core_id: stand for h264 or vp8 encode index
+ * @is_34bit: whether the encoder uses 34bit iova
  */
 struct mtk_vcodec_enc_pdata {
 	bool uses_ext;
@@ -411,9 +412,11 @@ struct mtk_vcodec_enc_pdata {
 	const struct mtk_video_fmt *output_formats;
 	size_t num_output_formats;
 	int core_id;
+	bool is_34bit;
 };
 
 #define MTK_ENC_CTX_IS_EXT(ctx) ((ctx)->dev->venc_pdata->uses_ext)
+#define MTK_ENC_IOVA_IS_34BIT(ctx) ((ctx)->dev->venc_pdata->is_34bit)
 
 /**
  * struct mtk_vcodec_dev - driver data
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 4d9b8798dffe..3a5af6cca040 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -127,6 +127,72 @@ struct venc_h264_vsi {
 	struct venc_h264_vpu_buf work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
 };
 
+/**
+ * struct venc_h264_vpu_config_ext - Structure for h264 encoder configuration
+ *                                   AP-W/R : AP is writer/reader on this item
+ *                                   VPU-W/R: VPU is write/reader on this item
+ * @input_fourcc: input fourcc
+ * @bitrate: target bitrate (in bps)
+ * @pic_w: picture width. Picture size is visible stream resolution, in pixels,
+ *         to be used for display purposes; must be smaller or equal to buffer
+ *         size.
+ * @pic_h: picture height
+ * @buf_w: buffer width. Buffer size is stream resolution in pixels aligned to
+ *         hardware requirements.
+ * @buf_h: buffer height
+ * @gop_size: group of picture size (idr frame)
+ * @intra_period: intra frame period
+ * @framerate: frame rate in fps
+ * @profile: as specified in standard
+ * @level: as specified in standard
+ * @wfd: WFD mode 1:on, 0:off
+ * @max_qp: max quant parameter
+ * @min_qp: min quant parameter
+ * @reserved: reserved configs
+ */
+struct venc_h264_vpu_config_ext {
+	u32 input_fourcc;
+	u32 bitrate;
+	u32 pic_w;
+	u32 pic_h;
+	u32 buf_w;
+	u32 buf_h;
+	u32 gop_size;
+	u32 intra_period;
+	u32 framerate;
+	u32 profile;
+	u32 level;
+	u32 wfd;
+	u32 max_qp;
+	u32 min_qp;
+	u32 reserved[8];
+};
+
+/**
+ * struct venc_h264_vpu_buf_34 - Structure for 34 bit buffer information
+ *                               AP-W/R : AP is writer/reader on this item
+ *                               VPU-W/R: VPU is write/reader on this item
+ * @iova: 34 bit IO virtual address
+ * @vpua: VPU side memory addr which is used by RC_CODE
+ * @size: buffer size (in bytes)
+ */
+struct venc_h264_vpu_buf_34 {
+	u64 iova;
+	u32 vpua;
+	u32 size;
+};
+
+/**
+ * struct venc_h264_vsi_64 - Structure for VPU driver control and info share
+ *                           Used for 64 bit iova sharing
+ * @config: h264 encoder configuration
+ * @work_bufs: working buffer information in VPU side
+ */
+struct venc_h264_vsi_34 {
+	struct venc_h264_vpu_config_ext config;
+	struct venc_h264_vpu_buf_34 work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
+};
+
 /*
  * struct venc_h264_inst - h264 encoder AP driver instance
  * @hw_base: h264 encoder hardware register base
@@ -140,6 +206,8 @@ struct venc_h264_vsi {
  * @vpu_inst: VPU instance to exchange information between AP and VPU
  * @vsi: driver structure allocated by VPU side and shared to AP side for
  *	 control and info share
+ * @vsi_64: driver structure allocated by VPU side and shared to AP side for
+ *	 control and info share, used for 64 bit iova sharing.
  * @ctx: context for v4l2 layer integration
  */
 struct venc_h264_inst {
@@ -152,6 +220,7 @@ struct venc_h264_inst {
 	unsigned int prepend_hdr;
 	struct venc_vpu_inst vpu_inst;
 	struct venc_h264_vsi *vsi;
+	struct venc_h264_vsi_34 *vsi_34;
 	struct mtk_vcodec_ctx *ctx;
 };
 
@@ -244,14 +313,21 @@ static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 	mtk_vcodec_debug_leave(inst);
 }
 
-static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
+static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst, bool is_34bit)
 {
+	struct venc_h264_vpu_buf *wb;
+	struct venc_h264_vpu_buf_34 *wb_34;
 	int i;
+	u32 vpua, wb_size;
 	int ret = 0;
-	struct venc_h264_vpu_buf *wb = inst->vsi->work_bufs;
 
 	mtk_vcodec_debug_enter(inst);
 
+	if (is_34bit)
+		wb_34 = inst->vsi_34->work_bufs;
+	else
+		wb = inst->vsi->work_bufs;
+
 	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
 		/*
 		 * This 'wb' structure is set by VPU side and shared to AP for
@@ -269,13 +345,22 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
 		 * address and do some memcpy access to move to bitstream buffer
 		 * assigned by v4l2 layer.
 		 */
-		inst->work_bufs[i].size = wb[i].size;
+		if (is_34bit) {
+			inst->work_bufs[i].size = wb_34[i].size;
+			vpua = wb_34[i].vpua;
+			wb_size = wb_34[i].size;
+		} else {
+			inst->work_bufs[i].size = wb[i].size;
+			vpua = wb[i].vpua;
+			wb_size = wb[i].size;
+		}
+
 		if (i == VENC_H264_VPU_WORK_BUF_SKIP_FRAME) {
 			struct mtk_vcodec_fw *handler;
 
 			handler = inst->vpu_inst.ctx->dev->fw_handler;
 			inst->work_bufs[i].va =
-				mtk_vcodec_fw_map_dm_addr(handler, wb[i].vpua);
+				mtk_vcodec_fw_map_dm_addr(handler, vpua);
 			inst->work_bufs[i].dma_addr = 0;
 		} else {
 			ret = mtk_vcodec_mem_alloc(inst->ctx,
@@ -297,12 +382,14 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
 
 				handler = inst->vpu_inst.ctx->dev->fw_handler;
 				tmp_va = mtk_vcodec_fw_map_dm_addr(handler,
-								   wb[i].vpua);
-				memcpy(inst->work_bufs[i].va, tmp_va,
-				       wb[i].size);
+								   vpua);
+				memcpy(inst->work_bufs[i].va, tmp_va, wb_size);
 			}
 		}
-		wb[i].iova = inst->work_bufs[i].dma_addr;
+		if (is_34bit)
+			wb_34[i].iova = inst->work_bufs[i].dma_addr;
+		else
+			wb[i].iova = inst->work_bufs[i].dma_addr;
 
 		mtk_vcodec_debug(inst,
 				 "work_buf[%d] va=0x%p iova=%pad size=%zu",
@@ -342,22 +429,22 @@ static unsigned int h264_enc_wait_venc_done(struct venc_h264_inst *inst)
 	return irq_status;
 }
 
-static int h264_frame_type(struct venc_h264_inst *inst)
+static int h264_frame_type(unsigned int frm_cnt, unsigned int gop_size,
+			   unsigned int intra_period)
 {
-	if ((inst->vsi->config.gop_size != 0 &&
-	     (inst->frm_cnt % inst->vsi->config.gop_size) == 0) ||
-	    (inst->frm_cnt == 0 && inst->vsi->config.gop_size == 0)) {
+	if ((gop_size != 0 && (frm_cnt % gop_size) == 0) ||
+	    (frm_cnt == 0 && gop_size == 0)) {
 		/* IDR frame */
 		return VENC_H264_IDR_FRM;
-	} else if ((inst->vsi->config.intra_period != 0 &&
-		    (inst->frm_cnt % inst->vsi->config.intra_period) == 0) ||
-		   (inst->frm_cnt == 0 && inst->vsi->config.intra_period == 0)) {
+	} else if ((intra_period != 0 && (frm_cnt % intra_period) == 0) ||
+		   (frm_cnt == 0 && intra_period == 0)) {
 		/* I frame */
 		return VENC_H264_I_FRM;
 	} else {
 		return VENC_H264_P_FRM;  /* Note: B frames are not supported */
 	}
 }
+
 static int h264_encode_sps(struct venc_h264_inst *inst,
 			   struct mtk_vcodec_mem *bs_buf,
 			   unsigned int *bs_size)
@@ -438,18 +525,32 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 			     unsigned int *bs_size)
 {
 	int ret = 0;
+	unsigned int gop_size;
+	unsigned int intra_period;
 	unsigned int irq_status;
 	struct venc_frame_info frame_info;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_debug_enter(inst);
 	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
+
+	if (MTK_ENC_IOVA_IS_34BIT(ctx)) {
+		gop_size = inst->vsi_34->config.gop_size;
+		intra_period = inst->vsi_34->config.intra_period;
+	} else {
+		gop_size = inst->vsi->config.gop_size;
+		intra_period = inst->vsi->config.intra_period;
+	}
 	frame_info.frm_count = inst->frm_cnt;
 	frame_info.skip_frm_count = inst->skip_frm_cnt;
-	frame_info.frm_type = h264_frame_type(inst);
+	frame_info.frm_type = h264_frame_type(inst->frm_cnt, gop_size,
+					      intra_period);
 	mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
 			 frame_info.frm_count, frame_info.skip_frm_count,
 			 frame_info.frm_type);
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME, frm_buf, bs_buf, &frame_info);
+
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME,
+			     frm_buf, bs_buf, &frame_info);
 	if (ret)
 		return ret;
 
@@ -517,7 +618,10 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 
 	ret = vpu_enc_init(&inst->vpu_inst);
 
-	inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+	if (MTK_ENC_IOVA_IS_34BIT(ctx))
+		inst->vsi_34 = (struct venc_h264_vsi_34 *)inst->vpu_inst.vsi;
+	else
+		inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
 
 	mtk_vcodec_debug_leave(inst);
 
@@ -624,31 +728,61 @@ static int h264_enc_encode(void *handle,
 	return ret;
 }
 
+static void h264_enc_set_vsi_configs(struct venc_h264_inst *inst,
+				     struct venc_enc_param *enc_prm)
+{
+	inst->vsi->config.input_fourcc = enc_prm->input_yuv_fmt;
+	inst->vsi->config.bitrate = enc_prm->bitrate;
+	inst->vsi->config.pic_w = enc_prm->width;
+	inst->vsi->config.pic_h = enc_prm->height;
+	inst->vsi->config.buf_w = enc_prm->buf_width;
+	inst->vsi->config.buf_h = enc_prm->buf_height;
+	inst->vsi->config.gop_size = enc_prm->gop_size;
+	inst->vsi->config.framerate = enc_prm->frm_rate;
+	inst->vsi->config.intra_period = enc_prm->intra_period;
+	inst->vsi->config.profile =
+		h264_get_profile(inst, enc_prm->h264_profile);
+	inst->vsi->config.level =
+		h264_get_level(inst, enc_prm->h264_level);
+	inst->vsi->config.wfd = 0;
+}
+
+static void h264_enc_set_vsi_34_configs(struct venc_h264_inst *inst,
+					struct venc_enc_param *enc_prm)
+{
+	inst->vsi_34->config.input_fourcc = enc_prm->input_yuv_fmt;
+	inst->vsi_34->config.bitrate = enc_prm->bitrate;
+	inst->vsi_34->config.pic_w = enc_prm->width;
+	inst->vsi_34->config.pic_h = enc_prm->height;
+	inst->vsi_34->config.buf_w = enc_prm->buf_width;
+	inst->vsi_34->config.buf_h = enc_prm->buf_height;
+	inst->vsi_34->config.gop_size = enc_prm->gop_size;
+	inst->vsi_34->config.framerate = enc_prm->frm_rate;
+	inst->vsi_34->config.intra_period = enc_prm->intra_period;
+	inst->vsi_34->config.profile =
+		h264_get_profile(inst, enc_prm->h264_profile);
+	inst->vsi_34->config.level =
+		h264_get_level(inst, enc_prm->h264_level);
+	inst->vsi_34->config.wfd = 0;
+}
+
 static int h264_enc_set_param(void *handle,
 			      enum venc_set_param_type type,
 			      struct venc_enc_param *enc_prm)
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	const bool is_34bit = MTK_ENC_IOVA_IS_34BIT(ctx);
 
 	mtk_vcodec_debug(inst, "->type=%d", type);
 
 	switch (type) {
 	case VENC_SET_PARAM_ENC:
-		inst->vsi->config.input_fourcc = enc_prm->input_yuv_fmt;
-		inst->vsi->config.bitrate = enc_prm->bitrate;
-		inst->vsi->config.pic_w = enc_prm->width;
-		inst->vsi->config.pic_h = enc_prm->height;
-		inst->vsi->config.buf_w = enc_prm->buf_width;
-		inst->vsi->config.buf_h = enc_prm->buf_height;
-		inst->vsi->config.gop_size = enc_prm->gop_size;
-		inst->vsi->config.framerate = enc_prm->frm_rate;
-		inst->vsi->config.intra_period = enc_prm->intra_period;
-		inst->vsi->config.profile =
-			h264_get_profile(inst, enc_prm->h264_profile);
-		inst->vsi->config.level =
-			h264_get_level(inst, enc_prm->h264_level);
-		inst->vsi->config.wfd = 0;
+		if (is_34bit)
+			h264_enc_set_vsi_34_configs(inst, enc_prm);
+		else
+			h264_enc_set_vsi_configs(inst, enc_prm);
 		ret = vpu_enc_set_param(&inst->vpu_inst, type, enc_prm);
 		if (ret)
 			break;
@@ -656,7 +790,7 @@ static int h264_enc_set_param(void *handle,
 			h264_enc_free_work_buf(inst);
 			inst->work_buf_allocated = false;
 		}
-		ret = h264_enc_alloc_work_buf(inst);
+		ret = h264_enc_alloc_work_buf(inst, is_34bit);
 		if (ret)
 			break;
 		inst->work_buf_allocated = true;
diff --git a/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h b/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
index 587a2cf15b76..bb16d96a7f57 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_ipi_msg.h
@@ -100,6 +100,30 @@ struct venc_ap_ipi_msg_enc_ext {
 	uint32_t data[32];
 };
 
+/**
+ * struct venc_ap_ipi_msg_enc_ext_34 - AP to SCP extended enc cmd structure
+ * @msg_id:		message id (AP_IPIMSG_XXX_ENC_ENCODE)
+ * @vpu_inst_addr:	VPU encoder instance addr
+ * @bs_mode:		bitstream mode for h264
+ * @reserved:		for struct padding
+ * @input_addr:		input frame buffer 34 bit address
+ * @bs_addr:		output bitstream buffer 34 bit address
+ * @bs_size:		bitstream buffer size
+ * @data_item:		number of items in the data array
+ * @data:		data array to store the set parameters
+ */
+struct venc_ap_ipi_msg_enc_ext_34 {
+	u32 msg_id;
+	u32 vpu_inst_addr;
+	u32 bs_mode;
+	u32 reserved;
+	u64 input_addr[3];
+	u64 bs_addr;
+	u32 bs_size;
+	u32 data_item;
+	u32 data[32];
+};
+
 /**
  * struct venc_ap_ipi_msg_deinit - AP to VPU deinit cmd structure
  * @msg_id:	message id (AP_IPIMSG_XXX_ENC_DEINIT)
diff --git a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
index d3570c4c177d..25c1b13559c9 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc_vpu_if.c
@@ -228,17 +228,28 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		   struct venc_frame_info *frame_info)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(vpu->ctx);
+	const bool is_34bit = MTK_ENC_IOVA_IS_34BIT(vpu->ctx);
+
 	size_t msg_size = is_ext ?
 		sizeof(struct venc_ap_ipi_msg_enc_ext) :
 		sizeof(struct venc_ap_ipi_msg_enc);
+	int status;
 	struct venc_ap_ipi_msg_enc_ext out;
+	struct venc_ap_ipi_msg_enc_ext_34 out_34;
 
 	mtk_vcodec_debug(vpu, "bs_mode %d ->", bs_mode);
 
 	memset(&out, 0, sizeof(out));
+	memset(&out_34, 0, sizeof(out_34));
+
 	out.base.msg_id = AP_IPIMSG_ENC_ENCODE;
 	out.base.vpu_inst_addr = vpu->inst_addr;
 	out.base.bs_mode = bs_mode;
+
+	out_34.msg_id = AP_IPIMSG_ENC_ENCODE;
+	out_34.vpu_inst_addr = vpu->inst_addr;
+	out_34.bs_mode = bs_mode;
+
 	if (frm_buf) {
 		if ((frm_buf->fb_addr[0].dma_addr % 16 == 0) &&
 		    (frm_buf->fb_addr[1].dma_addr % 16 == 0) &&
@@ -246,6 +257,10 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 			out.base.input_addr[0] = frm_buf->fb_addr[0].dma_addr;
 			out.base.input_addr[1] = frm_buf->fb_addr[1].dma_addr;
 			out.base.input_addr[2] = frm_buf->fb_addr[2].dma_addr;
+
+			out_34.input_addr[0] = frm_buf->fb_addr[0].dma_addr;
+			out_34.input_addr[1] = frm_buf->fb_addr[1].dma_addr;
+			out_34.input_addr[2] = frm_buf->fb_addr[2].dma_addr;
 		} else {
 			mtk_vcodec_err(vpu, "dma_addr not align to 16");
 			return -EINVAL;
@@ -254,14 +269,31 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 	if (bs_buf) {
 		out.base.bs_addr = bs_buf->dma_addr;
 		out.base.bs_size = bs_buf->size;
+
+		out_34.bs_addr = bs_buf->dma_addr;
+		out_34.bs_size = bs_buf->size;
 	}
+
 	if (is_ext && frame_info) {
 		out.data_item = 3;
 		out.data[0] = frame_info->frm_count;
 		out.data[1] = frame_info->skip_frm_count;
 		out.data[2] = frame_info->frm_type;
+
+		out_34.data_item = 3;
+		out_34.data[0] = frame_info->frm_count;
+		out_34.data[1] = frame_info->skip_frm_count;
+		out_34.data[2] = frame_info->frm_type;
 	}
-	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
+
+	if (is_34bit) {
+		msg_size = sizeof(struct venc_ap_ipi_msg_enc_ext_34);
+		status = vpu_enc_send_msg(vpu, &out_34, msg_size);
+	} else {
+		status = vpu_enc_send_msg(vpu, &out, msg_size);
+	}
+
+	if (status) {
 		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
 			       bs_mode);
 		return -EINVAL;
-- 
2.18.0

