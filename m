Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90CB5A246B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 11:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbiHZJaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 05:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343822AbiHZJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 05:29:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50834D7D05;
        Fri, 26 Aug 2022 02:29:23 -0700 (PDT)
X-UUID: b7fb7f4baecc4dcbb06e1cfe1ede1fc5-20220826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=YokyjwBnZCHsDcb2gPY03WgDk1z27Edq56FPi5rXXLE=;
        b=JP/23cduBDTIt/fLdCwtj+8ajIdoEXBWZAcfbNTYPLIPubz2bKjqMKVf2mGZlIh7CbPDeUACk/nEcAk6RDjJUmsQrSqgz9MN4L4QylVr6/YhuDBbbIYZ9wMMP88CqxSCu2fiDtCUj1eRpsJOZxR4Mrr0HnWF7hHgGZkmndGggsE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:a0029ab8-5140-42b6-9ebd-b59e27a4241f,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_
        Ham,ACTION:release,TS:0
X-CID-META: VersionHash:84eae18,CLOUDID:d759aa55-e800-47dc-8adf-0c936acf4f1b,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b7fb7f4baecc4dcbb06e1cfe1ede1fc5-20220826
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1886102531; Fri, 26 Aug 2022 17:29:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 26 Aug 2022 17:29:15 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 26 Aug 2022 17:29:14 +0800
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
        <maoguang.meng@mediatek.com>, irui wang <irui.wang@mediatek.com>
Subject: [V7,7/8] media: mtk-jpegdec: refactor jpegdec func interface
Date:   Fri, 26 Aug 2022 17:29:03 +0800
Message-ID: <20220826092904.10283-8-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826092904.10283-1-irui.wang@mediatek.com>
References: <20220826092904.10283-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

refactor the func interface of mtk_jpeg_dec_set_config
for decode

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.c    | 38 +++++++++++--
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  1 +
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 55 ++++++++++---------
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.h  |  3 +-
 .../platform/mediatek/jpeg/mtk_jpeg_dec_reg.h |  1 +
 5 files changed, 66 insertions(+), 32 deletions(-)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
index b1ed045bae4e..cfdf94b8a2cd 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c
@@ -588,6 +588,31 @@ static int mtk_jpeg_enc_s_selection(struct file *file, void *priv,
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
@@ -628,7 +653,7 @@ static const struct v4l2_ioctl_ops mtk_jpeg_dec_ioctl_ops = {
 	.vidioc_g_fmt_vid_out_mplane    = mtk_jpeg_g_fmt_vid_mplane,
 	.vidioc_s_fmt_vid_cap_mplane    = mtk_jpeg_s_fmt_vid_cap_mplane,
 	.vidioc_s_fmt_vid_out_mplane    = mtk_jpeg_s_fmt_vid_out_mplane,
-	.vidioc_qbuf                    = v4l2_m2m_ioctl_qbuf,
+	.vidioc_qbuf                    = mtk_jpeg_qbuf,
 	.vidioc_subscribe_event         = mtk_jpeg_subscribe_event,
 	.vidioc_g_selection		= mtk_jpeg_dec_g_selection,
 
@@ -1212,7 +1237,6 @@ static void mtk_jpegdec_worker(struct work_struct *work)
 	jpeg_src_buf->frame_num = ctx->total_frame_num;
 	jpeg_dst_buf->curr_ctx = ctx;
 	jpeg_dst_buf->frame_num = ctx->total_frame_num;
-	ctx->total_frame_num++;
 
 	mtk_jpegdec_set_hw_param(ctx, hw_id, src_buf, dst_buf);
 	ret = pm_runtime_get_sync(comp_jpeg[hw_id]->dev);
@@ -1242,9 +1266,11 @@ static void mtk_jpegdec_worker(struct work_struct *work)
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
@@ -1313,8 +1339,10 @@ static void mtk_jpeg_dec_device_run(void *priv)
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
index 55e2759a0b23..751a181ab067 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -80,6 +80,7 @@ struct mtk_jpeg_src_buf {
 	u32 frame_num;
 	struct vb2_v4l2_buffer b;
 	struct list_head list;
+	u32 bs_size;
 	struct mtk_jpeg_dec_param dec_param;
 
 	struct mtk_jpeg_ctx *curr_ctx;
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 1ea3ce7049f1..91bf80f8059c 100644
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

