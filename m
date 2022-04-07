Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625714F78EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiDGIGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242730AbiDGIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:05:50 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29B61B3F6B;
        Thu,  7 Apr 2022 01:02:22 -0700 (PDT)
X-UUID: 7ed996b0661e4a2eb3f2670fa6d65a6c-20220407
X-UUID: 7ed996b0661e4a2eb3f2670fa6d65a6c-20220407
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1775206421; Thu, 07 Apr 2022 16:02:13 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 7 Apr 2022 16:02:11 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Apr 2022 16:02:10 +0800
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
Subject: [PATCH v6 34/34] iommu/mediatek: mt8195: Enable multi banks for infra iommu
Date:   Thu, 7 Apr 2022 15:57:26 +0800
Message-ID: <20220407075726.17771-35-yong.wu@mediatek.com>
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

Enable the multi-bank functions for infra-iommu. We put PCIE in bank0
and USB in the last bank(bank4). and we don't use the other banks
currently, disable them.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 027bbbced80d..22c95ed78b3c 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1449,8 +1449,11 @@ static const struct mtk_iommu_plat_data mt8195_data_infra = {
 			    MTK_IOMMU_TYPE_INFRA | IFA_IOMMU_PCIE_SUPPORT,
 	.pericfg_comp_str = "mediatek,mt8195-pericfg_ao",
 	.inv_sel_reg      = REG_MMU_INV_SEL_GEN2,
-	.banks_num        = 1,
-	.banks_enable     = {true},
+	.banks_num	  = 5,
+	.banks_enable     = {true, false, false, false, true},
+	.banks_portmsk    = {[0] = GENMASK(19, 16),     /* PCIe */
+			     [4] = GENMASK(31, 20),     /* USB */
+			    },
 	.iova_region      = single_domain,
 	.iova_region_nr   = ARRAY_SIZE(single_domain),
 };
-- 
2.18.0

