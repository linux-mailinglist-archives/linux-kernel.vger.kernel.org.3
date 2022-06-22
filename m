Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE22554A25
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241217AbiFVMhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 08:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241306AbiFVMhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 08:37:07 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673853A5EB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 05:37:05 -0700 (PDT)
Received: from [192.168.1.101] (abxi223.neoplus.adsl.tpnet.pl [83.9.2.223])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 4C18E2063E;
        Wed, 22 Jun 2022 14:37:03 +0200 (CEST)
Message-ID: <8fc661d7-6f75-59d8-fa19-76193ed2f4fe@somainline.org>
Date:   Wed, 22 Jun 2022 14:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: add SA8540P and ADP
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
 <20220622041224.627803-6-bjorn.andersson@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220622041224.627803-6-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.06.2022 06:12, Bjorn Andersson wrote:
> Introduce the Qualcomm SA8540P automotive platform and the SA8295P ADP
> development board.
So are SA8295P and SA8540P the same SoCs? Or is it a board name?


> 
> The SA8540P and SC8280XP are fairly similar, so the SA8540P is built
> ontop of the SC8280XP dtsi to reduce duplication. As more advanced
> features are integrated this might be re-evaluated.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs (NSPs crashes shortly after
> booting) and USB.
> 
> The SA8295P ADP contains four PM8450 PMICs, which according to their
> revid are compatible with PM8150. They are defined within the ADP for
> now, to avoid creating additional .dtsi files for PM8150 with just
> addresses changed - and to allow using the labels from the schematics.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile        |   1 +
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts | 427 +++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sa8540p.dtsi    | 133 +++++++
>  3 files changed, 561 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8295p-adp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sa8540p.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index ceeae094a59f..2f416b84b71c 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -52,6 +52,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sa8155p-adp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sa8295p-adp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-coachz-r1-lte.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> new file mode 100644
> index 000000000000..8dbcd95966b0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
> @@ -0,0 +1,427 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
Can be moved to SoC dtsi.


> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/spmi/spmi.h>
> +
> +#include "sa8540p.dtsi"
> +
> +/ {
> +	model = "Qualcomm SA8295P ADP";
> +	compatible = "qcom,sa8295p-adp", "qcom,sa8540p";
> +
> +	aliases {
> +		serial0 = &qup2_uart17;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	reserved-memory {
> +	};
Seems redundant.


> +};
> +
> +&apps_rsc {
> +	pmm8540-a-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_l3a: ldo3 {
> +			regulator-name = "vreg_l3a";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l5a: ldo5 {
> +			regulator-name = "vreg_l5a";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7a: ldo7 {
> +			regulator-name = "vreg_l7a";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l13a: ldo13 {
> +			regulator-name = "vreg_l13a";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmm8540-c-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vreg_l1c: ldo1 {
> +			regulator-name = "vreg_l1c";
> +			regulator-min-microvolt = <912000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l2c: ldo2 {
> +			regulator-name = "vreg_l2c";
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l3c: ldo3 {
> +			regulator-name = "vreg_l3c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l4c: ldo4 {
> +			regulator-name = "vreg_l4c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1208000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l6c: ldo6 {
> +			regulator-name = "vreg_l6c";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7c: ldo7 {
> +			regulator-name = "vreg_l7c";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l10c: ldo10 {
> +			regulator-name = "vreg_l10c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l17c: ldo17 {
> +			regulator-name = "vreg_l17c";
> +			regulator-min-microvolt = <2504000>;
> +			regulator-max-microvolt = <2504000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +
> +	pmm8540-g-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "g";
> +
> +		vreg_l3g: ldo3 {
> +			regulator-name = "vreg_l3g";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l7g: ldo7 {
> +			regulator-name = "vreg_l7g";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +
> +		vreg_l8g: ldo8 {
> +			regulator-name = "vreg_l8g";
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +		};
> +	};
> +};
> +
> +&qup2 {
> +	status = "okay";
> +};
> +
> +&qup2_uart17 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
> +&remoteproc_adsp {
> +	status = "okay";
> +	firmware-name = "qcom/sa8540p/adsp.mbn";
> +};
> +
> +&remoteproc_nsp0 {
> +	status = "okay";
> +	firmware-name = "qcom/sa8540p/cdsp.mbn";
> +};
> +
> +&remoteproc_nsp1 {
> +	status = "okay";
> +	firmware-name = "qcom/sa8540p/cdsp1.mbn";
> +};
> +
> +&spmi_bus {
> +	pm8450a: pmic@0 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x0 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450a_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450c: pmic@4 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x4 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450c_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450e: pmic@8 {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0x8 SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450e_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +
> +	pm8450g: pmic@c {
> +		compatible = "qcom,pm8150", "qcom,spmi-pmic";
> +		reg = <0xc SPMI_USID>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pm8450g_gpios: gpio@c000 {
> +			compatible = "qcom,pm8150-gpio";
> +			reg = <0xc000>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};
> +	};
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 228 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l17c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l6c>;
> +	vccq-max-microamp = <900000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&ufs_card_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 229 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l10c>;
> +	vcc-max-microamp = <800000>;
> +	vccq-supply = <&vreg_l3c>;
> +	vccq-max-microamp = <900000>;
> +};
> +
> +&ufs_card_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l8g>;
> +	vdda-pll-supply = <&vreg_l3g>;
> +};
> +
> +&usb_0 {
> +	status = "okay";
> +};
> +
> +&usb_0_dwc3 {
> +	/* TODO: Define USB-C connector properly */
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_0_hsphy {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7a>;
> +	vdda33-supply = <&vreg_l13a>;
> +};
> +
> +&usb_0_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
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
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l1c>;
> +	vdda18-supply = <&vreg_l7c>;
> +	vdda33-supply = <&vreg_l2c>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l4c>;
> +	vdda-pll-supply = <&vreg_l1c>;
> +};
> +
> +&usb_2_hsphy0 {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +};
> +
> +&usb_2_hsphy1 {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +};
> +
> +&usb_2_hsphy2 {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +};
> +
> +&usb_2_hsphy3 {
> +	status = "okay";
> +
> +	vdda-pll-supply = <&vreg_l5a>;
> +	vdda18-supply = <&vreg_l7g>;
> +	vdda33-supply = <&vreg_l13a>;
> +};
> +
> +&usb_2_qmpphy0 {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +};
> +
> +&usb_2_qmpphy1 {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l3a>;
> +	vdda-pll-supply = <&vreg_l5a>;
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <38400000>;
> +};
Not entirely the best place to ask, but I only noticed now.. Is this expected to be variable? Can the SoC even run properly with the XO at different frequencies?

> +
> +/* PINCTRL */
Seems redundant.

Konrad
> +&pm8450c_gpios {
> +	usb2_en_state: usb2-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pm8450e_gpios {
> +	usb3_en_state: usb3-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> +
> +&pm8450g_gpios {
> +	usb4_en_state: usb4-en-state {
> +		pins = "gpio5";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +
> +	usb5_en_state: usb5-en-state {
> +		pins = "gpio9";
> +		function = "normal";
> +		output-high;
> +		power-source = <0>;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p.dtsi b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> new file mode 100644
> index 000000000000..8ea2886fbab2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sa8540p.dtsi
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Limited
> + */
> +
> +#include "sc8280xp.dtsi"
> +
> +/delete-node/ &cpu0_opp_table;
> +/delete-node/ &cpu4_opp_table;
> +
> +/ {
> +	cpu0_opp_table: cpu0-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-403200000 {
> +			opp-hz = /bits/ 64 <403200000>;
> +		};
> +		opp-499200000 {
> +			opp-hz = /bits/ 64 <499200000>;
> +		};
> +		opp-595200000 {
> +			opp-hz = /bits/ 64 <595200000>;
> +		};
> +		opp-710400000 {
> +			opp-hz = /bits/ 64 <710400000>;
> +		};
> +		opp-806400000 {
> +			opp-hz = /bits/ 64 <806400000>;
> +		};
> +		opp-902400000 {
> +			opp-hz = /bits/ 64 <902400000>;
> +		};
> +		opp-1017600000 {
> +			opp-hz = /bits/ 64 <1017600000>;
> +		};
> +		opp-1113600000 {
> +			opp-hz = /bits/ 64 <1113600000>;
> +		};
> +		opp-1209600000 {
> +			opp-hz = /bits/ 64 <1209600000>;
> +		};
> +		opp-1324800000 {
> +			opp-hz = /bits/ 64 <1324800000>;
> +		};
> +		opp-1440000000 {
> +			opp-hz = /bits/ 64 <1440000000>;
> +		};
> +		opp-1555200000 {
> +			opp-hz = /bits/ 64 <1555200000>;
> +		};
> +		opp-1670400000 {
> +			opp-hz = /bits/ 64 <1670400000>;
> +		};
> +		opp-1785600000 {
> +			opp-hz = /bits/ 64 <1785600000>;
> +		};
> +		opp-1881600000 {
> +			opp-hz = /bits/ 64 <1881600000>;
> +		};
> +		opp-2016000000 {
> +			opp-hz = /bits/ 64 <2016000000>;
> +		};
> +		opp-2131200000 {
> +			opp-hz = /bits/ 64 <2131200000>;
> +		};
> +		opp-2246400000 {
> +			opp-hz = /bits/ 64 <2246400000>;
> +		};
> +	};
> +
> +	cpu4_opp_table: cpu4-opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-825600000 {
> +			opp-hz = /bits/ 64 <825600000>;
> +		};
> +		opp-940800000 {
> +			opp-hz = /bits/ 64 <940800000>;
> +		};
> +		opp-1056000000 {
> +			opp-hz = /bits/ 64 <1056000000>;
> +		};
> +		opp-1171200000 {
> +			opp-hz = /bits/ 64 <1171200000>;
> +		};
> +		opp-1286400000 {
> +			opp-hz = /bits/ 64 <1286400000>;
> +		};
> +		opp-1401600000 {
> +			opp-hz = /bits/ 64 <1401600000>;
> +		};
> +		opp-1516800000 {
> +			opp-hz = /bits/ 64 <1516800000>;
> +		};
> +		opp-1632000000 {
> +			opp-hz = /bits/ 64 <1632000000>;
> +		};
> +		opp-1747200000 {
> +			opp-hz = /bits/ 64 <1747200000>;
> +		};
> +		opp-1862400000 {
> +			opp-hz = /bits/ 64 <1862400000>;
> +		};
> +		opp-1977600000 {
> +			opp-hz = /bits/ 64 <1977600000>;
> +		};
> +		opp-2073600000 {
> +			opp-hz = /bits/ 64 <2073600000>;
> +		};
> +		opp-2169600000 {
> +			opp-hz = /bits/ 64 <2169600000>;
> +		};
> +		opp-2284800000 {
> +			opp-hz = /bits/ 64 <2284800000>;
> +		};
> +		opp-2380800000 {
> +			opp-hz = /bits/ 64 <2380800000>;
> +		};
> +		opp-2496000000 {
> +			opp-hz = /bits/ 64 <2496000000>;
> +		};
> +		opp-2592000000 {
> +			opp-hz = /bits/ 64 <2592000000>;
> +		};
> +	};
> +};
> +
> +&rpmhpd {
> +	compatible = "qcom,sa8540p-rpmhpd";
> +};
> 
