Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13D1576D02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbiGPJfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiGPJfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:35:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED2C2CDE5;
        Sat, 16 Jul 2022 02:34:50 -0700 (PDT)
X-UUID: e891f58d34af42e0a6add91b15c1896a-20220716
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:e747981b-875c-4cf2-ab2b-bb8b643545f7,OB:10,L
        OB:10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:e747981b-875c-4cf2-ab2b-bb8b643545f7,OB:10,LOB
        :10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:3d5a2433-b9e4-42b8-b28a-6364427c76bb,C
        OID:98ccdc9f7b50,Recheck:0,SF:28|16|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: e891f58d34af42e0a6add91b15c1896a-20220716
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 458650923; Sat, 16 Jul 2022 17:34:44 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 16 Jul 2022 17:34:43 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:34:42 +0800
From:   Irui Wang <irui.wang@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        <angelogioacchino.delregno@collabora.com>,
        <nicolas.dufresne@collabora.com>, <wenst@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>
CC:     <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Tomasz Figa <tfiga@chromium.org>, <xia.jiang@mediatek.com>,
        <maoguang.meng@mediatek.com>, <srv_heupstream@mediatek.com>,
        irui wang <irui.wang@mediatek.com>
Subject: [V11,5/7] mtk-jpegenc: add jpeg encode worker interface
Date:   Sat, 16 Jul 2022 17:34:33 +0800
Message-ID: <20220716093435.29796-6-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716093435.29796-1-irui.wang@mediatek.com>
References: <20220716093435.29796-1-irui.wang@mediatek.com>
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

From: kyrie wu <kyrie.wu@mediatek.com>

Add jpeg encoding worker to ensure that two HWs
run in parallel in MT8195.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>

---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 158 +++++++++++++++++-
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  20 ++-
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  |  42 +++--
 3 files changed, 206 insertions(+), 14 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 3286e9606505..0a7fe7dfe605 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -105,10 +105,18 @@ static struct mtk_jpeg_fmt mtk_jpeg_dec_formats[] = {
 #define MTK_JPEG_ENC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_enc_formats)
 #define MTK_JPEG_DEC_NUM_FORMATS ARRAY_SIZE(mtk_jpeg_dec_formats)
 
+enum {
+	MTK_JPEG_BUF_FLAGS_INIT			= 0,
+	MTK_JPEG_BUF_FLAGS_LAST_FRAME		= 1,
+};
+
 struct mtk_jpeg_src_buf {
+	u32 frame_num;
 	struct vb2_v4l2_buffer b;
 	struct list_head list;
 	struct mtk_jpeg_dec_param dec_param;
+
+	struct mtk_jpeg_ctx *curr_ctx;
 };
 
 static int debug;
@@ -907,6 +915,147 @@ static int mtk_jpeg_set_dec_dst(struct mtk_jpeg_ctx *ctx,
 	return 0;
 }
 
+static int mtk_jpegenc_get_hw(struct mtk_jpeg_ctx *ctx)
+{
+	struct mtk_jpegenc_comp_dev *comp_jpeg;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+	unsigned long flags;
+	int hw_id = -1;
+	int i;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++) {
+		comp_jpeg = jpeg->enc_hw_dev[i];
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
+static int mtk_jpegenc_set_hw_param(struct mtk_jpeg_ctx *ctx,
+				    int hw_id,
+				    struct vb2_v4l2_buffer *src_buf,
+				    struct vb2_v4l2_buffer *dst_buf)
+{
+	struct mtk_jpegenc_comp_dev *jpeg = ctx->jpeg->enc_hw_dev[hw_id];
+
+	jpeg->hw_param.curr_ctx = ctx;
+	jpeg->hw_param.src_buffer = src_buf;
+	jpeg->hw_param.dst_buffer = dst_buf;
+
+	return 0;
+}
+
+static int mtk_jpegenc_put_hw(struct mtk_jpeg_dev *jpeg, int hw_id)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&jpeg->hw_lock, flags);
+	jpeg->enc_hw_dev[hw_id]->hw_state = MTK_JPEG_HW_IDLE;
+	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
+
+	return 0;
+}
+
+static void mtk_jpegenc_worker(struct work_struct *work)
+{
+	struct mtk_jpegenc_comp_dev *comp_jpeg[MTK_JPEGENC_HW_MAX];
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpeg_src_buf *jpeg_dst_buf;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+	int ret, i, hw_id = 0;
+	unsigned long flags;
+
+	struct mtk_jpeg_ctx *ctx = container_of(work,
+		struct mtk_jpeg_ctx,
+		jpeg_work);
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+
+	for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
+		comp_jpeg[i] = jpeg->enc_hw_dev[i];
+
+retry_select:
+	hw_id = mtk_jpegenc_get_hw(ctx);
+	if (hw_id < 0) {
+		ret = wait_event_interruptible(jpeg->enc_hw_wq,
+					       atomic_read(&jpeg->enchw_rdy) > 0);
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
+	atomic_dec(&jpeg->enchw_rdy);
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
+
+	mtk_jpegenc_set_hw_param(ctx, hw_id, src_buf, dst_buf);
+	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
+	if (ret < 0) {
+		dev_err(jpeg->dev, "%s : %d, pm_runtime_get_sync fail !!!\n",
+			__func__, __LINE__);
+		goto enc_end;
+	}
+
+	ret = clk_prepare_enable(comp_jpeg[hw_id]->venc_clk.clks->clk);
+	if (ret) {
+		dev_err(jpeg->dev, "%s : %d, jpegenc clk_prepare_enable fail\n",
+			__func__, __LINE__);
+		goto enc_end;
+	}
+
+	schedule_delayed_work(&comp_jpeg[hw_id]->job_timeout_work,
+			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+
+	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
+	jpeg_dst_buf = mtk_jpeg_vb2_to_srcbuf(&dst_buf->vb2_buf);
+	jpeg_dst_buf->curr_ctx = ctx;
+	jpeg_dst_buf->frame_num = ctx->total_frame_num;
+	ctx->total_frame_num++;
+	mtk_jpeg_enc_reset(comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_set_enc_dst(ctx,
+			     comp_jpeg[hw_id]->reg_base,
+			     &dst_buf->vb2_buf);
+	mtk_jpeg_set_enc_src(ctx,
+			     comp_jpeg[hw_id]->reg_base,
+			     &src_buf->vb2_buf);
+	mtk_jpeg_set_enc_params(ctx, comp_jpeg[hw_id]->reg_base);
+	mtk_jpeg_enc_start(comp_jpeg[hw_id]->reg_base);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+	spin_unlock_irqrestore(&comp_jpeg[hw_id]->hw_lock, flags);
+
+	return;
+
+enc_end:
+	v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+getbuf_fail:
+	atomic_inc(&jpeg->enchw_rdy);
+	mtk_jpegenc_put_hw(jpeg, hw_id);
+	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
+}
+
 static void mtk_jpeg_enc_device_run(void *priv)
 {
 	struct mtk_jpeg_ctx *ctx = priv;
@@ -924,7 +1073,7 @@ static void mtk_jpeg_enc_device_run(void *priv)
 		goto enc_end;
 
 	schedule_delayed_work(&jpeg->job_timeout_work,
-			      msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
+			msecs_to_jiffies(MTK_JPEG_HW_TIMEOUT_MSEC));
 
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 
@@ -951,6 +1100,10 @@ static void mtk_jpeg_enc_device_run(void *priv)
 
 static void mtk_jpeg_multicore_enc_device_run(void *priv)
 {
+	struct mtk_jpeg_ctx *ctx = priv;
+	struct mtk_jpeg_dev *jpeg = ctx->jpeg;
+
+	queue_work(jpeg->workqueue, &ctx->jpeg_work);
 }
 
 static void mtk_jpeg_dec_device_run(void *priv)
@@ -1219,6 +1372,9 @@ static int mtk_jpeg_open(struct file *file)
 		goto free;
 	}
 
+	if (jpeg->is_jpgenc_multihw)
+		INIT_WORK(&ctx->jpeg_work, mtk_jpegenc_worker);
+
 	v4l2_fh_init(&ctx->fh, vfd);
 	file->private_data = &ctx->fh;
 	v4l2_fh_add(&ctx->fh);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index caa9370ac8ac..ff7bd4467ae7 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -75,6 +75,11 @@ struct mtk_jpeg_variant {
 	u32 cap_q_default_fourcc;
 };
 
+enum mtk_jpeg_hw_state {
+	MTK_JPEG_HW_IDLE = 0,
+	MTK_JPEG_HW_BUSY = 1,
+};
+
 struct mtk_jpeg_hw_param {
 	struct vb2_v4l2_buffer *src_buffer;
 	struct vb2_v4l2_buffer *dst_buffer;
@@ -101,8 +106,13 @@ struct mtk_jpegenc_clk {
  * @plat_dev:		platform device data
  * @reg_base:		JPEG registers mapping
  * @master_dev:		mtk_jpeg_dev device
- * @pm:			mtk_jpegenc_pm
+ * @venc_clk:		mtk_jpegenc_clk
  * @jpegenc_irq:	jpeg encode irq num
+ * @job_timeout_work:	handle jpeg encode work
+ * @hw_param:		record hw param
+ * @hw_rdy:		record hw ready
+ * @hw_state:		record hw state
+ * @hw_lock:		spinlock protecting the hw device resource
  */
 struct mtk_jpegenc_comp_dev {
 	struct device *dev;
@@ -113,6 +123,9 @@ struct mtk_jpegenc_comp_dev {
 	int jpegenc_irq;
 	struct delayed_work job_timeout_work;
 	struct mtk_jpeg_hw_param hw_param;
+	enum mtk_jpeg_hw_state hw_state;
+	//spinlock protecting the hw device resource
+	spinlock_t hw_lock;
 };
 
 /**
@@ -145,6 +158,8 @@ struct mtk_jpeg_dev {
 	void __iomem *reg_encbase[MTK_JPEGENC_HW_MAX];
 	struct mtk_jpegenc_comp_dev *enc_hw_dev[MTK_JPEGENC_HW_MAX];
 	bool is_jpgenc_multihw;
+	wait_queue_head_t enc_hw_wq;
+	atomic_t enchw_rdy;
 };
 
 /**
@@ -203,6 +218,9 @@ struct mtk_jpeg_ctx {
 	u8 enc_quality;
 	u8 restart_interval;
 	struct v4l2_ctrl_handler ctrl_hdl;
+
+	struct work_struct jpeg_work;
+	u32 total_frame_num;
 };
 
 #endif /* _MTK_JPEG_CORE_H */
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 4d0d254bd574..f7e40c010ec4 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -192,6 +192,7 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
 		container_of(dly_work,
 			     struct mtk_jpegenc_comp_dev,
 			     job_timeout_work);
+	struct mtk_jpeg_dev *master_jpeg = cjpeg->master_dev;
 	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
 
@@ -202,6 +203,9 @@ static void mtk_jpegenc_timeout_work(struct work_struct *work)
 	mtk_jpeg_enc_reset(cjpeg->reg_base);
 	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
 	pm_runtime_put(cjpeg->dev);
+	cjpeg->hw_state = MTK_JPEG_HW_IDLE;
+	atomic_inc(&master_jpeg->enchw_rdy);
+	wake_up(&master_jpeg->enc_hw_wq);
 	v4l2_m2m_buf_done(src_buf, buf_state);
 }
 
@@ -218,30 +222,33 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 
 	cancel_delayed_work(&jpeg->job_timeout_work);
 
+	ctx = jpeg->hw_param.curr_ctx;
+	src_buf = jpeg->hw_param.src_buffer;
+	dst_buf = jpeg->hw_param.dst_buffer;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
 	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
 		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
 	if (irq_status)
 		writel(0, jpeg->reg_base + JPEG_ENC_INT_STS);
 	if (!(irq_status & JPEG_ENC_INT_STATUS_DONE))
-		return IRQ_NONE;
-
-	ctx = v4l2_m2m_get_curr_priv(master_jpeg->m2m_dev);
-	if (!ctx) {
-		v4l2_err(&master_jpeg->v4l2_dev, "Context is NULL\n");
-		return IRQ_HANDLED;
-	}
-
-	src_buf = v4l2_m2m_src_buf_remove(ctx->fh.m2m_ctx);
-	dst_buf = v4l2_m2m_dst_buf_remove(ctx->fh.m2m_ctx);
-	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+		v4l2_warn(jpeg->dev, "Jpg Enc occurs unknown Err.");
 
 	result_size = mtk_jpeg_enc_get_file_size(jpeg->reg_base);
 	vb2_set_plane_payload(&dst_buf->vb2_buf, 0, result_size);
 	buf_state = VB2_BUF_STATE_DONE;
 	v4l2_m2m_buf_done(src_buf, buf_state);
 	v4l2_m2m_buf_done(dst_buf, buf_state);
-	v4l2_m2m_job_finish(master_jpeg->m2m_dev, ctx->fh.m2m_ctx);
 	pm_runtime_put(ctx->jpeg->dev);
+	clk_disable_unprepare(jpeg->venc_clk.clks->clk);
+	if (!list_empty(&ctx->fh.m2m_ctx->out_q_ctx.rdy_queue) ||
+	    !list_empty(&ctx->fh.m2m_ctx->cap_q_ctx.rdy_queue)) {
+		queue_work(master_jpeg->workqueue, &ctx->jpeg_work);
+	}
+
+	jpeg->hw_state = MTK_JPEG_HW_IDLE;
+	wake_up(&master_jpeg->enc_hw_wq);
+	atomic_inc(&master_jpeg->enchw_rdy);
 
 	return IRQ_HANDLED;
 }
@@ -298,8 +305,19 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
 		master_dev->is_jpgenc_multihw = true;
 		for (i = 0; i < MTK_JPEGENC_HW_MAX; i++)
 			master_dev->enc_hw_dev[i] = NULL;
+
+		init_waitqueue_head(&master_dev->enc_hw_wq);
+		master_dev->workqueue = alloc_ordered_workqueue(MTK_JPEG_NAME,
+								WQ_MEM_RECLAIM
+								| WQ_FREEZABLE);
+		if (!master_dev->workqueue)
+			return -EINVAL;
 	}
 
+	atomic_set(&master_dev->enchw_rdy, MTK_JPEGENC_HW_MAX);
+	spin_lock_init(&dev->hw_lock);
+	dev->hw_state = MTK_JPEG_HW_IDLE;
+
 	INIT_DELAYED_WORK(&dev->job_timeout_work,
 			  mtk_jpegenc_timeout_work);
 
-- 
2.18.0

