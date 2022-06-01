Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3653A3D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352568AbiFALWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiFALWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1440A3D;
        Wed,  1 Jun 2022 04:22:11 -0700 (PDT)
X-UUID: 349b41b3ae254015962c4a30705fed52-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:4ac19da0-cc3d-44f0-85dc-b5f8ecc06041,OB:20,L
        OB:20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:4ac19da0-cc3d-44f0-85dc-b5f8ecc06041,OB:20,LOB
        :20,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,A
        CTION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:9a648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:63ea4881c016,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: 349b41b3ae254015962c4a30705fed52-20220601
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 672631603; Wed, 01 Jun 2022 19:22:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:06 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 12/15] remoteproc: mediatek: Add SCP core 1 as a rproc subdevice
Date:   Wed, 1 Jun 2022 19:21:58 +0800
Message-ID: <20220601112201.15510-13-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
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
 drivers/remoteproc/Makefile         |   2 +-
 drivers/remoteproc/mtk_common.h     |  12 +++
 drivers/remoteproc/mtk_scp.c        |  32 +++++++
 drivers/remoteproc/mtk_scp_dual.c   |   8 ++
 drivers/remoteproc/mtk_scp_subdev.c | 130 ++++++++++++++++++++++++++++
 5 files changed, 183 insertions(+), 1 deletion(-)
 create mode 100644 drivers/remoteproc/mtk_scp_subdev.c

diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
index 84cb687d28da..97f729f7c4ae 100644
--- a/drivers/remoteproc/Makefile
+++ b/drivers/remoteproc/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
 obj-$(CONFIG_IMX_DSP_REMOTEPROC)	+= imx_dsp_rproc.o
 obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
 obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
-obj-$(CONFIG_MTK_SCP_DUALCORE)		+= mtk_scp_dual.o
+obj-$(CONFIG_MTK_SCP_DUALCORE)		+= mtk_scp_dual.o mtk_scp_subdev.o
 obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
 obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
 obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 7b363411ec99..a5c26e56277d 100644
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
@@ -172,4 +181,7 @@ int scp_map_memory_region(struct mtk_scp *scp);
 void scp_unmap_memory_region(struct mtk_scp *scp);
 irqreturn_t scp_irq_handler(int irq, void *priv);
 void scp_ipi_handler(struct mtk_scp *scp);
+
+struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp);
+void scp_dual_destroy_subdev(struct rproc_subdev *subdev);
 #endif
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 55bc4e9d1a6f..c7bf0a44ba0d 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -231,6 +231,13 @@ static void mt8195_scp_irq_handler(struct mtk_scp *scp)
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
@@ -836,6 +843,27 @@ static void scp_remove_rpmsg_subdev(struct mtk_scp *scp)
 	}
 }
 
+static void scp_add_dual_subdev(struct mtk_scp *scp)
+{
+#if IS_ENABLED(CONFIG_MTK_SCP_DUALCORE)
+	scp->dual_subdev = scp_dual_create_subdev(scp);
+
+	if (scp->dual_subdev)
+		rproc_add_subdev(scp->rproc, scp->dual_subdev);
+#endif
+}
+
+static void scp_remove_dual_subdev(struct mtk_scp *scp)
+{
+#if IS_ENABLED(CONFIG_MTK_SCP_DUALCORE)
+	if (scp->dual_subdev) {
+		rproc_remove_subdev(scp->rproc, scp->dual_subdev);
+		scp_dual_destroy_subdev(scp->dual_subdev);
+		scp->dual_subdev = NULL;
+	}
+#endif
+}
+
 static int scp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -911,6 +939,8 @@ static int scp_probe(struct platform_device *pdev)
 
 	scp_add_rpmsg_subdev(scp);
 
+	scp_add_dual_subdev(scp);
+
 	ret = devm_request_threaded_irq(dev, platform_get_irq(pdev, 0), NULL,
 					scp_irq_handler, IRQF_ONESHOT,
 					pdev->name, scp);
@@ -927,6 +957,7 @@ static int scp_probe(struct platform_device *pdev)
 	return 0;
 
 remove_subdev:
+	scp_remove_dual_subdev(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 release_dev_mem:
@@ -944,6 +975,7 @@ static int scp_remove(struct platform_device *pdev)
 	int i;
 
 	rproc_del(scp->rproc);
+	scp_remove_dual_subdev(scp);
 	scp_remove_rpmsg_subdev(scp);
 	scp_ipi_unregister(scp, SCP_IPI_INIT);
 	scp_unmap_memory_region(scp);
diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index 4e8d7f5cdad6..90c49716dd39 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -258,6 +258,14 @@ static int scp_dual_probe(struct platform_device *pdev)
 		goto remove_ipi;
 	}
 
+	/* disable auto boot before register rproc.
+	 * it's booted as a subdevice of scp core 0.
+	 */
+	rproc->auto_boot = false;
+	ret = devm_rproc_add(dev, rproc);
+	if (ret)
+		goto remove_ipi;
+
 	return 0;
 
 remove_ipi:
diff --git a/drivers/remoteproc/mtk_scp_subdev.c b/drivers/remoteproc/mtk_scp_subdev.c
new file mode 100644
index 000000000000..197fb207c756
--- /dev/null
+++ b/drivers/remoteproc/mtk_scp_subdev.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2022 MediaTek Inc.
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+#include "mtk_common.h"
+
+#define SCP_MAIN_CORE 0
+#define SCP_DTS_CORE_ID 0
+#define SCP_DTS_CORE_REF 1
+
+static struct mtk_scp *scp_dual_get(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct device_node *np;
+	struct platform_device *dual_pdev;
+
+	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", SCP_DTS_CORE_REF);
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
+struct rproc_subdev *scp_dual_create_subdev(struct mtk_scp *scp)
+{
+	struct device *dev = scp->dev;
+	struct scp_subdev_core *subdev_core;
+	struct device_node *np;
+	int ret, core_id;
+
+	ret = of_property_read_u32_index(dev->of_node, "mediatek,scp-core", SCP_DTS_CORE_ID,
+					 &core_id);
+	if (ret < 0) {
+		dev_warn(dev, "No SCP core id\n");
+		return NULL;
+	}
+
+	if (core_id != SCP_MAIN_CORE) {
+		dev_dbg(dev, "SCP core id %d\n", core_id);
+		return NULL;
+	}
+
+	np = of_parse_phandle(dev->of_node, "mediatek,scp-core", SCP_DTS_CORE_REF);
+	if (!np) {
+		dev_err(dev, "Invalid mediatek,scp-core phandle\n");
+		return NULL;
+	}
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
+EXPORT_SYMBOL_GPL(scp_dual_create_subdev);
+
+void scp_dual_destroy_subdev(struct rproc_subdev *subdev)
+{
+	struct scp_subdev_core *subdev_core = to_subdev_core(subdev);
+
+	devm_kfree(subdev_core->main_scp->dev, subdev_core);
+}
+EXPORT_SYMBOL_GPL(scp_dual_destroy_subdev);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek scp dual core subdev interface");
-- 
2.18.0

