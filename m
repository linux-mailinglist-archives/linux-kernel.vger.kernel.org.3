Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084325515D8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241104AbiFTK2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240987AbiFTK2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:28:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134ABBC39;
        Mon, 20 Jun 2022 03:28:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KASN7G106135;
        Mon, 20 Jun 2022 05:28:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655720903;
        bh=rjNEY+fb0FLAlDCmgbjFcgdwmo6fWi+NdwjkkRfj88U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pf0Fz33URnLUEiDAcD4iF3Dm8SJ4hxZ/LT3CPZ+w9Txjho0mDF2YfTVd08jyoYnBM
         J6l+mYRfTL57NHnnDiumHBaOzyFDgcQJn0EO3vDi2Lfv7BDzv0XKSkzs9LBd4VZ8/o
         jR96kGUwUQeQ6qbycuXN97EZWXNXgkDdw9y5bEEc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KASNFa095347
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 05:28:23 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 05:28:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 05:28:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KASM56100090;
        Mon, 20 Jun 2022 05:28:22 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v4 2/2] arm64: dts: ti: k3-am625-sk: Add audio output support
Date:   Mon, 20 Jun 2022 15:57:50 +0530
Message-ID: <20220620102750.32718-4-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220620102750.32718-1-j-luthra@ti.com>
References: <20220620102750.32718-1-j-luthra@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for audio codec and sound card, enable the audio serializer
(McASP1) under use and update pinmux. Disable all other McASP nodes.

Audio input is currently not working properly, so the RX port on McASP1
is disabled for now, until the issue is debugged.

The serializer is shared between HDMI and codec. By default codec is
used for output, but it can be toggled to HDMI using a FET switch
connected to the MCASP1_FET_SEL (J24) header on the board.

Signed-off-by: Jai Luthra <j-luthra@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 89 ++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 39fb1d763037..a502b7ac48d4 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -121,6 +121,46 @@
 			 <3300000 0x1>;
 	};
 
+	vcc_1v8: regulator-5 {
+		/* output of TPS6282518DMQ */
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&vcc_3v3_sys>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	tlv320_mclk: clk-0 {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <12288000>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "AM62x-SKEVM";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT";
+		simple-audio-card,format = "dsp_b";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		simple-audio-card,bitclock-inversion;
+
+		simple-audio-card,cpu {
+			sound-dai = <&mcasp1>;
+		};
+
+		sound_master: simple-audio-card,codec {
+			sound-dai = <&tlv320aic3106>;
+			clocks = <&tlv320_mclk>;
+		};
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -266,6 +306,15 @@
 			AM62X_IOPAD(0x01d4, PIN_INPUT, 7) /* (B15) UART0_RTSn.GPIO1_23 */
 		>;
 	};
+
+	main_mcasp1_pins_default: main-mcasp1-pins-default {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0090, PIN_INPUT, 2) /* (M24) GPMC0_BE0N_CLE.MCASP1_ACLKX */
+			AM62X_IOPAD(0x0098, PIN_INPUT, 2) /* (U23) GPMC0_WAIT0.MCASP1_AFSX */
+			AM62X_IOPAD(0x008c, PIN_OUTPUT, 2) /* (L25) GPMC0_WEN.MCASP1_AXR0 */
+			AM62X_IOPAD(0x0084, PIN_INPUT, 2) /* (L23) GPMC0_ADVN_ALE.MCASP1_AXR2 */
+		>;
+	};
 };
 
 &wkup_uart0 {
@@ -352,6 +401,18 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&main_gpio1_ioexp_intr_pins_default>;
 	};
+
+	tlv320aic3106: audio-codec@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+
+		/* Regulators */
+		AVDD-supply = <&vcc_3v3_sys>;
+		IOVDD-supply = <&vcc_3v3_sys>;
+		DRVDD-supply = <&vcc_3v3_sys>;
+		DVDD-supply = <&vcc_1v8>;
+	};
 };
 
 &main_i2c2 {
@@ -412,6 +473,34 @@
 	};
 };
 
+&mcasp0 {
+	status = "disabled";
+};
+
+&mcasp1 {
+	status = "okay";
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mcasp1_pins_default>;
+
+	op-mode = <0>;          /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+	       1 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	       0 0 0 0
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
+
+&mcasp2 {
+	status = "disabled";
+};
+
 &mailbox0_cluster0 {
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 0>;
-- 
2.17.1

