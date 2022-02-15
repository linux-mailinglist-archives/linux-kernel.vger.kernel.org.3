Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAE44B73CF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241746AbiBOQk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 11:40:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240972AbiBOQkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 11:40:55 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC50EFF91;
        Tue, 15 Feb 2022 08:40:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u20so9445857lff.2;
        Tue, 15 Feb 2022 08:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aChZ9SNmkZslNBuQ9ASqYl7IFYspmQg69oTesUSlNro=;
        b=e0IXZegHffrFYosURTTrWVxL++tmES05QIIPmZi71zZR0QezqPrdDSKCNfVmzL0xJY
         zjHtRlr+YMLAOapj6P3TAmR7QPI0+xa6WgDMarEFB490CgkbvotoAXN/LFTQkZbbw8Yg
         PxCP9xyPg6e50RkEHnNelah10SrZ+QHfN69Uj+lhcYJcF4lXQy5Xw83MuGCLVeTJlK3b
         YO9KCvvj8xRvhlqlVrhksE5J+4xScUC3yXf6cyvdPd3SukGbYvG082VRwWinbXTAx8oI
         Gk7q2el1WnGSiJ0LeYW+ww06LefY3Br7Yh3c7gvfc3AhSCCcD83sbB4N9fScKSiqjppT
         4utw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aChZ9SNmkZslNBuQ9ASqYl7IFYspmQg69oTesUSlNro=;
        b=e5AzD/DzojcwHjzRnMtmMgi8lQpyMcExSSMA33Wq1D3Iy9b5m8KTeKStPQmP0pvEHk
         pg8kEp024UhWLPZuF6Pn95HAaG9EmykUlRO8SDPB3mNQBHAK8EEt2x+xWz8Xnl8RnqHu
         gimZjOCUVLzgV33AgjWKy1MSevVNsyAe7t0rIeL4j1HjFKx55E8UhnRD27sq7QDEzR6Y
         A4PJu+PJ7S9WqobrcHsiczCYfIzSGY/T68u6CHE01bV6KutuU9q43edDVHZzDewK7YLg
         YOcHu81oIgLinO2HSv+CpeQs1Bo38ifZ/JZc1Xa9NE2cOD3sn6tBCM22FTGIJ7NdnQsM
         dIbw==
X-Gm-Message-State: AOAM533F06HKWBlUqvVXURQR03Z6pnYwYt60E4zS6JhLYlhowi5AA44M
        7GF1iVc4HaS3+kVVj8EpIaecYhQMfeU76g==
X-Google-Smtp-Source: ABdhPJz5KqkoKsdtZ1NqsaEGR8ME5CViIi+yMmHzE+osKc6ehRbWF6Ff3Us9RI7lQzSFawyCyJNOLw==
X-Received: by 2002:a05:6512:39c8:: with SMTP id k8mr628616lfu.281.1644943242339;
        Tue, 15 Feb 2022 08:40:42 -0800 (PST)
Received: from WBEC678.wbe.local (xt27d8.stansat.pl. [83.243.39.216])
        by smtp.gmail.com with ESMTPSA id s1sm1127092ljd.18.2022.02.15.08.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 08:40:41 -0800 (PST)
From:   Pawel Dembicki <paweldembicki@gmail.com>
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] ARM: dts: kirkwood: Add Ctera C-200 V1 board
Date:   Tue, 15 Feb 2022 17:39:22 +0100
Message-Id: <20220215163926.894-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ctera C200 V1 is kirkwood-based 2-Bay NAS.

Hardware:
  - SoC: Marvell 88F6281-A1 ARMv5TE Processor 1.2GHz
  - Ram: 512MB (4x Nanya NT5TU128M8GE-AC)
  - NAND Flash: 256MB (Samsung 216 K9F2G08U0C)
  - Lan: 1x GBE (Marvell 88E1116R-NNC1)
  - Storage: 2x SATA HDD 3.5" Slot
  - USB: 2x USB 2.0 port
  - Console: Internal J3 connector (1: Vcc, 2: Rx, 3: Tx, 4: GND)
  - LEDs: 13x GPIO controlled
  - Buttons: 2x GPIO controlled

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
- removed 2x\n spacing issue
- removed unused pcie node
- made information about buzzer more comprehensive

 arch/arm/boot/dts/Makefile             |   1 +
 arch/arm/boot/dts/kirkwood-c200-v1.dts | 310 +++++++++++++++++++++++++
 2 files changed, 311 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-c200-v1.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 235ad559acb2..31616f6ae173 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -281,6 +281,7 @@ dtb-$(CONFIG_ARCH_KEYSTONE) += \
 dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-b3.dtb \
 	kirkwood-blackarmor-nas220.dtb \
+	kirkwood-c200-v1.dtb \
 	kirkwood-cloudbox.dtb \
 	kirkwood-d2net.dtb \
 	kirkwood-db-88f6281.dtb \
diff --git a/arch/arm/boot/dts/kirkwood-c200-v1.dts b/arch/arm/boot/dts/kirkwood-c200-v1.dts
new file mode 100644
index 000000000000..f59ff7578dfc
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-c200-v1.dts
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Ctera C200 V1 Board Description
+ * Copyright 2021-2022 Pawel Dembicki <paweldembicki@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include <dt-bindings/leds/common.h>
+
+/ {
+	model = "Ctera C200 V1";
+	compatible = "ctera,c200-v1", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+		stdout-path = &uart0;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
+	keys {
+		compatible = "gpio-keys";
+		pinctrl-0 = <&pmx_buttons>;
+		pinctrl-names = "default";
+
+		power {
+			label = "Power Button";
+			linux,code = <KEY_POWER>;
+			gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
+		};
+
+		reset {
+			label = "Reset Button";
+			linux,code = <KEY_RESTART>;
+			gpios = <&gpio1 17 GPIO_ACTIVE_LOW>;
+		};
+
+		usb1 {
+			label = "USB1 Button";
+			linux,code = <BTN_0>;
+			gpios = <&gpio0 28 GPIO_ACTIVE_LOW>;
+		};
+
+		usb2 {
+			label = "USB2 Button";
+			linux,code = <BTN_1>;
+			gpios = <&gpio0 29 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		pinctrl-0 = <&pmx_poweroff>;
+		pinctrl-names = "default";
+		gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pmx_leds>;
+		pinctrl-names = "default";
+
+		led-0 {
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio0 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-1 {
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-2 {
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio0 16 GPIO_ACTIVE_LOW>;
+		};
+
+		led-3 {
+			function = LED_FUNCTION_DISK;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
+		};
+
+		led-4 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
+		};
+
+		led-5 {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
+		};
+
+		led-6 {
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+		};
+
+		led-7 {
+			function = LED_FUNCTION_DISK_ERR;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
+		};
+
+		led-8 {
+			function = LED_FUNCTION_DISK_ERR;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-9 {
+			function = LED_FUNCTION_USB;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-10 {
+			function = LED_FUNCTION_USB;
+			function-enumerator = <1>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port2>;
+		};
+
+		led-11 {
+			function = LED_FUNCTION_USB;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-12 {
+			function = LED_FUNCTION_USB;
+			function-enumerator = <2>;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "usbport";
+			trigger-sources = <&hub_port1>;
+		};
+	};
+};
+
+&eth0 {
+	status = "okay";
+};
+
+&eth0port {
+	phy-handle = <&ethphy9>;
+};
+
+&i2c0 {
+	status = "okay";
+
+	rtc@30 {
+		compatible = "s35390a";
+		reg = <0x30>;
+	};
+
+	lm63@4c {
+		compatible = "national,lm63";
+		reg = <0x4c>;
+	};
+};
+
+&mdio {
+	status = "okay";
+
+	ethphy9: ethernet-phy@9 {
+		reg = <9>;
+	};
+};
+
+&nand {
+	status = "okay";
+	chip-delay = <40>;
+
+	partition@0 {
+		label = "uboot";
+		reg = <0x0000000 0x200000>;
+	};
+
+	partition@200000 {
+		label = "certificate";
+		reg = <0x0200000 0x100000>;
+	};
+
+	partition@300000 {
+		label = "preset_cfg";
+		reg = <0x0300000 0x100000>;
+	};
+
+	partition@400000 {
+		label = "dev_params";
+		reg = <0x0400000 0x100000>;
+	};
+
+	partition@500000 {
+		label = "active_bank";
+		reg = <0x0500000 0x0100000>;
+	};
+
+	partition@600000 {
+		label = "magic";
+		reg = <0x0600000 0x0100000>;
+	};
+
+	partition@700000 {
+		label = "bank1";
+		reg = <0x0700000 0x2800000>;
+	};
+
+	partition@2f00000 {
+		label = "bank2";
+		reg = <0x2f00000 0x2800000>;
+	};
+
+	/* 0x5700000-0x5a00000 undefined in vendor firmware */
+
+	partition@5a00000 {
+		label = "reserved";
+		reg = <0x5a00000 0x2000000>;
+	};
+
+	partition@7a00000 {
+		label = "rootfs";
+		reg = <0x7a00000 0x8600000>;
+	};
+};
+
+&pinctrl {
+	/* Buzzer gpios are connected to two pins of buzzer.
+	 * This buzzer require a modulated signal from gpio.
+	 * Leave it as is due lack of proper driver.
+	 */
+	pmx_buzzer: pmx-buzzer {
+		marvell,pins = "mpp12", "mpp13";
+		marvell,function = "gpio";
+	};
+
+	pmx_leds: pmx-leds {
+		marvell,pins = "mpp14", "mpp15", "mpp16", "mpp17", "mpp38",
+			       "mpp39", "mpp40", "mpp42", "mpp43", "mpp44",
+			       "mpp45", "mpp46", "mpp47";
+		marvell,function = "gpio";
+	};
+
+	pmx_buttons: pmx-buttons {
+		marvell,pins = "mpp28", "mpp29", "mpp48", "mpp49";
+		marvell,function = "gpio";
+	};
+
+	pmx_poweroff: pmx-poweroff {
+		marvell,pins = "mpp34";
+		marvell,function = "gpio";
+	};
+};
+
+&rtc {
+	status = "disabled";
+};
+
+&sata {
+	status = "okay";
+	nr-ports = <2>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&usb0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	port@1 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <1>;
+		#trigger-source-cells = <0>;
+
+		hub_port1: port@1 {
+			reg = <1>;
+			#trigger-source-cells = <0>;
+		};
+
+		hub_port2: port@2 {
+			reg = <2>;
+			#trigger-source-cells = <0>;
+		};
+	};
+};
-- 
2.25.1

