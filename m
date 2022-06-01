Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34C853A3E2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352657AbiFALWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345586AbiFALWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:16 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957D42A24;
        Wed,  1 Jun 2022 04:22:14 -0700 (PDT)
X-UUID: a4126dcbe3b649c7b9a84fab0eb0fde8-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:525c2a77-01fc-47d8-b83d-f2341d3a7c8f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:94648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: a4126dcbe3b649c7b9a84fab0eb0fde8-20220601
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1957231; Wed, 01 Jun 2022 19:22:05 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:04 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
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
        "Enric Balletbo i Serra" <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 03/15] remoteproc: mediatek: Support hanlding scp core 1 wdt timeout
Date:   Wed, 1 Jun 2022 19:21:49 +0800
Message-ID: <20220601112201.15510-4-tinghan.shen@mediatek.com>
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

MT8195 SCP is a dual-core processor. The SCP core 1 watchdog timeout
interrupt uses the same interrupt line of SCP core 0 watchdog timeout
interrupt.

Add support for handling SCP core 1 watchdog timeout interrupt in the
SCP IRQ handler.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  4 ++++
 drivers/remoteproc/mtk_scp.c    | 27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index ea6fa1100a00..73e8adf00de3 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -54,6 +54,10 @@
 #define MT8192_CORE0_WDT_IRQ		0x10030
 #define MT8192_CORE0_WDT_CFG		0x10034
 
+#define MT8195_SYS_STATUS		0x4004
+#define MT8195_CORE0_WDT		BIT(16)
+#define MT8195_CORE1_WDT		BIT(17)
+
 #define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		GENMASK(7, 4)
 
 #define SCP_FW_VER_LEN			32
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 47b2a40e1b4a..3510c6d0bbc8 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -212,6 +212,31 @@ static void mt8192_scp_irq_handler(struct mtk_scp *scp)
 	}
 }
 
+static void mt8195_scp_irq_handler(struct mtk_scp *scp)
+{
+	u32 scp_to_host;
+
+	scp_to_host = readl(scp->reg_base + MT8192_SCP2APMCU_IPC_SET);
+
+	if (scp_to_host & MT8192_SCP_IPC_INT_BIT) {
+		scp_ipi_handler(scp);
+
+		/*
+		 * SCP won't send another interrupt until we clear
+		 * MT8192_SCP2APMCU_IPC.
+		 */
+		writel(MT8192_SCP_IPC_INT_BIT,
+		       scp->reg_base + MT8192_SCP2APMCU_IPC_CLR);
+	} else {
+		if (readl(scp->reg_base + MT8195_SYS_STATUS) & MT8195_CORE1_WDT) {
+			writel(1, scp->reg_base + MT8195_CORE1_WDT_IRQ);
+		} else {
+			writel(1, scp->reg_base + MT8192_CORE0_WDT_IRQ);
+			scp_wdt_handler(scp, scp_to_host);
+		}
+	}
+}
+
 static irqreturn_t scp_irq_handler(int irq, void *priv)
 {
 	struct mtk_scp *scp = priv;
@@ -961,7 +986,7 @@ static const struct mtk_scp_of_data mt8192_of_data = {
 static const struct mtk_scp_of_data mt8195_of_data = {
 	.scp_clk_get = mt8195_scp_clk_get,
 	.scp_before_load = mt8195_scp_before_load,
-	.scp_irq_handler = mt8192_scp_irq_handler,
+	.scp_irq_handler = mt8195_scp_irq_handler,
 	.scp_reset_assert = mt8192_scp_reset_assert,
 	.scp_reset_deassert = mt8192_scp_reset_deassert,
 	.scp_stop = mt8195_scp_stop,
-- 
2.18.0

