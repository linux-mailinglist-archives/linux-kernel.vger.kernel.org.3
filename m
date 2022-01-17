Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A39C490849
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239699AbiAQMHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:07:03 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239667AbiAQMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:06:49 -0500
X-UUID: 34f2768e457a4dc79579b52bfe8c1f1a-20220117
X-UUID: 34f2768e457a4dc79579b52bfe8c1f1a-20220117
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 633297809; Mon, 17 Jan 2022 20:06:46 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 17 Jan 2022 20:06:45 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 17 Jan
 2022 20:06:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 20:06:43 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>
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
Subject: [PATCH v2, 09/10] media: mtk-vcodec: Add dual core mode encode process
Date:   Mon, 17 Jan 2022 20:06:14 +0800
Message-ID: <20220117120615.21687-10-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220117120615.21687-1-irui.wang@mediatek.com>
References: <20220117120615.21687-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dual core mode encoding is tries to uses the two venc cores:
frame#0 uses core#0, frame#1 uses core#1, frame#2 uses core#0...,

Lock the device and enable the clock by used core, for sequence
header encoding, it always uses core#0.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 11 ++-
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 23 +++---
 .../platform/mtk-vcodec/mtk_vcodec_enc.h      |  4 +-
 .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  7 +-
 .../platform/mtk-vcodec/venc/venc_h264_if.c   | 16 ++--
 .../platform/mtk-vcodec/venc/venc_vp8_if.c    |  3 +-
 .../media/platform/mtk-vcodec/venc_drv_if.c   | 73 ++++++++++++++-----
 .../media/platform/mtk-vcodec/venc_drv_if.h   |  5 ++
 .../media/platform/mtk-vcodec/venc_vpu_if.c   | 10 ++-
 .../media/platform/mtk-vcodec/venc_vpu_if.h   |  3 +-
 10 files changed, 113 insertions(+), 42 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index dc036279c42f..c3cf5904b4c6 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -308,6 +308,9 @@ struct vdec_pic_info {
  * @max_width: hardware supported max width
  * @max_height: hardware supported max height
  * @msg_queue: msg queue used to store lat buffer information.
+ * @q_mutex: src & dst vb2_queue mutex
+ * @enc_idx: used to record encoded frame count
+ * @core_id: used to reoord used core
  */
 struct mtk_vcodec_ctx {
 	enum mtk_instance_type type;
@@ -356,6 +359,10 @@ struct mtk_vcodec_ctx {
 	unsigned int max_width;
 	unsigned int max_height;
 	struct vdec_msg_queue msg_queue;
+
+	struct mutex q_mutex;
+	int enc_idx;
+	int core_id;
 };
 
 /*
@@ -533,7 +540,9 @@ struct mtk_vcodec_dev {
 
 	/* decoder hardware mutex lock */
 	struct mutex dec_mutex[MTK_VDEC_HW_MAX];
-	struct mutex enc_mutex;
+
+	/* encoder core mutex lock */
+	struct mutex enc_mutex[MTK_VENC_CORE_MAX];
 
 	struct mtk_vcodec_pm pm;
 	unsigned int dec_capability;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index df231e67cdb2..dc70d328fcd3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -1198,14 +1198,17 @@ static void mtk_venc_worker(struct work_struct *work)
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
 		mtk_v4l2_err("venc_if_encode failed=%d", ret);
-	} else {
+	} else if (ctx->dev->venc_pdata->core_mode == VENC_SINGLE_CORE_MODE) {
 		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
-		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_result.bs_size);
+		vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+				      enc_result.bs_size);
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
 		mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
-				 enc_result.bs_size);
+			       enc_result.bs_size);
 	}
 
+	ctx->enc_idx++;
+
 	v4l2_m2m_job_finish(ctx->dev->m2m_dev_enc, ctx->m2m_ctx);
 
 	mtk_v4l2_debug(1, "<=== src_buf[%d] dst_buf[%d] venc_if_encode ret=%d Size=%u===>",
@@ -1259,7 +1262,7 @@ void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx)
 {
 	struct mtk_q_data *q_data;
 
-	ctx->m2m_ctx->q_lock = &ctx->dev->dev_mutex;
+	ctx->m2m_ctx->q_lock = &ctx->q_mutex;
 	ctx->fh.m2m_ctx = ctx->m2m_ctx;
 	ctx->fh.ctrl_handler = &ctx->ctrl_hdl;
 	INIT_WORK(&ctx->encode_work, mtk_venc_worker);
@@ -1391,7 +1394,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	src_vq->ops		= &mtk_venc_vb2_ops;
 	src_vq->mem_ops		= &vb2_dma_contig_memops;
 	src_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-	src_vq->lock		= &ctx->dev->dev_mutex;
+	src_vq->lock		= &ctx->q_mutex;
 	src_vq->dev		= &ctx->dev->plat_dev->dev;
 
 	ret = vb2_queue_init(src_vq);
@@ -1405,26 +1408,26 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	dst_vq->ops		= &mtk_venc_vb2_ops;
 	dst_vq->mem_ops		= &vb2_dma_contig_memops;
 	dst_vq->timestamp_flags = V4L2_BUF_FLAG_TIMESTAMP_COPY;
-	dst_vq->lock		= &ctx->dev->dev_mutex;
+	dst_vq->lock		= &ctx->q_mutex;
 	dst_vq->dev		= &ctx->dev->plat_dev->dev;
 
 	return vb2_queue_init(dst_vq);
 }
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int core_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
-	mutex_unlock(&dev->enc_mutex);
+	mutex_unlock(&dev->enc_mutex[core_id]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_venc_unlock);
 
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx)
+int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int core_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
 
-	mutex_lock(&dev->enc_mutex);
+	mutex_lock(&dev->enc_mutex[core_id]);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mtk_venc_lock);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
index 513ee7993e34..434d91d36158 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
@@ -39,8 +39,8 @@ struct mtk_video_enc_buf {
 extern const struct v4l2_ioctl_ops mtk_venc_ioctl_ops;
 extern const struct v4l2_m2m_ops mtk_venc_m2m_ops;
 
-int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx);
-int mtk_venc_lock(struct mtk_vcodec_ctx *ctx);
+int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int core_id);
+int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int core_id);
 int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 			      struct vb2_queue *dst_vq);
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index cef134bb6e83..cf42a5930b48 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -133,6 +133,7 @@ static int fops_vcodec_open(struct file *file)
 	INIT_LIST_HEAD(&ctx->list);
 	ctx->dev = dev;
 	init_waitqueue_head(&ctx->queue[0]);
+	mutex_init(&ctx->q_mutex);
 
 	ctx->type = MTK_INST_ENCODER;
 	ret = mtk_vcodec_enc_ctrls_setup(ctx);
@@ -240,7 +241,7 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	struct video_device *vfd_enc;
 	phandle rproc_phandle;
 	enum mtk_vcodec_fw_type fw_type;
-	int ret, core_type;
+	int ret, core_type, i;
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
@@ -299,7 +300,9 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		}
 	}
 
-	mutex_init(&dev->enc_mutex);
+	for (i = 0; i < MTK_VENC_CORE_MAX; i++)
+		mutex_init(&dev->enc_mutex[i]);
+
 	mutex_init(&dev->dev_mutex);
 	spin_lock_init(&dev->irqlock);
 
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index 023b6eb8b20c..fdecf1d24b25 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -448,7 +448,8 @@ static int h264_encode_sps(struct venc_h264_inst *inst,
 
 	mtk_vcodec_debug_enter(inst);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS, NULL, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_SPS,
+			     NULL, bs_buf, NULL, MTK_VENC_CORE0);
 	if (ret)
 		return ret;
 
@@ -474,7 +475,8 @@ static int h264_encode_pps(struct venc_h264_inst *inst,
 
 	mtk_vcodec_debug_enter(inst);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS, NULL, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_PPS,
+			     NULL, bs_buf, NULL, MTK_VENC_CORE0);
 	if (ret)
 		return ret;
 
@@ -516,7 +518,8 @@ static int h264_encode_header(struct venc_h264_inst *inst,
 static int h264_encode_frame(struct venc_h264_inst *inst,
 			     struct venc_frm_buf *frm_buf,
 			     struct mtk_vcodec_mem *bs_buf,
-			     unsigned int *bs_size)
+			     unsigned int *bs_size,
+			     int core_id)
 {
 	int ret = 0;
 	unsigned int irq_status;
@@ -536,7 +539,8 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 	mtk_vcodec_debug(inst, "frm_count = %d,skip_frm_count =%d,frm_type=%d.\n",
 			 frame_info.frm_count, frame_info.skip_frm_count,
 			 frame_info.frm_type);
-	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME, frm_buf, bs_buf, &frame_info);
+	ret = vpu_enc_encode(&inst->vpu_inst, H264_BS_MODE_FRAME,
+			     frm_buf, bs_buf, &frame_info, core_id);
 	if (ret)
 		return ret;
 
@@ -664,7 +668,7 @@ static int h264_enc_encode(void *handle,
 
 		if (!inst->prepend_hdr) {
 			ret = h264_encode_frame(inst, frm_buf, bs_buf,
-						&result->bs_size);
+						&result->bs_size, ctx->core_id);
 			if (ret)
 				goto encode_err;
 			result->is_key_frm = inst->vpu_inst.is_key_frm;
@@ -692,7 +696,7 @@ static int h264_enc_encode(void *handle,
 		tmp_bs_buf.size = bs_buf->size - (hdr_sz + filler_sz);
 
 		ret = h264_encode_frame(inst, frm_buf, &tmp_bs_buf,
-					&bs_size_frm);
+					&bs_size_frm, ctx->core_id);
 		if (ret)
 			goto encode_err;
 
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
index 56ce58f761f1..3b3471d90e21 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_vp8_if.c
@@ -302,7 +302,8 @@ static int vp8_enc_encode_frame(struct venc_vp8_inst *inst,
 
 	mtk_vcodec_debug(inst, "->frm_cnt=%d", inst->frm_cnt);
 
-	ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf, NULL);
+	ret = vpu_enc_encode(&inst->vpu_inst, 0, frm_buf, bs_buf,
+			     NULL, MTK_VENC_CORE0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.c b/drivers/media/platform/mtk-vcodec/venc_drv_if.c
index 6cbdb7e30bb3..5c5013d0f32e 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.c
@@ -14,6 +14,7 @@
 #include "venc_drv_if.h"
 
 #include "mtk_vcodec_enc.h"
+#include "mtk_vcodec_enc_core.h"
 #include "mtk_vcodec_enc_pm.h"
 
 int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
@@ -31,9 +32,9 @@ int venc_if_init(struct mtk_vcodec_ctx *ctx, unsigned int fourcc)
 		return -EINVAL;
 	}
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->core_id);
 	ret = ctx->enc_if->init(ctx);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->core_id);
 
 	return ret;
 }
@@ -43,9 +44,9 @@ int venc_if_set_param(struct mtk_vcodec_ctx *ctx,
 {
 	int ret = 0;
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->core_id);
 	ret = ctx->enc_if->set_param(ctx->drv_handle, type, in);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->core_id);
 
 	return ret;
 }
@@ -56,24 +57,14 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 		   struct venc_done_result *result)
 {
 	int ret = 0;
-	unsigned long flags;
-
-	mtk_venc_lock(ctx);
 
-	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = ctx;
-	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+	venc_encode_prepare(ctx, opt);
 
-	mtk_vcodec_enc_clock_on(ctx->dev, 0);
 	ret = ctx->enc_if->encode(ctx->drv_handle, opt, frm_buf,
 				  bs_buf, result);
-	mtk_vcodec_enc_clock_off(ctx->dev, 0);
 
-	spin_lock_irqsave(&ctx->dev->irqlock, flags);
-	ctx->dev->curr_ctx = NULL;
-	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+	venc_encode_unprepare(ctx, opt);
 
-	mtk_venc_unlock(ctx);
 	return ret;
 }
 
@@ -84,11 +75,57 @@ int venc_if_deinit(struct mtk_vcodec_ctx *ctx)
 	if (!ctx->drv_handle)
 		return 0;
 
-	mtk_venc_lock(ctx);
+	mtk_venc_lock(ctx, ctx->core_id);
 	ret = ctx->enc_if->deinit(ctx->drv_handle);
-	mtk_venc_unlock(ctx);
+	mtk_venc_unlock(ctx, ctx->core_id);
 
 	ctx->drv_handle = NULL;
 
 	return ret;
 }
+
+void venc_encode_prepare(struct mtk_vcodec_ctx *ctx,
+			 enum venc_start_opt opt)
+{
+	unsigned long flags;
+	struct mtk_venc_core_dev *core;
+
+	if (ctx->dev->venc_pdata->core_mode == VENC_DUAL_CORE_MODE) {
+		if (ctx->enc_idx & 0x01)
+			ctx->core_id = MTK_VENC_CORE1;
+		else
+			ctx->core_id = MTK_VENC_CORE0;
+	} else {
+		ctx->core_id = MTK_VENC_CORE0;
+	}
+	mtk_venc_lock(ctx, ctx->core_id);
+
+	spin_lock_irqsave(&ctx->dev->irqlock, flags);
+
+	if (ctx->dev->venc_pdata->core_mode == VENC_DUAL_CORE_MODE) {
+		core = ctx->dev->enc_core_dev[ctx->core_id];
+
+		core->curr_ctx = ctx;
+	} else {
+		ctx->dev->curr_ctx = ctx;
+	}
+
+	spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+
+	mtk_vcodec_enc_clock_on(ctx->dev, ctx->core_id);
+}
+
+void venc_encode_unprepare(struct mtk_vcodec_ctx *ctx,
+			   enum venc_start_opt opt)
+{
+	unsigned long flags;
+
+	if (ctx->dev->venc_pdata->core_mode == VENC_SINGLE_CORE_MODE ||
+	    opt == VENC_START_OPT_ENCODE_SEQUENCE_HEADER) {
+		mtk_vcodec_enc_clock_off(ctx->dev, ctx->core_id);
+		spin_lock_irqsave(&ctx->dev->irqlock, flags);
+		ctx->dev->curr_ctx = NULL;
+		spin_unlock_irqrestore(&ctx->dev->irqlock, flags);
+		mtk_venc_unlock(ctx, ctx->core_id);
+	}
+}
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
index 0b04a1020873..15e9a2ab9cda 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
@@ -167,4 +167,9 @@ int venc_if_encode(struct mtk_vcodec_ctx *ctx,
 		   struct mtk_vcodec_mem *bs_buf,
 		   struct venc_done_result *result);
 
+void venc_encode_prepare(struct mtk_vcodec_ctx *ctx,
+			 enum venc_start_opt opt);
+void venc_encode_unprepare(struct mtk_vcodec_ctx *ctx,
+			   enum venc_start_opt opt);
+
 #endif /* _VENC_DRV_IF_H_ */
diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
index d3570c4c177d..a7219c10013b 100644
--- a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
@@ -225,9 +225,11 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
 int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
-		   struct venc_frame_info *frame_info)
+		   struct venc_frame_info *frame_info,
+		   int core_id)
 {
 	const bool is_ext = MTK_ENC_CTX_IS_EXT(vpu->ctx);
+	const int core_mode = MTK_ENC_CORE_MODE(vpu->ctx);
 	size_t msg_size = is_ext ?
 		sizeof(struct venc_ap_ipi_msg_enc_ext) :
 		sizeof(struct venc_ap_ipi_msg_enc);
@@ -261,6 +263,12 @@ int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		out.data[1] = frame_info->skip_frm_count;
 		out.data[2] = frame_info->frm_type;
 	}
+
+	if (core_mode == VENC_DUAL_CORE_MODE) {
+		out.data_item = 4;
+		out.data[3] = core_id;
+	}
+
 	if (vpu_enc_send_msg(vpu, &out, msg_size)) {
 		mtk_vcodec_err(vpu, "AP_IPIMSG_ENC_ENCODE %d fail",
 			       bs_mode);
diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h b/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
index f83bc1b3f2bf..a8055eb62f7c 100644
--- a/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_vpu_if.h
@@ -45,7 +45,8 @@ int vpu_enc_set_param(struct venc_vpu_inst *vpu,
 int vpu_enc_encode(struct venc_vpu_inst *vpu, unsigned int bs_mode,
 		   struct venc_frm_buf *frm_buf,
 		   struct mtk_vcodec_mem *bs_buf,
-		   struct venc_frame_info *frame_info);
+		   struct venc_frame_info *frame_info,
+		   int core_id);
 int vpu_enc_deinit(struct venc_vpu_inst *vpu);
 
 #endif
-- 
2.18.0

