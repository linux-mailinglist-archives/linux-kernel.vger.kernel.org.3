Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF074799B9
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhLRI2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:28:16 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37606 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232381AbhLRI2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:28:11 -0500
X-UUID: 5e414566af9e4ba78d2f7a82ace8231a-20211218
X-UUID: 5e414566af9e4ba78d2f7a82ace8231a-20211218
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 514525534; Sat, 18 Dec 2021 16:28:07 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 18 Dec 2021 16:28:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 18 Dec
 2021 16:28:05 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkcas11.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 18 Dec 2021 16:28:04 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: [PATCH v2 5/5] phy: phy-mtk-tphy: use new io helpers to access register
Date:   Sat, 18 Dec 2021 16:28:02 +0800
Message-ID: <20211218082802.5256-5-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use new helpers mtk_phy_clear/set/update_bits() to access registers

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2: new patch
---
 drivers/phy/mediatek/phy-mtk-tphy.c | 504 ++++++++++------------------
 1 file changed, 179 insertions(+), 325 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c b/drivers/phy/mediatek/phy-mtk-tphy.c
index 98a942c607a6..6d307102f4f6 100644
--- a/drivers/phy/mediatek/phy-mtk-tphy.c
+++ b/drivers/phy/mediatek/phy-mtk-tphy.c
@@ -8,7 +8,6 @@
 #include <dt-bindings/phy/phy.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
-#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -19,6 +18,8 @@
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include "phy-mtk-io.h"
+
 /* version V1 sub-banks offset base address */
 /* banks shared by multiple phys */
 #define SSUSB_SIFSLV_V1_SPLLC		0x000	/* shared by u3 phys */
@@ -401,15 +402,11 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 		return;
 
 	/* enable USB ring oscillator */
-	tmp = readl(com + U3P_USBPHYACR5);
-	tmp |= PA5_RG_U2_HSTX_SRCAL_EN;
-	writel(tmp, com + U3P_USBPHYACR5);
+	mtk_phy_set_bits(com + U3P_USBPHYACR5, PA5_RG_U2_HSTX_SRCAL_EN);
 	udelay(1);
 
 	/*enable free run clock */
-	tmp = readl(fmreg + U3P_U2FREQ_FMMONR1);
-	tmp |= P2F_RG_FRCK_EN;
-	writel(tmp, fmreg + U3P_U2FREQ_FMMONR1);
+	mtk_phy_set_bits(fmreg + U3P_U2FREQ_FMMONR1, P2F_RG_FRCK_EN);
 
 	/* set cycle count as 1024, and select u2 channel */
 	tmp = readl(fmreg + U3P_U2FREQ_FMCR0);
@@ -421,9 +418,7 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	writel(tmp, fmreg + U3P_U2FREQ_FMCR0);
 
 	/* enable frequency meter */
-	tmp = readl(fmreg + U3P_U2FREQ_FMCR0);
-	tmp |= P2F_RG_FREQDET_EN;
-	writel(tmp, fmreg + U3P_U2FREQ_FMCR0);
+	mtk_phy_set_bits(fmreg + U3P_U2FREQ_FMCR0, P2F_RG_FREQDET_EN);
 
 	/* ignore return value */
 	readl_poll_timeout(fmreg + U3P_U2FREQ_FMMONR1, tmp,
@@ -432,14 +427,10 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 	fm_out = readl(fmreg + U3P_U2FREQ_VALUE);
 
 	/* disable frequency meter */
-	tmp = readl(fmreg + U3P_U2FREQ_FMCR0);
-	tmp &= ~P2F_RG_FREQDET_EN;
-	writel(tmp, fmreg + U3P_U2FREQ_FMCR0);
+	mtk_phy_clear_bits(fmreg + U3P_U2FREQ_FMCR0, P2F_RG_FREQDET_EN);
 
 	/*disable free run clock */
-	tmp = readl(fmreg + U3P_U2FREQ_FMMONR1);
-	tmp &= ~P2F_RG_FRCK_EN;
-	writel(tmp, fmreg + U3P_U2FREQ_FMMONR1);
+	mtk_phy_clear_bits(fmreg + U3P_U2FREQ_FMMONR1, P2F_RG_FRCK_EN);
 
 	if (fm_out) {
 		/* ( 1024 / FM_OUT ) x reference clock frequency x coef */
@@ -455,63 +446,44 @@ static void hs_slew_rate_calibrate(struct mtk_tphy *tphy,
 		tphy->src_ref_clk, tphy->src_coef);
 
 	/* set HS slew rate */
-	tmp = readl(com + U3P_USBPHYACR5);
-	tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
-	tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(calibration_val);
-	writel(tmp, com + U3P_USBPHYACR5);
+	mtk_phy_update_bits(com + U3P_USBPHYACR5, PA5_RG_U2_HSTX_SRCTRL,
+			    PA5_RG_U2_HSTX_SRCTRL_VAL(calibration_val));
 
 	/* disable USB ring oscillator */
-	tmp = readl(com + U3P_USBPHYACR5);
-	tmp &= ~PA5_RG_U2_HSTX_SRCAL_EN;
-	writel(tmp, com + U3P_USBPHYACR5);
+	mtk_phy_clear_bits(com + U3P_USBPHYACR5, PA5_RG_U2_HSTX_SRCAL_EN);
 }
 
 static void u3_phy_instance_init(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
-	u32 tmp;
 
 	/* gating PCIe Analog XTAL clock */
-	tmp = readl(u3_banks->spllc + U3P_SPLLC_XTALCTL3);
-	tmp |= XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD;
-	writel(tmp, u3_banks->spllc + U3P_SPLLC_XTALCTL3);
+	mtk_phy_set_bits(u3_banks->spllc + U3P_SPLLC_XTALCTL3,
+			 XC3_RG_U3_XTAL_RX_PWD | XC3_RG_U3_FRC_XTAL_RX_PWD);
 
 	/* gating XSQ */
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG0);
-	tmp &= ~P3A_RG_XTAL_EXT_EN_U3;
-	tmp |= P3A_RG_XTAL_EXT_EN_U3_VAL(2);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG0);
-
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG9);
-	tmp &= ~P3A_RG_RX_DAC_MUX;
-	tmp |= P3A_RG_RX_DAC_MUX_VAL(4);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG9);
-
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG6);
-	tmp &= ~P3A_RG_TX_EIDLE_CM;
-	tmp |= P3A_RG_TX_EIDLE_CM_VAL(0xe);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG6);
-
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_CDR1);
-	tmp &= ~(P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1);
-	tmp |= P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_CDR1);
-
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_LFPS1);
-	tmp &= ~P3D_RG_FWAKE_TH;
-	tmp |= P3D_RG_FWAKE_TH_VAL(0x34);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_LFPS1);
-
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET1);
-	tmp &= ~P3D_RG_RXDET_STB2_SET;
-	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET1);
-
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET2);
-	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
-	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET2);
+	mtk_phy_update_bits(u3_banks->phya + U3P_U3_PHYA_DA_REG0,
+			    P3A_RG_XTAL_EXT_EN_U3, P3A_RG_XTAL_EXT_EN_U3_VAL(2));
+
+	mtk_phy_update_bits(u3_banks->phya + U3P_U3_PHYA_REG9,
+			    P3A_RG_RX_DAC_MUX, P3A_RG_RX_DAC_MUX_VAL(4));
+
+	mtk_phy_update_bits(u3_banks->phya + U3P_U3_PHYA_REG6,
+			    P3A_RG_TX_EIDLE_CM, P3A_RG_TX_EIDLE_CM_VAL(0xe));
+
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_CDR1,
+			    P3D_RG_CDR_BIR_LTD0 | P3D_RG_CDR_BIR_LTD1,
+			    P3D_RG_CDR_BIR_LTD0_VAL(0xc) | P3D_RG_CDR_BIR_LTD1_VAL(0x3));
+
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_LFPS1,
+			    P3D_RG_FWAKE_TH, P3D_RG_FWAKE_TH_VAL(0x34));
+
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_RXDET1,
+			    P3D_RG_RXDET_STB2_SET, P3D_RG_RXDET_STB2_SET_VAL(0x10));
+
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_RXDET2,
+			    P3D_RG_RXDET_STB2_SET_P3, P3D_RG_RXDET_STB2_SET_P3_VAL(0x10));
 
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
@@ -521,26 +493,20 @@ static void u2_phy_pll_26m_set(struct mtk_tphy *tphy,
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
-	u32 tmp;
 
 	if (!tphy->pdata->sw_pll_48m_to_26m)
 		return;
 
-	tmp = readl(com + U3P_USBPHYACR0);
-	tmp &= ~PA0_USB20_PLL_PREDIV;
-	tmp |= PA0_USB20_PLL_PREDIV_VAL(0);
-	writel(tmp, com + U3P_USBPHYACR0);
+	mtk_phy_update_bits(com + U3P_USBPHYACR0, PA0_USB20_PLL_PREDIV,
+			    PA0_USB20_PLL_PREDIV_VAL(0));
 
-	tmp = readl(com + U3P_USBPHYACR2);
-	tmp &= ~PA2_RG_U2PLL_BW;
-	tmp |= PA2_RG_U2PLL_BW_VAL(3);
-	writel(tmp, com + U3P_USBPHYACR2);
+	mtk_phy_update_bits(com + U3P_USBPHYACR2, PA2_RG_U2PLL_BW,
+			    PA2_RG_U2PLL_BW_VAL(3));
 
 	writel(P2R_RG_U2PLL_FBDIV_26M, com + U3P_U2PHYA_RESV);
 
-	tmp = readl(com + U3P_U2PHYA_RESV1);
-	tmp |= P2R_RG_U2PLL_FRA_EN | P2R_RG_U2PLL_REFCLK_SEL;
-	writel(tmp, com + U3P_U2PHYA_RESV1);
+	mtk_phy_set_bits(com + U3P_U2PHYA_RESV1,
+			 P2R_RG_U2PLL_FRA_EN | P2R_RG_U2PLL_REFCLK_SEL);
 }
 
 static void u2_phy_instance_init(struct mtk_tphy *tphy,
@@ -549,58 +515,40 @@ static void u2_phy_instance_init(struct mtk_tphy *tphy,
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
-	u32 tmp;
 
 	/* switch to USB function, and enable usb pll */
-	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~(P2C_FORCE_UART_EN | P2C_FORCE_SUSPENDM);
-	tmp |= P2C_RG_XCVRSEL_VAL(1) | P2C_RG_DATAIN_VAL(0);
-	writel(tmp, com + U3P_U2PHYDTM0);
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_FORCE_UART_EN | P2C_FORCE_SUSPENDM);
+
+	mtk_phy_update_bits(com + U3P_U2PHYDTM0, P2C_RG_XCVRSEL | P2C_RG_DATAIN,
+			    P2C_RG_XCVRSEL_VAL(1) | P2C_RG_DATAIN_VAL(0));
 
-	tmp = readl(com + U3P_U2PHYDTM1);
-	tmp &= ~P2C_RG_UART_EN;
-	writel(tmp, com + U3P_U2PHYDTM1);
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM1, P2C_RG_UART_EN);
 
-	tmp = readl(com + U3P_USBPHYACR0);
-	tmp |= PA0_RG_USB20_INTR_EN;
-	writel(tmp, com + U3P_USBPHYACR0);
+	mtk_phy_set_bits(com + U3P_USBPHYACR0, PA0_RG_USB20_INTR_EN);
 
 	/* disable switch 100uA current to SSUSB */
-	tmp = readl(com + U3P_USBPHYACR5);
-	tmp &= ~PA5_RG_U2_HS_100U_U3_EN;
-	writel(tmp, com + U3P_USBPHYACR5);
-
-	if (!index) {
-		tmp = readl(com + U3P_U2PHYACR4);
-		tmp &= ~P2C_U2_GPIO_CTR_MSK;
-		writel(tmp, com + U3P_U2PHYACR4);
-	}
+	mtk_phy_clear_bits(com + U3P_USBPHYACR5, PA5_RG_U2_HS_100U_U3_EN);
+
+	if (!index)
+		mtk_phy_clear_bits(com + U3P_U2PHYACR4, P2C_U2_GPIO_CTR_MSK);
 
 	if (tphy->pdata->avoid_rx_sen_degradation) {
 		if (!index) {
-			tmp = readl(com + U3P_USBPHYACR2);
-			tmp |= PA2_RG_SIF_U2PLL_FORCE_EN;
-			writel(tmp, com + U3P_USBPHYACR2);
+			mtk_phy_set_bits(com + U3P_USBPHYACR2, PA2_RG_SIF_U2PLL_FORCE_EN);
 
-			tmp = readl(com + U3D_U2PHYDCR0);
-			tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
-			writel(tmp, com + U3D_U2PHYDCR0);
+			mtk_phy_clear_bits(com + U3D_U2PHYDCR0, P2C_RG_SIF_U2PLL_FORCE_ON);
 		} else {
-			tmp = readl(com + U3D_U2PHYDCR0);
-			tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
-			writel(tmp, com + U3D_U2PHYDCR0);
+			mtk_phy_set_bits(com + U3D_U2PHYDCR0, P2C_RG_SIF_U2PLL_FORCE_ON);
 
-			tmp = readl(com + U3P_U2PHYDTM0);
-			tmp |= P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM;
-			writel(tmp, com + U3P_U2PHYDTM0);
+			mtk_phy_set_bits(com + U3P_U2PHYDTM0,
+					 P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
 		}
 	}
 
-	tmp = readl(com + U3P_USBPHYACR6);
-	tmp &= ~PA6_RG_U2_BC11_SW_EN;	/* DP/DM BC1.1 path Disable */
-	tmp &= ~PA6_RG_U2_SQTH;
-	tmp |= PA6_RG_U2_SQTH_VAL(2);
-	writel(tmp, com + U3P_USBPHYACR6);
+	/* DP/DM BC1.1 path Disable */
+	mtk_phy_clear_bits(com + U3P_USBPHYACR6, PA6_RG_U2_BC11_SW_EN);
+
+	mtk_phy_update_bits(com + U3P_USBPHYACR6, PA6_RG_U2_SQTH, PA6_RG_U2_SQTH_VAL(2));
 
 	/* Workaround only for mt8195, HW fix it for others (V3) */
 	u2_phy_pll_26m_set(tphy, instance);
@@ -614,30 +562,21 @@ static void u2_phy_instance_power_on(struct mtk_tphy *tphy,
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
-	u32 tmp;
 
-	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~(P2C_RG_XCVRSEL | P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
-	writel(tmp, com + U3P_U2PHYDTM0);
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM0,
+			   P2C_RG_XCVRSEL | P2C_RG_DATAIN | P2C_DTM0_PART_MASK);
 
 	/* OTG Enable */
-	tmp = readl(com + U3P_USBPHYACR6);
-	tmp |= PA6_RG_U2_OTG_VBUSCMP_EN;
-	writel(tmp, com + U3P_USBPHYACR6);
+	mtk_phy_set_bits(com + U3P_USBPHYACR6, PA6_RG_U2_OTG_VBUSCMP_EN);
+
+	mtk_phy_set_bits(com + U3P_U2PHYDTM1, P2C_RG_VBUSVALID | P2C_RG_AVALID);
 
-	tmp = readl(com + U3P_U2PHYDTM1);
-	tmp |= P2C_RG_VBUSVALID | P2C_RG_AVALID;
-	tmp &= ~P2C_RG_SESSEND;
-	writel(tmp, com + U3P_U2PHYDTM1);
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM1, P2C_RG_SESSEND);
 
 	if (tphy->pdata->avoid_rx_sen_degradation && index) {
-		tmp = readl(com + U3D_U2PHYDCR0);
-		tmp |= P2C_RG_SIF_U2PLL_FORCE_ON;
-		writel(tmp, com + U3D_U2PHYDCR0);
+		mtk_phy_set_bits(com + U3D_U2PHYDCR0, P2C_RG_SIF_U2PLL_FORCE_ON);
 
-		tmp = readl(com + U3P_U2PHYDTM0);
-		tmp |= P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM;
-		writel(tmp, com + U3P_U2PHYDTM0);
+		mtk_phy_set_bits(com + U3P_U2PHYDTM0, P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
 	}
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
 }
@@ -648,30 +587,20 @@ static void u2_phy_instance_power_off(struct mtk_tphy *tphy,
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
-	u32 tmp;
 
-	tmp = readl(com + U3P_U2PHYDTM0);
-	tmp &= ~(P2C_RG_XCVRSEL | P2C_RG_DATAIN);
-	writel(tmp, com + U3P_U2PHYDTM0);
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_RG_XCVRSEL | P2C_RG_DATAIN);
 
 	/* OTG Disable */
-	tmp = readl(com + U3P_USBPHYACR6);
-	tmp &= ~PA6_RG_U2_OTG_VBUSCMP_EN;
-	writel(tmp, com + U3P_USBPHYACR6);
+	mtk_phy_clear_bits(com + U3P_USBPHYACR6, PA6_RG_U2_OTG_VBUSCMP_EN);
+
+	mtk_phy_clear_bits(com + U3P_U2PHYDTM1, P2C_RG_VBUSVALID | P2C_RG_AVALID);
 
-	tmp = readl(com + U3P_U2PHYDTM1);
-	tmp &= ~(P2C_RG_VBUSVALID | P2C_RG_AVALID);
-	tmp |= P2C_RG_SESSEND;
-	writel(tmp, com + U3P_U2PHYDTM1);
+	mtk_phy_set_bits(com + U3P_U2PHYDTM1, P2C_RG_SESSEND);
 
 	if (tphy->pdata->avoid_rx_sen_degradation && index) {
-		tmp = readl(com + U3P_U2PHYDTM0);
-		tmp &= ~(P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
-		writel(tmp, com + U3P_U2PHYDTM0);
+		mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_RG_SUSPENDM | P2C_FORCE_SUSPENDM);
 
-		tmp = readl(com + U3D_U2PHYDCR0);
-		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
-		writel(tmp, com + U3D_U2PHYDCR0);
+		mtk_phy_clear_bits(com + U3D_U2PHYDCR0, P2C_RG_SIF_U2PLL_FORCE_ON);
 	}
 
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, index);
@@ -683,16 +612,11 @@ static void u2_phy_instance_exit(struct mtk_tphy *tphy,
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
 	u32 index = instance->index;
-	u32 tmp;
 
 	if (tphy->pdata->avoid_rx_sen_degradation && index) {
-		tmp = readl(com + U3D_U2PHYDCR0);
-		tmp &= ~P2C_RG_SIF_U2PLL_FORCE_ON;
-		writel(tmp, com + U3D_U2PHYDCR0);
+		mtk_phy_clear_bits(com + U3D_U2PHYDCR0, P2C_RG_SIF_U2PLL_FORCE_ON);
 
-		tmp = readl(com + U3P_U2PHYDTM0);
-		tmp &= ~P2C_FORCE_SUSPENDM;
-		writel(tmp, com + U3P_U2PHYDTM0);
+		mtk_phy_clear_bits(com + U3P_U2PHYDTM0, P2C_FORCE_SUSPENDM);
 	}
 }
 
@@ -725,69 +649,50 @@ static void pcie_phy_instance_init(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
-	u32 tmp;
+	void __iomem *phya = u3_banks->phya;
 
 	if (tphy->pdata->version != MTK_PHY_V1)
 		return;
 
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG0);
-	tmp &= ~(P3A_RG_XTAL_EXT_PE1H | P3A_RG_XTAL_EXT_PE2H);
-	tmp |= P3A_RG_XTAL_EXT_PE1H_VAL(0x2) | P3A_RG_XTAL_EXT_PE2H_VAL(0x2);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG0);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG0,
+			    P3A_RG_XTAL_EXT_PE1H | P3A_RG_XTAL_EXT_PE2H,
+			    P3A_RG_XTAL_EXT_PE1H_VAL(0x2) | P3A_RG_XTAL_EXT_PE2H_VAL(0x2));
 
 	/* ref clk drive */
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG1);
-	tmp &= ~P3A_RG_CLKDRV_AMP;
-	tmp |= P3A_RG_CLKDRV_AMP_VAL(0x4);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG1);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_REG1, P3A_RG_CLKDRV_AMP,
+			    P3A_RG_CLKDRV_AMP_VAL(0x4));
 
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG0);
-	tmp &= ~P3A_RG_CLKDRV_OFF;
-	tmp |= P3A_RG_CLKDRV_OFF_VAL(0x1);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG0);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_REG0, P3A_RG_CLKDRV_OFF,
+			    P3A_RG_CLKDRV_OFF_VAL(0x1));
 
 	/* SSC delta -5000ppm */
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG20);
-	tmp &= ~P3A_RG_PLL_DELTA1_PE2H;
-	tmp |= P3A_RG_PLL_DELTA1_PE2H_VAL(0x3c);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG20);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG20, P3A_RG_PLL_DELTA1_PE2H,
+			    P3A_RG_PLL_DELTA1_PE2H_VAL(0x3c));
 
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG25);
-	tmp &= ~P3A_RG_PLL_DELTA_PE2H;
-	tmp |= P3A_RG_PLL_DELTA_PE2H_VAL(0x36);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG25);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG25, P3A_RG_PLL_DELTA_PE2H,
+			    P3A_RG_PLL_DELTA_PE2H_VAL(0x36));
 
 	/* change pll BW 0.6M */
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG5);
-	tmp &= ~(P3A_RG_PLL_BR_PE2H | P3A_RG_PLL_IC_PE2H);
-	tmp |= P3A_RG_PLL_BR_PE2H_VAL(0x1) | P3A_RG_PLL_IC_PE2H_VAL(0x1);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG5);
-
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG4);
-	tmp &= ~(P3A_RG_PLL_DIVEN_PE2H | P3A_RG_PLL_BC_PE2H);
-	tmp |= P3A_RG_PLL_BC_PE2H_VAL(0x3);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG4);
-
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG6);
-	tmp &= ~P3A_RG_PLL_IR_PE2H;
-	tmp |= P3A_RG_PLL_IR_PE2H_VAL(0x2);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG6);
-
-	tmp = readl(u3_banks->phya + U3P_U3_PHYA_DA_REG7);
-	tmp &= ~P3A_RG_PLL_BP_PE2H;
-	tmp |= P3A_RG_PLL_BP_PE2H_VAL(0xa);
-	writel(tmp, u3_banks->phya + U3P_U3_PHYA_DA_REG7);
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG5,
+			    P3A_RG_PLL_BR_PE2H | P3A_RG_PLL_IC_PE2H,
+			    P3A_RG_PLL_BR_PE2H_VAL(0x1) | P3A_RG_PLL_IC_PE2H_VAL(0x1));
+
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG4,
+			    P3A_RG_PLL_DIVEN_PE2H | P3A_RG_PLL_BC_PE2H,
+			    P3A_RG_PLL_BC_PE2H_VAL(0x3));
+
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG6, P3A_RG_PLL_IR_PE2H,
+			    P3A_RG_PLL_IR_PE2H_VAL(0x2));
+
+	mtk_phy_update_bits(phya + U3P_U3_PHYA_DA_REG7, P3A_RG_PLL_BP_PE2H,
+			    P3A_RG_PLL_BP_PE2H_VAL(0xa));
 
 	/* Tx Detect Rx Timing: 10us -> 5us */
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET1);
-	tmp &= ~P3D_RG_RXDET_STB2_SET;
-	tmp |= P3D_RG_RXDET_STB2_SET_VAL(0x10);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET1);
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_RXDET1,
+			    P3D_RG_RXDET_STB2_SET, P3D_RG_RXDET_STB2_SET_VAL(0x10));
 
-	tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RXDET2);
-	tmp &= ~P3D_RG_RXDET_STB2_SET_P3;
-	tmp |= P3D_RG_RXDET_STB2_SET_P3_VAL(0x10);
-	writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RXDET2);
+	mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_RXDET2,
+			    P3D_RG_RXDET_STB2_SET_P3, P3D_RG_RXDET_STB2_SET_P3_VAL(0x10));
 
 	/* wait for PCIe subsys register to active */
 	usleep_range(2500, 3000);
@@ -798,15 +703,12 @@ static void pcie_phy_instance_power_on(struct mtk_tphy *tphy,
 	struct mtk_phy_instance *instance)
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
-	u32 tmp;
 
-	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
-	tmp &= ~(P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST);
-	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+	mtk_phy_clear_bits(bank->chip + U3P_U3_CHIP_GPIO_CTLD,
+			   P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST);
 
-	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
-	tmp &= ~(P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD);
-	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+	mtk_phy_clear_bits(bank->chip + U3P_U3_CHIP_GPIO_CTLE,
+			   P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD);
 }
 
 static void pcie_phy_instance_power_off(struct mtk_tphy *tphy,
@@ -814,15 +716,12 @@ static void pcie_phy_instance_power_off(struct mtk_tphy *tphy,
 
 {
 	struct u3phy_banks *bank = &instance->u3_banks;
-	u32 tmp;
 
-	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLD);
-	tmp |= P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST;
-	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLD);
+	mtk_phy_set_bits(bank->chip + U3P_U3_CHIP_GPIO_CTLD,
+			 P3C_FORCE_IP_SW_RST | P3C_REG_IP_SW_RST);
 
-	tmp = readl(bank->chip + U3P_U3_CHIP_GPIO_CTLE);
-	tmp |= P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD;
-	writel(tmp, bank->chip + U3P_U3_CHIP_GPIO_CTLE);
+	mtk_phy_set_bits(bank->chip + U3P_U3_CHIP_GPIO_CTLE,
+			 P3C_RG_SWRST_U3_PHYD_FORCE_EN | P3C_RG_SWRST_U3_PHYD);
 }
 
 static void sata_phy_instance_init(struct mtk_tphy *tphy,
@@ -830,55 +729,42 @@ static void sata_phy_instance_init(struct mtk_tphy *tphy,
 {
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
 	void __iomem *phyd = u3_banks->phyd;
-	u32 tmp;
 
 	/* charge current adjustment */
-	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL6);
-	tmp &= ~(RG_CDR_BIRLTR_GEN1_MSK | RG_CDR_BC_GEN1_MSK);
-	tmp |= RG_CDR_BIRLTR_GEN1_VAL(0x6) | RG_CDR_BC_GEN1_VAL(0x1a);
-	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL6);
-
-	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL4);
-	tmp &= ~RG_CDR_BIRLTD0_GEN1_MSK;
-	tmp |= RG_CDR_BIRLTD0_GEN1_VAL(0x18);
-	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL4);
-
-	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL5);
-	tmp &= ~RG_CDR_BIRLTD0_GEN3_MSK;
-	tmp |= RG_CDR_BIRLTD0_GEN3_VAL(0x06);
-	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL5);
-
-	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL4);
-	tmp &= ~(RG_CDR_BICLTR_GEN1_MSK | RG_CDR_BR_GEN2_MSK);
-	tmp |= RG_CDR_BICLTR_GEN1_VAL(0x0c) | RG_CDR_BR_GEN2_VAL(0x07);
-	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL4);
-
-	tmp = readl(phyd + PHYD_CTRL_SIGNAL_MODE4);
-	tmp &= ~(RG_CDR_BICLTD0_GEN1_MSK | RG_CDR_BICLTD1_GEN1_MSK);
-	tmp |= RG_CDR_BICLTD0_GEN1_VAL(0x08) | RG_CDR_BICLTD1_GEN1_VAL(0x02);
-	writel(tmp, phyd + PHYD_CTRL_SIGNAL_MODE4);
-
-	tmp = readl(phyd + PHYD_DESIGN_OPTION2);
-	tmp &= ~RG_LOCK_CNT_SEL_MSK;
-	tmp |= RG_LOCK_CNT_SEL_VAL(0x02);
-	writel(tmp, phyd + PHYD_DESIGN_OPTION2);
-
-	tmp = readl(phyd + PHYD_DESIGN_OPTION9);
-	tmp &= ~(RG_T2_MIN_MSK | RG_TG_MIN_MSK |
-		 RG_T2_MAX_MSK | RG_TG_MAX_MSK);
-	tmp |= RG_T2_MIN_VAL(0x12) | RG_TG_MIN_VAL(0x04) |
-	       RG_T2_MAX_VAL(0x31) | RG_TG_MAX_VAL(0x0e);
-	writel(tmp, phyd + PHYD_DESIGN_OPTION9);
-
-	tmp = readl(phyd + ANA_RG_CTRL_SIGNAL1);
-	tmp &= ~RG_IDRV_0DB_GEN1_MSK;
-	tmp |= RG_IDRV_0DB_GEN1_VAL(0x20);
-	writel(tmp, phyd + ANA_RG_CTRL_SIGNAL1);
-
-	tmp = readl(phyd + ANA_EQ_EYE_CTRL_SIGNAL1);
-	tmp &= ~RG_EQ_DLEQ_LFI_GEN1_MSK;
-	tmp |= RG_EQ_DLEQ_LFI_GEN1_VAL(0x03);
-	writel(tmp, phyd + ANA_EQ_EYE_CTRL_SIGNAL1);
+	mtk_phy_update_bits(phyd + ANA_RG_CTRL_SIGNAL6,
+			    RG_CDR_BIRLTR_GEN1_MSK | RG_CDR_BC_GEN1_MSK,
+			    RG_CDR_BIRLTR_GEN1_VAL(0x6) | RG_CDR_BC_GEN1_VAL(0x1a));
+
+	mtk_phy_update_bits(phyd + ANA_EQ_EYE_CTRL_SIGNAL4, RG_CDR_BIRLTD0_GEN1_MSK,
+			    RG_CDR_BIRLTD0_GEN1_VAL(0x18));
+
+	mtk_phy_update_bits(phyd + ANA_EQ_EYE_CTRL_SIGNAL5, RG_CDR_BIRLTD0_GEN3_MSK,
+			    RG_CDR_BIRLTD0_GEN3_VAL(0x06));
+
+	mtk_phy_update_bits(phyd + ANA_RG_CTRL_SIGNAL4,
+			    RG_CDR_BICLTR_GEN1_MSK | RG_CDR_BR_GEN2_MSK,
+			    RG_CDR_BICLTR_GEN1_VAL(0x0c) | RG_CDR_BR_GEN2_VAL(0x07));
+
+	mtk_phy_update_bits(phyd + PHYD_CTRL_SIGNAL_MODE4,
+			    RG_CDR_BICLTD0_GEN1_MSK | RG_CDR_BICLTD1_GEN1_MSK,
+			    RG_CDR_BICLTD0_GEN1_VAL(0x08) | RG_CDR_BICLTD1_GEN1_VAL(0x02));
+
+	mtk_phy_update_bits(phyd + PHYD_DESIGN_OPTION2, RG_LOCK_CNT_SEL_MSK,
+			    RG_LOCK_CNT_SEL_VAL(0x02));
+
+	mtk_phy_update_bits(phyd + PHYD_DESIGN_OPTION9,
+			    RG_T2_MIN_MSK | RG_TG_MIN_MSK,
+			    RG_T2_MIN_VAL(0x12) | RG_TG_MIN_VAL(0x04));
+
+	mtk_phy_update_bits(phyd + PHYD_DESIGN_OPTION9,
+			    RG_T2_MAX_MSK | RG_TG_MAX_MSK,
+			    RG_T2_MAX_VAL(0x31) | RG_TG_MAX_VAL(0x0e));
+
+	mtk_phy_update_bits(phyd + ANA_RG_CTRL_SIGNAL1, RG_IDRV_0DB_GEN1_MSK,
+			    RG_IDRV_0DB_GEN1_VAL(0x20));
+
+	mtk_phy_update_bits(phyd + ANA_EQ_EYE_CTRL_SIGNAL1, RG_EQ_DLEQ_LFI_GEN1_MSK,
+			    RG_EQ_DLEQ_LFI_GEN1_VAL(0x03));
 
 	dev_dbg(tphy->dev, "%s(%d)\n", __func__, instance->index);
 }
@@ -966,48 +852,29 @@ static void u2_phy_props_set(struct mtk_tphy *tphy,
 {
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	void __iomem *com = u2_banks->com;
-	u32 tmp;
 
-	if (instance->bc12_en) {
-		tmp = readl(com + U3P_U2PHYBC12C);
-		tmp |= P2C_RG_CHGDT_EN;	/* BC1.2 path Enable */
-		writel(tmp, com + U3P_U2PHYBC12C);
-	}
+	if (instance->bc12_en) /* BC1.2 path Enable */
+		mtk_phy_set_bits(com + U3P_U2PHYBC12C, P2C_RG_CHGDT_EN);
 
-	if (tphy->pdata->version < MTK_PHY_V3 && instance->eye_src) {
-		tmp = readl(com + U3P_USBPHYACR5);
-		tmp &= ~PA5_RG_U2_HSTX_SRCTRL;
-		tmp |= PA5_RG_U2_HSTX_SRCTRL_VAL(instance->eye_src);
-		writel(tmp, com + U3P_USBPHYACR5);
-	}
+	if (tphy->pdata->version < MTK_PHY_V3 && instance->eye_src)
+		mtk_phy_update_bits(com + U3P_USBPHYACR5, PA5_RG_U2_HSTX_SRCTRL,
+				    PA5_RG_U2_HSTX_SRCTRL_VAL(instance->eye_src));
 
-	if (instance->eye_vrt) {
-		tmp = readl(com + U3P_USBPHYACR1);
-		tmp &= ~PA1_RG_VRT_SEL;
-		tmp |= PA1_RG_VRT_SEL_VAL(instance->eye_vrt);
-		writel(tmp, com + U3P_USBPHYACR1);
-	}
+	if (instance->eye_vrt)
+		mtk_phy_update_bits(com + U3P_USBPHYACR1, PA1_RG_VRT_SEL,
+				    PA1_RG_VRT_SEL_VAL(instance->eye_vrt));
 
-	if (instance->eye_term) {
-		tmp = readl(com + U3P_USBPHYACR1);
-		tmp &= ~PA1_RG_TERM_SEL;
-		tmp |= PA1_RG_TERM_SEL_VAL(instance->eye_term);
-		writel(tmp, com + U3P_USBPHYACR1);
-	}
+	if (instance->eye_term)
+		mtk_phy_update_bits(com + U3P_USBPHYACR1, PA1_RG_TERM_SEL,
+				    PA1_RG_TERM_SEL_VAL(instance->eye_term));
 
-	if (instance->intr) {
-		tmp = readl(com + U3P_USBPHYACR1);
-		tmp &= ~PA1_RG_INTR_CAL;
-		tmp |= PA1_RG_INTR_CAL_VAL(instance->intr);
-		writel(tmp, com + U3P_USBPHYACR1);
-	}
+	if (instance->intr)
+		mtk_phy_update_bits(com + U3P_USBPHYACR1, PA1_RG_INTR_CAL,
+				    PA1_RG_INTR_CAL_VAL(instance->intr));
 
-	if (instance->discth) {
-		tmp = readl(com + U3P_USBPHYACR6);
-		tmp &= ~PA6_RG_U2_DISCTH;
-		tmp |= PA6_RG_U2_DISCTH_VAL(instance->discth);
-		writel(tmp, com + U3P_USBPHYACR6);
-	}
+	if (instance->discth)
+		mtk_phy_update_bits(com + U3P_USBPHYACR6, PA6_RG_U2_DISCTH,
+				    PA6_RG_U2_DISCTH_VAL(instance->discth));
 }
 
 /* type switch for usb3/pcie/sgmii/sata */
@@ -1147,44 +1014,31 @@ static void phy_efuse_set(struct mtk_phy_instance *instance)
 	struct device *dev = &instance->phy->dev;
 	struct u2phy_banks *u2_banks = &instance->u2_banks;
 	struct u3phy_banks *u3_banks = &instance->u3_banks;
-	u32 tmp;
 
 	if (!instance->efuse_sw_en)
 		return;
 
 	switch (instance->type) {
 	case PHY_TYPE_USB2:
-		tmp = readl(u2_banks->misc + U3P_MISC_REG1);
-		tmp |= MR1_EFUSE_AUTO_LOAD_DIS;
-		writel(tmp, u2_banks->misc + U3P_MISC_REG1);
-
-		tmp = readl(u2_banks->com + U3P_USBPHYACR1);
-		tmp &= ~PA1_RG_INTR_CAL;
-		tmp |= PA1_RG_INTR_CAL_VAL(instance->efuse_intr);
-		writel(tmp, u2_banks->com + U3P_USBPHYACR1);
+		mtk_phy_set_bits(u2_banks->misc + U3P_MISC_REG1, MR1_EFUSE_AUTO_LOAD_DIS);
+
+		mtk_phy_update_bits(u2_banks->com + U3P_USBPHYACR1, PA1_RG_INTR_CAL,
+				    PA1_RG_INTR_CAL_VAL(instance->efuse_intr));
 		break;
 	case PHY_TYPE_USB3:
 	case PHY_TYPE_PCIE:
-		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_RSV);
-		tmp |= P3D_RG_EFUSE_AUTO_LOAD_DIS;
-		writel(tmp, u3_banks->phyd + U3P_U3_PHYD_RSV);
-
-		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL0);
-		tmp &= ~P3D_RG_TX_IMPEL;
-		tmp |= P3D_RG_TX_IMPEL_VAL(instance->efuse_tx_imp);
-		tmp |= P3D_RG_FORCE_TX_IMPEL;
-		writel(tmp, u3_banks->phyd + U3P_U3_PHYD_IMPCAL0);
-
-		tmp = readl(u3_banks->phyd + U3P_U3_PHYD_IMPCAL1);
-		tmp &= ~P3D_RG_RX_IMPEL;
-		tmp |= P3D_RG_RX_IMPEL_VAL(instance->efuse_rx_imp);
-		tmp |= P3D_RG_FORCE_RX_IMPEL;
-		writel(tmp, u3_banks->phyd + U3P_U3_PHYD_IMPCAL1);
-
-		tmp = readl(u3_banks->phya + U3P_U3_PHYA_REG0);
-		tmp &= ~P3A_RG_IEXT_INTR;
-		tmp |= P3A_RG_IEXT_INTR_VAL(instance->efuse_intr);
-		writel(tmp, u3_banks->phya + U3P_U3_PHYA_REG0);
+		mtk_phy_set_bits(u3_banks->phyd + U3P_U3_PHYD_RSV, P3D_RG_EFUSE_AUTO_LOAD_DIS);
+
+		mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_TX_IMPEL,
+				    P3D_RG_TX_IMPEL_VAL(instance->efuse_tx_imp));
+		mtk_phy_set_bits(u3_banks->phyd + U3P_U3_PHYD_IMPCAL0, P3D_RG_FORCE_TX_IMPEL);
+
+		mtk_phy_update_bits(u3_banks->phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_RX_IMPEL,
+				    P3D_RG_RX_IMPEL_VAL(instance->efuse_rx_imp));
+		mtk_phy_set_bits(u3_banks->phyd + U3P_U3_PHYD_IMPCAL1, P3D_RG_FORCE_RX_IMPEL);
+
+		mtk_phy_update_bits(u3_banks->phya + U3P_U3_PHYA_REG0, P3A_RG_IEXT_INTR,
+				    P3A_RG_IEXT_INTR_VAL(instance->efuse_intr));
 		break;
 	default:
 		dev_warn(dev, "no sw efuse for type %d\n", instance->type);
-- 
2.18.0

