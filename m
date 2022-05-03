Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015D517EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiECHWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiECHWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:22:15 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC19338B2;
        Tue,  3 May 2022 00:18:23 -0700 (PDT)
X-UUID: 1e5074446f4d4ee48eeb635d9c2ab2e7-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:84aed189-11d5-4f82-9311-242b51055cff,OB:60,L
        OB:10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.4,REQID:84aed189-11d5-4f82-9311-242b51055cff,OB:60,LOB
        :10,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:100
X-CID-META: VersionHash:faefae9,CLOUDID:cbce4ac7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:641a58b95193,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: 1e5074446f4d4ee48eeb635d9c2ab2e7-20220503
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 878428207; Tue, 03 May 2022 15:18:16 +0800
Received: from MTKMBS07N2.mediatek.inc (172.21.101.141) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 15:18:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 May 2022 15:18:14 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:18:13 +0800
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
Subject: [PATCH v7 25/36] iommu/mediatek: Just move code position in hw_init
Date:   Tue, 3 May 2022 15:14:16 +0800
Message-ID: <20220503071427.2285-26-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
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

No functional change too, prepare for mt8195 IOMMU support bank functions.
Some global control settings are in bank0 while the other banks have
their bank independent setting. Here only move the global control
settings and the independent registers together.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 48 +++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index de448d056135..ac1681858af8 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -803,30 +803,6 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, data->base + REG_MMU_CTRL_REG);
 
-	regval = F_L2_MULIT_HIT_EN |
-		F_TABLE_WALK_FAULT_INT_EN |
-		F_PREETCH_FIFO_OVERFLOW_INT_EN |
-		F_MISS_FIFO_OVERFLOW_INT_EN |
-		F_PREFETCH_FIFO_ERR_INT_EN |
-		F_MISS_FIFO_ERR_INT_EN;
-	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
-
-	regval = F_INT_TRANSLATION_FAULT |
-		F_INT_MAIN_MULTI_HIT_FAULT |
-		F_INT_INVALID_PA_FAULT |
-		F_INT_ENTRY_REPLACEMENT_FAULT |
-		F_INT_TLB_MISS_FAULT |
-		F_INT_MISS_TRANSACTION_FIFO_FAULT |
-		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
-	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
-
-	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
-		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
-	else
-		regval = lower_32_bits(data->protect_base) |
-			 upper_32_bits(data->protect_base);
-	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
-
 	if (data->enable_4GB &&
 	    MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_VLD_PA_RNG)) {
 		/*
@@ -860,6 +836,30 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 	}
 	writel_relaxed(regval, data->base + REG_MMU_MISC_CTRL);
 
+	regval = F_L2_MULIT_HIT_EN |
+		F_TABLE_WALK_FAULT_INT_EN |
+		F_PREETCH_FIFO_OVERFLOW_INT_EN |
+		F_MISS_FIFO_OVERFLOW_INT_EN |
+		F_PREFETCH_FIFO_ERR_INT_EN |
+		F_MISS_FIFO_ERR_INT_EN;
+	writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
+
+	regval = F_INT_TRANSLATION_FAULT |
+		F_INT_MAIN_MULTI_HIT_FAULT |
+		F_INT_INVALID_PA_FAULT |
+		F_INT_ENTRY_REPLACEMENT_FAULT |
+		F_INT_TLB_MISS_FAULT |
+		F_INT_MISS_TRANSACTION_FIFO_FAULT |
+		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
+	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
+
+	if (MTK_IOMMU_HAS_FLAG(data->plat_data, HAS_LEGACY_IVRP_PADDR))
+		regval = (data->protect_base >> 1) | (data->enable_4GB << 31);
+	else
+		regval = lower_32_bits(data->protect_base) |
+			 upper_32_bits(data->protect_base);
+	writel_relaxed(regval, data->base + REG_MMU_IVRP_PADDR);
+
 	if (devm_request_irq(data->dev, data->irq, mtk_iommu_isr, 0,
 			     dev_name(data->dev), (void *)data)) {
 		writel_relaxed(0, data->base + REG_MMU_PT_BASE_ADDR);
-- 
2.18.0

