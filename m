Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BF5283AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 14:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243310AbiEPL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbiEPL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:59:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24B15A25;
        Mon, 16 May 2022 04:59:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y21so17992295edo.2;
        Mon, 16 May 2022 04:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hBQGlCOb9/uG9s6ZXsqustGqFa07ekesI9A1jC1cNws=;
        b=BlBfIjHqfrvNvI+f/E5QUsRjsOjgOXbAsCoNffZt4ZbnQMaM6vHhAXDX08vZELzlew
         RkDkf3Bv6Xw0ou/FynKxcUy1CC0AKW86J1OrzfH8VGeVuiOEErMwbvkFVr03iKuGuOjH
         q+tQESV6mmb+ZIy90Me0Osx0VUJ7NE/iACN4igveA2fy+hBkl/9JbUV3EeqKlo5s/zZr
         nIvNewaFCADR42AyCdmCg7sGISGzCe+J8U02RNzvAIICzn0qUFr31iXZYxz2QmDIglUP
         ZbA2B6jF37VLMoYh48nXbBTupYcE1xAe0R7nFQWS6fSA7Ncmdnnnt+LK7DbNMSx5yGfr
         rZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hBQGlCOb9/uG9s6ZXsqustGqFa07ekesI9A1jC1cNws=;
        b=k5Q+2a3ptStLXZnGDXlX5I3iz0lLTk4GwxK2Ilvz3rqSrYgRzdmRx48l906YZZVHFN
         cVpa5xb2tvCiZi4PwI62kiY8wVL2Mqz1Ri8aNu2VOvMg2VAjN2lr1/rAwbMImql6b/3B
         JikytsdeVokVBD/uYR6FwBvIxvFJgNOQ0l0PjzQluxpesBylTEUuPJRtAIDCFSSM8iLa
         SU6+fp/uXhw0dDWcy3eSn7qAFfBoUO30OjFb20cyEv5S2wkxgptV3RbhQd3WgETb6X+j
         HVjofMbGXNhEf3hH48QYoe+VcRGLn/6km8KG7LFtvceIJxrqMrl6KIMkQ7bXJYTPMmfQ
         5Xng==
X-Gm-Message-State: AOAM532XPVMc+k7mYxj4HUYDLz4go5wO9y7gZZpkQLVBE67HCnMu13AF
        gtLfGqv5nFRYlFQImA9U0zg=
X-Google-Smtp-Source: ABdhPJwE/XTjNI6hcbUcQDrYV8t2UZTE5vj2IrqNrrM15EDccdBWIwgkpxPPOTmcCLW5siSehUdlMw==
X-Received: by 2002:a05:6402:6da:b0:42a:9fe0:fdce with SMTP id n26-20020a05640206da00b0042a9fe0fdcemr9931535edy.172.1652702365592;
        Mon, 16 May 2022 04:59:25 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id s18-20020a170906779200b006f3ef214dacsm3711008ejm.18.2022.05.16.04.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 04:59:25 -0700 (PDT)
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
Subject: [PATCH v1 05/17] ARM: dts: imx6q-apalis: Move parallel rgb interface to SoM dtsi
Date:   Mon, 16 May 2022 13:58:33 +0200
Message-Id: <20220516115846.58328-6-max.oss.09@gmail.com>
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

Move all Parallel RGB-related nodes to the module level and disable it by
default. This allows to enable it in an overlay per the current system
configuration.

Update SPDX-License spelling to latest convention.
Update Copyright year.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
---

 arch/arm/boot/dts/imx6q-apalis-eval.dts       | 57 +------------------
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 55 +-----------------
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 55 +-----------------
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 52 ++++++++++++++++-
 4 files changed, 55 insertions(+), 164 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
index a0683b4aeca1..1e6b5482a777 100644
--- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -44,48 +44,6 @@
 		};
 	};
 
-	lcd_display: disp0 {
-		compatible = "fsl,imx-parallel-display";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
-		status = "okay";
-
-		port@0 {
-			reg = <0>;
-
-			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di1_disp1>;
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
-		power-supply = <&reg_3v3_sw>;
-
-		port {
-			lcd_panel_in: endpoint {
-				remote-endpoint = <&lcd_display_out>;
-			};
-		};
-	};
-
 	reg_pcie_switch: regulator-pcie-switch {
 		compatible = "regulator-fixed";
 		regulator-name = "pcie_switch";
@@ -106,13 +64,6 @@
 	};
 };
 
-&backlight {
-	brightness-levels = <0 127 191 223 239 247 251 255>;
-	default-brightness-level = <1>;
-	power-supply = <&reg_3v3_sw>;
-	status = "okay";
-};
-
 &can1 {
 	xceiver-supply = <&reg_3v3_sw>;
 	status = "okay";
@@ -164,10 +115,6 @@
 	status = "okay";
 };
 
-&ipu1_di1_disp1 {
-	remote-endpoint = <&lcd_display_in>;
-};
-
 &ldb {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
index 86e84781cf5d..527585d26e51 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -45,47 +45,6 @@
 		};
 	};
 
-	lcd_display: disp0 {
-		compatible = "fsl,imx-parallel-display";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
-		status = "okay";
-
-		port@0 {
-			reg = <0>;
-
-			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di1_disp1>;
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
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -114,12 +73,6 @@
 	};
 };
 
-&backlight {
-	brightness-levels = <0 127 191 223 239 247 251 255>;
-	default-brightness-level = <1>;
-	status = "okay";
-};
-
 &can1 {
 	status = "okay";
 };
@@ -164,10 +117,6 @@
 	status = "okay";
 };
 
-&ipu1_di1_disp1 {
-	remote-endpoint = <&lcd_display_in>;
-};
-
 &ldb {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
index 62e72773e53b..9900ab04fb28 100644
--- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
+++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -44,47 +44,6 @@
 		};
 	};
 
-	lcd_display: disp0 {
-		compatible = "fsl,imx-parallel-display";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		interface-pix-fmt = "rgb24";
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
-		status = "okay";
-
-		port@0 {
-			reg = <0>;
-
-			lcd_display_in: endpoint {
-				remote-endpoint = <&ipu1_di1_disp1>;
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
-
 	leds {
 		compatible = "gpio-leds";
 
@@ -113,12 +72,6 @@
 	};
 };
 
-&backlight {
-	brightness-levels = <0 127 191 223 239 247 251 255>;
-	default-brightness-level = <1>;
-	status = "okay";
-};
-
 &can1 {
 	status = "okay";
 };
@@ -168,10 +121,6 @@
 	status = "okay";
 };
 
-&ipu1_di1_disp1 {
-	remote-endpoint = <&lcd_display_in>;
-};
-
 &ldb {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 668793356b46..c0ae08780d86 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -1,6 +1,6 @@
-// SPDX-License-Identifier: GPL-2.0+ OR MIT
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
 /*
- * Copyright 2014-2020 Toradex
+ * Copyright 2014-2022 Toradex
  * Copyright 2012 Freescale Semiconductor, Inc.
  * Copyright 2011 Linaro Ltd.
  */
@@ -21,11 +21,53 @@
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_bl_on>;
-		pwms = <&pwm4 0 5000000>;
+		brightness-levels = <0 127 191 223 239 247 251 255>;
+		default-brightness-level = <1>;
 		enable-gpios = <&gpio3 13 GPIO_ACTIVE_HIGH>;
+		power-supply = <&reg_module_3v3>;
+		pwms = <&pwm4 0 5000000>;
 		status = "disabled";
 	};
 
+	lcd_display: disp0 {
+		compatible = "fsl,imx-parallel-display";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		interface-pix-fmt = "rgb24";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ipu1_lcdif>;
+		status = "disabled";
+
+		port@0 {
+			reg = <0>;
+
+			lcd_display_in: endpoint {
+				remote-endpoint = <&ipu1_di1_disp1>;
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
+		compatible = "edt,et057090dhu";
+		backlight = <&backlight>;
+
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
@@ -553,6 +595,10 @@
 	status = "disabled";
 };
 
+&ipu1_di1_disp1 {
+	remote-endpoint = <&lcd_display_in>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
-- 
2.20.1

