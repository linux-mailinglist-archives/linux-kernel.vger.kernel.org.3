Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45488576CFE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 11:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiGPJef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 05:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiGPJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 05:34:26 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4FC1EEDE;
        Sat, 16 Jul 2022 02:34:23 -0700 (PDT)
X-UUID: 47a8921a8c9e4c62b98ef013fbc89d44-20220716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:37490ffd-bf6f-439f-9a33-33c04a1d4236,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:0f94e32,CLOUDID:3d592433-b9e4-42b8-b28a-6364427c76bb,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 47a8921a8c9e4c62b98ef013fbc89d44-20220716
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 792323626; Sat, 16 Jul 2022 17:34:16 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sat, 16 Jul 2022 17:34:16 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Sat, 16 Jul 2022 17:34:15 +0800
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
Subject: [V5,4/8] media: mtk-jpegdec: add jpegdec timeout func interface
Date:   Sat, 16 Jul 2022 17:34:04 +0800
Message-ID: <20220716093408.29734-5-irui.wang@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716093408.29734-1-irui.wang@mediatek.com>
References: <20220716093408.29734-1-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RDNS_NONE,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kyrie wu <kyrie.wu@mediatek.com>

Generalizes jpegdec timeout func interfaces to handle HW timeout.

Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
Signed-off-by: irui wang <irui.wang@mediatek.com>

---
 .../platform/mediatek/jpeg/mtk_jpeg_core.h    |  2 ++
 .../platform/mediatek/jpeg/mtk_jpeg_dec_hw.c  | 24 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
index e2e670e58b82..ddfe2b4c48b3 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.h
@@ -169,6 +169,8 @@ struct mtk_jpegdec_comp_dev {
 	struct mtk_jpeg_dev *master_dev;
 	struct mtk_jpegdec_clk jdec_clk;
 	int jpegdec_irq;
+	struct delayed_work job_timeout_work;
+	struct mtk_jpeg_hw_param hw_param;
 };
 
 /**
diff --git a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
index 232e81165dd3..f3e885784afd 100644
--- a/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
+++ b/drivers/media/platform/mediatek/jpeg/mtk_jpeg_dec_hw.c
@@ -440,6 +440,25 @@ void mtk_jpeg_dec_set_config(void __iomem *base,
 }
 EXPORT_SYMBOL_GPL(mtk_jpeg_dec_set_config);
 
+static void mtk_jpegdec_timeout_work(struct work_struct *work)
+{
+	enum vb2_buffer_state buf_state = VB2_BUF_STATE_ERROR;
+	struct mtk_jpegdec_comp_dev *cjpeg =
+		container_of(work, struct mtk_jpegdec_comp_dev,
+			     job_timeout_work.work);
+	struct vb2_v4l2_buffer *src_buf, *dst_buf;
+
+	src_buf = cjpeg->hw_param.src_buffer;
+	dst_buf = cjpeg->hw_param.dst_buffer;
+	v4l2_m2m_buf_copy_metadata(src_buf, dst_buf, true);
+
+	mtk_jpeg_dec_reset(cjpeg->reg_base);
+	clk_disable_unprepare(cjpeg->jdec_clk.clks->clk);
+	pm_runtime_put(cjpeg->dev);
+	v4l2_m2m_buf_done(src_buf, buf_state);
+	v4l2_m2m_buf_done(dst_buf, buf_state);
+}
+
 static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 {
 	struct vb2_v4l2_buffer *src_buf, *dst_buf;
@@ -453,6 +472,8 @@ static irqreturn_t mtk_jpegdec_hw_irq_handler(int irq, void *priv)
 	struct mtk_jpegdec_comp_dev *jpeg = priv;
 	struct mtk_jpeg_dev *master_jpeg = jpeg->master_dev;
 
+	cancel_delayed_work(&jpeg->job_timeout_work);
+
 	irq_status = mtk_jpeg_dec_get_int_status(jpeg->reg_base);
 	dec_irq_ret = mtk_jpeg_dec_enum_result(irq_status);
 	if (dec_irq_ret >= MTK_JPEG_DEC_RESULT_UNDERFLOW)
@@ -540,6 +561,9 @@ static int mtk_jpegdec_hw_probe(struct platform_device *pdev)
 			master_dev->dec_hw_dev[i] = NULL;
 	}
 
+	INIT_DELAYED_WORK(&dev->job_timeout_work,
+			  mtk_jpegdec_timeout_work);
+
 	jpegdec_clk = &dev->jdec_clk;
 
 	jpegdec_clk->clk_num = devm_clk_bulk_get_all(&pdev->dev,
-- 
2.18.0

