Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644654FEDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiDMD57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiDMD4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:56:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488562E1;
        Tue, 12 Apr 2022 20:54:32 -0700 (PDT)
X-UUID: 7db9a74c5e9443a79f4e0e76581e8e8f-20220413
X-UUID: 7db9a74c5e9443a79f4e0e76581e8e8f-20220413
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 64575598; Wed, 13 Apr 2022 11:54:26 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 13 Apr 2022 11:54:24 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Apr 2022 11:54:23 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4, 7/7] media: mediatek: vcodec: Add to support H264 inner racing mode
Date:   Wed, 13 Apr 2022 11:54:10 +0800
Message-ID: <20220413035410.29568-8-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413035410.29568-1-yunfei.dong@mediatek.com>
References: <20220413035410.29568-1-yunfei.dong@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reduce decoder latency, enable H264 inner racing mode.

Send lat trans buffer information to core when trigger lat to work,
need not to wait until lat decode done.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
---
 .../mediatek/vcodec/mtk_vcodec_dec_drv.c      |  4 +++
 .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 34 +++++++++++++++++++
 .../platform/mediatek/vcodec/mtk_vcodec_drv.h | 10 ++++++
 .../vcodec/vdec/vdec_h264_req_multi_if.c      | 25 +++++++++++---
 4 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
index b9b99770c5cb..456cf33bc74f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
@@ -388,6 +388,10 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 		}
 	}
 
+	atomic_set(&dev->dec_active_cnt, 0);
+	memset(dev->vdec_racing_info, 0, sizeof(dev->vdec_racing_info));
+	mutex_init(&dev->dec_racing_info_mutex);
+
 	ret = video_register_device(vfd_dec, VFL_TYPE_VIDEO, -1);
 	if (ret) {
 		mtk_v4l2_err("Failed to register video device");
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
index d69faa463d04..4305e4eb9900 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
@@ -144,6 +144,34 @@ static void mtk_vcodec_dec_disable_irq(struct mtk_vcodec_dev *vdec_dev, int hw_i
 	}
 }
 
+static void mtk_vcodec_load_racing_info(struct mtk_vcodec_ctx *ctx)
+{
+	void __iomem *vdec_racing_addr;
+	int j;
+
+	mutex_lock(&ctx->dev->dec_racing_info_mutex);
+	if (atomic_inc_return(&ctx->dev->dec_active_cnt) == 1) {
+		vdec_racing_addr = ctx->dev->reg_base[VDEC_MISC] + 0x100;
+		for (j = 0; j < 132; j++)
+			writel(ctx->dev->vdec_racing_info[j], vdec_racing_addr + j * 4);
+	}
+	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
+}
+
+static void mtk_vcodec_record_racing_info(struct mtk_vcodec_ctx *ctx)
+{
+	void __iomem *vdec_racing_addr;
+	int j;
+
+	mutex_lock(&ctx->dev->dec_racing_info_mutex);
+	if (atomic_dec_and_test(&ctx->dev->dec_active_cnt)) {
+		vdec_racing_addr = ctx->dev->reg_base[VDEC_MISC] + 0x100;
+		for (j = 0; j < 132; j++)
+			ctx->dev->vdec_racing_info[j] = readl(vdec_racing_addr + j * 4);
+	}
+	mutex_unlock(&ctx->dev->dec_racing_info_mutex);
+}
+
 static struct mtk_vcodec_pm *mtk_vcodec_dec_get_pm(struct mtk_vcodec_dev *vdec_dev,
 						   int hw_idx)
 {
@@ -214,11 +242,17 @@ void mtk_vcodec_dec_enable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
 	mtk_vcodec_dec_child_dev_on(ctx->dev, hw_idx);
 
 	mtk_vcodec_dec_enable_irq(ctx->dev, hw_idx);
+
+	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+		mtk_vcodec_load_racing_info(ctx);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_dec_enable_hardware);
 
 void mtk_vcodec_dec_disable_hardware(struct mtk_vcodec_ctx *ctx, int hw_idx)
 {
+	if (IS_VDEC_INNER_RACING(ctx->dev->dec_capability))
+		mtk_vcodec_record_racing_info(ctx);
+
 	mtk_vcodec_dec_disable_irq(ctx->dev, hw_idx);
 
 	mtk_vcodec_dec_child_dev_off(ctx->dev, hw_idx);
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 0e3db8ccb398..677f47b34172 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -28,6 +28,7 @@
 #define MTK_V4L2_BENCHMARK	0
 #define WAIT_INTR_TIMEOUT_MS	1000
 #define IS_VDEC_LAT_ARCH(hw_arch) ((hw_arch) >= MTK_VDEC_LAT_SINGLE_CORE)
+#define IS_VDEC_INNER_RACING(capability) (capability & MTK_VCODEC_INNER_RACING)
 
 /*
  * enum mtk_hw_reg_idx - MTK hw register base index
@@ -357,6 +358,7 @@ enum mtk_vdec_format_types {
 	MTK_VDEC_FORMAT_H264_SLICE = 0x100,
 	MTK_VDEC_FORMAT_VP8_FRAME = 0x200,
 	MTK_VDEC_FORMAT_VP9_FRAME = 0x400,
+	MTK_VCODEC_INNER_RACING = 0x20000,
 };
 
 /**
@@ -478,6 +480,10 @@ struct mtk_vcodec_enc_pdata {
  * @subdev_dev: subdev hardware device
  * @subdev_prob_done: check whether all used hw device is prob done
  * @subdev_bitmap: used to record hardware is ready or not
+ *
+ * @dec_active_cnt: used to mark whether need to record register value
+ * @vdec_racing_info: record register value
+ * @dec_racing_info_mutex: mutex lock used for inner racing mode
  */
 struct mtk_vcodec_dev {
 	struct v4l2_device v4l2_dev;
@@ -523,6 +529,10 @@ struct mtk_vcodec_dev {
 	void *subdev_dev[MTK_VDEC_HW_MAX];
 	int (*subdev_prob_done)(struct mtk_vcodec_dev *vdec_dev);
 	DECLARE_BITMAP(subdev_bitmap, MTK_VDEC_HW_MAX);
+
+	atomic_t dec_active_cnt;
+	u32 vdec_racing_info[132];
+	struct mutex dec_racing_info_mutex;
 };
 
 static inline struct mtk_vcodec_ctx *fh_to_ctx(struct v4l2_fh *fh)
diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
index e199620b076d..c386655ea14c 100644
--- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
+++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_h264_req_multi_if.c
@@ -626,6 +626,18 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 		goto err_free_fb_out;
 	}
 
+	share_info->trans_end = inst->ctx->msg_queue.wdma_addr.dma_addr +
+		inst->vsi->wdma_end_addr_offset;
+	share_info->trans_start = inst->ctx->msg_queue.wdma_wptr_addr;
+	share_info->nal_info = inst->vsi->dec.nal_info;
+
+	if (IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
+		memcpy_fromio(&share_info->h264_slice_params,
+			      &inst->vsi->h264_slice_params,
+			      sizeof(share_info->h264_slice_params));
+		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
+	}
+
 	/* wait decoder done interrupt */
 	timeout = mtk_vcodec_wait_for_done_ctx(inst->ctx, MTK_INST_IRQ_RECEIVED,
 					       WAIT_INTR_TIMEOUT_MS, MTK_VDEC_LAT0);
@@ -639,14 +651,17 @@ static int vdec_h264_slice_lat_decode(void *h_vdec, struct mtk_vcodec_mem *bs,
 
 	share_info->trans_end = inst->ctx->msg_queue.wdma_addr.dma_addr +
 		inst->vsi->wdma_end_addr_offset;
-	share_info->trans_start = inst->ctx->msg_queue.wdma_wptr_addr;
-	share_info->nal_info = inst->vsi->dec.nal_info;
 	vdec_msg_queue_update_ube_wptr(&lat_buf->ctx->msg_queue,
 				       share_info->trans_end);
 
-	memcpy_fromio(&share_info->h264_slice_params, &inst->vsi->h264_slice_params,
-		      sizeof(share_info->h264_slice_params));
-	vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
+	if (!IS_VDEC_INNER_RACING(inst->ctx->dev->dec_capability)) {
+		memcpy_fromio(&share_info->h264_slice_params,
+			      &inst->vsi->h264_slice_params,
+			      sizeof(share_info->h264_slice_params));
+		vdec_msg_queue_qbuf(&inst->ctx->dev->msg_queue_core_ctx, lat_buf);
+	}
+	mtk_vcodec_debug(inst, "dec num: %d lat crc: 0x%x 0x%x 0x%x", inst->slice_dec_num,
+			 inst->vsi->dec.crc[0], inst->vsi->dec.crc[1], inst->vsi->dec.crc[2]);
 
 	inst->slice_dec_num++;
 	return 0;
-- 
2.18.0

