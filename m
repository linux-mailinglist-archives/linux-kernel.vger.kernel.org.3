Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662BE512207
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbiD0TGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbiD0TGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:06:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9479FB82E0;
        Wed, 27 Apr 2022 11:53:16 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 8FC1F1F44C87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651085595;
        bh=fdts8xdjxfo/HcbM44f5ebcxxEsRi/kQO4JxLimk5MU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WHTzTckzb4FP/l5onILZN2cxytJo1alLFMat4NiWCXoxs+i1auVeeB+EolxMFdOPe
         lUxjpJJ8QlZD2SFs1Qok4yTQl8RM6+Jz6/LOUA3GJ2/811ap1Hiym7cKbInp+9xMwW
         UC48EOwI/GsLeBhVuTrqcGFE2LErd5Eat4P1laUifBf2fL2ZOnZecnOu8Jds9EoesQ
         CoBGkMqoHoH4A0EKf69SMwjPrjdS3Ln0uQ3gbbJ5/Y42Vmf0iaWjrYnTchA2sM+9wP
         5/1lOPL4djWe1L5ucHlJ35yPXtF1PPkjtoxZ69tDPIKCugSqB0l6s2mRDmRw34lhCm
         +tkFIOmBD/eTw==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, bcm-kernel-feedback-list@broadcom.com,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, ndesaulniers@google.com,
        nsaenz@kernel.org, olof@lixom.net, rjui@broadcom.com,
        robh+dt@kernel.org, sbranden@broadcom.com, soc@kernel.org,
        stefan.wahren@i2se.com,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [RFC PATCH v2 3/3] ARM: dto: Add bcm2711-rpi-7-inches-ts.dts overlay
Date:   Wed, 27 Apr 2022 14:52:43 -0400
Message-Id: <20220427185243.173594-4-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427185243.173594-1-detlev.casanova@collabora.com>
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device tree overlay to support the official Raspberrypi 7" touchscreen for
the bcm2711 devices.

The panel is connected on the DSI 1 port and uses the simple-panel
driver.

The device tree also makes sure to activate the pixelvalve[0-4] CRTC modules

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 arch/arm/boot/dts/Makefile                    |   4 +
 arch/arm/boot/dts/overlays/Makefile           |   3 +
 .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/Makefile         |   4 +
 .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
 .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
 6 files changed, 141 insertions(+)
 create mode 100644 arch/arm/boot/dts/overlays/Makefile
 create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
 create mode 100644 arch/arm64/boot/dts/broadcom/overlays/Makefile
 create mode 100644 arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 235ad559acb2..eb0b0b121947 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1549,3 +1549,7 @@ dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-bmc-vegman-n110.dtb \
 	aspeed-bmc-vegman-rx20.dtb \
 	aspeed-bmc-vegman-sx20.dtb
+
+ifeq ($(CONFIG_OF_OVERLAY),y)
+subdir-y	+= overlays
+endif
diff --git a/arch/arm/boot/dts/overlays/Makefile b/arch/arm/boot/dts/overlays/Makefile
new file mode 100644
index 000000000000..c90883dfaf91
--- /dev/null
+++ b/arch/arm/boot/dts/overlays/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-7-inches-ts.dtbo
diff --git a/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts b/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
new file mode 100644
index 000000000000..de98a6c1079a
--- /dev/null
+++ b/arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	#address-cells = <2>;
+	#size-cells = <1>;
+
+	panel_disp1: panel@0 {
+		reg = <0 0 0>;
+		compatible = "raspberrypi,7inch-dsi", "simple-panel";
+		backlight = <&reg_display>;
+		power-supply = <&reg_display>;
+		status = "okay";
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&bridge_out>;
+			};
+		};
+	};
+
+	reg_bridge: regulator@0 {
+		reg = <0 0 0>;
+		compatible = "regulator-fixed";
+		regulator-name = "bridge_reg";
+		gpio = <&reg_display 0 0>;
+		vin-supply = <&reg_display>;
+		enable-active-high;
+		status = "okay";
+	};
+};
+
+&i2c_csi_dsi {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ft5406: touchscreen@38 {
+		compatible = "edt,edt-ft5506";
+		reg = <0x38>;
+		status = "okay";
+
+		vcc-supply = <&reg_display>;
+		reset-gpio = <&reg_display 1 1>;
+
+		touchscreen-size-x = < 800 >;
+		touchscreen-size-y = < 480 >;
+
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	reg_display: regulator@45 {
+		compatible = "raspberrypi,7inch-touchscreen-panel-regulator";
+		reg = <0x45>;
+		status = "okay";
+
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+};
+
+&dsi1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	status = "okay";
+
+	port {
+		dsi_out: endpoint {
+			remote-endpoint = <&bridge_in>;
+		};
+	};
+
+	bridge@0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reg = <0>;
+		compatible = "toshiba,tc358762";
+
+		vddc-supply = <&reg_bridge>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in: endpoint {
+					remote-endpoint = <&dsi_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out: endpoint {
+					remote-endpoint = <&panel_in>;
+				};
+			};
+		};
+	};
+};
+
+&pixelvalve0 {
+	status = "okay";
+};
+
+&pixelvalve1 {
+	status = "okay";
+};
+
+&pixelvalve2 {
+	status = "okay";
+};
+
+&pixelvalve3 {
+	status = "okay";
+};
+
+&pixelvalve4 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
index c6882032a428..a6c43c5b053a 100644
--- a/arch/arm64/boot/dts/broadcom/Makefile
+++ b/arch/arm64/boot/dts/broadcom/Makefile
@@ -7,6 +7,10 @@ dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-400.dtb \
 			      bcm2837-rpi-3-b-plus.dtb \
 			      bcm2837-rpi-cm3-io3.dtb
 
+ifeq ($(CONFIG_OF_OVERLAY),y)
+subdir-y	+= overlays
+endif
+
 subdir-y	+= bcm4908
 subdir-y	+= northstar2
 subdir-y	+= stingray
diff --git a/arch/arm64/boot/dts/broadcom/overlays/Makefile b/arch/arm64/boot/dts/broadcom/overlays/Makefile
new file mode 100644
index 000000000000..c90883dfaf91
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/overlays/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+dtb-$(CONFIG_ARCH_BCM2835) += bcm2711-rpi-7-inches-ts.dtbo
diff --git a/arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts b/arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts
new file mode 100644
index 000000000000..7d532b090305
--- /dev/null
+++ b/arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts
@@ -0,0 +1,2 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "arm/overlays/bcm2711-rpi-7-inches-ts.dts"
-- 
2.36.0

