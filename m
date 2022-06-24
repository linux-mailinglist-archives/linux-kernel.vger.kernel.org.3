Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423E855955C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiFXIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiFXIYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:24:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150066E7B8;
        Fri, 24 Jun 2022 01:23:57 -0700 (PDT)
X-UUID: 5fef8495a7b74750a4e6f0856508281a-20220624
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f270c385-2188-4ede-8866-fd7f9a0c21e3,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:664378d8-850a-491d-a127-60d9309b2b3e,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 5fef8495a7b74750a4e6f0856508281a-20220624
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 943728301; Fri, 24 Jun 2022 16:23:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 24 Jun 2022 16:23:48 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jun 2022 16:23:46 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        "Tiffany Lin" <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
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
Subject: [PATCH v4, 8/8] media: mediatek: vcodec: Return encoding result in asynchronous mode
Date:   Fri, 24 Jun 2022 16:23:35 +0800
Message-ID: <20220624082335.10165-9-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624082335.10165-1-irui.wang@mediatek.com>
References: <20220624082335.10165-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

when enable multi-core encoding, the wait IRQ done synchronous function
should not be called, so the encoding result can't return to client in
device_run. Move the buffer done function in IRQ handler.

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  6 ++
 .../platform/mediatek/vcodec/mtk_vcodec_enc.c | 73 +++++++++++++++++--
 .../platform/mediatek/vcodec/mtk_vcodec_enc.h |  7 +-
 .../mediatek/vcodec/mtk_vcodec_enc_drv.c      | 28 ++++++-
 .../mediatek/vcodec/mtk_vcodec_enc_hw.c       | 13 +++-
 .../mediatek/vcodec/mtk_vcodec_enc_pm.c       |  1 +
 .../mediatek/vcodec/mtk_vcodec_util.h         |  1 +
 .../mediatek/vcodec/venc/venc_h264_if.c       | 20 +++--
 .../platform/mediatek/vcodec/venc_drv_if.h    |  2 +
 9 files changed, 138 insertions(+), 13 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index d54f12026189..6b05ee201fd3 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -302,6 +302,9 @@ struct vdec_pic_info {
  * @max_height: hardware supported max height
  * @msg_queue: msg queue used to store lat buffer information.
  * @encoded_frame_cnt: number of encoded frames
+ * @pfrm_buf: used to store current ctx's frame buffer
+ * @pbs_buf: used to store current ctx's bitstream buffer
+ * @hdr_size: used to store prepend header size
  */
 struct mtk_vcodec_ctx {
 	enum mtk_instance_type type;
@@ -352,6 +355,9 @@ struct mtk_vcodec_ctx {
 	struct vdec_msg_queue msg_queue;
 
 	int encoded_frame_cnt;
+	struct vb2_v4l2_buffer *pfrm_buf[MTK_VENC_HW_MAX];
+	struct vb2_v4l2_buffer *pbs_buf[MTK_VENC_HW_MAX];
+	unsigned int hdr_size;
 };
 
 /*
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index e0168f9cb2f5..8196407b50b6 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -929,6 +929,8 @@ static void vb2ops_venc_stop_streaming(struct vb2_queue *q)
 
 	mtk_v4l2_debug(2, "[%d]-> type=%d", ctx->id, q->type);
 
+	mtk_venc_lock_all(ctx);
+
 	if (q->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
 		while ((dst_buf = v4l2_m2m_dst_buf_remove(ctx->m2m_ctx))) {
 			vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
@@ -1164,6 +1166,7 @@ static void mtk_venc_worker(struct work_struct *work)
 	 * is dequeued.
 	 */
 	if (src_buf == &ctx->empty_flush_buf.vb) {
+		mtk_venc_lock_all(ctx);
 		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
 		dst_buf->flags |= V4L2_BUF_FLAG_LAST;
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
@@ -1178,9 +1181,12 @@ static void mtk_venc_worker(struct work_struct *work)
 		frm_buf.fb_addr[i].size =
 				(size_t)src_buf->vb2_buf.planes[i].length;
 	}
+	frm_buf.frm_addr = src_buf;
+
 	bs_buf.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
 	bs_buf.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
 	bs_buf.size = (size_t)dst_buf->vb2_buf.planes[0].length;
+	bs_buf.buf = dst_buf;
 
 	mtk_v4l2_debug(2,
 			"Framebuf PA=%llx Size=0x%zx;PA=0x%llx Size=0x%zx;PA=0x%llx Size=%zu",
@@ -1206,11 +1212,14 @@ static void mtk_venc_worker(struct work_struct *work)
 		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
 		mtk_v4l2_err("venc_if_encode failed=%d", ret);
 	} else {
-		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
-		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_result.bs_size);
-		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
-		mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
-				 enc_result.bs_size);
+		if (!IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
+			vb2_set_plane_payload(&dst_buf->vb2_buf, 0,
+					      enc_result.bs_size);
+			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
+			mtk_v4l2_debug(2, "venc_if_encode bs size=%d",
+				       enc_result.bs_size);
+		}
 	}
 
 	ctx->encoded_frame_cnt++;
@@ -1420,6 +1429,34 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 	return vb2_queue_init(dst_vq);
 }
 
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int hw_id,
+		       unsigned int bs_size, bool time_out, bool key_frame)
+{
+	struct vb2_v4l2_buffer *src_vb2_v4l2 = NULL;
+	struct vb2_v4l2_buffer *dst_vb2_v4l2 = NULL;
+
+	/*
+	 * the frm_buf(src_buf) and bs_buf(dst_buf) can be obtained from ctx,
+	 * then put them to done list, user can get them by dqbuf call
+	 */
+	src_vb2_v4l2 = ctx->pfrm_buf[hw_id];
+	dst_vb2_v4l2 = ctx->pbs_buf[hw_id];
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
 int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
 	struct mtk_vcodec_dev *dev = ctx->dev;
@@ -1427,6 +1464,7 @@ int mtk_venc_unlock(struct mtk_vcodec_ctx *ctx, int hw_id)
 	mutex_unlock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_unlock);
 
 int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id)
 {
@@ -1435,6 +1473,31 @@ int mtk_venc_lock(struct mtk_vcodec_ctx *ctx, int hw_id)
 	mutex_lock(&dev->enc_mutex[hw_id]);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mtk_venc_lock);
+
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx)
+{
+	unsigned int i;
+	struct mtk_vcodec_dev *dev = ctx->dev;
+
+	/*
+	 * For multi-core mode encoding, there are may be bufs being encoded
+	 * when get the empty flush buffer or stop streaming, for example, the
+	 * buffer with LAST flag will return to client before the encoding
+	 * buffers, which will cause frame lost.
+
+	 * The encoder device mutex will be locked during encoding process,
+	 * when encode done, the mutex unlocked. So if all encoder device mutex
+	 * can be locked, which means there are no bufs being encoded at this
+	 * time, then the buffer with LAST flag can return to client properly.
+	 */
+
+	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
+		mutex_lock(&dev->enc_mutex[i]);
+		mutex_unlock(&dev->enc_mutex[i]);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_venc_lock_all);
 
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx)
 {
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
index 29f5c8d1b59f..5ab17381c7ba 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.h
@@ -20,6 +20,9 @@
 
 #define MTK_VENC_IRQ_STATUS_OFFSET	0x05C
 #define MTK_VENC_IRQ_ACK_OFFSET	0x060
+#define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
+#define VENC_PIC_FRM_TYPE		0x0010
+#define VENC_PIC_KEY_FRM       0x2
 
 /**
  * struct mtk_video_enc_buf - Private data related to each VB2 buffer.
@@ -46,5 +49,7 @@ int mtk_vcodec_enc_queue_init(void *priv, struct vb2_queue *src_vq,
 void mtk_vcodec_enc_release(struct mtk_vcodec_ctx *ctx);
 int mtk_vcodec_enc_ctrls_setup(struct mtk_vcodec_ctx *ctx);
 void mtk_vcodec_enc_set_default_params(struct mtk_vcodec_ctx *ctx);
-
+void mtk_venc_buf_done(struct mtk_vcodec_ctx *ctx, int hw_id,
+		       unsigned int bs_size, bool time_out, bool key_frame);
+void mtk_venc_lock_all(struct mtk_vcodec_ctx *ctx);
 #endif /* _MTK_VCODEC_ENC_H_ */
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
index 006f3ce9c0d8..3210c24fefa5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_drv.c
@@ -89,6 +89,9 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	unsigned int bs_size;
+	unsigned int frm_type;
+	bool is_key_frame = 0;
 
 	spin_lock_irqsave(&dev->irqlock, flags);
 	ctx = dev->curr_enc_ctx[MTK_VENC_CORE_0];
@@ -101,8 +104,32 @@ static irqreturn_t mtk_vcodec_enc_irq_handler(int irq, void *priv)
 	ctx->irq_status = readl(dev->reg_base[dev->venc_pdata->core_id] +
 				(MTK_VENC_IRQ_STATUS_OFFSET));
 
+	bs_size = readl(dev->reg_base[dev->venc_pdata->core_id] +
+			(VENC_PIC_BITSTREAM_BYTE_CNT));
+	frm_type = readl(dev->reg_base[dev->venc_pdata->core_id] +
+			 (VENC_PIC_FRM_TYPE));
+
 	clean_irq_status(ctx->irq_status, addr);
 
+	if (IS_VENC_MULTICORE(dev->enc_capability)) {
+		if (ctx->irq_status & MTK_VENC_IRQ_STATUS_FRM) {
+			if (ctx->hdr_size != 0) {
+				bs_size += ctx->hdr_size;
+				ctx->hdr_size = 0;
+			}
+
+			if (frm_type & VENC_PIC_KEY_FRM)
+				is_key_frame = 1;
+
+			mtk_venc_buf_done(ctx, 0, bs_size, 0, is_key_frame);
+			mtk_vcodec_enc_clock_off(dev, 0);
+			mtk_venc_unlock(ctx, 0);
+		} else {
+			wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+		}
+		return IRQ_HANDLED;
+	}
+
 	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
 	return IRQ_HANDLED;
 }
@@ -290,7 +317,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 	}
 
 	dev->enc_irq = platform_get_irq(pdev, 0);
-	irq_set_status_flags(dev->enc_irq, IRQ_NOAUTOEN);
 	ret = devm_request_irq(&pdev->dev, dev->enc_irq,
 			       mtk_vcodec_enc_irq_handler,
 			       0, pdev->name, dev);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
index c151686f36a0..565acb3837d3 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_hw.c
@@ -52,6 +52,9 @@ static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
 	struct mtk_vcodec_ctx *ctx;
 	unsigned long flags;
 	void __iomem *addr;
+	unsigned int bs_size;
+	unsigned int frm_type;
+	bool is_key_frame = 0;
 
 	spin_lock_irqsave(&main_dev->irqlock, flags);
 	ctx = main_dev->curr_enc_ctx[dev->hw_id];
@@ -63,9 +66,17 @@ static irqreturn_t mtk_enc_hw_irq_handler(int irq, void *priv)
 
 	addr = dev->reg_base + MTK_VENC_IRQ_ACK_OFFSET;
 	ctx->irq_status = readl(dev->reg_base + MTK_VENC_IRQ_STATUS_OFFSET);
+	bs_size = readl(dev->reg_base + VENC_PIC_BITSTREAM_BYTE_CNT);
+	frm_type = readl(dev->reg_base + VENC_PIC_FRM_TYPE);
 	clean_hw_irq_status(ctx->irq_status, addr);
 
-	wake_up_ctx(ctx, MTK_INST_IRQ_RECEIVED, 0);
+	if (frm_type & VENC_PIC_KEY_FRM)
+		is_key_frame = 1;
+
+	mtk_venc_buf_done(ctx, dev->hw_id, bs_size, 0, is_key_frame);
+	mtk_vcodec_enc_clock_off(main_dev, dev->hw_id);
+	mtk_venc_unlock(ctx, dev->hw_id);
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
index e9b4e95ca012..e7914da9dfa5 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc_pm.c
@@ -234,3 +234,4 @@ void mtk_vcodec_enc_clock_off(struct mtk_vcodec_dev *dev, int hw_id)
 	for (i = enc_clk->clk_num - 1; i >= 0; i--)
 		clk_disable(enc_clk->clk_info[i].vcodec_clk);
 }
+EXPORT_SYMBOL_GPL(mtk_vcodec_enc_clock_off);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
index a74c98aa355b..a4b19f4ef759 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
@@ -15,6 +15,7 @@ struct mtk_vcodec_mem {
 	size_t size;
 	void *va;
 	dma_addr_t dma_addr;
+	void *buf;
 };
 
 struct mtk_vcodec_fb {
diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
index 1abdcc324b0e..0b28d075ac49 100644
--- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
+++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
@@ -22,7 +22,6 @@
 static const char h264_filler_marker[] = {0x0, 0x0, 0x0, 0x1, 0xc};
 
 #define H264_FILLER_MARKER_SIZE ARRAY_SIZE(h264_filler_marker)
-#define VENC_PIC_BITSTREAM_BYTE_CNT 0x0098
 
 /*
  * enum venc_h264_frame_type - h264 encoder output bitstream frame type
@@ -554,6 +553,11 @@ static int h264_encode_frame(struct venc_h264_inst *inst,
 		return ret;
 	}
 
+	if (IS_VENC_MULTICORE(ctx->dev->enc_capability)) {
+		++inst->frm_cnt;
+		return ret;
+	}
+
 	irq_status = h264_enc_wait_venc_done(inst);
 	if (irq_status != MTK_VENC_IRQ_STATUS_FRM) {
 		mtk_vcodec_err(inst, "irq_status=%d failed", irq_status);
@@ -638,8 +642,6 @@ static int h264_enc_encode(void *handle,
 
 	mtk_vcodec_debug(inst, "opt %d ->", opt);
 
-	enable_irq(ctx->dev->enc_irq);
-
 	switch (opt) {
 	case VENC_START_OPT_ENCODE_SEQUENCE_HEADER: {
 		unsigned int bs_size_hdr;
@@ -662,6 +664,13 @@ static int h264_enc_encode(void *handle,
 		unsigned int bs_size_hdr;
 		unsigned int bs_size_frm;
 
+		/*
+		 * the frm_buf and bs_buf need to recorded into current ctx,
+		 * when encoding done, the target buffers can be got from ctx.
+		 */
+		ctx->pfrm_buf[ctx->hw_id] = frm_buf->frm_addr;
+		ctx->pbs_buf[ctx->hw_id] = bs_buf->buf;
+
 		if (!inst->prepend_hdr) {
 			ret = h264_encode_frame(inst, frm_buf, bs_buf,
 						&result->bs_size, ctx->hw_id);
@@ -696,7 +705,9 @@ static int h264_enc_encode(void *handle,
 		if (ret)
 			goto encode_err;
 
-		result->bs_size = hdr_sz + filler_sz + bs_size_frm;
+		ctx->hdr_size = hdr_sz + filler_sz;
+
+		result->bs_size = ctx->hdr_size + bs_size_frm;
 
 		mtk_vcodec_debug(inst, "hdr %d filler %d frame %d bs %d",
 				 hdr_sz, filler_sz, bs_size_frm,
@@ -715,7 +726,6 @@ static int h264_enc_encode(void *handle,
 
 encode_err:
 
-	disable_irq(ctx->dev->enc_irq);
 	mtk_vcodec_debug(inst, "opt %d <-", opt);
 
 	return ret;
diff --git a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
index e676ccf6bd25..7e24b7f573d7 100644
--- a/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
+++ b/drivers/media/platform/mediatek/vcodec/venc_drv_if.h
@@ -108,9 +108,11 @@ struct venc_frame_info {
 /*
  * struct venc_frm_buf - frame buffer information used in venc_if_encode()
  * @fb_addr: plane frame buffer addresses
+ * @frm_addr: current v4l2 buffer address
  */
 struct venc_frm_buf {
 	struct mtk_vcodec_fb fb_addr[MTK_VCODEC_MAX_PLANES];
+	void *frm_addr;
 };
 
 /*
-- 
2.18.0

