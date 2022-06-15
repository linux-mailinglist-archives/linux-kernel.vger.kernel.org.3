Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4FB54CE7C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355854AbiFOQTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355150AbiFOQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:19:35 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6F964E4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:19:30 -0700 (PDT)
X-UUID: c6ce86a7e4924f778e3432b46bd114ed-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:2f619c16-03a1-40cb-8808-48e50f43fe83,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:0baf9e48-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: c6ce86a7e4924f778e3432b46bd114ed-20220616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1508141498; Thu, 16 Jun 2022 00:19:27 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 00:19:26 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 16 Jun 2022 00:19:25 +0800
From:   <yf.wang@mediatek.com>
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        "Will Deacon" <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list" <linux-kernel@vger.kernel.org>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Yong Wu <Yong.Wu@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Yunfei Wang <yf.wang@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Subject: [PATCH v9 3/3] iommu/mediatek: Allow page table PA up to 35bit
Date:   Thu, 16 Jun 2022 00:12:23 +0800
Message-ID: <20220615161224.6923-4-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220615161224.6923-1-yf.wang@mediatek.com>
References: <20220615161224.6923-1-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunfei Wang <yf.wang@mediatek.com>

Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA. So add
the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT to let level 1 and level 2
pgtable support at most 35bit PA.

Signed-off-by: Ning Li <ning.li@mediatek.com>
Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 3d62399e8865..4dbc33758711 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -138,6 +138,7 @@
 /* PM and clock always on. e.g. infra iommu */
 #define PM_CLK_AO			BIT(15)
 #define IFA_IOMMU_PCIE_SUPPORT		BIT(16)
+#define PGTABLE_PA_35_EN		BIT(17)
 
 #define MTK_IOMMU_HAS_FLAG_MASK(pdata, _x, mask)	\
 				((((pdata)->flags) & (mask)) == (_x))
@@ -240,6 +241,7 @@ struct mtk_iommu_data {
 struct mtk_iommu_domain {
 	struct io_pgtable_cfg		cfg;
 	struct io_pgtable_ops		*iop;
+	u32				ttbr;
 
 	struct mtk_iommu_bank_data	*bank;
 	struct iommu_domain		domain;
@@ -596,6 +598,9 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_domain *dom,
 		.iommu_dev = data->dev,
 	};
 
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, PGTABLE_PA_35_EN))
+		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT;
+
 	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_4GB_MODE))
 		dom->cfg.oas = data->enable_4GB ? 33 : 32;
 	else
@@ -684,8 +689,8 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
 			goto err_unlock;
 		}
 		bank->m4u_dom = dom;
-		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       bank->base + REG_MMU_PT_BASE_ADDR);
+		bank->m4u_dom->ttbr = MTK_IOMMU_ADDR(dom->cfg.arm_v7s_cfg.ttbr);
+		writel(bank->m4u_dom->ttbr, data->base + REG_MMU_PT_BASE_ADDR);
 
 		pm_runtime_put(m4udev);
 	}
@@ -1366,8 +1371,7 @@ static int __maybe_unused mtk_iommu_runtime_resume(struct device *dev)
 		writel_relaxed(reg->int_control[i], base + REG_MMU_INT_CONTROL0);
 		writel_relaxed(reg->int_main_control[i], base + REG_MMU_INT_MAIN_CONTROL);
 		writel_relaxed(reg->ivrp_paddr[i], base + REG_MMU_IVRP_PADDR);
-		writel(m4u_dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
-		       base + REG_MMU_PT_BASE_ADDR);
+		writel(m4u_dom->ttbr, base + REG_MMU_PT_BASE_ADDR);
 	} while (++i < data->plat_data->banks_num);
 
 	/*
@@ -1401,7 +1405,7 @@ static const struct mtk_iommu_plat_data mt2712_data = {
 static const struct mtk_iommu_plat_data mt6779_data = {
 	.m4u_plat      = M4U_MT6779,
 	.flags         = HAS_SUB_COMM_2BITS | OUT_ORDER_WR_EN | WR_THROT_EN |
-			 MTK_IOMMU_TYPE_MM,
+			 MTK_IOMMU_TYPE_MM | PGTABLE_PA_35_EN,
 	.inv_sel_reg   = REG_MMU_INV_SEL_GEN2,
 	.banks_num    = 1,
 	.banks_enable = {true},
-- 
2.18.0

