Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDC65A9665
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbiIAMKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiIAMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:10:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491ECDF658
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662034246; x=1693570246;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RIo2pBaslBQzwR75AbcPm8a1ycfCen3KShSxpD0kInc=;
  b=wHhC3LmTHXbwUW5XuRrYFijd2YusLgLFvr/tzay3AY8jcAICYMoG/TqQ
   iNPWYdxC6uwHal+sSk3Jv9SLyAdPiC2RQsgHVLxS/aKRIU2Y1sFZLpw0b
   2NBybzvX5FqzI7ExhVqOeCf5FaqGIbzFPhXcJ5IBrHfl1ftJ66HDd1bHI
   pkbKtjpTAk7ThBdO/wMLsex/gPhZV/hdLjixKwTIQjoopSxv8E3K5jo6V
   Bn+DlHwnRjMC983p3i00ylM39BwVFWAh3RXb54at4XYrEG2V6jKtPqVIy
   gHRuy0I/Hcy+Y/lU/Bmv+xw8D9T8ie+8TFijKhQoJbqaZ4ssBELePD1OY
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="188977520"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Sep 2022 05:10:43 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 1 Sep 2022 05:10:41 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 1 Sep 2022 05:10:40 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <rmk+kernel@armlinux.org.uk>,
        <UNGLinuxDriver@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] phy: Add RGMII support on lan966x
Date:   Thu, 1 Sep 2022 14:14:55 +0200
Message-ID: <20220901121455.245103-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The serdes driver contains also a mux to decide which interface type to
use. Currently the driver supports GMII/SGMII/QSGMII and partially RGMII.
As it doesn't support all the other RGMII interfaces like
RGMII_TXID/RXID/ID and it could run only at 1G.
Therefore extend this for all the other speeds(10/100) and also allow
the other interfaces.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/lan966x_serdes.c      | 99 ++++++++++++++++++---
 drivers/phy/microchip/lan966x_serdes_regs.h | 42 +++++++++
 2 files changed, 129 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index e86a879b92b5..fbc725ffa4ab 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -42,7 +42,10 @@
 #define SERDES_MUX_QSGMII(i, p, m, c) \
 	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_QSGMII, m, c)
 #define SERDES_MUX_RGMII(i, p, m, c) \
-	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII, m, c)
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII, m, c), \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII_TXID, m, c), \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII_RXID, m, c), \
+	SERDES_MUX(i, p, PHY_MODE_ETHERNET, PHY_INTERFACE_MODE_RGMII_ID, m, c)
 
 static void lan_rmw_(u32 val, u32 mask, void __iomem *mem, u32 offset)
 {
@@ -94,21 +97,29 @@ static const struct serdes_mux lan966x_serdes_muxes[] = {
 			 HSIO_HW_CFG_SD6G_1_CFG_SET(1)),
 
 	SERDES_MUX_RGMII(RGMII(0), 2, HSIO_HW_CFG_RGMII_0_CFG |
-			 HSIO_HW_CFG_RGMII_ENA,
-			 HSIO_HW_CFG_RGMII_0_CFG_SET(BIT(0)) |
-			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0))),
+			 HSIO_HW_CFG_RGMII_ENA |
+			 HSIO_HW_CFG_GMII_ENA,
+			 HSIO_HW_CFG_RGMII_0_CFG_SET(0) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0)) |
+			 HSIO_HW_CFG_GMII_ENA_SET(BIT(2))),
 	SERDES_MUX_RGMII(RGMII(1), 3, HSIO_HW_CFG_RGMII_1_CFG |
-			 HSIO_HW_CFG_RGMII_ENA,
-			 HSIO_HW_CFG_RGMII_1_CFG_SET(BIT(0)) |
-			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1))),
+			 HSIO_HW_CFG_RGMII_ENA |
+			 HSIO_HW_CFG_GMII_ENA,
+			 HSIO_HW_CFG_RGMII_1_CFG_SET(0) |
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1)) |
+			 HSIO_HW_CFG_GMII_ENA_SET(BIT(3))),
 	SERDES_MUX_RGMII(RGMII(0), 5, HSIO_HW_CFG_RGMII_0_CFG |
-			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_ENA |
+			 HSIO_HW_CFG_GMII_ENA,
 			 HSIO_HW_CFG_RGMII_0_CFG_SET(BIT(0)) |
-			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0))),
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(0)) |
+			 HSIO_HW_CFG_GMII_ENA_SET(BIT(5))),
 	SERDES_MUX_RGMII(RGMII(1), 6, HSIO_HW_CFG_RGMII_1_CFG |
-			 HSIO_HW_CFG_RGMII_ENA,
+			 HSIO_HW_CFG_RGMII_ENA |
+			 HSIO_HW_CFG_GMII_ENA,
 			 HSIO_HW_CFG_RGMII_1_CFG_SET(BIT(0)) |
-			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1))),
+			 HSIO_HW_CFG_RGMII_ENA_SET(BIT(1)) |
+			 HSIO_HW_CFG_GMII_ENA_SET(BIT(6))),
 };
 
 struct serdes_ctrl {
@@ -382,6 +393,67 @@ static int lan966x_sd6g40_setup(struct serdes_macro *macro, u32 idx, int mode)
 	return lan966x_sd6g40_setup_lane(macro, conf, idx);
 }
 
+static int lan966x_rgmii_setup(struct serdes_macro *macro, u32 idx, int mode)
+{
+	bool tx_delay = false;
+	bool rx_delay = false;
+
+	/* Configure RGMII */
+	lan_rmw(HSIO_RGMII_CFG_RGMII_RX_RST_SET(0) |
+		HSIO_RGMII_CFG_RGMII_TX_RST_SET(0) |
+		HSIO_RGMII_CFG_TX_CLK_CFG_SET(macro->speed == SPEED_1000 ? 1 :
+					      macro->speed == SPEED_100 ? 2 :
+					      macro->speed == SPEED_10 ? 3 : 0),
+		HSIO_RGMII_CFG_RGMII_RX_RST |
+		HSIO_RGMII_CFG_RGMII_TX_RST |
+		HSIO_RGMII_CFG_TX_CLK_CFG,
+		macro->ctrl->regs, HSIO_RGMII_CFG(idx));
+
+	if (mode == PHY_INTERFACE_MODE_RGMII ||
+	    mode == PHY_INTERFACE_MODE_RGMII_TXID)
+		rx_delay = true;
+
+	if (mode == PHY_INTERFACE_MODE_RGMII ||
+	    mode == PHY_INTERFACE_MODE_RGMII_RXID)
+		tx_delay = true;
+
+	/* Setup DLL configuration */
+	lan_rmw(HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(rx_delay),
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA,
+		macro->ctrl->regs, HSIO_DLL_CFG(idx == 0 ? 0x0 : 0x2));
+
+	lan_rmw(HSIO_DLL_CFG_DELAY_ENA_SET(rx_delay),
+		HSIO_DLL_CFG_DELAY_ENA,
+		macro->ctrl->regs, HSIO_DLL_CFG(idx == 0 ? 0x0 : 0x2));
+
+	lan_rmw(HSIO_DLL_CFG_DLL_RST_SET(0) |
+		HSIO_DLL_CFG_DLL_ENA_SET(tx_delay),
+		HSIO_DLL_CFG_DLL_RST |
+		HSIO_DLL_CFG_DLL_ENA,
+		macro->ctrl->regs, HSIO_DLL_CFG(idx == 0 ? 0x1 : 0x3));
+
+	lan_rmw(HSIO_DLL_CFG_DELAY_ENA_SET(tx_delay),
+		HSIO_DLL_CFG_DELAY_ENA,
+		macro->ctrl->regs, HSIO_DLL_CFG(idx == 0 ? 0x1 : 0x3));
+
+	return 0;
+}
+
+static int serdes_set_speed(struct phy *phy, int speed)
+{
+	struct serdes_macro *macro = phy_get_drvdata(phy);
+
+	if (!phy_interface_mode_is_rgmii(macro->mode))
+		return 0;
+
+	macro->speed = speed;
+	lan966x_rgmii_setup(macro, macro->idx - (SERDES6G_MAX + 1), macro->mode);
+
+	return 0;
+}
+
 static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 {
 	struct serdes_macro *macro = phy_get_drvdata(phy);
@@ -424,7 +496,9 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 						    macro->mode);
 
 		if (macro->idx < RGMII_MAX)
-			return 0;
+			return lan966x_rgmii_setup(macro,
+						   macro->idx - (SERDES6G_MAX + 1),
+						   macro->mode);
 
 		return -EOPNOTSUPP;
 	}
@@ -434,6 +508,7 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 
 static const struct phy_ops serdes_ops = {
 	.set_mode	= serdes_set_mode,
+	.set_speed	= serdes_set_speed,
 	.owner		= THIS_MODULE,
 };
 
diff --git a/drivers/phy/microchip/lan966x_serdes_regs.h b/drivers/phy/microchip/lan966x_serdes_regs.h
index ea30f64ffd5c..ac54cd01fea6 100644
--- a/drivers/phy/microchip/lan966x_serdes_regs.h
+++ b/drivers/phy/microchip/lan966x_serdes_regs.h
@@ -206,4 +206,46 @@ enum lan966x_target {
 #define HSIO_HW_CFG_QSGMII_ENA_GET(x)\
 	FIELD_GET(HSIO_HW_CFG_QSGMII_ENA, x)
 
+/*      HSIO:HW_CFGSTAT:RGMII_CFG */
+#define HSIO_RGMII_CFG(r)         __REG(TARGET_HSIO, 0, 1, 104, 0, 1, 52, 20, r, 2, 4)
+
+#define HSIO_RGMII_CFG_TX_CLK_CFG                GENMASK(4, 2)
+#define HSIO_RGMII_CFG_TX_CLK_CFG_SET(x)\
+	FIELD_PREP(HSIO_RGMII_CFG_TX_CLK_CFG, x)
+#define HSIO_RGMII_CFG_TX_CLK_CFG_GET(x)\
+	FIELD_GET(HSIO_RGMII_CFG_TX_CLK_CFG, x)
+
+#define HSIO_RGMII_CFG_RGMII_TX_RST              BIT(1)
+#define HSIO_RGMII_CFG_RGMII_TX_RST_SET(x)\
+	FIELD_PREP(HSIO_RGMII_CFG_RGMII_TX_RST, x)
+#define HSIO_RGMII_CFG_RGMII_TX_RST_GET(x)\
+	FIELD_GET(HSIO_RGMII_CFG_RGMII_TX_RST, x)
+
+#define HSIO_RGMII_CFG_RGMII_RX_RST              BIT(0)
+#define HSIO_RGMII_CFG_RGMII_RX_RST_SET(x)\
+	FIELD_PREP(HSIO_RGMII_CFG_RGMII_RX_RST, x)
+#define HSIO_RGMII_CFG_RGMII_RX_RST_GET(x)\
+	FIELD_GET(HSIO_RGMII_CFG_RGMII_RX_RST, x)
+
+/*      HSIO:HW_CFGSTAT:DLL_CFG */
+#define HSIO_DLL_CFG(r)           __REG(TARGET_HSIO, 0, 1, 104, 0, 1, 52, 36, r, 4, 4)
+
+#define HSIO_DLL_CFG_DELAY_ENA                   BIT(2)
+#define HSIO_DLL_CFG_DELAY_ENA_SET(x)\
+	FIELD_PREP(HSIO_DLL_CFG_DELAY_ENA, x)
+#define HSIO_DLL_CFG_DELAY_ENA_GET(x)\
+	FIELD_GET(HSIO_DLL_CFG_DELAY_ENA, x)
+
+#define HSIO_DLL_CFG_DLL_ENA                     BIT(1)
+#define HSIO_DLL_CFG_DLL_ENA_SET(x)\
+	FIELD_PREP(HSIO_DLL_CFG_DLL_ENA, x)
+#define HSIO_DLL_CFG_DLL_ENA_GET(x)\
+	FIELD_GET(HSIO_DLL_CFG_DLL_ENA, x)
+
+#define HSIO_DLL_CFG_DLL_RST                     BIT(0)
+#define HSIO_DLL_CFG_DLL_RST_SET(x)\
+	FIELD_PREP(HSIO_DLL_CFG_DLL_RST, x)
+#define HSIO_DLL_CFG_DLL_RST_GET(x)\
+	FIELD_GET(HSIO_DLL_CFG_DLL_RST, x)
+
 #endif /* _LAN966X_HSIO_REGS_H_ */
-- 
2.33.0

