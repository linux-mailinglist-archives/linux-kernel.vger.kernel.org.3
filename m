Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCCE544864
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242910AbiFIKIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242763AbiFIKIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:08:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378B25FC8;
        Thu,  9 Jun 2022 03:08:15 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AD97A66017CC;
        Thu,  9 Jun 2022 11:08:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654769293;
        bh=Plms5A1aPKPSw6D4rqzNZbSfoJtYh6ZPWxqrodjCyng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPu7vlTYqvPWk04niq1EAUwsL2W3fSGKAoBbW6zTm2JV9mwOV8aXa//KUFGWQaZxw
         7s9sYunRMusw/qp+ZxpiHTriyjgwjEt/xlqkrzOKckn8GuiYAHuqoUJYTVX8K2GdfJ
         3GNQYJjp9RFVOgsZG7JiC0VHrRnAUI3LoeErDsE3eQ7fCICH0xpYdx9hQhdE8uri2g
         slqkg2Tzkw/DFMnwgck0DA7dvY73eupKyozNYz/2OS56feC6lYMQOCRZCpm0FDf6Sy
         GY93oKQUTH3z54ZQl9UX+xhgKYppD8kbWauVYDcdMxSdSJ3dAqufFaLpu6bwQJdNTt
         0EjYwWP1HQ4Pw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve syscon to pericfg
Date:   Thu,  9 Jun 2022 12:08:02 +0200
Message-Id: <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some SoCs (of which only MT8195 is supported at the time of writing),
the "R" and "W" (I/O) enable bits for the IOMMUs are in the pericfg_ao
register space and not in the IOMMU space: as it happened already with
infracfg, it is expected that this list will grow.

Instead of specifying pericfg compatibles on a per-SoC basis, following
what was done with infracfg, let's lookup the syscon by phandle instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 90685946fcbe..0ea0848581e9 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -138,6 +138,8 @@
 /* PM and clock always on. e.g. infra iommu */
 #define PM_CLK_AO			BIT(15)
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
+/* IOMMU I/O (r/w) is enabled using PERICFG_IOMMU_1 register */
+#define HAS_PERI_IOMMU1_REG		BIT(17)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -187,7 +189,6 @@ struct mtk_iommu_plat_data {
 	u32			flags;
 	u32			inv_sel_reg;
 
-	char			*pericfg_comp_str;
 	struct list_head	*hw_list;
 	unsigned int		iova_region_nr;
 	const struct mtk_iommu_iova_region	*iova_region;
@@ -1218,14 +1219,16 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_runtime_disable;
 		}
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   data->plat_data->pericfg_comp_str) {
-		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
-		if (IS_ERR(infracfg)) {
-			ret = PTR_ERR(infracfg);
-			goto out_runtime_disable;
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
+		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
+		if (IS_ERR(data->pericfg)) {
+			p = "mediatek,mt8195-pericfg_ao";
+			data->pericfg = syscon_regmap_lookup_by_compatible(p);
+			if (IS_ERR(data->pericfg)) {
+				ret = PTR_ERR(data->pericfg);
+				goto out_runtime_disable;
+			}
 		}
-
-		data->pericfg = infracfg;
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -1484,8 +1487,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
 static const struct mtk_iommu_plat_data mt8195_data_infra = {
 	.m4u_plat	  = M4U_MT8195,
 	.flags            = WR_THROT_EN | DCM_DISABLE | STD_AXI_MODE | PM_CLK_AO |
-			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
-	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
+			    HAS_PERI_IOMMU1_REG | MTK_IOMMU_TYPE_INFRA |
+			    IFA_IOMMU_PCIE_SUPPORT,
 	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
 	.banks_num	  = 5,
 	.banks_enable     = {true, false, false, false, true},
-- 
2.35.1

