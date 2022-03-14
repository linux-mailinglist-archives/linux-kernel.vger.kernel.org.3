Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254D94D8936
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiCNQcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243059AbiCNQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42171DA46;
        Mon, 14 Mar 2022 09:30:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso9247wms.1;
        Mon, 14 Mar 2022 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erJKWfBVOPAC7/YbLDzpdnGH/84KxFdomOjrDboBHfI=;
        b=cZCKVB8t8KSxqaj37vNnTAYOOXjtoVKGCKEf45FO/JhqDkD4X1fmmhYmJTvGzZeIqJ
         YgEXV+OfhEWS+TaNVEt+qLIkzv+0RuGMEjQqndI/t23z3OZvg8bh56CZ7Q2GEPmX0XAT
         4Du/N+CcT1mWqYBI9x/UJaXPb5BShIcnen/XjH7DDwUCU48cVbC0d3/cFEa+X8D6APHx
         tD2sqJU3I7q41mByFWHZHQjlO0blSonXRBDjwQ1L0HARLaN+3BWaTagZbY05hTexYasE
         68p3jCSehZESe79but0Dom54DDr9/CcqdqoGH6d46a5ntjU3fw0eMVg4HYlq1Pv5Rcsl
         Uc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erJKWfBVOPAC7/YbLDzpdnGH/84KxFdomOjrDboBHfI=;
        b=smtF+yfcbJBc1a1EpA8bLRIqqkP3MnFwSQFR1IqCp1FSUGYBHQhm2I9rZM1ISKw3wY
         Z0g6h99VYbvtMUo8rkcFE6ileErZmQgo5DgWUNgio1wX7haMPNKOde7wX9AFncCLQ7Ob
         Dwzk8yc2cvDZzhnNcwifOE7DNCjty7i+DA/pj2D3oT8MetedYs1ZJP+v7/7ot8vxMh1z
         Eje9kB1VJvWRcyYRtGNPVvPznb4JTYJobE+NfaWYKa84HrH31UPG3sBCR1hHw+G6Rd2F
         IqA2FAPlla8GIarUiCq1Ukck0LMl/VEW1/FQQtaEEeDoEdJ3kNIky9MyvsjGKZabMfkt
         N4xA==
X-Gm-Message-State: AOAM531ZkhJQU6PvwPGACwi++smc7NSiVt/4egB77LTypInyqsibxpw4
        MQEd320/8psYsCR5bv3x4OA=
X-Google-Smtp-Source: ABdhPJzg8REEfcJlApAVgv6ga/UP1lVc3QKJ2cYQrHVEOYgQPeWLyQU56sDjkT5peLsoa/G6IPt66w==
X-Received: by 2002:a05:600c:21d1:b0:381:4fed:159a with SMTP id x17-20020a05600c21d100b003814fed159amr5422wmj.143.1647275423287;
        Mon, 14 Mar 2022 09:30:23 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 09/14] ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi
Date:   Mon, 14 Mar 2022 17:29:53 +0100
Message-Id: <20220314162958.40361-10-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220314162958.40361-1-max.krummenacher@toradex.com>
References: <20220314162958.40361-1-max.krummenacher@toradex.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following two nodes define module level functionality, move
them from the carrier board dts file to the SoM file.
While at it, reorder the properties in the gpio-keys node alphabetical.

- gpio-keys defining the wakeup pin
- memory node

The atmel touchscreen node can be used on any carrier board.
Move it from the carrier board to the module-level device tree and
keep it disabled.
Set the default pinmuxing to the dedicated connector available
on newer carrier boards and rename the pinctrl labels specifying
the INT/Reset signal to a common pattern.
  pinctrl_atmel_conn - uses 107/106 pins as used on dedicated connector
  pinctrl_atmel_adap - uses 28/30 pins as used with jumper wires

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 49 ------------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 53 ++++++++++++++++++++
 2 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 535b5c156229..dff2d35e693b 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -17,12 +17,6 @@
 	compatible = "toradex,colibri_imx6dl-eval-v3", "toradex,colibri_imx6dl",
 		     "fsl,imx6dl";
 
-	/* Will be filled by the bootloader */
-	memory@10000000 {
-		device_type = "memory";
-		reg = <0x10000000 0>;
-	};
-
 	aliases {
 		i2c0 = &i2c2;
 		i2c1 = &i2c3;
@@ -44,20 +38,6 @@
 		clock-frequency = <16000000>;
 		clock-output-names = "clk16m";
 	};
-
-	gpio-keys {
-		compatible = "gpio-keys";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_gpio_keys>;
-
-		wakeup {
-			label = "Wake-Up";
-			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
-			linux,code = <KEY_WAKEUP>;
-			debounce-interval = <10>;
-			wakeup-source;
-		};
-	};
 };
 
 /* Colibri SSP */
@@ -81,21 +61,6 @@
 &i2c3 {
 	status = "okay";
 
-	/*
-	 * Touchscreen is using SODIMM 28/30, also used for PWM<B>, PWM<C>,
-	 * aka pwm2, pwm3. so if you enable touchscreen, disable the pwms
-	 */
-	touchscreen@4a {
-		compatible = "atmel,maxtouch";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcap_1>;
-		reg = <0x4a>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;		/* SODIMM 28 */
-		reset-gpios = <&gpio2 10 GPIO_ACTIVE_LOW>;	/* SODIMM 30 */
-		status = "disabled";
-	};
-
 	/* M41T0M6 real time clock on carrier board */
 	rtc_i2c: rtc@68 {
 		compatible = "st,m41t0";
@@ -111,20 +76,6 @@
 		&pinctrl_weim_gpio_5 &pinctrl_weim_gpio_6
 		&pinctrl_usbh_oc_1 &pinctrl_usbc_id_1
 	>;
-
-	pinctrl_pcap_1: pcap1grp {
-		fsl,pins = <
-			MX6QDL_PAD_GPIO_9__GPIO1_IO09	0x1b0b0 /* SODIMM 28 */
-			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10	0x1b0b0 /* SODIMM 30 */
-		>;
-	};
-
-	pinctrl_mxt_ts: mxttsgrp {
-		fsl,pins = <
-			MX6QDL_PAD_EIM_CS1__GPIO2_IO24	0x130b0 /* SODIMM 107 */
-			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14	0x130b0 /* SODIMM 106 */
-		>;
-	};
 };
 
 &pwm1 {
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index 3459bfb5c60b..1c49fd3e6286 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -23,6 +23,20 @@
 		status = "disabled";
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_keys>;
+
+		wakeup {
+			debounce-interval = <10>;
+			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>; /* SODIMM 45 */
+			label = "Wake-Up";
+			linux,code = <KEY_WAKEUP>;
+			wakeup-source;
+		};
+	};
+
 	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		interface-pix-fmt = "bgr666";
@@ -50,6 +64,12 @@
 		};
 	};
 
+	/* Will be filled by the bootloader */
+	memory@10000000 {
+		device_type = "memory";
+		reg = <0x10000000 0>;
+	};
+
 	panel_dpi: panel-dpi {
 		/*
 		 * edt,et057090dhu: EDT 5.7" LCD TFT
@@ -564,6 +584,17 @@
 	scl-gpios = <&gpio1 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio1 6 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	atmel_mxt_ts: touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		interrupt-parent = <&gpio2>;
+		interrupts = <24 IRQ_TYPE_EDGE_FALLING>;	/* SODIMM 107 */
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_atmel_conn>;
+		reg = <0x4a>;
+		reset-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		status = "disabled";
+	};
 };
 
 &ipu1_di0_disp0 {
@@ -682,6 +713,28 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usbh_oc_1>;
 
+	/* Atmel MXT touchsceen + Capacitive Touch Adapter */
+	/* NOTE: This pin group conflicts with pin groups
+	 * pinctrl_pwm1/pinctrl_pwm4. Don't use them simultaneously.
+	 */
+	pinctrl_atmel_adap: atmeladaptergrp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_9__GPIO1_IO09   0xb0b1  /* SODIMM  28 */
+			MX6QDL_PAD_SD4_DAT2__GPIO2_IO10 0xb0b1  /* SODIMM  30 */
+		>;
+	};
+
+	/* Atmel MXT touchsceen + boards with built-in Capacitive Touch Connector */
+	/* NOTE: This pin group conflicts with pin groups pinctrl_weim_cs1 and
+	 * pinctrl_weim_cs2. Don't use them simultaneously.
+	 */
+	pinctrl_atmel_conn: atmelconnectorgrp {
+		fsl,pins = <
+			MX6QDL_PAD_EIM_CS1__GPIO2_IO24  0xb0b1  /* SODIMM_107 */
+			MX6QDL_PAD_SD2_DAT1__GPIO1_IO14 0xb0b1  /* SODIMM_106 */
+		>;
+	};
+
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_COL0__AUD5_TXC	0x130b0
-- 
2.20.1

