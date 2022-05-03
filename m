Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9938B51814D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 11:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbiECJm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 05:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiECJmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 05:42:39 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C0F369F9;
        Tue,  3 May 2022 02:39:06 -0700 (PDT)
X-UUID: f2ae53a54bcc443e9c410e4b88e0bad3-20220503
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:fabc99c4-91df-4f59-82c6-307620724898,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:bdf44fc7-85ee-4ac1-ac05-bd3f1e72e732,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f2ae53a54bcc443e9c410e4b88e0bad3-20220503
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 765195696; Tue, 03 May 2022 17:39:01 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 3 May 2022 17:39:00 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 3 May 2022 17:39:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 3 May 2022 17:39:00 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.zabel@pengutronix.de>,
        <angelogioacchino.delregno@collabora.com>,
        <chun-jie.chen@mediatek.com>, <wenst@chromium.org>,
        <runyang.chen@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Subject: [PATCH v6 14/16] clk: mediatek: reset: Add infra_ao reset support for MT8192/MT8195
Date:   Tue, 3 May 2022 17:38:54 +0800
Message-ID: <20220503093856.22250-15-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
References: <20220503093856.22250-1-rex-bc.chen@mediatek.com>
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

The infra_ao reset is needed for MT8192 and MT8195.
- Add mtk_clk_rst_desc for MT8192 and MT8195
- Add register reset controller function for MT8192 infra_ao.
- Move definition of infra reset from cl-mt8183.c to reset.h
  because it's the same definition with MT8192 and MT8195.
- Add new definition of infra reset_4 for MT8192 and MT8195.
- Add infra_ao_idx_map for MT8192 and MT8195.

Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8183.c          |  6 -----
 drivers/clk/mediatek/clk-mt8192.c          | 29 ++++++++++++++++++++++
 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 24 ++++++++++++++++++
 drivers/clk/mediatek/reset.h               |  7 ++++++
 4 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index c7d5ffacbd1d..40b53e15411d 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -18,12 +18,6 @@
 
 #include <dt-bindings/clock/mt8183-clk.h>
 
-/* Infra global controller reset set register */
-#define INFRA_RST0_SET_OFFSET		0x120
-#define INFRA_RST1_SET_OFFSET		0x130
-#define INFRA_RST2_SET_OFFSET		0x140
-#define INFRA_RST3_SET_OFFSET		0x150
-
 static DEFINE_SPINLOCK(mt8183_clk_lock);
 
 static const struct mtk_fixed_clk top_fixed_clks[] = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index ab27cd66b866..66b43d3ba424 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -18,6 +18,7 @@
 #include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8192-clk.h>
+#include <dt-bindings/reset/mt8192-resets.h>
 
 static DEFINE_SPINLOCK(mt8192_clk_lock);
 
@@ -1114,6 +1115,30 @@ static const struct mtk_gate top_clks[] = {
 	GATE_TOP(CLK_TOP_SSUSB_PHY_REF, "ssusb_phy_ref", "clk26m", 25),
 };
 
+static u16 infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+	INFRA_RST4_SET_OFFSET,
+};
+
+static u16 infra_ao_idx_map[] = {
+	[MT8192_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8192_INFRA_RST2_PEXTP_PHY_SWRST] = 2 * RST_NR_PER_BANK + 15,
+	[MT8192_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
+	[MT8192_INFRA_RST4_PCIE_TOP_SWRST] = 4 * RST_NR_PER_BANK + 1,
+	[MT8192_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 12,
+};
+
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
+	.rst_idx_map = infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
+};
+
 #define MT8192_PLL_FMAX		(3800UL * MHZ)
 #define MT8192_PLL_FMIN		(1500UL * MHZ)
 #define MT8192_INTEGER_BITS	8
@@ -1239,6 +1264,10 @@ static int clk_mt8192_infra_probe(struct platform_device *pdev)
 	if (r)
 		goto free_clk_data;
 
+	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+	if (r)
+		goto free_clk_data;
+
 	r = of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
 	if (r)
 		goto free_clk_data;
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index 8ebe3b9415c4..97657f255618 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -7,6 +7,7 @@
 #include "clk-mtk.h"
 
 #include <dt-bindings/clock/mt8195-clk.h>
+#include <dt-bindings/reset/mt8195-resets.h>
 #include <linux/clk-provider.h>
 #include <linux/platform_device.h>
 
@@ -182,9 +183,32 @@ static const struct mtk_gate infra_ao_clks[] = {
 	GATE_INFRA_AO4(CLK_INFRA_AO_PERI_UFS_MEM_SUB, "infra_ao_peri_ufs_mem_sub", "mem_466m", 31),
 };
 
+static u16 infra_ao_rst_ofs[] = {
+	INFRA_RST0_SET_OFFSET,
+	INFRA_RST1_SET_OFFSET,
+	INFRA_RST2_SET_OFFSET,
+	INFRA_RST3_SET_OFFSET,
+	INFRA_RST4_SET_OFFSET,
+};
+
+static u16 infra_ao_idx_map[] = {
+	[MT8195_INFRA_RST0_THERM_CTRL_SWRST] = 0 * RST_NR_PER_BANK + 0,
+	[MT8195_INFRA_RST3_THERM_CTRL_PTP_SWRST] = 3 * RST_NR_PER_BANK + 5,
+	[MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST] = 4 * RST_NR_PER_BANK + 10,
+};
+
+static struct mtk_clk_rst_desc infra_ao_rst_desc = {
+	.version = MTK_RST_SET_CLR,
+	.rst_bank_ofs = infra_ao_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infra_ao_rst_ofs),
+	.rst_idx_map = infra_ao_idx_map,
+	.rst_idx_map_nr = ARRAY_SIZE(infra_ao_idx_map),
+};
+
 static const struct mtk_clk_desc infra_ao_desc = {
 	.clks = infra_ao_clks,
 	.num_clks = ARRAY_SIZE(infra_ao_clks),
+	.rst_desc = &infra_ao_rst_desc,
 };
 
 static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
index 34772ef74ec7..913fe676cba7 100644
--- a/drivers/clk/mediatek/reset.h
+++ b/drivers/clk/mediatek/reset.h
@@ -11,6 +11,13 @@
 
 #define RST_NR_PER_BANK 32
 
+/* Infra global controller reset set register */
+#define INFRA_RST0_SET_OFFSET 0x120
+#define INFRA_RST1_SET_OFFSET 0x130
+#define INFRA_RST2_SET_OFFSET 0x140
+#define INFRA_RST3_SET_OFFSET 0x150
+#define INFRA_RST4_SET_OFFSET 0x730
+
 /**
  * enum mtk_reset_version - Version of MediaTek clock reset controller.
  * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
-- 
2.18.0

