Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83AE84964B2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351874AbiAUSAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:00:39 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:37521 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241924AbiAUSAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:00:38 -0500
Received: from [192.168.1.101] (abxi173.neoplus.adsl.tpnet.pl [83.9.2.173])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DF4E93F46F;
        Fri, 21 Jan 2022 19:00:34 +0100 (CET)
Message-ID: <ab57f88c-8473-2499-afa6-86bcf639ca32@somainline.org>
Date:   Fri, 21 Jan 2022 19:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sc7280: Add herobrine-r1
Content-Language: en-US
To:     Douglas Anderson <dianders@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     quic_rjendra@quicinc.com, sibis@codeaurora.org,
        kgodara1@codeaurora.org, mka@chromium.org, swboyd@chromium.org,
        pmaliset@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220114004303.905808-1-dianders@chromium.org>
 <20220113164233.4.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <20220113164233.4.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!


Your DTs look good, but incorporate some weird style decisions..

On 14.01.2022 01:43, Douglas Anderson wrote:
> Add the new herobrine-r1. Note that this is pretty much a re-design
> compared to herobrine-r0 so we don't attempt any dtsi to share stuff
> between them.
> 
> This patch attempts to define things at 3 levels:
> 
> 1. The Qcard level. Herobrine includes a Qcard PCB and the Qcard PCB
>    is supposed to be the same (modulo stuffing options) across
>    multiple boards, so trying to define what's there hopefully makes
>    sense. NOTE that newer "CRD" boards from Qualcomm also use
>    Qcard. When support for CRD3 is added hopefully it can use the
>    Qcard include (and perhaps we should even evaluate it using
>    herobrine.dtsi?)
> 2. The herobrine "baseboard" level. Right now most stuff is here with
>    the exception of things that we _know_ will be different per
>    board. We know that not all boards will have the same set of eMMC,
>    nvme, and SD. We also know that the exact pin names are likely to
>    be different.
> 3. The actual "board" level, AKA herobrine-rev1.
> 
> NOTES:
> - This boots to command prompt, but no eDP yet since eDP hasn't
>   been added to sc7280.dtsi yet.
> - This assumes LTE for now. Once it's clear how WiFi-only SKUs will
>   work we expect some small changes.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> 
>  arch/arm64/boot/dts/qcom/Makefile             |   1 +
>  .../qcom/sc7280-herobrine-herobrine-r0.dts    |   2 +-
>  .../qcom/sc7280-herobrine-herobrine-r1.dts    | 314 +++++++
>  .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 781 ++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    | 557 +++++++++++++
>  5 files changed, 1654 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 9db743826391..54998e108092 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -83,6 +83,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-pompom-r3-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= sc7280-crd.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
> index 67680a13c234..dcd10d0ead1e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r0.dts
> @@ -26,7 +26,7 @@
>  
>  / {
>  	model = "Google Herobrine (rev0)";
> -	compatible = "google,herobrine",
> +	compatible = "google,herobrine-rev0",
>  		     "qcom,sc7280";
Why break the line here?


>  };
>  
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> new file mode 100644
> index 000000000000..c57bd689df23
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -0,0 +1,314 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/dts-v1/;
> +
> +#include "sc7280-herobrine.dtsi"
> +
> +/ {
> +	model = "Google Herobrine (rev1+)";
Are you sure there won't be any changes significant enough in the future
that will make rev2 or rev7 or rev8192 incompatible with the rev1+ DT?


> +	compatible = "google,herobrine",
> +		     "qcom,sc7280";
Why break the line here?

> +};
> +
> +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
This is superfluous at best.


> +
> +&ap_spi_fp {
> +	status = "okay";
> +};
> +
> +/*
> + * Although the trackpad is really part of the herobrine baseboard, we'll
> + * put the actual definition in the board device tree since different boards
> + * might hook up different trackpads (or no i2c trackpad at all in the case
> + * of tablets / detachables).
> + */
> +ap_tp_i2c: &i2c0 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	trackpad: trackpad@15 {
> +		compatible = "elan,ekth3000";
> +		reg = <0x15>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&tp_int_odl>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> +
> +		vcc-supply = <&pp3300_z1>;
> +
> +		wakeup-source;
> +	};
> +};
> +
> +/*
> + * The touchscreen connector might come off the Qcard, at least in the case of
> + * eDP. Like the trackpad, we'll put it in the board device tree file since
> + * different boards have different touchscreens.
> + */
> +ts_i2c: &i2c13 {
Either sort these by their i2c aliases, or by their new ones.. currently it is
not alphabetically sorted at all.. 

Looks like some nodes below are just thrown at random places too..


> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	ap_ts: touchscreen@5c {
> +		compatible = "hid-over-i2c";
> +		reg = <0x5c>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
> +
> +		post-power-on-delay-ms = <500>;
> +		hid-descr-addr = <0x0000>;
> +
> +		vdd-supply = <&ts_avdd>;
> +	};
> +};
> +
> +/* For nvme */
> +&pcie1 {
> +	status = "okay";
> +};
> +
> +/* For nvme */
I think this is kind of obvious and there is no need for this to be said twice
within 10 lines..


> +&pcie1_phy {
> +	status = "okay";
> +};
> +
> +/* For eMMC */
> +&sdhc_1 {
> +	status = "okay";
> +};
> +
> +/* For SD Card */
> +&sdhc_2 {
> +	status = "okay";
> +};
> +
> +/* PINCTRL - BOARD-SPECIFIC */
This is also kind of obvious, if it wasn't board-specific, it wouldn't be in the
board DT..


> +
> +/*
> + * Methodology for gpio-line-names:
> + * - If a pin goes to herobrine board and is named it gets that name.
> + * - If a pin goes to herobrine board and is not named, it gets no name.
> + * - If a pin is totally internal to Qcard then it gets Qcard name.
> + * - If a pin is not hooked up on Qcard, it gets no name.
> + */
> +
> +&pm8350c_gpios {
> +	gpio-line-names = "FLASH_STROBE_1",		/* 1 */
> +			  "AP_SUSPEND",
> +			  "PM8008_1_RST_N",
> +			  "",
> +			  "",
> +			  "",
> +			  "PMIC_EDP_BL_EN",
> +			  "PMIC_EDP_BL_PWM",
> +			  "";
> +};
> +
> +&tlmm {
> +	gpio-line-names = "AP_TP_I2C_SDA",		/* 0 */
> +			  "AP_TP_I2C_SCL",
> +			  "SSD_RST_L",
> +			  "PE_WAKE_ODL",
> +			  "AP_SAR_SDA",
> +			  "AP_SAR_SCL",
> +			  "PRB_SC_GPIO_6",
> +			  "TP_INT_ODL",
> +			  "HP_I2C_SDA",
> +			  "HP_I2C_SCL",
> +
> +			  "GNSS_L1_EN",			/* 10 */
> +			  "GNSS_L5_EN",
> +			  "SPI_AP_MOSI",
> +			  "SPI_AP_MISO",
> +			  "SPI_AP_CLK",
> +			  "SPI_AP_CS0_L",
> +			  /*
> +			   * AP_FLASH_WP is crossystem ABI. Schematics
> +			   * call it BIOS_FLASH_WP_OD.
> +			   */
Is there a need to put this comment on 4 lines instead of a single one?


> +			  "AP_FLASH_WP",
> +			  "",
> +			  "AP_EC_INT_L",
> +			  "",
> +
> +			  "UF_CAM_RST_L",		/* 20 */
> +			  "WF_CAM_RST_L",
> +			  "UART_AP_TX_DBG_RX",
> +			  "UART_DBG_TX_AP_RX",
> +			  "",
> +			  "PM8008_IRQ_1",
> +			  "HOST2WLAN_SOL",
> +			  "WLAN2HOST_SOL",
> +			  "MOS_BT_UART_CTS",
> +			  "MOS_BT_UART_RFR",
> +
> +			  "MOS_BT_UART_TX",		/* 30 */
> +			  "MOS_BT_UART_RX",
> +			  "PRB_SC_GPIO_32",
> +			  "HUB_RST_L",
> +			  "",
> +			  "",
> +			  "AP_SPI_FP_MISO",
> +			  "AP_SPI_FP_MOSI",
> +			  "AP_SPI_FP_CLK",
> +			  "AP_SPI_FP_CS_L",
> +
> +			  "AP_EC_SPI_MISO",		/* 40 */
> +			  "AP_EC_SPI_MOSI",
> +			  "AP_EC_SPI_CLK",
> +			  "AP_EC_SPI_CS_L",
> +			  "LCM_RST_L",
> +			  "EARLY_EUD_N",
> +			  "",
> +			  "DP_HOT_PLUG_DET",
> +			  "IO_BRD_MLB_ID0",
> +			  "IO_BRD_MLB_ID1",
> +
> +			  "IO_BRD_MLB_ID2",		/* 50 */
> +			  "SSD_EN",
> +			  "TS_I2C_SDA_CONN",
> +			  "TS_I2C_CLK_CONN",
> +			  "TS_RST_CONN",
> +			  "TS_INT_CONN",
> +			  "AP_I2C_TPM_SDA",
> +			  "AP_I2C_TPM_SCL",
> +			  "PRB_SC_GPIO_58",
> +			  "PRB_SC_GPIO_59",
> +
> +			  "EDP_HOT_PLUG_DET_N",		/* 60 */
> +			  "FP_TO_AP_IRQ_L",
> +			  "",
> +			  "AMP_EN",
> +			  "CAM0_MCLK_GPIO_64",
> +			  "CAM1_MCLK_GPIO_65",
> +			  "WF_CAM_MCLK",
> +			  "PRB_SC_GPIO_67",
> +			  "FPMCU_BOOT0",
> +			  "UF_CAM_SDA",
> +
> +			  "UF_CAM_SCL",			/* 70 */
> +			  "",
> +			  "",
> +			  "WF_CAM_SDA",
> +			  "WF_CAM_SCL",
> +			  "",
> +			  "",
> +			  "EN_FP_RAILS",
> +			  "FP_RST_L",
> +			  "PCIE1_CLKREQ_ODL",
> +
> +			  "EN_PP3300_DX_EDP",		/* 80 */
> +			  "SC_GPIO_81",
> +			  "FORCED_USB_BOOT",
> +			  "WCD_RESET_N",
> +			  "MOS_WLAN_EN",
> +			  "MOS_BT_EN",
> +			  "MOS_SW_CTRL",
> +			  "MOS_PCIE0_RST",
> +			  "MOS_PCIE0_CLKREQ_N",
> +			  "MOS_PCIE0_WAKE_N",
> +
> +			  "MOS_LAA_AS_EN",		/* 90 */
> +			  "SD_CD_ODL",
> +			  "",
> +			  "",
> +			  "MOS_BT_WLAN_SLIMBUS_CLK",
> +			  "MOS_BT_WLAN_SLIMBUS_DAT0",
> +			  "HP_MCLK",
> +			  "HP_BCLK",
> +			  "HP_DOUT",
> +			  "HP_DIN",
> +
> +			  "HP_LRCLK",			/* 100 */
> +			  "HP_IRQ",
> +			  "",
> +			  "",
> +			  "GSC_AP_INT_ODL",
> +			  "EN_PP3300_CODEC",
> +			  "AMP_BCLK",
> +			  "AMP_DIN",
> +			  "AMP_LRCLK",
> +			  "UIM1_DATA_GPIO_109",
> +
> +			  "UIM1_CLK_GPIO_110",		/* 110 */
> +			  "UIM1_RESET_GPIO_111",
> +			  "PRB_SC_GPIO_112",
> +			  "UIM0_DATA",
> +			  "UIM0_CLK",
> +			  "UIM0_RST",
> +			  "UIM0_PRESENT_ODL",
> +			  "SDM_RFFE0_CLK",
> +			  "SDM_RFFE0_DATA",
> +			  "WF_CAM_EN",
> +
> +			  "FASTBOOT_SEL_0",		/* 120 */
> +			  "SC_GPIO_121",
> +			  "FASTBOOT_SEL_1",
> +			  "SC_GPIO_123",
> +			  "FASTBOOT_SEL_2",
> +			  "SM_RFFE4_CLK_GRFC_8",
> +			  "SM_RFFE4_DATA_GRFC_9",
> +			  "WLAN_COEX_UART1_RX",
> +			  "WLAN_COEX_UART1_TX",
> +			  "PRB_SC_GPIO_129",
> +
> +			  "LCM_ID0",			/* 130 */
> +			  "LCM_ID1",
> +			  "",
> +			  "SDR_QLINK_REQ",
> +			  "SDR_QLINK_EN",
> +			  "QLINK0_WMSS_RESET_N",
> +			  "SMR526_QLINK1_REQ",
> +			  "SMR526_QLINK1_EN",
> +			  "SMR526_QLINK1_WMSS_RESET_N",
> +			  "PRB_SC_GPIO_139",
> +
> +			  "SAR1_IRQ_ODL",		/* 140 */
> +			  "SAR0_IRQ_ODL",
> +			  "PRB_SC_GPIO_142",
> +			  "",
> +			  "WCD_SWR_TX_CLK",
> +			  "WCD_SWR_TX_DATA0",
> +			  "WCD_SWR_TX_DATA1",
> +			  "WCD_SWR_RX_CLK",
> +			  "WCD_SWR_RX_DATA0",
> +			  "WCD_SWR_RX_DATA1",
> +
> +			  "DMIC01_CLK",			/* 150 */
> +			  "DMIC01_DATA",
> +			  "DMIC23_CLK",
> +			  "DMIC23_DATA",
> +			  "",
> +			  "",
> +			  "EC_IN_RW_ODL",
> +			  "HUB_EN",
> +			  "WCD_SWR_TX_DATA2",
> +			  "",
> +
> +			  "",				/* 160 */
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +
> +			  "",				/* 170 */
> +			  "MOS_BLE_UART_TX",
> +			  "MOS_BLE_UART_RX",
> +			  "",
> +			  "",
> +			  "";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> new file mode 100644
> index 000000000000..157da25cc5a8
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> @@ -0,0 +1,781 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine baseboard device tree source
> + *
> + * The set of things in this file is a bit loosely defined. It's roughly
> + * defined as the set of things that the child boards happen to have in
> + * common. Since all of the child boards started from the same original
> + * design this is hopefully a large set of things but as more derivatives
> + * appear things may "bubble down" out of this file. For things that are
> + * part of the reference design but might not exist on child nodes we will
> + * follow the lead of the SoC dtsi files and leave their status as "disabled".
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
Factoring gpio.h out into the SoC DT is a good idea.


> +#include <dt-bindings/input/gpio-keys.h>
> +#include <dt-bindings/input/input.h>
> +
> +#include "sc7280-qcard.dtsi"
> +#include "sc7280-chrome-common.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	/*
> +	 * FIXED REGULATORS
> +	 *
> +	 * Sort order:
> +	 * 1. parents above children.
> +	 * 2. higher voltage above lower voltage.
> +	 * 3. alphabetically by node name.
Why not just alphabetically? These regulator-fixed nodes shouldn't
have issues with probe order and their parent-child relations are
specified in their properties.

> +	 */
> +
> +	/* This is the top level supply and variable voltage */
Is there a way to read out the voltage somehow, perhaps as a TODO for the future
if a driver is needed? I think the regulator framework used not to be very happy
about not specifying a (fixed) voltage range on a fixed regulator, but I may be
wrong..


> +	ppvar_sys: ppvar-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "ppvar_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	/* This divides ppvar_sys by 2, so voltage is variable */
> +	src_vph_pwr: src-vph-pwr-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "src_vph_pwr";
> +
> +		/* EC turns on with switchcap_on; always on for AP */
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	pp5000_s5: pp5000-s5-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp5000_s5";
> +
> +		/* EC turns on with en_pp5000_s5; always on for AP */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	pp3300_z1: pp3300-z1-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_z1";
> +
> +		/* EC turns on with en_pp3300_z1; always on for AP */
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		vin-supply = <&ppvar_sys>;
> +	};
> +
> +	pp3300_codec: pp3300-codec-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_codec";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 105 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp3300_codec>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp3300_left_in_mlb: pp3300-left-in-mlb {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_left_in_mlb";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 80 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_pp3300_dx_edp>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp3300_mcu_fp:
> +	pp3300_fp_ls:
> +	pp3300_fp_mcu: pp3300-fp-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_fp";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +
> +		/*
> +		 * WARNING: it is intentional that GPIO 77 isn't listed here.
> +		 * The userspace script for updating the fingerprint firmware
> +		 * needs to control the FP regulators during a FW update,
> +		 * hence the signal can't be owned by the kernel regulator.
> +		 */
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_fp_rails>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp3300_hub: pp3300-hub-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_hub";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +
> +		gpio = <&tlmm 157 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hub_en>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp3300_tp: pp3300-tp-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_tp";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		/* AP turns on with PP1800_L18B_S0; always on for AP */
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp3300_ssd: pp3300-ssd {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp3300_ssd";
> +
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ssd_en>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp2850_vcm_wf_cam: pp2850-vcm-wf-cam {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp2850_vcm_wf_cam";
> +
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +
> +		gpio = <&tlmm 119 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wf_cam_en>;
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp2850_wf_cam: pp2850-wf-cam {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp2850_wf_cam";
> +
> +		regulator-min-microvolt = <2850000>;
> +		regulator-max-microvolt = <2850000>;
> +
> +		gpio = <&tlmm 119 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * The pinconf can only be referenced once so we put it on the
> +		 * first regulator and comment it out here.
> +		 *
> +		 * pinctrl-names = "default";
> +		 * pinctrl-0 = <&wf_cam_en>;
> +		 */
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	pp1800_fp: pp1800-fp-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_fp";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		regulator-boot-on;
> +		regulator-always-on;
> +
> +		/*
> +		 * WARNING: it is intentional that GPIO 77 isn't listed here.
> +		 * The userspace script for updating the fingerprint firmware
> +		 * needs to control the FP regulators during a FW update,
> +		 * hence the signal can't be owned by the kernel regulator.
> +		 */
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&en_fp_rails>;
> +
> +		vin-supply = <&pp1800_l18b_s0>;
> +		status = "disabled";
> +	};
> +
> +	pp1800_wf_cam: pp1800-wf-cam {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1800_wf_cam";
> +
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +
> +		gpio = <&tlmm 119 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * The pinconf can only be referenced once so we put it on the
> +		 * first regulator and comment it out here.
> +		 *
> +		 * pinctrl-names = "default";
> +		 * pinctrl-0 = <&wf_cam_en>;
> +		 */
> +
> +		vin-supply = <&vreg_l19b_s0>;
> +	};
> +
> +	pp1200_wf_cam: pp1200-wf-cam {
> +		compatible = "regulator-fixed";
> +		regulator-name = "pp1200_wf_cam";
> +
> +		regulator-min-microvolt = <1200000>;
> +		regulator-max-microvolt = <1200000>;
> +
> +		gpio = <&tlmm 119 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +		/*
> +		 * The pinconf can only be referenced once so we put it on the
> +		 * first regulator and comment it out here.
> +		 *
> +		 * pinctrl-names = "default";
> +		 * pinctrl-0 = <&wf_cam_en>;
> +		 */
> +
> +		vin-supply = <&pp3300_z1>;
> +	};
> +
> +	/* BOARD-SPECIFIC TOP LEVEL NODES */
Again, seems superfluous.


> +
> +	pwmleds {
> +		compatible = "pwm-leds";
> +		status = "disabled";
If it's disabled and it's not enabled anywhere else, why is it here?
Is it going to have users in a very near future?


> +		keyboard_backlight: keyboard-backlight {
> +			status = "disabled";
> +			label = "cros_ec::kbd_backlight";
> +			pwms = <&cros_ec_pwm 0>;
> +			max-brightness = <1023>;
> +		};
> +	};
> +};
> +
> +/*
> + * BOARD-LOCAL NAMES FOR REGULATORS THAT CONNECT TO QCARD
> + *
> + * Names are only listed here if regulators go somewhere other than a
> + * testpoint.
> + */
> +
> +/* From Qcard to our board; ordered by PMIC-ID / rail number */
> +
> +pp1256_s8b: &vreg_s8b_1p256 {};
> +
> +pp1800_l18b_s0: &vreg_l18b_1p8 {};
> +pp1800_l18b:    &vreg_l18b_1p8 {};
> +
> +vreg_l19b_s0: &vreg_l19b_1p8 {};
> +
> +pp1800_alc5682: &vreg_l2c_1p8 {};
> +pp1800_l2c:     &vreg_l2c_1p8 {};
> +
> +vreg_l4c: &vreg_l4c_1p8_3p0 {};
> +
> +ppvar_l6c: &vreg_l6c_2p96 {};
> +
> +pp3000_l7c: &vreg_l7c_3p0 {};
> +
> +pp1800_prox: &vreg_l8c_1p8 {};
> +pp1800_l8c:  &vreg_l8c_1p8 {};
> +
> +pp2950_l9c: &vreg_l9c_2p96 {};
> +
> +pp1800_lcm:  &vreg_l12c_1p8 {};
> +pp1800_mipi: &vreg_l12c_1p8 {};
> +pp1800_l12c: &vreg_l12c_1p8 {};
> +
> +pp3300_lcm:  &vreg_l13c_3p0 {};
> +pp3300_mipi: &vreg_l13c_3p0 {};
> +pp3300_l13c: &vreg_l13c_3p0 {};
> +
> +/* From our board to Qcard; ordered same as node definition above */
> +
> +vreg_edp_bl: &ppvar_sys {};
> +
> +ts_avdd:      &pp3300_left_in_mlb {};
> +vreg_edp_3p3: &pp3300_left_in_mlb {};
> +
> +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
Again.


> +
> +ap_i2c_tpm: &i2c14 {
> +	status = "okay";
> +	clock-frequency = <400000>;
> +
> +	tpm@50 {
> +		compatible = "google,cr50";
> +		reg = <0x50>;
> +
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gsc_ap_int_odl>;
> +
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <104 IRQ_TYPE_EDGE_RISING>;
> +	};
> +};
> +
> +/* For nvme; not all herobrine boards have; boards set status = "okay" */
"NVMe drive, enabled on a per-board basis"?


> +&pcie1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie1_clkreq_n>, <&ssd_rst_l>, <&pe_wake_odl>;
> +
> +	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +	vddpe-3v3-supply = <&pp3300_ssd>;
> +};
> +
> +&pmk8350_rtc {
> +	status = "disabled";
> +};
> +
> +&qupv3_id_0 {
> +	status = "okay";
> +};
> +
> +&qupv3_id_1 {
> +	status = "okay";
> +};
> +
> +/* For SD Card; not all herobrine boards have; boards set status = "okay" */
Ditto

> +&sdhc_2 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_on>;
> +	pinctrl-1 = <&sdc2_off>;
> +
> +	vmmc-supply = <&pp2950_l9c>;
> +	vqmmc-supply = <&ppvar_l6c>;
> +
> +	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
> +};
> +
> +/* Not all herobrine boards have fingerprint; boards set status = "okay" */
Ditto

> +ap_spi_fp: &spi9 {
> +	pinctrl-0 = <&qup_spi9_data_clk>, <&qup_spi9_cs_gpio_init_high>, <&qup_spi9_cs_gpio>;
> +
> +	cs-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> +
> +	cros_ec_fp: ec@0 {
> +		compatible = "google,cros-ec-spi";
> +		reg = <0>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <61 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
> +		spi-max-frequency = <3000000>;
> +	};
> +};
> +
> +ap_ec_spi: &spi10 {
> +	status = "okay";
> +	pinctrl-0 = <&qup_spi10_data_clk>, <&qup_spi10_cs_gpio_init_high>, <&qup_spi10_cs_gpio>;
> +
> +	cs-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
> +
> +	cros_ec: ec@0 {
> +		compatible = "google,cros-ec-spi";
> +		reg = <0>;
> +		interrupt-parent = <&tlmm>;
> +		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&ap_ec_int_l>;
> +		spi-max-frequency = <3000000>;
> +
> +		cros_ec_pwm: ec-pwm {
> +			compatible = "google,cros-ec-pwm";
> +			#pwm-cells = <1>;
> +		};
> +
> +		i2c_tunnel: i2c-tunnel {
> +			compatible = "google,cros-ec-i2c-tunnel";
> +			google,remote-bus = <0>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +
> +		typec {
> +			compatible = "google,cros-ec-typec";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			usb_c0: connector@0 {
> +				compatible = "usb-c-connector";
> +				reg = <0>;
> +				label = "left";
> +				power-role = "dual";
> +				data-role = "host";
> +				try-power-role = "source";
> +			};
> +
> +			usb_c1: connector@1 {
> +				compatible = "usb-c-connector";
> +				reg = <1>;
> +				label = "right";
> +				power-role = "dual";
> +				data-role = "host";
> +				try-power-role = "source";
> +			};
> +		};
> +	};
> +};
> +
> +#include <arm/cros-ec-keyboard.dtsi>
> +#include <arm/cros-ec-sbs.dtsi>
> +
> +&keyboard_controller {
> +	function-row-physmap = <
> +		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
> +		MATRIX_KEY(0x03, 0x02, 0)	/* T2 */
> +		MATRIX_KEY(0x02, 0x02, 0)	/* T3 */
> +		MATRIX_KEY(0x01, 0x02, 0)	/* T4 */
> +		MATRIX_KEY(0x03, 0x04, 0)	/* T5 */
> +		MATRIX_KEY(0x02, 0x04, 0)	/* T6 */
> +		MATRIX_KEY(0x01, 0x04, 0)	/* T7 */
> +		MATRIX_KEY(0x02, 0x09, 0)	/* T8 */
> +		MATRIX_KEY(0x01, 0x09, 0)	/* T9 */
> +		MATRIX_KEY(0x00, 0x04, 0)	/* T10 */
> +	>;
> +	linux,keymap = <
> +		MATRIX_KEY(0x00, 0x02, KEY_BACK)
> +		MATRIX_KEY(0x03, 0x02, KEY_REFRESH)
> +		MATRIX_KEY(0x02, 0x02, KEY_ZOOM)
> +		MATRIX_KEY(0x01, 0x02, KEY_SCALE)
> +		MATRIX_KEY(0x03, 0x04, KEY_SYSRQ)
> +		MATRIX_KEY(0x02, 0x04, KEY_BRIGHTNESSDOWN)
> +		MATRIX_KEY(0x01, 0x04, KEY_BRIGHTNESSUP)
> +		MATRIX_KEY(0x02, 0x09, KEY_MUTE)
> +		MATRIX_KEY(0x01, 0x09, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0x00, 0x04, KEY_VOLUMEUP)
> +
> +		CROS_STD_MAIN_KEYMAP
> +	>;
> +};
> +
> +&usb_1 {
> +	status = "okay";
> +};
> +
> +&usb_1_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_1_hsphy {
> +	status = "okay";
> +};
> +
> +&usb_1_qmpphy {
> +	status = "okay";
> +};
> +
> +&usb_2 {
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +};
> +
> +&usb_2_hsphy {
> +	status = "okay";
> +};
> +
> +/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
Again, seemingly not very useful.


> +
> +&qspi_cs0 {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&qspi_clk {
> +	drive-strength = <8>;
> +	bias-disable;
> +};
> +
> +&qspi_data01 {
> +	drive-strength = <8>;
> +	/* High-Z when no transfers; nice to park the lines */
> +	bias-pull-up;
> +};
> +
> +/* For ap_tp_i2c */
> +&qup_i2c0_data_clk {
> +	drive-strength = <2>;
> +	/* Has external pull */
> +	bias-disable;
> +};
> +
> +/* For ap_i2c_tpm */
> +&qup_i2c14_data_clk {
> +	drive-strength = <2>;
> +	/* Has external pull */
> +	bias-disable;
> +};
> +
> +/* For ap_spi_fp */
> +&qup_spi9_data_clk {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For ap_spi_fp */
> +&qup_spi9_cs_gpio {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For ap_ec_spi */
> +&qup_spi10_data_clk {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For ap_ec_spi */
> +&qup_spi10_cs_gpio {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For uart_dbg */
> +&qup_uart5_rx {
> +	bias-pull-up;
> +};
> +
> +/* For uart_dbg */
> +&qup_uart5_tx {
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +&sdc2_on {
> +	clk {
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	cmd {
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	data {
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	sd-cd {
> +		pins = "gpio91";
> +		bias-pull-up;
> +	};
> +};
> +
> +/* PINCTRL - board-specific pinctrl */
And again


> +
> +&pm7325_gpios {
> +	/*
> +	 * On a quick glance it might look like KYPD_VOL_UP_N is used, but
> +	 * that only passes through to a debug connector and not to the actual
> +	 * volume up key.
> +	 */
> +	status = "disabled"; /* No GPIOs are connected */
> +};
> +
> +&pmk8350_gpios {
> +	status = "disabled"; /* No GPIOs are connected */
> +};
> +
> +&tlmm {
> +	/*
> +	 * pinctrl settings for pins that have no real owners.
> +	 */
You can make it /* one line */

Also, the following pins seem to be in random order, not sorted by either their
name nor by their gpio number..
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&bios_flash_wp_od>;
> +
> +	amp_en: amp-en {
> +		pins = "gpio63";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	ap_ec_int_l: ap-ec-int-l {
> +		pins = "gpio18";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	bios_flash_wp_od: bios-flash-wp-od {
> +		pins = "gpio16";
> +		function = "gpio";
> +		/* Has external pull */
> +		bias-disable;
> +	};
> +
> +	en_fp_rails: en-fp-rails {
> +		pins = "gpio77";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	en_pp3300_codec: en-pp3300-codec {
> +		pins = "gpio105";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	en_pp3300_dx_edp: en-pp3300-dx-edp {
> +		pins = "gpio80";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	hub_en: hub-en {
> +		pins = "gpio157";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	fp_rst_l: fp-rst-l {
> +		pins = "gpio78";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-high;
> +	};
> +
> +	fp_to_ap_irq_l: fp-to-ap-irq-l {
> +		pins = "gpio61";
> +		function = "gpio";
> +		/* Has external pullup */
> +		bias-disable;
> +	};
> +
> +	fpmcu_boot0: fpmcu-boot0 {
> +		pins = "gpio68";
> +		function = "gpio";
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	gsc_ap_int_odl: gsc-ap-int-odl {
> +		pins = "gpio104";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	hp_irq: hp-irq {
> +		pins = "gpio101";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	pe_wake_odl: pe-wake-odl {
> +		pins = "gpio3";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		/* Has external pull */
> +		bias-disable;
> +	};
> +
> +	/* For ap_spi_fp */
> +	qup_spi9_cs_gpio_init_high: qup-spi9-cs-gpio-init-high {
> +		pins = "gpio39";
> +		function = "gpio";
> +		output-high;
> +	};
> +
> +	/* For ap_ec_spi */
> +	qup_spi10_cs_gpio_init_high: qup-spi10-cs-gpio-init-high {
> +		pins = "gpio43";
> +		function = "gpio";
> +		output-high;
> +	};
> +
> +	sar0_irq_odl: sar0-irq-odl {
> +		pins = "gpio141";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	sar1_irq_odl: sar0-irq-odl {
> +		pins = "gpio140";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	ssd_en: ssd-en {
> +		pins = "gpio51";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +	};
> +
> +	ssd_rst_l: ssd-rst-l {
> +		pins = "gpio2";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
> +
> +	tp_int_odl: tp-int-odl {
> +		pins = "gpio7";
> +		function = "gpio";
> +		/* Has external pullup */
> +		bias-disable;
> +	};
> +
> +	wf_cam_en: wf-cam-en {
> +		pins = "gpio119";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		/* Has external pulldown */
> +		bias-disable;
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> new file mode 100644
> index 000000000000..caff21d1e588
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
> @@ -0,0 +1,557 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * sc7280 Qcard device tree source
> + *
> + * Qcard PCB has the processor, RAM, eMMC (if stuffed), and eDP connector (if
> + * stuffed) on it. This device tree tries to encapsulate all the things that
> + * all boards using Qcard will have in common. Given that there are stuffing
> + * options, some things may be left with status "disabled" and enabled in
> + * the actual board device tree files.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/iio/qcom,spmi-adc7-pmr735a.h>
> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +#include "sc7280.dtsi"
> +
> +/* PMICs depend on spmi_bus label and so must come after SoC */
> +#include "pm7325.dtsi"
> +#include "pm8350c.dtsi"
> +#include "pmk8350.dtsi"
> +
> +/ {
> +	aliases {
> +		bluetooth0 = &bluetooth;
> +		serial0 = &uart5;
> +		serial1 = &uart7;
> +	};
> +};
> +
> +&apps_rsc {
> +	/*
> +	 * Regulators are given labels corresponding to the various names
> +	 * they are referred to on schematics. They are also given labels
> +	 * corresponding to named voltage inputs on the SoC or components
> +	 * bundled with the SoC (like radio companion chips). We totally
> +	 * ignore it when one regulator is the input to another regulator.
> +	 * That's handled automatically by the initial config given to
> +	 * RPMH by the firmware.
> +	 *
> +	 * Regulators that the HLOS (High Level OS) doesn't touch at all
> +	 * are left out of here since they are managed elsewhere.
> +	 */
> +
> +	pm7325-regulators {
> +		compatible = "qcom,pm7325-rpmh-regulators";
> +		qcom,pmic-id = "b";
> +
> +		vdd19_pmu_pcie_i:
> +		vdd19_pmu_rfa_i:
> +		vreg_s1b_1p856: smps1 {
> +			regulator-min-microvolt = <1856000>;
> +			regulator-max-microvolt = <2040000>;
> +		};
> +
> +		vdd_pmu_aon_i:
> +		vdd09_pmu_rfa_i:
> +		vdd095_mx_pmu:
> +		vdd095_pmu:
> +		vreg_s7b_0p952: smps7 {
> +			regulator-min-microvolt = <535000>;
> +			regulator-max-microvolt = <1120000>;
> +		};
> +
> +		vdd13_pmu_rfa_i:
> +		vdd13_pmu_pcie_i:
> +		vreg_s8b_1p256: smps8 {
> +			regulator-min-microvolt = <1256000>;
> +			regulator-max-microvolt = <1500000>;
> +		};
> +
> +		vdd_a_usbssdp_0_core:
> +		vreg_l1b_0p912: ldo1 {
> +			regulator-min-microvolt = <825000>;
> +			regulator-max-microvolt = <925000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_a_usbhs_3p1:
> +		vreg_l2b_3p072: ldo2 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_a_csi_0_1_1p2:
> +		vdd_a_csi_2_3_1p2:
> +		vdd_a_csi_4_1p2:
> +		vdd_a_dsi_0_1p2:
> +		vdd_a_edp_0_1p2:
> +		vdd_a_qlink_0_1p2:
> +		vdd_a_qlink_1_1p2:
> +		vdd_a_pcie_0_1p2:
> +		vdd_a_pcie_1_1p2:
> +		vdd_a_ufs_0_1p2:
> +		vdd_a_usbssdp_0_1p2:
> +		vreg_l6b_1p2: ldo6 {
> +			regulator-min-microvolt = <1140000>;
> +			regulator-max-microvolt = <1260000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		/*
> +		 * Despite the fact that this is named to be 2.5V on the
> +		 * schematic, it powers eMMC which doesn't accept 2.5V
> +		 */
> +		vreg_l7b_2p5: ldo7 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_px_wcd9385:
> +		vdd_txrx:
> +		vddpx_0:
> +		vddpx_3:
> +		vddpx_7:
> +		vreg_l18b_1p8: ldo18 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_1p8:
> +		vdd_px_sdr735:
> +		vdd_pxm:
> +		vdd18_io:
> +		vddio_px_1:
> +		vddio_px_2:
> +		vddio_px_3:
> +		vddpx_ts:
> +		vddpx_wl4otp:
> +		vreg_l19b_1p8: ldo19 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +	};
> +
> +	pm8350c-regulators {
> +		compatible = "qcom,pm8350c-rpmh-regulators";
> +		qcom,pmic-id = "c";
> +
> +		vdd22_wlbtpa_ch0:
> +		vdd22_wlbtpa_ch1:
> +		vdd22_wlbtppa_ch0:
> +		vdd22_wlbtppa_ch1:
> +		vdd22_wlpa5g_ch0:
> +		vdd22_wlpa5g_ch1:
> +		vdd22_wlppa5g_ch0:
> +		vdd22_wlppa5g_ch1:
> +		vreg_s1c_2p2: smps1 {
> +			regulator-min-microvolt = <2190000>;
> +			regulator-max-microvolt = <2210000>;
> +		};
> +
> +		lp4_vdd2_1p052:
> +		vreg_s9c_0p676: smps9 {
> +			regulator-min-microvolt = <1010000>;
> +			regulator-max-microvolt = <1170000>;
> +		};
> +
> +		vdda_apc_cs_1p8:
> +		vdda_gfx_cs_1p8:
> +		vdda_turing_q6_cs_1p8:
> +		vdd_a_cxo_1p8:
> +		vdd_a_qrefs_1p8:
> +		vdd_a_usbhs_1p8:
> +		vdd_qfprom:
> +		vreg_l1c_1p8: ldo1 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1980000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l2c_1p8: ldo2 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <1980000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l3c_3p0: ldo3 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3540000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vddpx_5:
> +		vreg_l4c_1p8_3p0: ldo4 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vddpx_6:
> +		vreg_l5c_1p8_3p0: ldo5 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vddpx_2:
> +		vreg_l6c_2p96: ldo6 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2950000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l7c_3p0: ldo7 {
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l8c_1p8: ldo8 {
> +			regulator-min-microvolt = <1620000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l9c_2p96: ldo9 {
> +			regulator-min-microvolt = <2960000>;
> +			regulator-max-microvolt = <2960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_a_csi_0_1_0p9:
> +		vdd_a_csi_2_3_0p9:
> +		vdd_a_csi_4_0p9:
> +		vdd_a_dsi_0_0p9:
> +		vdd_a_dsi_0_pll_0p9:
> +		vdd_a_edp_0_0p9:
> +		vdd_a_gnss_0p9:
> +		vdd_a_pcie_0_core:
> +		vdd_a_pcie_1_core:
> +		vdd_a_qlink_0_0p9:
> +		vdd_a_qlink_0_0p9_ck:
> +		vdd_a_qlink_1_0p9:
> +		vdd_a_qlink_1_0p9_ck:
> +		vdd_a_qrefs_0p875_0:
> +		vdd_a_qrefs_0p875_1:
> +		vdd_a_qrefs_0p875_2:
> +		vdd_a_qrefs_0p875_3:
> +		vdd_a_qrefs_0p875_4_5:
> +		vdd_a_qrefs_0p875_6:
> +		vdd_a_qrefs_0p875_7:
> +		vdd_a_qrefs_0p875_8:
> +		vdd_a_qrefs_0p875_9:
> +		vdd_a_ufs_0_core:
> +		vdd_a_usbhs_core:
> +		vreg_l10c_0p88: ldo10 {
> +			regulator-min-microvolt = <720000>;
> +			regulator-max-microvolt = <1050000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l11c_2p8: ldo11 {
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l12c_1p8: ldo12 {
> +			regulator-min-microvolt = <1650000>;
> +			regulator-max-microvolt = <2000000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vreg_l13c_3p0: ldo13 {
> +			regulator-min-microvolt = <2700000>;
> +			regulator-max-microvolt = <3544000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> +		};
> +
> +		vdd_flash:
> +		vdd_iris_rgb:
> +		vdd_mic_bias:
> +		vreg_bob: bob {
> +			regulator-min-microvolt = <3008000>;
> +			regulator-max-microvolt = <3960000>;
> +			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
> +		};
> +	};
> +};
> +
> +/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
Ditto.


> +
> +&ipa {
> +	status = "okay";
> +	modem-init;
> +};
> +
> +/* For nvme; boards set status = "okay" */
This is kind of obvious, no?


> +&pcie1_phy {
> +	vdda-phy-supply = <&vreg_l10c_0p88>;
> +	vdda-pll-supply = <&vreg_l6b_1p2>;
> +};
> +
> +&pmk8350_vadc {
> +	pmk8350-die-temp@3 {
> +		reg = <PMK8350_ADC7_DIE_TEMP>;
> +		label = "pmk8350_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
> +
> +	pmr735a-die-temp@403 {
> +		reg = <PMR735A_ADC7_DIE_TEMP>;
> +		label = "pmr735a_die_temp";
> +		qcom,pre-scaling = <1 1>;
> +	};
> +};
> +
> +&qfprom {
> +	vcc-supply = <&vdd_qfprom>;
> +};
> +
> +/* For eMMC; not all Qcards have eMMC stuffed; boards set status = "okay" */
Same here.


> +&sdhc_1 {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_on>;
> +	pinctrl-1 = <&sdc1_off>;
> +
> +	vmmc-supply = <&vreg_l7b_2p5>;
> +	vqmmc-supply = <&vreg_l19b_1p8>;
> +
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +};
> +
> +uart_dbg: &uart5 {
> +	compatible = "qcom,geni-debug-uart";
> +	status = "okay";
> +};
> +
> +mos_bt_uart: &uart7 {
> +	status = "okay";
> +
> +	/delete-property/interrupts;
I think generally one should put a space after '/'.


> +	interrupts-extended = <&intc GIC_SPI 608 IRQ_TYPE_LEVEL_HIGH>,
> +				<&tlmm 31 IRQ_TYPE_EDGE_FALLING>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-1 = <&qup_uart7_sleep_cts>, <&qup_uart7_sleep_rts>, <&qup_uart7_sleep_tx>, <&qup_uart7_sleep_rx>;
> +
> +	bluetooth: bluetooth {
> +		compatible = "qcom,wcn6750-bt";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mos_bt_en>;
> +		enable-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
> +		swctrl-gpios = <&tlmm 86 GPIO_ACTIVE_HIGH>;
> +		vddaon-supply = <&vreg_s7b_0p952>;
> +		vddbtcxmx-supply = <&vreg_s7b_0p952>;
> +		vddrfacmn-supply = <&vreg_s7b_0p952>;
> +		vddrfa0p8-supply = <&vreg_s7b_0p952>;
> +		vddrfa1p7-supply = <&vdd19_pmu_rfa_i>;
> +		vddrfa1p2-supply = <&vdd13_pmu_rfa_i>;
> +		vddrfa2p2-supply = <&vreg_s1c_2p2>;
> +		vddasd-supply = <&vreg_l11c_2p8>;
> +		vddio-supply = <&vreg_l18b_1p8>;
> +		max-speed = <3200000>;
> +	};
> +};
> +
> +&usb_1_hsphy {
> +	vdda-pll-supply = <&vdd_a_usbhs_core>;
> +	vdda33-supply = <&vdd_a_usbhs_3p1>;
> +	vdda18-supply = <&vdd_a_usbhs_1p8>;
> +};
> +
> +&usb_1_qmpphy {
> +	vdda-phy-supply = <&vdd_a_usbssdp_0_1p2>;
> +	vdda-pll-supply = <&vdd_a_usbssdp_0_core>;
> +};
> +
> +&usb_2_hsphy {
> +	vdda-pll-supply = <&vdd_a_usbhs_core>;
> +	vdda33-supply = <&vdd_a_usbhs_3p1>;
> +	vdda18-supply = <&vdd_a_usbhs_1p8>;
> +};
> +
> +/*
> + * PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES
Again.


> + *
> + * NOTE: In general if pins leave the Qcard then the pinctrl goes in the
> + * baseboard or board device tree, not here.
> + */
> +
> +/*
> + * For ts_i2c
> + *
> + * Technically this i2c bus actually leaves the Qcard, but it leaves directly
> + * via the eDP connector (it doesn't hit the baseboard). The external pulls
> + * are on Qcard.
> + */
> +&qup_i2c13_data_clk {
> +	drive-strength = <2>;
> +	/* Has external pull */
> +	bias-disable;
> +};
> +
> +/* For mos_bt_uart */
> +&qup_uart7_cts {
> +	/*
> +	 * Configure a pull-down on CTS to match the pull of
> +	 * the Bluetooth module.
My email client doesn't show me the column count, but I think this would
fit in a single 100 char line..

> +	 */
> +	bias-pull-down;
> +};
> +
> +/* For mos_bt_uart */
> +&qup_uart7_rts {
> +	/* We'll drive RTS, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For mos_bt_uart */
> +&qup_uart7_tx {
> +	/* We'll drive TX, so no pull */
> +	drive-strength = <2>;
> +	bias-disable;
> +};
> +
> +/* For mos_bt_uart */
> +&qup_uart7_rx {
> +	/*
> +	 * Configure a pull-up on RX. This is needed to avoid
> +	 * garbage data when the TX pin of the Bluetooth module is
> +	 * in tri-state (module powered off or not driving the
> +	 * signal yet).
> +	 */
> +	bias-pull-up;
> +};
> +
> +/* eMMC, if stuffed, is straight on the Qcard */
> +&sdc1_on {
> +	clk {
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	cmd {
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	data {
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	rclk {
> +		bias-pull-down;
> +	};
> +};
> +
> +/*
> + * PINCTRL - QCARD
> + *
> + * This has entries that are defined by Qcard even if they go to the main
> + * board. In cases where the pulls may be board dependent we defer those
> + * settings to the board device tree. Drive strengths tend to be assinged here
> + * but could conceivably be overwridden by board device trees.
> + */
> +
> +&pm8350c_gpios {
> +	pmic_edp_bl_en: pmic-edp-bl-en {
> +		pins = "gpio7";
> +		function = "normal";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +
> +		/* Force backlight to be disabled to match state at boot. */
> +		output-low;
> +	};
> +
> +	pmic_edp_bl_pwm: pmic-edp-bl-pwm {
> +		pins = "gpio8";
> +		function = "func1";
> +		qcom,drive-strength = <PMIC_GPIO_STRENGTH_LOW>;
> +		bias-disable;
> +		output-low;
> +		power-source = <0>;
> +	};
> +};
> +
> +&tlmm {
> +	mos_bt_en: mos-bt-en {
> +		pins = "gpio85";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		output-low;
> +	};
> +
> +	/* For mos_bt_uart */
> +	qup_uart7_sleep_cts: qup-uart7-sleep-cts {
> +		pins = "gpio28";
> +		function = "gpio";
> +		/*
> +		 * Configure a pull-down on CTS to match the pull of
> +		 * the Bluetooth module.
> +		 */
> +		bias-pull-down;
> +	};
> +
> +	/* For mos_bt_uart */
> +	qup_uart7_sleep_rts: qup-uart7-sleep-rts {
> +		pins = "gpio29";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-down on RTS. As RTS is active low
> +		 * signal, pull it low to indicate the BT SoC that it
> +		 * can wakeup the system anytime from suspend state by
> +		 * pulling RX low (by sending wakeup bytes).
> +		 */
> +		bias-pull-down;
> +	};
> +
> +	/* For mos_bt_uart */
> +	qup_uart7_sleep_rx: qup-uart7-sleep-rx {
> +		pins = "gpio31";
> +		function = "gpio";
> +		/*
> +		 * Configure a pull-up on RX. This is needed to avoid
> +		 * garbage data when the TX pin of the Bluetooth module
> +		 * is floating which may cause spurious wakeups.
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	/* For mos_bt_uart */
> +	qup_uart7_sleep_tx: qup-uart7-sleep-tx {
> +		pins = "gpio30";
> +		function = "gpio";
> +		/*
> +		 * Configure pull-up on TX when it isn't actively driven
> +		 * to prevent BT SoC from receiving garbage during sleep.
> +		 */
> +		bias-pull-up;
> +	};
> +
> +	ts_int_conn: ts-int-conn {
> +		pins = "gpio55";
> +		function = "gpio";
> +		bias-pull-up;
> +	};
> +
> +	ts_rst_conn: ts-rst-conn {
> +		pins = "gpio54";
> +		function = "gpio";
> +		bias-pull-up;
> +		drive-strength = <2>;
Please be consistent in the order in which you add the same properties throughout
GPIO nodes.

> +	};
> +};
>

Konrad
 
