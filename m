Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643944D8934
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:31:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243155AbiCNQcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243057AbiCNQbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:31:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C3613CF7;
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id r190-20020a1c2bc7000000b0038a1013241dso2070374wmr.1;
        Mon, 14 Mar 2022 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9syfLAeUMuDCT7+k274ygLM02eVSibv/ExsyEoQU3A=;
        b=iX3HGOaOAPz16P+P0rMVHT5Bp1G5WU4nZBYD67Np692jb74DZg28/d6GrE9SYA2abt
         KeqtmuioXOtxayGTMj5LBGlSuMhpBVLZb+XlZUxK2Lg2+OY3K8CXZCNRY0AJy6cXLC8M
         jB2WgINyoDzQxJktxaPaDsDtuvwg9ASq/d7OlZ6R4kL9Mg7JSavFzstyKK/PPSuR7ojk
         V7lRetzjzABB1wnyCN5KkJ8VMu7CaZnzAUAUM0419GWf3FC9tIUqmxgLx/QRRU+ysjQC
         nR0jrFl7UDHlB4qULsC+ibhEV0SAjF8Yx2RrvkET6cpzClfzTPWcGLSdoePoKvYtZsEu
         YoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9syfLAeUMuDCT7+k274ygLM02eVSibv/ExsyEoQU3A=;
        b=viomEw1Fw6tu6YxaqgK4eNf+aja5zBJQC5sKvQNTQV20wc9TArSwHZEUYAy8Q5/wcB
         faJhWMit6PntMjGylcxEXl14YCVKS62ygyqiOex6xhcaDG2YVaRJPwa32+FM5ztrkk0r
         1mNHfoF/4e1D+kFLYJaefviIBY36tfP3vjHYof72Ql2/74NgCzo6vGsYaOxEScNJ2XnK
         VPn1Ja595iaAzP/WNq7RhKvPsWXVc4Fk7jWXIFEBf5BWx2ghMNYudOs+FfuoeZ1Ta6aK
         Niar/7JJo3f5gP5J4cBPmpVGHdu22DokP9L0LkH8ImRFY//IyQLOjFMITFNCwhbSnNTk
         CQJA==
X-Gm-Message-State: AOAM531bNZtIZCYwbUGwyyg004+fejr3p4MZ6f+5JNB1Ma3PXwPFKkns
        bOSHan3LZhxhma8UXjZXPbo=
X-Google-Smtp-Source: ABdhPJxhYhe1RdfsAlJUdEocLedc3X/12ar5deYwugiH0MS4Rer4QJnMIStUW2ohY4EVzECpTiIPmQ==
X-Received: by 2002:a05:600c:1550:b0:389:d623:cb7f with SMTP id f16-20020a05600c155000b00389d623cb7fmr19003928wmg.183.1647275420746;
        Mon, 14 Mar 2022 09:30:20 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id w10-20020a5d680a000000b001f1dabec837sm13476817wru.113.2022.03.14.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:30:20 -0700 (PDT)
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
Subject: [PATCH v1 06/14] ARM: dts: imx6dl-colibri: Disable add-on accessories
Date:   Mon, 14 Mar 2022 17:29:50 +0100
Message-Id: <20220314162958.40361-7-max.krummenacher@toradex.com>
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

