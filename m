Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2425AAC12
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiIBKIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbiIBKIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:08:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9498E99265;
        Fri,  2 Sep 2022 03:08:17 -0700 (PDT)
Received: from localhost (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 52C4E6601ECD;
        Fri,  2 Sep 2022 11:08:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662113296;
        bh=PnxgHYy3tBGlEE2Z3ijS2VaXZ9ECaU56aH/Odp+EDMU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKvQ8VrgBGulJXCrTHL+dg1ot8nbQ1jiN12jsgdsJGdyMFmLeFqte298YUKL9cGHO
         ZHFOCWrhfR/iVW+0nlCVSbi2zWuDS47NzeiDakerpwGiyoXIi4aZuF2DIO5KYpM0HB
         h94fH9UYDVeLN4E6jNn6/NwLsugwLp7f/cpqUg76vt36lbZdI33GUfKxvyN55XDY14
         ZWTO+1b518aLo7/R7EYg1H0TnV3SJWSSZldxMUl38O8Tib9lx0VBAGA80DPMf3mFdE
         QjpnN278dKFIaVcnNv773zcoYVcpmoAM6nTLJ5pR9ewUIZZ5pgpyC9zc+YyqW9SvYi
         0GVAlafnXADtQ==
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: [PATCH v2 2/3] riscv: dts: starfive: Add common DT for JH7100 based boards
Date:   Fri,  2 Sep 2022 13:08:05 +0300
Message-Id: <20220902100806.2378543-3-cristian.ciocaltea@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
References: <20220902100806.2378543-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding initial device tree support for the StarFive
VisionFive board, which is similar with BeagleV Starlight, move most
of the content from jh7100-beaglev-starlight.dts to a new file, to be
shared between the two boards.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +----------------
 .../boot/dts/starfive/jh7100-common.dtsi      | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+), 152 deletions(-)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7100-common.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
index c9af67f7a0d2..7cda3a89020a 100644
--- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
+++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
@@ -5,160 +5,9 @@
  */
 
 /dts-v1/;
-#include "jh7100.dtsi"
-#include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/leds/common.h>
-#include <dt-bindings/pinctrl/pinctrl-starfive.h>
+#include "jh7100-common.dtsi"
 
 / {
 	model = "BeagleV Starlight Beta";
 	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
-
-	aliases {
-		serial0 = &uart3;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	cpus {
-		timebase-frequency = <6250000>;
-	};
-
-	memory@80000000 {
-		device_type = "memory";
-		reg = <0x0 0x80000000 0x2 0x0>;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		led-ack {
-			gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
-			color = <LED_COLOR_ID_GREEN>;
-			function = LED_FUNCTION_HEARTBEAT;
-			linux,default-trigger = "heartbeat";
-			label = "ack";
-		};
-	};
-};
-
-&gpio {
-	i2c0_pins: i2c0-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(62, GPO_LOW,
-				  GPO_I2C0_PAD_SCK_OEN,
-				  GPI_I2C0_PAD_SCK_IN)>,
-				 <GPIOMUX(61, GPO_LOW,
-				  GPO_I2C0_PAD_SDA_OEN,
-				  GPI_I2C0_PAD_SDA_IN)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c1_pins: i2c1-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(47, GPO_LOW,
-				  GPO_I2C1_PAD_SCK_OEN,
-				  GPI_I2C1_PAD_SCK_IN)>,
-				 <GPIOMUX(48, GPO_LOW,
-				  GPO_I2C1_PAD_SDA_OEN,
-				  GPI_I2C1_PAD_SDA_IN)>;
-			bias-pull-up;
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	i2c2_pins: i2c2-0 {
-		i2c-pins {
-			pinmux = <GPIOMUX(60, GPO_LOW,
-				  GPO_I2C2_PAD_SCK_OEN,
-				  GPI_I2C2_PAD_SCK_IN)>,
-				 <GPIOMUX(59, GPO_LOW,
-				  GPO_I2C2_PAD_SDA_OEN,
-				  GPI_I2C2_PAD_SDA_IN)>;
-			bias-disable; /* external pull-up */
-			input-enable;
-			input-schmitt-enable;
-		};
-	};
-
-	uart3_pins: uart3-0 {
-		rx-pins {
-			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
-				  GPI_UART3_PAD_SIN)>;
-			bias-pull-up;
-			drive-strength = <14>;
-			input-enable;
-			input-schmitt-enable;
-			slew-rate = <0>;
-		};
-		tx-pins {
-			pinmux = <GPIOMUX(14, GPO_UART3_PAD_SOUT,
-				  GPO_ENABLE, GPI_NONE)>;
-			bias-disable;
-			drive-strength = <35>;
-			input-disable;
-			input-schmitt-disable;
-			slew-rate = <0>;
-		};
-	};
-};
-
-&i2c0 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <500>;
-	i2c-scl-falling-time-ns = <500>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c0_pins>;
-	status = "okay";
-
-	pmic@5e {
-		compatible = "ti,tps65086";
-		reg = <0x5e>;
-		gpio-controller;
-		#gpio-cells = <2>;
-
-		regulators {
-		};
-	};
-};
-
-&i2c1 {
-	clock-frequency = <400000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <100>;
-	i2c-scl-falling-time-ns = <100>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c1_pins>;
-	status = "okay";
-};
-
-&i2c2 {
-	clock-frequency = <100000>;
-	i2c-sda-hold-time-ns = <300>;
-	i2c-sda-falling-time-ns = <500>;
-	i2c-scl-falling-time-ns = <500>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&i2c2_pins>;
-	status = "okay";
-};
-
-&osc_sys {
-	clock-frequency = <25000000>;
-};
-
-&osc_aud {
-	clock-frequency = <27000000>;
-};
-
-&uart3 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart3_pins>;
-	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7100-common.dtsi b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
new file mode 100644
index 000000000000..6a66abacb612
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7100-common.dtsi
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2021 StarFive Technology Co., Ltd.
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include "jh7100.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/pinctrl-starfive.h>
+
+/ {
+	aliases {
+		serial0 = &uart3;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	cpus {
+		timebase-frequency = <6250000>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x2 0x0>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		led-ack {
+			gpios = <&gpio 43 GPIO_ACTIVE_HIGH>;
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_HEARTBEAT;
+			linux,default-trigger = "heartbeat";
+			label = "ack";
+		};
+	};
+};
+
+&gpio {
+	i2c0_pins: i2c0-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(62, GPO_LOW,
+				  GPO_I2C0_PAD_SCK_OEN,
+				  GPI_I2C0_PAD_SCK_IN)>,
+				 <GPIOMUX(61, GPO_LOW,
+				  GPO_I2C0_PAD_SDA_OEN,
+				  GPI_I2C0_PAD_SDA_IN)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c1_pins: i2c1-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(47, GPO_LOW,
+				  GPO_I2C1_PAD_SCK_OEN,
+				  GPI_I2C1_PAD_SCK_IN)>,
+				 <GPIOMUX(48, GPO_LOW,
+				  GPO_I2C1_PAD_SDA_OEN,
+				  GPI_I2C1_PAD_SDA_IN)>;
+			bias-pull-up;
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	i2c2_pins: i2c2-0 {
+		i2c-pins {
+			pinmux = <GPIOMUX(60, GPO_LOW,
+				  GPO_I2C2_PAD_SCK_OEN,
+				  GPI_I2C2_PAD_SCK_IN)>,
+				 <GPIOMUX(59, GPO_LOW,
+				  GPO_I2C2_PAD_SDA_OEN,
+				  GPI_I2C2_PAD_SDA_IN)>;
+			bias-disable; /* external pull-up */
+			input-enable;
+			input-schmitt-enable;
+		};
+	};
+
+	uart3_pins: uart3-0 {
+		rx-pins {
+			pinmux = <GPIOMUX(13, GPO_LOW, GPO_DISABLE,
+				  GPI_UART3_PAD_SIN)>;
+			bias-pull-up;
+			drive-strength = <14>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+		tx-pins {
+			pinmux = <GPIOMUX(14, GPO_UART3_PAD_SOUT,
+				  GPO_ENABLE, GPI_NONE)>;
+			bias-disable;
+			drive-strength = <35>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <500>;
+	i2c-scl-falling-time-ns = <500>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+
+	pmic@5e {
+		compatible = "ti,tps65086";
+		reg = <0x5e>;
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		regulators {
+		};
+	};
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <100>;
+	i2c-scl-falling-time-ns = <100>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock-frequency = <100000>;
+	i2c-sda-hold-time-ns = <300>;
+	i2c-sda-falling-time-ns = <500>;
+	i2c-scl-falling-time-ns = <500>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+	status = "okay";
+};
+
+&osc_sys {
+	clock-frequency = <25000000>;
+};
+
+&osc_aud {
+	clock-frequency = <27000000>;
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "okay";
+};
-- 
2.37.2

