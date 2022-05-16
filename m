Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF8B5283C3
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiEPMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiEPL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0FF167C0;
        Mon, 16 May 2022 04:59:36 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh6so28276322ejb.0;
        Mon, 16 May 2022 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKqWeVdKRXTC0PRCpQ3WiXZdLhshSKyjEsxqGUT/HYc=;
        b=HOVL5KjJ8vLZnRuUW2KIYcrGAxudGUnJ+hwrzYqmdVzZkAxlxfk9QerQIxCDD//Rbk
         VmVqhnrTCkQ/ySHwiQzlUsEGPifjqJP2fBC8EatI00V+kHqzDJASctQl95vHmaaHmI6t
         XVg7JAKTze24nTs/M9dV9rl6Rpd83vbr3EtHjjBhFwZWhRc6TsJ0ARikICwP/UjbuuyR
         9faK/4Y3L35YjxpIUMFMCtbJ2S3TSShiA/4f61RzQcu2opkQqSdjMaVIjlihZDnBptFR
         92qdBE+7DzgWbU3zfbpyClqXH0gKOpyTFZQ7jEWkcH8eM2a0S0foyZDkigUXt42sjmmJ
         JPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKqWeVdKRXTC0PRCpQ3WiXZdLhshSKyjEsxqGUT/HYc=;
        b=lnQOI1Z0eEV1zwv8m7iuFeiMZ2hMo1KnQ+PEFyb86Zx019ZrN7G+YVxMgGmLXolc0J
         98sUPsZqLcLap383OALEeVD+TuWA+HYcuS4lelVV4uXZv5xoFW0OZU5YRTbbxml0cwBL
         yyM7bHKh7cNhJQs7o/1zT490A84zPYf5enrRZAKqPzfU7eZ4s4tn1Yjool934T61Qudf
         3q8M/DwDlbh9tEtB5IMCcqi0iRs47oeaeN6gtHlVALX1Y7mARR2F7iDzcA/B9pEyAlxX
         9lbl+f9pgmSa/GUgCYizs31KHpjumw/SJVgIa5apCjW6UNl7A3kliVjaM1pIsEaNk1kH
         58wg==
X-Gm-Message-State: AOAM533L0+DluHcj89CWTwlvbB7T8f0oLTsvTglVJjqU02spAFRzmfaE
        NJiltqLp5etLjERqPN8o7DA=
X-Google-Smtp-Source: ABdhPJzjRyVMdvgn2cmwrSPAdySFmjd6bAJZiiS1JEC/F0scx+NlGXVoK/y8QYY59y9r0SKSK6JBfA==
X-Received: by 2002:a17:906:8306:b0:6f3:da72:5ca1 with SMTP id j6-20020a170906830600b006f3da725ca1mr15039625ejx.606.1652702374743;
        Mon, 16 May 2022 04:59:34 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:34 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 11/17] ARM: dts: imx6q-apalis: Add ov5640 mipi csi camera
Date:   Mon, 16 May 2022 13:58:39 +0200
Message-Id: <20220516115846.58328-12-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516115846.58328-1-max.oss.09@gmail.com>
References: <20220516115846.58328-1-max.oss.09@gmail.com>
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

From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

The Apalis iMX6 modules allow connecting a mipi-csi video input.
Add support for our OV5640 camera module but have it disabled.
This allows to enable it in an overlay per the current system
configuration.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6qdl-apalis.dtsi | 67 ++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 506d040ea37a..0d1004eede62 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -29,6 +29,12 @@
 		status = "disabled";
 	};
 
+	clk_ov5640_osc: clk_ov5640_osc_int {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24000000>;
+	};
+
 	lcd_display: disp0 {
 		compatible = "fsl,imx-parallel-display";
 		#address-cells = <1>;
@@ -96,6 +102,26 @@
 		regulator-always-on;
 	};
 
+	reg_ov5640_1v8_d_o_vdd: regulator-ov5640-1v8-d-o-vdd {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <1800000>;
+		regulator-name = "DOVDD/DVDD_1.8V";
+		/* Note: The CSI module uses on-board 3.3V_SW supply */
+		vin-supply = <&reg_module_3v3>;
+	};
+
+	reg_ov5640_2v8_a_vdd: regulator-ov5640-2v8-a-vdd {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-max-microvolt = <2800000>;
+		regulator-min-microvolt = <2800000>;
+		regulator-name = "AVDD/AFVDD_2.8V";
+		/* Note: The CSI module uses on-board 3.3V_SW supply */
+		vin-supply = <&reg_module_3v3>;
+	};
+
 	reg_usb_otg_vbus: regulator-usb-otg-vbus {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -438,7 +464,6 @@
 		reset-gpios = <&gpio6 9 GPIO_ACTIVE_LOW>;	/* MXM3_13 */
 		status = "disabled";
 	};
-
 };
 
 /*
@@ -617,6 +642,30 @@
 	scl-gpios = <&gpio3 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio3 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "disabled";
+
+	ov5640_csi_cam: ov5640_mipi@3c {
+		compatible = "ovti,ov5640";
+		AVDD-supply = <&reg_ov5640_2v8_a_vdd>;
+		DOVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
+		DVDD-supply = <&reg_ov5640_1v8_d_o_vdd>;
+		clocks = <&clks IMX6QDL_CLK_CKO2>;
+		clock-names = "xclk";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_cam_mclk>;
+		/* These GPIOs are muxed with the iomuxc node */
+		powerdown-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>;
+		reg = <0x3c>;
+		reset-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
+		status = "disabled";
+
+		port {
+			ov5640_to_mipi_csi2: endpoint {
+				clock-lanes = <0>;
+				data-lanes = <1 2>;
+				remote-endpoint = <&mipi_csi_from_ov5640>;
+			};
+		};
+	};
 };
 
 &ipu1_di1_disp1 {
@@ -647,6 +696,22 @@
 	};
 };
 
+&mipi_csi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "disabled";
+
+	port@0 {
+		reg = <0>;
+
+		mipi_csi_from_ov5640: endpoint {
+			clock-lanes = <0>;
+			data-lanes = <1 2>;
+			remote-endpoint = <&ov5640_to_mipi_csi2>;
+		};
+	};
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.20.1

