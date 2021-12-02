Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE7465E23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 07:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355762AbhLBGQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 01:16:57 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49310 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355715AbhLBGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 01:16:52 -0500
X-UUID: 129ec53cce814bf0bba03df662e9a610-20211202
X-UUID: 129ec53cce814bf0bba03df662e9a610-20211202
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 458286765; Thu, 02 Dec 2021 14:13:27 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Dec 2021 14:13:26 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Dec
 2021 14:13:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 14:13:25 +0800
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
Subject: [PATCH v10 4/4] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Thu, 2 Dec 2021 14:13:22 +0800
Message-ID: <20211202061322.19917-5-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211202061322.19917-1-moudy.ho@mediatek.com>
References: <20211202061322.19917-1-moudy.ho@mediatek.com>
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
index 5525c5dbfe8e..92a0e2bbd356 100644
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
@@ -164,6 +168,8 @@ struct mtk_mutex_ctx {
 	void __iomem			*regs;
 	struct mtk_mutex		mutex[10];
 	const struct mtk_mutex_data	*data;
+	phys_addr_t			addr;
+	u8				subsys_id;
 };
 
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -510,6 +516,25 @@ u32 mtk_mutex_get_mdp_mod(struct mtk_mutex *mutex,enum mtk_mdp_comp_id id)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_get_mdp_mod);
 
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
@@ -521,6 +546,20 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
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
@@ -532,6 +571,20 @@ void mtk_mutex_disable(struct mtk_mutex *mutex)
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
@@ -559,7 +612,8 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
-	struct resource *regs;
+	struct cmdq_client_reg cmdq_reg;
+	struct resource *regs, addr;
 	int i;
 
 	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
@@ -580,6 +634,15 @@ static int mtk_mutex_probe(struct platform_device *pdev)
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
index b2608f4220ee..05de7ad4a124 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -17,8 +17,14 @@ int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
 u32 mtk_mutex_get_mdp_mod(struct mtk_mutex *mutex, enum mtk_mdp_comp_id id);
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

