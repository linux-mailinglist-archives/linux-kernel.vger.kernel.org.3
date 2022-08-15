Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A39592C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbiHOI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbiHOI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 04:28:50 -0400
Received: from mail.fris.de (mail.fris.de [IPv6:2a01:4f8:c2c:390b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0C41F624;
        Mon, 15 Aug 2022 01:28:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C651BFADB;
        Mon, 15 Aug 2022 10:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
        t=1660552125; h=from:subject:date:message-id:to:cc:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=sl6SUxmAvCtP4OCDbrUpoCUjEKmSThZ1ykVQkty4PkY=;
        b=ERH0izhw41NwQGgY3f8bYUY5SceyY9Z5TY1NsyeRlxzk/bqt2ZG3IsvH3nxL2DcjIQCRaY
        1ZTUw6YiT6BVgUpnWVgfrpLqiJ+xzgnaJr1C3L6tgS4YYGi0MRSHD/l7oMnQQ1vvmaawim
        XCDu+5N1WGU79y1FjTTaK5BjYd6W3p0lAjOhBHZIo6lAYONlTbinBv+TwDRI8wdJc8pY3G
        3zAWYyEuZIT7JC5T19sjPw52aFlBANPG9GKohw60QJuxwdyVKd15EyabasriPX78cLfE5B
        neVZyN6XTAdjvEUwzOZKyWtdiu076Slb2tZ4lWn+af+SlBA/Bus9+KLkhojLhg==
From:   Frieder Schrempf <frieder@fris.de>
To:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, soc@kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH v3 2/3] ARM: dts: imx6ul-kontron: Simplify devicetree structure
Date:   Mon, 15 Aug 2022 10:28:11 +0200
Message-Id: <20220815082814.27651-3-frieder@fris.de>
In-Reply-To: <20220815082814.27651-1-frieder@fris.de>
References: <20220815082814.27651-1-frieder@fris.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

There is no need in differentiating between the different SoM versions
that only differ in memory size, etc. It's much cleaner to simplify
the devicetrees and let them be more generic.

If necessary the bootloader will update the devicetree dynamically
to contain the correct size of the memory.

We also get rid of the N6xxx notation in the compatibles and file
names, as they are not really used anymore and often result in
confusion.

This is a breaking change, but the impact shouldn't be too big and it
makes usage and maintenance easier in the future.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 arch/arm/boot/dts/Makefile                    |  4 +-
 ...6310-s-43.dts => imx6ul-kontron-bl-43.dts} |  8 ++--
 ...x-s.dtsi => imx6ul-kontron-bl-common.dtsi} |  0
 ...tron-n6310-s.dts => imx6ul-kontron-bl.dts} |  9 ++---
 .../boot/dts/imx6ul-kontron-n6311-som.dtsi    | 40 -------------------
 ...mon.dtsi => imx6ul-kontron-sl-common.dtsi} | 15 +++++++
 ...-n6310-som.dtsi => imx6ul-kontron-sl.dtsi} | 33 ++-------------
 ...ron-n6411-s.dts => imx6ull-kontron-bl.dts} |  9 ++---
 .../boot/dts/imx6ull-kontron-n6411-som.dtsi   | 40 -------------------
 ...on-n6311-s.dts => imx6ull-kontron-sl.dtsi} | 11 ++---
 10 files changed, 36 insertions(+), 133 deletions(-)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s-43.dts => imx6ul-kontron-bl-43.dts} (93%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-s.dtsi => imx6ul-kontron-bl-common.dtsi} (100%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-s.dts => imx6ul-kontron-bl.dts} (52%)
 delete mode 100644 arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6x1x-som-common.dtsi => imx6ul-kontron-sl-common.dtsi} (90%)
 rename arch/arm/boot/dts/{imx6ul-kontron-n6310-som.dtsi => imx6ul-kontron-sl.dtsi} (28%)
 rename arch/arm/boot/dts/{imx6ull-kontron-n6411-s.dts => imx6ull-kontron-bl.dts} (43%)
 delete mode 100644 arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
 rename arch/arm/boot/dts/{imx6ul-kontron-n6311-s.dts => imx6ull-kontron-sl.dtsi} (41%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5112f493f494..6627aed26fd6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -696,8 +696,8 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-geam.dtb \
 	imx6ul-isiot-emmc.dtb \
 	imx6ul-isiot-nand.dtb \
-	imx6ul-kontron-n6310-s.dtb \
-	imx6ul-kontron-n6310-s-43.dtb \
+	imx6ul-kontron-bl.dtb \
+	imx6ul-kontron-bl-43.dtb \
 	imx6ul-liteboard.dtb \
 	imx6ul-tqma6ul1-mba6ulx.dtb \
 	imx6ul-tqma6ul2-mba6ulx.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
similarity index 93%
rename from arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
rename to arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
index 5bfad4655b22..0c643706a158 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s-43.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-bl-43.dts
@@ -5,12 +5,12 @@
  * Copyright (c) 2019 Krzysztof Kozlowski <krzk@kernel.org>
  */
 
-#include "imx6ul-kontron-n6310-s.dts"
+#include "imx6ul-kontron-bl.dts"
 
 / {
-	model = "Kontron N6310 S 43";
-	compatible = "kontron,imx6ul-n6310-s-43", "kontron,imx6ul-n6310-s",
-		     "kontron,imx6ul-n6310-som", "fsl,imx6ul";
+	model = "Kontron BL i.MX6UL 43 (N631X S 43)";
+	compatible = "kontron,bl-imx6ul-43", "kontron,bl-imx6ul",
+		     "kontron,sl-imx6ul", "fsl,imx6ul";
 
 	backlight {
 		compatible = "pwm-backlight";
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi b/arch/arm/boot/dts/imx6ul-kontron-bl-common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/imx6ul-kontron-n6x1x-s.dtsi
rename to arch/arm/boot/dts/imx6ul-kontron-bl-common.dtsi
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts b/arch/arm/boot/dts/imx6ul-kontron-bl.dts
similarity index 52%
rename from arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
rename to arch/arm/boot/dts/imx6ul-kontron-bl.dts
index 5a3e06d6219b..dadf6d3d5f52 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-bl.dts
@@ -7,11 +7,10 @@
 
 /dts-v1/;
 
-#include "imx6ul-kontron-n6310-som.dtsi"
-#include "imx6ul-kontron-n6x1x-s.dtsi"
+#include "imx6ul-kontron-sl.dtsi"
+#include "imx6ul-kontron-bl-common.dtsi"
 
 / {
-	model = "Kontron N6310 S";
-	compatible = "kontron,imx6ul-n6310-s", "kontron,imx6ul-n6310-som",
-		     "fsl,imx6ul";
+	model = "Kontron BL i.MX6UL (N631X S)";
+	compatible = "kontron,bl-imx6ul", "kontron,sl-imx6ul", "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
deleted file mode 100644
index 29ed38dce580..000000000000
--- a/arch/arm/boot/dts/imx6ul-kontron-n6311-som.dtsi
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-#include "imx6ul.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
-
-/ {
-	model = "Kontron N6311 SOM";
-	compatible = "kontron,imx6ul-n6311-som", "fsl,imx6ul";
-
-	memory@80000000 {
-		reg = <0x80000000 0x20000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <104000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x18000000>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi b/arch/arm/boot/dts/imx6ul-kontron-sl-common.dtsi
similarity index 90%
rename from arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
rename to arch/arm/boot/dts/imx6ul-kontron-sl-common.dtsi
index 09a83dbdf651..dcf88f610346 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6x1x-som-common.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-sl-common.dtsi
@@ -11,6 +11,11 @@ / {
 	chosen {
 		stdout-path = &uart4;
 	};
+
+	memory@80000000 {
+		reg = <0x80000000 0x10000000>;
+		device_type = "memory";
+	};
 };
 
 &ecspi2 {
@@ -55,6 +60,16 @@ &qspi {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_qspi>;
 	status = "okay";
+
+	spi-flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "spi-nand";
+		spi-max-frequency = <104000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+		reg = <0>;
+	};
 };
 
 &wdog1 {
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi b/arch/arm/boot/dts/imx6ul-kontron-sl.dtsi
similarity index 28%
rename from arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
rename to arch/arm/boot/dts/imx6ul-kontron-sl.dtsi
index acd936540d89..0580d043e5ae 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-kontron-sl.dtsi
@@ -6,36 +6,9 @@
  */
 
 #include "imx6ul.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
+#include "imx6ul-kontron-sl-common.dtsi"
 
 / {
-	model = "Kontron N6310 SOM";
-	compatible = "kontron,imx6ul-n6310-som", "fsl,imx6ul";
-
-	memory@80000000 {
-		reg = <0x80000000 0x10000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <108000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x08000000>;
-		};
-	};
+	model = "Kontron SL i.MX6UL (N631X SOM)";
+	compatible = "kontron,sl-imx6ul", "fsl,imx6ul";
 };
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts b/arch/arm/boot/dts/imx6ull-kontron-bl.dts
similarity index 43%
rename from arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
rename to arch/arm/boot/dts/imx6ull-kontron-bl.dts
index 57588a5e1e34..fa016465cdbc 100644
--- a/arch/arm/boot/dts/imx6ull-kontron-n6411-s.dts
+++ b/arch/arm/boot/dts/imx6ull-kontron-bl.dts
@@ -6,11 +6,10 @@
 
 /dts-v1/;
 
-#include "imx6ull-kontron-n6411-som.dtsi"
-#include "imx6ul-kontron-n6x1x-s.dtsi"
+#include "imx6ull-kontron-sl.dtsi"
+#include "imx6ul-kontron-bl-common.dtsi"
 
 / {
-	model = "Kontron N6411 S";
-	compatible = "kontron,imx6ull-n6411-s", "kontron,imx6ull-n6411-som",
-		     "fsl,imx6ull";
+	model = "Kontron BL i.MX6ULL (N641X S)";
+	compatible = "kontron,bl-imx6ull", "kontron,sl-imx6ull", "fsl,imx6ull";
 };
diff --git a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi b/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
deleted file mode 100644
index d000606c0704..000000000000
--- a/arch/arm/boot/dts/imx6ull-kontron-n6411-som.dtsi
+++ /dev/null
@@ -1,40 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 exceet electronics GmbH
- * Copyright (C) 2018 Kontron Electronics GmbH
- */
-
-#include "imx6ull.dtsi"
-#include "imx6ul-kontron-n6x1x-som-common.dtsi"
-
-/ {
-	model = "Kontron N6411 SOM";
-	compatible = "kontron,imx6ull-n6311-som", "fsl,imx6ull";
-
-	memory@80000000 {
-		reg = <0x80000000 0x20000000>;
-		device_type = "memory";
-	};
-};
-
-&qspi {
-	flash@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "spi-nand";
-		spi-max-frequency = <104000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-		reg = <0>;
-
-		partition@0 {
-			label = "ubi1";
-			reg = <0x00000000 0x08000000>;
-		};
-
-		partition@8000000 {
-			label = "ubi2";
-			reg = <0x08000000 0x18000000>;
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts b/arch/arm/boot/dts/imx6ull-kontron-sl.dtsi
similarity index 41%
rename from arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
rename to arch/arm/boot/dts/imx6ull-kontron-sl.dtsi
index 239a1af3aeaa..93f10eb3494f 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6311-s.dts
+++ b/arch/arm/boot/dts/imx6ull-kontron-sl.dtsi
@@ -4,13 +4,10 @@
  * Copyright (C) 2018 Kontron Electronics GmbH
  */
 
-/dts-v1/;
-
-#include "imx6ul-kontron-n6311-som.dtsi"
-#include "imx6ul-kontron-n6x1x-s.dtsi"
+#include "imx6ull.dtsi"
+#include "imx6ul-kontron-sl-common.dtsi"
 
 / {
-	model = "Kontron N6311 S";
-	compatible = "kontron,imx6ul-n6311-s", "kontron,imx6ul-n6311-som",
-		     "fsl,imx6ul";
+	model = "Kontron SL i.MX6ULL (N641X SOM)";
+	compatible = "kontron,sl-imx6ull", "fsl,imx6ull";
 };
-- 
2.37.1

