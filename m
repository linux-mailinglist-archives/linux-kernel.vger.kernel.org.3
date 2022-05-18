Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C6A52B6BE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiERKFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiERKFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:05:18 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF2B6FD31;
        Wed, 18 May 2022 03:05:17 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 34E7B1F44E09
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652868312;
        bh=A5k1VBFcKvGxrzqgH+3j6bGmcr4uqfHwo1Y08EGhiiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hxNE4pApZ8gh9Nj1TIILgEFkkMYNj8c5ZFBNhdR3LX1qK9xEJqpKrQlj6db7I6LE/
         xqZGZOlzU3Usnq6zer2AUyTJ0/mNbdFSwaT3/3KxVzrx6Bgpr/4rtXQsawOtTctRwd
         TG/32fPPLILxUCMYM+SRCUhzpSO1O/+3Iaj1DHLkw6nJ4n5q3qe0gqGtDzTO8z9ZUB
         KTVgGh9tupltX8Vl0D3HlJZoTculsbCa0yxgSHoqPdBRlfdJsSOOgT9uxveF5vS/FD
         fHLEh9xGmPR2HWr2kJJQ3iF+IDYFSfyplWGf8nnHKtzK3f2sc8H3kUKcoTvUEkMII6
         6rZry0GnZnZaw==
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
Subject: [PATCH v2 2/7] iommu: mtk_iommu: Lookup phandle to retrieve syscon to infracfg
Date:   Wed, 18 May 2022 12:04:58 +0200
Message-Id: <20220518100503.37279-3-angelogioacchino.delregno@collabora.com>
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

This driver will get support for more SoCs and the list of infracfg
compatibles is expected to grow: in order to prevent getting this
situation out of control and see a long list of compatible strings,
add support to retrieve a handle to infracfg's regmap through a
new "mediatek,infracfg" phandle.

In order to keep retrocompatibility with older devicetrees, the old
way is kept in place, but also a dev_warn() was added to advertise
this change in hope that the user will see it and eventually update
the devicetree if this is possible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 40 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 71b2ace74cd6..d16b95e71ded 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1134,22 +1134,34 @@ static int mtk_iommu_probe(struct platform_device *pdev)
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
+			dev_info(dev, "Cannot find phandle to mediatek,infracfg:"
+				      " Please update your devicetree.\n");
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

