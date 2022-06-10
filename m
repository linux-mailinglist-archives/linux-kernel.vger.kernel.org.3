Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A311D545E5F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbiFJIQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347258AbiFJIQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:16:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6509B21F992;
        Fri, 10 Jun 2022 01:16:33 -0700 (PDT)
X-UUID: 32c04f247ec44bc9a0663952ea7b68bd-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:9ce30446-ea2d-4c4b-881a-24324bd05b7d,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:0d9e61e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 32c04f247ec44bc9a0663952ea7b68bd-20220610
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 504504300; Fri, 10 Jun 2022 16:16:29 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with ShadowRedundancy id 15.2.792.3;
 Fri, 10 Jun 2022 08:15:41 +0000
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 14:34:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 10 Jun 2022 14:34:26 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <xiandong.wang@mediatek.com>,
        <randy.wu@mediatek.com>, <moudy.ho@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <cellopoint.kai@gmail.com>
Subject: [PATCH v20 6/6] soc: mediatek: mutex: add functions that operate registers by CMDQ
Date:   Fri, 10 Jun 2022 14:34:23 +0800
Message-ID: <20220610063424.7800-7-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220610063424.7800-1-moudy.ho@mediatek.com>
References: <20220610063424.7800-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=unavailable
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/soc/mediatek/mtk-mutex.c       | 45 +++++++++++++++++++++++++-
 include/linux/soc/mediatek/mtk-mutex.h |  2 ++
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index f8ea09a8bb5d..85fa7df7066d 100644
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
@@ -204,6 +206,8 @@ struct mtk_mutex_ctx {
 	void __iomem			*regs;
 	struct mtk_mutex		mutex[10];
 	const struct mtk_mutex_data	*data;
+	phys_addr_t			addr;
+	struct cmdq_client_reg		cmdq_reg;
 };
 
 static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
@@ -594,6 +598,30 @@ void mtk_mutex_enable(struct mtk_mutex *mutex)
 }
 EXPORT_SYMBOL_GPL(mtk_mutex_enable);
 
+int mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex, void *pkt)
+{
+	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
+						 mutex[mutex->id]);
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	struct cmdq_pkt *cmdq_pkt = (struct cmdq_pkt *)pkt;
+
+	WARN_ON(&mtx->mutex[mutex->id] != mutex);
+
+	if (!mtx->cmdq_reg.size) {
+		dev_err(mtx->dev, "mediatek,gce-client-reg hasn't been set");
+		return -EINVAL;
+	}
+
+	cmdq_pkt_write(cmdq_pkt, mtx->cmdq_reg.subsys,
+		       mtx->addr + DISP_REG_MUTEX_EN(mutex->id), 1);
+	return 0;
+#else
+	dev_err(mtx->dev, "Not support for enable MUTEX by CMDQ");
+	return -ENODEV;
+#endif
+}
+EXPORT_SYMBOL_GPL(mtk_mutex_enable_by_cmdq);
+
 void mtk_mutex_disable(struct mtk_mutex *mutex)
 {
 	struct mtk_mutex_ctx *mtx = container_of(mutex, struct mtk_mutex_ctx,
@@ -684,8 +712,11 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct mtk_mutex_ctx *mtx;
-	struct resource *regs;
+	struct resource *regs, addr;
 	int i;
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	int ret;
+#endif
 
 	mtx = devm_kzalloc(dev, sizeof(*mtx), GFP_KERNEL);
 	if (!mtx)
@@ -705,6 +736,18 @@ static int mtk_mutex_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (of_address_to_resource(dev->of_node, 0, &addr) < 0) {
+		dev_err(dev, "Failed to get addr\n");
+		return -EINVAL;
+	}
+	mtx->addr = addr.start;
+
+#if IS_REACHABLE(CONFIG_MTK_CMDQ)
+	ret = cmdq_dev_get_client_reg(dev, &mtx->cmdq_reg, 0);
+	if (ret)
+		dev_dbg(dev, "No mediatek,gce-client-reg!\n");
+#endif
+
 	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	mtx->regs = devm_ioremap_resource(dev, regs);
 	if (IS_ERR(mtx->regs)) {
diff --git a/include/linux/soc/mediatek/mtk-mutex.h b/include/linux/soc/mediatek/mtk-mutex.h
index 2ddab9d2b85d..a0f4f51a3b45 100644
--- a/include/linux/soc/mediatek/mtk-mutex.h
+++ b/include/linux/soc/mediatek/mtk-mutex.h
@@ -35,6 +35,8 @@ int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
 void mtk_mutex_enable(struct mtk_mutex *mutex);
+int mtk_mutex_enable_by_cmdq(struct mtk_mutex *mutex,
+			     void *pkt);
 void mtk_mutex_disable(struct mtk_mutex *mutex);
 void mtk_mutex_remove_comp(struct mtk_mutex *mutex,
 			   enum mtk_ddp_comp_id id);
-- 
2.18.0

