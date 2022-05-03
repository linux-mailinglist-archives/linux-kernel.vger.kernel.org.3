Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B190D517E89
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbiECHWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiECHVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:21:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878FE2559E;
        Tue,  3 May 2022 00:17:50 -0700 (PDT)
X-UUID: f51f16b8bbae4285a023de54ba7952fb-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:9b5c8d9a-b600-4507-88e4-5718607d84b7,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:8cba822f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f51f16b8bbae4285a023de54ba7952fb-20220503
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 583513074; Tue, 03 May 2022 15:17:46 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 15:17:44 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:17:43 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
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
Subject: [PATCH v7 22/36] iommu/mediatek: Add PCIe support
Date:   Tue, 3 May 2022 15:14:13 +0800
Message-ID: <20220503071427.2285-23-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
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

Currently the code for of_iommu_configure_dev_id is like this:

static int of_iommu_configure_dev_id(struct device_node *master_np,
                                     struct device *dev,
                                     const u32 *id)
{
       struct of_phandle_args iommu_spec = { .args_count = 1 };

       err = of_map_id(master_np, *id, "iommu-map",
                       "iommu-map-mask", &iommu_spec.np,
                       iommu_spec.args);
...
}

It supports only one id output. BUT our PCIe HW has two ID(one is for
writing, the other is for reading). I'm not sure if we should change
of_map_id to support output MAX_PHANDLE_ARGS.

Here add the solution in ourselve drivers. If it's pcie case, enable one
more bit.

Not all infra iommu support PCIe, thus add a PCIe support flag here.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index ff48506b480c..d63fe28c1403 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -20,6 +20,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
+#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
@@ -134,6 +135,7 @@
 #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
 /* PM and clock always on. e.g. infra iommu */
 #define PM_CLK_AO			BIT(15)
+#define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -420,8 +422,11 @@ static int mtk_iommu_config(struct mtk_iommu_data *data, struct device *dev,
 				larb_mmu->mmu &= ~MTK_SMI_MMU_EN(portid);
 		} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA)) {
 			peri_mmuen_msk = BIT(portid);
-			peri_mmuen = enable ? peri_mmuen_msk : 0;
+			/* PCI dev has only one output id, enable the next writing bit for PCIe */
+			if (dev_is_pci(dev))
+				peri_mmuen_msk |= BIT(portid + 1);
 
+			peri_mmuen = enable ? peri_mmuen_msk : 0;
 			ret = regmap_update_bits(data->pericfg, PERICFG_IOMMU_1,
 						 peri_mmuen_msk, peri_mmuen);
 			if (ret)
@@ -1054,6 +1059,15 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		ret = component_master_add_with_match(dev, &mtk_iommu_com_ops, match);
 		if (ret)
 			goto out_bus_set_null;
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIE_SUPPORT)) {
+#ifdef CONFIG_PCI
+		if (!iommu_present(&pci_bus_type)) {
+			ret = bus_set_iommu(&pci_bus_type, &mtk_iommu_ops);
+			if (ret) /* PCIe fail don't affect platform_bus. */
+				goto out_list_del;
+		}
+#endif
 	}
 	return ret;
 
@@ -1084,6 +1098,11 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		device_link_remove(data->smicomm_dev, &pdev->dev);
 		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
+	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
+		   MTK_IOMMU_HAS_FLAG(data->plat_data, IFA_IOMMU_PCIE_SUPPORT)) {
+#ifdef CONFIG_PCI
+		bus_set_iommu(&pci_bus_type, NULL);
+#endif
 	}
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
-- 
2.18.0

