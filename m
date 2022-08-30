Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF15A6190
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiH3LVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiH3LVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:21:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2CB5FF48
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 04:21:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1oSzJ7-0000k6-BY; Tue, 30 Aug 2022 13:21:25 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSzJ5-002rKh-LL; Tue, 30 Aug 2022 13:21:23 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1oSzJ5-008dgv-0q; Tue, 30 Aug 2022 13:21:23 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v1 1/1] ARM: dts: imx6: skov: migrate to resistive-adc-touch
Date:   Tue, 30 Aug 2022 13:21:21 +0200
Message-Id: <20220830112121.2059062-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
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

Start to use more generic resistive-adc-touch node. ti,tsc2046 is an ADC
controller used for resistive touchscreen. So, define it as ADC and
attach resistive-adc-touch to it.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi | 65 ++++++++++++++------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi b/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
index 8254bce1b8a22..b81799d7076aa 100644
--- a/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-skov-cpu-revc.dtsi
@@ -2,35 +2,60 @@
 //
 // Copyright (C) 2020 Pengutronix, Ulrich Oelmann <kernel@pengutronix.de>
 
+/ {
+	touchscreen {
+		compatible = "resistive-adc-touch";
+		io-channels = <&adc_ts 1>, <&adc_ts 3>, <&adc_ts 4>, <&adc_ts 5>;
+		io-channel-names = "y", "z1", "z2", "x";
+		touchscreen-min-pressure = <65000>;
+		touchscreen-inverted-y;
+		touchscreen-swapped-x-y;
+		touchscreen-x-plate-ohms = <300>;
+		touchscreen-y-plate-ohms = <800>;
+	};
+};
+
 &ecspi4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi4>;
 	cs-gpios = <&gpio3 20 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-	touchscreen@0 {
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_touch>;
-		compatible = "ti,tsc2046";
+	adc_ts: adc@0 {
+		compatible = "ti,tsc2046e-adc";
 		reg = <0>;
+		pinctrl-0 = <&pinctrl_touch>;
+		pinctrl-names ="default";
 		spi-max-frequency = <1000000>;
 		interrupts-extended = <&gpio3 19 IRQ_TYPE_LEVEL_LOW>;
-		vcc-supply = <&reg_3v3>;
-		pendown-gpio = <&gpio3 19 GPIO_ACTIVE_LOW>;
-		ti,x-plate-ohms = /bits/ 16 <850>;
-		ti,y-plate-ohms = /bits/ 16 <295>;
-		ti,pressure-min = /bits/ 16 <2>;
-		ti,pressure-max = /bits/ 16 <1500>;
-		ti,vref-mv = /bits/ 16 <3300>;
-		ti,settle-delay-usec = /bits/ 16 <15>;
-		ti,vref-delay-usecs = /bits/ 16 <0>;
-		ti,penirq-recheck-delay-usecs = /bits/ 16 <100>;
-		ti,debounce-max = /bits/ 16 <100>;
-		ti,debounce-tol = /bits/ 16 <(~0)>;
-		ti,debounce-rep = /bits/ 16 <4>;
-		touchscreen-swapped-x-y;
-		touchscreen-inverted-y;
-		wakeup-source;
+		#io-channel-cells = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		channel@1 {
+			reg = <1>;
+			settling-time-us = <700>;
+			oversampling-ratio = <5>;
+		};
+
+		channel@3 {
+			reg = <3>;
+			settling-time-us = <700>;
+			oversampling-ratio = <5>;
+		};
+
+		channel@4 {
+			reg = <4>;
+			settling-time-us = <700>;
+			oversampling-ratio = <5>;
+		};
+
+		channel@5 {
+			reg = <5>;
+			settling-time-us = <700>;
+			oversampling-ratio = <5>;
+		};
 	};
 };
 
-- 
2.30.2

