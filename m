Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE78547E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiFMDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiFMDX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:23:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33821837;
        Sun, 12 Jun 2022 20:23:19 -0700 (PDT)
X-UUID: 829c96e0207f4d4398c3dd12e991db92-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:27ea8ac0-2297-4933-916e-cd89fae44276,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:74587837-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 829c96e0207f4d4398c3dd12e991db92-20220613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 445946691; Mon, 13 Jun 2022 11:23:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 11:23:13 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Jun 2022 11:23:12 +0800
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
Subject: [V9,4/7] mtk-jpegenc: add jpegenc timeout func interface
Date:   Mon, 13 Jun 2022 11:23:03 +0800
Message-ID: <20220613032306.23237-5-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613032306.23237-1-irui.wang@mediatek.com>
References: <20220613032306.23237-1-irui.wang@mediatek.com>
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

Generalizes jpegenc timeout func interfaces to handle HW timeout.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  8 ++++++
 .../platform/mediatek/jpeg/mtk_jpeg_enc_hw.c  | 25 +++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index f6e980fde4ef..0683d80fcea5 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -76,6 +76,12 @@ struct mtk_jpeg_variant {
 	u32 cap_q_default_fourcc;
 };
 
+struct mtk_jpeg_hw_param {
+	struct vb2_v4l2_buffer *src_buffer;
+	struct vb2_v4l2_buffer *dst_buffer;
+	struct mtk_jpeg_ctx *curr_ctx;
+};
+
 enum mtk_jpegenc_hw_id {
 	MTK_JPEGENC_HW0,
 	MTK_JPEGENC_HW1,
@@ -107,6 +113,8 @@ struct mtk_jpegenc_comp_dev {
 	struct mtk_jpegenc_clk venc_clk;
 	int jpegenc_irq;
 	int hw_id;
+	struct delayed_work job_timeout_work;
+	struct mtk_jpeg_hw_param hw_param;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
index 8ac6b031dcd4..99f3db2a393a 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_enc_hw.c
@@ -185,6 +185,26 @@ void mtk_jpeg_set_enc_params(struct mtk_jpeg_ctx *ctx,  void __iomem *base)
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_set_enc_params);
 
+static void mtk_jpegenc_timeout_work(struct work_struct *work)
+{
+	struct delayed_work *dly_work = to_delayed_work(work);
+	struct mtk_jpegenc_comp_dev *cjpeg =
+		container_of(dly_work,
+			     struct mtk_jpegenc_comp_dev,
+			     job_timeout_work);
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+
+	src_buf = cjpeg->hw_param.src_buffer;
+	dst_buf = cjpeg->hw_param.dst_buffer;
+	dst_buf->vb2_buf.timestamp = src_buf->vb2_buf.timestamp;
+
+	mtk_jpeg_enc_reset(cjpeg->reg_base);
+	clk_disable_unprepare(cjpeg->venc_clk.clks->clk);
+	pm_runtime_put(cjpeg->dev);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+}
+
 static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 {
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
@@ -196,6 +216,8 @@ static irqreturn_t mtk_jpegenc_hw_irq_handler(int irq, void *priv)
 	struct mtk_jpegenc_comp_dev *jpeg = priv;
 	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
 
+	cancel_delayed_work(&jpeg->job_timeout_work);
+
 	irq_status = readl(jpeg->reg_base + JPEG_ENC_INT_STS) &
 		JPEG_ENC_INT_STATUS_MASK_ALLIRQ;
 	if (irq_status)
@@ -272,6 +294,9 @@ static int mtk_jpegenc_hw_probe(struct platform_device *pdev)
 	dev->plat_dev = pdev;
 	dev->dev = &pdev->dev;
 
+	INIT_DELAYED_WORK(&dev->job_timeout_work,
+			  mtk_jpegenc_timeout_work);
+
 	jpegenc_clk = &dev->venc_clk;
 
 	jpegenc_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
-- 
2.18.0

