Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3B4C88C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbiCAKDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiCAKDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:03:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622BF6005C;
        Tue,  1 Mar 2022 02:03:00 -0800 (PST)
X-UUID: d680cbefce634ffaa0697797ea939d13-20220301
X-UUID: d680cbefce634ffaa0697797ea939d13-20220301
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 591106217; Tue, 01 Mar 2022 18:02:51 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 1 Mar 2022 18:02:50 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Mar
 2022 18:02:49 +0800
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
Subject: [PATCH v12 2/4] soc: mediatek: mmsys: add support for ISP control
Date:   Tue, 1 Mar 2022 18:02:44 +0800
Message-ID: <20220301100246.2153-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220301100246.2153-1-moudy.ho@mediatek.com>
References: <20220301100246.2153-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 8183 ISP settings in MMSYS domain and interface.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8183-mmsys.h    |  26 ++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 115 +++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h       |   1 +
 include/linux/soc/mediatek/mtk-mmsys.h |  30 +++++++
 4 files changed, 172 insertions(+)

diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
index 9dee485807c9..179d5996c659 100644
--- a/drivers/soc/mediatek/mt8183-mmsys.h
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -13,6 +13,18 @@
 #define MT8183_DISP_RDMA0_SOUT_SEL_IN		0xf50
 #define MT8183_DISP_RDMA1_SOUT_SEL_IN		0xf54
 
+#define MT8183_ISP_REG_MMSYS_SW0_RST_B		0x140
+#define MT8183_ISP_REG_MMSYS_SW1_RST_B		0x144
+#define MT8183_ISP_REG_MDP_ASYNC_CFG_WD		0x934
+#define MT8183_ISP_REG_MDP_ASYNC_IPU_CFG_WD	0x93C
+#define MT8183_ISP_REG_ISP_RELAY_CFG_WD		0x994
+#define MT8183_ISP_REG_IPU_RELAY_CFG_WD		0x9a0
+#define MT8183_ISP_BIT_MDP_DL_ASYNC_TX		BIT(3)
+#define MT8183_ISP_BIT_MDP_DL_ASYNC_TX2		BIT(4)
+#define MT8183_ISP_BIT_MDP_DL_ASYNC_RX		BIT(10)
+#define MT8183_ISP_BIT_MDP_DL_ASYNC_RX2		BIT(11)
+#define MT8183_ISP_BIT_NO_SOF_MODE		BIT(31)
+
 #define MT8183_OVL0_MOUT_EN_OVL0_2L		BIT(4)
 #define MT8183_OVL0_2L_MOUT_EN_DISP_PATH0	BIT(0)
 #define MT8183_OVL1_2L_MOUT_EN_RDMA1		BIT(4)
@@ -57,5 +69,19 @@ static const struct mtk_mmsys_routes mmsys_mt8183_routing_table[] = {
 	}
 };
 
+static const unsigned int mmsys_mt8183_mdp_isp_ctrl_table[ISP_CTRL_MAX] = {
+	[ISP_REG_MMSYS_SW0_RST_B] = MT8183_ISP_REG_MMSYS_SW0_RST_B,
+	[ISP_REG_MMSYS_SW1_RST_B] = MT8183_ISP_REG_MMSYS_SW1_RST_B,
+	[ISP_REG_MDP_ASYNC_CFG_WD] = MT8183_ISP_REG_MDP_ASYNC_CFG_WD,
+	[ISP_REG_MDP_ASYNC_IPU_CFG_WD] = MT8183_ISP_REG_MDP_ASYNC_IPU_CFG_WD,
+	[ISP_REG_ISP_RELAY_CFG_WD] = MT8183_ISP_REG_ISP_RELAY_CFG_WD,
+	[ISP_REG_IPU_RELAY_CFG_WD] = MT8183_ISP_REG_IPU_RELAY_CFG_WD,
+	[ISP_BIT_MDP_DL_ASYNC_TX] = MT8183_ISP_BIT_MDP_DL_ASYNC_TX,
+	[ISP_BIT_MDP_DL_ASYNC_TX2] = MT8183_ISP_BIT_MDP_DL_ASYNC_TX2,
+	[ISP_BIT_MDP_DL_ASYNC_RX] = MT8183_ISP_BIT_MDP_DL_ASYNC_RX,
+	[ISP_BIT_MDP_DL_ASYNC_RX2] = MT8183_ISP_BIT_MDP_DL_ASYNC_RX2,
+	[ISP_BIT_NO_SOF_MODE] = MT8183_ISP_BIT_NO_SOF_MODE,
+};
+
 #endif /* __SOC_MEDIATEK_MT8183_MMSYS_H */
 
diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
index 04c0c7de395e..0e271d1a86e5 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -58,6 +58,7 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.routes = mmsys_mt8183_routing_table,
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 	.has_gce_client_reg = true,
+	.mdp_isp_ctrl = mmsys_mt8183_mdp_isp_ctrl_table,
 };
 
 static const struct mtk_mmsys_driver_data mt8186_mmsys_driver_data = {
@@ -136,6 +137,120 @@ void mtk_mmsys_write_reg_by_cmdq(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_write_reg_by_cmdq);
 
+void mtk_mmsys_mdp_isp_ctrl(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			    enum mtk_mdp_comp_id id)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+	const unsigned int *isp_ctrl = mmsys->data->mdp_isp_ctrl;
+	u32 reg;
+
+	/* Direct link */
+	if (id == MDP_COMP_CAMIN) {
+		/* Reset MDP_DL_ASYNC_TX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW0_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW0_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX]);
+		}
+
+		/* Reset MDP_DL_ASYNC_RX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW1_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW1_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX]);
+		}
+
+		/* Enable sof mode */
+		if (isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_NO_SOF_MODE]);
+		}
+	}
+
+	if (id == MDP_COMP_CAMIN2) {
+		/* Reset MDP_DL_ASYNC2_TX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW0_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW0_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2]);
+		}
+
+		/* Reset MDP_DL_ASYNC2_RX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW1_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW1_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2]);
+		}
+
+		/* Enable sof mode */
+		if (isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_NO_SOF_MODE]);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_mdp_isp_ctrl);
+
+void mtk_mmsys_mdp_camin_ctrl(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			      enum mtk_mdp_comp_id id, u32 camin_w, u32 camin_h)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+	const unsigned int *isp_ctrl = mmsys->data->mdp_isp_ctrl;
+	u32 reg;
+
+	/* Config for direct link */
+	if (id == MDP_COMP_CAMIN) {
+		if (isp_ctrl[ISP_REG_MDP_ASYNC_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MDP_ASYNC_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+
+		if (isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+	}
+	if (id == MDP_COMP_CAMIN2) {
+		if (isp_ctrl[ISP_REG_MDP_ASYNC_IPU_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MDP_ASYNC_IPU_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+		if (isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->cmdq_base.subsys, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_mmsys_mdp_camin_ctrl);
+
 static int mtk_mmsys_reset_update(struct reset_controller_dev *rcdev, unsigned long id,
 				  bool assert)
 {
diff --git a/drivers/soc/mediatek/mtk-mmsys.h b/drivers/soc/mediatek/mtk-mmsys.h
index 9fce400507d2..ad8b92389b54 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -93,6 +93,7 @@ struct mtk_mmsys_driver_data {
 	const struct mtk_mmsys_routes *routes;
 	const unsigned int num_routes;
 	bool has_gce_client_reg;
+	const unsigned int *mdp_isp_ctrl;
 };
 
 /*
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 7f8ecc98d023..45e77d1cd6c1 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -91,6 +91,29 @@ enum mtk_mdp_comp_id {
 	MDP_MAX_COMP_COUNT	/* ALWAYS keep at the end */
 };
 
+enum mtk_mdp_pipe_id {
+	MDP_PIPE_RDMA0,
+	MDP_PIPE_IMGI,
+	MDP_PIPE_WPEI,
+	MDP_PIPE_WPEI2,
+	MDP_PIPE_MAX
+};
+
+enum mtk_isp_ctrl {
+	ISP_REG_MMSYS_SW0_RST_B,
+	ISP_REG_MMSYS_SW1_RST_B,
+	ISP_REG_MDP_ASYNC_CFG_WD,
+	ISP_REG_MDP_ASYNC_IPU_CFG_WD,
+	ISP_REG_ISP_RELAY_CFG_WD,
+	ISP_REG_IPU_RELAY_CFG_WD,
+	ISP_BIT_MDP_DL_ASYNC_TX,
+	ISP_BIT_MDP_DL_ASYNC_TX2,
+	ISP_BIT_MDP_DL_ASYNC_RX,
+	ISP_BIT_MDP_DL_ASYNC_RX2,
+	ISP_BIT_NO_SOF_MODE,
+	ISP_CTRL_MAX
+};
+
 void mtk_mmsys_ddp_connect(struct device *dev,
 			   enum mtk_ddp_comp_id cur,
 			   enum mtk_ddp_comp_id next);
@@ -103,4 +126,11 @@ void mtk_mmsys_write_reg_by_cmdq(struct device *dev,
 				 struct mmsys_cmdq_cmd *cmd,
 				 u32 alias_id, u32 value, u32 mask);
 
+void mtk_mmsys_mdp_isp_ctrl(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			    enum mtk_mdp_comp_id id);
+
+void mtk_mmsys_mdp_camin_ctrl(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			      enum mtk_mdp_comp_id id,
+			      u32 camin_w, u32 camin_h);
+
 #endif /* __MTK_MMSYS_H */
-- 
2.18.0

