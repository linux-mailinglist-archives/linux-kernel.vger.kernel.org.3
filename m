Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044DA4883C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 14:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbiAHNUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 08:20:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40738 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234339AbiAHNUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 08:20:18 -0500
X-UUID: 5190ff4abc6746368de2e9f82a242350-20220108
X-UUID: 5190ff4abc6746368de2e9f82a242350-20220108
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 899414800; Sat, 08 Jan 2022 21:20:14 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 8 Jan 2022 21:20:12 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 8 Jan 2022 21:20:12 +0800
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
Subject: [v1 2/2] soc: mediatek: pm-domains: Add support for mt8186
Date:   Sat, 8 Jan 2022 21:19:53 +0800
Message-ID: <20220108131953.16744-3-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
References: <20220108131953.16744-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domain control data in mt8186.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/soc/mediatek/mt8186-pm-domains.h | 344 +++++++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c    |   5 +
 include/linux/soc/mediatek/infracfg.h    |  48 ++++
 3 files changed, 397 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt8186-pm-domains.h

diff --git a/drivers/soc/mediatek/mt8186-pm-domains.h b/drivers/soc/mediatek/mt8186-pm-domains.h
new file mode 100644
index 000000000000..bf2dd0cdc3a8
--- /dev/null
+++ b/drivers/soc/mediatek/mt8186-pm-domains.h
@@ -0,0 +1,344 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+ */
+
+#ifndef __SOC_MEDIATEK_MT8186_PM_DOMAINS_H
+#define __SOC_MEDIATEK_MT8186_PM_DOMAINS_H
+
+#include "mtk-pm-domains.h"
+#include <dt-bindings/power/mt8186-power.h>
+
+/*
+ * MT8186 power domain support
+ */
+
+static const struct scpsys_domain_data scpsys_domain_data_mt8186[] = {
+	[MT8186_POWER_DOMAIN_MFG0] = {
+		.name = "mfg0",
+		.sta_mask = BIT(2),
+		.ctl_offs = 0x308,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_DOMAIN_SUPPLY,
+	},
+	[MT8186_POWER_DOMAIN_MFG1] = {
+		.name = "mfg1",
+		.sta_mask = BIT(3),
+		.ctl_offs = 0x30c,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP2,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_MFG1_STEP3,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_MFG2] = {
+		.name = "mfg2",
+		.sta_mask = BIT(4),
+		.ctl_offs = 0x310,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_MFG3] = {
+		.name = "mfg3",
+		.sta_mask = BIT(5),
+		.ctl_offs = 0x314,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_SSUSB] = {
+		.name = "ssusb",
+		.sta_mask = BIT(20),
+		.ctl_offs = 0x9F0,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8186_POWER_DOMAIN_SSUSB_P1] = {
+		.name = "ssusb_p1",
+		.sta_mask = BIT(19),
+		.ctl_offs = 0x9F4,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8186_POWER_DOMAIN_DIS] = {
+		.name = "dis",
+		.sta_mask = BIT(21),
+		.ctl_offs = 0x354,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_DIS_STEP2,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+		},
+	},
+	[MT8186_POWER_DOMAIN_IMG] = {
+		.name = "img",
+		.sta_mask = BIT(13),
+		.ctl_offs = 0x334,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_IMG2] = {
+		.name = "img2",
+		.sta_mask = BIT(14),
+		.ctl_offs = 0x338,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_IPE] = {
+		.name = "ipe",
+		.sta_mask = BIT(15),
+		.ctl_offs = 0x33C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_CAM] = {
+		.name = "cam",
+		.sta_mask = BIT(23),
+		.ctl_offs = 0x35C,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_CAM_RAWA] = {
+		.name = "cam_rawa",
+		.sta_mask = BIT(24),
+		.ctl_offs = 0x360,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_CAM_RAWB] = {
+		.name = "cam_rawb",
+		.sta_mask = BIT(25),
+		.ctl_offs = 0x364,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_VENC] = {
+		.name = "venc",
+		.sta_mask = BIT(18),
+		.ctl_offs = 0x348,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_VDEC] = {
+		.name = "vdec",
+		.sta_mask = BIT(16),
+		.ctl_offs = 0x340,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_WPE] = {
+		.name = "wpe",
+		.sta_mask = BIT(0),
+		.ctl_offs = 0x3F8,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1,
+				MT8186_TOP_AXI_PROT_EN_2_SET,
+				MT8186_TOP_AXI_PROT_EN_2_CLR,
+				MT8186_TOP_AXI_PROT_EN_2_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2,
+				MT8186_TOP_AXI_PROT_EN_2_SET,
+				MT8186_TOP_AXI_PROT_EN_2_CLR,
+				MT8186_TOP_AXI_PROT_EN_2_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_CONN_ON] = {
+		.name = "conn_on",
+		.sta_mask = BIT(1),
+		.ctl_offs = 0x304,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1,
+				MT8186_TOP_AXI_PROT_EN_1_SET,
+				MT8186_TOP_AXI_PROT_EN_1_CLR,
+				MT8186_TOP_AXI_PROT_EN_1_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4,
+				MT8186_TOP_AXI_PROT_EN_SET,
+				MT8186_TOP_AXI_PROT_EN_CLR,
+				MT8186_TOP_AXI_PROT_EN_STA),
+		},
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+	[MT8186_POWER_DOMAIN_CSIRX_TOP] = {
+		.name = "csirx_top",
+		.sta_mask = BIT(6),
+		.ctl_offs = 0x318,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_ADSP_AO] = {
+		.name = "adsp_ao",
+		.sta_mask = BIT(17),
+		.ctl_offs = 0x9FC,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_ADSP_INFRA] = {
+		.name = "adsp_infra",
+		.sta_mask = BIT(10),
+		.ctl_offs = 0x9F8,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.caps = MTK_SCPD_KEEP_DEFAULT_OFF,
+	},
+	[MT8186_POWER_DOMAIN_ADSP_TOP] = {
+		.name = "adsp_top",
+		.sta_mask = BIT(31),
+		.ctl_offs = 0x3E4,
+		.pwr_sta_offs = 0x16C,
+		.pwr_sta2nd_offs = 0x170,
+		.sram_pdn_bits = BIT(8),
+		.sram_pdn_ack_bits = BIT(12),
+		.bp_infracfg = {
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1,
+				MT8186_TOP_AXI_PROT_EN_3_SET,
+				MT8186_TOP_AXI_PROT_EN_3_CLR,
+				MT8186_TOP_AXI_PROT_EN_3_STA),
+			BUS_PROT_WR_IGN(MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2,
+				MT8186_TOP_AXI_PROT_EN_3_SET,
+				MT8186_TOP_AXI_PROT_EN_3_CLR,
+				MT8186_TOP_AXI_PROT_EN_3_STA),
+		},
+		.caps = MTK_SCPD_SRAM_ISO | MTK_SCPD_KEEP_DEFAULT_OFF | MTK_SCPD_ACTIVE_WAKEUP,
+	},
+};
+
+static const struct scpsys_soc_data mt8186_scpsys_data = {
+	.domains_data = scpsys_domain_data_mt8186,
+	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8186),
+};
+
+#endif /* __SOC_MEDIATEK_MT8186_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index 61973a306e97..5ced254b082b 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -19,6 +19,7 @@
 #include "mt8167-pm-domains.h"
 #include "mt8173-pm-domains.h"
 #include "mt8183-pm-domains.h"
+#include "mt8186-pm-domains.h"
 #include "mt8192-pm-domains.h"
 #include "mt8195-pm-domains.h"
 
@@ -566,6 +567,10 @@ static const struct of_device_id scpsys_of_match[] = {
 		.compatible = "mediatek,mt8183-power-controller",
 		.data = &mt8183_scpsys_data,
 	},
+	{
+		.compatible = "mediatek,mt8186-power-controller",
+		.data = &mt8186_scpsys_data,
+	},
 	{
 		.compatible = "mediatek,mt8192-power-controller",
 		.data = &mt8192_scpsys_data,
diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
index d858e0bab7a2..8a1c2040a28e 100644
--- a/include/linux/soc/mediatek/infracfg.h
+++ b/include/linux/soc/mediatek/infracfg.h
@@ -140,6 +140,54 @@
 #define MT8192_TOP_AXI_PROT_EN_MM_2_MDP_2ND		BIT(13)
 #define MT8192_TOP_AXI_PROT_EN_VDNR_CAM			BIT(21)
 
+#define MT8186_TOP_AXI_PROT_EN_SET			(0x2A0)
+#define MT8186_TOP_AXI_PROT_EN_CLR			(0x2A4)
+#define MT8186_TOP_AXI_PROT_EN_STA			(0x228)
+#define MT8186_TOP_AXI_PROT_EN_1_SET			(0x2A8)
+#define MT8186_TOP_AXI_PROT_EN_1_CLR			(0x2AC)
+#define MT8186_TOP_AXI_PROT_EN_1_STA			(0x258)
+#define MT8186_TOP_AXI_PROT_EN_2_SET			(0x2B0)
+#define MT8186_TOP_AXI_PROT_EN_2_CLR			(0x2B4)
+#define MT8186_TOP_AXI_PROT_EN_2_STA			(0x26C)
+#define MT8186_TOP_AXI_PROT_EN_3_SET			(0x2B8)
+#define MT8186_TOP_AXI_PROT_EN_3_CLR			(0x2BC)
+#define MT8186_TOP_AXI_PROT_EN_3_STA			(0x2C8)
+
+/* MFG1 */
+#define MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP1		(GENMASK(28, 27))
+#define MT8186_TOP_AXI_PROT_EN_MFG1_STEP2		(GENMASK(22, 21))
+#define MT8186_TOP_AXI_PROT_EN_MFG1_STEP3		(BIT(25))
+#define MT8186_TOP_AXI_PROT_EN_1_MFG1_STEP4		(BIT(29))
+/* DIS */
+#define MT8186_TOP_AXI_PROT_EN_1_DIS_STEP1		(GENMASK(12, 11))
+#define MT8186_TOP_AXI_PROT_EN_DIS_STEP2		(GENMASK(2, 1) | GENMASK(11, 10))
+/* IMG */
+#define MT8186_TOP_AXI_PROT_EN_1_IMG_STEP1		(BIT(23))
+#define MT8186_TOP_AXI_PROT_EN_1_IMG_STEP2		(BIT(15))
+/* IPE */
+#define MT8186_TOP_AXI_PROT_EN_1_IPE_STEP1		(BIT(24))
+#define MT8186_TOP_AXI_PROT_EN_1_IPE_STEP2		(BIT(16))
+/* CAM */
+#define MT8186_TOP_AXI_PROT_EN_1_CAM_STEP1		(GENMASK(22, 21))
+#define MT8186_TOP_AXI_PROT_EN_1_CAM_STEP2		(GENMASK(14, 13))
+/* VENC */
+#define MT8186_TOP_AXI_PROT_EN_1_VENC_STEP1		(BIT(31))
+#define MT8186_TOP_AXI_PROT_EN_1_VENC_STEP2		(BIT(19))
+/* VDEC */
+#define MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP1		(BIT(30))
+#define MT8186_TOP_AXI_PROT_EN_1_VDEC_STEP2		(BIT(17))
+/* WPE */
+#define MT8186_TOP_AXI_PROT_EN_2_WPE_STEP1		(BIT(17))
+#define MT8186_TOP_AXI_PROT_EN_2_WPE_STEP2		(BIT(16))
+/* CONN_ON */
+#define MT8186_TOP_AXI_PROT_EN_1_CONN_ON_STEP1		(BIT(18))
+#define MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP2		(BIT(14))
+#define MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP3		(BIT(13))
+#define MT8186_TOP_AXI_PROT_EN_CONN_ON_STEP4		(BIT(16))
+/* ADSP_TOP */
+#define MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP1		(GENMASK(12, 11))
+#define MT8186_TOP_AXI_PROT_EN_3_ADSP_TOP_STEP2		(GENMASK(1, 0))
+
 #define MT8183_TOP_AXI_PROT_EN_STA1			0x228
 #define MT8183_TOP_AXI_PROT_EN_STA1_1			0x258
 #define MT8183_TOP_AXI_PROT_EN_SET			0x2a0
-- 
2.18.0

