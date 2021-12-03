Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3C9467220
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350732AbhLCGot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 01:44:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40730 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350645AbhLCGos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 01:44:48 -0500
X-UUID: adff3507915f4b08a435aa6d364d88d7-20211203
X-UUID: adff3507915f4b08a435aa6d364d88d7-20211203
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1241112027; Fri, 03 Dec 2021 14:41:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 3 Dec 2021 14:41:20 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Fri, 3 Dec 2021 14:41:19 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tomasz Figa" <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <lc.kan@mediatek.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>
Subject: [PATCH 3/4] memory: mtk-smi: Add sleep ctrl function
Date:   Fri, 3 Dec 2021 14:40:26 +0800
Message-ID: <20211203064027.14993-4-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211203064027.14993-1-yong.wu@mediatek.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sleep control means that when the larb go to sleep, we should wait a bit
until all the current commands are finished. thus, when the larb runtime
suspend, we need enable this function to wait until all the existed
command are finished. when the larb resume, just disable this function.
This function only improve the safe of bus. Add a new flag for this
function. Prepare for mt8186.

Signed-off-by: Anan Sun <anan.sun@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/memory/mtk-smi.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index b883dcc0bbfa..4b59b28e4d73 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
@@ -32,6 +33,10 @@
 #define SMI_DUMMY			0x444
 
 /* SMI LARB */
+#define SMI_LARB_SLP_CON                0x00c
+#define SLP_PROT_EN                     BIT(0)
+#define SLP_PROT_RDY                    BIT(16)
+
 #define SMI_LARB_CMD_THRT_CON		0x24
 #define SMI_LARB_THRT_RD_NU_LMT_MSK	GENMASK(7, 4)
 #define SMI_LARB_THRT_RD_NU_LMT		(5 << 4)
@@ -81,6 +86,7 @@
 
 #define MTK_SMI_FLAG_THRT_UPDATE	BIT(0)
 #define MTK_SMI_FLAG_SW_FLAG		BIT(1)
+#define MTK_SMI_FLAG_SLEEP_CTL		BIT(2)
 #define MTK_SMI_CAPS(flags, _x)		(!!((flags) & (_x)))
 
 struct mtk_smi_reg_pair {
@@ -371,6 +377,24 @@ static const struct of_device_id mtk_smi_larb_of_ids[] = {
 	{}
 };
 
+static int mtk_smi_larb_sleep_ctrl(struct device *dev, bool to_sleep)
+{
+	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	int ret = 0;
+	u32 tmp;
+
+	if (to_sleep) {
+		writel_relaxed(SLP_PROT_EN, larb->base + SMI_LARB_SLP_CON);
+		ret = readl_poll_timeout_atomic(larb->base + SMI_LARB_SLP_CON,
+						tmp, !!(tmp & SLP_PROT_RDY), 10, 1000);
+		if (ret)
+			dev_warn(dev, "sleep ctrl is not ready(0x%x).\n", tmp);
+	} else {
+		writel_relaxed(0, larb->base + SMI_LARB_SLP_CON);
+	}
+	return ret;
+}
+
 static int mtk_smi_device_link_common(struct device *dev, struct device **com_dev)
 {
 	struct platform_device *smi_com_pdev;
@@ -477,24 +501,31 @@ static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
 	const struct mtk_smi_larb_gen *larb_gen = larb->larb_gen;
-	int ret;
+	int ret = 0;
 
 	ret = clk_bulk_prepare_enable(larb->smi.clk_num, larb->smi.clks);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
+	if (MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_SLEEP_CTL))
+		ret = mtk_smi_larb_sleep_ctrl(dev, false);
+
 	/* Configure the basic setting for this larb */
 	larb_gen->config_port(dev);
 
-	return 0;
+	return ret;
 }
 
 static int __maybe_unused mtk_smi_larb_suspend(struct device *dev)
 {
 	struct mtk_smi_larb *larb = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (MTK_SMI_CAPS(larb->larb_gen->flags_general, MTK_SMI_FLAG_SLEEP_CTL))
+		ret = mtk_smi_larb_sleep_ctrl(dev, true);
 
 	clk_bulk_disable_unprepare(larb->smi.clk_num, larb->smi.clks);
-	return 0;
+	return ret;
 }
 
 static const struct dev_pm_ops smi_larb_pm_ops = {
-- 
2.18.0

