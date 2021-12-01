Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E295C464B01
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbhLAJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:54:47 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48416 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348356AbhLAJy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:54:29 -0500
X-UUID: 5a3283146a6a4d8da7d26dd6fa7355df-20211201
X-UUID: 5a3283146a6a4d8da7d26dd6fa7355df-20211201
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1500848343; Wed, 01 Dec 2021 17:51:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Dec 2021 17:51:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 1 Dec 2021 17:51:03 +0800
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
Subject: [PATCH v9 4/7] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Wed, 1 Dec 2021 17:50:28 +0800
Message-ID: <20211201095031.31606-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211201095031.31606-1-moudy.ho@mediatek.com>
References: <20211201095031.31606-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering that some functions have timing requirements
in specific situation, this patch adds several interface that
operate registers by CMDQ.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 65 +++++++++++++++++++++++++-
 include/linux/soc/mediatek/mtk-mutex.h |  6 +++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index e5e6255f5b84..320d0b72c78d 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -7,10 +7,14 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/soc/mediatek/mtk-mutex.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
+
+#define MTK_MUTEX_ENABLE			BIT(0)
 
 #define MT2701_MUTEX0_MOD0			0x2c
 #define MT2701_MUTEX0_SOF0			0x30
@@ -155,6 +159,8 @@ struct mtk_mutex_ctx {
 	void __iomem			*regs;
 	struct mtk_mutex		mutex[10];
 	const struct mtk_mutex_data	*data;
+	phys_addr_t			addr;
+	u8				subsys_id;
 };
 
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -475,6 +481,25 @@ void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_remove_comp);
 
+void mtk_mutex_add_mod_by_cmdq(struct mtk_mutex *mutex, u32 mod,
+			       struct mmsys_cmdq_cmd *cmd)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	unsigned int offset;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	offset = DISP_REG_MUTEX_MOD(mtx->data->mutex_mod_reg, mutex->id);
+	cmdq_pkt_write_mask(cmd->pkt, mtx->subsys_id, mtx->addr + offset,
+			    mod, mtx->data->mutex_mdp_mod_mask);
+
+	offset = DISP_REG_MUTEX_SOF(mtx->data->mutex_sof_reg, mutex->id);
+	cmdq_pkt_write_mask(cmd->pkt, mtx->subsys_id, mtx->addr + offset,
+			    0, mtx->data->mutex_mdp_sof_mask);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_add_mod_by_cmdq);
+
 void mtk_mutex_enable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -486,6 +511,20 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_enable);
 
+void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
+			      struct mmsys_cmdq_cmd *cmd)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	cmdq_pkt_write_mask(cmd->pkt, mtx->subsys_id,
+			    mtx->addr + DISP_REG_MUTEX_EN(mutex->id),
+			    MTK_MUTEX_ENABLE, MTK_MUTEX_ENABLE);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
+
 void mtk_mutex_disable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -497,6 +536,20 @@ void mtk_mutex_disable(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_disable);
 
+void mtk_mutex_disable_by_cmdq(struct mtk_mutex *mutex,
+			       struct mmsys_cmdq_cmd *cmd)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	cmdq_pkt_write_mask(cmd->pkt, mtx->subsys_id,
+			    mtx->addr + DISP_REG_MUTEX_EN(mutex->id),
+			    0x0, MTK_MUTEX_ENABLE);
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_disable_by_cmdq);
+
 void mtk_mutex_acquire(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -524,7 +577,8 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
-	struct resource *regs;
+	struct cmdq_client_reg cmdq_reg;
+	struct resource *regs, addr;
 	int i;
 
 	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
@@ -545,6 +599,15 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
+		mtx->addr = 0L;
+	else
+		mtx->addr = addr.start;
+
+	if (cmdq_dev_get_client_reg(dev, &cmdq_reg, 0) != 0)
+		dev_info(dev, "cmdq subsys id has not been set\n");
+	mtx->subsys_id = cmdq_reg.subsys;
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mtx->regs = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(mtx->regs)) {
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 099ddb025d79..86c17c024d83 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -16,8 +16,14 @@ struct mtk_mutex *mtk_mutex_mdp_get(struct device *dev,
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
+void mtk_mutex_add_mod_by_cmdq(struct mtk_mutex *mutex, u32 mod,
+			       struct mmsys_cmdq_cmd *cmd);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
+void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
+			      struct mmsys_cmdq_cmd *cmd);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
+void mtk_mutex_disable_by_cmdq(struct mtk_mutex *mutex,
+			       struct mmsys_cmdq_cmd *cmd);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id);
 void mtk_mutex_unprepare(struct mtk_mutex *mutex);
-- 
2.18.0

