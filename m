Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E620E4DC0F3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiCQIZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCQIY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:58 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E416E16C08C;
        Thu, 17 Mar 2022 01:23:34 -0700 (PDT)
X-UUID: e2bb798dfc5f4ce8a231752df283b01f-20220317
X-UUID: e2bb798dfc5f4ce8a231752df283b01f-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1950854792; Thu, 17 Mar 2022 16:23:26 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 17 Mar 2022 16:23:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Mar
 2022 16:23:21 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:23:20 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        Irui Wang <irui.wang@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v3, 08/10] media: mtk-vcodec: Add more extra processing for venc_multi_core mode
Date:   Thu, 17 Mar 2022 16:22:28 +0800
Message-ID: <20220317082230.23622-9-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317082230.23622-1-irui.wang@mediatek.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

venc_multi_core mode encoding need more venc working buffers, it
will break the compatibility if we just add venc_vsi in AP-Kernel
but not in firmware, so add more struct definition for it.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_util.c     |  19 ++
 .../platform/mtk-vcodec/mtk_vcodec_util.h     |   4 +
 .../platform/mtk-vcodec/venc/venc_h264_if.c   | 174 +++++++++++++++---
 3 files changed, 172 insertions(+), 25 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
index ace78c4b5b9e..059f665afa96 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -11,6 +11,7 @@
 
 #include "mtk_vcodec_dec_hw.h"
 #include "mtk_vcodec_drv.h"
+#include "mtk_vcodec_enc_core.h"
 #include "mtk_vcodec_util.h"
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
@@ -26,6 +27,24 @@ void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 }
 EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
 
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *ctx,
+					 unsigned int core_id)
+{
+	struct mtk_venc_core_dev *core;
+
+	if (core_id >= MTK_VENC_CORE_MAX) {
+		mtk_v4l2_err("Invalid core_id = %d", core_id);
+		return NULL;
+	}
+
+	core = (struct mtk_venc_core_dev *)ctx->dev->enc_core_dev[core_id];
+	if (!core)
+		return NULL;
+
+	return core->reg_base;
+}
+EXPORT_SYMBOL(mtk_venc_get_core_reg_addr);
+
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 			struct mtk_vcodec_mem *mem)
 {
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index 71956627a0e2..de9e18688842 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -50,6 +50,10 @@ struct mtk_vcodec_dev;
 
 void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
 				unsigned int reg_idx);
+
+void __iomem *mtk_venc_get_core_reg_addr(struct mtk_vcodec_ctx *data,
+					 unsigned int core_id);
+
 int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
 				struct mtk_vcodec_mem *mem);
 void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index 4d9b8798dffe..aee31cb836c6 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
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
@@ -94,6 +112,24 @@ struct venc_h264_vpu_config {
 	u32 wfd;
 };
 
+struct venc_multi_core_config {
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
@@ -127,6 +163,11 @@ struct venc_h264_vsi {
 	struct venc_h264_vpu_buf work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
 };
 
+struct venc_multi_core_vsi {
+	struct venc_multi_core_config config;
+	struct venc_h264_vpu_buf work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
+};
+
 /*
  * struct venc_h264_inst - h264 encoder AP driver instance
  * @hw_base: h264 encoder hardware register base
@@ -143,8 +184,8 @@ struct venc_h264_vsi {
  * @ctx: context for v4l2 layer integration
  */
 struct venc_h264_inst {
-	void __iomem *hw_base;
-	struct mtk_vcodec_mem work_bufs[VENC_H264_VPU_WORK_BUF_MAX];
+	void __iomem *hw_base[MTK_VENC_CORE_MAX];
+	struct mtk_vcodec_mem work_bufs[VENC_MULTI_CORE_WORK_BUF_MAX];
 	struct mtk_vcodec_mem pps_buf;
 	bool work_buf_allocated;
 	unsigned int frm_cnt;
@@ -152,12 +193,13 @@ struct venc_h264_inst {
 	unsigned int prepend_hdr;
 	struct venc_vpu_inst vpu_inst;
 	struct venc_h264_vsi *vsi;
+	struct venc_multi_core_vsi *core_vsi;
 	struct mtk_vcodec_ctx *ctx;
 };
 
 static inline u32 h264_read_reg(struct venc_h264_inst *inst, u32 addr)
 {
-	return readl(inst->hw_base + addr);
+	return readl(inst->hw_base[MTK_VENC_CORE0] + addr);
 }
 
 static unsigned int h264_get_profile(struct venc_h264_inst *inst,
@@ -228,13 +270,20 @@ static unsigned int h264_get_level(struct venc_h264_inst *inst,
 static void h264_enc_free_work_buf(struct venc_h264_inst *inst)
 {
 	int i;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	int max_work_buf;
 
 	mtk_vcodec_debug_enter(inst);
 
+	if (ctx->dev->venc_multi_core)
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
@@ -248,11 +297,21 @@ static int h264_enc_alloc_work_buf(struct venc_h264_inst *inst)
 {
 	int i;
 	int ret = 0;
-	struct venc_h264_vpu_buf *wb = inst->vsi->work_bufs;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	struct venc_h264_vpu_buf *wb;
+	int max_work_buf;
 
 	mtk_vcodec_debug_enter(inst);
 
-	for (i = 0; i < VENC_H264_VPU_WORK_BUF_MAX; i++) {
+	if (ctx->dev->venc_multi_core) {
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
@@ -358,6 +417,26 @@ static int h264_frame_type(struct venc_h264_inst *inst)
 		return VENC_H264_P_FRM;  /* Note: B frames are not supported */
 	}
 }
+
+static int h264_core_frame_type(struct venc_h264_inst *inst)
+{
+	struct venc_multi_core_vsi *vsi = inst->core_vsi;
+
+	if ((vsi->config.gop_size != 0 &&
+	     (inst->frm_cnt % vsi->config.gop_size) == 0) ||
+	    (inst->frm_cnt == 0 && vsi->config.gop_size == 0)) {
+		/* IDR frame */
+		return VENC_H264_IDR_FRM;
+	} else if ((vsi->config.intra_period != 0 &&
+		    (inst->frm_cnt % vsi->config.intra_period) == 0) ||
+		   (inst->frm_cnt == 0 && vsi->config.intra_period == 0)) {
+		/* I frame */
+		return VENC_H264_I_FRM;
+	} else {
+		return VENC_H264_P_FRM;  /* Note: B frames are not supported */
+	}
+}
+
 static int h264_encode_sps(struct venc_h264_inst *inst,
 			   struct mtk_vcodec_mem *bs_buf,
 			   unsigned int *bs_size)
@@ -440,12 +519,17 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	int ret = 0;
 	unsigned int irq_status;
 	struct venc_frame_info frame_info;
+	struct mtk_vcodec_ctx *ctx = inst->ctx;
 
 	mtk_vcodec_debug_enter(inst);
 	mtk_vcodec_debug(inst, "frm_cnt = %d\n ", inst->frm_cnt);
 	frame_info.frm_count = inst->frm_cnt;
 	frame_info.skip_frm_count = inst->skip_frm_cnt;
-	frame_info.frm_type = h264_frame_type(inst);
+	if (ctx->dev->venc_multi_core)
+		frame_info.frm_type = h264_core_frame_type(inst);
+	else
+		frame_info.frm_type = h264_frame_type(inst);
+
 	mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
 			 frame_info.frm_count, frame_info.skip_frm_count,
 			 frame_info.frm_type);
@@ -501,7 +585,7 @@ static void h264_encode_filler(struct venc_h264_inst *inst, void *buf,
 static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(ctx);
-	int ret = 0;
+	int ret, i = 0;
 	struct venc_h264_inst *inst;
 
 	inst = kzalloc(sizeof(*inst), GFP_KERNEL);
@@ -511,13 +595,22 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
 	inst->ctx = ctx;
 	inst->vpu_inst.ctx = ctx;
 	inst->vpu_inst.id = is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
-	inst->hw_base = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
 
 	mtk_vcodec_debug_enter(inst);
 
 	ret = vpu_enc_init(&inst->vpu_inst);
 
-	inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+	if (ctx->dev->venc_multi_core) {
+		inst->core_vsi =
+			(struct venc_multi_core_vsi *)inst->vpu_inst.vsi;
+		for (i = 0; i < MTK_VENC_CORE_MAX; i++)
+			inst->hw_base[i] =
+				mtk_venc_get_core_reg_addr(inst->ctx, i);
+
+	} else {
+		inst->vsi = (struct venc_h264_vsi *)inst->vpu_inst.vsi;
+		inst->hw_base[0] = mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
+	}
 
 	mtk_vcodec_debug_leave(inst);
 
@@ -624,31 +717,62 @@ static int h264_enc_encode(void *handle,
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
 
-	mtk_vcodec_debug(inst, "->type=%d", type);
+	mtk_vcodec_debug(inst, "->type=%d, multi_core=%d",
+			 type, ctx->dev->venc_multi_core);
 
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
+		if (ctx->dev->venc_multi_core)
+			h264_enc_set_core_configs(inst, enc_prm);
+		else
+			h264_enc_set_configs(inst, enc_prm);
+
 		ret = vpu_enc_set_param(&inst->vpu_inst, type, enc_prm);
 		if (ret)
 			break;
-- 
2.18.0

