Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8CA549A4D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242589AbiFMRm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347514AbiFMRkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:40:46 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E795039B98
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=stMRjnyMVz9r4c
        1ylukkPkM32KBZXfFXWJnNgmRy7Go=; b=wS+6TT/lgo8P/OK6rhMeB+eOn/m+3+
        5M4TqDxf+JTy7c2dBNC7XluToCloHyvYn0vChnVyB9wVzBgLqfEZk+BL4zPwV5zb
        ra2i876oJH1CKCgfi/bOe5ymPeZyNOwyBDdYiNOw18caO/O/XZULuzg82tUEKQDb
        AL3D0fdhZdHw8=
Received: (qmail 1304762 invoked from network); 13 Jun 2022 15:10:52 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Jun 2022 15:10:52 +0200
X-UD-Smtp-Session: l3s3148p1@o2Z2BFThogZZD+yY
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: renesas: spider-cpu: Switch from SCIF3 to HSCIF0
Date:   Mon, 13 Jun 2022 15:10:32 +0200
Message-Id: <20220613131033.10053-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220613131033.10053-1-wsa+renesas@sang-engineering.com>
References: <20220613131033.10053-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Every loader before Linux utilizes HSCIF0 with a speed of 1843200bps.
Make Linux behave the same.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 .../boot/dts/renesas/r8a779f0-spider-cpu.dtsi | 26 +++++++++----------
 .../boot/dts/renesas/r8a779f0-spider.dts      |  4 +--
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
index 41aa8591b3b1..3208d2148768 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-cpu.dtsi
@@ -31,6 +31,14 @@ &extalr_clk {
 	clock-frequency = <32768>;
 };
 
+&hscif0 {
+	pinctrl-0 = <&hscif0_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
 &i2c4 {
 	pinctrl-0 = <&i2c4_pins>;
 	pinctrl-names = "default";
@@ -50,16 +58,16 @@ &pfc {
 	pinctrl-0 = <&scif_clk_pins>;
 	pinctrl-names = "default";
 
+	hscif0_pins: hscif0 {
+		groups = "hscif0_data", "hscif0_ctrl";
+		function = "hscif0";
+	};
+
 	i2c4_pins: i2c4 {
 		groups = "i2c4";
 		function = "i2c4";
 	};
 
-	scif3_pins: scif3 {
-		groups = "scif3_data", "scif3_ctrl";
-		function = "scif3";
-	};
-
 	scif_clk_pins: scif_clk {
 		groups = "scif_clk";
 		function = "scif_clk";
@@ -71,14 +79,6 @@ &rwdt {
 	status = "okay";
 };
 
-&scif3 {
-	pinctrl-0 = <&scif3_pins>;
-	pinctrl-names = "default";
-
-	uart-has-rtscts;
-	status = "okay";
-};
-
 &scif_clk {
 	clock-frequency = <24000000>;
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
index 2e3b719cc749..954ba227bfa7 100644
--- a/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider.dts
@@ -14,11 +14,11 @@ / {
 	compatible = "renesas,spider-breakout", "renesas,spider-cpu", "renesas,r8a779f0";
 
 	aliases {
-		serial0 = &scif3;
+		serial0 = &hscif0;
 	};
 
 	chosen {
-		stdout-path = "serial0:115200n8";
+		stdout-path = "serial0:1843200n8";
 	};
 };
 
-- 
2.35.1

