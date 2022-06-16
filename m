Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC64C54D9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358626AbiFPFmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiFPFmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:42:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DEE1705F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:42:41 -0700 (PDT)
X-UUID: 154b863681f1476fa5d08220bb72f8ad-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:66cedaf5-38dc-4cd0-80b2-28736f358617,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:a2e0b248-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 154b863681f1476fa5d08220bb72f8ad-20220616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1800370144; Thu, 16 Jun 2022 13:42:34 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 16 Jun 2022 13:42:33 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 13:42:32 +0800
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Yong Wu" <yong.wu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: [PATCH v2 1/5] iommu/mediatek: Use dev_err_probe to mute probe_defer err log
Date:   Thu, 16 Jun 2022 13:41:59 +0800
Message-ID: <20220616054203.11365-2-yong.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220616054203.11365-1-yong.wu@mediatek.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mute the probe defer log:

[    2.654806] mtk-iommu 14018000.iommu: mm dts parse fail(-517).
[    2.656168] mtk-iommu 1c01f000.iommu: mm dts parse fail(-517).

Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow with the MM TYPE")
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 drivers/iommu/mtk_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index bb9dd92c9898..3b2489e8a6dd 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1204,7 +1204,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
 		ret = mtk_iommu_mm_dts_parse(dev, &match, data);
 		if (ret) {
-			dev_err(dev, "mm dts parse fail(%d).", ret);
+			dev_err_probe(dev, ret, "mm dts parse fail.");
 			goto out_runtime_disable;
 		}
 	} else if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_INFRA) &&
-- 
2.18.0

