Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757B0554A0A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiFVMdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbiFVMdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:33:07 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847F85F62
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:33:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 870172062C;
        Wed, 22 Jun 2022 14:33:03 +0200 (CEST)
Message-ID: <099cc82f-d52f-315f-189d-bcc40c1afd49@somainline.org>
Date:   Wed, 22 Jun 2022 14:33:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 4/6] arm64: dts: qcom: sc8280xp: Add reference device
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220622041224.627803-1-bjorn.andersson@linaro.org>
 <20220622041224.627803-5-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220622041224.627803-5-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 06:12, Bjorn Andersson wrote:
> Add basic support for the SC8280XP reference device, which allows it to
> boot to a shell (using EFIFB) with functional storage (UFS), USB,
> keyboard, touchpad, touchscreen, backlight and remoteprocs.
> 
> The PMICs are, per socinfo, reused from other platforms. But given that
> the address of the PMICs doesn't match other cases and that it's
> desirable to label things according to the schematics a new dtsi file is
> created to represent the reference combination of PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
> 
> Changes since v1:
> - Reordered "status" last
> - Fixed invalid PMIC gpio 0
> - Replaced "hid" name with touchscreen, touchpad and keyboard
> - Added &xo_board_clk frequency
> 
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts    | 432 +++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 108 +++++
>  3 files changed, 541 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 2f8aec2cc6db..ceeae094a59f 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -89,6 +89,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-villager-r0.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd-r3.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-ganges-kirin.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-discovery.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sdm630-sony-xperia-nile-pioneer.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> new file mode 100644
> index 000000000000..38a64e886466
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sc8280xp.dtsi"
> +#include "sc8280xp-pmics.dtsi"
> +
> +/ {
> +	model = "Qualcomm SC8280XP CRD";
> +	compatible = "qcom,sc8280xp-crd", "qcom,sc8280xp";
> +
> +	aliases {
> +		serial0 = &qup2_uart17;
> +	};
> +
> +	backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pmc8280c_lpg 3 1000000>;
> +		enable-gpios = <&pmc8280_1_gpios 8 GPIO_ACTIVE_HIGH>;
> +		power-supply = <&vreg_edp_bl>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_en>, <&edp_bl_pwm>;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	vreg_edp_bl: edp-bl-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_EDP_BL";
> +		regulator-min-microvolt = <3600000>;
> +		regulator-max-microvolt = <3600000>;
> +
> +		gpio = <&pmc8280_1_gpios 9 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&edp_bl_reg_en>;
> +
> +		regulator-boot-on;
> +	};
> +
> +	vreg_misc_3p3: misc-3p3-regulator {
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "VREG_MISC_3P3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&pmc8280_1_gpios 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&misc_3p3_reg_en>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
> +	reserved-memory {
> +	};
Seems redundant.


> +};
> +
> +&apps_rsc {
> +	pmc8280-1-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd-l3-l5-supply = <&vreg_s11b>;
> +
> +		vreg_s11b: smps11 {
> +			regulator-name = "vreg_s11b";
> +			regulator-min-microvolt = <1272000>;
> +			regulator-max-microvolt = <1272000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3b: ldo3 {
> +			regulator-name = "vreg_l3b";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l4b: ldo4 {
> +			regulator-name = "vreg_l4b";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6b: ldo6 {
> +			regulator-name = "vreg_l6b";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-boot-on;
> +		};
> +	};
> +
> +	pmc8280c-rpmh-regulators {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l13c: ldo13 {
> +			regulator-name = "vreg_l13c";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmc8280-2-rpmh-regulators {
> +		compatible = "qcom,pm8350-rpmh-regulators";
> +		qcom,pmic-id = "d";
> +
> +		vdd-l1-l4-supply = <&vreg_s11b>;
> +
> +		vreg_l3d: ldo3 {
> +			regulator-name = "vreg_l3d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l4d: ldo4 {
> +			regulator-name = "vreg_l4d";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6d: ldo6 {
> +			regulator-name = "vreg_l6d";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7d: ldo7 {
> +			regulator-name = "vreg_l7d";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l9d: ldo9 {
> +			regulator-name = "vreg_l9d";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
> +
> +&pmc8280c_lpg {
> +	status = "okay";
> +};
> +
> +&pmk8280_pon_pwrkey {
> +	status = "okay";
> +};
> +
> +&qup0 {
> +	status = "okay";
> +};
> +
> +&qup0_i2c4 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup0_i2c4_default>, <&ts0_default>;
> +
> +	status = "okay";
> +
> +	touchscreen@10 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x10>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 175 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};
> +
> +&qup1 {
> +	status = "okay";
> +};
> +
> +&qup2 {
> +	status = "okay";
> +};
> +
> +&qup2_i2c5 {
> +	clock-frequency = <400000>;
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&qup2_i2c5_default>, <&kybd_default>, <&tpad_default>;
> +
> +	status = "okay";
> +
I think all device DTs generally have 'status = "okay"' at the beginning. Should we change that?


> +	touchpad@15 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x15>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 182 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +
> +	keyboard@68 {
> +		compatible = "hid-over-i2c";
> +		reg = <0x68>;
> +		hid-descr-addr = <0x1>;
> +		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
> +		vdd-supply = <&vreg_misc_3p3>;
> +	};
> +};
> +
> +&qup2_uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	firmware-name = "qcom/sc8280xp/qcadsp8280.mbn";
> +
> +	status = "okay";
> +};
> +
> +&remoteproc_nsp0 {
> +	firmware-name = "qcom/sc8280xp/qccdsp8280.mbn";
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_hc {
> +	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l7c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l3d>;
> +	vccq-max-microamp = <900000>;
> +
> +	status = "okay";
> +};
> +
> +&ufs_mem_phy {
> +	vdda-phy-supply = <&vreg_l6b>;
> +	vdda-pll-supply = <&vreg_l3b>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "host";
> +};
> +
> +&usb_0_hsphy {
> +	vdda-pll-supply = <&vreg_l9d>;
> +	vdda18-supply = <&vreg_l1c>;
> +	vdda33-supply = <&vreg_l7d>;
> +
> +	status = "okay";
> +};
> +
> +&usb_0_qmpphy {
> +	vdda-phy-supply = <&vreg_l9d>;
> +	vdda-pll-supply = <&vreg_l4d>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vreg_l4b>;
> +	vdda18-supply = <&vreg_l1c>;
> +	vdda33-supply = <&vreg_l13c>;
> +
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vreg_l4b>;
> +	vdda-pll-supply = <&vreg_l3b>;
> +
> +	status = "okay";
> +};
> +
> +/* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
This comment seems redundant.

> +
> +&pmc8280_1_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio8";
> +		function = "normal";
> +	};
> +
> +	edp_bl_reg_en: edp-bl-reg-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +	};
> +
> +	misc_3p3_reg_en: misc-3p3-reg-en-state {
> +		pins = "gpio1";
> +		function = "normal";
> +	};
> +};
> +
> +&pmc8280c_gpios {
> +	edp_bl_pwm: edp-bl-pwm-state {
> +		pins = "gpio8";
> +		function = "func1";
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
> +
> +	kybd_default: kybd-default-state {
> +		disable {
> +			pins = "gpio102";
> +			function = "gpio";
> +			output-low;
> +		};
> +
> +		int-n {
> +			pins = "gpio104";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +
> +		reset {
> +			pins = "gpio105";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
> +	qup0_i2c4_default: qup0-i2c4-default-state {
> +		pins = "gpio171", "gpio172";
> +		function = "qup4";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	qup2_i2c5_default: qup2-i2c5-default-state {
> +		pins = "gpio81", "gpio82";
> +		function = "qup21";
> +
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	tpad_default: tpad-default-state {
> +		int-n {
If you aren't gonna add more pins to this touchpad block, I think you could drop this extra level.


> +			pins = "gpio182";
> +			function = "gpio";
> +			bias-disable;
> +		};
> +	};
> +
> +	ts0_default: ts0-default-state {
> +		int-n {
> +			pins = "gpio175";
> +			function = "gpio";
> +			bias-pull-up;
> +		};
> +
> +		reset-n {
> +			pins = "gpio99";
> +			function = "gpio";
> +			output-high;
> +			drive-strength = <16>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> new file mode 100644
> index 000000000000..36ed7d808ab8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
Is it the only configuration supported by Qualcomm, or only a reference one?

Konrad


> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +&spmi_bus {
> +	pmk8280: pmic@0 {
> +		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmk8280_pon: pon@1300 {
> +			compatible = "qcom,pm8998-pon";
> +			reg = <0x1300>;
> +
> +			pmk8280_pon_pwrkey: pwrkey {
> +				compatible = "qcom,pmk8350-pwrkey";
> +				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
> +				linux,code = <KEY_POWER>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	pmc8280_1: pmic@1 {
> +		compatible = "qcom,pm8350", "qcom,spmi-pmic";
> +		reg = <0x1 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmc8280_1_gpios: gpio@8800 {
> +			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmc8280_1_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmc8280c: pmic@2 {
> +		compatible = "qcom,pm8350c", "qcom,spmi-pmic";
> +		reg = <0x2 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmc8280c_gpios: gpio@8800 {
> +			compatible = "qcom,pm8350c-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmc8280c_gpios 0 0 9>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		pmc8280c_lpg: lpg@e800 {
> +			compatible = "qcom,pm8350c-pwm";
> +			reg = <0xe800>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			#pwm-cells = <2>;
> +
> +			status = "disabled";
> +		};
> +	};
> +
> +	pmc8280_2: pmic@3 {
> +		compatible = "qcom,pm8350", "qcom,spmi-pmic";
> +		reg = <0x3 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmc8280_2_gpios: gpio@8800 {
> +			compatible = "qcom,pm8350-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmc8280_2_gpios 0 0 10>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pmr735a: pmic@4 {
> +		compatible = "qcom,pmr735a", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pmr735a_gpios: gpio@8800 {
> +			compatible = "qcom,pmr735a-gpio", "qcom,spmi-gpio";
> +			reg = <0x8800>;
> +			gpio-controller;
> +			gpio-ranges = <&pmr735a_gpios 0 0 4>;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> 
