Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E73F483F00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 10:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiADJRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 04:17:30 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48148 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229568AbiADJR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 04:17:26 -0500
X-UUID: 5b5b85acd161465bb2d86b8c045a9451-20220104
X-UUID: 5b5b85acd161465bb2d86b8c045a9451-20220104
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 268454181; Tue, 04 Jan 2022 17:17:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Tue, 4 Jan 2022 17:17:19 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Jan 2022 17:17:18 +0800
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
Subject: [PATCH v11 3/4] soc: mediatek: mutex: add support for MDP
Date:   Tue, 4 Jan 2022 17:17:11 +0800
Message-ID: <20220104091712.25670-4-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220104091712.25670-1-moudy.ho@mediatek.com>
References: <20220104091712.25670-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the purpose of module independence, related settings should be moved
from MDP to the corresponding driver.
This patch adds more 8183 MDP settings and interface.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 68 ++++++++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mutex.h |  3 ++
 2 files changed, 71 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 2ca55bb5a8be..64a4f79e432e 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -119,6 +119,18 @@
 #define MT8183_MUTEX_EOF_DSI0			(MT8183_MUTEX_SOF_DSI0 << 6)
 #define MT8183_MUTEX_EOF_DPI0			(MT8183_MUTEX_SOF_DPI0 << 6)
 
+#define MT8183_MUTEX_MDP_START			5
+#define MT8183_MUTEX_MDP_MOD_MASK		0x07FFFFFF
+#define MT8183_MUTEX_MDP_SOF_MASK		0x00000007
+#define MT8183_MUTEX_MOD_MDP_RDMA0		BIT(2)
+#define MT8183_MUTEX_MOD_MDP_RSZ0		BIT(4)
+#define MT8183_MUTEX_MOD_MDP_RSZ1		BIT(5)
+#define MT8183_MUTEX_MOD_MDP_TDSHP0		BIT(6)
+#define MT8183_MUTEX_MOD_MDP_WROT0		BIT(7)
+#define MT8183_MUTEX_MOD_MDP_WDMA		BIT(8)
+#define MT8183_MUTEX_MOD_MDP_AAL0		BIT(23)
+#define MT8183_MUTEX_MOD_MDP_CCORR0		BIT(24)
+
 struct mtk_mutex {
 	int id;
 	bool claimed;
@@ -139,6 +151,10 @@ struct mtk_mutex_data {
 	const unsigned int *mutex_sof;
 	const unsigned int mutex_mod_reg;
 	const unsigned int mutex_sof_reg;
+	const unsigned int *mutex_mdp_offset;
+	const unsigned int *mutex_mdp_mod;
+	const unsigned int mutex_mdp_mod_mask;
+	const unsigned int mutex_mdp_sof_mask;
 	const bool no_clk;
 };
 
@@ -226,6 +242,17 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
+static const unsigned int mt8183_mutex_mdp_mod[MDP_MAX_COMP_COUNT] = {
+	[MDP_COMP_RDMA0] = MT8183_MUTEX_MOD_MDP_RDMA0,
+	[MDP_COMP_RSZ0] = MT8183_MUTEX_MOD_MDP_RSZ0,
+	[MDP_COMP_RSZ1] = MT8183_MUTEX_MOD_MDP_RSZ1,
+	[MDP_COMP_TDSHP0] = MT8183_MUTEX_MOD_MDP_TDSHP0,
+	[MDP_COMP_WROT0] = MT8183_MUTEX_MOD_MDP_WROT0,
+	[MDP_COMP_WDMA] = MT8183_MUTEX_MOD_MDP_WDMA,
+	[MDP_COMP_AAL0] = MT8183_MUTEX_MOD_MDP_AAL0,
+	[MDP_COMP_CCORR0] = MT8183_MUTEX_MOD_MDP_CCORR0,
+};
+
 static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
@@ -264,6 +291,14 @@ static const unsigned int mt8183_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
 };
 
+/* indicate which mutex is used by each pipepline */
+static const unsigned int mt8183_mutex_mdp_offset[MDP_PIPE_MAX] = {
+	[MDP_PIPE_IMGI] = MT8183_MUTEX_MDP_START,
+	[MDP_PIPE_RDMA0] = MT8183_MUTEX_MDP_START + 1,
+	[MDP_PIPE_WPEI] = MT8183_MUTEX_MDP_START + 2,
+	[MDP_PIPE_WPEI2] = MT8183_MUTEX_MDP_START + 3
+};
+
 static const struct mtk_mutex_data mt2701_mutex_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -298,6 +333,10 @@ static const struct mtk_mutex_data mt8183_mutex_driver_data = {
 	.mutex_sof = mt8183_mutex_sof,
 	.mutex_mod_reg = MT8183_MUTEX0_MOD0,
 	.mutex_sof_reg = MT8183_MUTEX0_SOF0,
+	.mutex_mdp_offset = mt8183_mutex_mdp_offset,
+	.mutex_mdp_mod = mt8183_mutex_mdp_mod,
+	.mutex_mdp_mod_mask = MT8183_MUTEX_MDP_MOD_MASK,
+	.mutex_mdp_sof_mask = MT8183_MUTEX_MDP_SOF_MASK,
 	.no_clk = true,
 };
 
@@ -323,6 +362,21 @@ struct mtk_mutex *mtk_mutex_get(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_get);
 
+struct mtk_mutex *mtk_mutex_mdp_get(struct device *dev,
+				    enum mtk_mdp_pipe_id id)
+{
+	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
+	int i = mtx->data->mutex_mdp_offset[id];
+
+	if (!mtx->mutex[i].claimed) {
+		mtx->mutex[i].claimed = true;
+		return &mtx->mutex[i];
+	}
+
+	return ERR_PTR(-EBUSY);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_mdp_get);
+
 void mtk_mutex_put(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -442,6 +496,20 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
 
+u32 mtk_mutex_get_mdp_mod(struct mtk_mutex *mutex, enum mtk_mdp_comp_id id)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (mtx->data->mutex_mdp_mod)
+		return mtx->data->mutex_mdp_mod[id];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_get_mdp_mod);
+
 void mtk_mutex_enable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 6fe4ffbde290..b2608f4220ee 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -11,9 +11,12 @@ struct device;
 struct mtk_mutex;
 
 struct mtk_mutex *mtk_mutex_get(struct device *dev);
+struct mtk_mutex *mtk_mutex_mdp_get(struct device *dev,
+				    enum mtk_mdp_pipe_id id);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
+u32 mtk_mutex_get_mdp_mod(struct mtk_mutex *mutex, enum mtk_mdp_comp_id id);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
-- 
2.18.0

