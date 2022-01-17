Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC50049028F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237305AbiAQHGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:06:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46608 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S237299AbiAQHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:06:45 -0500
X-UUID: 69c02547177f428698ab72477c68ad7a-20220117
X-UUID: 69c02547177f428698ab72477c68ad7a-20220117
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1414581264; Mon, 17 Jan 2022 15:06:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 17 Jan 2022 15:06:39 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 15:06:37 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>
CC:     Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, Matthias Kaehlcke <mka@chromium.org>,
        <anan.sun@mediatek.com>, <yi.kuo@mediatek.com>,
        <acourbot@chromium.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Dafna Hirschfeld" <dafna.hirschfeld@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        <anthony.huang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rick Chang" <rick.chang@mediatek.com>,
        Xia Jiang <xia.jiang@mediatek.com>
Subject: [PATCH v10 06/13] media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
Date:   Mon, 17 Jan 2022 15:05:03 +0800
Message-ID: <20220117070510.17642-7-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220117070510.17642-1-yong.wu@mediatek.com>
References: <20220117070510.17642-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MediaTek IOMMU has already added device_link between the consumer
and smi-larb device. If the jpg device calls the pm_runtime_get_sync,
the smi-larb's pm_runtime_get_sync also be called automatically.

After removing the larb_get operations, then mtk_jpeg_clk_init is
also unnecessary. Remove it too.

CC: Rick Chang <rick.chang@mediatek.com>
CC: Xia Jiang <xia.jiang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: Evan Green <evgreen@chromium.org>
Acked-by: Rick Chang <rick.chang@mediatek.com>
Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Tested-by: Frank Wunderlich <frank-w@public-files.de> # BPI-R2/MT7623
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +------------------
 .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
 2 files changed, 2 insertions(+), 45 deletions(-)

diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
index af994b9913a6..1e29ca0aad77 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c
@@ -22,7 +22,6 @@
 #include <media/v4l2-ioctl.h>
 #include <media/videobuf2-core.h>
 #include <media/videobuf2-dma-contig.h>
-#include <soc/mediatek/smi.h>
 
 #include "mtk_jpeg_enc_hw.h"
 #include "mtk_jpeg_dec_hw.h"
@@ -1055,10 +1054,6 @@ static void mtk_jpeg_clk_on(struct mtk_jpeg_dev *jpeg)
 {
 	int ret;
 
-	ret = mtk_smi_larb_get(jpeg->larb);
-	if (ret)
-		dev_err(jpeg->dev, "mtk_smi_larb_get larbvdec fail %d\n", ret);
-
 	ret = clk_bulk_prepare_enable(jpeg->variant->num_clks,
 				      jpeg->variant->clks);
 	if (ret)
@@ -1069,7 +1064,6 @@ static void mtk_jpeg_clk_off(struct mtk_jpeg_dev *jpeg)
 {
 	clk_bulk_disable_unprepare(jpeg->variant->num_clks,
 				   jpeg->variant->clks);
-	mtk_smi_larb_put(jpeg->larb);
 }
 
 static irqreturn_t mtk_jpeg_enc_done(struct mtk_jpeg_dev *jpeg)
@@ -1284,35 +1278,6 @@ static struct clk_bulk_data mtk_jpeg_clocks[] = {
 	{ .id = "jpgenc" },
 };
 
-static int mtk_jpeg_clk_init(struct mtk_jpeg_dev *jpeg)
-{
-	struct device_node *node;
-	struct platform_device *pdev;
-	int ret;
-
-	node = of_parse_phandle(jpeg->dev->of_node, "mediatek,larb", 0);
-	if (!node)
-		return -EINVAL;
-	pdev = of_find_device_by_node(node);
-	if (WARN_ON(!pdev)) {
-		of_node_put(node);
-		return -EINVAL;
-	}
-	of_node_put(node);
-
-	jpeg->larb = &pdev->dev;
-
-	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
-				jpeg->variant->clks);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to get jpeg clock:%d\n", ret);
-		put_device(&pdev->dev);
-		return ret;
-	}
-
-	return 0;
-}
-
 static void mtk_jpeg_job_timeout_work(struct work_struct *work)
 {
 	struct mtk_jpeg_dev *jpeg = container_of(work, struct mtk_jpeg_dev,
@@ -1333,11 +1298,6 @@ static void mtk_jpeg_job_timeout_work(struct work_struct *work)
 	v4l2_m2m_job_finish(jpeg->m2m_dev, ctx->fh.m2m_ctx);
 }
 
-static inline void mtk_jpeg_clk_release(struct mtk_jpeg_dev *jpeg)
-{
-	put_device(jpeg->larb);
-}
-
 static int mtk_jpeg_probe(struct platform_device *pdev)
 {
 	struct mtk_jpeg_dev *jpeg;
@@ -1374,7 +1334,8 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 		goto err_req_irq;
 	}
 
-	ret = mtk_jpeg_clk_init(jpeg);
+	ret = devm_clk_bulk_get(jpeg->dev, jpeg->variant->num_clks,
+				jpeg->variant->clks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to init clk, err %d\n", ret);
 		goto err_clk_init;
@@ -1440,7 +1401,6 @@ static int mtk_jpeg_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&jpeg->v4l2_dev);
 
 err_dev_register:
-	mtk_jpeg_clk_release(jpeg);
 
 err_clk_init:
 
@@ -1458,7 +1418,6 @@ static int mtk_jpeg_remove(struct platform_device *pdev)
 	video_device_release(jpeg->vdev);
 	v4l2_m2m_release(jpeg->m2m_dev);
 	v4l2_device_unregister(&jpeg->v4l2_dev);
-	mtk_jpeg_clk_release(jpeg);
 
 	return 0;
 }
diff --git a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
index 595f7f10c9fd..3e4811a41ba2 100644
--- a/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
+++ b/drivers/media/platform/mtk-jpeg/mtk_jpeg_core.h
@@ -85,7 +85,6 @@ struct mtk_jpeg_variant {
  * @alloc_ctx:		videobuf2 memory allocator's context
  * @vdev:		video device node for jpeg mem2mem mode
  * @reg_base:		JPEG registers mapping
- * @larb:		SMI device
  * @job_timeout_work:	IRQ timeout structure
  * @variant:		driver variant to be used
  */
@@ -99,7 +98,6 @@ struct mtk_jpeg_dev {
 	void			*alloc_ctx;
 	struct video_device	*vdev;
 	void __iomem		*reg_base;
-	struct device		*larb;
 	struct delayed_work job_timeout_work;
 	const struct mtk_jpeg_variant *variant;
 };
-- 
2.18.0

