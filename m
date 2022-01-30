Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0107D4A330B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353669AbiA3BVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:21:36 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:47540 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353677AbiA3BVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:21:33 -0500
X-UUID: 01c3642cde044e73a8fb9db2ed0b14e8-20220130
X-UUID: 01c3642cde044e73a8fb9db2ed0b14e8-20220130
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 646610924; Sun, 30 Jan 2022 09:21:30 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 30 Jan 2022 09:21:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 09:21:28 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [v7 5/5] soc: mediatek: pm-domains: Add support for mt8195
Date:   Sun, 30 Jan 2022 09:21:04 +0800
Message-ID: <20220130012104.5292-6-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
References: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add domain control data including bus protection data size
change due to more protection steps in mt8195.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8195-pm-domains.h | 613 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 drivers/soc/mediatek/mtk-pm-domains.h    |   2 +-
 include/linux/soc/mediatek/infracfg.h    |  82 +++
 4 files changed, 701 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soc/mediatek/mt8195-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8195-pm-domains.h b/drivers/soc/mediatek/mt8195-pm-domains.h
new file mode 100644
index 000000000000..938f4d51f5ae
--- /dev/null
+++ b/drivers/soc/mediatek/mt8195-pm-domains.h
@@ -0,0 +1,613 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+ */
+
+#ifndef __SOC_MEDIATEK_MT8195_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8195_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt8195-power.h>
+
+/*
+ * MT8195 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8195[] = {
+	[MT8195_POWER_DOMAIN_PCIE_MAC_P0] = {
+		.name = "pcie_mac_p0",
+		.sta_mask = BIT(11),
+		.ctl_offs = 0x328,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_PCIE_MAC_P1] = {
+		.name = "pcie_mac_p1",
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x32C,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_PCIE_PHY] = {
+		.name = "pcie_phy",
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x330,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY] = {
+		.name = "ssusb_pcie_phy",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x334,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8195_POWER_DOMAIN_CSI_RX_TOP] = {
+		.name = "csi_rx_top",
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x3C4,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_ETHER] = {
+		.name = "ether",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x344,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8195_POWER_DOMAIN_ADSP] = {
+		.name = "adsp",
+		.sta_mask = BIT(10),
+		.ctl_offs = 0x360,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_ADSP,
+				    MT8195_TOP_AXI_PROT_EN_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+		},
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8195_POWER_DOMAIN_AUDIO] = {
+		.name = "audio",
+		.sta_mask = BIT(8),
+		.ctl_offs = 0x358,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_AUDIO,
+				    MT8195_TOP_AXI_PROT_EN_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x300,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT8195_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x304,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1,
+				    MT8195_TOP_AXI_PROT_EN_SET,
+				    MT8195_TOP_AXI_PROT_EN_CLR,
+				    MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1,
+				    MT8195_TOP_AXI_PROT_EN_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_MFG1,
+				    MT8195_TOP_AXI_PROT_EN_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND,
+				    MT8195_TOP_AXI_PROT_EN_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MFG1_2ND,
+				    MT8195_TOP_AXI_PROT_EN_SET,
+				    MT8195_TOP_AXI_PROT_EN_CLR,
+				    MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x308,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x30C,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_MFG4] = {
+		.name = "mfg4",
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x310,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_MFG5] = {
+		.name = "mfg5",
+		.sta_mask = BIT(6),
+		.ctl_offs = 0x314,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_MFG6] = {
+		.name = "mfg6",
+		.sta_mask = BIT(7),
+		.ctl_offs = 0x318,
+		.pwr_sta_offs = 0x174,
+		.pwr_sta2nd_offs = 0x178,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_VPPSYS0] = {
+		.name = "vppsys0",
+		.sta_mask = BIT(11),
+		.ctl_offs = 0x364,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0,
+				    MT8195_TOP_AXI_PROT_EN_SET,
+				    MT8195_TOP_AXI_PROT_EN_CLR,
+				    MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND,
+				    MT8195_TOP_AXI_PROT_EN_SET,
+				    MT8195_TOP_AXI_PROT_EN_CLR,
+				    MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_VDOSYS0] = {
+		.name = "vdosys0",
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x36C,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDOSYS0,
+				    MT8195_TOP_AXI_PROT_EN_SET,
+				    MT8195_TOP_AXI_PROT_EN_CLR,
+				    MT8195_TOP_AXI_PROT_EN_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR,
+				    MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_VPPSYS1] = {
+		.name = "vppsys1",
+		.sta_mask = BIT(12),
+		.ctl_offs = 0x368,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_VDOSYS1] = {
+		.name = "vdosys1",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x370,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_DP_TX] = {
+		.name = "dp_tx",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x378,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_EPD_TX] = {
+		.name = "epd_tx",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x37C,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_HDMI_TX] = {
+		.name = "hdmi_tx",
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x380,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8195_POWER_DOMAIN_WPESYS] = {
+		.name = "wpesys",
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x374,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_WPESYS,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+	},
+	[MT8195_POWER_DOMAIN_VDEC0] = {
+		.name = "vdec0",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x388,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_VDEC1] = {
+		.name = "vdec1",
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x38C,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_VDEC2] = {
+		.name = "vdec2",
+		.sta_mask = BIT(22),
+		.ctl_offs = 0x390,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x394,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_VENC_CORE1] = {
+		.name = "venc_core1",
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x398,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_IMG] = {
+		.name = "img",
+		.sta_mask = BIT(29),
+		.ctl_offs = 0x3AC,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_DIP] = {
+		.name = "dip",
+		.sta_mask = BIT(30),
+		.ctl_offs = 0x3B0,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_IPE] = {
+		.name = "ipe",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x3B4,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_IPE,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_IPE,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x39C,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.bp_infracfg = {
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_2_CAM,
+				    MT8195_TOP_AXI_PROT_EN_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_2_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_1_CAM,
+				    MT8195_TOP_AXI_PROT_EN_1_SET,
+				    MT8195_TOP_AXI_PROT_EN_1_CLR,
+				    MT8195_TOP_AXI_PROT_EN_1_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND,
+				    MT8195_TOP_AXI_PROT_EN_MM_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_STA1),
+			BUS_PROT_WR(MT8195_TOP_AXI_PROT_EN_MM_2_CAM,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_SET,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_CLR,
+				    MT8195_TOP_AXI_PROT_EN_MM_2_STA1),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_CAM_RAWA] = {
+		.name = "cam_rawa",
+		.sta_mask = BIT(26),
+		.ctl_offs = 0x3A0,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_CAM_RAWB] = {
+		.name = "cam_rawb",
+		.sta_mask = BIT(27),
+		.ctl_offs = 0x3A4,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8195_POWER_DOMAIN_CAM_MRAW] = {
+		.name = "cam_mraw",
+		.sta_mask = BIT(28),
+		.ctl_offs = 0x3A8,
+		.pwr_sta_offs = 0x16c,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = GENMASK(8, 8),
+		.sram_pdn_ack_bits = GENMASK(12, 12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+};
+
+static const struct scpsys_soc_data mt8195_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8195,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8195),
+};
+
+#endif /* __SOC_MEDIATEK_MT8195_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index ad06b6f90435..61973a306e97 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -20,6 +20,7 @@
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
 #include "mt8192-pm-domains.h"
+#include "mt8195-pm-domains.h"
 
 #define MTK_POLL_DELAY_US		10
 #define MTK_POLL_TIMEOUT		USEC_PER_SEC
@@ -569,6 +570,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8192-power-controller",
 		.data = &mt8192_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8195-power-controller",
+		.data = &mt8195_scpsys_data,
+	},
 	{ }
 };
 
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index c233ed828f86..daa24e890dd4 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -37,7 +37,7 @@
 #define PWR_STATUS_AUDIO		BIT(24)
 #define PWR_STATUS_USB			BIT(25)
 
-#define SPM_MAX_BUS_PROT_DATA		5
+#define SPM_MAX_BUS_PROT_DATA		6
 
 #define _BUS_PROT(_mask, _set, _clr, _sta, _update, _ignore) {	\
 		.bus_prot_mask = (_mask),			\
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index 4615a228da51..d858e0bab7a2 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -2,6 +2,88 @@
 #ifndef __SOC_MEDIATEK_INFRACFG_H
 #define __SOC_MEDIATEK_INFRACFG_H
 
+#define MT8195_TOP_AXI_PROT_EN_STA1                     0x228
+#define MT8195_TOP_AXI_PROT_EN_1_STA1                   0x258
+#define MT8195_TOP_AXI_PROT_EN_SET			0x2a0
+#define MT8195_TOP_AXI_PROT_EN_CLR                      0x2a4
+#define MT8195_TOP_AXI_PROT_EN_1_SET                    0x2a8
+#define MT8195_TOP_AXI_PROT_EN_1_CLR                    0x2ac
+#define MT8195_TOP_AXI_PROT_EN_MM_SET                   0x2d4
+#define MT8195_TOP_AXI_PROT_EN_MM_CLR                   0x2d8
+#define MT8195_TOP_AXI_PROT_EN_MM_STA1                  0x2ec
+#define MT8195_TOP_AXI_PROT_EN_2_SET                    0x714
+#define MT8195_TOP_AXI_PROT_EN_2_CLR                    0x718
+#define MT8195_TOP_AXI_PROT_EN_2_STA1                   0x724
+#define MT8195_TOP_AXI_PROT_EN_VDNR_SET                 0xb84
+#define MT8195_TOP_AXI_PROT_EN_VDNR_CLR                 0xb88
+#define MT8195_TOP_AXI_PROT_EN_VDNR_STA1                0xb90
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_SET               0xba4
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_CLR               0xba8
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_STA1              0xbb0
+#define MT8195_TOP_AXI_PROT_EN_VDNR_2_SET               0xbb8
+#define MT8195_TOP_AXI_PROT_EN_VDNR_2_CLR               0xbbc
+#define MT8195_TOP_AXI_PROT_EN_VDNR_2_STA1              0xbc4
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_SET       0xbcc
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_CLR       0xbd0
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_STA1      0xbd8
+#define MT8195_TOP_AXI_PROT_EN_MM_2_SET                 0xdcc
+#define MT8195_TOP_AXI_PROT_EN_MM_2_CLR                 0xdd0
+#define MT8195_TOP_AXI_PROT_EN_MM_2_STA1                0xdd8
+
+#define MT8195_TOP_AXI_PROT_EN_VDOSYS0			BIT(6)
+#define MT8195_TOP_AXI_PROT_EN_VPPSYS0			BIT(10)
+#define MT8195_TOP_AXI_PROT_EN_MFG1			BIT(11)
+#define MT8195_TOP_AXI_PROT_EN_MFG1_2ND			GENMASK(22, 21)
+#define MT8195_TOP_AXI_PROT_EN_VPPSYS0_2ND		BIT(23)
+#define MT8195_TOP_AXI_PROT_EN_1_MFG1			GENMASK(20, 19)
+#define MT8195_TOP_AXI_PROT_EN_1_CAM			BIT(22)
+#define MT8195_TOP_AXI_PROT_EN_2_CAM			BIT(0)
+#define MT8195_TOP_AXI_PROT_EN_2_MFG1_2ND		GENMASK(6, 5)
+#define MT8195_TOP_AXI_PROT_EN_2_MFG1			BIT(7)
+#define MT8195_TOP_AXI_PROT_EN_2_AUDIO			(BIT(9) | BIT(11))
+#define MT8195_TOP_AXI_PROT_EN_2_ADSP			(BIT(12) | GENMASK(16, 14))
+#define MT8195_TOP_AXI_PROT_EN_MM_CAM			(BIT(0) | BIT(2) | BIT(4))
+#define MT8195_TOP_AXI_PROT_EN_MM_IPE			BIT(1)
+#define MT8195_TOP_AXI_PROT_EN_MM_IMG			BIT(3)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDOSYS0		GENMASK(21, 17)
+#define MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1		GENMASK(8, 5)
+#define MT8195_TOP_AXI_PROT_EN_MM_VENC			(BIT(9) | BIT(11))
+#define MT8195_TOP_AXI_PROT_EN_MM_VENC_CORE1		(BIT(10) | BIT(12))
+#define MT8195_TOP_AXI_PROT_EN_MM_VDEC0			BIT(13)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDEC1			BIT(14)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1_2ND		BIT(22)
+#define MT8195_TOP_AXI_PROT_EN_MM_VPPSYS1_2ND		BIT(23)
+#define MT8195_TOP_AXI_PROT_EN_MM_CAM_2ND		BIT(24)
+#define MT8195_TOP_AXI_PROT_EN_MM_IMG_2ND		BIT(25)
+#define MT8195_TOP_AXI_PROT_EN_MM_VENC_2ND		BIT(26)
+#define MT8195_TOP_AXI_PROT_EN_MM_WPESYS		BIT(27)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDEC0_2ND		BIT(28)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDEC1_2ND		BIT(29)
+#define MT8195_TOP_AXI_PROT_EN_MM_VDOSYS1		GENMASK(31, 30)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0_2ND		(GENMASK(1, 0) | BIT(4) | BIT(11))
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VENC		BIT(2)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VENC_CORE1		(BIT(3) | BIT(15))
+#define MT8195_TOP_AXI_PROT_EN_MM_2_CAM			(BIT(5) | BIT(17))
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS1		(GENMASK(7, 6) | BIT(18))
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VPPSYS0		GENMASK(9, 8)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VDOSYS1		BIT(10)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2_2ND		BIT(12)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0_2ND		BIT(13)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS_2ND		BIT(14)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_IPE			BIT(16)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VDEC2		BIT(21)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_VDEC0		BIT(22)
+#define MT8195_TOP_AXI_PROT_EN_MM_2_WPESYS		GENMASK(24, 23)
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_EPD_TX		BIT(1)
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_DP_TX		BIT(2)
+#define MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P0		(BIT(11) | BIT(28))
+#define MT8195_TOP_AXI_PROT_EN_VDNR_PCIE_MAC_P1		(BIT(12) | BIT(29))
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P0	BIT(13)
+#define MT8195_TOP_AXI_PROT_EN_VDNR_1_PCIE_MAC_P1	BIT(14)
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_MFG1	(BIT(17) | BIT(19))
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VPPSYS0	BIT(20)
+#define MT8195_TOP_AXI_PROT_EN_SUB_INFRA_VDNR_VDOSYS0	BIT(21)
+
 #define MT8192_TOP_AXI_PROT_EN_STA1			0x228
 #define MT8192_TOP_AXI_PROT_EN_1_STA1			0x258
 #define MT8192_TOP_AXI_PROT_EN_SET			0x2a0
-- 
2.18.0

