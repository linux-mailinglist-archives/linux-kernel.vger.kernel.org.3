Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F34F78ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242652AbiDGIF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242748AbiDGIFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:05:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B43A1AFEAE;
        Thu,  7 Apr 2022 01:02:12 -0700 (PDT)
X-UUID: 2be21ecd880d4ee69ad33003769323ff-20220407
X-UUID: 2be21ecd880d4ee69ad33003769323ff-20220407
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1658065705; Thu, 07 Apr 2022 16:02:07 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 7 Apr 2022 16:02:05 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:02:04 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <yong.wu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, <yen-chang.chen@mediatek.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>
Subject: [PATCH v6 33/34] iommu/mediatek: Backup/restore regsiters for multi banks
Date:   Thu, 7 Apr 2022 15:57:25 +0800
Message-ID: <20220407075726.17771-34-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
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

Each bank has some independent registers. thus backup/restore them for
each a bank when suspend and resume.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 46 ++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 028dc642a31e..027bbbced80d 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -173,11 +173,12 @@ struct mtk_iommu_suspend_reg {
 	u32			misc_ctrl;
 	u32			dcm_dis;
 	u32			ctrl_reg;
-	u32			int_control0;
-	u32			int_main_control;
-	u32			ivrp_paddr;
 	u32			vld_pa_rng;
 	u32			wr_len_ctrl;
+
+	u32			int_control[MTK_IOMMU_BANK_MAX];
+	u32			int_main_control[MTK_IOMMU_BANK_MAX];
+	u32			ivrp_paddr[MTK_IOMMU_BANK_MAX];
 };
 
 struct mtk_iommu_plat_data {
@@ -1292,16 +1293,23 @@ static int __maybe_unused mtk_iommu_runtime_suspend(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	void __iomem *base = data->bank[0].base;
+	void __iomem *base;
+	int i = 0;
 
+	base = data->bank[i].base;
 	reg->wr_len_ctrl = readl_relaxed(base + REG_MMU_WR_LEN_CTRL);
 	reg->misc_ctrl = readl_relaxed(base + REG_MMU_MISC_CTRL);
 	reg->dcm_dis = readl_relaxed(base + REG_MMU_DCM_DIS);
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
-	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
-	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
-	reg->ivrp_paddr = readl_relaxed(base + REG_MMU_IVRP_PADDR);
 	reg->vld_pa_rng = readl_relaxed(base + REG_MMU_VLD_PA_RNG);
+	do {
+		if (!data->plat_data->banks_enable[i])
+			continue;
+		base = data->bank[i].base;
+		reg->int_control[i] = readl_relaxed(base + REG_MMU_INT_CONTROL0);
+		reg->int_main_control[i] = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
+		reg->ivrp_paddr[i] = readl_relaxed(base + REG_MMU_IVRP_PADDR);
+	} while (++i < data->plat_data->banks_num);
 	clk_disable_unprepare(data->bclk);
 	return 0;
 }
@@ -1310,9 +1318,9 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 {
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
-	struct mtk_iommu_domain *m4u_dom = data->bank[0].m4u_dom;
-	void __iomem *base = data->bank[0].base;
-	int ret;
+	struct mtk_iommu_domain *m4u_dom;
+	void __iomem *base;
+	int ret, i = 0;
 
 	ret = clk_prepare_enable(data->bclk);
 	if (ret) {
@@ -1324,18 +1332,26 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 	 * Uppon first resume, only enable the clk and return, since the values of the
 	 * registers are not yet set.
 	 */
-	if (!m4u_dom)
+	if (!reg->wr_len_ctrl)
 		return 0;
 
+	base = data->bank[i].base;
 	writel_relaxed(reg->wr_len_ctrl, base + REG_MMU_WR_LEN_CTRL);
 	writel_relaxed(reg->misc_ctrl, base + REG_MMU_MISC_CTRL);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
-	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
-	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
-	writel_relaxed(reg->ivrp_paddr, base + REG_MMU_IVRP_PADDR);
 	writel_relaxed(reg->vld_pa_rng, base + REG_MMU_VLD_PA_RNG);
-	writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK, base + REG_MMU_PT_BASE_ADDR);
+	do {
+		m4u_dom = data->bank[i].m4u_dom;
+		if (!data->plat_data->banks_enable[i] || !m4u_dom)
+			continue;
+		base = data->bank[i].base;
+		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
+		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
+		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
+		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
+		       base + REG_MMU_PT_BASE_ADDR);
+	} while (++i < data->plat_data->banks_num);
 
 	/*
 	 * Users may allocate dma buffer before they call pm_runtime_get,
-- 
2.18.0

