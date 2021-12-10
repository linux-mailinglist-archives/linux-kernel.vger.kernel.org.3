Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DC34707B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244835AbhLJR4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:56:34 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:44656 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244808AbhLJR4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:56:14 -0500
X-UUID: fe157854d93f49da8b203f4f07e58695-20211211
X-UUID: fe157854d93f49da8b203f4f07e58695-20211211
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2043753425; Sat, 11 Dec 2021 01:52:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:52:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:52:35 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        JB Tsai <jb.tsai@mediatek.com>
Subject: [PATCH 06/12] soc: mediatek: apu: Add MT8195 APU power driver
Date:   Sat, 11 Dec 2021 01:52:17 +0800
Message-ID: <20211210175223.31131-7-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210175223.31131-1-flora.fu@mediatek.com>
References: <20211210175223.31131-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add APU power driver for MT8195 to support for
subsys clock and regulator controller.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 drivers/soc/mediatek/apusys/apu-pwr.c | 34 ++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/apusys/apu-pwr.c b/drivers/soc/mediatek/apusys/apu-pwr.c
index e8e54a767aff..73e08b442558 100644
--- a/drivers/soc/mediatek/apusys/apu-pwr.c
+++ b/drivers/soc/mediatek/apusys/apu-pwr.c
@@ -578,10 +578,25 @@ static struct apupwr_plat_data mt8192_apu_power_data = {
 	.ops = &mt8192_pwr_ops,
 };
 
+static const struct apupwr_plat_reg mt8195_pwr_reg = {
+	.opp_user = 0x40,
+	.opp_thermal = 0x44,
+	.opp_curr = 0x48,
+	.opp_mask = 0xF,
+};
+
+static struct apupwr_plat_data mt8195_apu_power_data = {
+	.dvfs_user = MDLA1,
+	.plat_regs = &mt8195_pwr_reg,
+};
+
 static const struct of_device_id apu_power_of_match[] = {
 	{
 		.compatible = "mediatek,mt8192-apu-power",
 		.data = &mt8192_apu_power_data
+	}, {
+		.compatible = "mediatek,mt8195-apu-power",
+		.data = &mt8195_apu_power_data
 	}, {
 		/* Terminator */
 	},
@@ -597,13 +612,30 @@ static struct platform_driver apu_power_driver = {
 	},
 };
 
+static const struct of_device_id apu_combo_iommu[] = {
+	{ .compatible = "mediatek,apu_combo_iommu0"},
+	{ .compatible = "mediatek,apu_combo_iommu1"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, apu_combo_iommu);
+
+static struct platform_driver apu_combo_iommu_driver = {
+	.driver = {
+		.name = "apu_combo_iommu",
+		.of_match_table = of_match_ptr(apu_combo_iommu),
+	},
+};
+
 static int __init apu_power_drv_init(void)
 {
-	return platform_driver_register(&apu_power_driver);
+	platform_driver_register(&apu_power_driver);
+	platform_driver_register(&apu_combo_iommu_driver);
+	return 0;
 }
 
 static void __exit apu_power_drv_exit(void)
 {
+	platform_driver_unregister(&apu_combo_iommu_driver);
 	platform_driver_unregister(&apu_power_driver);
 }
 
-- 
2.18.0

