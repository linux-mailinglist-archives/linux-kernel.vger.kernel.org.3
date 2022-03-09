Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD584D2E61
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbiCILs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCILsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:48:24 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF2E171EDA;
        Wed,  9 Mar 2022 03:47:21 -0800 (PST)
X-UUID: deca741a9de44af4903e34c783dfca40-20220309
X-UUID: deca741a9de44af4903e34c783dfca40-20220309
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 490752552; Wed, 09 Mar 2022 19:47:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 9 Mar 2022 19:47:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Mar 2022 19:47:15 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: [PATCH] remoteproc: mediatek: fix side effect of mt8195 sram power on
Date:   Wed, 9 Mar 2022 19:47:13 +0800
Message-ID: <20220309114713.8156-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.

L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.

L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
These bits have to be powered on to allow EMI access for SCP.

Bits[7:4] also affect audio DSP because audio DSP and SCP are
placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
blocked too.

L1TCM_SRAM_PDN bits[31:8] are not used.

This fix removes modification of bits[7:4] when power on/off mt8195 SCP
L1TCM. It's because the modification introduces a short period of time
blocking audio DSP to access EMI. This was not a problem until we have
to load both SCP module and audio DSP module. audio DSP needs to access
EMI because it has source/data on DRAM. Audio DSP will have unexpected
behavior when it accesses EMI and the SCP driver blocks the EMI path at
the same time.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_common.h |  4 +++
 drivers/remoteproc/mtk_scp.c    | 57 +++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 5ff3867c72f3..27e7172c926d 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -51,6 +51,10 @@
 #define MT8192_CORE0_WDT_IRQ		0x10030
 #define MT8192_CORE0_WDT_CFG		0x10034
 
+#define MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS		0xF0
+#define MT8195_L1TCM_SRAM_PDN_RESERVED_BITS \
+	MT8195_L1TCM_SRAM_PDN_RESERVED_RSI_BITS
+
 #define SCP_FW_VER_LEN			32
 #define SCP_SHARE_BUFFER_SIZE		288
 
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index dcddb33e9997..4d75af856fd1 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -365,22 +365,32 @@ static int mt8183_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
-static void mt8192_power_on_sram(void __iomem *addr)
+static void scp_sram_power_on(void __iomem *addr, u32 reserved_mask)
 {
 	int i;
 
 	for (i = 31; i >= 0; i--)
-		writel(GENMASK(i, 0), addr);
+		writel(GENMASK(i, 0) & ~reserved_mask, addr);
 	writel(0, addr);
 }
 
-static void mt8192_power_off_sram(void __iomem *addr)
+static void scp_sram_power_off(void __iomem *addr, u32 reserved_mask)
 {
 	int i;
 
 	writel(0, addr);
 	for (i = 0; i < 32; i++)
-		writel(GENMASK(i, 0), addr);
+		writel(GENMASK(i, 0) & ~reserved_mask, addr);
+}
+
+static void mt8192_power_on_sram(void __iomem *addr)
+{
+	scp_sram_power_on(addr, 0);
+}
+
+static void mt8192_power_off_sram(void __iomem *addr)
+{
+	scp_sram_power_off(addr, 0);
 }
 
 static int mt8192_scp_before_load(struct mtk_scp *scp)
@@ -403,6 +413,27 @@ static int mt8192_scp_before_load(struct mtk_scp *scp)
 	return 0;
 }
 
+static int mt8195_scp_before_load(struct mtk_scp *scp)
+{
+	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
+	writel(0xff, scp->reg_base + MT8192_SCP2SPM_IPC_CLR);
+
+	writel(1, scp->reg_base + MT8192_CORE0_SW_RSTN_SET);
+
+	/* enable SRAM clock */
+	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_0);
+	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_1);
+	mt8192_power_on_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_2);
+	scp_sram_power_on(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
+			  MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
+	mt8192_power_on_sram(scp->reg_base + MT8192_CPU0_SRAM_PD);
+
+	/* enable MPU for all memory regions */
+	writel(0xff, scp->reg_base + MT8192_CORE0_MEM_ATT_PREDEF);
+
+	return 0;
+}
+
 static int scp_load(struct rproc *rproc, const struct firmware *fw)
 {
 	struct mtk_scp *scp = rproc->priv;
@@ -561,6 +592,20 @@ static void mt8192_scp_stop(struct mtk_scp *scp)
 	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
 }
 
+static void mt8195_scp_stop(struct mtk_scp *scp)
+{
+	/* Disable SRAM clock */
+	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_0);
+	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_1);
+	mt8192_power_off_sram(scp->reg_base + MT8192_L2TCM_SRAM_PD_2);
+	scp_sram_power_off(scp->reg_base + MT8192_L1TCM_SRAM_PDN,
+			   MT8195_L1TCM_SRAM_PDN_RESERVED_BITS);
+	mt8192_power_off_sram(scp->reg_base + MT8192_CPU0_SRAM_PD);
+
+	/* Disable SCP watchdog */
+	writel(0, scp->reg_base + MT8192_CORE0_WDT_CFG);
+}
+
 static int scp_stop(struct rproc *rproc)
 {
 	struct mtk_scp *scp = (struct mtk_scp *)rproc->priv;
@@ -888,11 +933,11 @@ static const struct mtk_scp_of_data mt8192_of_data = {
 
 static const struct mtk_scp_of_data mt8195_of_data = {
 	.scp_clk_get = mt8195_scp_clk_get,
-	.scp_before_load = mt8192_scp_before_load,
+	.scp_before_load = mt8195_scp_before_load,
 	.scp_irq_handler = mt8192_scp_irq_handler,
 	.scp_reset_assert = mt8192_scp_reset_assert,
 	.scp_reset_deassert = mt8192_scp_reset_deassert,
-	.scp_stop = mt8192_scp_stop,
+	.scp_stop = mt8195_scp_stop,
 	.scp_da_to_va = mt8192_scp_da_to_va,
 	.host_to_scp_reg = MT8192_GIPC_IN_SET,
 	.host_to_scp_int_bit = MT8192_HOST_IPC_INT_BIT,
-- 
2.18.0

