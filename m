Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9CF465547
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352320AbhLAS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:26:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352287AbhLASY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:24:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCF7BC061574;
        Wed,  1 Dec 2021 10:21:34 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so1836236wmb.0;
        Wed, 01 Dec 2021 10:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/WroRDb6MKbU3FJ1ZPL1YT3ab/zhWwGmxwsKBVpS1gQ=;
        b=OTA+O1L8HGjFyFIkQKV2eq3XXXqY7kF0fcV4OyiemDwmnUQShEj9JcVUM8DriCqnX1
         Ui9dA/zsbD/HiawuakujXnKFAx27S/thf2VNZvHI4i7dNL5kR185LV3znlqDu5J8rmci
         qm5Aj2vk2EE/dQBc0g/izHziNk0H8RdD8wNyQDpJqwXDhYc0n2UV2SdsBqyt//UxpszO
         e4zeloWjrYK+HX5Yc75IC1aRKIpPQOqegWzTdIVUc4k2XcKHqWuA53jheVY1wKHVrGKn
         QCpmQwLcK6EyH30WauQVNmsc8VV2H69AXSvLMB+1uq4kDIu8udjSRTcLMDcGzLc4u17S
         rNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/WroRDb6MKbU3FJ1ZPL1YT3ab/zhWwGmxwsKBVpS1gQ=;
        b=c6XlbiHDS/XBUTNPHvxh6tCDdBdCz1bnCErIR7dG1JM1NzG9YlsxKvIDUQb4j7zg1m
         C1eORJEckOOUL0ClsjpWCr/lfPktlXS+samjRKzoPNdHGkNQ0NZbEXdRfkhqlLlgVjoT
         O0G/91m8j9sR5w0DVQPVTZmTBq9FSQ6tFlpqWjki3R/Kw/JazVNuLJ8rgmzw4KOHOEpn
         V6GAGgT5+g6RYa9N4/Am4EvAQbzJ5whXei/ptlEcQ4pyGRq11PV5Orbw01l4BrJK6Hnq
         pcPxmCtyhvJ9WjkdnHjThslJ2lBwC5scwbonNU61cRji5NL/W6YYu3G7JS/CjBlvGOiP
         JNcQ==
X-Gm-Message-State: AOAM533GXuilygas4UP3uuSlaHEmRmtrIwr4yCrUyC55MbbBEvXP7Qm4
        bAIeJtp/mIQFIwzapYH1M4Q=
X-Google-Smtp-Source: ABdhPJwTH9ldu2VWmwBL0F1m67vb3qWTMSTnJR60+cKgyN6x6ibinctgSAlRKsZsdNCHwiYvP/uoeg==
X-Received: by 2002:a05:600c:4e45:: with SMTP id e5mr9155796wmq.43.1638382893333;
        Wed, 01 Dec 2021 10:21:33 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id f7sm604705wri.74.2021.12.01.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 10:21:33 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/5] arm64: dts: allwinner: h6: tanix-tx6: Split to DT and DTSI
Date:   Wed,  1 Dec 2021 19:21:14 +0100
Message-Id: <20211201182118.1213806-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
References: <20211201182118.1213806-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is another very similar device to Tanix TX6, namely Tanix TX6
mini. Because most of the board design is shared, it makes sense to have
common nodes in DTSI file.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 164 +----------------
 .../boot/dts/allwinner/sun50i-h6-tanix.dtsi   | 173 ++++++++++++++++++
 2 files changed, 174 insertions(+), 163 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 7c37aa4c60cb..a6e69f4b2666 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -3,175 +3,13 @@
 
 /dts-v1/;
 
-#include "sun50i-h6.dtsi"
-#include "sun50i-h6-cpu-opp.dtsi"
-
-#include <dt-bindings/gpio/gpio.h>
+#include "sun50i-h6-tanix.dtsi"
 
 / {
 	model = "Tanix TX6";
 	compatible = "oranth,tanix-tx6", "allwinner,sun50i-h6";
-
-	aliases {
-		serial0 = &uart0;
-	};
-
-	chosen {
-		stdout-path = "serial0:115200n8";
-	};
-
-	connector {
-		compatible = "hdmi-connector";
-		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
-		type = "a";
-
-		port {
-			hdmi_con_in: endpoint {
-				remote-endpoint = <&hdmi_out_con>;
-			};
-		};
-	};
-
-	/* used for FD650 LED display driver */
-	i2c {
-		compatible = "i2c-gpio";
-		sda-gpios = <&pio 7 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH6 */
-		scl-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH5 */
-		i2c-gpio,delay-us = <5>;
-	};
-
-	reg_vcc1v8: regulator-vcc1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc1v8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
-	reg_vcc3v3: regulator-vcc3v3 {
-		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-	};
-
-	reg_vdd_cpu_gpu: regulator-vdd-cpu-gpu {
-		compatible = "regulator-fixed";
-		regulator-name = "vdd-cpu-gpu";
-		regulator-min-microvolt = <1135000>;
-		regulator-max-microvolt = <1135000>;
-	};
-
-	sound-spdif {
-		compatible = "simple-audio-card";
-		simple-audio-card,name = "sun50i-h6-spdif";
-
-		simple-audio-card,cpu {
-			sound-dai = <&spdif>;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&spdif_out>;
-		};
-	};
-
-	spdif_out: spdif-out {
-		#sound-dai-cells = <0>;
-		compatible = "linux,spdif-dit";
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_vdd_cpu_gpu>;
-};
-
-&de {
-	status = "okay";
-};
-
-&dwc3 {
-	status = "okay";
-};
-
-&ehci0 {
-	status = "okay";
-};
-
-&ehci3 {
-	status = "okay";
-};
-
-&gpu {
-	mali-supply = <&reg_vdd_cpu_gpu>;
-	status = "okay";
-};
-
-&hdmi {
-	status = "okay";
-};
-
-&hdmi_out {
-	hdmi_out_con: endpoint {
-		remote-endpoint = <&hdmi_con_in>;
-	};
-};
-
-&mmc0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&reg_vcc3v3>;
-	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-	bus-width = <4>;
-	status = "okay";
-};
-
-&mmc2 {
-	vmmc-supply = <&reg_vcc3v3>;
-	vqmmc-supply = <&reg_vcc1v8>;
-	bus-width = <8>;
-	non-removable;
-	cap-mmc-hw-reset;
-	mmc-hs200-1_8v;
-	status = "okay";
-};
-
-&ohci0 {
-	status = "okay";
-};
-
-&ohci3 {
-	status = "okay";
-};
-
-&pio {
-	vcc-pc-supply = <&reg_vcc1v8>;
-	vcc-pd-supply = <&reg_vcc3v3>;
-	vcc-pg-supply = <&reg_vcc1v8>;
 };
 
 &r_ir {
 	linux,rc-map-name = "rc-tanix-tx5max";
-	status = "okay";
-};
-
-&spdif {
-	status = "okay";
-};
-
-&uart0 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&uart0_ph_pins>;
-	status = "okay";
-};
-
-&usb2otg {
-	dr_mode = "host";
-	status = "okay";
-};
-
-&usb2phy {
-	status = "okay";
-};
-
-&usb3phy {
-	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
new file mode 100644
index 000000000000..166b6a7a586c
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix.dtsi
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+// Copyright (c) 2019 Jernej Skrabec <jernej.skrabec@siol.net>
+
+/dts-v1/;
+
+#include "sun50i-h6.dtsi"
+#include "sun50i-h6-cpu-opp.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	connector {
+		compatible = "hdmi-connector";
+		ddc-en-gpios = <&pio 7 2 GPIO_ACTIVE_HIGH>; /* PH2 */
+		type = "a";
+
+		port {
+			hdmi_con_in: endpoint {
+				remote-endpoint = <&hdmi_out_con>;
+			};
+		};
+	};
+
+	/* used for FD650 LED display driver */
+	i2c {
+		compatible = "i2c-gpio";
+		sda-gpios = <&pio 7 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH6 */
+		scl-gpios = <&pio 7 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>; /* PH5 */
+		i2c-gpio,delay-us = <5>;
+	};
+
+	reg_vcc1v8: regulator-vcc1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	reg_vcc3v3: regulator-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vdd_cpu_gpu: regulator-vdd-cpu-gpu {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpu-gpu";
+		regulator-min-microvolt = <1135000>;
+		regulator-max-microvolt = <1135000>;
+	};
+
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-h6-spdif";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpu_gpu>;
+};
+
+&de {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
+&ehci0 {
+	status = "okay";
+};
+
+&ehci3 {
+	status = "okay";
+};
+
+&gpu {
+	mali-supply = <&reg_vdd_cpu_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	status = "okay";
+};
+
+&hdmi_out {
+	hdmi_out_con: endpoint {
+		remote-endpoint = <&hdmi_con_in>;
+	};
+};
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&mmc2 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc1v8>;
+	bus-width = <8>;
+	non-removable;
+	cap-mmc-hw-reset;
+	mmc-hs200-1_8v;
+	status = "okay";
+};
+
+&ohci0 {
+	status = "okay";
+};
+
+&ohci3 {
+	status = "okay";
+};
+
+&pio {
+	vcc-pc-supply = <&reg_vcc1v8>;
+	vcc-pd-supply = <&reg_vcc3v3>;
+	vcc-pg-supply = <&reg_vcc1v8>;
+};
+
+&r_ir {
+	status = "okay";
+};
+
+&spdif {
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_ph_pins>;
+	status = "okay";
+};
+
+&usb2otg {
+	dr_mode = "host";
+	status = "okay";
+};
+
+&usb2phy {
+	status = "okay";
+};
+
+&usb3phy {
+	status = "okay";
+};
-- 
2.34.1

