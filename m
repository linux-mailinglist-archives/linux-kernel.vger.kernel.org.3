Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057FD53A3DD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352618AbiFALWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 07:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243113AbiFALWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 07:22:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D94C41983;
        Wed,  1 Jun 2022 04:22:12 -0700 (PDT)
X-UUID: f26b983fbe4d47b28ff114f612ca7838-20220601
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:00582883-3df0-4a6d-b028-ddfa6c41f410,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.5,REQID:00582883-3df0-4a6d-b028-ddfa6c41f410,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:2a19b09,CLOUDID:93648f14-f88c-475e-badf-d9ee54230b8f,C
        OID:63ea4881c016,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:0,BEC:nil
X-UUID: f26b983fbe4d47b28ff114f612ca7838-20220601
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 9315063; Wed, 01 Jun 2022 19:22:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 1 Jun 2022 19:22:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 1 Jun 2022 19:22:05 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        "Dustin L. Howett" <dustin@howett.net>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>
CC:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <weishunc@google.com>
Subject: [PATCH v1 11/15] remoteproc: mediatek: Add SCP core 1 SRAM offset
Date:   Wed, 1 Jun 2022 19:21:57 +0800
Message-ID: <20220601112201.15510-12-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220601112201.15510-1-tinghan.shen@mediatek.com>
References: <20220601112201.15510-1-tinghan.shen@mediatek.com>
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

Because SCP core 0 and core 1 both boot from address 0 and have the same
viewpoint of memory, HW has a set of registers, "SRAM offset", to add
offset to accessed address for SCP core 1 to solve this problem.

The "SRAM offset" configuration is composed by specifying a range and an
offset. The value of range is from the viewpoint of SCP core 1.
When SCP core 1 accessing addresses in the configured range, SCP bus
adds an offset to shift the destination on SCP SRAM. This shift is
transparent to the software running on SCP core 1.

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/remoteproc/mtk_scp_dual.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/remoteproc/mtk_scp_dual.c b/drivers/remoteproc/mtk_scp_dual.c
index 16cf9d2628c8..4e8d7f5cdad6 100644
--- a/drivers/remoteproc/mtk_scp_dual.c
+++ b/drivers/remoteproc/mtk_scp_dual.c
@@ -33,6 +33,27 @@ static void mt8195_power_off_sram(void __iomem *addr)
 static int mt8195_scp_dual_before_load(struct mtk_scp *scp)
 {
 	u32 sec_ctrl;
+	struct device *dev = scp->dev;
+	struct device_node *main_np;
+	struct platform_device *main_pdev;
+	struct mtk_scp *scp_core0;
+
+	/* Get sram start address from SCP core 0 */
+	main_np = of_parse_phandle(dev->of_node, "mediatek,scp-core", 1);
+	if (!main_np) {
+		dev_warn(dev, "Invalid SCP main core phandle\n");
+		return -EINVAL;
+	}
+
+	main_pdev = of_find_device_by_node(main_np);
+	of_node_put(main_np);
+
+	if (!main_pdev) {
+		dev_err(dev, "Cannot find SCP core 0 device\n");
+		return -ENODEV;
+	}
+	scp_core0 = platform_get_drvdata(main_pdev);
+	put_device(&main_pdev->dev);
 
 	mt8195_power_on_sram(scp->reg_base + MT8195_CPU1_SRAM_PD);
 
@@ -42,6 +63,27 @@ static int mt8195_scp_dual_before_load(struct mtk_scp *scp)
 	/* enable MPU for all memory regions */
 	writel(0xff, scp->reg_base + MT8195_CORE1_MEM_ATT_PREDEF);
 
+	/* The value of SRAM offset range is from the viewpoint of SCP core 1.
+	 * This configuration adds an offset on SCP bus when SCP core 1 accesses SCP SRAM
+	 * to solve the SCP core 0 and core 1 both fetch the 1st instruction from the same
+	 * SRAM address.
+	 *
+	 * Because SCP core 0 and core 1 both boot from address 0, this must be configured
+	 * before boot SCP core 1.
+	 *
+	 * Configure the range of SRAM addresses will be added offset.
+	 */
+	writel(0, scp->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_LOW);
+	writel(scp->sram_size, scp->reg_base + MT8195_L2TCM_OFFSET_RANGE_0_HIGH);
+
+	/* configure the offset value */
+	writel(scp->sram_phys - scp_core0->sram_phys, scp->reg_base + MT8195_L2TCM_OFFSET);
+
+	/* enable adding sram offset when fetching instruction and data */
+	sec_ctrl = readl(scp->reg_base + MT8195_SEC_CTRL);
+	sec_ctrl |= MT8195_CORE_OFFSET_ENABLE_I | MT8195_CORE_OFFSET_ENABLE_D;
+	writel(sec_ctrl, scp->reg_base + MT8195_SEC_CTRL);
+
 	return 0;
 }
 
-- 
2.18.0

