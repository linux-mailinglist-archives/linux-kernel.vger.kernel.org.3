Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC0F54485D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242982AbiFIKI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiFIKIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:08:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41490624A;
        Thu,  9 Jun 2022 03:08:11 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3686C66017C8;
        Thu,  9 Jun 2022 11:08:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654769289;
        bh=7NH0zCAnj6DTlLIJ/fPDdoJP+dAMJTzS1hu071yicYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GyKAfIQh74M6E0tS7YI+WWQ8i656pqE/dLB+PGHHNhMJCyezDxe/wNPQTf6/Z1Lb6
         2nOCQ8aQAScMRdbalLEvlepTF4pmn+kYGgE+z9wo7GaA1j7ZTgfUZtTUCDRjtnd1ma
         xiPp1BQ9iM8iXzXh/qZy65LX8UXNXukkqgoeWsUofAN/8jwlGCSI1KOD9UxVRxcE2V
         +HpUPseyFCLwBBIAT5VfImJBx9zVRN6VanQ1fqtE0c3i7pW5Q//ovmvcJmuP8UGoNC
         UcoNwTeiCV2evdJxw8041q5e12xpGLvwPgZTVi7//4c2+RnClJy3RHqvcr0kYmoh4h
         5MX9E1q6M/9zw==
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
Subject: [PATCH v3 2/6] iommu: mtk_iommu: Lookup phandle to retrieve syscon to infracfg
Date:   Thu,  9 Jun 2022 12:07:58 +0200
Message-Id: <20220609100802.54513-3-angelogioacchino.delregno@collabora.com>
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

This driver will get support for more SoCs and the list of infracfg
compatibles is expected to grow: in order to prevent getting this
situation out of control and see a long list of compatible strings,
add support to retrieve a handle to infracfg's regmap through a
new "mediatek,infracfg" phandle.

In order to keep retrocompatibility with older devicetrees, the old
way is kept in place.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..90685946fcbe 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1140,22 +1140,32 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE)) {
-		switch (data->plat_data->m4u_plat) {
-		case M4U_MT2712:
-			p = "mediatek,mt2712-infracfg";
-			break;
-		case M4U_MT8173:
-			p = "mediatek,mt8173-infracfg";
-			break;
-		default:
-			p = NULL;
+		infracfg = syscon_regmap_lookup_by_phandle(dev->of_node, "mediatek,infracfg");
+		if (IS_ERR(infracfg)) {
+			/*
+			 * Legacy devicetrees will not specify a phandle to
+			 * mediatek,infracfg: in that case, we use the older
+			 * way to retrieve a syscon to infra.
+			 *
+			 * This is for retrocompatibility purposes only, hence
+			 * no more compatibles shall be added to this.
+			 */
+			switch (data->plat_data->m4u_plat) {
+			case M4U_MT2712:
+				p = "mediatek,mt2712-infracfg";
+				break;
+			case M4U_MT8173:
+				p = "mediatek,mt8173-infracfg";
+				break;
+			default:
+				p = NULL;
+			}
+
+			infracfg = syscon_regmap_lookup_by_compatible(p);
+			if (IS_ERR(infracfg))
+				return PTR_ERR(infracfg);
 		}
 
-		infracfg = syscon_regmap_lookup_by_compatible(p);
-
-		if (IS_ERR(infracfg))
-			return PTR_ERR(infracfg);
-
 		ret = regmap_read(infracfg, REG_INFRA_MISC, &val);
 		if (ret)
 			return ret;
-- 
2.35.1

