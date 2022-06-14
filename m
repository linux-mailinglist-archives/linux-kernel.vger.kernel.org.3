Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADB754B013
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356685AbiFNMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356490AbiFNMKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:10:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198AA49914;
        Tue, 14 Jun 2022 05:10:22 -0700 (PDT)
X-UUID: 3dfb46e32cdc48108d41fc81ef078b45-20220614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:a193d36f-c491-4342-848f-543b899f2d3e,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:11069207-b57a-4a25-a071-bc7b4972bc68,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 3dfb46e32cdc48108d41fc81ef078b45-20220614
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 103969406; Tue, 14 Jun 2022 20:10:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 14 Jun 2022 20:10:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 14 Jun 2022 20:10:13 +0800
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
Subject: [RESEND V3,7/8] media: mtk-jpegdec: refactor jpegdec func interface
Date:   Tue, 14 Jun 2022 20:10:03 +0800
Message-ID: <20220614121004.31616-8-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220614121004.31616-1-irui.wang@mediatek.com>
References: <20220614121004.31616-1-irui.wang@mediatek.com>
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

From: kyrie wu <kyrie.wu@mediatek.com>

refactor the func interface of mtk_jpeg_dec_set_config
for decode

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 38 +++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 55 ++++++++++---------
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |  3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |  1 +
 5 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index 25fa3ad8de3d..ee351625bf81 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -587,6 +587,31 @@ static int mtk_jpeg_enc_s_selection(struct file *file, void *priv,
 	return 0;
 }
 
+static int mtk_jpeg_qbuf(struct file *file, void *priv, struct v4l2_buffer *buf)
+{
+	struct v4l2_fh *fh = file->private_data;
+	struct mtk_jpeg_ctx *ctx = mtk_jpeg_fh_to_ctx(priv);
+	struct vb2_queue *vq;
+	struct vb2_buffer *vb;
+	struct mtk_jpeg_src_buf *jpeg_src_buf;
+
+	if (buf->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
+		goto end;
+
+	vq = v4l2_m2m_get_vq(fh->m2m_ctx, buf->type);
+	if (buf->index >= vq->num_buffers) {
+		dev_err(ctx->jpeg->dev, "buffer index out of range\n");
+		return -EINVAL;
+	}
+
+	vb = vq->bufs[buf->index];
+	jpeg_src_buf = mtk_jpeg_vb2_to_srcbuf(vb);
+	jpeg_src_buf->bs_size = buf->m.planes[0].bytesused;
+
+end:
+	return v4l2_m2m_qbuf(file, fh->m2m_ctx, buf);
+}
+
 static const struct v4l2_ioctl_ops mtk_jpeg_enc_ioctl_ops = {
 	.vidioc_querycap                = mtk_jpeg_querycap,
 	.vidioc_enum_fmt_vid_cap	= mtk_jpeg_enum_fmt_vid_cap,
@@ -627,7 +652,7 @@ static const struct v4l2_ioctl_ops mtk_jpeg_dec_ioctl_ops = {
 	.vidioc_g_fmt_vid_out_mplane    = mtk_jpeg_g_fmt_vid_mplane,
 	.vidioc_s_fmt_vid_cap_mplane    = mtk_jpeg_s_fmt_vid_cap_mplane,
 	.vidioc_s_fmt_vid_out_mplane    = mtk_jpeg_s_fmt_vid_out_mplane,
-	.vidioc_qbuf                    = v4l2_m2m_ioctl_qbuf,
+	.vidioc_qbuf                    = mtk_jpeg_qbuf,
 	.vidioc_subscribe_event         = mtk_jpeg_subscribe_event,
 	.vidioc_g_selection		= mtk_jpeg_dec_g_selection,
 
@@ -1214,7 +1239,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	jpeg_src_buf->frame_num = ctx->total_frame_num;
 	jpeg_dst_buf->curr_ctx = ctx;
 	jpeg_dst_buf->frame_num = ctx->total_frame_num;
-	ctx->total_frame_num++;
 
 	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
 	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
@@ -1244,9 +1268,11 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	}
 
 	spin_lock_irqsave(&comp_jpeg[hw_id]->hw_lock, flags);
+	ctx->total_frame_num++;
 	mtk_jpeg_dec_reset(comp_jpeg[hw_id]->reg_base);
-	mtk_jpeg_dec_set_config(jpeg->reg_base,
+	mtk_jpeg_dec_set_config(comp_jpeg[hw_id]->reg_base,
 				&jpeg_src_buf->dec_param,
+				jpeg_src_buf->bs_size,
 				&bs,
 				&fb);
 	mtk_jpeg_dec_start(comp_jpeg[hw_id]->reg_base);
@@ -1308,8 +1334,10 @@ if (!jpeg->variant->is_multihw) {
 	spin_lock_irqsave(&jpeg->hw_lock, flags);
 	mtk_jpeg_dec_reset(jpeg->reg_base);
 	mtk_jpeg_dec_set_config(jpeg->reg_base,
-				&jpeg_src_buf->dec_param, &bs, &fb);
-
+				&jpeg_src_buf->dec_param,
+				jpeg_src_buf->bs_size,
+				&bs,
+				&fb);
 	mtk_jpeg_dec_start(jpeg->reg_base);
 	spin_unlock_irqrestore(&jpeg->hw_lock, flags);
 	return;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index 4da6d0621981..16634de8bd0f 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -81,6 +81,7 @@ struct mtk_jpeg_src_buf {
 	u32 frame_num;
 	struct vb2_v4l2_buffer b;
 	struct list_head list;
+	u32 bs_size;
 	struct mtk_jpeg_dec_param dec_param;
 
 	struct mtk_jpeg_ctx *curr_ctx;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 8879968f7d7d..d98bbbe05db2 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -330,12 +330,14 @@ static void mtk_jpeg_dec_set_bs_write_ptr(void __iomem *base, u32 ptr)
 	writel(ptr, base + JPGDEC_REG_FILE_BRP);
 }
 
-static void mtk_jpeg_dec_set_bs_info(void __iomem *base, u32 addr, u32 size)
+static void mtk_jpeg_dec_set_bs_info(void __iomem *base, u32 addr, u32 size,
+				     u32 bitstream_size)
 {
 	mtk_jpeg_verify_align(addr, 16, JPGDEC_REG_FILE_ADDR);
 	mtk_jpeg_verify_align(size, 128, JPGDEC_REG_FILE_TOTAL_SIZE);
 	writel(addr, base + JPGDEC_REG_FILE_ADDR);
 	writel(size, base + JPGDEC_REG_FILE_TOTAL_SIZE);
+	writel(bitstream_size, base + JPGDEC_REG_BIT_STREAM_SIZE);
 }
 
 static void mtk_jpeg_dec_set_comp_id(void __iomem *base, u32 id_y, u32 id_u,
@@ -404,39 +406,40 @@ static void mtk_jpeg_dec_set_sampling_factor(void __iomem *base, u32 comp_num,
 }
 
 void mtk_jpeg_dec_set_config(void __iomem *base,
-			     struct mtk_jpeg_dec_param *config,
+			     struct mtk_jpeg_dec_param *cfg,
+			     u32 bitstream_size,
 			     struct mtk_jpeg_bs *bs,
 			     struct mtk_jpeg_fb *fb)
 {
-	mtk_jpeg_dec_set_brz_factor(base, 0, 0, config->uv_brz_w, 0);
+	mtk_jpeg_dec_set_brz_factor(base, 0, 0, cfg->uv_brz_w, 0);
 	mtk_jpeg_dec_set_dec_mode(base, 0);
-	mtk_jpeg_dec_set_comp0_du(base, config->unit_num);
-	mtk_jpeg_dec_set_total_mcu(base, config->total_mcu);
-	mtk_jpeg_dec_set_bs_info(base, bs->str_addr, bs->size);
+	mtk_jpeg_dec_set_comp0_du(base, cfg->unit_num);
+	mtk_jpeg_dec_set_total_mcu(base, cfg->total_mcu);
+	mtk_jpeg_dec_set_bs_info(base, bs->str_addr, bs->size, bitstream_size);
 	mtk_jpeg_dec_set_bs_write_ptr(base, bs->end_addr);
-	mtk_jpeg_dec_set_du_membership(base, config->membership, 1,
-				       (config->comp_num == 1) ? 1 : 0);
-	mtk_jpeg_dec_set_comp_id(base, config->comp_id[0], config->comp_id[1],
-				 config->comp_id[2]);
-	mtk_jpeg_dec_set_q_table(base, config->qtbl_num[0],
-				 config->qtbl_num[1], config->qtbl_num[2]);
-	mtk_jpeg_dec_set_sampling_factor(base, config->comp_num,
-					 config->sampling_w[0],
-					 config->sampling_h[0],
-					 config->sampling_w[1],
-					 config->sampling_h[1],
-					 config->sampling_w[2],
-					 config->sampling_h[2]);
-	mtk_jpeg_dec_set_mem_stride(base, config->mem_stride[0],
-				    config->mem_stride[1]);
-	mtk_jpeg_dec_set_img_stride(base, config->img_stride[0],
-				    config->img_stride[1]);
+	mtk_jpeg_dec_set_du_membership(base, cfg->membership, 1,
+				       (cfg->comp_num == 1) ? 1 : 0);
+	mtk_jpeg_dec_set_comp_id(base, cfg->comp_id[0], cfg->comp_id[1],
+				 cfg->comp_id[2]);
+	mtk_jpeg_dec_set_q_table(base, cfg->qtbl_num[0],
+				 cfg->qtbl_num[1], cfg->qtbl_num[2]);
+	mtk_jpeg_dec_set_sampling_factor(base, cfg->comp_num,
+					 cfg->sampling_w[0],
+					 cfg->sampling_h[0],
+					 cfg->sampling_w[1],
+					 cfg->sampling_h[1],
+					 cfg->sampling_w[2],
+					 cfg->sampling_h[2]);
+	mtk_jpeg_dec_set_mem_stride(base, cfg->mem_stride[0],
+				    cfg->mem_stride[1]);
+	mtk_jpeg_dec_set_img_stride(base, cfg->img_stride[0],
+				    cfg->img_stride[1]);
 	mtk_jpeg_dec_set_dst_bank0(base, fb->plane_addr[0],
 				   fb->plane_addr[1], fb->plane_addr[2]);
 	mtk_jpeg_dec_set_dst_bank1(base, 0, 0, 0);
-	mtk_jpeg_dec_set_dma_group(base, config->dma_mcu, config->dma_group,
-				   config->dma_last_mcu);
-	mtk_jpeg_dec_set_pause_mcu_idx(base, config->total_mcu);
+	mtk_jpeg_dec_set_dma_group(base, cfg->dma_mcu, cfg->dma_group,
+				   cfg->dma_last_mcu);
+	mtk_jpeg_dec_set_pause_mcu_idx(base, cfg->total_mcu);
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
 
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
index 87aaa5c9082b..8c31c6b12417 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.h
@@ -71,7 +71,8 @@ int mtk_jpeg_dec_fill_param(struct mtk_jpeg_dec_param *param);
 u32 mtk_jpeg_dec_get_int_status(void __iomem *dec_reg_base);
 u32 mtk_jpeg_dec_enum_result(u32 irq_result);
 void mtk_jpeg_dec_set_config(void __iomem *base,
-			     struct mtk_jpeg_dec_param *config,
+			     struct mtk_jpeg_dec_param *cfg,
+			     u32 bitstream_size,
 			     struct mtk_jpeg_bs *bs,
 			     struct mtk_jpeg_fb *fb);
 void mtk_jpeg_dec_reset(void __iomem *dec_reg_base);
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
index 21ec8f96797f..27b7711ca341 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_reg.h
@@ -45,5 +45,6 @@
 #define JPGDEC_REG_QT_ID		0x0270
 #define JPGDEC_REG_INTERRUPT_STATUS	0x0274
 #define JPGDEC_REG_STATUS		0x0278
+#define JPGDEC_REG_BIT_STREAM_SIZE	0x0344
 
 #endif /* _MTK_JPEG_REG_H */
-- 
2.18.0

