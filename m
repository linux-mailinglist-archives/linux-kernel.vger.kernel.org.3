Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8644FC072
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347942AbiDKPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347890AbiDKPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:25:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E1E3BA40;
        Mon, 11 Apr 2022 08:22:55 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r64so10128870wmr.4;
        Mon, 11 Apr 2022 08:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azh5l951MpFAgYPR/Hx/XxEuebGMoFjq0h/SwKZyYXM=;
        b=E5XiMCiOjM5Y+RDysiNnT7H9f4qVHFz9s41YpQX9mW6u6EevPWoEHW5weNOVqbFghG
         +bQKQ1JaGIBLc9l9zkol20WiFbddOTMJ24tLPIioIGunewweqRjBdQE0Zm35n8XMvYsH
         5RPjAzoIZewvZ2HuEk+OEtK8K0q3yP2sZHFVlV4gwOPQZn17j5+XFOm2GH2xUsX73U2A
         Pkt25zPQNBAln6ZWCp8KX47gaouKk1sxXZUdyauCtyiMg2GK2X2Ps2yoppneRHHG2kpZ
         w8Bxib7Z1+qKXiWWEooIWjNLE2dylf3q9YyQkiaeSZK4/WSqCSYg4HQ0CgdQ0SaJEN2/
         D6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azh5l951MpFAgYPR/Hx/XxEuebGMoFjq0h/SwKZyYXM=;
        b=k/mgE7uIFBEtzm4MIZunSVhwAncPtYg97Bds8bN7VO/LMwum2gqXO4YLUrp6Ml7wTG
         s4AinyJVh5YknneF06sBxJ8xK7RPQ9X0dI/NNYyfKHYJ1g/6is37vUbpWxtq7M8b4Ov3
         mLSOhCmcmfoJNX+6QPkO39RhvTiTPDBo8do2RKMmQyoRgfFXPHAHlZ/A4DsJ83h1KdMY
         WEpMzl32BU9JH1guqB88fLVwE/UFYPMyIaTcCIUyJkI5tniRFYLVWYBwrqSuUcqscx2J
         +4JuYgd7fb1gt3gaSVmkMutid5iyZyLgjqB0W+iXgXP+zOTeTdBDBmlY/QTBrH4YwI9+
         fi8Q==
X-Gm-Message-State: AOAM533oqDyrRajfvah/5sU1eRwcLVf1SLEE1Vsz01qTwVeuuWwrCEM0
        zYZ0ZhomQGwdkcqEb6QnQKs=
X-Google-Smtp-Source: ABdhPJzrMUBwKjKDyTGhhVauBr3xDo7CRNie0uLfMBJmPjbqXY7M9qQhj2400Nmxvd6dm7J7NpLaWA==
X-Received: by 2002:a05:600c:1994:b0:38c:95b5:bbfa with SMTP id t20-20020a05600c199400b0038c95b5bbfamr29920378wmq.0.1649690573125;
        Mon, 11 Apr 2022 08:22:53 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id a9-20020a7bc1c9000000b0038eb67e966esm5209374wmj.29.2022.04.11.08.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 08:22:52 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/14] ARM: dts: imx6dl-colibri: Disable add-on accessories
Date:   Mon, 11 Apr 2022 17:22:26 +0200
Message-Id: <20220411152234.12678-7-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220411152234.12678-1-max.oss.09@gmail.com>
References: <20220411152234.12678-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

The Toradex Colibri family is composed of SoM that can be plugged in
various carrier board, with carrier boards allowing multiple optional
add-on (e.g. display, camera, ...).

Keep all the SoM specific part into the module .dtsi, disabling
everything that is not self-contained on the board. The carrier board
dts can reuse/enable anything that is defined in the module dtsi.
Additional device tree overlays can be used for any accessories that
are plugged in the carrier board.

Disable parallel RGB:
The parallel RGB interface (lcd_display) and all related nodes can
be enabled in an overlay if used. Keep all nodes disabled in the
module-level device tree.
Rename display interface node to match imx6qdl-apalis
to make it easier to use overlays.
The pwm-backlight binding now requires the power-supply property,
add it.

Disable stmpe touchscreen:
The touchscreen can be enabled in an overlay if used.
Add labels to the stmpe sub nodes.

Disable hdmi interface:
HDMI can be enabled in an overlay if used.

Update SPDX-License spelling to latest convention.
Update Copyright year.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

(no changes since v1)

 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 59 +-------------------
 arch/arm/boot/dts/imx6qdl-colibri.dtsi       | 57 ++++++++++++++++++-
 2 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 7da74e6f46d9..535b5c156229 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -58,53 +58,6 @@
 			wakeup-source;
 		};
 	};
-
-	lcd_display: disp0 {
-		compatible = "fsl,imx-parallel-display";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interface-pix-fmt = "bgr666";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
-		status = "okay";
-
-		port@0 {
-			reg = <0>;
-
-			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di0_disp0>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			lcd_display_out: endpoint {
-				remote-endpoint = <&lcd_panel_in>;
-			};
-		};
-	};
-
-	panel: panel {
-		/*
-		 * edt,et057090dhu: EDT 5.7" LCD TFT
-		 * edt,et070080dh6: EDT 7.0" LCD TFT
-		 */
-		compatible = "edt,et057090dhu";
-		backlight = <&backlight>;
-
-		port {
-			lcd_panel_in: endpoint {
-				remote-endpoint = <&lcd_display_out>;
-			};
-		};
-	};
-};
-
-&backlight {
-	brightness-levels = <0 127 191 223 239 247 251 255>;
-	default-brightness-level = <1>;
-	status = "okay";
 };
 
 /* Colibri SSP */
@@ -122,10 +75,6 @@
 	};
 };
 
-&hdmi {
-	status = "okay";
-};
-
 /*
  * Colibri I2C: I2C3_SDA/SCL on SODIMM 194/196 (e.g. RTC on carrier board)
  */
@@ -178,10 +127,6 @@
 	};
 };
 
-&ipu1_di0_disp0 {
-	remote-endpoint = <&lcd_display_in>;
-};
-
 &pwm1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c92887f6af61..f6243762e918 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -13,13 +13,59 @@
 
 	backlight: backlight {
 		compatible = "pwm-backlight";
+		brightness-levels = <0 127 191 223 239 247 251 255>;
+		default-brightness-level = <1>;
+		enable-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* Colibri BL_ON */
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
+		power-supply = <&reg_module_3v3>;
 		pwms = <&pwm3 0 5000000>;
-		enable-gpios = <&gpio3 26 GPIO_ACTIVE_HIGH>; /* Colibri BL_ON */
 		status = "disabled";
 	};
 
+	lcd_display: disp0 {
+		compatible = "fsl,imx-parallel-display";
+		interface-pix-fmt = "bgr666";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
+		status = "disabled";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		port@0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di0_disp0>;
+			};
+		};
+
+		port@1 {
+			reg = <1>;
+
+			lcd_display_out: endpoint {
+				remote-endpoint = <&lcd_panel_in>;
+			};
+		};
+	};
+
+	panel_dpi: panel-dpi {
+		/*
+		 * edt,et057090dhu: EDT 5.7" LCD TFT
+		 * edt,et070080dh6: EDT 7.0" LCD TFT
+		 */
+		compatible = "edt,et057090dhu";
+		backlight = <&backlight>;
+		status = "disabled";
+
+		port {
+			lcd_panel_in: endpoint {
+				remote-endpoint = <&lcd_display_out>;
+			};
+		};
+	};
+
 	reg_module_3v3: regulator-module-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "+V3.3";
@@ -476,7 +522,7 @@
 		/* ADC converstion time: 80 clocks */
 		st,sample-time = <4>;
 
-		stmpe_touchscreen {
+		stmpe_ts: stmpe_touchscreen {
 			compatible = "st,stmpe-ts";
 			/* 8 sample average control */
 			st,ave-ctrl = <3>;
@@ -491,9 +537,10 @@
 			st,settling = <3>;
 			/* 5 ms touch detect interrupt delay */
 			st,touch-det-delay = <5>;
+			status = "disabled";
 		};
 
-		stmpe_adc {
+		stmpe_adc: stmpe_adc {
 			compatible = "st,stmpe-adc";
 			/* forbid to use ADC channels 3-0 (touch) */
 			st,norequest-mask = <0x0F>;
@@ -514,6 +561,10 @@
 	status = "disabled";
 };
 
+&ipu1_di0_disp0 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
 /* Colibri PWM<B> */
 &pwm1 {
 	pinctrl-names = "default";
-- 
2.20.1

