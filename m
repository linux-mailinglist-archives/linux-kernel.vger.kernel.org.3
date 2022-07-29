Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A92584C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 08:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbiG2G5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 02:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiG2G5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 02:57:01 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7858543E59;
        Thu, 28 Jul 2022 23:56:59 -0700 (PDT)
X-UUID: e705fe584324436294893162a29294b1-20220729
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:c21bd177-cf5a-408f-8477-83817d7699ca,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:6c88bacf-a6cf-4fb6-be1b-c60094821ca2,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e705fe584324436294893162a29294b1-20220729
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1107082872; Fri, 29 Jul 2022 14:56:51 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Fri, 29 Jul 2022 06:56:15 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 29 Jul 2022 11:51:36 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 29 Jul 2022 11:51:35 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        <nicolas.dufresne@collabora.com>
CC:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v5, 4/8] media: mediatek: vcodec: Add more extra processing for multi-core encoding
Date:   Fri, 29 Jul 2022 11:51:25 +0800
Message-ID: <20220729035129.3634-5-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220729035129.3634-1-irui.wang@mediatek.com>
References: <20220729035129.3634-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a bit for indicating support multi-core encoding, because multi-core
encoding need more working buffers for encoder hardware. The working
buffers are allocated from kernel side then pass to scp firmware side
through shared memory, the struct definition must be kept align between
kernel and scp firmware side. New another shared memory struct for
multi-core encoding.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |   2 +
 .../mediatek/vcodec/mtk_vcodec_util.c         |  19 ++
 .../mediatek/vcodec/mtk_vcodec_util.h         |   2 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 207 +++++++++++++++---
 4 files changed, 195 insertions(+), 35 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 644021c5bbd4..250e9833b955 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -27,6 +27,8 @@
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
 #define IS_VDEC_INNER_RACING(capability) ((capability) & MTK_VCODEC_INNER_RACING)
+#define MTK_VENC_MULTICORE_ENABLE BIT(1)
+#define IS_VENC_MULTICORE(capability) ((capability) & MTK_VENC_MULTICORE_ENABLE)
 
 /*
  * enum mtk_hw_reg_idx - MTK hw register base index
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
index ace78c4b5b9e..a4c2cbf4040e 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
@@ -11,6 +11,7 @@
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_hw.h"
 #include "mtk_vcodec_util.h"
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
@@ -26,6 +27,24 @@ void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *ctx,
+					 int hw_id)
+{
+	struct mtk_venc_hw_dev *sub_core;
+
+	if (hw_id >= MTK_VENC_HW_MAX) {
+		mtk_v4l2_err("Invalid hw_id = %d", hw_id);
+		return NULL;
+	}
+
+	sub_core = (struct mtk_venc_hw_dev *)ctx->dev->enc_hw_dev[hw_id];
+	if (!sub_core)
+		return NULL;
+
+	return sub_core->reg_base;
+}
+EXPORT_SYMBOL(mtk_venc_get_core_reg_addr);
+
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 			struct mtk_vcodec_mem *mem)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index 71956627a0e2..0033c53d5589 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -50,6 +50,8 @@ struct mtk_vcodec_dev;
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 				unsigned int reg_idx);
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *data,
+					 int hw_id);
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 				struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 4d9b8798dffe..3a565929f2b0 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -50,6 +50,24 @@ enum venc_h264_vpu_work_buf {
 	VENC_H264_VPU_WORK_BUF_MAX,
 };
 
+/*
+ * enum venc_multi_core_work_buf - h264 multi core encoder buffer index
+ */
+enum venc_multi_core_work_buf {
+	VENC_MULTI_CORE_WORK_BUF_RC_INFO_CORE0,
+	VENC_MULTI_CORE_WORK_BUF_RC_CODE,
+	VENC_MULTI_CORE_WORK_BUF_REC_LUMA,
+	VENC_MULTI_CORE_WORK_BUF_REC_CHROMA,
+	VENC_MULTI_CORE_WORK_BUF_REF_LUMA,
+	VENC_MULTI_CORE_WORK_BUF_REF_CHROMA,
+	VENC_MULTI_CORE_WORK_BUF_MV_INFO_1,
+	VENC_MULTI_CORE_WORK_BUF_MV_INFO_2,
+	VENC_MULTI_CORE_WORK_BUF_SKIP_FRAME,
+	VENC_MULTI_CORE_WORK_BUF_RC_INFO_CORE1,
+	VENC_MULTI_CORE_WORK_BUF_FR_RC_INFO,
+	VENC_MULTI_CORE_WORK_BUF_MAX,
+};
+
 /*
  * enum venc_h264_bs_mode - for bs_mode argument in h264_enc_vpu_encode
  */
@@ -94,6 +112,47 @@ struct venc_h264_vpu_config {
 	u32 wfd;
 };
 
+/*
+ * struct venc_h264_vpu_config_ext - Structure for h264 encoder configuration
+ *                               AP-W/R : AP is writer/reader on this item
+ *                               VPU-W/R: VPU is write/reader on this item
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
 /*
  * struct venc_h264_vpu_buf - Structure for buffer information
  *                            AP-W/R : AP is writer/reader on this item
@@ -127,6 +186,17 @@ struct venc_h264_vsi {
 	struct venc_h264_vpu_buf work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
 };
 
+/*
+ * struct venc_multi_core_vsi - Structure for VPU driver control and info share
+ *				Used for multi-core encode sharing
+ * @config: h264 encoder configuration
+ * @work_bufs: working buffer information in VPU side
+ */
+struct venc_multi_core_vsi {
+	struct venc_h264_vpu_config_ext config;
+	struct venc_h264_vpu_buf work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
+};
+
 /*
  * struct venc_h264_inst - h264 encoder AP driver instance
  * @hw_base: h264 encoder hardware register base
@@ -140,11 +210,12 @@ struct venc_h264_vsi {
  * @vpu_inst: VPU instance to exchange information between AP and VPU
  * @vsi: driver structure allocated by VPU side and shared to AP side for
  *	 control and info share
+ * @core_vsi: used for multi-core encode info sharing.
  * @ctx: context for v4l2 layer integration
  */
 struct venc_h264_inst {
-	void __iomem *hw_base;
-	struct mtk_vcodec_mem work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
+	void __iomem *hw_base[MTK_VENC_HW_MAX];
+	struct mtk_vcodec_mem work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
 	struct mtk_vcodec_mem pps_buf;
 	bool work_buf_allocated;
 	unsigned int frm_cnt;
@@ -152,12 +223,13 @@ struct venc_h264_inst {
 	unsigned int prepend_hdr;
 	struct venc_vpu_inst vpu_inst;
 	struct venc_h264_vsi *vsi;
+	struct venc_multi_core_vsi *core_vsi;
 	struct mtk_vcodec_ctx *ctx;
 };
 
 static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
 {
-	return readl(inst->hw_base + addr);
+	return readl(inst->hw_base[MTK_VENC_CORE_0] + addr);
 }
 
 static unsigned int h264_get_profile(struct venc_h264_inst *inst,
@@ -227,14 +299,20 @@ static unsigned int h264_get_level(struct venc_h264_inst *inst,
 
 static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 {
-	int i;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	int i, max_work_buf;
 
 	mtk_vcodec_debug_enter(inst);
 
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
+		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
+	else
+		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
+
 	/* Except the SKIP_FRAME buffers,
 	 * other buffers need to be freed by AP.
 	 */
-	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
+	for (i = 0; i < max_work_buf; i++) {
 		if (i != VENC_H264_VPU_WORK_BUF_SKIP_FRAME)
 			mtk_vcodec_mem_free(inst->ctx, &inst->work_bufs[i]);
 	}
@@ -246,13 +324,22 @@ static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 
 static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
 {
-	int i;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct venc_h264_vpu_buf *wb;
+	int i, max_work_buf;
 	int ret = 0;
-	struct venc_h264_vpu_buf *wb = inst->vsi->work_bufs;
 
 	mtk_vcodec_debug_enter(inst);
 
-	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		wb = inst->core_vsi->work_bufs;
+		max_work_buf = VENC_MULTI_CORE_WORK_BUF_MAX;
+	} else {
+		wb = inst->vsi->work_bufs;
+		max_work_buf = VENC_H264_VPU_WORK_BUF_MAX;
+	}
+
+	for (i = 0; i < max_work_buf; i++) {
 		/*
 		 * This 'wb' structure is set by VPU side and shared to AP for
 		 * buffer allocation and IO virtual addr mapping. For most of
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
@@ -437,15 +524,25 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 			     struct mtk_vcodec_mem *bs_buf,
 			     unsigned int *bs_size)
 {
-	int ret = 0;
-	unsigned int irq_status;
 	struct venc_frame_info frame_info;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	unsigned int irq_status, gop_size, intra_period;
+	int ret = 0;
 
 	mtk_vcodec_debug_enter(inst);
 	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		gop_size = inst->core_vsi->config.gop_size;
+		intra_period = inst->core_vsi->config.intra_period;
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
@@ -501,8 +598,8 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
 static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
-	int ret = 0;
 	struct venc_h264_inst *inst;
+	int ret, i;
 
 	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
 	if (!inst)
@@ -511,13 +608,23 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
 
-	inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+	inst->hw_base[0] = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
+
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		inst->core_vsi =
+			(struct venc_multi_core_vsi *)inst->vpu_inst.vsi;
+
+		for (i = 1; i < MTK_VENC_HW_MAX; i++)
+			inst->hw_base[i] =
+				mtk_venc_get_core_reg_addr(inst->ctx, i);
+	} else {
+		inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+	}
 
 	mtk_vcodec_debug_leave(inst);
 
@@ -624,31 +731,61 @@ static int h264_enc_encode(void *handle,
 	return ret;
 }
 
+static void h264_enc_set_configs(struct venc_h264_inst *inst,
+				 struct venc_enc_param *enc_prm)
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
+static void h264_enc_set_core_configs(struct venc_h264_inst *inst,
+				      struct venc_enc_param *enc_prm)
+{
+	inst->core_vsi->config.input_fourcc = enc_prm->input_yuv_fmt;
+	inst->core_vsi->config.bitrate = enc_prm->bitrate;
+	inst->core_vsi->config.pic_w = enc_prm->width;
+	inst->core_vsi->config.pic_h = enc_prm->height;
+	inst->core_vsi->config.buf_w = enc_prm->buf_width;
+	inst->core_vsi->config.buf_h = enc_prm->buf_height;
+	inst->core_vsi->config.gop_size = enc_prm->gop_size;
+	inst->core_vsi->config.framerate = enc_prm->frm_rate;
+	inst->core_vsi->config.intra_period = enc_prm->intra_period;
+	inst->core_vsi->config.profile =
+		h264_get_profile(inst, enc_prm->h264_profile);
+	inst->core_vsi->config.level =
+		h264_get_level(inst, enc_prm->h264_level);
+	inst->core_vsi->config.wfd = 0;
+}
+
 static int h264_enc_set_param(void *handle,
 			      enum venc_set_param_type type,
 			      struct venc_enc_param *enc_prm)
 {
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
 
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
+		if (IS_VENC_MULTICORE(ctx->dev->enc_capability))
+			h264_enc_set_core_configs(inst, enc_prm);
+		else
+			h264_enc_set_configs(inst, enc_prm);
+
 		ret = vpu_enc_set_param(&inst->vpu_inst, type, enc_prm);
 		if (ret)
 			break;
-- 
2.18.0

