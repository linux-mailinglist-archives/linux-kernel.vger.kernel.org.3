Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2001752B6F9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbiERKFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbiERKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F247E6F4BB;
        Wed, 18 May 2022 03:05:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 083F11F44E0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868313;
        bh=jzNtgZkb9ZUDqbEgkSmucrQ5hqCWbZHhy8hNzMj2XCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RSm8VlR/wAkXXUyu0gDZ6NPI7QYwM97rHI7JWcFMigO3nQKyH9qCeDUgvPCamrn5x
         oG9DVcuX80Sl/fAiuJ/ohrcsUYzGxlvInw4de0rzfIySHPIxYKp+m1FxRmvFC+m4rc
         Ll4gO3qzCVgJO+51BZalQvAykzNrRmpdJd4E+2wX/SOoFpLzG32atEmW0MBGE53SyQ
         yNKpcvVncG+Lkcz4jHAeexkRmpnHQWRhqNnkgowBszwi1JGwmAqHhqPs4v/szydqbg
         XRLIBlxUnNLWPn1PtSb+tEo7gHwNTu0qFLJtcCOukae2vIzpiS4UGFIE2g3q9ZbNzr
         FZNKueUpDMBtA==
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
Subject: [PATCH v2 3/7] iommu: mtk_iommu: Lookup phandle to retrieve syscon to pericfg
Date:   Wed, 18 May 2022 12:04:59 +0200
Message-Id: <20220518100503.37279-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
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
Also following the previous infracfg change, add a warning for outdated
devicetrees, in hope that the user will take action.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d16b95e71ded..090cf6e15f85 100644
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
@@ -1214,14 +1215,19 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			goto out_runtime_disable;
 		}
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   data->plat_data->pericfg_comp_str) {
-		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
-		if (IS_ERR(infracfg)) {
-			ret = PTR_ERR(infracfg);
-			goto out_runtime_disable;
-		}
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_PERI_IOMMU1_REG)) {
+		data->pericfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,pericfg");
+		if (IS_ERR(data->pericfg)) {
+			dev_info(dev, "Cannot find phandle to mediatek,pericfg:"
+				      " Please update your devicetree.\n");
 
-		data->pericfg = infracfg;
+			p = "mediatek,mt8195-pericfg_ao";
+			data->pericfg = syscon_regmap_lookup_by_compatible(p);
+			if (IS_ERR(data->pericfg)) {
+				ret = PTR_ERR(data->pericfg);
+				goto out_runtime_disable;
+			}
+		}
 	}
 
 	platform_set_drvdata(pdev, data);
@@ -1480,8 +1486,8 @@ static const struct mtk_iommu_plat_data mt8192_data = {
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

