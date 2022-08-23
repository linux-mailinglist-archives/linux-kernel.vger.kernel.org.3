Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAC959D12B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbiHWGTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbiHWGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:18:55 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F75F13DF2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:18:53 -0700 (PDT)
X-UUID: 43afc50180204ecd86b3ebd163c5ecb2-20220823
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=to1J31q+0yUGC7dO9OTi95xM6u2vTOh6on6nY2qkCbk=;
        b=oMeAdXPwNhQHaDEzF/H1NDS8B/w1l28v73dO3LpSRCgyhNka4OqUUE0WvT0E2jjJcJ7nf6lufvrhaNdNXJV+wFYyWXe1NHliy8XwkYUulHi48Zigl+qw+drc+futxJgrWTKyWcbGdt44q/faNxUE4VYc++mzlWBZLhph+uoV1og=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:918908b7-d5b8-4838-8e71-31e66ad36aed,OB:0,L
        OB:0,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Releas
        e_Ham,ACTION:release,TS:-25
X-CID-META: VersionHash:84eae18,CLOUDID:708d51cf-20bd-4e5e-ace8-00692b7ab380,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 43afc50180204ecd86b3ebd163c5ecb2-20220823
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1385553394; Tue, 23 Aug 2022 14:18:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 23 Aug 2022 14:18:46 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 23 Aug 2022 14:18:46 +0800
From:   <xinlei.lee@mediatek.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <rex-bc.chen@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <jason-jh.lin@mediatek.com>, <yongqiang.niu@mediatek.com>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3,2/2] drm: mediatek: Adjust the dpi output format to MT8186
Date:   Tue, 23 Aug 2022 14:18:37 +0800
Message-ID: <1661235517-23699-3-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1661235517-23699-1-git-send-email-xinlei.lee@mediatek.com>
References: <1661235517-23699-1-git-send-email-xinlei.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xinlei Lee <xinlei.lee@mediatek.com>

Dpi output needs to adjust the output format to dual edge for MT8186.
Because MT8186 HW has been modified at that time, SW needs to cooperate.
And the register (MMSYS) reserved for dpi will be used for output
format control (dual_edge/single_edge).

Co-developed-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

---
 drivers/gpu/drm/mediatek/mtk_dpi.c      | 31 +++++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dpi_regs.h |  4 ++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c  |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 630a4e301ef6..b66423bd7765 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -15,6 +15,7 @@
 #include <linux/of_graph.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/types.h>
 
 #include <video/videomode.h>
@@ -30,6 +31,7 @@
 #include "mtk_disp_drv.h"
 #include "mtk_dpi_regs.h"
 #include "mtk_drm_ddp_comp.h"
+#include "mtk_drm_drv.h"
 
 enum mtk_dpi_out_bit_num {
 	MTK_DPI_OUT_BIT_NUM_8BITS,
@@ -82,6 +84,7 @@ struct mtk_dpi {
 	struct pinctrl_state *pins_dpi;
 	u32 output_fmt;
 	int refcount;
+	struct device *mmsys_dev;
 };
 
 static inline struct mtk_dpi *bridge_to_dpi(struct drm_bridge *b)
@@ -135,6 +138,7 @@ struct mtk_dpi_yc_limit {
  * @yuv422_en_bit: Enable bit of yuv422.
  * @csc_enable_bit: Enable bit of CSC.
  * @pixels_per_iter: Quantity of transferred pixels per iteration.
+ * @rgb888_dual_enable: Control output format for mt8186.
  */
 struct mtk_dpi_conf {
 	unsigned int (*cal_factor)(int clock);
@@ -153,6 +157,7 @@ struct mtk_dpi_conf {
 	u32 yuv422_en_bit;
 	u32 csc_enable_bit;
 	u32 pixels_per_iter;
+	bool rgb888_dual_enable;
 };
 
 static void mtk_dpi_mask(struct mtk_dpi *dpi, u32 offset, u32 val, u32 mask)
@@ -449,6 +454,9 @@ static void mtk_dpi_dual_edge(struct mtk_dpi *dpi)
 		mtk_dpi_mask(dpi, DPI_OUTPUT_SETTING,
 			     dpi->output_fmt == MEDIA_BUS_FMT_RGB888_2X12_LE ?
 			     EDGE_SEL : 0, EDGE_SEL);
+	if (dpi->conf->rgb888_dual_enable)
+		mtk_mmsys_ddp_dpi_fmt_config(dpi->mmsys_dev, DPI_RGB888_DDR_CON,
+					     DPI_FORMAT_MASK, NULL);
 	} else {
 		mtk_dpi_mask(dpi, DPI_DDR_SETTING, DDR_EN | DDR_4PHASE, 0);
 	}
@@ -778,8 +786,10 @@ static int mtk_dpi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct mtk_dpi *dpi = dev_get_drvdata(dev);
 	struct drm_device *drm_dev = data;
+	struct mtk_drm_private *priv = drm_dev->dev_private;
 	int ret;
 
+	dpi->mmsys_dev = priv->mmsys_dev;
 	ret = drm_simple_encoder_init(drm_dev, &dpi->encoder,
 				      DRM_MODE_ENCODER_TMDS);
 	if (ret) {
@@ -930,6 +940,24 @@ static const struct mtk_dpi_conf mt8183_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8186_conf = {
+	.cal_factor = mt8183_calculate_factor,
+	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 150000,
+	.output_fmts = mt8183_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8183_output_fmts),
+	.rgb888_dual_enable = true,
+	.pixels_per_iter = 1,
+	.is_ck_de_pol = true,
+	.swap_input_support = true,
+	.support_direct_pin = true,
+	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
+};
+
 static const struct mtk_dpi_conf mt8192_conf = {
 	.cal_factor = mt8183_calculate_factor,
 	.reg_h_fre_con = 0xe0,
@@ -1080,6 +1108,9 @@ static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt8183-dpi",
 	  .data = &mt8183_conf,
 	},
+	{ .compatible = "mediatek,mt8186-dpi",
+	  .data = &mt8186_conf,
+	},
 	{ .compatible = "mediatek,mt8192-dpi",
 	  .data = &mt8192_conf,
 	},
diff --git a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
index 62bd4931b344..e5d254a2097b 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
+++ b/drivers/gpu/drm/mediatek/mtk_dpi_regs.h
@@ -235,4 +235,8 @@
 #define MATRIX_SEL_RGB_TO_JPEG		0
 #define MATRIX_SEL_RGB_TO_BT601		2
 
+#define DPI_FORMAT_MASK			0x1
+#define DPI_RGB888_DDR_CON		BIT(0)
+#define DPI_RGB565_SDR_CON		BIT(1)
+
 #endif /* __MTK_DPI_REGS_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index d72263c8a621..6cafbfa25d02 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -784,6 +784,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8183-dpi",
 	  .data = (void *)MTK_DPI },
+	{ .compatible = "mediatek,mt8186-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8192-dpi",
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8195-dp-intf",
-- 
2.18.0

