Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20D6C55B573
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 04:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiF0C4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiF0C4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:56:06 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804153885;
        Sun, 26 Jun 2022 19:56:04 -0700 (PDT)
X-UUID: ef7cd0c9baad437dbe4d0a2576816f95-20220627
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:8e3e6bf3-8629-47ae-9328-4b29d93a8e39,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:6a8a90ea-f7af-4e69-92ee-0fd74a0c286c,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: ef7cd0c9baad437dbe4d0a2576816f95-20220627
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 441861078; Mon, 27 Jun 2022 10:55:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 27 Jun 2022 10:55:55 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 27 Jun 2022 10:55:54 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, kyrie wu <kyrie.wu@mediatek.com>,
        <srv_heupstream@mediatek.com>
Subject: [V4,5/8] media: mtk-jpegdec: add jpeg decode worker interface
Date:   Mon, 27 Jun 2022 10:55:37 +0800
Message-ID: <20220627025540.8901-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627025540.8901-1-irui.wang@mediatek.com>
References: <20220627025540.8901-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Add jpeg decoding worker to ensure that three HWs
run in parallel in MT8195.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 184 ++++++++++++++++++
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |   6 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  |  33 ++--
 3 files changed, 212 insertions(+), 11 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 5683df94ac6a..d4eca0b22ace 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -1096,6 +1096,171 @@ static void mtk_jpeg_enc_device_run(void *priv)
 	}
 }
 
+static int mtk_jpegdec_select_hw(struct mtk_jpeg_ctx *ctx)
+{
+	struct mtk_jpegdec_comp_dev *comp_jpeg;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	unsigned long flags;
+	int hw_id = -1;
+	int i;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++) {
+		comp_jpeg = jpeg->dec_hw_dev[i];
+		if (comp_jpeg->hw_state == MTK_JPEG_HW_IDLE) {
+			hw_id = i;
+			comp_jpeg->hw_state = MTK_JPEG_HW_BUSY;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return hw_id;
+}
+
+static int mtk_jpegdec_deselect_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	jpeg->dec_hw_dev[hw_id]->hw_state =
+		MTK_JPEG_HW_IDLE;
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return 0;
+}
+
+static int mtk_jpegdec_set_hw_param(struct mtk_jpeg_ctx *ctx,
+				    int hw_id,
+				    struct vb2_v4l2_buffer *src_buf,
+				    struct vb2_v4l2_buffer *dst_buf)
+{
+	struct mtk_jpegdec_comp_dev *jpeg =
+		ctx->jpeg->dec_hw_dev[hw_id];
+
+	jpeg->hw_param.curr_ctx = ctx;
+	jpeg->hw_param.src_buffer = src_buf;
+	jpeg->hw_param.dst_buffer = dst_buf;
+
+	return 0;
+}
+
+static void mtk_jpegdec_worker(struct work_struct *work)
+{
+	struct mtk_jpeg_ctx *ctx = container_of(work, struct mtk_jpeg_ctx,
+		jpeg_work);
+	struct mtk_jpegdec_comp_dev *comp_jpeg[MTK_JPEGDEC_HW_MAX];
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpeg_src_buf *jpeg_src_buf, *jpeg_dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	int ret, i, hw_id = 0;
+	struct mtk_jpeg_bs bs;
+	struct mtk_jpeg_fb fb;
+	unsigned long flags;
+
+	for (i = 0; i < MTK_JPEGDEC_HW_MAX; i++)
+		comp_jpeg[i] = jpeg->dec_hw_dev[i];
+
+retry_select:
+	hw_id = mtk_jpegdec_select_hw(ctx);
+	if (hw_id < 0) {
+		ret = wait_event_interruptible_timeout(jpeg->dec_hw_wq,
+						       atomic_read(&jpeg->dechw_rdy) > 0,
+						       MTK_JPEG_HW_TIMEOUT_MSEC);
+		if (ret != 0) {
+			dev_err(jpeg->dev, "%s : %d, all HW are busy\n",
+				__func__, __LINE__);
+			v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+			return;
+		}
+
+		goto retry_select;
+	}
+
+	atomic_dec(&jpeg->dechw_rdy);
+	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
+	if (!src_buf)
+		goto getbuf_fail;
+
+	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
+	if (!dst_buf)
+		goto getbuf_fail;
+
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
+	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
+
+	if (mtk_jpeg_check_resolution_change(ctx,
+					     &jpeg_src_buf->dec_param)) {
+		mtk_jpeg_queue_src_chg_event(ctx);
+		ctx->state = MTK_JPEG_SOURCE_CHANGE;
+		goto dec_end;
+	}
+
+	jpeg_src_buf->curr_ctx = ctx;
+	jpeg_src_buf->frame_num = ctx->total_frame_num;
+	jpeg_dst_buf->curr_ctx = ctx;
+	jpeg_dst_buf->frame_num = ctx->total_frame_num;
+	ctx->total_frame_num++;
+
+	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
+	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
+	if (ret < 0) {
+		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
+			__func__, __LINE__);
+		goto dec_end;
+	}
+
+	ret = clk_prepare_enable(comp_jpeg[hw_id]->jdec_clk.clks->clk);
+	if (ret) {
+		dev_err(jpeg->dev, "%s : %d, jpegdec clk_prepare_enable fail\n",
+			__func__, __LINE__);
+		goto clk_end;
+	}
+
+	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
+	mtk_jpeg_set_dec_src(ctx, &src_buf->vb2_buf, &bs);
+	if (mtk_jpeg_set_dec_dst(ctx,
+				 &jpeg_src_buf->dec_param,
+				 &dst_buf->vb2_buf, &fb)) {
+		dev_err(jpeg->dev, "%s : %d, mtk_jpeg_set_dec_dst fail\n",
+			__func__, __LINE__);
+		goto setdst_end;
+	}
+
+	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
+	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_dec_set_config(jpeg->reg_base,
+				&jpeg_src_buf->dec_param,
+				&bs,
+				&fb);
+	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
+
+	return;
+
+setdst_end:
+	clk_disable_unprepare(comp_jpeg[hw_id]->jdec_clk.clks->clk);
+clk_end:
+	pm_runtime_put(comp_jpeg[hw_id]->dev);
+dec_end:
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+getbuf_fail:
+	atomic_inc(&jpeg->dechw_rdy);
+	mtk_jpegdec_deselect_hw(jpeg, hw_id);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+}
+
 static void mtk_jpeg_dec_device_run(void *priv)
 {
 	struct mtk_jpeg_ctx *ctx = priv;
@@ -1108,6 +1273,7 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	struct mtk_jpeg_fb fb;
 	int ret;
 
+if (!jpeg->is_jpgdec_multihw) {
 	src_buf = v4l2_m2m_next_src_buf(ctx->fh.m2m_ctx);
 	dst_buf = v4l2_m2m_next_dst_buf(ctx->fh.m2m_ctx);
 	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(&src_buf->vb2_buf);
@@ -1145,6 +1311,9 @@ static void mtk_jpeg_dec_device_run(void *priv)
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+} else {
+	queue_work(jpeg->workqueue, &ctx->jpeg_work);
+}
 }
 
 static int mtk_jpeg_dec_job_ready(void *priv)
@@ -1361,6 +1530,9 @@ static int mtk_jpeg_open(struct file *file)
 	if (jpeg->is_jpgenc_multihw)
 		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
 
+	if (jpeg->is_jpgdec_multihw)
+		INIT_WORK(&ctx->jpeg_work, mtk_jpegdec_worker);
+
 	INIT_LIST_HEAD(&ctx->dst_done_queue);
 	spin_lock_init(&ctx->done_queue_lock);
 	v4l2_fh_init(&ctx->fh, vfd);
@@ -1526,6 +1698,18 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 				goto err_alloc_workqueue;
 			}
 		}
+
+		if (of_property_read_bool(pdev->dev.of_node,
+					  "mediatek,jpegdec-multi-core")) {
+			init_waitqueue_head(&jpeg->dec_hw_wq);
+			jpeg->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+								  WQ_MEM_RECLAIM
+								  | WQ_FREEZABLE);
+			if (!jpeg->workqueue) {
+				ret = -EINVAL;
+				goto err_alloc_workqueue;
+			}
+		}
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &jpeg->v4l2_dev);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 353ce40f6ca2..a158017c7767 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -173,6 +173,9 @@ struct mtk_jpegdec_comp_dev {
 	int hw_id;
 	struct delayed_work job_timeout_work;
 	struct mtk_jpeg_hw_param hw_param;
+	enum mtk_jpeg_hw_state hw_state;
+	//spinlock protecting the hw device resource
+	spinlock_t hw_lock;
 };
 
 /**
@@ -211,6 +214,9 @@ struct mtk_jpeg_dev {
 	void __iomem *reg_decbase[MTK_JPEGDEC_HW_MAX];
 	struct mtk_jpegdec_comp_dev *dec_hw_dev[MTK_JPEGDEC_HW_MAX];
 	bool is_jpgdec_multihw;
+	wait_queue_head_t dec_hw_wq;
+	struct workqueue_struct	*dec_workqueue;
+	atomic_t dechw_rdy;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index e9e99fea656e..a8d63242ea8f 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -446,6 +446,7 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
 	struct mtk_jpegdec_comp_dev *cjpeg =
 		container_of(work, struct mtk_jpegdec_comp_dev,
 			     job_timeout_work.work);
+	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
 	src_buf = cjpeg->hw_param.src_buffer;
@@ -455,6 +456,9 @@ static void mtk_jpegdec_timeout_work(struct work_struct *work)
 	mtk_jpeg_dec_reset(cjpeg->reg_base);
 	clk_disable_unprepare(cjpeg->jdec_clk.clks->clk);
 	pm_runtime_put(cjpeg->dev);
+	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
+	atomic_inc(&master_jpeg->dechw_rdy);
+	wake_up(&master_jpeg->dec_hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
 }
@@ -474,22 +478,21 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 
 	cancel_delayed_work(&jpeg->job_timeout_work);
 
+	ctx = jpeg->hw_param.curr_ctx;
+	src_buf = jpeg->hw_param.src_buffer;
+	dst_buf = jpeg->hw_param.dst_buffer;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
 	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
 	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
 	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
 		mtk_jpeg_dec_reset(jpeg->reg_base);
-	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE)
-		return IRQ_NONE;
 
-	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
-	if (!ctx) {
-		dev_err(jpeg->dev, "Context is NULL\n");
-		return IRQ_HANDLED;
+	if (dec_irq_ret != MTK_JPEG_DEC_RESULT_EOF_DONE) {
+		dev_err(jpeg->dev, " Not MTK_JPEG_DEC_RESULT_EOF_DONE\n");
+		goto irq_handled;
 	}
 
-	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
 	jpeg_src_buf =
 		container_of(src_buf, struct mtk_jpeg_src_buf, b);
 
@@ -497,12 +500,16 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 		vb2_set_plane_payload(&dst_buf->vb2_buf, i,
 				      jpeg_src_buf->dec_param.comp_size[i]);
 
+irq_handled:
 	buf_state = VB2_BUF_STATE_DONE;
-
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
-	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
 	pm_runtime_put(ctx->jpeg->dev);
+	clk_disable_unprepare(jpeg->jdec_clk.clks->clk);
+
+	jpeg->hw_state = MTK_JPEG_HW_IDLE;
+	wake_up(&master_jpeg->dec_hw_wq);
+	atomic_inc(&master_jpeg->dechw_rdy);
 
 	return IRQ_HANDLED;
 }
@@ -555,6 +562,10 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
+	atomic_set(&master_dev->dechw_rdy, MTK_JPEGDEC_HW_MAX);
+	spin_lock_init(&dev->hw_lock);
+	dev->hw_state = MTK_JPEG_HW_IDLE;
+
 	INIT_DELAYED_WORK(&dev->job_timeout_work,
 			  mtk_jpegdec_timeout_work);
 
-- 
2.18.0

