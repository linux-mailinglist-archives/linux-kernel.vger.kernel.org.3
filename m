Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E914DC0FB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 09:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiCQIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 04:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiCQIY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 04:24:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3F9B16C08A;
        Thu, 17 Mar 2022 01:23:33 -0700 (PDT)
X-UUID: 09757d13d9994aeca831f53f0499a5dc-20220317
X-UUID: 09757d13d9994aeca831f53f0499a5dc-20220317
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1314942033; Thu, 17 Mar 2022 16:23:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 17 Mar 2022 16:23:28 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 17 Mar 2022 16:23:26 +0800
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
Subject: [PATCH v3, 10/10] media: mtk-vcodec: Done encode result to client
Date:   Thu, 17 Mar 2022 16:22:30 +0800
Message-ID: <20220317082230.23622-11-irui.wang@mediatek.com>
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

When enable venc_multi_core mode encoding, the wait IRQ done synchronous
function should not be called, so the encode result can't return
to client in device_run. device_run called to trigger encoding
process, finish it, so another scheduled job can be ran. When
encoding done, done the encode result to client in IRQ handler.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  6 ++
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 68 +++++++++++++++++--
 .../platform/mtk-vcodec/mtk_vcodec_enc.h      |  3 +
 .../platform/mtk-vcodec/mtk_vcodec_enc_core.c | 25 ++++++-
 .../platform/mtk-vcodec/mtk_vcodec_util.h     |  1 +
 .../platform/mtk-vcodec/venc/venc_h264_if.c   | 22 +++++-
 .../media/platform/mtk-vcodec/venc_drv_if.h   |  2 +
 7 files changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 889ce61f0fc8..0317707b2ed3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -300,6 +300,9 @@ struct vdec_pic_info {
  * @q_mutex: src & dst vb2_queue mutex
  * @enc_idx: used to record encoded frame count
  * @core_id: used to record used core
+ * @pfrm_buf: used to store current ctx's frame buffer
+ * @pbs_buf: used to store current ctx's bitstream buffer
+ * @hdr_size: used to store prepend header size
  */
 struct mtk_vcodec_ctx {
 	enum mtk_instance_type type;
@@ -353,6 +356,9 @@ struct mtk_vcodec_ctx {
 	struct mutex q_mutex;
 	int enc_idx;
 	int core_id;
+	struct vb2_v4l2_buffer *pfrm_buf[MTK_VENC_CORE_MAX];
+	struct vb2_v4l2_buffer *pbs_buf[MTK_VENC_CORE_MAX];
+	unsigned int hdr_size;
 };
 
 /*
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 2753f004f123..49186b6ab943 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -476,13 +476,13 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		f->fmt.pix.pixelformat = fmt->fourcc;
 	}
 
+	q_data->visible_width = f->fmt.pix_mp.width;
+	q_data->visible_height = f->fmt.pix_mp.height;
 	ret = vidioc_try_fmt_out(ctx, f, fmt);
 	if (ret)
 		return ret;
 
 	q_data->fmt = fmt;
-	q_data->visible_width = f->fmt.pix_mp.width;
-	q_data->visible_height = f->fmt.pix_mp.height;
 	q_data->coded_width = f->fmt.pix_mp.width;
 	q_data->coded_height = f->fmt.pix_mp.height;
 
@@ -923,6 +923,8 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 
 	mtk_v4l2_debug(2, "[%d]-> type=%d", ctx->id, q->type);
 
+	mtk_venc_lock_all(ctx);
+
 	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
 			vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
@@ -1102,10 +1104,13 @@ static int mtk_venc_param_change(struct mtk_vcodec_ctx *ctx)
 				ctx->id,
 				vb2_v4l2->vb2_buf.index,
 				mtk_buf->enc_params.force_intra);
-		if (mtk_buf->enc_params.force_intra)
+		if (mtk_buf->enc_params.force_intra) {
 			ret |= venc_if_set_param(ctx,
 						 VENC_SET_PARAM_FORCE_INTRA,
 						 NULL);
+
+			ctx->enc_idx = 0;
+		}
 	}
 
 	mtk_buf->param_change = MTK_ENCODE_PARAM_NONE;
@@ -1156,6 +1161,7 @@ static void mtk_venc_worker(struct work_struct *work)
 	 * is dequeued.
 	 */
 	if (src_buf == &ctx->empty_flush_buf.vb) {
+		mtk_venc_lock_all(ctx);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
@@ -1170,9 +1176,12 @@ static void mtk_venc_worker(struct work_struct *work)
 		frm_buf.fb_addr[i].size =
 				(size_t)src_buf->vb2_buf.planes[i].length;
 	}
+	frm_buf.src_addr = src_buf;
+
 	bs_buf.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
 	bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	bs_buf.size = (size_t)dst_buf->vb2_buf.planes[0].length;
+	bs_buf.buf = dst_buf;
 
 	mtk_v4l2_debug(2,
 			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
@@ -1219,6 +1228,8 @@ static void m2mops_venc_device_run(void *priv)
 {
 	struct mtk_vcodec_ctx *ctx = priv;
 
+	mtk_venc_param_change(ctx);
+
 	if ((ctx->q_data[MTK_Q_DATA_DST].fmt->fourcc == V4L2_PIX_FMT_H264) &&
 	    (ctx->state != MTK_STATE_HEADER)) {
 		/* encode h264 sps/pps header */
@@ -1227,7 +1238,6 @@ static void m2mops_venc_device_run(void *priv)
 		return;
 	}
 
-	mtk_venc_param_change(ctx);
 	queue_work(ctx->dev->encode_workqueue, &ctx->encode_work);
 }
 
@@ -1413,6 +1423,34 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int core_id,
+		       unsigned int bs_size, bool time_out, bool key_frame)
+{
+	struct vb2_v4l2_buffer *src_vb2_v4l2 = NULL;
+	struct vb2_v4l2_buffer *dst_vb2_v4l2 = NULL;
+
+	/*
+	 * the frm_buf(src_buf) and bs_buf(dst_buf) can be obtained from ctx,
+	 * then put them to done list, user can get them by dqbuf call
+	 */
+	src_vb2_v4l2 = ctx->pfrm_buf[core_id];
+	dst_vb2_v4l2 = ctx->pbs_buf[core_id];
+
+	if (src_vb2_v4l2 && dst_vb2_v4l2) {
+		dst_vb2_v4l2->vb2_buf.timestamp =
+			src_vb2_v4l2->vb2_buf.timestamp;
+		dst_vb2_v4l2->timecode = src_vb2_v4l2->timecode;
+
+		if (key_frame)
+			dst_vb2_v4l2->flags |= V4L2_BUF_FLAG_KEYFRAME;
+
+		v4l2_m2m_buf_done(src_vb2_v4l2, VB2_BUF_STATE_DONE);
+		vb2_set_plane_payload(&dst_vb2_v4l2->vb2_buf, 0, bs_size);
+		v4l2_m2m_buf_done(dst_vb2_v4l2, VB2_BUF_STATE_DONE);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_venc_buf_done);
+
 int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int core_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
@@ -1440,3 +1478,25 @@ void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
 
 	ctx->state = MTK_STATE_FREE;
 }
+
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx)
+{
+	unsigned int i;
+	struct mtk_vcodec_dev *dev = ctx->dev;
+
+	/*
+	 * For frame-racing mode encoding, there are may be bufs being encoded
+	 * when get the empty flush buffer or stop streaming, for example, the
+	 * buffer with LAST flag will return to client before the encoding
+	 * buffers, which will cause frame lost.
+	 * The encoder device mutex will be locked during encoding process,
+	 * when encode done, the mutex unlocked. So if all encoder device mutex
+	 * can be locked, which means there are no bufs being encoded at this
+	 * time, then the buffer with LAST flag can return to client properly.
+	 */
+	for (i = 0; i < MTK_VENC_CORE_MAX; i++) {
+		mutex_lock(&dev->enc_mutex[i]);
+		mutex_unlock(&dev->enc_mutex[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_venc_lock_all);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
index 434d91d36158..1e22c77a2760 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.h
@@ -46,5 +46,8 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
 int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int core_id,
+		       unsigned int bs_size, bool time_out, bool key_frame);
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx);
 
 #endif /* _MTK_VCODEC_ENC_H_ */
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
index 7e376413beaa..c295b5d0b877 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_core.c
@@ -16,6 +16,10 @@
 #include "mtk_vcodec_enc_pm.h"
 #include "mtk_vcodec_intr.h"
 
+#define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
+#define VENC_PIC_FRM_TYPE      0x0010
+#define VENC_PIC_KEY_FRM       0x2
+
 static const struct of_device_id mtk_venc_core_ids[] = {
 	{
 		.compatible = "mediatek,mtk-venc-core",
@@ -51,6 +55,9 @@ static irqreturn_t mtk_enc_core_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	unsigned int bs_size;
+	unsigned int frm_type;
+	bool is_key_frame = 0;
 
 	spin_lock_irqsave(&core->main_dev->irqlock, flags);
 	ctx = core->curr_ctx;
@@ -62,9 +69,25 @@ static irqreturn_t mtk_enc_core_irq_handler(int irq, void *priv)
 
 	addr = core->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
 	ctx->irq_status = readl(core->reg_base + MTK_VENC_IRQ_STATUS_OFFSET);
+	bs_size = readl(core->reg_base + VENC_PIC_BITSTREAM_BYTE_CNT);
+	frm_type = readl(core->reg_base + VENC_PIC_FRM_TYPE);
 	clean_irq_status(ctx->irq_status, addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	if (ctx->irq_status & MTK_VENC_IRQ_STATUS_FRM) {
+		if (ctx->hdr_size != 0) {
+			bs_size += ctx->hdr_size;
+			ctx->hdr_size = 0;
+		}
+		if (frm_type & VENC_PIC_KEY_FRM)
+			is_key_frame = 1;
+
+		mtk_venc_buf_done(ctx, core->core_id, bs_size, 0, is_key_frame);
+		mtk_vcodec_enc_clock_off(core->main_dev, core->core_id);
+		mtk_venc_unlock(ctx, core->core_id);
+	} else {
+		wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
index de9e18688842..4436d8bc60a0 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.h
@@ -15,6 +15,7 @@ struct mtk_vcodec_mem {
 	size_t size;
 	void *va;
 	dma_addr_t dma_addr;
+	void *buf;
 };
 
 struct mtk_vcodec_fb {
diff --git a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
index 4bfaaf2ec91c..b54c3c7ccab8 100644
--- a/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc/venc_h264_if.c
@@ -555,6 +555,12 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 		return ret;
 	}
 
+	if (ctx->dev->venc_multi_core) {
+		++inst->frm_cnt;
+		mtk_vcodec_debug(inst, "multi core : frm %d <-", inst->frm_cnt);
+		return ret;
+	}
+
 	irq_status = h264_enc_wait_venc_done(inst);
 	if (irq_status != MTK_VENC_IRQ_STATUS_FRM) {
 		mtk_vcodec_err(inst, "irq_status=%d failed", irq_status);
@@ -635,10 +641,12 @@ static int h264_enc_encode(void *handle,
 	int ret = 0;
 	struct venc_h264_inst *inst = (struct venc_h264_inst *)handle;
 	struct mtk_vcodec_ctx *ctx = inst->ctx;
+	bool is_single_core = !ctx->dev->venc_multi_core;
 
 	mtk_vcodec_debug(inst, "opt %d ->", opt);
 
-	enable_irq(ctx->dev->enc_irq);
+	if (is_single_core)
+		enable_irq(ctx->dev->enc_irq);
 
 	switch (opt) {
 	case VENC_START_OPT_ENCODE_SEQUENCE_HEADER: {
@@ -662,6 +670,13 @@ static int h264_enc_encode(void *handle,
 		unsigned int bs_size_hdr;
 		unsigned int bs_size_frm;
 
+		/*
+		 * the frm_buf and bs_buf need to be recorded into ctx,
+		 * when encoding done, the target buffer can be obtained
+		 */
+		ctx->pfrm_buf[ctx->core_id] = frm_buf->src_addr;
+		ctx->pbs_buf[ctx->core_id] = bs_buf->buf;
+
 		if (!inst->prepend_hdr) {
 			ret = h264_encode_frame(inst, frm_buf, bs_buf,
 						&result->bs_size, ctx->core_id);
@@ -698,6 +713,8 @@ static int h264_enc_encode(void *handle,
 
 		result->bs_size = hdr_sz + filler_sz + bs_size_frm;
 
+		ctx->hdr_size = hdr_sz + filler_sz;
+
 		mtk_vcodec_debug(inst, "hdr %d filler %d frame %d bs %d",
 				 hdr_sz, filler_sz, bs_size_frm,
 				 result->bs_size);
@@ -714,8 +731,9 @@ static int h264_enc_encode(void *handle,
 	}
 
 encode_err:
+	if (is_single_core)
+		disable_irq(ctx->dev->enc_irq);
 
-	disable_irq(ctx->dev->enc_irq);
 	mtk_vcodec_debug(inst, "opt %d <-", opt);
 
 	return ret;
diff --git a/drivers/media/platform/mtk-vcodec/venc_drv_if.h b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
index 15e9a2ab9cda..3ad31abb7290 100644
--- a/drivers/media/platform/mtk-vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mtk-vcodec/venc_drv_if.h
@@ -108,9 +108,11 @@ struct venc_frame_info {
 /*
  * struct venc_frm_buf - frame buffer information used in venc_if_encode()
  * @fb_addr: plane frame buffer addresses
+ * @src_addr: vb2_v4l2_buffer src buffer address
  */
 struct venc_frm_buf {
 	struct mtk_vcodec_fb fb_addr[MTK_VCODEC_MAX_PLANES];
+	void *src_addr;
 };
 
 /*
-- 
2.18.0

