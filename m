Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624B24A330C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 02:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353695AbiA3BVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 20:21:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:51446 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353676AbiA3BVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 20:21:32 -0500
X-UUID: aec432b3b6c24406b00928a6bfca64d4-20220130
X-UUID: aec432b3b6c24406b00928a6bfca64d4-20220130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1086985844; Sun, 30 Jan 2022 09:21:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 30 Jan 2022 09:21:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 30 Jan 2022 09:21:26 +0800
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
Subject: [v7 4/5] soc: mediatek: pm-domains: Move power status offset to power domain data
Date:   Sun, 30 Jan 2022 09:21:03 +0800
Message-ID: <20220130012104.5292-5-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
References: <20220130012104.5292-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT8195 has more than 32 power domains so it needs
two set of pwr_sta and pwr_sta2nd registers,
so move the register offset from soc data into power domain data.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8167-pm-domains.h | 16 +++++++--
 drivers/soc/mediatek/mt8173-pm-domains.h | 22 ++++++++++--
 drivers/soc/mediatek/mt8183-pm-domains.h | 32 +++++++++++++++--
 drivers/soc/mediatek/mt8192-pm-domains.h | 44 ++++++++++++++++++++++--
 drivers/soc/mediatek/mtk-pm-domains.c    |  4 +--
 drivers/soc/mediatek/mtk-pm-domains.h    |  4 +--
 6 files changed, 110 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/mediatek/mt8167-pm-domains.h b/drivers/soc/mediatek/mt8167-pm-domains.h
index 15559ddf26e4..4d6c32759606 100644
--- a/drivers/soc/mediatek/mt8167-pm-domains.h
+++ b/drivers/soc/mediatek/mt8167-pm-domains.h
@@ -18,6 +18,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "mm",
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = SPM_DIS_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -30,6 +32,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "vdec",
 		.sta_mask = PWR_STATUS_VDEC,
 		.ctl_offs = SPM_VDE_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
@@ -38,6 +42,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "isp",
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = SPM_ISP_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
@@ -46,6 +52,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "mfg_async",
 		.sta_mask = MT8167_PWR_STATUS_MFG_ASYNC,
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
 		.bp_infracfg = {
@@ -57,6 +65,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "mfg_2d",
 		.sta_mask = MT8167_PWR_STATUS_MFG_2D,
 		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -64,6 +74,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = SPM_MFG_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -71,6 +83,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = SPM_CONN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = 0,
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
@@ -85,8 +99,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8167[] = {
 static const struct scpsys_soc_data mt8167_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8167,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8167),
-	.pwr_sta_offs = SPM_PWR_STATUS,
-	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 };
 
 #endif /* __SOC_MEDIATEK_MT8167_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mt8173-pm-domains.h b/drivers/soc/mediatek/mt8173-pm-domains.h
index 714fa92575df..1a5dc63b7357 100644
--- a/drivers/soc/mediatek/mt8173-pm-domains.h
+++ b/drivers/soc/mediatek/mt8173-pm-domains.h
@@ -15,6 +15,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "vdec",
 		.sta_mask = PWR_STATUS_VDEC,
 		.ctl_offs = SPM_VDE_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -22,6 +24,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "venc",
 		.sta_mask = PWR_STATUS_VENC,
 		.ctl_offs = SPM_VEN_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -29,6 +33,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "isp",
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = SPM_ISP_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 	},
@@ -36,6 +42,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "mm",
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = SPM_DIS_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -47,6 +55,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "venc_lt",
 		.sta_mask = PWR_STATUS_VENC_LT,
 		.ctl_offs = SPM_VEN2_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -54,6 +64,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "audio",
 		.sta_mask = PWR_STATUS_AUDIO,
 		.ctl_offs = SPM_AUDIO_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -61,6 +73,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "usb",
 		.sta_mask = PWR_STATUS_USB,
 		.ctl_offs = SPM_USB_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.caps = MTK_SCPD_ACTIVE_WAKEUP,
@@ -69,6 +83,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "mfg_async",
 		.sta_mask = PWR_STATUS_MFG_ASYNC,
 		.ctl_offs = SPM_MFG_ASYNC_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = 0,
 		.caps = MTK_SCPD_DOMAIN_SUPPLY,
@@ -77,6 +93,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "mfg_2d",
 		.sta_mask = PWR_STATUS_MFG_2D,
 		.ctl_offs = SPM_MFG_2D_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 	},
@@ -84,6 +102,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = SPM_MFG_PWR_CON,
+		.pwr_sta_offs = SPM_PWR_STATUS,
+		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 		.sram_pdn_bits = GENMASK(13, 8),
 		.sram_pdn_ack_bits = GENMASK(21, 16),
 		.bp_infracfg = {
@@ -98,8 +118,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8173[] = {
 static const struct scpsys_soc_data mt8173_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8173,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8173),
-	.pwr_sta_offs = SPM_PWR_STATUS,
-	.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND,
 };
 
 #endif /* __SOC_MEDIATEK_MT8173_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mt8183-pm-domains.h b/drivers/soc/mediatek/mt8183-pm-domains.h
index 98a9940d05fb..71b8757e552d 100644
--- a/drivers/soc/mediatek/mt8183-pm-domains.h
+++ b/drivers/soc/mediatek/mt8183-pm-domains.h
@@ -15,6 +15,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "audio",
 		.sta_mask = PWR_STATUS_AUDIO,
 		.ctl_offs = 0x0314,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 	},
@@ -22,6 +24,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = 0x032c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
 		.bp_infracfg = {
@@ -33,6 +37,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "mfg_async",
 		.sta_mask = PWR_STATUS_MFG_ASYNC,
 		.ctl_offs = 0x0334,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
 	},
@@ -40,6 +46,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "mfg",
 		.sta_mask = PWR_STATUS_MFG,
 		.ctl_offs = 0x0338,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.caps = MTK_SCPD_DOMAIN_SUPPLY,
@@ -48,6 +56,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "mfg_core0",
 		.sta_mask = BIT(7),
 		.ctl_offs = 0x034c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -55,6 +65,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "mfg_core1",
 		.sta_mask = BIT(20),
 		.ctl_offs = 0x0310,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -62,6 +74,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "mfg_2d",
 		.sta_mask = PWR_STATUS_MFG_2D,
 		.ctl_offs = 0x0348,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -75,6 +89,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "disp",
 		.sta_mask = PWR_STATUS_DISP,
 		.ctl_offs = 0x030c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -94,6 +110,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "cam",
 		.sta_mask = BIT(25),
 		.ctl_offs = 0x0344,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.bp_infracfg = {
@@ -117,6 +135,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "isp",
 		.sta_mask = PWR_STATUS_ISP,
 		.ctl_offs = 0x0308,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(9, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.bp_infracfg = {
@@ -140,6 +160,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "vdec",
 		.sta_mask = BIT(31),
 		.ctl_offs = 0x0300,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_smi = {
@@ -153,6 +175,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "venc",
 		.sta_mask = PWR_STATUS_VENC,
 		.ctl_offs = 0x0304,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(15, 12),
 		.bp_smi = {
@@ -166,6 +190,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "vpu_top",
 		.sta_mask = BIT(26),
 		.ctl_offs = 0x0324,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -193,6 +219,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "vpu_core0",
 		.sta_mask = BIT(27),
 		.ctl_offs = 0x33c,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.bp_infracfg = {
@@ -211,6 +239,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 		.name = "vpu_core1",
 		.sta_mask = BIT(28),
 		.ctl_offs = 0x0340,
+		.pwr_sta_offs = 0x0180,
+		.pwr_sta2nd_offs = 0x0184,
 		.sram_pdn_bits = GENMASK(11, 8),
 		.sram_pdn_ack_bits = GENMASK(13, 12),
 		.bp_infracfg = {
@@ -230,8 +260,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8183[] = {
 static const struct scpsys_soc_data mt8183_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8183,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8183),
-	.pwr_sta_offs = 0x0180,
-	.pwr_sta2nd_offs = 0x0184
 };
 
 #endif /* __SOC_MEDIATEK_MT8183_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mt8192-pm-domains.h b/drivers/soc/mediatek/mt8192-pm-domains.h
index 543dda70de01..558c4ee4784a 100644
--- a/drivers/soc/mediatek/mt8192-pm-domains.h
+++ b/drivers/soc/mediatek/mt8192-pm-domains.h
@@ -15,6 +15,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "audio",
 		.sta_mask = BIT(21),
 		.ctl_offs = 0x0354,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -28,6 +30,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "conn",
 		.sta_mask = PWR_STATUS_CONN,
 		.ctl_offs = 0x0304,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = 0,
 		.sram_pdn_ack_bits = 0,
 		.bp_infracfg = {
@@ -50,6 +54,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg0",
 		.sta_mask = BIT(2),
 		.ctl_offs = 0x0308,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -57,6 +63,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg1",
 		.sta_mask = BIT(3),
 		.ctl_offs = 0x030c,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -82,6 +90,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg2",
 		.sta_mask = BIT(4),
 		.ctl_offs = 0x0310,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -89,6 +99,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg3",
 		.sta_mask = BIT(5),
 		.ctl_offs = 0x0314,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -96,6 +108,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg4",
 		.sta_mask = BIT(6),
 		.ctl_offs = 0x0318,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -103,6 +117,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg5",
 		.sta_mask = BIT(7),
 		.ctl_offs = 0x031c,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -110,6 +126,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mfg6",
 		.sta_mask = BIT(8),
 		.ctl_offs = 0x0320,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -117,6 +135,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "disp",
 		.sta_mask = BIT(20),
 		.ctl_offs = 0x0350,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -146,6 +166,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "ipe",
 		.sta_mask = BIT(14),
 		.ctl_offs = 0x0338,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -163,6 +185,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "isp",
 		.sta_mask = BIT(12),
 		.ctl_offs = 0x0330,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -180,6 +204,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "isp2",
 		.sta_mask = BIT(13),
 		.ctl_offs = 0x0334,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -197,6 +223,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "mdp",
 		.sta_mask = BIT(19),
 		.ctl_offs = 0x034c,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -214,6 +242,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "venc",
 		.sta_mask = BIT(17),
 		.ctl_offs = 0x0344,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -231,6 +261,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "vdec",
 		.sta_mask = BIT(15),
 		.ctl_offs = 0x033c,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -248,6 +280,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "vdec2",
 		.sta_mask = BIT(16),
 		.ctl_offs = 0x0340,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -255,6 +289,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "cam",
 		.sta_mask = BIT(23),
 		.ctl_offs = 0x035c,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 		.bp_infracfg = {
@@ -284,6 +320,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "cam_rawa",
 		.sta_mask = BIT(24),
 		.ctl_offs = 0x0360,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -291,6 +329,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "cam_rawb",
 		.sta_mask = BIT(25),
 		.ctl_offs = 0x0364,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -298,6 +338,8 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 		.name = "cam_rawc",
 		.sta_mask = BIT(26),
 		.ctl_offs = 0x0368,
+		.pwr_sta_offs = 0x016c,
+		.pwr_sta2nd_offs = 0x0170,
 		.sram_pdn_bits = GENMASK(8, 8),
 		.sram_pdn_ack_bits = GENMASK(12, 12),
 	},
@@ -306,8 +348,6 @@ static const struct scpsys_domain_data scpsys_domain_data_mt8192[] = {
 static const struct scpsys_soc_data mt8192_scpsys_data = {
 	.domains_data = scpsys_domain_data_mt8192,
 	.num_domains = ARRAY_SIZE(scpsys_domain_data_mt8192),
-	.pwr_sta_offs = 0x016c,
-	.pwr_sta2nd_offs = 0x0170,
 };
 
 #endif /* __SOC_MEDIATEK_MT8192_PM_DOMAINS_H */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
index afd2fd74802d..ad06b6f90435 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.c
+++ b/drivers/soc/mediatek/mtk-pm-domains.c
@@ -60,10 +60,10 @@ static bool scpsys_domain_is_on(struct scpsys_domain *pd)
 	struct scpsys *scpsys = pd->scpsys;
 	u32 status, status2;
 
-	regmap_read(scpsys->base, scpsys->soc_data->pwr_sta_offs, &status);
+	regmap_read(scpsys->base, pd->data->pwr_sta_offs, &status);
 	status &= pd->data->sta_mask;
 
-	regmap_read(scpsys->base, scpsys->soc_data->pwr_sta2nd_offs, &status2);
+	regmap_read(scpsys->base, pd->data->pwr_sta2nd_offs, &status2);
 	status2 &= pd->data->sta_mask;
 
 	/* A domain is on when both status bits are set. */
diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
index 089a31679806..c233ed828f86 100644
--- a/drivers/soc/mediatek/mtk-pm-domains.h
+++ b/drivers/soc/mediatek/mtk-pm-domains.h
@@ -92,13 +92,13 @@ struct scpsys_domain_data {
 	u8 caps;
 	const struct scpsys_bus_prot_data bp_infracfg[SPM_MAX_BUS_PROT_DATA];
 	const struct scpsys_bus_prot_data bp_smi[SPM_MAX_BUS_PROT_DATA];
+	int pwr_sta_offs;
+	int pwr_sta2nd_offs;
 };
 
 struct scpsys_soc_data {
 	const struct scpsys_domain_data *domains_data;
 	int num_domains;
-	int pwr_sta_offs;
-	int pwr_sta2nd_offs;
 };
 
 #endif /* __SOC_MEDIATEK_MTK_PM_DOMAINS_H */
-- 
2.18.0

