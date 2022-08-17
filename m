Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBC597694
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241504AbiHQTcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241522AbiHQTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:32:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B1DA5981
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:31:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E316148E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 19:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2734CC433C1;
        Wed, 17 Aug 2022 19:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660764693;
        bh=nMFKYdKcFqlI5rRLQUTyDNkHZ32B8MXSLFMlY2NXf2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP7x9I8fOusChGcyWH7hLRzOerdOM989UciS0FBtbq4foOrT7PZwFB5gmVkht7USF
         E/SfKEAb9Ieyrr4pd7oUeHv6TkX2JelJuzyMQJTNgyvwrdr1SYrtjOSKTDxRbfOm4s
         h/zpPwmhns5b3RpnlwxALoIfiSSi1GjjnqyCaLqKNzJnmMgKmXiYpVblLHM7vmT63F
         xouA6ENx2vscuR7vc4PLVv74UcycEraRJ1tQVx1e5BX0cns8+T4awGNHJFjtIz6pE/
         36mGgyf4m4eaUb55zxcHHClhb1Nb/Enst2Dd1TYZrAy3gzUE3un2j9jyFZOwS/Lr9K
         9UGCxpI3tt4bg==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Phy <linux-phy@lists.infradead.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, pali@kernel.org,
        josef.schlehofer@nic.cz,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH linux-phy 3/4] phy: marvell: phy-mvebu-a3700-comphy: Support changing tx amplitude for ethernet
Date:   Wed, 17 Aug 2022 21:31:18 +0200
Message-Id: <20220817193119.4463-4-kabel@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220817193119.4463-1-kabel@kernel.org>
References: <20220817193119.4463-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to set SerDes transmit amplitude if specified via the
'tx-p2p-microvolt' and 'tx-p2p-microvolt-names' device-tree properties.

This support is currently only for ethernet mode.

Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 109 ++++++++++++++++++-
 1 file changed, 108 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
index a4d7d9bd100d..7fabd959ae0f 100644
--- a/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
+++ b/drivers/phy/marvell/phy-mvebu-a3700-comphy.c
@@ -68,6 +68,16 @@
 #define SPEED_PLL_MASK			GENMASK(7, 2)
 #define SPEED_PLL_VALUE_16		FIELD_PREP(SPEED_PLL_MASK, 0x10)
 
+#define COMPHY_GEN1_SET0		0x0d
+#define COMPHY_GEN2_SET0		0x0f
+#define COMPHY_GEN3_SET0		0x11
+#define COMPHY_GEN4_SET0		0x13
+#define COMPHY_GENx_SET0(x)		(0x0d + (((x) & 3) - 1) * 2)
+#define Gx_TX_AMP_MASK			GENMASK(5, 1)
+#define Gx_TX_AMP_VALUE(x)		FIELD_PREP(Gx_TX_AMP_MASK, x)
+#define Gx_TX_AMP_ADJ			BIT(6)
+#define Gx_TX_AMP_1025MV		(Gx_TX_AMP_VALUE(0x12) | Gx_TX_AMP_ADJ)
+
 #define COMPHY_DIG_LOOPBACK_EN		0x23
 #define SEL_DATA_WIDTH_MASK		GENMASK(11, 10)
 #define DATA_WIDTH_10BIT		FIELD_PREP(SEL_DATA_WIDTH_MASK, 0x0)
@@ -269,6 +279,7 @@ struct mvebu_a3700_comphy_priv {
 struct mvebu_a3700_comphy_lane {
 	struct mvebu_a3700_comphy_priv *priv;
 	struct device *dev;
+	struct phy *phy;
 	unsigned int id;
 	enum phy_mode mode;
 	int submode;
@@ -385,6 +396,15 @@ static inline void comphy_reg_set16(void __iomem *addr, u16 data, u16 mask)
 }
 
 /* Used for accessing lane 2 registers (SATA/USB3 PHY) */
+static u16 comphy_get_indirect(struct mvebu_a3700_comphy_priv *priv, u32 offset)
+{
+	writel(offset,
+	       priv->lane2_phy_indirect + COMPHY_LANE2_INDIR_ADDR);
+
+	/* We need to read the register with 32-bit read */
+	return readl(priv->lane2_phy_indirect + COMPHY_LANE2_INDIR_DATA);
+}
+
 static void comphy_set_indirect(struct mvebu_a3700_comphy_priv *priv,
 				u32 offset, u16 data, u16 mask)
 {
@@ -394,6 +414,21 @@ static void comphy_set_indirect(struct mvebu_a3700_comphy_priv *priv,
 		       data, mask);
 }
 
+static u16 comphy_lane_reg_get(struct mvebu_a3700_comphy_lane *lane, u16 reg)
+{
+	if (lane->id == 2) {
+		/* lane 2 PHY registers are accessed indirectly */
+		return comphy_get_indirect(lane->priv,
+					   reg + COMPHY_LANE2_REGS_BASE);
+	} else {
+		void __iomem *base = lane->id == 1 ?
+				     lane->priv->lane1_phy_regs :
+				     lane->priv->lane0_phy_regs;
+
+		return readw(base + COMPHY_LANE_REG_DIRECT(reg));
+	}
+}
+
 static void comphy_lane_reg_set(struct mvebu_a3700_comphy_lane *lane,
 				u16 reg, u16 data, u16 mask)
 {
@@ -624,10 +659,53 @@ static void comphy_gbe_phy_init(struct mvebu_a3700_comphy_lane *lane,
 	}
 }
 
+static u8 comphy_find_best_tx_amp(bool full_swing, u32 amp, u32 *true_amp)
+{
+	static const u32 half_swing_table[32] = {
+		250, 270, 290, 310, 330, 345, 365, 380,
+		400, 420, 435, 455, 470, 490, 505, 525,
+		485, 520, 555, 590, 625, 660, 695, 730,
+		765, 800, 830, 865, 900, 930, 965, 1000,
+	};
+	static const u32 full_swing_table[22] = {
+		470, 505, 540, 575, 610, 645, 680, 715,
+		750, 785, 820, 850, 885, 915, 950, 980,
+		900, 965, 1025, 1095, 1160, 1220,
+	};
+	u32 diff, min_diff;
+	const u32 *table;
+	size_t len;
+	u8 res;
+
+	if (full_swing) {
+		table = full_swing_table;
+		len = ARRAY_SIZE(full_swing_table);
+	} else {
+		table = half_swing_table;
+		len = ARRAY_SIZE(half_swing_table);
+	}
+
+	res = 0;
+	min_diff = abs(amp - table[0]);
+
+	for (size_t i = 1; i < len; ++i) {
+		diff = abs(amp - table[i]);
+		if (diff < min_diff) {
+			min_diff = diff;
+			res = i;
+		}
+	}
+
+	if (true_amp)
+		*true_amp = table[res];
+
+	return res;
+}
+
 static int
 mvebu_a3700_comphy_ethernet_power_on(struct mvebu_a3700_comphy_lane *lane)
 {
-	u32 mask, data, speed_sel;
+	u32 mask, data, speed_sel, tx_amp_uv;
 	int ret;
 
 	/* Set selector */
@@ -746,6 +824,34 @@ mvebu_a3700_comphy_ethernet_power_on(struct mvebu_a3700_comphy_lane *lane)
 		comphy_gbe_phy_init(lane,
 				    lane->submode != PHY_INTERFACE_MODE_2500BASEX);
 
+	/*
+	 * Change transmit amplitude if specified in device-tree.
+	 */
+	if (!device_get_tx_p2p_amplitude(&lane->phy->dev,
+					 phy_modes(lane->submode),
+					 &tx_amp_uv)) {
+		u32 tx_amp_mv, true_tx_amp_mv;
+		bool full_swing;
+		u8 tx_amp;
+		u16 reg;
+
+		reg = COMPHY_GENx_SET0(speed_sel + 1);
+
+		data = comphy_lane_reg_get(lane, reg);
+		full_swing = data & Gx_TX_AMP_ADJ;
+		tx_amp_mv = DIV_ROUND_CLOSEST(tx_amp_uv, 1000);
+		tx_amp = comphy_find_best_tx_amp(tx_amp_mv, full_swing,
+						 &true_tx_amp_mv);
+
+		data = Gx_TX_AMP_VALUE(tx_amp);
+		mask = Gx_TX_AMP_MASK;
+		comphy_lane_reg_set(lane, reg, data, mask);
+
+		dev_dbg(lane->dev,
+			"changed tx amplitude to %u mV (requested %u mV) on lane %d\n",
+			true_tx_amp_mv, tx_amp_mv, lane->id);
+	}
+
 	/*
 	 * 14. Check the PHY Polarity invert bit
 	 */
@@ -1382,6 +1488,7 @@ static int mvebu_a3700_comphy_probe(struct platform_device *pdev)
 
 		lane->priv = priv;
 		lane->dev = &pdev->dev;
+		lane->phy = phy;
 		lane->mode = PHY_MODE_INVALID;
 		lane->submode = PHY_INTERFACE_MODE_NA;
 		lane->id = lane_id;
-- 
2.35.1

