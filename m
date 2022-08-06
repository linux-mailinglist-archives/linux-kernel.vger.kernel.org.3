Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DF858B358
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 04:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241685AbiHFCKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 22:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbiHFCKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 22:10:18 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BCAA510ED;
        Fri,  5 Aug 2022 19:10:14 -0700 (PDT)
Received: from [192.168.1.12] (unknown [81.178.197.238])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 09ACF14021F;
        Sat,  6 Aug 2022 02:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1659751813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LsI+40M2+kammgXl2cNUrd5LjH7UGzz6rCgH1ftsCbk=;
        b=ZkOfu5DdB4zuWRucOjD2S+erutTS8+ClC/dAx9fgrn+n488rH1YEGzah18u8wn+amkQMwp
        uHJgq8+y+YspobcVDUC5UdCvmVUOpfwaJ67BvtlIhXOVToLSbXNxy8K2IoeM4UkbRjsOT4
        QXsqQ/ih3NzAV7qMgh6SCILiMSgQJYE=
Message-ID: <f9cbc047-f30f-e711-3213-56fcbb7bbc8a@postmarketos.org>
Date:   Sat, 6 Aug 2022 03:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Content-Language: en-US
To:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de
Cc:     megi@xff.cz, martijn@brixit.nl, ayufan@ayufan.eu,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
From:   Caleb Connolly <kc@postmarketos.org>
In-Reply-To: <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/08/2022 00:44, Tom Fitzhenry wrote:
> This is a basic DT containing regulators and UART, intended to be a
> base that myself and others can add additional nodes in future patches.
Hi,

I was surprised to see this series, and this patch especially.
An almost ready to submit version of this patch with considerably more 
functionality has been sat around for a while but unfortunately never sent [1].

Creating a minimal patch to just finally get the PinePhone pro into mainline is 
not a bad idea, but as it stands I'm not fully on board with this patch.

According to the link below (and my own knowledge of PPP development) Kamil is 
the original author of this patch, both Kamil and Martijn created the initial 
version of the devicetree. Given that you're using their work as a base, Kamil's 
authorship should be respected in the patch you submit.

Their original patch [2] contained SoBs from them and Martijn, those are both 
missing below. Both of their signed-off-by tags should be added before this 
patch hits the mailing list, and the same for Ondrej. The order also seems wrong 
(Ondrej should be last before you).

Support for the volume keys, accelerometer, magnetometer, GPIO LEDs, 
touchscreen, modem codec and audio support are all missing here, but they're 
included in the patches you referenced. In their current state (see Martijn's 
commit [1] or my 5.19 rebase [3]) the DT for these components has been worked on 
by several people, tested by the larger user community, and are already 
supported in mainline. It seems strange not to include them and just leads to a 
bunch of extra busywork to add them back later. It's easy enough to drop any of 
these nodes during review if they become an issue.

With that being said, I've left some feedback below, with it addressed and the 
authorship/SoB situation sorted out:

Reviewed-by: Caleb Connolly <kc@postmarketos.org>

Alternatively, I'd be more than happy to review a new revision with the 
aforementioned nodes re-included.

Kind Regards,
Caleb

[1]: 
https://git.sr.ht/~martijnbraam/linux-unlisted/commit/01f0c90f6c4c1649f17a0ced72fc32a26d509e06
[2]: 
https://gitlab.com/pine64-org/linux/-/commit/261d3b5f8ac503f97da810986d1d6422430c8531
[3]: 
https://gitlab.com/pine64-org/linux/-/blob/caleb/ppp-5.19-rc5/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> 
> Tested to work: booting from eMMC, output over UART.
> 
> This is derived from a combination of https://gitlab.com/pine64-org/linux
> and https://megous.com/git/linux.
> 
> https://wiki.pine64.org/wiki/PinePhone_Pro
> 
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Martijn Braam <martijn@brixit.nl>
> Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
> ---
>   arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>   .../dts/rockchip/rk3399-pinephone-pro.dts     | 385 ++++++++++++++++++
>   2 files changed, 386 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index ef79a672804a1..cb42e0a15808e 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -42,6 +42,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-r4s.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinephone-pro.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> new file mode 100644
> index 0000000000000..f5608487ad58f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinephone-pro.dts
> @@ -0,0 +1,385 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020 Martijn Braam <martijn@brixit.nl>
> + * Copyright (c) 2021 Kamil Trzciński <ayufan@ayufan.eu>
> + */
> +
> +// PinePhone Pro datasheet: https://files.pine64.org/doc/PinePhonePro/PinephonePro-Schematic-V1.0-20211127.pdf
Use C-style comments
> +
> +/dts-v1/;
> +#include <dt-bindings/input/gpio-keys.h>
This header is unused and can be dropped.
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include "rk3399.dtsi"
> +#include "rk3399-t-opp.dtsi"
> +
> +/ {
> +	model = "Pine64 PinePhonePro";
> +	compatible = "pine64,pinephone-pro", "rockchip,rk3399";
> +	chassis-type = "handset";
> +
> +	aliases {
> +                mmc0 = &sdio0;
> +                mmc1 = &sdmmc;
> +                mmc2 = &sdhci;
> +        };
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	gpio-key-power {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pwrbtn_pin>;
> +
> +		power {
> +			debounce-interval = <20>;
> +			// Per "PMU Controler", page 4.
Comments like these aren't useful and should be dropped
> +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> +			label = "Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
> +
> +	/* Power tree */
> +	/* Root power source */
These too
> +	vcc_sysin: vcc-sysin {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sysin";
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	/* Main 3.3v supply */
^^
> +	vcc3v3_sys: wifi_bat: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc_sysin>;
> +	};
> +
> +	vcca1v8_s3: vcc1v8-s3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcca1v8_s3";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		vin-supply = <&vcc3v3_sys>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +};
> +
> +&cpu_l0 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l1 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l2 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_l3 {
> +	cpu-supply = <&vdd_cpu_l>;
> +};
> +
> +&cpu_b0 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&cpu_b1 {
> +	cpu-supply = <&vdd_cpu_b>;
> +};
> +
> +&emmc_phy {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	// Per "SCL clock frequency", page 30, RK818 datasheet.
Drop
> +	clock-frequency = <400000>;
> +	i2c-scl-rising-time-ns = <168>;
> +	i2c-scl-falling-time-ns = <4>;
> +	status = "okay";
> +
> +	// Per "PMIC RK818-3", page 13.
Drop
> +	rk818: pmic@1c {
> +		compatible = "rockchip,rk818";
> +		reg = <0x1c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <RK_PC5 IRQ_TYPE_LEVEL_LOW>;
> +		#clock-cells = <1>;
> +		clock-output-names = "xin32k", "rk808-clkout2";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int_l>;
> +		rockchip,system-power-controller;
> +		wakeup-source;
> +
> +		vcc1-supply = <&vcc_sysin>;
> +		vcc2-supply = <&vcc_sysin>;
> +		vcc3-supply = <&vcc_sysin>;
> +		vcc4-supply = <&vcc_sysin>;
> +		vcc6-supply = <&vcc_sysin>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc_sysin>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +
> +		regulators {
> +			vdd_cpu_l: DCDC_REG1 {
> +				regulator-name = "vdd_cpu_l";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vdd_center: DCDC_REG2 {
> +				regulator-name = "vdd_center";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1350000>;
> +				regulator-ramp-delay = <6001>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcc_ddr: DCDC_REG3 {
> +				regulator-name = "vcc_ddr";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v8: vcc_wl: DCDC_REG4 {
> +				regulator-name = "vcc_1v8";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			// Audio codec.
Drop
> +			vcca3v0_codec: LDO_REG1 {
> +				regulator-name = "vcca3v0_codec";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			// Touch screen.
Drop
> +			vcc3v0_touch: LDO_REG2 {
> +				regulator-name = "vcc3v0_touch";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vcca1v8_codec: LDO_REG3 {
> +				regulator-name = "vcca1v8_codec";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_power_on: LDO_REG4 {
> +				regulator-name = "vcc_power_on";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_3v0: LDO_REG5 {
> +				regulator-name = "vcc_3v0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc_1v5: LDO_REG6 {
> +				regulator-name = "vcc_1v5";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <1500000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			vcc1v8_dvp: LDO_REG7 {
> +				regulator-name = "vcc1v8_dvp";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			vcc3v3_s3: LDO_REG8 {
> +				regulator-name = "vcc3v3_s3";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			vccio_sd: LDO_REG9 {
> +				regulator-name = "vccio_sd";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <3300000>;
> +			};
> +
> +			vcc3v3_s0: SWITCH_REG {
> +				regulator-name = "vcc3v3_s0";
> +				regulator-always-on;
> +				regulator-boot-on;
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +		};
> +	};
> +
> +	vdd_cpu_b: regulator@40 {
> +		compatible = "silergy,syr827";
> +		reg = <0x40>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel1_pin>;
> +		regulator-name = "vdd_cpu_b";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	vdd_gpu: regulator@41 {
> +		compatible = "silergy,syr828";
> +		reg = <0x41>;
> +		fcs,suspend-voltage-selector = <1>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vsel2_pin>;
> +		regulator-name = "vdd_gpu";
> +		regulator-min-microvolt = <712500>;
> +		regulator-max-microvolt = <1500000>;
> +		regulator-ramp-delay = <1000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +};
> +
> +&io_domains {
> +        status = "okay";
> +
> +        bt656-supply = <&vcc1v8_dvp>;
> +        audio-supply = <&vcca1v8_codec>;
> +        sdmmc-supply = <&vccio_sd>;
> +        gpio1830-supply = <&vcc_3v0>;
> +};
> +
> +&pmu_io_domains {
> +	pmu1830-supply = <&vcc_1v8>;
> +	status = "okay";
> +};
> +
> +&pinctrl {
> +	buttons {
> +		pwrbtn_pin: pwrbtn-pin {
> +			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +	};
> +
> +	pmic {
> +		pmic_int_l: pmic-int-l {
> +			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
> +		};
> +
> +		vsel1_pin: vsel1-pin {
> +			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +
> +		vsel2_pin: vsel2-pin {
> +			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
> +		};
> +	};
> +};
> +
> +// Per "SDMMC Controler", page 6.
Drop
> +&sdmmc {
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	cd-gpios = <&gpio0 RK_PA7 GPIO_ACTIVE_LOW>;
> +	disable-wp;
> +	max-frequency = <150000000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
> +	vmmc-supply = <&vcc3v3_sys>;
> +	vqmmc-supply = <&vccio_sd>;
> +	status = "okay";
> +};
> +
> +&sdhci {
> +	bus-width = <8>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +// Enable thermal sensors.
Drop
> +&tsadc {
> +	/* tshut mode 0:CRU 1:GPIO */
Drop
> +	rockchip,hw-tshut-mode = <1>;
> +	/* tshut polarity 0:LOW 1:HIGH */
Drop
> +	rockchip,hw-tshut-polarity = <1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
