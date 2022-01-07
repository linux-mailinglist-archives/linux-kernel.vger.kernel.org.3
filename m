Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D4D4870D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345609AbiAGDBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:01:14 -0500
Received: from vps5.brixit.nl ([192.81.221.234]:38744 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345500AbiAGDBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:01:13 -0500
Received: from lexxgentoo.local (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id 10F3C61A22;
        Fri,  7 Jan 2022 03:01:10 +0000 (UTC)
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH] arm64: dts: qcom: Initial Xiaomi Mi 9 support (cepheus)
Date:   Fri,  7 Jan 2022 05:59:10 +0300
Message-Id: <20220107025910.112425-1-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial support for Xiaomi Mi 9 smartphone, based on
Qualcomm SM8150 (Snapdragon 855) chipset.

Currently the following features are supported:
 * reserved-memory map
 * debug UART
 * display using simple-framebuffer
 * physical keys: power, volume up/down, AI key
 * reboot modes
 * regulator voltages
 * USB peripheral mode

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/sm8150-xiaomi-cepheus.dts   | 575 ++++++++++++++++++
 2 files changed, 576 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..078c0d13ae8e 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -101,6 +101,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-microsoft-surface-duo.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-bahamut.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-sony-xperia-kumano-griffin.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8150-xiaomi-cepheus.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
new file mode 100644
index 000000000000..2c768a6d51ca
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
@@ -0,0 +1,575 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Alexey Minnekhanov <alexeymin@postmarketos.org>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/gpio-keys.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include "sm8150.dtsi"
+#include "pm8150.dtsi"
+#include "pm8150b.dtsi"
+#include "pm8150l.dtsi"
+
+/*
+ * Rewrite reserved memory maps inherited from sm8150.dtsi to match the ones
+ * used on xiaomi-cepheus.
+ * Note: this list is ordered by its memory address in sm8150.dtsi.
+ */
+/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
+/delete-node/ &rmtfs_mem;   /* moved to completely different address */
+/delete-node/ &adsp_mem;    /* same start address, but larger size */
+/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
+/delete-node/ &venus_mem;   /* same size, shifted higher */
+/delete-node/ &slpi_mem;    /* same size, shifted higher */
+/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
+/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
+/delete-node/ &gpu_mem;     /* same size, shifted higher */
+/delete-node/ &spss_mem;    /* same size, shifted higher */
+/delete-node/ &cdsp_mem;    /* same size, shifted higher */
+
+/ {
+	model = "Xiaomi Mi 9";
+	compatible = "xiaomi,cepheus", "qcom,sm8150";
+
+	aliases {
+		serial0 = &uart2;
+		display0 = &framebuffer;
+	};
+
+	chosen {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		stdout-path = "serial0:115200n8";
+
+		framebuffer: framebuffer@9c000000 {
+			compatible = "simple-framebuffer";
+			reg = <0 0x9c000000 0 0x2300000>;
+			width = <1080>;
+			height = <2340>;
+			stride = <(1080 * 4)>;
+			format = "a8r8g8b8";
+			/*
+			 * That's (going to be) a lot of clocks, but it's necessary due
+			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
+			 */
+			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
+				 <&gcc GCC_DISP_SF_AXI_CLK>;
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		pinctrl-names = "default";
+		pinctrl-0 = <&ai_key_pin_a &vol_up_pin_a>;
+
+		vol_up {
+			label = "volume_up";
+			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_VOLUMEUP>;
+			wakeup-source;
+			debounce-interval = <15>;
+		};
+
+		ai_key {
+			label = "ai_key";
+			gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_KEY>;
+			linux,code = <KEY_HOMEPAGE>; /* no AI key in Linux */
+			wakeup-source;
+			debounce-interval = <39>;
+		};
+	};
+
+	reserved-memory {
+		tz_mem: memory@86200000 {
+			no-map;
+			reg = <0x0 0x86200000 0x0 0x5500000>;
+			phandle = <0x594>;
+		};
+
+		adsp_mem: memory@8be00000 {
+			no-map;
+			reg = <0x0 0x8be00000 0x0 0x2200000>;
+		};
+
+		mpss_mem: memory@8e000000 {
+			no-map;
+			reg = <0x0 0x8e000000 0x0 0x9600000>;
+		};
+
+		venus_mem: memory@97600000 {
+			no-map;
+			reg = <0x0 0x97600000 0x0 0x500000>;
+		};
+
+		slpi_mem: memory@97b00000 {
+			no-map;
+			reg = <0x0 0x97b00000 0x0 0x1400000>;
+		};
+
+		ipa_fw_mem: memory@98f00000 {
+			no-map;
+			reg = <0x0 0x98f00000 0x0 0x10000>;
+		};
+
+		ipa_gsi_mem: memory@98f10000 {
+			no-map;
+			reg = <0x0 0x98f10000 0x0 0x5000>;
+		};
+
+		gpu_mem: memory@98f15000 {
+			no-map;
+			reg = <0x0 0x98f15000 0x0 0x2000>;
+		};
+
+		spss_mem: memory@99000000 {
+			no-map;
+			reg = <0x0 0x99000000 0x0 0x100000>;
+		};
+
+		cdsp_mem: memory@99100000 {
+			no-map;
+			reg = <0x0 0x99100000 0x0 0x1400000>;
+		};
+
+		cont_splash_mem: memory@9c000000 {
+			reg = <0x0 0x9c000000 0x0 0x2400000>;
+			no-map;
+		};
+
+		cdsp_sec_mem: memory@a4c00000 {
+			reg = <0x0 0xa4c00000 0x0 0x3c00000>;
+			no-map;
+		};
+
+		ramoops@b0000000 {
+			compatible = "ramoops";
+			reg = <0x0 0xb0000000 0x0 0x400000>;
+			console-size = <0x200000>;
+			ecc-size = <0>;
+			ftrace-size = <0>;
+			pmsg-size = <0x200000>;
+			record-size = <0>;
+		};
+
+		/* Downstream dynamically allocates rmtfs_mem region using
+		 * dma_alloc_coherent and adds 4k guard pages before and after
+		 * it to workaround some "XPU limitation". */
+		/* rmtfs_lower_guard */
+		memory@f4100000 {
+			no-map;
+			reg = <0x0 0xf4100000 0x0 0x1000>;
+		};
+
+		rmtfs_mem: memory@f4101000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0xf4101000 0x0 0x300000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
+		/* rmtfs_upper_guard */
+		memory@f4401000 {
+			no-map;
+			reg = <0x0 0xf4401000 0x0 0x1000>;
+		};
+	};
+
+	vdd_boost_vreg: vdd-boost-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_boost_vreg";
+		startup-delay-us = <4000>;
+		enable-active-high;
+		regulator-always-on;
+		gpio = <&pm8150b_gpios 5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vdd_boost_en_pin>;
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+	};
+
+	/* S4 is modeled as a fixed regulator in vendor sources */
+	vreg_s4a_1p8: pm8150-s4-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vreg_s4a_1p8";
+
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+
+		vin-supply = <&vph_pwr>;
+	};
+};
+
+&apps_rsc {
+	pm8150-rpmh-regulators {
+		compatible = "qcom,pm8150-rpmh-regulators";
+		qcom,pmic-id = "a";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+		vdd-s9-supply = <&vph_pwr>;
+		vdd-s10-supply = <&vph_pwr>;
+
+		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
+		vdd-l2-l10-supply = <&vreg_bob>;
+		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
+		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
+		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
+		vdd-l13-l16-l17-supply = <&vreg_bob>;
+
+		vreg_s2a_0p6: smps2 {
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <600000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s2a_0p6";
+		};
+
+		vreg_s5a_1p9: smps5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s5a_0p6";
+		};
+
+		vreg_s6a_0p9: smps6 {
+			regulator-min-microvolt = <920000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_s6a_0p9";
+		};
+
+		vreg_l1a_0p75: ldo1 {
+			regulator-min-microvolt = <752000>;
+			regulator-max-microvolt = <752000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l1a_0p75";
+		};
+
+		vreg_l2a_3p1: ldo2 {
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l2a_3p1";
+		};
+
+		vreg_l3a_0p8: ldo3 {
+			regulator-min-microvolt = <480000>;
+			regulator-max-microvolt = <932000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l3a_0p8";
+		};
+
+		vreg_l5a_0p875: ldo5 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l5a_0p875";
+		};
+
+		vreg_l6a_1p2: ldo6 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l6a_1p2";
+		};
+
+		vreg_l7a_1p8: ldo7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l7a_1p8";
+		};
+
+		vreg_l9a_1p2: ldo9 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l9a_1p2";
+		};
+
+		vreg_l10a_2p5: ldo10 {
+			regulator-min-microvolt = <2504000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l10a_2p5";
+		};
+
+		vreg_l11a_0p8: ldo11 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l11a_0p8";
+		};
+
+		vreg_l12a_1p8: ldo12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l12a_1p8";
+		};
+
+		/* L13 is unused, but min/max are 3000000 for it. */
+
+		vreg_l14a_1p8: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l14a_1p8";
+		};
+
+		vreg_l15a_1p7: ldo15 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <1704000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l15a_1p7";
+		};
+
+		vreg_l16a_2p7: ldo16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l16a_2p7";
+		};
+
+		vreg_l17a_3p0: ldo17 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3008000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l17a_3p0";
+		};
+
+		vreg_l18a_0p8: ldo18 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150_l18a_0p8";
+		};
+	};
+
+	pm8150l-rpmh-regulators {
+		compatible = "qcom,pm8150l-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-s1-supply = <&vph_pwr>;
+		vdd-s2-supply = <&vph_pwr>;
+		vdd-s3-supply = <&vph_pwr>;
+		vdd-s4-supply = <&vph_pwr>;
+		vdd-s5-supply = <&vph_pwr>;
+		vdd-s6-supply = <&vph_pwr>;
+		vdd-s7-supply = <&vph_pwr>;
+		vdd-s8-supply = <&vph_pwr>;
+
+		vdd-l1-l8-supply = <&vreg_s4a_1p8>;
+		vdd-l2-l3-supply = <&vreg_s8c_1p3>;
+		vdd-l4-l5-l6-supply = <&vreg_bob>;
+		vdd-l7-l11-supply = <&vreg_bob>;
+		vdd-l9-l10-supply = <&vreg_bob>;
+
+		vdd-bob-supply = <&vph_pwr>;
+		vdd-flash-supply = <&vreg_bob>;
+		vdd-rgb-supply = <&vreg_bob>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3350000>;
+			regulator-max-microvolt = <4000000>;
+			/* tavil-slim-pgd will request 3300000 */
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-allow-bypass;
+			regulator-name = "pm8150l_bob";
+		};
+
+		vreg_s1c_1p1: smps1 {
+			regulator-min-microvolt = <1128000>;
+			regulator-max-microvolt = <1128000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s1c_1p1";
+		};
+
+		vreg_s8c_1p3: smps8 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_s8c_1p3";
+		};
+
+		vreg_l1c_1p8: ldo1 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l1c_1p8";
+		};
+
+		vreg_l2c_1p3: ldo2 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l2c_1p3";
+		};
+
+		vreg_l3c_1p2: ldo3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l3c_1p2";
+		};
+
+		vreg_l4c_1p8: ldo4 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l4c_1p8";
+		};
+
+		vreg_l5c_1p8: ldo5 {
+			regulator-min-microvolt = <1704000>;
+			regulator-max-microvolt = <2928000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l5c_1p8";
+		};
+
+		vreg_l6c_2p9: ldo6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l6c_2p9";
+		};
+
+		vreg_l7c_3p0: ldo7 {
+			regulator-min-microvolt = <2856000>;
+			regulator-max-microvolt = <3104000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l7c_3p0";
+		};
+
+		vreg_l8c_1p8: ldo8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l8c_1p8";
+		};
+
+		vreg_l9c_2p9: ldo9 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-allow-set-load;
+			regulator-name = "pm8150l_l9c_2p9";
+		};
+
+		vreg_l10c_3p3: ldo10 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l10c_3p3";
+		};
+
+		vreg_l11c_3p3: ldo11 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3312000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-name = "pm8150l_l11c_3p3";
+		};
+	};
+};
+
+&pm8150_gpios {
+	vol_up_pin_a: vol-up-active {
+		pins = "gpio6";
+		function = "normal";
+		input-enable;
+		bias-pull-up;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+};
+
+&pm8150b_gpios {
+	vdd_boost_en_pin: vdd-boost-en-pin {
+		pins = "gpio12";
+		function = "normal";
+		output-low;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_HIGH>;
+	};
+};
+
+&pon {
+	mode-recovery = <0x1>;
+	mode-bootloader = <0x2>;
+	mode-rtc = <0x3>;
+	mode-normal = <0x20>;
+	mode-panic = <0x21>;
+};
+
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
+};
+
+&tlmm {
+	/* gpios 0..3 are NFC spi, gpios 126..129 are FP spi */
+	gpio-reserved-ranges = <0 4>, <126 4>;
+
+	ai_key_pin_a: ai-key-pin-active {
+		pins = "gpio97";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	snps,has-lpm-erratum;
+	snps,hird-threshold = /bits/ 8 <0x10>;
+	maximum-speed = "high-speed";
+	dr_mode = "peripheral";
+};
+
+&usb_1_hsphy {
+	status = "okay";
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+	vdda18-supply = <&vreg_l12a_1p8>;
+	vdda33-supply = <&vreg_l2a_3p1>;
+};
+
+&usb_1_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l3c_1p2>;
+	vdda-pll-supply = <&vreg_l5a_0p875>;
+};
-- 
2.32.0

