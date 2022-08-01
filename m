Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DC5587098
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 20:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiHASxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbiHASxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 14:53:15 -0400
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [5.144.164.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACAC1AF34
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 11:53:10 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9839D3F73E;
        Mon,  1 Aug 2022 20:53:06 +0200 (CEST)
Date:   Mon, 1 Aug 2022 20:53:04 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Joel Selvaraj <joel.selvaraj@outlook.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] arm64: dts: qcom: sdm845-xiaomi-beryllium-common:
 move common nodes to a common dtsi
Message-ID: <20220801185304.ozoydbmbgqe6fqdy@SoMainline.org>
References: <BY5PR02MB70099020AC1D181D15909F64EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
 <BY5PR02MB70091276EDE0CE4FCB6CFBD5EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR02MB70091276EDE0CE4FCB6CFBD5EA9A9@BY5PR02MB7009.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 16:55:11, Joel Selvaraj wrote:
> Since there are two variants of Xiaomi Poco F1, move the common nodes from
> Tianma variant into a new common dtsi. The EBBG variant will also inherit
> the new common dtsi.
> 
> Signed-off-by: Joel Selvaraj <joel.selvaraj@outlook.com>
> ---

Any summary what changed since v1?

>  .../qcom/sdm845-xiaomi-beryllium-common.dtsi  | 595 ++++++++++++++++++
>  .../qcom/sdm845-xiaomi-beryllium-tianma.dts   | 590 +----------------
>  2 files changed, 598 insertions(+), 587 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
> new file mode 100644
> index 000000000000..83edcb1171f5
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi

I haven't re-read what was discussed in v1, but doing it this way causes
git to _not_ record this as a rename but instead state that everything
has been removed from sdm845-xiaomi-beryllium-tianma.dts, and a new file
sdm845-xiaomi-beryllium-common.dtsi was introduced with inconveniently
almost identical contents (see the unnecessary size of the patch that
follows).

Instead, I'd keep the original patch with a rename from
sdm845-xiaomi-beryllium.dts to sdm845-xiaomi-beryllium-common.dtsi, and
_also_ update the existing:

	dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-xiaomi-beryllium.dtb

in Makefile to match this rename so that it keeps compiling, even if
that means we treat a .dtsi as a .dts which may (likely) not be treated
correctly by existing build rules.

If it doesn't - and this approach is probably frowned upon anyway - it
is perhaps easiest to generalize sdm845-xiaomi-beryllium.dtb (as
suggested above) _and_ introduce sdm845-xiaomi-beryllium-tianma.dtb
_and_ update Makefile in a _single_ patch, such that everyting keeps
compiling and stays consistent wrt how git treats renames.  Later
patches update the compatible and add the ebbg variant.

- Marijn

> @@ -0,0 +1,595 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include <dt-bindings/sound/qcom,q6afe.h>
> +#include <dt-bindings/sound/qcom,q6asm.h>
> +#include "sdm845.dtsi"
> +#include "pm8998.dtsi"
> +#include "pmi8998.dtsi"
> +
> +/*
> + * Delete following upstream (sdm845.dtsi) reserved
> + * memory mappings which are different in this device.
> + */
> +/delete-node/ &tz_mem;
> +/delete-node/ &adsp_mem;
> +/delete-node/ &wlan_msa_mem;
> +/delete-node/ &mpss_region;
> +/delete-node/ &venus_mem;
> +/delete-node/ &cdsp_mem;
> +/delete-node/ &mba_region;
> +/delete-node/ &slpi_mem;
> +/delete-node/ &spss_mem;
> +/delete-node/ &rmtfs_mem;
> +
> +/ {
> +	model = "Xiaomi Pocophone F1";
> +	compatible = "xiaomi,beryllium", "qcom,sdm845";
> +	chassis-type = "handset";
> +
> +	/* required for bootloader to select correct board */
> +	qcom,board-id = <69 0>;
> +	qcom,msm-id = <321 0x20001>;
> +
> +	aliases {
> +		hsuart0 = &uart6;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		autorepeat;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vol_up_pin_a>;
> +
> +		vol-up {
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	/* Reserved memory changes from downstream */
> +	reserved-memory {
> +		tz_mem: memory@86200000 {
> +			reg = <0 0x86200000 0 0x4900000>;
> +			no-map;
> +		};
> +
> +		adsp_mem: memory@8c500000 {
> +			reg = <0 0x8c500000 0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		wlan_msa_mem: memory@8e300000 {
> +			reg = <0 0x8e300000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		mpss_region: memory@8e400000 {
> +			reg = <0 0x8e400000 0 0x7800000>;
> +			no-map;
> +		};
> +
> +		venus_mem: memory@95c00000 {
> +			reg = <0 0x95c00000 0 0x500000>;
> +			no-map;
> +		};
> +
> +		cdsp_mem: memory@96100000 {
> +			reg = <0 0x96100000 0 0x800000>;
> +			no-map;
> +		};
> +
> +		mba_region: memory@96900000 {
> +			reg = <0 0x96900000 0 0x200000>;
> +			no-map;
> +		};
> +
> +		slpi_mem: memory@96b00000 {
> +			reg = <0 0x96b00000 0 0x1400000>;
> +			no-map;
> +		};
> +
> +		spss_mem: memory@97f00000 {
> +			reg = <0 0x97f00000 0 0x100000>;
> +			no-map;
> +		};
> +
> +		rmtfs_mem: memory@f6301000 {
> +			compatible = "qcom,rmtfs-mem";
> +			reg = <0 0xf6301000 0 0x200000>;
> +			no-map;
> +
> +			qcom,client-id = <1>;
> +			qcom,vmid = <15>;
> +		};
> +	};
> +
> +	vreg_s4a_1p8: vreg-s4a-1p8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vreg_s4a_1p8";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-always-on;
> +	};
> +};
> +
> +&adsp_pas {
> +	status = "okay";
> +	firmware-name = "qcom/sdm845/beryllium/adsp.mbn";
> +};
> +
> +&apps_rsc {
> +	pm8998-rpmh-regulators {
> +		compatible = "qcom,pm8998-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vreg_l1a_0p875: ldo1 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l5a_0p8: ldo5 {
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7a_1p8: ldo7 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12a_1p8: ldo12 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13a_2p95: ldo13 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l14a_1p8: ldo14 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-boot-on;
> +			regulator-always-on;
> +		};
> +
> +		vreg_l17a_1p3: ldo17 {
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l20a_2p95: ldo20 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2968000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l21a_2p95: ldo21 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2968000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l23a_3p3: ldo23 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l24a_3p075: ldo24 {
> +			regulator-min-microvolt = <3088000>;
> +			regulator-max-microvolt = <3088000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l25a_3p3: ldo25 {
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3312000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l26a_1p2: ldo26 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-boot-on;
> +		};
> +	};
> +};
> +
> +&cdsp_pas {
> +	status = "okay";
> +	firmware-name = "qcom/sdm845/beryllium/cdsp.mbn";
> +};
> +
> +&dsi0 {
> +	status = "okay";
> +	vdda-supply = <&vreg_l26a_1p2>;
> +
> +	display_panel: panel@0 {
> +		reg = <0>;
> +		vddio-supply = <&vreg_l14a_1p8>;
> +		vddpos-supply = <&lab>;
> +		vddneg-supply = <&ibb>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		backlight = <&pmi8998_wled>;
> +		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> +
> +		status = "disabled";
> +
> +		port {
> +			panel_in_0: endpoint {
> +				remote-endpoint = <&dsi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&dsi0_out {
> +	remote-endpoint = <&panel_in_0>;
> +	data-lanes = <0 1 2 3>;
> +};
> +
> +&dsi0_phy {
> +	status = "okay";
> +	vdds-supply = <&vreg_l1a_0p875>;
> +};
> +
> +&gcc {
> +	protected-clocks = <GCC_QSPI_CORE_CLK>,
> +			   <GCC_QSPI_CORE_CLK_SRC>,
> +			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +			   <GCC_LPASS_Q6_AXI_CLK>,
> +			   <GCC_LPASS_SWAY_CLK>;
> +};
> +
> +&gmu {
> +	status = "okay";
> +};
> +
> +&gpu {
> +	status = "okay";
> +
> +	zap-shader {
> +		memory-region = <&gpu_mem>;
> +		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
> +	};
> +};
> +
> +&ibb {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +	qcom,discharge-resistor-kohms = <300>;
> +};
> +
> +&lab {
> +	regulator-min-microvolt = <4600000>;
> +	regulator-max-microvolt = <6000000>;
> +	regulator-over-current-protection;
> +	regulator-pull-down;
> +	regulator-soft-start;
> +};
> +
> +&mdss {
> +	status = "okay";
> +};
> +
> +&mss_pil {
> +	status = "okay";
> +	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
> +};
> +
> +&ipa {
> +	status = "okay";
> +	memory-region = <&ipa_fw_mem>;
> +	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
> +};
> +
> +&pm8998_gpio {
> +	vol_up_pin_a: vol-up-active {
> +		pins = "gpio6";
> +		function = "normal";
> +		input-enable;
> +		bias-pull-up;
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> +	};
> +};
> +
> +&pmi8998_wled {
> +	status = "okay";
> +	qcom,current-boost-limit = <970>;
> +	qcom,ovp-millivolt = <29600>;
> +	qcom,current-limit-microamp = <20000>;
> +	qcom,num-strings = <2>;
> +	qcom,switching-freq = <600>;
> +	qcom,external-pfet;
> +	qcom,cabc;
> +};
> +
> +&pm8998_pon {
> +	resin {
> +		compatible = "qcom,pm8941-resin";
> +		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> +		debounce = <15625>;
> +		bias-pull-up;
> +		linux,code = <KEY_VOLUMEDOWN>;
> +	};
> +};
> +
> +/* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
> +&q6afedai {
> +	qi2s@22 {
> +		reg = <22>;
> +		qcom,sd-lines = <0>;
> +	};
> +};
> +
> +&q6asmdai {
> +	dai@0 {
> +		reg = <0>;
> +	};
> +
> +	dai@1 {
> +		reg = <1>;
> +	};
> +
> +	dai@2 {
> +		reg = <2>;
> +	};
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> +
> +	vmmc-supply = <&vreg_l21a_2p95>;
> +	vqmmc-supply = <&vreg_l13a_2p95>;
> +
> +	bus-width = <4>;
> +	cd-gpios = <&tlmm 126 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&sound {
> +	compatible = "qcom,db845c-sndcard";
> +	pinctrl-0 = <&quat_mi2s_active
> +			&quat_mi2s_sd0_active>;
> +	pinctrl-names = "default";
> +	model = "Xiaomi Poco F1";
> +	audio-routing =
> +		"RX_BIAS", "MCLK",
> +		"AMIC1", "MIC BIAS1",
> +		"AMIC2", "MIC BIAS2",
> +		"AMIC3", "MIC BIAS3";
> +
> +	mm1-dai-link {
> +		link-name = "MultiMedia1";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> +		};
> +	};
> +
> +	mm2-dai-link {
> +		link-name = "MultiMedia2";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> +		};
> +	};
> +
> +	mm3-dai-link {
> +		link-name = "MultiMedia3";
> +		cpu {
> +			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> +		};
> +	};
> +
> +	slim-dai-link {
> +		link-name = "SLIM Playback";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai =  <&wcd9340 0>;
> +		};
> +	};
> +
> +	slimcap-dai-link {
> +		link-name = "SLIM Capture";
> +		cpu {
> +			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> +		};
> +
> +		platform {
> +			sound-dai = <&q6routing>;
> +		};
> +
> +		codec {
> +			sound-dai = <&wcd9340 1>;
> +		};
> +	};
> +};
> +
> +&tlmm {
> +	gpio-reserved-ranges = <0 4>, <81 4>;
> +
> +	sdc2_default_state: sdc2-default {
> +		clk {
> +			pins = "sdc2_clk";
> +			bias-disable;
> +			drive-strength = <16>;
> +		};
> +
> +		cmd {
> +			pins = "sdc2_cmd";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +
> +		data {
> +			pins = "sdc2_data";
> +			bias-pull-up;
> +			drive-strength = <10>;
> +		};
> +	};
> +
> +	sdc2_card_det_n: sd-card-det-n {
> +		pins = "gpio126";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	wcd_intr_default: wcd_intr_default {
> +		pins = <54>;
> +		function = "gpio";
> +
> +		input-enable;
> +		bias-pull-down;
> +		drive-strength = <2>;
> +	};
> +};
> +
> +&uart6 {
> +	status = "okay";
> +
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&ufs_mem_hc {
> +	status = "okay";
> +
> +	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
> +
> +	vcc-supply = <&vreg_l20a_2p95>;
> +	vcc-max-microamp = <800000>;
> +};
> +
> +&ufs_mem_phy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l26a_1p2>;
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +
> +	vdd-supply = <&vreg_l1a_0p875>;
> +	vdda-pll-supply = <&vreg_l12a_1p8>;
> +	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> +
> +	qcom,imp-res-offset-value = <8>;
> +	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> +	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> +	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +
> +	vdda-phy-supply = <&vreg_l26a_1p2>;
> +	vdda-pll-supply = <&vreg_l1a_0p875>;
> +};
> +
> +&venus {
> +	status = "okay";
> +	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
> +};
> +
> +&wcd9340{
> +	pinctrl-0 = <&wcd_intr_default>;
> +	pinctrl-names = "default";
> +	clock-names = "extclk";
> +	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
> +	reset-gpios = <&tlmm 64 0>;
> +	vdd-buck-supply = <&vreg_s4a_1p8>;
> +	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> +	vdd-tx-supply = <&vreg_s4a_1p8>;
> +	vdd-rx-supply = <&vreg_s4a_1p8>;
> +	vdd-io-supply = <&vreg_s4a_1p8>;
> +	qcom,micbias1-microvolt = <2700000>;
> +	qcom,micbias2-microvolt = <1800000>;
> +	qcom,micbias3-microvolt = <2700000>;
> +	qcom,micbias4-microvolt = <2700000>;
> +};
> +
> +&wifi {
> +	status = "okay";
> +
> +	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> +	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> +	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> +	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> +	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
> +};
> +
> +/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> +
> +&qup_uart6_default {
> +	pinmux {
> +		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> +		function = "qup6";
> +	};
> +
> +	cts {
> +		pins = "gpio45";
> +		bias-disable;
> +	};
> +
> +	rts-tx {
> +		pins = "gpio46", "gpio47";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	rx {
> +		pins = "gpio48";
> +		bias-pull-up;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> index d88dc07205f7..fcbef5ad2909 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-tianma.dts
> @@ -2,593 +2,9 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> -#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> -#include <dt-bindings/sound/qcom,q6afe.h>
> -#include <dt-bindings/sound/qcom,q6asm.h>
> -#include "sdm845.dtsi"
> -#include "pm8998.dtsi"
> -#include "pmi8998.dtsi"
> +#include "sdm845-xiaomi-beryllium-common.dtsi"
>  
> -/*
> - * Delete following upstream (sdm845.dtsi) reserved
> - * memory mappings which are different in this device.
> - */
> -/delete-node/ &tz_mem;
> -/delete-node/ &adsp_mem;
> -/delete-node/ &wlan_msa_mem;
> -/delete-node/ &mpss_region;
> -/delete-node/ &venus_mem;
> -/delete-node/ &cdsp_mem;
> -/delete-node/ &mba_region;
> -/delete-node/ &slpi_mem;
> -/delete-node/ &spss_mem;
> -/delete-node/ &rmtfs_mem;
> -
> -/ {
> -	model = "Xiaomi Pocophone F1";
> -	compatible = "xiaomi,beryllium", "qcom,sdm845";
> -	chassis-type = "handset";
> -
> -	/* required for bootloader to select correct board */
> -	qcom,board-id = <69 0>;
> -	qcom,msm-id = <321 0x20001>;
> -
> -	aliases {
> -		hsuart0 = &uart6;
> -	};
> -
> -	gpio-keys {
> -		compatible = "gpio-keys";
> -		autorepeat;
> -
> -		pinctrl-names = "default";
> -		pinctrl-0 = <&vol_up_pin_a>;
> -
> -		vol-up {
> -			label = "Volume Up";
> -			linux,code = <KEY_VOLUMEUP>;
> -			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
> -		};
> -	};
> -
> -	/* Reserved memory changes from downstream */
> -	reserved-memory {
> -		tz_mem: memory@86200000 {
> -			reg = <0 0x86200000 0 0x4900000>;
> -			no-map;
> -		};
> -
> -		adsp_mem: memory@8c500000 {
> -			reg = <0 0x8c500000 0 0x1e00000>;
> -			no-map;
> -		};
> -
> -		wlan_msa_mem: memory@8e300000 {
> -			reg = <0 0x8e300000 0 0x100000>;
> -			no-map;
> -		};
> -
> -		mpss_region: memory@8e400000 {
> -			reg = <0 0x8e400000 0 0x7800000>;
> -			no-map;
> -		};
> -
> -		venus_mem: memory@95c00000 {
> -			reg = <0 0x95c00000 0 0x500000>;
> -			no-map;
> -		};
> -
> -		cdsp_mem: memory@96100000 {
> -			reg = <0 0x96100000 0 0x800000>;
> -			no-map;
> -		};
> -
> -		mba_region: memory@96900000 {
> -			reg = <0 0x96900000 0 0x200000>;
> -			no-map;
> -		};
> -
> -		slpi_mem: memory@96b00000 {
> -			reg = <0 0x96b00000 0 0x1400000>;
> -			no-map;
> -		};
> -
> -		spss_mem: memory@97f00000 {
> -			reg = <0 0x97f00000 0 0x100000>;
> -			no-map;
> -		};
> -
> -		rmtfs_mem: memory@f6301000 {
> -			compatible = "qcom,rmtfs-mem";
> -			reg = <0 0xf6301000 0 0x200000>;
> -			no-map;
> -
> -			qcom,client-id = <1>;
> -			qcom,vmid = <15>;
> -		};
> -	};
> -
> -	vreg_s4a_1p8: vreg-s4a-1p8 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vreg_s4a_1p8";
> -
> -		regulator-min-microvolt = <1800000>;
> -		regulator-max-microvolt = <1800000>;
> -		regulator-always-on;
> -	};
> -};
> -
> -&adsp_pas {
> -	status = "okay";
> -	firmware-name = "qcom/sdm845/beryllium/adsp.mbn";
> -};
> -
> -&apps_rsc {
> -	pm8998-rpmh-regulators {
> -		compatible = "qcom,pm8998-rpmh-regulators";
> -		qcom,pmic-id = "a";
> -
> -		vreg_l1a_0p875: ldo1 {
> -			regulator-min-microvolt = <880000>;
> -			regulator-max-microvolt = <880000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l5a_0p8: ldo5 {
> -			regulator-min-microvolt = <800000>;
> -			regulator-max-microvolt = <800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l7a_1p8: ldo7 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l12a_1p8: ldo12 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l13a_2p95: ldo13 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <2960000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l14a_1p8: ldo14 {
> -			regulator-min-microvolt = <1800000>;
> -			regulator-max-microvolt = <1800000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-boot-on;
> -			regulator-always-on;
> -		};
> -
> -		vreg_l17a_1p3: ldo17 {
> -			regulator-min-microvolt = <1304000>;
> -			regulator-max-microvolt = <1304000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l20a_2p95: ldo20 {
> -			regulator-min-microvolt = <2960000>;
> -			regulator-max-microvolt = <2968000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l21a_2p95: ldo21 {
> -			regulator-min-microvolt = <2960000>;
> -			regulator-max-microvolt = <2968000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l23a_3p3: ldo23 {
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3312000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l24a_3p075: ldo24 {
> -			regulator-min-microvolt = <3088000>;
> -			regulator-max-microvolt = <3088000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l25a_3p3: ldo25 {
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3312000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -		};
> -
> -		vreg_l26a_1p2: ldo26 {
> -			regulator-min-microvolt = <1200000>;
> -			regulator-max-microvolt = <1200000>;
> -			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> -			regulator-boot-on;
> -		};
> -	};
> -};
> -
> -&cdsp_pas {
> +&display_panel {
> +	compatible = "tianma,fhd-video";
>  	status = "okay";
> -	firmware-name = "qcom/sdm845/beryllium/cdsp.mbn";
> -};
> -
> -&dsi0 {
> -	status = "okay";
> -	vdda-supply = <&vreg_l26a_1p2>;
> -
> -	panel@0 {
> -		compatible = "tianma,fhd-video";
> -		reg = <0>;
> -		vddio-supply = <&vreg_l14a_1p8>;
> -		vddpos-supply = <&lab>;
> -		vddneg-supply = <&ibb>;
> -
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		backlight = <&pmi8998_wled>;
> -		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
> -
> -		port {
> -			tianma_nt36672a_in_0: endpoint {
> -				remote-endpoint = <&dsi0_out>;
> -			};
> -		};
> -	};
> -};
> -
> -&dsi0_out {
> -	remote-endpoint = <&tianma_nt36672a_in_0>;
> -	data-lanes = <0 1 2 3>;
> -};
> -
> -&dsi0_phy {
> -	status = "okay";
> -	vdds-supply = <&vreg_l1a_0p875>;
> -};
> -
> -&gcc {
> -	protected-clocks = <GCC_QSPI_CORE_CLK>,
> -			   <GCC_QSPI_CORE_CLK_SRC>,
> -			   <GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> -			   <GCC_LPASS_Q6_AXI_CLK>,
> -			   <GCC_LPASS_SWAY_CLK>;
> -};
> -
> -&gmu {
> -	status = "okay";
> -};
> -
> -&gpu {
> -	status = "okay";
> -
> -	zap-shader {
> -		memory-region = <&gpu_mem>;
> -		firmware-name = "qcom/sdm845/beryllium/a630_zap.mbn";
> -	};
> -};
> -
> -&ibb {
> -	regulator-min-microvolt = <4600000>;
> -	regulator-max-microvolt = <6000000>;
> -	regulator-over-current-protection;
> -	regulator-pull-down;
> -	regulator-soft-start;
> -	qcom,discharge-resistor-kohms = <300>;
> -};
> -
> -&lab {
> -	regulator-min-microvolt = <4600000>;
> -	regulator-max-microvolt = <6000000>;
> -	regulator-over-current-protection;
> -	regulator-pull-down;
> -	regulator-soft-start;
> -};
> -
> -&mdss {
> -	status = "okay";
> -};
> -
> -&mss_pil {
> -	status = "okay";
> -	firmware-name = "qcom/sdm845/beryllium/mba.mbn", "qcom/sdm845/beryllium/modem.mbn";
> -};
> -
> -&ipa {
> -	status = "okay";
> -	memory-region = <&ipa_fw_mem>;
> -	firmware-name = "qcom/sdm845/beryllium/ipa_fws.mbn";
> -};
> -
> -&pm8998_gpio {
> -	vol_up_pin_a: vol-up-active {
> -		pins = "gpio6";
> -		function = "normal";
> -		input-enable;
> -		bias-pull-up;
> -		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
> -	};
> -};
> -
> -&pmi8998_wled {
> -	status = "okay";
> -	qcom,current-boost-limit = <970>;
> -	qcom,ovp-millivolt = <29600>;
> -	qcom,current-limit-microamp = <20000>;
> -	qcom,num-strings = <2>;
> -	qcom,switching-freq = <600>;
> -	qcom,external-pfet;
> -	qcom,cabc;
> -};
> -
> -&pm8998_pon {
> -	resin {
> -		compatible = "qcom,pm8941-resin";
> -		interrupts = <0x0 0x8 1 IRQ_TYPE_EDGE_BOTH>;
> -		debounce = <15625>;
> -		bias-pull-up;
> -		linux,code = <KEY_VOLUMEDOWN>;
> -	};
> -};
> -
> -/* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
> -&q6afedai {
> -	qi2s@22 {
> -		reg = <22>;
> -		qcom,sd-lines = <0>;
> -	};
> -};
> -
> -&q6asmdai {
> -	dai@0 {
> -		reg = <0>;
> -	};
> -
> -	dai@1 {
> -		reg = <1>;
> -	};
> -
> -	dai@2 {
> -		reg = <2>;
> -	};
> -};
> -
> -&qupv3_id_0 {
> -	status = "okay";
> -};
> -
> -&sdhc_2 {
> -	status = "okay";
> -
> -	pinctrl-names = "default";
> -	pinctrl-0 = <&sdc2_default_state &sdc2_card_det_n>;
> -
> -	vmmc-supply = <&vreg_l21a_2p95>;
> -	vqmmc-supply = <&vreg_l13a_2p95>;
> -
> -	bus-width = <4>;
> -	cd-gpios = <&tlmm 126 GPIO_ACTIVE_HIGH>;
> -};
> -
> -&sound {
> -	compatible = "qcom,db845c-sndcard";
> -	pinctrl-0 = <&quat_mi2s_active
> -			&quat_mi2s_sd0_active>;
> -	pinctrl-names = "default";
> -	model = "Xiaomi Poco F1";
> -	audio-routing =
> -		"RX_BIAS", "MCLK",
> -		"AMIC1", "MIC BIAS1",
> -		"AMIC2", "MIC BIAS2",
> -		"AMIC3", "MIC BIAS3";
> -
> -	mm1-dai-link {
> -		link-name = "MultiMedia1";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA1>;
> -		};
> -	};
> -
> -	mm2-dai-link {
> -		link-name = "MultiMedia2";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA2>;
> -		};
> -	};
> -
> -	mm3-dai-link {
> -		link-name = "MultiMedia3";
> -		cpu {
> -			sound-dai = <&q6asmdai  MSM_FRONTEND_DAI_MULTIMEDIA3>;
> -		};
> -	};
> -
> -	slim-dai-link {
> -		link-name = "SLIM Playback";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_RX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai =  <&wcd9340 0>;
> -		};
> -	};
> -
> -	slimcap-dai-link {
> -		link-name = "SLIM Capture";
> -		cpu {
> -			sound-dai = <&q6afedai SLIMBUS_0_TX>;
> -		};
> -
> -		platform {
> -			sound-dai = <&q6routing>;
> -		};
> -
> -		codec {
> -			sound-dai = <&wcd9340 1>;
> -		};
> -	};
> -};
> -
> -&tlmm {
> -	gpio-reserved-ranges = <0 4>, <81 4>;
> -
> -	sdc2_default_state: sdc2-default {
> -		clk {
> -			pins = "sdc2_clk";
> -			bias-disable;
> -			drive-strength = <16>;
> -		};
> -
> -		cmd {
> -			pins = "sdc2_cmd";
> -			bias-pull-up;
> -			drive-strength = <10>;
> -		};
> -
> -		data {
> -			pins = "sdc2_data";
> -			bias-pull-up;
> -			drive-strength = <10>;
> -		};
> -	};
> -
> -	sdc2_card_det_n: sd-card-det-n {
> -		pins = "gpio126";
> -		function = "gpio";
> -		bias-pull-up;
> -	};
> -
> -	wcd_intr_default: wcd_intr_default {
> -		pins = <54>;
> -		function = "gpio";
> -
> -		input-enable;
> -		bias-pull-down;
> -		drive-strength = <2>;
> -	};
> -};
> -
> -&uart6 {
> -	status = "okay";
> -
> -	bluetooth {
> -		compatible = "qcom,wcn3990-bt";
> -
> -		vddio-supply = <&vreg_s4a_1p8>;
> -		vddxo-supply = <&vreg_l7a_1p8>;
> -		vddrf-supply = <&vreg_l17a_1p3>;
> -		vddch0-supply = <&vreg_l25a_3p3>;
> -		max-speed = <3200000>;
> -	};
> -};
> -
> -&ufs_mem_hc {
> -	status = "okay";
> -
> -	reset-gpios = <&tlmm 150 GPIO_ACTIVE_LOW>;
> -
> -	vcc-supply = <&vreg_l20a_2p95>;
> -	vcc-max-microamp = <800000>;
> -};
> -
> -&ufs_mem_phy {
> -	status = "okay";
> -
> -	vdda-phy-supply = <&vreg_l1a_0p875>;
> -	vdda-pll-supply = <&vreg_l26a_1p2>;
> -};
> -
> -&usb_1 {
> -	status = "okay";
> -};
> -
> -&usb_1_dwc3 {
> -	dr_mode = "peripheral";
> -};
> -
> -&usb_1_hsphy {
> -	status = "okay";
> -
> -	vdd-supply = <&vreg_l1a_0p875>;
> -	vdda-pll-supply = <&vreg_l12a_1p8>;
> -	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
> -
> -	qcom,imp-res-offset-value = <8>;
> -	qcom,hstx-trim-value = <QUSB2_V2_HSTX_TRIM_21_6_MA>;
> -	qcom,preemphasis-level = <QUSB2_V2_PREEMPHASIS_5_PERCENT>;
> -	qcom,preemphasis-width = <QUSB2_V2_PREEMPHASIS_WIDTH_HALF_BIT>;
> -};
> -
> -&usb_1_qmpphy {
> -	status = "okay";
> -
> -	vdda-phy-supply = <&vreg_l26a_1p2>;
> -	vdda-pll-supply = <&vreg_l1a_0p875>;
> -};
> -
> -&venus {
> -	status = "okay";
> -	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
> -};
> -
> -&wcd9340{
> -	pinctrl-0 = <&wcd_intr_default>;
> -	pinctrl-names = "default";
> -	clock-names = "extclk";
> -	clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
> -	reset-gpios = <&tlmm 64 0>;
> -	vdd-buck-supply = <&vreg_s4a_1p8>;
> -	vdd-buck-sido-supply = <&vreg_s4a_1p8>;
> -	vdd-tx-supply = <&vreg_s4a_1p8>;
> -	vdd-rx-supply = <&vreg_s4a_1p8>;
> -	vdd-io-supply = <&vreg_s4a_1p8>;
> -	qcom,micbias1-microvolt = <2700000>;
> -	qcom,micbias2-microvolt = <1800000>;
> -	qcom,micbias3-microvolt = <2700000>;
> -	qcom,micbias4-microvolt = <2700000>;
> -};
> -
> -&wifi {
> -	status = "okay";
> -
> -	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
> -	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
> -	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
> -	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
> -	vdd-3.3-ch1-supply = <&vreg_l23a_3p3>;
> -};
> -
> -/* PINCTRL - additions to nodes defined in sdm845.dtsi */
> -
> -&qup_uart6_default {
> -	pinmux {
> -		pins = "gpio45", "gpio46", "gpio47", "gpio48";
> -		function = "qup6";
> -	};
> -
> -	cts {
> -		pins = "gpio45";
> -		bias-disable;
> -	};
> -
> -	rts-tx {
> -		pins = "gpio46", "gpio47";
> -		drive-strength = <2>;
> -		bias-disable;
> -	};
> -
> -	rx {
> -		pins = "gpio48";
> -		bias-pull-up;
> -	};
>  };
> -- 
> 2.37.1
> 
