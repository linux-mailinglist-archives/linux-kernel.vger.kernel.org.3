Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CAC48D64B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiAMLFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 06:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbiAMLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:05:18 -0500
Received: from relay07.th.seeweb.it (relay07.th.seeweb.it [IPv6:2001:4b7a:2000:18::168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109CAC06173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 03:05:18 -0800 (PST)
Received: from [192.168.1.101] (83.6.165.232.neoplus.adsl.tpnet.pl [83.6.165.232])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 5EB493E7CC;
        Thu, 13 Jan 2022 12:05:14 +0100 (CET)
Message-ID: <6e1affb2-c4fe-568c-38d2-bcfd3bd3c437@somainline.org>
Date:   Thu, 13 Jan 2022 12:05:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] arm64: dts: qcom: Initial Xiaomi Mi 9 support (cepheus)
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20220107025910.112425-1-alexeymin@postmarketos.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220107025910.112425-1-alexeymin@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.01.2022 03:59, Alexey Minnekhanov wrote:
> Add initial support for Xiaomi Mi 9 smartphone, based on
> Qualcomm SM8150 (Snapdragon 855) chipset.
> 
> Currently the following features are supported:
>  * reserved-memory map
>  * debug UART
>  * display using simple-framebuffer
>  * physical keys: power, volume up/down, AI key
>  * reboot modes
>  * regulator voltages
>  * USB peripheral mode
> 
> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
> ---

[..]


> +++ b/arch/arm64/boot/dts/qcom/sm8150-xiaomi-cepheus.dts
Is there a shared xiaomi 8150/8150+/8150++(860) platform btw?

It seems like they release a new device each week, so there may be
some nice potential to commonize it in the future :D


> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2021, Alexey Minnekhanov <alexeymin@postmarketos.org>
22


> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
gpio.h can be moved to sm8150.dtsi


> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +#include "sm8150.dtsi"
> +#include "pm8150.dtsi"
> +#include "pm8150b.dtsi"
> +#include "pm8150l.dtsi"
> +
> +/*
> + * Rewrite reserved memory maps inherited from sm8150.dtsi to match the ones
> + * used on xiaomi-cepheus.
> + * Note: this list is ordered by its memory address in sm8150.dtsi.
> + */
> +/delete-node/ &tz_mem;      /* same address but larger, no place for rmtfs_mem! */
> +/delete-node/ &rmtfs_mem;   /* moved to completely different address */
> +/delete-node/ &adsp_mem;    /* same start address, but larger size */
> +/delete-node/ &mpss_mem;    /* same size, shifted higher, due to larger adsp_mem */
> +/delete-node/ &venus_mem;   /* same size, shifted higher */
> +/delete-node/ &slpi_mem;    /* same size, shifted higher */
> +/delete-node/ &ipa_fw_mem;  /* same size, shifted higher */
> +/delete-node/ &ipa_gsi_mem; /* same size, shifted higher */
> +/delete-node/ &gpu_mem;     /* same size, shifted higher */
> +/delete-node/ &spss_mem;    /* same size, shifted higher */
> +/delete-node/ &cdsp_mem;    /* same size, shifted higher */
> +
> +/ {
> +	model = "Xiaomi Mi 9";
> +	compatible = "xiaomi,cepheus", "qcom,sm8150";
> +
> +	aliases {
> +		serial0 = &uart2;
> +		display0 = &framebuffer;
> +	};
> +
> +	chosen {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		stdout-path = "serial0:115200n8";
> +
> +		framebuffer: framebuffer@9c000000 {
> +			compatible = "simple-framebuffer";
> +			reg = <0 0x9c000000 0 0x2300000>;
> +			width = <1080>;
> +			height = <2340>;
> +			stride = <(1080 * 4)>;
> +			format = "a8r8g8b8";
> +			/*
> +			 * That's (going to be) a lot of clocks, but it's necessary due
> +			 * to unused clk cleanup & no panel driver yet (& no dispcc either)..
> +			 */
> +			clocks = <&gcc GCC_DISP_HF_AXI_CLK>,
> +				 <&gcc GCC_DISP_SF_AXI_CLK>;
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ai_key_pin_a &vol_up_pin_a>;
> +
> +		vol_up {
> +			label = "volume_up";
> +			gpios = <&pm8150_gpios 6 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_KEY>;
> +			linux,code = <KEY_VOLUMEUP>;
> +			wakeup-source;
> +			debounce-interval = <15>;
> +		};
> +
> +		ai_key {
> +			label = "ai_key";
> +			gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +			linux,input-type = <EV_KEY>;
> +			linux,code = <KEY_HOMEPAGE>; /* no AI key in Linux */
On Xperias with an additional button I set it to KEY_LEFTMETA for tiling WMs, maybe that could home in handy?
No pressure though

> +			wakeup-source;
> +			debounce-interval = <39>;
> +		};
> +	};
> +
> +	reserved-memory {
> +		tz_mem: memory@86200000 {
> +			no-map;
> +			reg = <0x0 0x86200000 0x0 0x5500000>;
> +			phandle = <0x594>;
Phandle properties are generated by dtc at compile time, this is probably a leftover
from copying the decompiled dtb, also please move no-map below reg consistently in all nodes.


[..]

> +
> +	vdd_boost_vreg: vdd-boost-regulator {
> +		compatible = "regulator-fixed";
This regulator should have a voltage range specified.


> +		regulator-name = "vdd_boost_vreg";
> +		startup-delay-us = <4000>;
> +		enable-active-high;
> +		regulator-always-on;
> +		gpio = <&pm8150b_gpios 5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vdd_boost_en_pin>;
> +	};
> +

[..]


> +&apps_rsc {
> +	pm8150-rpmh-regulators {
> +		compatible = "qcom,pm8150-rpmh-regulators";
> +		qcom,pmic-id = "a";
> +
> +		vdd-s1-supply = <&vph_pwr>;
> +		vdd-s2-supply = <&vph_pwr>;
> +		vdd-s3-supply = <&vph_pwr>;
> +		vdd-s4-supply = <&vph_pwr>;
> +		vdd-s5-supply = <&vph_pwr>;
> +		vdd-s6-supply = <&vph_pwr>;
> +		vdd-s7-supply = <&vph_pwr>;
> +		vdd-s8-supply = <&vph_pwr>;
> +		vdd-s9-supply = <&vph_pwr>;
> +		vdd-s10-supply = <&vph_pwr>;
> +
> +		vdd-l1-l8-l11-supply = <&vreg_s6a_0p9>;
> +		vdd-l2-l10-supply = <&vreg_bob>;
> +		vdd-l3-l4-l5-l18-supply = <&vreg_s6a_0p9>;
> +		vdd-l6-l9-supply = <&vreg_s8c_1p3>;
> +		vdd-l7-l12-l14-l15-supply = <&vreg_s5a_1p9>;
> +		vdd-l13-l16-l17-supply = <&vreg_bob>;
> +
> +		vreg_s2a_0p6: smps2 {
> +			regulator-min-microvolt = <600000>;
> +			regulator-max-microvolt = <600000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_s2a_0p6";
> +		};
> +
> +		vreg_s5a_1p9: smps5 {
> +			regulator-min-microvolt = <1904000>;
> +			regulator-max-microvolt = <2040000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_s5a_0p6";
> +		};
> +
> +		vreg_s6a_0p9: smps6 {
> +			regulator-min-microvolt = <920000>;
> +			regulator-max-microvolt = <1128000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_s6a_0p9";
> +		};
> +
> +		vreg_l1a_0p75: ldo1 {
> +			regulator-min-microvolt = <752000>;
> +			regulator-max-microvolt = <752000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_l1a_0p75";
> +		};
> +
> +		vreg_l2a_3p1: ldo2 {
> +			regulator-min-microvolt = <3072000>;
> +			regulator-max-microvolt = <3072000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_l2a_3p1";
> +		};
> +
> +		vreg_l3a_0p8: ldo3 {
> +			regulator-min-microvolt = <480000>;
> +			regulator-max-microvolt = <932000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_l3a_0p8";
0p8 seems weird considering the voltage range..

> +		};
> +
> +		vreg_l5a_0p875: ldo5 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <880000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_l5a_0p875";
definitely 0p88


> +
> +		vreg_l18a_0p8: ldo18 {
> +			regulator-min-microvolt = <880000>;
> +			regulator-max-microvolt = <912000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150_l18a_0p8";
and here 0p88 too


[..]


> +
> +		vreg_s8c_1p3: smps8 {
> +			regulator-min-microvolt = <1352000>;
> +			regulator-max-microvolt = <1352000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_s8c_1p3";
1p35 unless it's voted otherwise


> +		};
> +
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l1c_1p8";
> +		};
> +
> +		vreg_l2c_1p3: ldo2 {
> +			regulator-min-microvolt = <1304000>;
> +			regulator-max-microvolt = <1304000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l2c_1p3";
> +		};
> +
> +		vreg_l3c_1p2: ldo3 {
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l3c_1p2";
> +		};
> +
> +		vreg_l4c_1p8: ldo4 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <2928000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l4c_1p8";
Again, 1p8 seems weird unless it's always voted to be 1p8


> +		};
> +
> +		vreg_l5c_1p8: ldo5 {
> +			regulator-min-microvolt = <1704000>;
> +			regulator-max-microvolt = <2928000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l5c_1p8";
> +		};
ditto


> +
> +		vreg_l6c_2p9: ldo6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-name = "pm8150l_l6c_2p9";
> +		};
> +
> +		vreg_l7c_3p0: ldo7 {
> +			regulator-min-microvolt = <2856000>;
> +			regulator-max-microvolt = <3104000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l7c_3p0";
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-name = "pm8150l_l8c_1p8";
> +		};
> +
> +		vreg_l9c_2p9: ldo9 {
> +			regulator-min-microvolt = <2704000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +			regulator-allow-set-load;
> +			regulator-name = "pm8150l_l9c_2p9";
Again, weird unless it's voted otherwise



Btw, do we really want to name voltage lines on phones to sound like they are taken
out of a Dragonboard schematic without having the knowledge about the engineering behind it?

Well uh, unless somebody does actually have this knowledge of course..


> +&tlmm {
> +	/* gpios 0..3 are NFC spi, gpios 126..129 are FP spi */
Since I'm asking you for changes already, I may as well ask you to capitalize SPI..
Also, is the entire NFC chip wired via SPI or only the Secure Element (SE)?


> +	gpio-reserved-ranges = <0 4>, <126 4>;
> +
> +	ai_key_pin_a: ai-key-pin-active {
> +		pins = "gpio97";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-pull-up;
> +		input-enable;
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	snps,has-lpm-erratum;
> +	snps,hird-threshold = /bits/ 8 <0x10>;
Looks like these two properties are set SoC-wide on 4.14


> +	maximum-speed = "high-speed";
Shame, Xiaomi :(


> +	dr_mode = "peripheral";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +	vdda-pll-supply = <&vreg_l5a_0p875>;
> +	vdda18-supply = <&vreg_l12a_1p8>;
> +	vdda33-supply = <&vreg_l2a_3p1>;
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +	vdda-phy-supply = <&vreg_l3c_1p2>;
> +	vdda-pll-supply = <&vreg_l5a_0p875>;
> +};
> 


Konrad
