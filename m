Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC5A4CB1C8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbiCBWIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243941AbiCBWIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:08:45 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A23381B2;
        Wed,  2 Mar 2022 14:07:59 -0800 (PST)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 55480E0007;
        Wed,  2 Mar 2022 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646258877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ULYkhBYvj9UYIqVLQ11leNXTVxE/VxX/d7VAB3Nfqck=;
        b=acKHn+PNaBLEtc4EYHYK5EaJTWLLZ7xkGKl8E2vYq+DT0O3Actr3d3/f0zLgl2hgDSbBEv
        lMH8F+jcRFtHIHvc3mUthaVPre0HeyBLZax7VTmozD078eVX3M+Mkuf+FFguuoSz4PvLCt
        Kpx6kPvhwC2+Ii4NAkteDeGLD7FEikhk5jN+GEakzPv0233AIZm2rOP07KDxMkERge1ict
        hkSF0KMkoPBatf9dMn+MZAAx09BkbOzy7iJsZjpgFqI5iId6Yg7m80grfR9YVIRSYdQahc
        lR6LEWbydcpVfyQHOBxycK28fN+b3BCfc/JKGM54OYJ6+v2QZ19qovFTyQrCrg==
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v3 2/9] phy: allwinner: phy-sun6i-mipi-dphy: Support D-PHY Rx mode for MIPI CSI-2
Date:   Wed,  2 Mar 2022 23:07:32 +0100
Message-Id: <20220302220739.144303-3-paul.kocialkowski@bootlin.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
References: <20220302220739.144303-1-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner A31 D-PHY supports both Rx and Tx modes. While the latter
is already supported and used for MIPI DSI this adds support for the
former, to be used with MIPI CSI-2.

This implementation is inspired by Allwinner's V3s Linux SDK
implementation, which was used as a documentation base.

It uses the direction dt property to distinguish between tx and rx
directions.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
---
 drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 166 +++++++++++++++++++-
 1 file changed, 162 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
index f0bc87d654d4..3900f1650851 100644
--- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
+++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
@@ -24,6 +24,14 @@
 #define SUN6I_DPHY_TX_CTL_REG		0x04
 #define SUN6I_DPHY_TX_CTL_HS_TX_CLK_CONT	BIT(28)
 
+#define SUN6I_DPHY_RX_CTL_REG		0x08
+#define SUN6I_DPHY_RX_CTL_EN_DBC	BIT(31)
+#define SUN6I_DPHY_RX_CTL_RX_CLK_FORCE	BIT(24)
+#define SUN6I_DPHY_RX_CTL_RX_D3_FORCE	BIT(23)
+#define SUN6I_DPHY_RX_CTL_RX_D2_FORCE	BIT(22)
+#define SUN6I_DPHY_RX_CTL_RX_D1_FORCE	BIT(21)
+#define SUN6I_DPHY_RX_CTL_RX_D0_FORCE	BIT(20)
+
 #define SUN6I_DPHY_TX_TIME0_REG		0x10
 #define SUN6I_DPHY_TX_TIME0_HS_TRAIL(n)		(((n) & 0xff) << 24)
 #define SUN6I_DPHY_TX_TIME0_HS_PREPARE(n)	(((n) & 0xff) << 16)
@@ -44,12 +52,29 @@
 #define SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(n)	(((n) & 0xff) << 8)
 #define SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(n)	((n) & 0xff)
 
+#define SUN6I_DPHY_RX_TIME0_REG		0x30
+#define SUN6I_DPHY_RX_TIME0_HS_RX_SYNC(n)	(((n) & 0xff) << 24)
+#define SUN6I_DPHY_RX_TIME0_HS_RX_CLK_MISS(n)	(((n) & 0xff) << 16)
+#define SUN6I_DPHY_RX_TIME0_LP_RX(n)		(((n) & 0xff) << 8)
+
+#define SUN6I_DPHY_RX_TIME1_REG		0x34
+#define SUN6I_DPHY_RX_TIME1_RX_DLY(n)		(((n) & 0xfff) << 20)
+#define SUN6I_DPHY_RX_TIME1_LP_RX_ULPS_WP(n)	((n) & 0xfffff)
+
+#define SUN6I_DPHY_RX_TIME2_REG		0x38
+#define SUN6I_DPHY_RX_TIME2_HS_RX_ANA1(n)	(((n) & 0xff) << 8)
+#define SUN6I_DPHY_RX_TIME2_HS_RX_ANA0(n)	((n) & 0xff)
+
+#define SUN6I_DPHY_RX_TIME3_REG		0x40
+#define SUN6I_DPHY_RX_TIME3_LPRST_DLY(n)	(((n) & 0xffff) << 16)
+
 #define SUN6I_DPHY_ANA0_REG		0x4c
 #define SUN6I_DPHY_ANA0_REG_PWS			BIT(31)
 #define SUN6I_DPHY_ANA0_REG_DMPC		BIT(28)
 #define SUN6I_DPHY_ANA0_REG_DMPD(n)		(((n) & 0xf) << 24)
 #define SUN6I_DPHY_ANA0_REG_SLV(n)		(((n) & 7) << 12)
 #define SUN6I_DPHY_ANA0_REG_DEN(n)		(((n) & 0xf) << 8)
+#define SUN6I_DPHY_ANA0_REG_SFB(n)		(((n) & 3) << 2)
 
 #define SUN6I_DPHY_ANA1_REG		0x50
 #define SUN6I_DPHY_ANA1_REG_VTTMODE		BIT(31)
@@ -84,6 +109,11 @@
 
 #define SUN6I_DPHY_DBG5_REG		0xf4
 
+enum sun6i_dphy_direction {
+	SUN6I_DPHY_DIRECTION_TX,
+	SUN6I_DPHY_DIRECTION_RX,
+};
+
 struct sun6i_dphy {
 	struct clk				*bus_clk;
 	struct clk				*mod_clk;
@@ -92,6 +122,8 @@ struct sun6i_dphy {
 
 	struct phy				*phy;
 	struct phy_configure_opts_mipi_dphy	config;
+
+	enum sun6i_dphy_direction		direction;
 };
 
 static int sun6i_dphy_init(struct phy *phy)
@@ -119,9 +151,8 @@ static int sun6i_dphy_configure(struct phy *phy, union phy_configure_opts *opts)
 	return 0;
 }
 
-static int sun6i_dphy_power_on(struct phy *phy)
+static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
 {
-	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
 	u8 lanes_mask = GENMASK(dphy->config.lanes - 1, 0);
 
 	regmap_write(dphy->regs, SUN6I_DPHY_TX_CTL_REG,
@@ -211,12 +242,129 @@ static int sun6i_dphy_power_on(struct phy *phy)
 	return 0;
 }
 
+static int sun6i_dphy_rx_power_on(struct sun6i_dphy *dphy)
+{
+	/* Physical clock rate is actually half of symbol rate with DDR. */
+	unsigned long mipi_symbol_rate = dphy->config.hs_clk_rate;
+	unsigned long dphy_clk_rate;
+	unsigned int rx_dly;
+	unsigned int lprst_dly;
+	u32 value;
+
+	dphy_clk_rate = clk_get_rate(dphy->mod_clk);
+	if (!dphy_clk_rate)
+		return -EINVAL;
+
+	/* Hardcoded timing parameters from the Allwinner BSP. */
+	regmap_write(dphy->regs, SUN6I_DPHY_RX_TIME0_REG,
+		     SUN6I_DPHY_RX_TIME0_HS_RX_SYNC(255) |
+		     SUN6I_DPHY_RX_TIME0_HS_RX_CLK_MISS(255) |
+		     SUN6I_DPHY_RX_TIME0_LP_RX(255));
+
+	/*
+	 * Formula from the Allwinner BSP, with hardcoded coefficients
+	 * (probably internal divider/multiplier).
+	 */
+	rx_dly = 8 * (unsigned int)(dphy_clk_rate / (mipi_symbol_rate / 8));
+
+	/*
+	 * The Allwinner BSP has an alternative formula for LP_RX_ULPS_WP:
+	 * lp_ulps_wp_cnt = lp_ulps_wp_ms * lp_clk / 1000
+	 * but does not use it and hardcodes 255 instead.
+	 */
+	regmap_write(dphy->regs, SUN6I_DPHY_RX_TIME1_REG,
+		     SUN6I_DPHY_RX_TIME1_RX_DLY(rx_dly) |
+		     SUN6I_DPHY_RX_TIME1_LP_RX_ULPS_WP(255));
+
+	/* HS_RX_ANA0 value is hardcoded in the Allwinner BSP. */
+	regmap_write(dphy->regs, SUN6I_DPHY_RX_TIME2_REG,
+		     SUN6I_DPHY_RX_TIME2_HS_RX_ANA0(4));
+
+	/*
+	 * Formula from the Allwinner BSP, with hardcoded coefficients
+	 * (probably internal divider/multiplier).
+	 */
+	lprst_dly = 4 * (unsigned int)(dphy_clk_rate / (mipi_symbol_rate / 2));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_RX_TIME3_REG,
+		     SUN6I_DPHY_RX_TIME3_LPRST_DLY(lprst_dly));
+
+	/* Analog parameters are hardcoded in the Allwinner BSP. */
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
+		     SUN6I_DPHY_ANA0_REG_PWS |
+		     SUN6I_DPHY_ANA0_REG_SLV(7) |
+		     SUN6I_DPHY_ANA0_REG_SFB(2));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA1_REG,
+		     SUN6I_DPHY_ANA1_REG_SVTT(4));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG,
+		     SUN6I_DPHY_ANA4_REG_DMPLVC |
+		     SUN6I_DPHY_ANA4_REG_DMPLVD(1));
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA2_REG,
+		     SUN6I_DPHY_ANA2_REG_ENIB);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG,
+		     SUN6I_DPHY_ANA3_EN_LDOR |
+		     SUN6I_DPHY_ANA3_EN_LDOC |
+		     SUN6I_DPHY_ANA3_EN_LDOD);
+
+	/*
+	 * Delay comes from the Allwinner BSP, likely for internal regulator
+	 * ramp-up.
+	 */
+	udelay(3);
+
+	value = SUN6I_DPHY_RX_CTL_EN_DBC | SUN6I_DPHY_RX_CTL_RX_CLK_FORCE;
+
+	/*
+	 * Rx data lane force-enable bits are used as regular RX enable by the
+	 * Allwinner BSP.
+	 */
+	if (dphy->config.lanes >= 1)
+		value |= SUN6I_DPHY_RX_CTL_RX_D0_FORCE;
+	if (dphy->config.lanes >= 2)
+		value |= SUN6I_DPHY_RX_CTL_RX_D1_FORCE;
+	if (dphy->config.lanes >= 3)
+		value |= SUN6I_DPHY_RX_CTL_RX_D2_FORCE;
+	if (dphy->config.lanes == 4)
+		value |= SUN6I_DPHY_RX_CTL_RX_D3_FORCE;
+
+	regmap_write(dphy->regs, SUN6I_DPHY_RX_CTL_REG, value);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
+		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
+		     SUN6I_DPHY_GCTL_EN);
+
+	return 0;
+}
+
+static int sun6i_dphy_power_on(struct phy *phy)
+{
+	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
+
+	switch (dphy->direction) {
+	case SUN6I_DPHY_DIRECTION_TX:
+		return sun6i_dphy_tx_power_on(dphy);
+	case SUN6I_DPHY_DIRECTION_RX:
+		return sun6i_dphy_rx_power_on(dphy);
+	default:
+		return -EINVAL;
+	}
+}
+
 static int sun6i_dphy_power_off(struct phy *phy)
 {
 	struct sun6i_dphy *dphy = phy_get_drvdata(phy);
 
-	regmap_update_bits(dphy->regs, SUN6I_DPHY_ANA1_REG,
-			   SUN6I_DPHY_ANA1_REG_VTTMODE, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG, 0);
+
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA1_REG, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA2_REG, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA3_REG, 0);
+	regmap_write(dphy->regs, SUN6I_DPHY_ANA4_REG, 0);
 
 	return 0;
 }
@@ -253,7 +401,9 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 {
 	struct phy_provider *phy_provider;
 	struct sun6i_dphy *dphy;
+	const char *direction;
 	void __iomem *regs;
+	int ret;
 
 	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
 	if (!dphy)
@@ -290,6 +440,14 @@ static int sun6i_dphy_probe(struct platform_device *pdev)
 		return PTR_ERR(dphy->phy);
 	}
 
+	dphy->direction = SUN6I_DPHY_DIRECTION_TX;
+
+	ret = of_property_read_string(pdev->dev.of_node, "allwinner,direction",
+				      &direction);
+
+	if (!ret && !strncmp(direction, "rx", 2))
+		dphy->direction = SUN6I_DPHY_DIRECTION_RX;
+
 	phy_set_drvdata(dphy->phy, dphy);
 	phy_provider = devm_of_phy_provider_register(&pdev->dev, of_phy_simple_xlate);
 
-- 
2.35.1

