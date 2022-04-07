Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A154F78DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbiDGIFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242800AbiDGIEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:04:45 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347D1680A0;
        Thu,  7 Apr 2022 01:02:05 -0700 (PDT)
X-UUID: ee5e79815f2742f892d40b9404a52670-20220407
X-UUID: ee5e79815f2742f892d40b9404a52670-20220407
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 430986515; Thu, 07 Apr 2022 16:01:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 7 Apr 2022 16:01:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:01:56 +0800
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
Subject: [PATCH v6 32/34] iommu/mediatek: Initialise/Remove for multi bank dev
Date:   Thu, 7 Apr 2022 15:57:24 +0800
Message-ID: <20220407075726.17771-33-yong.wu@mediatek.com>
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

The registers for each bank of the IOMMU base are in order, delta is
0x1000. Initialise the base for each bank.

For all the previous SoC, we only have bank0. thus use "do {} while()"
to allow bank0 always go.

When removing the device, Not always all the banks are initialised, it
depend on if there is masters for that bank.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 44 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index d42b3d35a36e..028dc642a31e 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -113,6 +113,7 @@
 #define F_MMU_INT_ID_PORT_ID(a)			(((a) >> 2) & 0x1f)
 
 #define MTK_PROTECT_PA_ALIGN			256
+#define MTK_IOMMU_BANK_SZ			0x1000
 
 #define PERICFG_IOMMU_1				0x714
 
@@ -1104,7 +1105,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	struct component_match  *match = NULL;
 	struct regmap		*infracfg;
 	void                    *protect;
-	int                     ret, banks_num;
+	int                     ret, banks_num, i = 0;
 	u32			val;
 	char                    *p;
 	struct mtk_iommu_bank_data *bank;
@@ -1145,27 +1146,36 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		data->enable_4GB = !!(val & F_DDR_4GB_SUPPORT_EN);
 	}
 
+	banks_num = data->plat_data->banks_num;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (resource_size(res) < banks_num * MTK_IOMMU_BANK_SZ) {
+		dev_err(dev, "banknr %d. res %pR is not enough.\n", banks_num, res);
+		return -EINVAL;
+	}
 	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	ioaddr = res->start;
 
-	banks_num = data->plat_data->banks_num;
 	data->bank = devm_kmalloc(dev, banks_num * sizeof(*data->bank), GFP_KERNEL);
 	if (!data->bank)
 		return -ENOMEM;
 
-	bank = &data->bank[0];
-	bank->id = 0;
-	bank->base = base;
-	bank->m4u_dom = NULL;
-	bank->irq = platform_get_irq(pdev, 0);
-	if (bank->irq < 0)
-		return bank->irq;
-	bank->parent_dev = dev;
-	bank->parent_data = data;
-	spin_lock_init(&bank->tlb_lock);
+	do {
+		if (!data->plat_data->banks_enable[i])
+			continue;
+		bank = &data->bank[i];
+		bank->id = i;
+		bank->base = base + i * MTK_IOMMU_BANK_SZ;
+		bank->m4u_dom = NULL;
+
+		bank->irq = platform_get_irq(pdev, i);
+		if (bank->irq < 0)
+			return bank->irq;
+		bank->parent_dev = dev;
+		bank->parent_data = data;
+		spin_lock_init(&bank->tlb_lock);
+	} while (++i < banks_num);
 
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_BCLK)) {
 		data->bclk = devm_clk_get(dev, "bclk");
@@ -1251,7 +1261,8 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 static int mtk_iommu_remove(struct platform_device *pdev)
 {
 	struct mtk_iommu_data *data = platform_get_drvdata(pdev);
-	struct mtk_iommu_bank_data *bank = &data->bank[0];
+	struct mtk_iommu_bank_data *bank;
+	int i;
 
 	iommu_device_sysfs_remove(&data->iommu);
 	iommu_device_unregister(&data->iommu);
@@ -1268,7 +1279,12 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 #endif
 	}
 	pm_runtime_disable(&pdev->dev);
-	devm_free_irq(&pdev->dev, bank->irq, bank);
+	for (i = 0; i < data->plat_data->banks_num; i++) {
+		bank = &data->bank[i];
+		if (!bank->m4u_dom)
+			continue;
+		devm_free_irq(&pdev->dev, bank->irq, bank);
+	}
 	return 0;
 }
 
-- 
2.18.0

