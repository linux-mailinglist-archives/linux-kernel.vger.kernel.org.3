Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F151517E53
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiECHTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiECHTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:19:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1C521819;
        Tue,  3 May 2022 00:15:42 -0700 (PDT)
X-UUID: f1835783fe404f39a47ceaf3e551c5fc-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:159bae67-ed95-4a69-9a33-670c37e3900d,OB:10,L
        OB:10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ha
        m,ACTION:release,TS:80
X-CID-INFO: VERSION:1.1.4,REQID:159bae67-ed95-4a69-9a33-670c37e3900d,OB:10,LOB
        :10,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3
        D,ACTION:quarantine,TS:80
X-CID-META: VersionHash:faefae9,CLOUDID:4fa7822f-6199-437e-8ab4-9920b4bc5b76,C
        OID:d2f05428c351,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,File:nil
        ,QS:0,BEC:nil
X-UUID: f1835783fe404f39a47ceaf3e551c5fc-20220503
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 492551616; Tue, 03 May 2022 15:15:36 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 15:15:35 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 May 2022 15:15:35 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 3 May 2022 15:15:34 +0800
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
Subject: [PATCH v7 06/36] iommu/mediatek: Remove clk_disable in mtk_iommu_remove
Date:   Tue, 3 May 2022 15:13:57 +0800
Message-ID: <20220503071427.2285-7-yong.wu@mediatek.com>
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

After the commit b34ea31fe013 ("iommu/mediatek: Always enable the clk on
resume"), the iommu clock is controlled by the runtime callback.
thus remove the clk control in the mtk_iommu_remove.

Otherwise, it will warning like:

echo 14018000.iommu > /sys/bus/platform/drivers/mtk-iommu/unbind

[   51.413044] ------------[ cut here ]------------
[   51.413648] vpp0_smi_iommu already disabled
[   51.414233] WARNING: CPU: 2 PID: 157 at */v5.15-rc1/kernel/mediatek/
                          drivers/clk/clk.c:952 clk_core_disable+0xb0/0xb8
[   51.417174] Hardware name: MT8195V/C(ENG) (DT)
[   51.418635] pc : clk_core_disable+0xb0/0xb8
[   51.419177] lr : clk_core_disable+0xb0/0xb8
...
[   51.429375] Call trace:
[   51.429694]  clk_core_disable+0xb0/0xb8
[   51.430193]  clk_core_disable_lock+0x24/0x40
[   51.430745]  clk_disable+0x20/0x30
[   51.431189]  mtk_iommu_remove+0x58/0x118
[   51.431705]  platform_remove+0x28/0x60
[   51.432197]  device_release_driver_internal+0x110/0x1f0
[   51.432873]  device_driver_detach+0x18/0x28
[   51.433418]  unbind_store+0xd4/0x108
[   51.433886]  drv_attr_store+0x24/0x38
[   51.434363]  sysfs_kf_write+0x40/0x58
[   51.434843]  kernfs_fop_write_iter+0x164/0x1e0

Fixes: b34ea31fe013 ("iommu/mediatek: Always enable the clk on resume")
Reported-by: Hsin-Yi Wang <hsinyi@chromium.org>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/iommu/mtk_iommu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index e4b4ebbcb73f..81b8db450eac 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -957,7 +957,6 @@ static int mtk_iommu_remove(struct platform_device *pdev)
 
 	list_del(&data->list);
 
-	clk_disable_unprepare(data->bclk);
 	device_link_remove(data->smicomm_dev, &pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	devm_free_irq(&pdev->dev, data->irq, data);
-- 
2.18.0

