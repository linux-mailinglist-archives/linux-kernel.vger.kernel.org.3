Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112764F00BF
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354412AbiDBKpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDBKpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:45:50 -0400
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076A22AE24;
        Sat,  2 Apr 2022 03:43:54 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout3.routing.net (Postfix) with ESMTP id D0527604DC;
        Sat,  2 Apr 2022 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1648896233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVlsNMjXQQ4jdCL0TbPne+ht1OtgQ3f4+EzKpSKvrX8=;
        b=laU5/8abs7BHEJiXUVOxX/fh85mUVBUDwAH9+jDMwO/f9mGWpiSwt4ZUrFPAE7KGkMKUPJ
        +mjsNSrOTgI4P7PHHnQFwRQaKd2LIZ1e8BKJcuGqj/CqcnlPd5FHYEJ4923KdR1LiMCHUz
        PpzFTTQEDyx4yiYhKUuefvKK8dq8ugE=
Received: from localhost.localdomain (fttx-pool-80.245.79.107.bambit.de [80.245.79.107])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 21652403AC;
        Sat,  2 Apr 2022 10:43:52 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: dts: rockchip: Add gmac1 and change network settings
Date:   Sat,  2 Apr 2022 12:43:12 +0200
Message-Id: <20220402104313.100333-3-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220402104313.100333-1-linux@fw-web.de>
References: <20220402104313.100333-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 9004292b-8e73-4ef7-931d-e37bf50c2a4b
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

New Version (v1.0) of R2 pro has swapped gmacs compared to the v00.

WAN-Port is now on gmac1 (RTL8211F) and lan-ports on gmac0 with mt7531
switch.

There is already a mt7531 dsa driver in mainline, but it needs to be
modified to work for this board.

Fixes: f901aaadaa2a ("arm64: dts: rockchip: Add Bananapi R2 Pro")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../boot/dts/rockchip/rk3568-bpi-r2-pro.dts   | 36 +++++++++++++++++--
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index a0388ff85ddf..067fe4a6b178 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -16,6 +16,7 @@ / {
 
 	aliases {
 		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
 		mmc0 = &sdmmc0;
 		mmc1 = &sdhci;
 	};
@@ -78,7 +79,6 @@ &gmac0 {
 	assigned-clocks = <&cru SCLK_GMAC0_RX_TX>, <&cru SCLK_GMAC0>;
 	assigned-clock-parents = <&cru SCLK_GMAC0_RGMII_SPEED>, <&cru CLK_MAC0_2TOP>;
 	clock_in_out = "input";
-	phy-handle = <&rgmii_phy0>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&gmac0_miim
@@ -90,8 +90,38 @@ &gmac0_rgmii_clk
 	snps,reset-active-low;
 	/* Reset time is 20ms, 100ms for rtl8211f */
 	snps,reset-delays-us = <0 20000 100000>;
+	tx_delay = <0x4f>;
+	rx_delay = <0x0f>;
+	status = "okay";
+
+	fixed-link {
+		speed = <1000>;
+		full-duplex;
+		pause;
+	};
+};
+
+&gmac1 {
+	assigned-clocks = <&cru SCLK_GMAC1_RX_TX>, <&cru SCLK_GMAC1>;
+	assigned-clock-parents = <&cru SCLK_GMAC1_RGMII_SPEED>, <&cru CLK_MAC1_2TOP>;
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac1m1_miim
+		     &gmac1m1_tx_bus2
+		     &gmac1m1_rx_bus2
+		     &gmac1m1_rgmii_clk
+		     &gmac1m1_rgmii_bus>;
+
+	snps,reset-gpio = <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	/* Reset time is 20ms, 100ms for rtl8211f */
+	snps,reset-delays-us = <0 20000 100000>;
+
 	tx_delay = <0x3c>;
 	rx_delay = <0x2f>;
+
 	status = "okay";
 };
 
@@ -315,8 +345,8 @@ &i2c5 {
 	status = "disabled";
 };
 
-&mdio0 {
-	rgmii_phy0: ethernet-phy@0 {
+&mdio1 {
+	rgmii_phy1: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c22";
 		reg = <0x0>;
 	};
-- 
2.25.1

