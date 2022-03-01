Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F364C88C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiCAKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232039AbiCAKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:03:41 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628934ECE0;
        Tue,  1 Mar 2022 02:02:56 -0800 (PST)
X-UUID: 42391c1e17b943e69cc2e2814998aaff-20220301
X-UUID: 42391c1e17b943e69cc2e2814998aaff-20220301
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 160602737; Tue, 01 Mar 2022 18:02:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 18:02:48 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 18:02:48 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <moudy.ho@mediatek.com>, <jason-jh.lin@mediatek.com>,
        <roy-cw.yeh@mediatek.com>, <river.cheng@mediatek.com>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v12 1/4] soc: mediatek: mmsys: add CMDQ write register function
Date:   Tue, 1 Mar 2022 18:02:43 +0800
Message-ID: <20220301100246.2153-2-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220301100246.2153-1-moudy.ho@mediatek.com>
References: <20220301100246.2153-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding the interface of writing MMSYS register via CMDQ,
users do not need to parse related dts information.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/Kconfig           |  1 +
 drivers/soc/mediatek/mtk-mmsys.c       | 30 ++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h       |  1 +
 include/linux/soc/mediatek/mtk-mmsys.h | 50 ++++++++++++++++++++++++++
 4 files changed, 82 insertions(+)

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index fdd8bc08569e..172bc7828aca 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -69,6 +69,7 @@ config MTK_MMSYS
 	bool "MediaTek MMSYS Support"
 	default ARCH_MEDIATEK
 	depends on HAS_IOMEM
+	select MTK_CMDQ
 	help
 	  Say yes here to add support for the MediaTek Multimedia
 	  Subsystem (MMSYS).
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 50c797d70ddd..04c0c7de395e 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -8,9 +8,11 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
 
 #include "mtk-mmsys.h"
 #include "mt8167-mmsys.h"
@@ -55,6 +57,7 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.clk_driver = "clk-mt8183-mm",
 	.routes = mmsys_mt8183_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
+	.has_gce_client_reg = true,
 };
 
 static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
@@ -81,6 +84,8 @@ struct mtk_mmsys {
 	const struct mtk_mmsys_driver_data *data;
 	spinlock_t lock; /* protects mmsys_sw_rst_b reg */
 	struct reset_controller_dev rcdev;
+	struct cmdq_client_reg cmdq_base;
+	phys_addr_t addr;
 };
 
 void mtk_mmsys_ddp_connect(struct device *dev,
@@ -120,6 +125,17 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
+void mtk_mmsys_write_reg_by_cmdq(struct device *dev,
+				 struct mmsys_cmdq_cmd *cmd,
+				 u32 offset, u32 value, u32 mask)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+
+	cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys,
+			    mmsys->addr + offset, value, mask);
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_write_reg_by_cmdq);
+
 static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
 				  bool assert)
 {
@@ -178,6 +194,7 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 	struct platform_device *clks;
 	struct platform_device *drm;
 	struct mtk_mmsys *mmsys;
+	struct resource res;
 	int ret;
 
 	mmsys = devm_kzalloc(dev, sizeof(*mmsys), GFP_KERNEL);
@@ -203,6 +220,19 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (of_address_to_resource(dev->of_node, 0, &res) < 0)
+		mmsys->addr = 0L;
+	else
+		mmsys->addr = res.start;
+
+	if (mmsys->data->has_gce_client_reg) {
+		ret = cmdq_dev_get_client_reg(dev, &mmsys->cmdq_base, 0);
+		if (ret) {
+			dev_err(dev, "No mediatek,gce-client-reg!\n");
+			return ret;
+		}
+	}
+
 	mmsys->data = of_device_get_match_data(&pdev->dev);
 	platform_set_drvdata(pdev, mmsys);
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 8b0ed05117ea..9fce400507d2 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -92,6 +92,7 @@ struct mtk_mmsys_driver_data {
 	const char *clk_driver;
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
+	bool has_gce_client_reg;
 };
 
 /*
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 4bba275e235a..7f8ecc98d023 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -7,8 +7,14 @@
 #define __MTK_MMSYS_H
 
 enum mtk_ddp_comp_id;
+enum mtk_mdp_comp_id;
 struct device;
 
+struct mmsys_cmdq_cmd {
+	struct cmdq_pkt *pkt;
+	s32 *event;
+};
+
 enum mtk_ddp_comp_id {
 	DDP_COMPONENT_AAL0,
 	DDP_COMPONENT_AAL1,
@@ -45,6 +51,46 @@ enum mtk_ddp_comp_id {
 	DDP_COMPONENT_ID_MAX,
 };
 
+enum mtk_mdp_comp_id {
+	MDP_COMP_NONE = -1,	/* Invalid engine */
+
+	/* ISP */
+	MDP_COMP_WPEI = 0,
+	MDP_COMP_WPEO,		/* 1 */
+	MDP_COMP_WPEI2,		/* 2 */
+	MDP_COMP_WPEO2,		/* 3 */
+	MDP_COMP_ISP_IMGI,	/* 4 */
+	MDP_COMP_ISP_IMGO,	/* 5 */
+	MDP_COMP_ISP_IMG2O,	/* 6 */
+
+	/* IPU */
+	MDP_COMP_IPUI,		/* 7 */
+	MDP_COMP_IPUO,		/* 8 */
+
+	/* MDP */
+	MDP_COMP_CAMIN,		/* 9 */
+	MDP_COMP_CAMIN2,	/* 10 */
+	MDP_COMP_RDMA0,		/* 11 */
+	MDP_COMP_AAL0,		/* 12 */
+	MDP_COMP_CCORR0,	/* 13 */
+	MDP_COMP_RSZ0,		/* 14 */
+	MDP_COMP_RSZ1,		/* 15 */
+	MDP_COMP_TDSHP0,	/* 16 */
+	MDP_COMP_COLOR0,	/* 17 */
+	MDP_COMP_PATH0_SOUT,	/* 18 */
+	MDP_COMP_PATH1_SOUT,	/* 19 */
+	MDP_COMP_WROT0,		/* 20 */
+	MDP_COMP_WDMA,		/* 21 */
+
+	/* Dummy Engine */
+	MDP_COMP_RDMA1,		/* 22 */
+	MDP_COMP_RSZ2,		/* 23 */
+	MDP_COMP_TDSHP1,	/* 24 */
+	MDP_COMP_WROT1,		/* 25 */
+
+	MDP_MAX_COMP_COUNT	/* ALWAYS keep at the end */
+};
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next);
@@ -53,4 +99,8 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 			      enum mtk_ddp_comp_id cur,
 			      enum mtk_ddp_comp_id next);
 
+void mtk_mmsys_write_reg_by_cmdq(struct device *dev,
+				 struct mmsys_cmdq_cmd *cmd,
+				 u32 alias_id, u32 value, u32 mask);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

