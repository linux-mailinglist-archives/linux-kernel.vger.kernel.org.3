Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C724FDF8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352184AbiDLMMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354634AbiDLMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:10:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1336E352;
        Tue, 12 Apr 2022 04:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 031C8B81CCD;
        Tue, 12 Apr 2022 11:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3AA8C385A1;
        Tue, 12 Apr 2022 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649761836;
        bh=gt5u2JP05nDBYKNXjErrsaT2OkhaTZraa4iJgn23z6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Y4NjQF7zB+YbRQtPYnrClR0bIChBqfZS13tntb5Le+g+CyuxfYLn6vCM45NzWylDq
         62Dagknjtl4sdsqbEpwFHvdUWF/ibgWlSf0UqiQYBH9vkVOyhpTzO1pub5+zzr5HS5
         1VhZmmAdpWNPCaUZpxw1Ct8O8L6NgIXIVqqkXHvEH4iHI9gqkRm5A2K5tUeIH9DWd5
         MBviNWn2PJEuypadAv82gz0k9tLFM2gEN728QL8fEVMfRtmd6FZc7+jaJwUBWKUZ0X
         R8Ex0eJMQvGD2Hcvc+WahKAFrc3oAmJ5jFFqHr+thLqW6wRMcgaP+QN0MaAW6ClWbf
         ZlAPIAKBZ7bAg==
Message-ID: <f2b1359d-a003-ae38-e8af-ab6aa1d0fe72@kernel.org>
Date:   Tue, 12 Apr 2022 13:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] arm: dts: Add device tree for bosch acc board
Content-Language: en-US
To:     Philip Oberfichtner <pro@denx.de>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>
References: <20220412101905.514310-1-pro@denx.de>
 <20220412101905.514310-3-pro@denx.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220412101905.514310-3-pro@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:19, Philip Oberfichtner wrote:
> Add device tree for the Bosch ACC board, based on i.MX6 Dual.
> 

Thank you for your patch. There is something to discuss/improve.

> +	};
> +
> +	backlight {
> +		status = "okay";

Are you overriding any node? Looks like not, so status is not needed.

> +
> +		compatible = "pwm-backlight";
> +		/* The last value is the PWM period in nano-seconds!
> +		 * -> 5 kHz = 200 µS = 200.000 ns
> +		 */
> +		pwms = <&pwm1 0 200000>;
> +		brightness-levels = <0 61 499 1706 4079 8022 13938 22237 33328 47623 65535>;
> +		num-interpolated-steps = <10>;
> +		default-brightness-level = <60>;
> +		power-supply = <&reg_lcd0_pwr>;
> +	};
> +
> +	usb3503_refclk: usb3503_refclk {

hyphens in node names, not underscores. Node names should be generic,
but if you need a specific prefix, it's ok.

> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +
> +		clocks = <&clks IMX6QDL_CLK_CKO2>;
> +		clock-div = <1>;
> +		clock-mult = <1>;
> +		clock-output-names = "12mhz_refclk";
> +
> +		assigned-clocks = <&clks IMX6QDL_CLK_CKO>,
> +				  <&clks IMX6QDL_CLK_CKO2>,
> +				  <&clks IMX6QDL_CLK_CKO2_SEL>;
> +		assigned-clock-parents = <&clks IMX6QDL_CLK_CKO2>,
> +					 <&clks IMX6QDL_CLK_CKO2_PODF>,
> +					 <&clks IMX6QDL_CLK_OSC>;
> +		assigned-clock-rates = <0>, <12000000>, <0>;
> +	};
> +
> +	cpus {
> +		/* Override operating points with board-specific values */
> +		cpu0: cpu@0 {
> +			operating-points = <

Anything blocking from using OPP v2 bindings?

> +				/* kHz    uV */
> +				1200000 1275000
> +				996000  1225000
> +				852000  1225000
> +				792000  1150000
> +				396000  950000
> +			>;
> +			fsl,soc-operating-points = <

This seems undocumented and actually - why do you need it if you have
generic operating points?

> +				/* ARM kHz  SOC-PU uV */
> +				1200000 1225000
> +				996000	1175000
> +				852000	1175000
> +				792000	1150000
> +				396000	1150000
> +			>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			operating-points = <
> +				/* kHz    uV */
> +				1200000 1275000
> +				996000  1225000
> +				852000  1225000
> +				792000  1150000
> +				396000  950000
> +			>;
> +			fsl,soc-operating-points = <
> +				/* ARM kHz  SOC-PU uV */
> +				1200000 1225000
> +				996000	1175000
> +				852000	1175000
> +				792000	1150000
> +				396000	1150000
> +			>;
> +		};
> +	};
> +
> +	leds {
> +		compatible = "pwm-leds";
> +
> +		led_red: red {

Generic node names, so led-0.

Add common properties for color and function.

> +			label = "red";
> +			max-brightness = <248>;
> +			default-state = "off";
> +			pwms = <&pwm2 0 500000>;
> +		};
> +
> +		led_white: white {

The same.

> +			label = "white";
> +			max-brightness = <248>;
> +			default-state = "off";
> +			pwms = <&pwm3 0 500000>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +	};
> +
> +	memory {
> +		reg = <0x10000000 0x40000000>;
> +	};
> +
> +	regulators: regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;

This should not be a bus. Instead "regulator-0" and so on.

> +
> +		supply_5P0: regulator@0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;

Please run `make dtbs_check` (see Docs for this) and fix the warnings.
Please fix automated check warnings before using reviewers time.

> +			regulator-name = "5P0";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;

Why do you need it? There is no control here, it's only used as a supply
for other uncontrollable regulators (unless I missed something).

> +		};
> +
> +		supply_VIN: regulator@1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "VIN";
> +			regulator-min-microvolt = <4500000>;
> +			regulator-max-microvolt = <4500000>;
> +			regulator-always-on;
> +			vin-supply = <&supply_5P0>;
> +		};
> +
> +		reg_usb_otg_vbus: regulator@2 {
> +			compatible = "regulator-fixed";
> +			reg = <2>;
> +			regulator-name = "usb_otg_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +		};
> +
> +		reg_usb_h1_vbus: regulator@3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "usb_h1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			regulator-always-on;
> +			vin-supply = <&supply_5P0>;
> +		};
> +
> +		supply_VSNVS_3V0: regulator@4 {
> +			compatible = "regulator-fixed";
> +			reg = <4>;
> +			regulator-name = "VSNVS_3V0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-always-on;
> +			vin-supply = <&supply_5P0>;
> +		};
> +
> +		reg_lcd0_pwr: regulator-lcd0-pwr {
> +			compatible = "regulator-fixed";
> +			regulator-name = "LCD0 POWER";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_lcd_enable>;
> +			gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> +			enable-active-high;
> +			regulator-boot-on;
> +		};
> +
> +		reg_usb_h2_vbus: regulator@6 {
> +			compatible = "regulator-fixed";
> +			reg = <6>;
> +			regulator-name = "usb_h2_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			vin-supply = <&supply_5P0> ;
> +			regulator-always-on;
> +		};
> +
> +		supply_vref_dac: vref_dac {

1. No underscores in node names.
2. Did you compile dts with W=1 and fixed warnings?


> +			compatible = "regulator-fixed";
> +			regulator-name = "vref_dac";
> +			regulator-min-microvolt = <20000>;
> +			regulator-max-microvolt = <20000>;
> +			vin-supply = <&supply_5P0> ;
> +			regulator-boot-on;
> +		};
> +	};
> +
> +	reset_gpio_led {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_reset_gpio_led>;
> +
> +		reset {
> +			label = "red_reset";
> +			gpios = <&gpio5 18 0>;
> +			default-state = "off";
> +		};
> +	};
> +
> +	soc {
> +		aips1: bus@2000000 {};
> +	};
> +};
> +
> +&reg_arm {
> +	vin-supply = <&pmic_sw2>;
> +};
> +
> +&reg_soc {
> +	vin-supply = <&pmic_sw1abc>;
> +};
> +
> +&reg_vdd1p1 {
> +	vin-supply = <&supply_VSNVS_3V0>;
> +};
> +
> +&reg_vdd2p5 {
> +	vin-supply = <&supply_VSNVS_3V0>;
> +};
> +
> +&reg_vdd3p0 {
> +	vin-supply = <&supply_VSNVS_3V0>;
> +};
> +
> +&audmux {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_audmux>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_enet>;
> +	status = "okay";
> +
> +	clocks = <&clks IMX6QDL_CLK_ENET>,
> +		<&clks IMX6QDL_CLK_ENET>,
> +		<&clks IMX6QDL_CLK_ENET>,
> +		<&clks IMX6QDL_CLK_ENET_REF>;
> +	clock-names = "ipg", "ahb", "ptp", "enet_out";
> +	phy-mode = "rmii";
> +	phy-supply = <&supply_sw4_3V3>;
> +	phy-handle = <&ethphy>;
> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ethphy: ethernet-phy@0 {
> +			compatible = "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +			interrupt-parent = <&gpio1>;
> +			interrupts = <23 IRQ_TYPE_EDGE_FALLING>;
> +			smsc,disable-energy-detect;
> +		};
> +	};
> +};
> +
> +

No need for two blank lines.

> +&gpu_vg {
> +	status = "disabled";
> +};
> +
> +&gpu_2d {
> +	status = "disabled";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	clock-frequency = <400000>;
> +	status = "okay";
> +
> +	eeprom: eeprom@50 {
> +		compatible = "atmel,24c32";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +		bytelen = <4096>;
> +		bus-id = <0>;
> +		flags = <0x80>;		/* AT24_FLAG_ADDR16 */
> +	};
> +
> +	lm75: lm75@49 {

Generic node name.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_lm75>;
> +
> +		compatible = "national,lm75b";
> +		reg = <0x49>;
> +
> +		interrupts = <7 0x4>;
> +		interrupt-parent = <&gpio4>;
> +	};
> +
> +	pmic: pfuze100@8 {

pmic, not pfuze

> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
> +		uboot,bootcounter;

Do not add undocumented properties. Please check all entire DTS for such
undocumented stuff.

> +
> +		VGEN1-supply = <&supply_AUX_3V15>;
> +		VGEN2-supply = <&supply_AUX_3V15>;
> +		VGEN3-supply = <&supply_sw4_3V3>;
> +		VGEN4-supply = <&supply_sw4_3V3>;
> +		VGEN5-supply = <&supply_SYS_4V2>;
> +		VGEN6-supply = <&supply_SYS_4V2>;
> +
> +		VREFDDR-supply = <&supply_DDR_1V5>;
> +
> +		SW1AB-supply = <&supply_SYS_4V2>;
> +		SW1C-supply = <&supply_SYS_4V2>;
> +		SW2-supply = <&supply_SYS_4V2>;
> +		SW3A-supply = <&supply_SYS_4V2>;
> +		SW3B-supply = <&supply_SYS_4V2>;
> +		SW4-supply = <&supply_SYS_4V2>;
> +
> +		regulators {
> +			/*
> +			 * VDD_CORE is connected to SW1 ABC
> +			 * We need to define sw1ab and sw1c, but later it is controlled solely with
> +			 * sw1c and therefore only this is named "VDD_SOC".
> +			 * See PMIC datasheet Rev. 18, chapter 6.4.4.3.1: "The feedback and all
> +			 * other controls are accomplished by use of pin SW1CFB and SW1C control
> +			 * registers, respectively."
> +			 * Setting min and max according to SOC datasheet
> +			 */
> +			pmic_sw1abc: sw1c {
> +				regulator-name = "VDD_SOC (sw1abc)";
> +				regulator-min-microvolt = <1275000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +
> +				default-voltage = <1300000>;
> +			};
> +
> +			pmic_sw2: sw2{

Missing space.

> +				regulator-name = "VDD_ARM (sw2)";
> +

Why blank line here and not in other places?

> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +				regulator-ramp-delay = <6250>;
> +
> +				default-voltage = <1300000>;
> +			};
> +
> +			pmic_sw3a: sw3a {
> +				/* U-Boot sets correct voltage, shall not be touched by the OS */
> +				compatible = "regulator-fixed";
> +				regulator-name = "DDR_1V5a";
> +				regulator-boot-on;
> +				regulator-always-on;
> +
> +			};
> +
> +			supply_DDR_1V5: sw3b {
> +				/* U-Boot sets correct voltage, shall not be touched by the OS */
> +				compatible = "regulator-fixed";
> +				regulator-name = "DDR_1V5b";
> +				regulator-boot-on;
> +				regulator-always-on;
> +
> +			};
> +
> +			supply_AUX_3V15: sw4 {
> +				regulator-name = "AUX 3V15 (sw4)";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				default-voltage = <3150000>;
> +
> +			};
> +
> +			swbst_reg: swbst {
> +				status = "disabled";
> +				regulator-min-microvolt = <5000000>;
> +				regulator-max-microvolt = <5150000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +
> +			};
> +
> +			snvs_reg: vsnvs {
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-boot-on;
> +				regulator-always-on;
> +
> +				default-voltage = <3000000>;
> +			};
> +
> +			vref_reg: vrefddr {
> +				regulator-boot-on;
> +				regulator-always-on;
> +
> +				default-voltage = <675000>;
> +			};
> +
> +			vgen1_reg: vgen1 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +				regulator-always-on;
> +
> +				default-voltage = <1500000>;
> +			};
> +
> +			vgen2_reg: vgen2 {
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1550000>;
> +				regulator-always-on;
> +
> +				default-voltage = <1200000>;
> +			};
> +
> +			vgen3_reg: vgen3 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +
> +				default-voltage = <2500000>;
> +			};
> +
> +			vgen4_reg: vgen4 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				default-voltage = <1800000>;
> +			};
> +
> +			vgen5_reg: vgen5 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				default-voltage = <2800000>;
> +			};
> +
> +			vgen6_reg: vgen6 {
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +
> +				default-voltage = <2800000>;
> +			};
> +
> +		};
> +	};
> +
> +	rtc: rtcpcf8563@51 {

Generic node names.

> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_rtc>;
> +
> +		compatible = "nxp,pcf8563";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&i2c2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c2>;
> +	clock-frequency = <100000>;
> +	status = "okay";
> +
> +	adc101c: ac101c@54 {

Ugh...

> +		compatible = "ti,adc101c";
> +		reg = <0x54>;
> +		status = "okay";
> +		vref-supply = <&supply_vref_dac>;
> +		vcc-supply = <&supply_vref_dac>;
> +	};
> +
> +	ad5602: ad5602@c {
> +		compatible = "adi,ad5602";
> +		reg = <0x0c>;
> +		status = "okay";
> +		vcc-supply = <&supply_vref_dac>;
> +	};
> +
> +	eeprom_ext: eeprom_ext@50 {

Generic node names, no underscores in node names.

OK, I'll stop for now. :)


Best regards,
Krzysztof
