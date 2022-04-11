Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AAF4FB551
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 09:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245691AbiDKHwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 03:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245651AbiDKHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 03:51:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8872459B;
        Mon, 11 Apr 2022 00:49:36 -0700 (PDT)
X-UUID: 967323ce618e48e6be2fba20878afbb4-20220411
X-UUID: 967323ce618e48e6be2fba20878afbb4-20220411
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 530486425; Mon, 11 Apr 2022 15:49:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 11 Apr 2022 15:49:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Apr 2022 15:49:28 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "daoyuan huang" <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v15 6/6] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Mon, 11 Apr 2022 15:49:25 +0800
Message-ID: <20220411074925.25539-7-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220411074925.25539-1-moudy.ho@mediatek.com>
References: <20220411074925.25539-1-moudy.ho@mediatek.com>
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

Due to HW limitations, MDP3 is necessary to enable MUTEX in each frame
for SOF triggering and cooperate with CMDQ control to reduce the amount
of interrupts generated(also, reduce frame latency).

In response to the above situation, a new interface
"mtk_mutex_enable_by_cmdq" has been added to achieve the purpose.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 42 +++++++++++++++++++++++++-
 include/linux/soc/mediatek/mtk-mutex.h |  2 ++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index fc9ba2749946..1811beaf399d 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -7,10 +7,12 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/soc/mediatek/mtk-mutex.h>
+#include <linux/soc/mediatek/mtk-cmdq.h>
 
 #define MT2701_MUTEX0_MOD0			0x2c
 #define MT2701_MUTEX0_SOF0			0x30
@@ -176,6 +178,9 @@ struct mtk_mutex_ctx {
 	void __iomem			*regs;
 	struct mtk_mutex		mutex[10];
 	const struct mtk_mutex_data	*data;
+	phys_addr_t			addr;
+	struct cmdq_client_reg		cmdq_reg;
+	bool				has_gce_client_reg;
 };
 
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -618,6 +623,28 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_enable);
 
+void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex, void *pkt)
+{
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+	struct cmdq_pkt *cmdq_pkt = (struct cmdq_pkt *)pkt;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (!mtx->has_gce_client_reg) {
+		dev_dbg(mtx->dev, "mediatek,gce-client-reg hasn't been set in dts");
+		return;
+	}
+
+	cmdq_pkt_write(cmdq_pkt, mtx->cmdq_reg.subsys,
+		       mtx->addr + DISP_REG_MUTEX_EN(mutex->id), 1);
+#else
+	dev_err(mtx->dev, "Not support for enable MUTEX by CMDQ");
+#endif
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
+
 void mtk_mutex_disable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -656,7 +683,7 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
-	struct resource *regs;
+	struct resource *regs, addr;
 	int i;
 
 	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
@@ -677,6 +704,19 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_address_to_resource(dev->of_node, 0, &addr) < 0)
+		mtx->addr = 0L;
+	else
+		mtx->addr = addr.start;
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
+	else
+		mtx->has_gce_client_reg = true;
+#endif
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mtx->regs = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(mtx->regs)) {
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 200f4365c950..17eea55b6809 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -33,6 +33,8 @@ void mtk_mutex_set_mod(struct mtk_mutex *mutex,
 void mtk_mutex_set_sof(struct mtk_mutex *mutex,
 		       enum mtk_mutex_table_index idx);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
+void mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
+			      void *pkt);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id);
-- 
2.18.0

