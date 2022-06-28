Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2321C55C4EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiF1MX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345023AbiF1MXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1726DF19;
        Tue, 28 Jun 2022 05:23:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D36F61471;
        Tue, 28 Jun 2022 12:23:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0516CC341CF;
        Tue, 28 Jun 2022 12:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656418999;
        bh=1V8MXkUgNi2dcarHxNrHOzzjdAUMNaQOkHe4RSHwLdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amuzenp5fcgyTfrovE+uSCAOii+Rs7Qv7Lq3/mE/7CYVxIvODoc1UZjkPtSXL85A6
         Gy/zJhBflTXxNN7ruQUVRD31IlK5R4Ahi30scRUZmZ/clkjGQqOyGZO8ptFb1Pdat1
         G4DovSYjlHjW72EGPn6r8ZuyL7/apGo2edAGvfvFfVgOVuIOCKiYQL6sKiDjFjwh6b
         eDcu6gV8muOJSutU7wI+szP3gxJfiNBl5c7ynFL3Sh/FS4795lw2j+vKMQpr/WG9n1
         twluTyfRRl+yiNbbxnqlJ7iNsl29GXJg8JBJA9I6jOqPyCgSp5IJyMOfAdEmWwUeMk
         ScWI3Xwj3pZFA==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 3/7] phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver
Date:   Tue, 28 Jun 2022 15:22:51 +0300
Message-Id: <20220628122255.24265-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tanmay Patil <t-patil@ti.com>

Changes the wiz_p_mac_div_sel() and wiz_mode_select() to
configure serdes for USXGMII.

Adds the support to configure mac_src_sel, refclk_sel and
rxfclk_sel in the LANECTL register and configures the serdes for
usxgmii.

[rogerq] Fix MAC_SRC_SEL to 0x3 for USXGMII as per CSL code.

Signed-off-by: Tanmay Patil <t-patil@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 51 +++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 8c10ee8e2707..77accea6ec2f 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -129,6 +129,26 @@ static const struct reg_field p0_fullrt_div[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANECTL(3), 22, 23),
 };
 
+static const struct reg_field p0_mac_src_sel[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANECTL(0), 20, 21),
+	REG_FIELD(WIZ_LANECTL(1), 20, 21),
+	REG_FIELD(WIZ_LANECTL(2), 20, 21),
+	REG_FIELD(WIZ_LANECTL(3), 20, 21),
+};
+
+static const struct reg_field p0_rxfclk_sel[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANECTL(0), 6, 7),
+	REG_FIELD(WIZ_LANECTL(1), 6, 7),
+	REG_FIELD(WIZ_LANECTL(2), 6, 7),
+	REG_FIELD(WIZ_LANECTL(3), 6, 7),
+};
+
+static const struct reg_field p0_refclk_sel[WIZ_MAX_LANES] = {
+	REG_FIELD(WIZ_LANECTL(0), 18, 19),
+	REG_FIELD(WIZ_LANECTL(1), 18, 19),
+	REG_FIELD(WIZ_LANECTL(2), 18, 19),
+	REG_FIELD(WIZ_LANECTL(3), 18, 19),
+};
 static const struct reg_field p_mac_div_sel0[WIZ_MAX_LANES] = {
 	REG_FIELD(WIZ_LANEDIV(0), 16, 22),
 	REG_FIELD(WIZ_LANEDIV(1), 16, 22),
@@ -280,6 +300,9 @@ struct wiz {
 	struct regmap_field	*p_mac_div_sel0[WIZ_MAX_LANES];
 	struct regmap_field	*p_mac_div_sel1[WIZ_MAX_LANES];
 	struct regmap_field	*p0_fullrt_div[WIZ_MAX_LANES];
+	struct regmap_field	*p0_mac_src_sel[WIZ_MAX_LANES];
+	struct regmap_field	*p0_rxfclk_sel[WIZ_MAX_LANES];
+	struct regmap_field	*p0_refclk_sel[WIZ_MAX_LANES];
 	struct regmap_field	*pma_cmn_refclk_int_mode;
 	struct regmap_field	*pma_cmn_refclk_mode;
 	struct regmap_field	*pma_cmn_refclk_dig_div;
@@ -326,7 +349,8 @@ static int wiz_p_mac_div_sel(struct wiz *wiz)
 
 	for (i = 0; i < num_lanes; i++) {
 		if (wiz->lane_phy_type[i] == PHY_TYPE_SGMII ||
-		    wiz->lane_phy_type[i] == PHY_TYPE_QSGMII) {
+		    wiz->lane_phy_type[i] == PHY_TYPE_QSGMII ||
+		    wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
 			ret = regmap_field_write(wiz->p_mac_div_sel0[i], 1);
 			if (ret)
 				return ret;
@@ -355,6 +379,13 @@ static int wiz_mode_select(struct wiz *wiz)
 		else
 			continue;
 
+		if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
+			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
+			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);
+			ret = regmap_field_write(wiz->p0_refclk_sel[i], 0x3);
+			mode = LANE_MODE_GEN1;
+		}
+
 		ret = regmap_field_write(wiz->p_standard_mode[i], mode);
 		if (ret)
 			return ret;
@@ -524,6 +555,24 @@ static int wiz_regfield_init(struct wiz *wiz)
 			return PTR_ERR(wiz->p0_fullrt_div[i]);
 		}
 
+		wiz->p0_mac_src_sel[i] = devm_regmap_field_alloc(dev, regmap, p0_mac_src_sel[i]);
+		if (IS_ERR(wiz->p0_mac_src_sel[i])) {
+			dev_err(dev, "P%d_MAC_SRC_SEL reg field init failed\n", i);
+			return PTR_ERR(wiz->p0_mac_src_sel[i]);
+		}
+
+		wiz->p0_rxfclk_sel[i] = devm_regmap_field_alloc(dev, regmap, p0_rxfclk_sel[i]);
+		if (IS_ERR(wiz->p0_rxfclk_sel[i])) {
+			dev_err(dev, "P%d_RXFCLK_SEL reg field init failed\n", i);
+			return PTR_ERR(wiz->p0_rxfclk_sel[i]);
+		}
+
+		wiz->p0_refclk_sel[i] = devm_regmap_field_alloc(dev, regmap, p0_refclk_sel[i]);
+		if (IS_ERR(wiz->p0_refclk_sel[i])) {
+			dev_err(dev, "P%d_REFCLK_SEL reg field init failed\n", i);
+			return PTR_ERR(wiz->p0_refclk_sel[i]);
+		}
+
 		wiz->p_mac_div_sel0[i] =
 		  devm_regmap_field_alloc(dev, regmap, p_mac_div_sel0[i]);
 		if (IS_ERR(wiz->p_mac_div_sel0[i])) {
-- 
2.17.1

