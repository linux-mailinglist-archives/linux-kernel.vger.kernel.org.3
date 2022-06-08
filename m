Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20ECD542B0C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 11:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbiFHJQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiFHJOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:14:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9729B1DAE5D;
        Wed,  8 Jun 2022 01:37:26 -0700 (PDT)
X-UUID: f5c1e9e9b2634d548c8b7d0de3b55509-20220608
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:1a601765-eea6-4ef0-9d17-adc775769923,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:1a601765-eea6-4ef0-9d17-adc775769923,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:b73a15e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:8f91e81df6c9,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: f5c1e9e9b2634d548c8b7d0de3b55509-20220608
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 265310191; Wed, 08 Jun 2022 16:37:21 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 8 Jun 2022 16:36:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 8 Jun 2022 16:36:02 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v2 7/9] remoteproc: mediatek: Add SCP core 1 as a rproc subdevice
Date:   Wed, 8 Jun 2022 16:35:51 +0800
Message-ID: <20220608083553.8697-8-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220608083553.8697-1-tinghan.shen@mediatek.com>
References: <20220608083553.8697-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the clock and SRAM power is controlled by SCP core 0, SCP core 1
has to be boot after SCP core 0. We use the rproc subdev to achieve this
purpose.

The watchdog timeout handler of SCP core 1 is added as part of the rproc
subdevice. This allows SCP core 0 to handle watchdog timeout coming from
SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |   9 +++
 drivers/remoteproc/mtk_scp.c    | 130 ++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 5582f4207fbf..67b41866a100 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -99,6 +99,14 @@ struct scp_ipi_desc {
 	void *priv;
 };
 
+struct scp_subdev_core {
+	struct rproc_subdev subdev;
+	struct mtk_scp *main_scp;
+	void (*scp_dual_wdt_timeout)(struct mtk_scp *scp, u32 scp_to_host);
+};
+
+#define to_subdev_core(d) container_of(d, struct scp_subdev_core, subdev)
+
 struct mtk_scp;
 
 struct mtk_scp_of_data {
@@ -144,6 +152,7 @@ struct mtk_scp {
 	size_t dram_size;
 
 	struct rproc_subdev *rpmsg_subdev;
+	struct rproc_subdev *dual_subdev;
 };
 
 /**
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index b8a4db581179..d0e9e19e251f 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -244,6 +244,13 @@ static void mt8195_scp_irq_handler(struct mtk_scp *scp)
 	} else {
 		if (readl(scp->reg_base + MT8195_SYS_STATUS) & MT8195_CORE1_WDT) {
 			writel(1, scp->reg_base + MT8195_CORE1_WDT_IRQ);
+
+			if (scp->dual_subdev) {
+				struct scp_subdev_core *subdev_core;
+
+				subdev_core = to_subdev_core(scp->dual_subdev);
+				subdev_core->scp_dual_wdt_timeout(scp, scp_to_host);
+			}
 		} else {
 			writel(1, scp->reg_base + MT8192_CORE0_WDT_IRQ);
 			scp_wdt_handler(scp, scp_to_host);
@@ -925,6 +932,118 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
+static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct device_node *np;
+	struct platform_device *dual_pdev;
+
+	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", 0);
+	dual_pdev = of_find_device_by_node(np);
+	of_node_put(np);
+
+	if (!dual_pdev) {
+		dev_err(dev, "No scp-dual pdev\n");
+		return NULL;
+	}
+
+	return platform_get_drvdata(dual_pdev);
+}
+
+static void scp_dual_put(struct mtk_scp *scp)
+{
+	put_device(scp->dev);
+}
+
+static int scp_dual_rproc_start(struct rproc_subdev *subdev)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+	struct mtk_scp *scp_dual;
+
+	scp_dual = scp_dual_get(subdev_core->main_scp);
+	if (!scp_dual)
+		return -ENODEV;
+
+	rproc_boot(scp_dual->rproc);
+	scp_dual_put(scp_dual);
+
+	return 0;
+}
+
+static void scp_dual_rproc_stop(struct rproc_subdev *subdev, bool crashed)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+	struct mtk_scp *scp_dual;
+
+	scp_dual = scp_dual_get(subdev_core->main_scp);
+	if (!scp_dual)
+		return;
+
+	rproc_shutdown(scp_dual->rproc);
+	scp_dual_put(scp_dual);
+}
+
+static void scp_dual_wdt_handler(struct mtk_scp *scp, u32 scp_to_host)
+{
+	struct mtk_scp *scp_dual;
+
+	scp_dual = scp_dual_get(scp);
+	if (!scp_dual)
+		return;
+
+	dev_err(scp_dual->dev, "SCP watchdog timeout! 0x%x\n", scp_to_host);
+	rproc_report_crash(scp_dual->rproc, RPROC_WATCHDOG);
+	scp_dual_put(scp_dual);
+}
+
+static struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct scp_subdev_core *subdev_core;
+	struct device_node *np;
+
+	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", 0);
+	if (!np)
+		return NULL;
+
+	of_node_put(np);
+
+	subdev_core = devm_kzalloc(dev, sizeof(*subdev_core), GFP_KERNEL);
+	if (!subdev_core)
+		return NULL;
+
+	subdev_core->main_scp = scp;
+	subdev_core->scp_dual_wdt_timeout = scp_dual_wdt_handler;
+	subdev_core->subdev.start = scp_dual_rproc_start;
+	subdev_core->subdev.stop = scp_dual_rproc_stop;
+
+	return &subdev_core->subdev;
+}
+
+static void scp_dual_destroy_subdev(struct rproc_subdev *subdev)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+
+	devm_kfree(subdev_core->main_scp->dev, subdev_core);
+}
+
+static void scp_add_dual_subdev(struct mtk_scp *scp)
+{
+	scp->dual_subdev = scp_dual_create_subdev(scp);
+
+	if (scp->dual_subdev)
+		rproc_add_subdev(scp->rproc, scp->dual_subdev);
+}
+
+static void scp_remove_dual_subdev(struct mtk_scp *scp)
+{
+	if (scp->dual_subdev) {
+		rproc_remove_subdev(scp->rproc, scp->dual_subdev);
+		scp_dual_destroy_subdev(scp->dual_subdev);
+		scp->dual_subdev = NULL;
+	}
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1014,6 +1133,9 @@ static int scp_probe(struct platform_device *pdev)
 
 	scp_add_rpmsg_subdev(scp);
 
+	if (core_id == SCP_CORE_0)
+		scp_add_dual_subdev(scp);
+
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
@@ -1023,6 +1145,12 @@ static int scp_probe(struct platform_device *pdev)
 		goto remove_subdev;
 	}
 
+	/* disable auto boot before register rproc.
+	 * scp core 1 is booted as a subdevice of scp core 0.
+	 */
+	if (core_id == SCP_CORE_1)
+		rproc->auto_boot = false;
+
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_subdev;
@@ -1030,6 +1158,7 @@ static int scp_probe(struct platform_device *pdev)
 	return 0;
 
 remove_subdev:
+	scp_remove_dual_subdev(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
@@ -1047,6 +1176,7 @@ static int scp_remove(struct platform_device *pdev)
 	int i;
 
 	rproc_del(scp->rproc);
+	scp_remove_dual_subdev(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
-- 
2.18.0

