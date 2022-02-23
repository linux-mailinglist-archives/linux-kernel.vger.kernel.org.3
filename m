Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1804C4C1D75
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242108AbiBWVGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241907AbiBWVGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:06:50 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBF54E387;
        Wed, 23 Feb 2022 13:06:21 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 11EC3223EA;
        Wed, 23 Feb 2022 22:06:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645650380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywNZ6NSwfejE8EDXjQ33JHJOKjebhsdDklw/YWSsZMY=;
        b=Vh36zDY8A7LXo3Wsc99YbxzTH1MP7fd/G5W3X9pKVoP79hxUIQJlHb+426S0cIea7m9YWC
        sQ9lAfKBpZFAt/ha++SpLI1vDKXgi3S+ZfGvdGyI8BjCbRpiBT2qCNSXAF9wkUfH6W6dsz
        6t70+vDP9QweL4Uo17LorcM1vmEGft0=
From:   Michael Walle <michael@walle.cc>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     heiko.thiery@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 2/2] arm64: dts: imx8mn-evk: fix the min/max voltages of the PMIC
Date:   Wed, 23 Feb 2022 22:05:59 +0100
Message-Id: <20220223210559.1999209-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220223210559.1999209-1-michael@walle.cc>
References: <20220223210559.1999209-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the proper voltages as supported by the board instead of the ones
supported by the PMIC. The voltages were taken from both the schematic
of the 8MNANOLPD4-EVK eval board and the datasheet of the IMX8MN SoC.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Please help review and test this. This was never tested on the actual
8MNANOLPD4-EVK because I don't have that board! Instead it is a
"byproduct" of the development of an devicetree for the 8MNANOD3L-EVK
which is quite similar except for the DDR voltage and the buck1
converter.

 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 34 ++++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index eaa06f49aef5..2bb0155ea018 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -42,8 +42,8 @@ pmic: pmic@25 {
 		regulators {
 			buck1: BUCK1{
 				regulator-name = "VDD_ARM_0V9";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <1000000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -51,8 +51,8 @@ buck1: BUCK1{
 
 			buck2: BUCK2 {
 				regulator-name = "VDD_SOC";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <2187500>;
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-ramp-delay = <3125>;
@@ -62,32 +62,32 @@ buck2: BUCK2 {
 
 			buck4: BUCK4{
 				regulator-name = "VDD_3V3";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			buck5: BUCK5{
 				regulator-name = "VDD_1V8";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			buck6: BUCK6 {
 				regulator-name = "NVCC_DRAM_1V1";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <3400000>;
+				regulator-min-microvolt = <1100000>;
+				regulator-max-microvolt = <1100000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo1: LDO1 {
 				regulator-name = "NVCC_SNVS_1V8";
-				regulator-min-microvolt = <1600000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -95,23 +95,23 @@ ldo1: LDO1 {
 			ldo2: LDO2 {
 				regulator-name = "VDD_SNVS_0V8";
 				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <1150000>;
+				regulator-max-microvolt = <800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo3: LDO3 {
 				regulator-name = "VDDA_1V8";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
 
 			ldo4: LDO4 {
 				regulator-name = "VDD_PHY_1V2";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
-- 
2.30.2

