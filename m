Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B18F524D77
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354001AbiELMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353992AbiELMtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:49:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE4724EA01
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p4so6177485edx.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfLuO2bBXhL8oa/UMAFdd0jhsQRQifT6C/f2wEkgFLI=;
        b=L43YhiT2wsBXxUHAxiZR9VWAQvCAeHpaUgjMTb6U5Db8tgM2a38PNFVnS70l4s3DAy
         R3EkQ0J3DJluXGw9ruQioOZMC/+OJDwGpBhvp7KgOSzVAhhxgZAoYr6et6ubMyeqAGQ/
         CGc2XDtFYLChCj+GtxOQhWyNVN6yO3NDr8iNekfPJfehYE4Jl01+foZkXPtrtVJzSuvE
         IZbW0vySmy+WFpvGZnJc2EJ3CDRi0O7rVWI0lu4NoQ4ZLw80LGkwAMGB30L3gCfGMhE6
         4mGpu6rtZTyu1bE9gVu4TbFrTp4TUn6HaCyadxPSdkFJg4EgdtYjk9bdE+38UvTGd+4u
         H4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfLuO2bBXhL8oa/UMAFdd0jhsQRQifT6C/f2wEkgFLI=;
        b=5KpVgp5GpktGCRDTTI/k58wAu8/oDG5XZfDxRRklbTMoYiOnYS+heRiJ98tNpbAguF
         cE5NCwC62yztZZRyswqqZY2ZAx0tzUAe09nxMvbHejUmfjJFaydSJlNIQxfKCTfu+AaU
         YD9CYDIA5sWDno7XgN1bsDmY3jNh3DbULASKwcdvzN+85LABSZb3BRT8xVmVN3Sfyql7
         dWwZpjieOpxgIlRWHumcpX7bTkMSKCj1ZMKuyFmvP8vQJBpARN7iXXjgcr0pgQvC9uo9
         Ri49D3UJQWSt/ceXHugukSrVVGNuRXRW7yFfc0O52h4Cf9MMweWus7WoIvkbtvHBsRZ+
         Xb8Q==
X-Gm-Message-State: AOAM5310eSu+d+zbJB6S+gYi8c5udqZgd/SBn0ak11NGsJca/Cne20R7
        TmZ1m6tlK4Kb8Dcxqp6rq+0AKcUtHB0267C+
X-Google-Smtp-Source: ABdhPJwHuUuqTGyN20MxxMY43Cid9m9kP329LRVhLvlYj8nAMgSSRHntaU8KjZcz1GDv3NO02jwM9Q==
X-Received: by 2002:a05:6402:3456:b0:425:ab60:1b00 with SMTP id l22-20020a056402345600b00425ab601b00mr35301778edc.71.1652359764826;
        Thu, 12 May 2022 05:49:24 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-58.xnet.hr. [88.207.98.58])
        by smtp.googlemail.com with ESMTPSA id h3-20020a170906828300b006f3ef214dc2sm2109475ejx.40.2022.05.12.05.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:49:24 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v3 09/11] arm64: dts: marvell: split Methode uDPU DTS
Date:   Thu, 12 May 2022 14:49:03 +0200
Message-Id: <20220512124905.49979-9-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220512124905.49979-1-robert.marko@sartura.hr>
References: <20220512124905.49979-1-robert.marko@sartura.hr>
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

Split the Methode uDPU DTS into a common DTSI as preparation for adding
support for Methode eDPU which is based on the uDPU to avoid duplication.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 150 +---------------
 .../boot/dts/marvell/armada-3720-uDPU.dtsi    | 160 ++++++++++++++++++
 2 files changed, 161 insertions(+), 149 deletions(-)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index f21a855fc608..a75734d88a4f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -1,66 +1,13 @@
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
 	compatible = "methode,udpu", "marvell,armada3720", "marvell,armada3710";
 
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
-		compatible = "gpio-leds";
-
-		led-power1 {
-			label = "udpu:green:power";
-			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
-		};
-
-		led-power2 {
-			label = "udpu:red:power";
-			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
-		};
-
-		led-network1 {
-			label = "udpu:green:network";
-			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
-		};
-
-		led-network2 {
-			label = "udpu:red:network";
-			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
-		};
-
-		led-alarm1 {
-			label = "udpu:green:alarm";
-			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
-		};
-
-		led-alarm2 {
-			label = "udpu:red:alarm";
-			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
-		};
-	};
-
 	sfp_eth0: sfp-eth0 {
 		compatible = "sff,sfp";
 		i2c-bus = <&i2c0>;
@@ -70,55 +17,6 @@ sfp_eth0: sfp-eth0 {
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
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-		spi-max-frequency = <54000000>;
-
-		partitions {
-			compatible = "fixed-partitions";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			partition@0 {
-				label = "firmware";
-				reg = <0x0 0x180000>;
-			};
-
-			partition@180000 {
-				label = "u-boot-env";
-				reg = <0x180000 0x10000>;
-			};
-		};
-	};
 };
 
 &pinctrl_nb {
@@ -126,11 +24,6 @@ i2c1_recovery_pins: i2c1-recovery-pins {
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
@@ -143,48 +36,7 @@ &i2c0 {
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
-	temp-sensor@48 {
-		compatible = "ti,tmp75c";
-		reg = <0x48>;
-	};
-
-	temp-sensor@49 {
-		compatible = "ti,tmp75c";
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
index 000000000000..3f79923376fb
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -0,0 +1,160 @@
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
+		compatible = "gpio-leds";
+
+		led-power1 {
+			label = "udpu:green:power";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+
+		led-power2 {
+			label = "udpu:red:power";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+
+		led-network1 {
+			label = "udpu:green:network";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-network2 {
+			label = "udpu:red:network";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-alarm1 {
+			label = "udpu:green:alarm";
+			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
+		};
+
+		led-alarm2 {
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
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <54000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
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
+	temp-sensor@48 {
+		compatible = "ti,tmp75c";
+		reg = <0x48>;
+	};
+
+	temp-sensor@49 {
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
2.36.1

