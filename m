Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27C5465E25
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355795AbhLBGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:17:05 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49364 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355730AbhLBGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:16:53 -0500
X-UUID: 303ce383cfcf425cacb4f8a27d838ed4-20211202
X-UUID: 303ce383cfcf425cacb4f8a27d838ed4-20211202
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1159303233; Thu, 02 Dec 2021 14:13:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Dec 2021 14:13:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 14:13:24 +0800
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
        <srv_heupstream@mediatek.com>
Subject: [PATCH v10 2/4] soc: mediatek: mmsys: add support for ISP control
Date:   Thu, 2 Dec 2021 14:13:20 +0800
Message-ID: <20211202061322.19917-3-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211202061322.19917-1-moudy.ho@mediatek.com>
References: <20211202061322.19917-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds 8183 ISP settings in MMSYS domain and interface.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/soc/mediatek/mt8183-mmsys.h    |  26 ++++++
 drivers/soc/mediatek/mtk-mmsys.c       | 117 +++++++++++++++++++++++++
 drivers/soc/mediatek/mtk-mmsys.h       |   1 +
 include/linux/soc/mediatek/mtk-mmsys.h |  30 +++++++
 4 files changed, 174 insertions(+)

diff --git a/drivers/soc/mediatek/mt8183-mmsys.h b/drivers/soc/mediatek/mt8183-mmsys.h
index 48865973314d..afc98c4dac95 100644
--- a/drivers/soc/mediatek/mt8183-mmsys.h
+++ b/drivers/soc/mediatek/mt8183-mmsys.h
@@ -32,6 +32,18 @@
 #define MT8183_MDP_CCORR_SEL_IN			0xff0
 #define MT8183_MDP_CCORR_SOUT_SEL		0xff4
 
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
@@ -325,5 +337,19 @@ static const struct mtk_mmsys_routes mmsys_mt8183_mdp_routing_table[] = {
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
index 905847d6e16c..cfbf36e6e0ad 100644
--- a/drivers/soc/mediatek/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mtk-mmsys.c
@@ -58,6 +58,7 @@ static const struct mtk_mmsys_driver_data mt8183_mmsys_driver_data = {
 	.num_routes = ARRAY_SIZE(mmsys_mt8183_routing_table),
 	.mdp_routes = mmsys_mt8183_mdp_routing_table,
 	.mdp_num_routes = ARRAY_SIZE(mmsys_mt8183_mdp_routing_table),
+	.mdp_isp_ctrl = mmsys_mt8183_mdp_isp_ctrl_table,
 };
 
 static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
@@ -157,6 +158,122 @@ void mtk_mmsys_mdp_disconnect(struct device *dev, struct mmsys_cmdq_cmd *cmd,
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_mdp_disconnect);
 
+void mtk_mmsys_mdp_isp_ctrl(struct device *dev, struct mmsys_cmdq_cmd *cmd,
+			    enum mtk_mdp_comp_id id)
+{
+	struct mtk_mmsys *mmsys = dev_get_drvdata(dev);
+	const unsigned int *isp_ctrl = mmsys->data->mdp_isp_ctrl;
+	u32 reg;
+
+	WARN_ON(mmsys->subsys_id == 0);
+	/* Direct link */
+	if (id == MDP_COMP_CAMIN) {
+		/* Reset MDP_DL_ASYNC_TX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW0_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW0_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX]);
+		}
+
+		/* Reset MDP_DL_ASYNC_RX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW1_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW1_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX]);
+		}
+
+		/* Enable sof mode */
+		if (isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_NO_SOF_MODE]);
+		}
+	}
+
+	if (id == MDP_COMP_CAMIN2) {
+		/* Reset MDP_DL_ASYNC2_TX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW0_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW0_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_TX2]);
+		}
+
+		/* Reset MDP_DL_ASYNC2_RX */
+		if (isp_ctrl[ISP_REG_MMSYS_SW1_RST_B]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MMSYS_SW1_RST_B];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    0x0,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2]);
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2],
+					    isp_ctrl[ISP_BIT_MDP_DL_ASYNC_RX2]);
+		}
+
+		/* Enable sof mode */
+		if (isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
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
+	WARN_ON(mmsys->subsys_id == 0);
+	/* Config for direct link */
+	if (id == MDP_COMP_CAMIN) {
+		if (isp_ctrl[ISP_REG_MDP_ASYNC_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MDP_ASYNC_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+
+		if (isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_ISP_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+	}
+	if (id == MDP_COMP_CAMIN2) {
+		if (isp_ctrl[ISP_REG_MDP_ASYNC_IPU_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_MDP_ASYNC_IPU_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
+					    (camin_h << 16) + camin_w,
+					    0x3FFF3FFF);
+		}
+		if (isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD]) {
+			reg = mmsys->addr + isp_ctrl[ISP_REG_IPU_RELAY_CFG_WD];
+			cmdq_pkt_write_mask(cmd->pkt, mmsys->subsys_id, reg,
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
index 7ec2107b9823..61baec9409de 100644
--- a/drivers/soc/mediatek/mtk-mmsys.h
+++ b/drivers/soc/mediatek/mtk-mmsys.h
@@ -94,6 +94,7 @@ struct mtk_mmsys_driver_data {
 	const unsigned int num_routes;
 	const struct mtk_mmsys_routes *mdp_routes;
 	const unsigned int mdp_num_routes;
+	const unsigned int *mdp_isp_ctrl;
 };
 
 /*
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index c5a4d6b181ce..1938428369f2 100644
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
@@ -109,4 +132,11 @@ void mtk_mmsys_mdp_disconnect(struct device *dev,
 			      enum mtk_mdp_comp_id cur,
 			      enum mtk_mdp_comp_id next);
 
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

