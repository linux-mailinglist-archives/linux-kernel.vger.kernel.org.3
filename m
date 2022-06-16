Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F1D54DFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbiFPLJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376717AbiFPLIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:08:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B065E159;
        Thu, 16 Jun 2022 04:08:44 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB0C66601756;
        Thu, 16 Jun 2022 12:08:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1655377723;
        bh=Ym8V4C7cqusZmnKUp44mYzfUNnjhU5hnhfnX8Zm9pqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NmtPN0WvcM9Ve1t1pov1LUxFbiFgFsHXn7r1U0/dBzpD2ev+nNt/AsBREsxoLTnvg
         1MXrkjTKKJ2o3BdglJrC/B/r0wtT7q/Bd1JOTv4SG0kt9axG22fWfGU61cHQUDFq8G
         sGjjCszu4KJdE/J7JzQ5U7AP45Msq8+2TkLltrtmxCq2CPMnRIMMDCGxZZhvAIbgFL
         wusIWrO6ZpaBFJOSF6Du39eqV3BaWwFAPhGtE3zlRKZHppx0Qy2rh6BvZ+aXB+DvyO
         0NXS43OHcFjvEcxekxmHDZwzuA/EpVcnhbEyBSPSDcEnjVvkMn9TpG8mtQelh9vn0T
         svphRSs2SqIIg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org, miles.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v4 5/5] iommu/mediatek: Cleanup pericfg lookup flow
Date:   Thu, 16 Jun 2022 13:08:30 +0200
Message-Id: <20220616110830.26037-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
References: <20220616110830.26037-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since only the INFRA type IOMMU needs to modify register(s) in the
pericfg iospace, it's safe to drop the pericfg_comp_str NULL check;
also, directly assign the regmap handle to data->pericfg instead of
to the infracfg variable to improve code readability.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 90685946fcbe..b2ae84046249 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1217,15 +1217,13 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 			dev_err(dev, "mm dts parse fail(%d).", ret);
 			goto out_runtime_disable;
 		}
-	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-		   data->plat_data->pericfg_comp_str) {
-		infracfg = syscon_regmap_lookup_by_compatible(data->plat_data->pericfg_comp_str);
-		if (IS_ERR(infracfg)) {
-			ret = PTR_ERR(infracfg);
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
+		p = data->plat_data->pericfg_comp_str;
+		data->pericfg = syscon_regmap_lookup_by_compatible(p);
+		if (IS_ERR(data->pericfg)) {
+			ret = PTR_ERR(data->pericfg);
 			goto out_runtime_disable;
 		}
-
-		data->pericfg = infracfg;
 	}
 
 	platform_set_drvdata(pdev, data);
-- 
2.35.1

