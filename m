Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2051FAB9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiEILEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiEILEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:04:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1610C25EB0
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:00:38 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id m20so26021854ejj.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 04:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9C/dOs+COLporee6Egh1ahx65haWLbpcqSzk8GrRKY=;
        b=iH5TErsDifUOIuQcIKUmXt37hX972ny5G1Q1A5T57sV8QY/1wn38qyb2PwE/VJxQCu
         t+5vxfCUNm7vRWcJRdRlT/RphIQsW09fx+O17RSfw0IiK5mSGgqYW6YtekZfGQ/WPq84
         VAxSXfHCORAcU0sJKRoLmSR9wPOZVzoFeo7/dtZJZpdZjMyezBo8AE0Zb8lKI5llgZiO
         DE7z7c1h7DfCNaP8/2heK+3BOWlkMBCgMd5SucJMe5n5lByVzLaRoSBbWjfLdN03CTOv
         lUydmpssZ4XoOfWwmREi0bo0HNxFLkH0DdqoU8elOimpm3Ey43Rhfb1it7BweWJ7JQND
         drKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9C/dOs+COLporee6Egh1ahx65haWLbpcqSzk8GrRKY=;
        b=F1PmSP3h1jQCHfrpRkKouLPD1zeIutwm2GIrcEuB20l81343FGGDrUpq4Wi0zkRJep
         3cL6xLoLE/d6whe9xfBcZybiMHtE8O6PdxQXtS3afc5VYDzntO5jdym97b9yUwx7+8Bt
         fi0WVz69wCAZ9sVYYcBvSUaKN1o2sNDaYHq4K+HAUpI9qnwl8rVltk5FOkmdrRyxxyY3
         ChZeuCxLUB2YSkd39CGC6F4iie6sf0tnLqcWQnEuP7ScPMcpjVNLfwwAYCxhLMZc2bdo
         3R0D2sG9aHoKJjrvZp06VvVNUgKiT+zTdSrZ/gq3+UOAUTSxSI92FZykb4Kr7njaDmIE
         ImAg==
X-Gm-Message-State: AOAM530VSuEiNm5YqXtsjLN2H1xNQiCnkBxHq1te2t63wGoS0QbScSne
        EgivvGSH5gJ+vKPzj+1H+xIiYQ==
X-Google-Smtp-Source: ABdhPJza++Loo4dFcU6TUoRfB7Pf+eTPDr8GrjTW2XkhQo/47G11FQS0KoBnVF2y+nX3nqV3ZCEX4Q==
X-Received: by 2002:a17:907:62a6:b0:6ef:8118:d3e2 with SMTP id nd38-20020a17090762a600b006ef8118d3e2mr13713700ejc.605.1652094036401;
        Mon, 09 May 2022 04:00:36 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id hw7-20020a170907a0c700b006f3ef214e73sm4963822ejc.217.2022.05.09.04.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 04:00:35 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, shawnguo@kernel.org,
        linus.walleij@linaro.org, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] arm64: dts: marvell: add support for Methode eDPU
Date:   Mon,  9 May 2022 13:00:28 +0200
Message-Id: <20220509110028.144226-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220509110028.144226-1-robert.marko@sartura.hr>
References: <20220509110028.144226-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Methode eDPU is an Armada 3720 powered board based on the Methode uDPU.

They feature the same CPU, RAM, and storage as well as the form factor.

However, eDPU only has one SFP slot plus a copper G.hn port.

In order to reduce duplication, split the uDPU DTS into a common one.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-3720-eDPU.dts     |  14 ++
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 148 +---------------
 .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 163 ++++++++++++++++++
 4 files changed, 179 insertions(+), 147 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1c794cdcb8e6..104d7d7e8215 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-eDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-emmc.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin-ultra.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
new file mode 100644
index 000000000000..6b573a6854cc
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-eDPU.dts
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include "armada-3720-uDPU.dtsi"
+
+/ {
+	model = "Methode eDPU Board";
+	compatible = "methode,edpu", "marvell,armada3720";
+};
+
+&eth0 {
+	phy-mode = "2500base-x";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 95d46e8d081c..b146fae9f60b 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -1,67 +1,13 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR MIT)
-/*
- * Device tree for the uDPU board.
- * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
- * Copyright (C) 2016 Marvell
- * Copyright (C) 2019 Methode Electronics
- * Copyright (C) 2019 Telus
- *
- * Vladimir Vid <vladimir.vid@sartura.hr>
- */
 
 /dts-v1/;
 
-#include <dt-bindings/gpio/gpio.h>
-#include "armada-372x.dtsi"
+#include "armada-3720-uDPU.dtsi"
 
 / {
 	model = "Methode uDPU Board";
 	compatible = "methode,udpu", "marvell,armada3720";
 
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory@0 {
-		device_type = "memory";
-		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
-	};
-
-	leds {
-		pinctrl-names = "default";
-		compatible = "gpio-leds";
-
-		power1 {
-			label = "udpu:green:power";
-			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
-		};
-
-		power2 {
-			label = "udpu:red:power";
-			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
-		};
-
-		network1 {
-			label = "udpu:green:network";
-			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
-		};
-
-		network2 {
-			label = "udpu:red:network";
-			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
-		};
-
-		alarm1 {
-			label = "udpu:green:alarm";
-			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
-		};
-
-		alarm2 {
-			label = "udpu:red:alarm";
-			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	sfp_eth0: sfp-eth0 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
@@ -71,50 +17,6 @@ sfp_eth0: sfp-eth0 {
 		tx-fault-gpio = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
 		maximum-power-milliwatt = <3000>;
 	};
-
-	sfp_eth1: sfp-eth1 {
-		compatible = "sff,sfp";
-		i2c-bus = <&i2c1>;
-		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
-		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
-		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
-		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
-		maximum-power-milliwatt = <3000>;
-	};
-};
-
-&sdhci0 {
-	status = "okay";
-	bus-width = <8>;
-	mmc-ddr-1_8v;
-	mmc-hs400-1_8v;
-	marvell,pad-type = "fixed-1-8v";
-	non-removable;
-	no-sd;
-	no-sdio;
-};
-
-&spi0 {
-	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_quad_pins>;
-
-	m25p80@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <54000000>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-			/* only bootloader is located on the SPI */
-			partition@0 {
-				label = "uboot";
-				reg = <0 0x400000>;
-			};
-		};
-	};
 };
 
 &pinctrl_nb {
@@ -122,11 +24,6 @@ i2c1_recovery_pins: i2c1-recovery-pins {
 		groups = "i2c1";
 		function = "gpio";
 	};
-
-	i2c2_recovery_pins: i2c2-recovery-pins {
-		groups = "i2c2";
-		function = "gpio";
-	};
 };
 
 &i2c0 {
@@ -139,50 +36,7 @@ &i2c0 {
 	sda-gpios = <&gpionb 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 };
 
-&i2c1 {
-	status = "okay";
-	pinctrl-names = "default", "recovery";
-	pinctrl-0 = <&i2c2_pins>;
-	pinctrl-1 = <&i2c2_recovery_pins>;
-	/delete-property/mrvl,i2c-fast-mode;
-	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-
-	lm75@48 {
-		status = "okay";
-		compatible = "lm75";
-		reg = <0x48>;
-	};
-
-	lm75@49 {
-		status = "okay";
-		compatible = "lm75";
-		reg = <0x49>;
-	};
-};
-
 &eth0 {
 	phy-mode = "sgmii";
-	status = "okay";
-	managed = "in-band-status";
-	phys = <&comphy1 0>;
 	sfp = <&sfp_eth0>;
 };
-
-&eth1 {
-	phy-mode = "sgmii";
-	status = "okay";
-	managed = "in-band-status";
-	phys = <&comphy0 1>;
-	sfp = <&sfp_eth1>;
-};
-
-&usb3 {
-	status = "okay";
-	phys = <&usb2_utmi_otg_phy>;
-	phy-names = "usb2-utmi-otg-phy";
-};
-
-&uart0 {
-	status = "okay";
-};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
new file mode 100644
index 000000000000..5e38acc92a31
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree for the uDPU board.
+ * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
+ * Copyright (C) 2016 Marvell
+ * Copyright (C) 2019 Methode Electronics
+ * Copyright (C) 2019 Telus
+ *
+ * Vladimir Vid <vladimir.vid@sartura.hr>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-372x.dtsi"
+
+/ {
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+
+	leds {
+		pinctrl-names = "default";
+		compatible = "gpio-leds";
+
+		power1 {
+			label = "udpu:green:power";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+
+		power2 {
+			label = "udpu:red:power";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+
+		network1 {
+			label = "udpu:green:network";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+
+		network2 {
+			label = "udpu:red:network";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm1 {
+			label = "udpu:green:alarm";
+			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm2 {
+			label = "udpu:red:alarm";
+			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	sfp_eth1: sfp-eth1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
+		maximum-power-milliwatt = <3000>;
+	};
+};
+
+&sdhci0 {
+	status = "okay";
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
+	non-removable;
+	no-sd;
+	no-sdio;
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins>;
+
+	spi-flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* only bootloader is located on the SPI */
+			partition@0 {
+				label = "firmware";
+				reg = <0x0 0x180000>;
+			};
+
+			partition@180000 {
+				label = "u-boot-env";
+				reg = <0x180000 0x10000>;
+			};
+		};
+	};
+};
+
+&pinctrl_nb {
+	i2c2_recovery_pins: i2c2-recovery-pins {
+		groups = "i2c2";
+		function = "gpio";
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default", "recovery";
+	pinctrl-0 = <&i2c2_pins>;
+	pinctrl-1 = <&i2c2_recovery_pins>;
+	/delete-property/mrvl,i2c-fast-mode;
+	scl-gpios = <&gpionb 2 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpionb 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+
+	nct375@48 {
+		status = "okay";
+		compatible = "ti,tmp75c";
+		reg = <0x48>;
+	};
+
+	nct375@49 {
+		status = "okay";
+		compatible = "ti,tmp75c";
+		reg = <0x49>;
+	};
+};
+
+&eth0 {
+	status = "okay";
+	managed = "in-band-status";
+	phys = <&comphy1 0>;
+};
+
+&eth1 {
+	phy-mode = "sgmii";
+	status = "okay";
+	managed = "in-band-status";
+	phys = <&comphy0 1>;
+	sfp = <&sfp_eth1>;
+};
+
+&usb3 {
+	status = "okay";
+	phys = <&usb2_utmi_otg_phy>;
+	phy-names = "usb2-utmi-otg-phy";
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.36.0

