Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07BE4F787F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbiDGIBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242581AbiDGIBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:01:34 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51369156083;
        Thu,  7 Apr 2022 00:59:34 -0700 (PDT)
X-UUID: e37cc886cf394bdca35e91275cae0c2b-20220407
X-UUID: e37cc886cf394bdca35e91275cae0c2b-20220407
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1566800310; Thu, 07 Apr 2022 15:59:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 7 Apr 2022 15:59:27 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 15:59:26 +0800
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
Subject: [PATCH v6 10/34] iommu/mediatek: Add a flag DCM_DISABLE
Date:   Thu, 7 Apr 2022 15:57:02 +0800
Message-ID: <20220407075726.17771-11-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220407075726.17771-1-yong.wu@mediatek.com>
References: <20220407075726.17771-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the infra iommu, we should disable DCM. add a new flag for this.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d91a0c138536..92f172a772d1 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -51,6 +51,8 @@
 #define F_MMU_STANDARD_AXI_MODE_MASK		(BIT(3) | BIT(19))
 
 #define REG_MMU_DCM_DIS				0x050
+#define F_MMU_DCM				BIT(8)
+
 #define REG_MMU_WR_LEN_CTRL			0x054
 #define F_MMU_WR_THROT_DIS_MASK			(BIT(5) | BIT(21))
 
@@ -119,6 +121,7 @@
 #define HAS_LEGACY_IVRP_PADDR		BIT(7)
 #define IOVA_34_EN			BIT(8)
 #define SHARE_PGTABLE			BIT(9) /* 2 HW share pgtable */
+#define DCM_DISABLE			BIT(10)
 
 #define MTK_IOMMU_HAS_FLAG(pdata, _x) \
 		((((pdata)->flags) & (_x)) == (_x))
@@ -765,7 +768,11 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		regval = F_MMU_VLD_PA_RNG(7, 4);
 		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
 	}
-	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, DCM_DISABLE))
+		writel_relaxed(F_MMU_DCM, data->base + REG_MMU_DCM_DIS);
+	else
+		writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
+
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, WR_THROT_EN)) {
 		/* write command throttling mode */
 		regval = readl_relaxed(data->base + REG_MMU_WR_LEN_CTRL);
-- 
2.18.0

