Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CEB4C4650
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbiBYN2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbiBYN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:28:30 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FA61A7DAC;
        Fri, 25 Feb 2022 05:27:57 -0800 (PST)
X-UUID: 3c33adf8969946cca74dfbcc264e8e64-20220225
X-UUID: 3c33adf8969946cca74dfbcc264e8e64-20220225
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <allen-kh.cheng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 587001712; Fri, 25 Feb 2022 21:27:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 25 Feb 2022 21:27:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 25 Feb 2022 21:27:50 +0800
From:   Allen-KH Cheng <allen-kh.cheng@mediatek.com>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Tinghan Shen <tinghan.shen@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Subject: [RESEND v5 2/2] remoteproc: mediatek: Support mt8186 scp
Date:   Fri, 25 Feb 2022 21:27:47 +0800
Message-ID: <20220225132747.31808-3-allen-kh.cheng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220225132747.31808-1-allen-kh.cheng@mediatek.com>
References: <20220225132747.31808-1-allen-kh.cheng@mediatek.com>
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

From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

Add SCP support for mt8186

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/remoteproc/mtk_common.h |  3 +++
 drivers/remoteproc/mtk_scp.c    | 35 +++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/remoteproc/mtk_common.h b/drivers/remoteproc/mtk_common.h
index 5ff3867c72f3..71ce4977cb0b 100644
--- a/drivers/remoteproc/mtk_common.h
+++ b/drivers/remoteproc/mtk_common.h
@@ -32,6 +32,9 @@
 #define MT8183_SCP_CACHESIZE_8KB	BIT(8)
 #define MT8183_SCP_CACHE_CON_WAYEN	BIT(10)
 
+#define MT8186_SCP_L1_SRAM_PD_P1	0x40B0
+#define MT8186_SCP_L1_SRAM_PD_p2	0x40B4
+
 #define MT8192_L2TCM_SRAM_PD_0		0x10C0
 #define MT8192_L2TCM_SRAM_PD_1		0x10C4
 #define MT8192_L2TCM_SRAM_PD_2		0x10C8
diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
index 36e48cf58ed6..6860ea4d5125 100644
--- a/drivers/remoteproc/mtk_scp.c
+++ b/drivers/remoteproc/mtk_scp.c
@@ -383,6 +383,27 @@ static void mt8192_power_off_sram(void __iomem *addr)
 		writel(GENMASK(i, 0), addr);
 }
 
+static int mt8186_scp_before_load(struct mtk_scp *scp)
+{
+	/* Clear SCP to host interrupt */
+	writel(MT8183_SCP_IPC_INT_BIT, scp->reg_base + MT8183_SCP_TO_HOST);
+
+	/* Reset clocks before loading FW */
+	writel(0x0, scp->reg_base + MT8183_SCP_CLK_SW_SEL);
+	writel(0x0, scp->reg_base + MT8183_SCP_CLK_DIV_SEL);
+
+	/* Turn on the power of SCP's SRAM before using it. Enable 1 block per time*/
+	mt8192_power_on_sram(scp->reg_base + MT8183_SCP_SRAM_PDN);
+
+	/* Initialize TCM before loading FW. */
+	writel(0x0, scp->reg_base + MT8183_SCP_L1_SRAM_PD);
+	writel(0x0, scp->reg_base + MT8183_SCP_TCM_TAIL_SRAM_PD);
+	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_P1);
+	writel(0x0, scp->reg_base + MT8186_SCP_L1_SRAM_PD_p2);
+
+	return 0;
+}
+
 static int mt8192_scp_before_load(struct mtk_scp *scp)
 {
 	/* clear SPM interrupt, SCP2SPM_IPC_CLR */
@@ -887,6 +908,19 @@ static const struct mtk_scp_of_data mt8183_of_data = {
 	.ipi_buf_offset = 0x7bdb0,
 };
 
+static const struct mtk_scp_of_data mt8186_of_data = {
+	.scp_clk_get = mt8195_scp_clk_get,
+	.scp_before_load = mt8186_scp_before_load,
+	.scp_irq_handler = mt8183_scp_irq_handler,
+	.scp_reset_assert = mt8183_scp_reset_assert,
+	.scp_reset_deassert = mt8183_scp_reset_deassert,
+	.scp_stop = mt8183_scp_stop,
+	.scp_da_to_va = mt8183_scp_da_to_va,
+	.host_to_scp_reg = MT8183_HOST_TO_SCP,
+	.host_to_scp_int_bit = MT8183_HOST_IPC_INT_BIT,
+	.ipi_buf_offset = 0x7bdb0,
+};
+
 static const struct mtk_scp_of_data mt8192_of_data = {
 	.scp_clk_get = mt8192_scp_clk_get,
 	.scp_before_load = mt8192_scp_before_load,
@@ -913,6 +947,7 @@ static const struct mtk_scp_of_data mt8195_of_data = {
 
 static const struct of_device_id mtk_scp_of_match[] = {
 	{ .compatible = "mediatek,mt8183-scp", .data = &mt8183_of_data },
+	{ .compatible = "mediatek,mt8186-scp", .data = &mt8186_of_data },
 	{ .compatible = "mediatek,mt8192-scp", .data = &mt8192_of_data },
 	{ .compatible = "mediatek,mt8195-scp", .data = &mt8195_of_data },
 	{},
-- 
2.18.0

