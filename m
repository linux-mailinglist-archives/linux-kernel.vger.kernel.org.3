Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F974C0A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbiBWDkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237929AbiBWDkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:40:49 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6444C3D49F;
        Tue, 22 Feb 2022 19:40:21 -0800 (PST)
X-UUID: 6b6f8da668354749889148ee400fb7eb-20220223
X-UUID: 6b6f8da668354749889148ee400fb7eb-20220223
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 37144040; Wed, 23 Feb 2022 11:40:16 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Feb 2022 11:40:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Feb 2022 11:40:12 +0800
From:   Yunfei Dong <yunfei.dong@mediatek.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
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
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        Steve Cho <stevecho@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v7, 02/15] media: mtk-vcodec: Using firmware type to separate different firmware architecture
Date:   Wed, 23 Feb 2022 11:39:55 +0800
Message-ID: <20220223034008.15781-3-yunfei.dong@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220223034008.15781-1-yunfei.dong@mediatek.com>
References: <20220223034008.15781-1-yunfei.dong@mediatek.com>
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

MT8173 platform use vpu firmware, mt8183/mt8192 will use scp
firmware instead, using chip name is not reasonable to separate
different firmware architecture. Using firmware type is much better.

Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
Reviewed-by: Tzung-Bi Shih<tzungbi@google.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../platform/mtk-vcodec/mtk_vcodec_dec_stateful.c   |  1 -
 .../platform/mtk-vcodec/mtk_vcodec_dec_stateless.c  |  2 --
 drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h  | 13 -------------
 .../media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  5 -----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c   |  6 ++++++
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h   |  1 +
 drivers/media/platform/mtk-vcodec/vdec_vpu_if.c     |  4 ++--
 drivers/media/platform/mtk-vcodec/venc_vpu_if.c     |  2 +-
 8 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
index 04ca43c77e5f..7966c132be8f 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateful.c
@@ -613,7 +613,6 @@ static struct vb2_ops mtk_vdec_frame_vb2_ops = {
 };
 
 const struct mtk_vcodec_dec_pdata mtk_vdec_8173_pdata = {
-	.chip = MTK_MT8173,
 	.init_vdec_params = mtk_init_vdec_params,
 	.ctrls_setup = mtk_vcodec_dec_ctrls_setup,
 	.vdec_vb2_ops = &mtk_vdec_frame_vb2_ops,
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
index 23d997ac114d..5aebf88f997b 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_stateless.c
@@ -343,7 +343,6 @@ static struct vb2_ops mtk_vdec_request_vb2_ops = {
 };
 
 const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata = {
-	.chip = MTK_MT8183,
 	.init_vdec_params = mtk_init_vdec_params,
 	.ctrls_setup = mtk_vcodec_dec_ctrls_setup,
 	.vdec_vb2_ops = &mtk_vdec_request_vb2_ops,
@@ -362,7 +361,6 @@ const struct mtk_vcodec_dec_pdata mtk_vdec_8183_pdata = {
 
 /* This platform data is used for one lat and one core architecture. */
 const struct mtk_vcodec_dec_pdata mtk_lat_sig_core_pdata = {
-	.chip = MTK_MT8192,
 	.init_vdec_params = mtk_init_vdec_params,
 	.ctrls_setup = mtk_vcodec_dec_ctrls_setup,
 	.vdec_vb2_ops = &mtk_vdec_request_vb2_ops,
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
index 813901c4be5e..bb7b8e914d24 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
@@ -332,13 +332,6 @@ struct mtk_vcodec_ctx {
 	struct vdec_msg_queue msg_queue;
 };
 
-enum mtk_chip {
-	MTK_MT8173,
-	MTK_MT8183,
-	MTK_MT8192,
-	MTK_MT8195,
-};
-
 /*
  * enum mtk_vdec_hw_arch - Used to separate different hardware architecture
  */
@@ -364,7 +357,6 @@ enum mtk_vdec_hw_arch {
  * @vdec_framesizes: supported video decoder frame sizes
  * @num_framesizes: count of video decoder frame sizes
  *
- * @chip: chip this decoder is compatible with
  * @hw_arch: hardware arch is used to separate pure_sin_core and lat_sin_core
  *
  * @is_subdev_supported: whether support parent-node architecture(subdev)
@@ -387,7 +379,6 @@ struct mtk_vcodec_dec_pdata {
 	const struct mtk_codec_framesizes *vdec_framesizes;
 	const int num_framesizes;
 
-	enum mtk_chip chip;
 	enum mtk_vdec_hw_arch hw_arch;
 
 	bool is_subdev_supported;
@@ -397,8 +388,6 @@ struct mtk_vcodec_dec_pdata {
 /**
  * struct mtk_vcodec_enc_pdata - compatible data for each IC
  *
- * @chip: chip this encoder is compatible with
- *
  * @uses_ext: whether the encoder uses the extended firmware messaging format
  * @min_bitrate: minimum supported encoding bitrate
  * @max_bitrate: maximum supported encoding bitrate
@@ -409,8 +398,6 @@ struct mtk_vcodec_dec_pdata {
  * @core_id: stand for h264 or vp8 encode index
  */
 struct mtk_vcodec_enc_pdata {
-	enum mtk_chip chip;
-
 	bool uses_ext;
 	unsigned long min_bitrate;
 	unsigned long max_bitrate;
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
index e21487341d8b..65207f5b6c1c 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_drv.c
@@ -377,7 +377,6 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
 }
 
 static const struct mtk_vcodec_enc_pdata mt8173_avc_pdata = {
-	.chip = MTK_MT8173,
 	.capture_formats = mtk_video_formats_capture_h264,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_h264),
 	.output_formats = mtk_video_formats_output,
@@ -388,7 +387,6 @@ static const struct mtk_vcodec_enc_pdata mt8173_avc_pdata = {
 };
 
 static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
-	.chip = MTK_MT8173,
 	.capture_formats = mtk_video_formats_capture_vp8,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_vp8),
 	.output_formats = mtk_video_formats_output,
@@ -399,7 +397,6 @@ static const struct mtk_vcodec_enc_pdata mt8173_vp8_pdata = {
 };
 
 static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
-	.chip = MTK_MT8183,
 	.uses_ext = true,
 	.capture_formats = mtk_video_formats_capture_h264,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_h264),
@@ -411,7 +408,6 @@ static const struct mtk_vcodec_enc_pdata mt8183_pdata = {
 };
 
 static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
-	.chip = MTK_MT8192,
 	.uses_ext = true,
 	.capture_formats = mtk_video_formats_capture_h264,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_h264),
@@ -423,7 +419,6 @@ static const struct mtk_vcodec_enc_pdata mt8192_pdata = {
 };
 
 static const struct mtk_vcodec_enc_pdata mt8195_pdata = {
-	.chip = MTK_MT8195,
 	.uses_ext = true,
 	.capture_formats = mtk_video_formats_capture_h264,
 	.num_capture_formats = ARRAY_SIZE(mtk_video_formats_capture_h264),
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
index 94b39ae5c2e1..556e54aadac9 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.c
@@ -65,3 +65,9 @@ int mtk_vcodec_fw_ipi_send(struct mtk_vcodec_fw *fw, int id, void *buf,
 	return fw->ops->ipi_send(fw, id, buf, len, wait);
 }
 EXPORT_SYMBOL_GPL(mtk_vcodec_fw_ipi_send);
+
+int mtk_vcodec_fw_get_type(struct mtk_vcodec_fw *fw)
+{
+	return fw->type;
+}
+EXPORT_SYMBOL_GPL(mtk_vcodec_fw_get_type);
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
index 539bb626772c..acd355961e3a 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw.h
@@ -39,5 +39,6 @@ int mtk_vcodec_fw_ipi_register(struct mtk_vcodec_fw *fw, int id,
 			       const char *name, void *priv);
 int mtk_vcodec_fw_ipi_send(struct mtk_vcodec_fw *fw, int id,
 			   void *buf, unsigned int len, unsigned int wait);
+int mtk_vcodec_fw_get_type(struct mtk_vcodec_fw *fw);
 
 #endif /* _MTK_VCODEC_FW_H_ */
diff --git a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
index dd35d2c5f920..7210061c772f 100644
--- a/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
+++ b/drivers/media/platform/mtk-vcodec/vdec_vpu_if.c
@@ -33,8 +33,8 @@ static void handle_init_ack_msg(const struct vdec_vpu_ipi_init_ack *msg)
 	 */
 	vpu->inst_id = 0xdeadbeef;
 
-	/* Firmware version field does not exist on MT8173. */
-	if (vpu->ctx->dev->vdec_pdata->chip == MTK_MT8173)
+	/* VPU firmware does not contain a version field. */
+	if (mtk_vcodec_fw_get_type(vpu->ctx->dev->fw_handler) == VPU)
 		return;
 
 	/* Check firmware version. */
diff --git a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
index e7899d8a3e4e..d3570c4c177d 100644
--- a/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
+++ b/drivers/media/platform/mtk-vcodec/venc_vpu_if.c
@@ -18,7 +18,7 @@ static void handle_enc_init_msg(struct venc_vpu_inst *vpu, const void *data)
 					     msg->vpu_inst_addr);
 
 	/* Firmware version field value is unspecified on MT8173. */
-	if (vpu->ctx->dev->venc_pdata->chip == MTK_MT8173)
+	if (mtk_vcodec_fw_get_type(vpu->ctx->dev->fw_handler) == VPU)
 		return;
 
 	/* Check firmware version. */
-- 
2.25.1

