Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94278598608
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbiHROew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245296AbiHROeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:34:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559EE27B13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:33:42 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgaJ-0005lR-Kg; Thu, 18 Aug 2022 16:33:23 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgaI-000X15-PW; Thu, 18 Aug 2022 16:33:22 +0200
Received: from mfe by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1oOgaH-0043dR-2W; Thu, 18 Aug 2022 16:33:21 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org, kishon@ti.com,
        sakari.ailus@linux.intel.com, hverkuil@xs4all.nl,
        jacopo@jmondi.org, laurent.pinchart+renesas@ideasonboard.com
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/4] phy: dphy: add support to calculate the timing based on hs_clk_rate
Date:   Thu, 18 Aug 2022 16:33:05 +0200
Message-Id: <20220818143307.967150-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220818143307.967150-1-m.felsch@pengutronix.de>
References: <20220818143307.967150-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For MIPI-CSI sender use-case it is common to specify the allowed
link-frequencies which should be used for the MIPI link and is
half the hs-clock rate.

This commit adds a helper to calculate the D-PHY timing based on the
hs-clock rate so we don't need to calculate the timings within the
driver.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/phy/phy-core-mipi-dphy.c  | 22 ++++++++++++++++++----
 include/linux/phy/phy-mipi-dphy.h |  3 +++
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/phy-core-mipi-dphy.c b/drivers/phy/phy-core-mipi-dphy.c
index ba365bc77407..f4956a417a47 100644
--- a/drivers/phy/phy-core-mipi-dphy.c
+++ b/drivers/phy/phy-core-mipi-dphy.c
@@ -20,16 +20,18 @@
 static int phy_mipi_dphy_calc_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
+				     unsigned long long hs_clk_rate,
 				     struct phy_configure_opts_mipi_dphy *cfg)
 {
-	unsigned long long hs_clk_rate;
 	unsigned long long ui;
 
 	if (!cfg)
 		return -EINVAL;
 
-	hs_clk_rate = pixel_clock * bpp;
-	do_div(hs_clk_rate, lanes);
+	if (!hs_clk_rate) {
+		hs_clk_rate = pixel_clock * bpp;
+		do_div(hs_clk_rate, lanes);
+	}
 
 	ui = ALIGN(PSEC_PER_SEC, hs_clk_rate);
 	do_div(ui, hs_clk_rate);
@@ -81,11 +83,23 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 				     unsigned int lanes,
 				     struct phy_configure_opts_mipi_dphy *cfg)
 {
-	return phy_mipi_dphy_calc_config(pixel_clock, bpp, lanes, cfg);
+	return phy_mipi_dphy_calc_config(pixel_clock, bpp, lanes, 0, cfg);
 
 }
 EXPORT_SYMBOL(phy_mipi_dphy_get_default_config);
 
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg)
+{
+	if (!hs_clk_rate)
+		return -EINVAL;
+
+	return phy_mipi_dphy_calc_config(0, 0, lanes, hs_clk_rate, cfg);
+
+}
+EXPORT_SYMBOL(phy_mipi_dphy_get_default_config_for_hsclk);
+
 /*
  * Validate D-PHY configuration according to MIPI D-PHY specification
  * (v1.2, Section Section 6.9 "Global Operation Timing Parameters").
diff --git a/include/linux/phy/phy-mipi-dphy.h b/include/linux/phy/phy-mipi-dphy.h
index a877ffee845d..1ac128d78dfe 100644
--- a/include/linux/phy/phy-mipi-dphy.h
+++ b/include/linux/phy/phy-mipi-dphy.h
@@ -279,6 +279,9 @@ int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
 				     unsigned int bpp,
 				     unsigned int lanes,
 				     struct phy_configure_opts_mipi_dphy *cfg);
+int phy_mipi_dphy_get_default_config_for_hsclk(unsigned long long hs_clk_rate,
+					       unsigned int lanes,
+					       struct phy_configure_opts_mipi_dphy *cfg);
 int phy_mipi_dphy_config_validate(struct phy_configure_opts_mipi_dphy *cfg);
 
 #endif /* __PHY_MIPI_DPHY_H_ */
-- 
2.30.2

