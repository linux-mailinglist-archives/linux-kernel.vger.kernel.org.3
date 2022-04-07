Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C474F78F9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiDGIDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242656AbiDGICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:02:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319415A228;
        Thu,  7 Apr 2022 01:00:33 -0700 (PDT)
X-UUID: be15bf2ca06a41be8c8577a6662dd7cf-20220407
X-UUID: be15bf2ca06a41be8c8577a6662dd7cf-20220407
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1698868561; Thu, 07 Apr 2022 16:00:28 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 7 Apr 2022 16:00:07 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:00:06 +0800
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
Subject: [PATCH v6 16/34] iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
Date:   Thu, 7 Apr 2022 15:57:08 +0800
Message-ID: <20220407075726.17771-17-yong.wu@mediatek.com>
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

Prepare for supporting INFRA_IOMMU, and APU_IOMMU later.

For Infra IOMMU/APU IOMMU, it doesn't have the "larb""port". thus, Use
the MM flag contain the MM_IOMMU special flow, Also, it moves a big
chunk code about parsing the mediatek,larbs into a function, this is
only needed for MM IOMMU. and all the current SoC are MM_IOMMU.

The device link between iommu consumer device and smi-larb device only
is needed in MM iommu case.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 212 ++++++++++++++++++++++----------------
 1 file changed, 121 insertions(+), 91 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 642949aad47e..b048986913b9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -138,6 +138,8 @@
 #define MTK_IOMMU_IS_TYPE(pdata, _x)	MTK_IOMMU_HAS_FLAG_MASK(pdata, _x,\
 							MTK_IOMMU_TYPE_MASK)
 
+#define MTK_INVALID_LARBID		MTK_LARB_NR_MAX
+
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
@@ -274,7 +276,7 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 {
 	struct mtk_iommu_data *data = dev_id;
 	struct mtk_iommu_domain *dom = data->m4u_dom;
-	unsigned int fault_larb, fault_port, sub_comm = 0;
+	unsigned int fault_larb = MTK_INVALID_LARBID, fault_port = 0, sub_comm = 0;
 	u32 int_state, regval, va34_32, pa34_32;
 	u64 fault_iova, fault_pa;
 	bool layer, write;
@@ -300,17 +302,19 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	pa34_32 = FIELD_GET(F_MMU_INVAL_PA_34_32_MASK, fault_iova);
 	fault_pa |= (u64)pa34_32 << 32;
 
-	fault_port = F_MMU_INT_ID_PORT_ID(regval);
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
-		fault_larb = F_MMU_INT_ID_COMM_ID(regval);
-		sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
-	} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
-		fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
-		sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
-	} else {
-		fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		fault_port = F_MMU_INT_ID_PORT_ID(regval);
+		if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_2BITS)) {
+			fault_larb = F_MMU_INT_ID_COMM_ID(regval);
+			sub_comm = F_MMU_INT_ID_SUB_COMM_ID(regval);
+		} else if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_SUB_COMM_3BITS)) {
+			fault_larb = F_MMU_INT_ID_COMM_ID_EXT(regval);
+			sub_comm = F_MMU_INT_ID_SUB_COMM_ID_EXT(regval);
+		} else {
+			fault_larb = F_MMU_INT_ID_LARB_ID(regval);
+		}
+		fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 	}
-	fault_larb = data->plat_data->larbid_remap[fault_larb][sub_comm];
 
 	if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
 			       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
@@ -374,19 +378,21 @@ static void mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 		larbid = MTK_M4U_TO_LARB(fwspec->ids[i]);
 		portid = MTK_M4U_TO_PORT(fwspec->ids[i]);
 
-		larb_mmu = &data->larb_imu[larbid];
+		if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+			larb_mmu = &data->larb_imu[larbid];
 
-		region = data->plat_data->iova_region + domid;
-		larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
+			region = data->plat_data->iova_region + domid;
+			larb_mmu->bank[portid] = upper_32_bits(region->iova_base);
 
-		dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
-			enable ? "enable" : "disable", dev_name(larb_mmu->dev),
-			portid, domid, larb_mmu->bank[portid]);
+			dev_dbg(dev, "%s iommu for larb(%s) port %d dom %d bank %d.\n",
+				enable ? "enable" : "disable", dev_name(larb_mmu->dev),
+				portid, domid, larb_mmu->bank[portid]);
 
-		if (enable)
-			larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
-		else
-			larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+			if (enable)
+				larb_mmu->mmu |= MTK_SMI_MMU_EN(portid);
+			else
+				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
+		}
 	}
 }
 
@@ -593,6 +599,9 @@ static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 
 	data = dev_iommu_priv_get(dev);
 
+	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+		return &data->iommu;
+
 	/*
 	 * Link the consumer device with the smi-larb device(supplier).
 	 * The device that connects with each a larb is a independent HW.
@@ -626,9 +635,11 @@ static void mtk_iommu_release_device(struct device *dev)
 		return;
 
 	data = dev_iommu_priv_get(dev);
-	larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
-	larbdev = data->larb_imu[larbid].dev;
-	device_link_remove(dev, larbdev);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		larbid = MTK_M4U_TO_LARB(fwspec->ids[0]);
+		larbdev = data->larb_imu[larbid].dev;
+		device_link_remove(dev, larbdev);
+	}
 
 	iommu_fwspec_free(dev);
 }
@@ -820,19 +831,77 @@ static const struct component_master_ops mtk_iommu_com_ops = {
 	.unbind		= mtk_iommu_unbind,
 };
 
+static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **match,
+				  struct mtk_iommu_data *data)
+{
+	struct device_node *larbnode, *smicomm_node;
+	struct platform_device *plarbdev;
+	struct device_link *link;
+	int i, larb_nr, ret;
+
+	larb_nr = of_count_phandle_with_args(dev->of_node, "mediatek,larbs", NULL);
+	if (larb_nr < 0)
+		return larb_nr;
+
+	for (i = 0; i < larb_nr; i++) {
+		u32 id;
+
+		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
+		if (!larbnode)
+			return -EINVAL;
+
+		if (!of_device_is_available(larbnode)) {
+			of_node_put(larbnode);
+			continue;
+		}
+
+		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
+		if (ret)/* The id is consecutive if there is no this property */
+			id = i;
+
+		plarbdev = of_find_device_by_node(larbnode);
+		if (!plarbdev) {
+			of_node_put(larbnode);
+			return -ENODEV;
+		}
+		if (!plarbdev->dev.driver) {
+			of_node_put(larbnode);
+			return -EPROBE_DEFER;
+		}
+		data->larb_imu[id].dev = &plarbdev->dev;
+
+		component_match_add_release(dev, match, component_release_of,
+					    component_compare_of, larbnode);
+	}
+
+	/* Get smi-common dev from the last larb. */
+	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
+	if (!smicomm_node)
+		return -EINVAL;
+
+	plarbdev = of_find_device_by_node(smicomm_node);
+	of_node_put(smicomm_node);
+	data->smicomm_dev = &plarbdev->dev;
+
+	link = device_link_add(data->smicomm_dev, dev,
+			       DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
+	if (!link) {
+		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int mtk_iommu_probe(struct platform_device *pdev)
 {
 	struct mtk_iommu_data   *data;
 	struct device           *dev = &pdev->dev;
-	struct device_node	*larbnode, *smicomm_node;
-	struct platform_device	*plarbdev;
-	struct device_link	*link;
 	struct resource         *res;
 	resource_size_t		ioaddr;
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     i, larb_nr, ret;
+	int                     ret;
 	u32			val;
 	char                    *p;
 
@@ -887,59 +956,12 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			return PTR_ERR(data->bclk);
 	}
 
-	larb_nr = of_count_phandle_with_args(dev->of_node,
-					     "mediatek,larbs", NULL);
-	if (larb_nr < 0)
-		return larb_nr;
-
-	for (i = 0; i < larb_nr; i++) {
-		u32 id;
-
-		larbnode = of_parse_phandle(dev->of_node, "mediatek,larbs", i);
-		if (!larbnode)
-			return -EINVAL;
-
-		if (!of_device_is_available(larbnode)) {
-			of_node_put(larbnode);
-			continue;
-		}
-
-		ret = of_property_read_u32(larbnode, "mediatek,larb-id", &id);
-		if (ret)/* The id is consecutive if there is no this property */
-			id = i;
-
-		plarbdev = of_find_device_by_node(larbnode);
-		if (!plarbdev) {
-			of_node_put(larbnode);
-			return -ENODEV;
-		}
-		if (!plarbdev->dev.driver) {
-			of_node_put(larbnode);
-			return -EPROBE_DEFER;
-		}
-		data->larb_imu[id].dev = &plarbdev->dev;
-
-		component_match_add_release(dev, &match, component_release_of,
-					    component_compare_of, larbnode);
-	}
-
-	/* Get smi-common dev from the last larb. */
-	smicomm_node = of_parse_phandle(larbnode, "mediatek,smi", 0);
-	if (!smicomm_node)
-		return -EINVAL;
-
-	plarbdev = of_find_device_by_node(smicomm_node);
-	of_node_put(smicomm_node);
-	data->smicomm_dev = &plarbdev->dev;
-
 	pm_runtime_enable(dev);
 
-	link = device_link_add(data->smicomm_dev, dev,
-			DL_FLAG_STATELESS | DL_FLAG_PM_RUNTIME);
-	if (!link) {
-		dev_err(dev, "Unable to link %s.\n", dev_name(data->smicomm_dev));
-		ret = -EINVAL;
-		goto out_runtime_disable;
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
+		if (ret)
+			goto out_runtime_disable;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -971,9 +993,11 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_list_del;
 	}
 
-	ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
-	if (ret)
-		goto out_bus_set_null;
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
+		if (ret)
+			goto out_bus_set_null;
+	}
 	return ret;
 
 out_bus_set_null:
@@ -984,7 +1008,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 out_sysfs_remove:
 	iommu_device_sysfs_remove(&data->iommu);
 out_link_remove:
-	device_link_remove(data->smicomm_dev, dev);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
+		device_link_remove(data->smicomm_dev, dev);
 out_runtime_disable:
 	pm_runtime_disable(dev);
 	return ret;
@@ -999,10 +1024,12 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	list_del(&data->list);
 
-	device_link_remove(data->smicomm_dev, &pdev->dev);
+	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
+		device_link_remove(data->smicomm_dev, &pdev->dev);
+		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	}
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
-	component_master_del(&pdev->dev, &mtk_iommu_com_ops);
 	return 0;
 }
 
@@ -1073,7 +1100,7 @@ static const struct dev_pm_ops mtk_iommu_pm_ops = {
 static const struct mtk_iommu_plat_data mt2712_data = {
 	.m4u_plat     = M4U_MT2712,
 	.flags        = HAS_4GB_MODE | HAS_BCLK | HAS_VLD_PA_RNG | SHARE_PGTABLE |
-			NOT_STD_AXI_MODE,
+			NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.hw_list      = &m4ulist,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
@@ -1084,7 +1111,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
 	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
-			 NOT_STD_AXI_MODE,
+			 NOT_STD_AXI_MODE | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
 	.iova_region   = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1093,7 +1120,8 @@ static const struct mtk_iommu_plat_data mt6779_data = {
 
 static const struct mtk_iommu_plat_data mt8167_data = {
 	.m4u_plat     = M4U_MT8167,
-	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
+	.flags        = RESET_AXI | HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
+			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1103,7 +1131,8 @@ static const struct mtk_iommu_plat_data mt8167_data = {
 static const struct mtk_iommu_plat_data mt8173_data = {
 	.m4u_plat     = M4U_MT8173,
 	.flags	      = HAS_4GB_MODE | HAS_BCLK | RESET_AXI |
-			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE,
+			HAS_LEGACY_IVRP_PADDR | NOT_STD_AXI_MODE |
+			MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1112,7 +1141,7 @@ static const struct mtk_iommu_plat_data mt8173_data = {
 
 static const struct mtk_iommu_plat_data mt8183_data = {
 	.m4u_plat     = M4U_MT8183,
-	.flags        = RESET_AXI,
+	.flags        = RESET_AXI | MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg  = REG_MMU_INV_SEL_GEN1,
 	.iova_region  = single_domain,
 	.iova_region_nr = ARRAY_SIZE(single_domain),
@@ -1122,7 +1151,8 @@ static const struct mtk_iommu_plat_data mt8183_data = {
 static const struct mtk_iommu_plat_data mt8192_data = {
 	.m4u_plat       = M4U_MT8192,
 	.flags          = HAS_BCLK | HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN |
-			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE,
+			  WR_THROT_EN | IOVA_34_EN | NOT_STD_AXI_MODE |
+			  MTK_IOMMU_TYPE_MM,
 	.inv_sel_reg    = REG_MMU_INV_SEL_GEN2,
 	.iova_region    = mt8192_multi_dom,
 	.iova_region_nr = ARRAY_SIZE(mt8192_multi_dom),
-- 
2.18.0

