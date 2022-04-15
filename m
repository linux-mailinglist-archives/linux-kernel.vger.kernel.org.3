Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D01502C3A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 17:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354772AbiDOPDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 11:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354771AbiDOPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 11:03:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0801AB2474
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t1so10957239wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WvgoMsFeJbLKfIyFYwF/hSsw2Ot+YCW2u9O8U5My99M=;
        b=oCABQfTIFtAdRLF4uQqOyGM+SaI8gF9tPvHvk+s9hqCsWNyknC6bcjlrJl+ejjM3HV
         EJn6UuKFo2C6Yoe4T3T2pR3g+Kr377Q+x/1IUfbByf86Gu14BM80MTQdaNmy4sDsccbs
         PYDk/DHv2GouXMVrYRmSx6a+YuDSodFmbErfFqjSzdwiswTXnF/5dvOiLuR6ao46gvdI
         f6F+DAmHyar0xtIUxHxnAVusfknw+ix9+yiiIJwCTsM/Vwbj9BYdDr4DNYWLDiWiLRzZ
         6telRdQfWiDpY/MYKw1papNIwd2BdVg1dTviYTbv79buZwHGyH/nUiJsVGvhQ0Jd2z6b
         yUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WvgoMsFeJbLKfIyFYwF/hSsw2Ot+YCW2u9O8U5My99M=;
        b=Jwm/p6RdHTZvn+uX1WYPY+89GLngwIzv6aZV4C9Jher8Kl+IQ/Cbg/M9T5E43khQY1
         l56Hxv8xBXLfNI6xyQduetfWqArmPOUZNtCbuUJtdqH3mlEHG623glFOm8UVER+bdk2U
         8loQ/9W+D9p2WaRaNyJkLnwjz5dZdHoLasZY8wlv84z1wjDJ700g0PCjo+Lj/xyxO7o6
         BpiiN89zwUQR/BA6ng+CZerF8CC0/Ea8ZId7ue/VuocJAK1luKqSEHrnTCJLyJEf6Eo9
         Pzh5F0FFNj55JNqiLoL9eNRBb3XcK3Ify1t/Mwp7B5dAVeydarmC8aGii7YfTB0COmtY
         lpOg==
X-Gm-Message-State: AOAM5305pxNbB6xtiHIYMxKKk+9lr+E7I/8A9xDzO4HJZz7L1whXnU7u
        w2HAZm5lmjYmBBh1SXzYcAhcww==
X-Google-Smtp-Source: ABdhPJybsESsODYC2KDj++u7jHKovR4dN9IMLiM818j15zfCInvGAJXx5//V2bd7bKo2cGeao79hFQ==
X-Received: by 2002:a05:6000:156f:b0:205:c541:3e8e with SMTP id 15-20020a056000156f00b00205c5413e8emr5658239wrz.581.1650034862499;
        Fri, 15 Apr 2022 08:01:02 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id n2-20020a5d6b82000000b0020a7e34ef20sm1579664wrx.47.2022.04.15.08.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 08:01:01 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] arm64: dts: mediatek: Add device-tree for MT8195 Demo board
Date:   Fri, 15 Apr 2022 17:00:01 +0200
Message-Id: <20220415150003.1793063-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220415150003.1793063-1-fparent@baylibre.com>
References: <20220415150003.1793063-1-fparent@baylibre.com>
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

Add basic device-tree for the MT8195 Demo board. The
Demo board is made by MediaTek and has a MT8195 SoC,
associated with the MT6359 and MT6360 PMICs, and
the MT7921 connectivity chip.

The IOs available on that board are:
* 1 USB Type-C connector with DP aux mode support
* 1 USB Type-A connector
* 1 full size HDMI RX and 1 full size HDMI TX connector
* 1 uSD slot
* 40 pins header
* SPI interface header
* 1 M.2 slot
* 1 audio jack
* 1 micro-USB port for serial debug
* 2 connectors for DSI displays
* 3 connectors for CSI cameras
* 1 connector for a eDP panel
* 1 MMC storage

This commit adds basic support in order to be able to boot.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
v3:
 * use plural for all pinctrl subnode names
 * reorder all nodes in alphabetical order
 * Remove invalid property for i2c6 pinctrl
 * use interrupts-extended instead of interrupts/interrupt-parent
 * rebase on top [v14,2/2] arm64: dts: Add mediatek SoC mt8195 and evaluation board
    -> https://patchwork.kernel.org/project/linux-mediatek/patch/20220411022724.11005-3-tinghan.shen@mediatek.com/

v2:
 * remove empty i2c nodes
 * remove empty spi node
 * remove unused pcie pinctrls
 * fixup node nodes to not contains underscore
 * rename mt6360 pmic node
 * move mmc1 node right after mmc0 node
 * use generic node name for gpio-keys
 * uniformize pinctrl node names

 arch/arm64/boot/dts/mediatek/Makefile        |   1 +
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 445 +++++++++++++++++++
 2 files changed, 446 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-demo.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 5da29e7223e4..c7d4636a2cb7 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -38,5 +38,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-pumpkin.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-demo.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8195-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
new file mode 100644
index 000000000000..def3fc26cb99
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 BayLibre, SAS.
+ * Author: Fabien Parent <fparent@baylibre.com>
+ */
+/dts-v1/;
+
+#include "mt8195.dtsi"
+#include "mt6359.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/pinctrl/mt8195-pinfunc.h>
+#include <dt-bindings/regulator/mediatek,mt6360-regulator.h>
+
+/ {
+	model = "MediaTek MT8195 demo board";
+	compatible = "mediatek,mt8195-demo", "mediatek,mt8195";
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	chosen {
+		stdout-path = "serial0:921600n8";
+	};
+
+	firmware {
+		optee {
+			compatible = "linaro,optee-tz";
+			method = "smc";
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		input-name = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gpio_keys_pins>;
+
+		key-0 {
+			gpios = <&pio 106 GPIO_ACTIVE_LOW>;
+			label = "volume_up";
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
+		bl31_secmon_reserved: secmon@54600000 {
+			no-map;
+			reg = <0 0x54600000 0x0 0x30000>;
+		};
+
+		/* 12 MiB reserved for OP-TEE (BL32)
+		 * +-----------------------+ 0x43e0_0000
+		 * |      SHMEM 2MiB       |
+		 * +-----------------------+ 0x43c0_0000
+		 * |        | TA_RAM  8MiB |
+		 * + TZDRAM +--------------+ 0x4340_0000
+		 * |        | TEE_RAM 2MiB |
+		 * +-----------------------+ 0x4320_0000
+		 */
+		optee_reserved: optee@43200000 {
+			no-map;
+			reg = <0 0x43200000 0 0x00c00000>;
+		};
+	};
+};
+
+&i2c6 {
+	clock-frequency = <400000>;
+	pinctrl-0 = <&i2c6_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	mt6360: pmic@34 {
+		compatible = "mediatek,mt6360";
+		reg = <0x34>;
+		interrupt-controller;
+		interrupts-extended = <&pio 101 IRQ_TYPE_EDGE_FALLING>;
+		interrupt-names = "IRQB";
+
+		charger {
+			compatible = "mediatek,mt6360-chg";
+			richtek,vinovp-microvolt = <14500000>;
+
+			otg_vbus_regulator: usb-otg-vbus-regulator {
+				regulator-compatible = "usb-otg-vbus";
+				regulator-name = "usb-otg-vbus";
+				regulator-min-microvolt = <4425000>;
+				regulator-max-microvolt = <5825000>;
+			};
+		};
+
+		regulator {
+			compatible = "mediatek,mt6360-regulator";
+			LDO_VIN3-supply = <&mt6360_buck2>;
+
+			mt6360_buck1: buck1 {
+				regulator-compatible = "BUCK1";
+				regulator-name = "mt6360,buck1";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_buck2: buck2 {
+				regulator-compatible = "BUCK2";
+				regulator-name = "mt6360,buck2";
+				regulator-min-microvolt = <300000>;
+				regulator-max-microvolt = <1300000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP
+							   MT6360_OPMODE_ULP>;
+				regulator-always-on;
+			};
+
+			mt6360_ldo1: ldo1 {
+				regulator-compatible = "LDO1";
+				regulator-name = "mt6360,ldo1";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo2: ldo2 {
+				regulator-compatible = "LDO2";
+				regulator-name = "mt6360,ldo2";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo3: ldo3 {
+				regulator-compatible = "LDO3";
+				regulator-name = "mt6360,ldo3";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo5: ldo5 {
+				regulator-compatible = "LDO5";
+				regulator-name = "mt6360,ldo5";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3600000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo6: ldo6 {
+				regulator-compatible = "LDO6";
+				regulator-name = "mt6360,ldo6";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+			};
+
+			mt6360_ldo7: ldo7 {
+				regulator-compatible = "LDO7";
+				regulator-name = "mt6360,ldo7";
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <2100000>;
+				regulator-allowed-modes = <MT6360_OPMODE_NORMAL
+							   MT6360_OPMODE_LP>;
+				regulator-always-on;
+			};
+		};
+	};
+};
+
+&mmc0 {
+	status = "okay";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_default_pins>;
+	pinctrl-1 = <&mmc0_uhs_pins>;
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	cap-mmc-highspeed;
+	mmc-hs200-1_8v;
+	mmc-hs400-1_8v;
+	cap-mmc-hw-reset;
+	no-sdio;
+	no-sd;
+	hs400-ds-delay = <0x14c11>;
+	vmmc-supply = <&mt6359_vemc_1_ldo_reg>;
+	vqmmc-supply = <&mt6359_vufs_ldo_reg>;
+	non-removable;
+};
+
+&mmc1 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_default_pins>;
+	pinctrl-1 = <&mmc1_uhs_pins>;
+	cd-gpios = <&pio 129 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	max-frequency = <200000000>;
+	cap-sd-highspeed;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	vmmc-supply = <&mt6360_ldo5>;
+	vqmmc-supply = <&mt6360_ldo3>;
+	status = "okay";
+};
+
+&mt6359_vbbck_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vcore_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vgpu11_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vproc1_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vproc2_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vpu_buck_reg {
+	regulator-always-on;
+};
+
+&mt6359_vrf12_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_md_ldo_reg {
+	regulator-always-on;
+};
+
+&mt6359_vsram_others_ldo_reg {
+	regulator-always-on;
+};
+
+&pio {
+	gpio_keys_pins: gpio-keys-pins {
+		pins {
+			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
+			input-enable;
+		};
+	};
+
+	i2c6_pins: i2c6-pins {
+		pins {
+			pinmux = <PINMUX_GPIO25__FUNC_SDA6>,
+				 <PINMUX_GPIO26__FUNC_SCL6>;
+			bias-pull-up;
+		};
+	};
+
+	mmc0_default_pins: mmc0-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_6mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc0_uhs_pins: mmc0-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO122__FUNC_MSDC0_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO126__FUNC_MSDC0_DAT0>,
+				 <PINMUX_GPIO125__FUNC_MSDC0_DAT1>,
+				 <PINMUX_GPIO124__FUNC_MSDC0_DAT2>,
+				 <PINMUX_GPIO123__FUNC_MSDC0_DAT3>,
+				 <PINMUX_GPIO119__FUNC_MSDC0_DAT4>,
+				 <PINMUX_GPIO118__FUNC_MSDC0_DAT5>,
+				 <PINMUX_GPIO117__FUNC_MSDC0_DAT6>,
+				 <PINMUX_GPIO116__FUNC_MSDC0_DAT7>,
+				 <PINMUX_GPIO121__FUNC_MSDC0_CMD>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-ds {
+			pinmux = <PINMUX_GPIO127__FUNC_MSDC0_DSL>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-rst {
+			pinmux = <PINMUX_GPIO120__FUNC_MSDC0_RSTB>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	mmc1_default_pins: mmc1-default-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+
+		pins-insert {
+			pinmux = <PINMUX_GPIO129__FUNC_GPIO129>;
+			bias-pull-up;
+		};
+	};
+
+	mmc1_uhs_pins: mmc1-uhs-pins {
+		pins-clk {
+			pinmux = <PINMUX_GPIO111__FUNC_MSDC1_CLK>;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
+		};
+
+		pins-cmd-dat {
+			pinmux = <PINMUX_GPIO110__FUNC_MSDC1_CMD>,
+				 <PINMUX_GPIO112__FUNC_MSDC1_DAT0>,
+				 <PINMUX_GPIO113__FUNC_MSDC1_DAT1>,
+				 <PINMUX_GPIO114__FUNC_MSDC1_DAT2>,
+				 <PINMUX_GPIO115__FUNC_MSDC1_DAT3>;
+			input-enable;
+			drive-strength = <MTK_DRIVE_8mA>;
+			bias-pull-up = <MTK_PUPD_SET_R1R0_01>;
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		pins {
+			pinmux = <PINMUX_GPIO98__FUNC_UTXD0>,
+				 <PINMUX_GPIO99__FUNC_URXD0>;
+		};
+	};
+
+	uart1_pins: uart1-pins {
+		pins {
+			pinmux = <PINMUX_GPIO102__FUNC_UTXD1>,
+				 <PINMUX_GPIO103__FUNC_URXD1>;
+		};
+	};
+};
+
+
+&pmic {
+	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins>;
+	status = "okay";
+};
+
+&u3phy0 {
+	status = "okay";
+};
+
+&u3phy1 {
+	status = "okay";
+};
+
+&u3phy2 {
+	status = "okay";
+};
+
+&u3phy3 {
+	status = "okay";
+};
+
+&xhci0 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	vbus-supply = <&otg_vbus_regulator>;
+	status = "okay";
+};
+
+&xhci1 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&xhci2 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
+
+&xhci3 {
+	vusb33-supply = <&mt6359_vusb_ldo_reg>;
+	status = "okay";
+};
-- 
2.35.2

