Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 301B948F7E1
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 17:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiAOQed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 11:34:33 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51102
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233113AbiAOQec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 11:34:32 -0500
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EE0B94001E
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 16:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642264470;
        bh=gL9SEHLuHJRS1jdAno9IyHB1vb4Hf73HgAfrKy43/Ko=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=Mx1YhUNij9kpwMzHK0IbIzIPGPZwVmMjyvCVf2t9l/qziNU7lZN2r8Ftmnl0bxbNt
         59HtgmTzkYcMfjWzeTLIku8cXZs40JV2jFVFAkNX6sdVEiSe8PRMRNy2fDltSifSsa
         YKLjfEtugRrohK6vWWfO3pbUQ0cNSOfhJp0jf15vyqnKCHXcAFLGu85E3Rxmu1wkVw
         CZBo2fInQiZ0KBHIKL5YXFcmyvhTCaNYW1Lpd8tP5/FVczX7mQ0yXTWIydUYdcQ1UU
         Cl5IYRv7tbMTclfcd0tTaQXDLibCEc+mE7xEPTv8GgarGesiG/TeO9bzpSFJrD4H3O
         bjVD3AfssQoMA==
Received: by mail-wm1-f71.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso2935376wmb.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 08:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gL9SEHLuHJRS1jdAno9IyHB1vb4Hf73HgAfrKy43/Ko=;
        b=vihm4uKt2iX/10ymy531HzcTdQEAci56Mr6fhIxX06ZLDgGVvcW9xGvUygAbHARDMs
         yXSRei4HTVHm6TQZ78NX2nmGn2sPlBdkCqyfh1QUT38tkNR5m5w6AIC7LD4lq3uNhCCd
         ahrKwW6pVLaizqsGUGVwimhlApMOPLo5+APqKGwGwGShkMMlqptC/A6ZEv3Ogr8c282D
         3EYr8nplpTWcnCs2+0ishoGi6FAt1Pva2pLtmDMG+Y0AIXFeuuvu1Jo60YI3O0E7G5IW
         iPpPBRdACSj9kZsrrkARzay/XqWc1Mto+8o7RFLrro3mLtDUOQ8FbICcIXiQHuAQc6lx
         tW5w==
X-Gm-Message-State: AOAM531uQQBjUPgH3h2c/9dR9whKr1R9Oyx/vaRVkzLEwCk1vysIxyDT
        z8O39Ut6xJ4+LFFsMt1snEvr0LuzMENKK8vsF1FtvYUFzI43HpBintXMlO8m03NRwpHeAWLNVAY
        NCC3jEM02rHbc8zwArPE6xtOct+HW0h+4JARwpNSpRg==
X-Received: by 2002:a5d:5601:: with SMTP id l1mr12951731wrv.213.1642264469931;
        Sat, 15 Jan 2022 08:34:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHswMfkkO9YJ64VDagii45fBFOZj1OVJFHlsDvp+hgYMPoSe3Qopodt69S3mp9d1IiXpQx6A==
X-Received: by 2002:a5d:5601:: with SMTP id l1mr12951707wrv.213.1642264469583;
        Sat, 15 Jan 2022 08:34:29 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id bk2sm8364725wrb.65.2022.01.15.08.34.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jan 2022 08:34:29 -0800 (PST)
Message-ID: <99e33cde-1304-a098-cd7b-8da8408d8052@canonical.com>
Date:   Sat, 15 Jan 2022 17:34:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 3/3] ARM: dts: Add support for Samsung Chagallwifi
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, semen.protsenko@linaro.org,
        virag.david003@gmail.com, martin.juecker@gmail.com,
        cw00.choi@samsung.com, m.szyprowski@samsung.com,
        alim.akhtar@samsung.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220113154019.74434-1-henrik@grimler.se>
 <20220113154019.74434-4-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113154019.74434-4-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 16:40, Henrik Grimler wrote:
> Chagallwifi, with product name Samsung Galaxy Tab S 10.5", is based on
> Exynos 5420. This device is one of several tablet models released in
> 2013 - 2014 based on Exynos 5420.
> 
> The device tree added here contains support for:
> 
> - UART
> - eMMC
> - SD card
> - USB
> 

Thanks for the patches. It is a really nice work, good job!

Some comments below.

> CCI has been disabled in the hardware, enabling it would require
> (de-)soldering a resistor on the board.  Trying to boot with it
> enabled in kernel makes the device hang when CCI is probed.
> Exynos5420-arndale-octa also has had CCI disabled due to issues [1].
> 
> To successfully boot the mainline kernel with the stock bootloader
> (SBOOT), an additional hack is needed [2]. The same hack is also
> needed to boot exynos4412-i9300 with stock bootloader, and probably
> other Samsung devices of similar age.
> 
> [1] https://marc.info/?l=linux-arm-kernel&m=141718639200624

Commits should use 'commit SHA_12char ("subject")' format instead of
links to mailing lists.

> [2] https://lore.kernel.org/all/1355276466-18295-1-git-send-email-arve@android.com/
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5420-chagallwifi.dts  |  57 ++
>  .../dts/exynos5420-galaxy-tab-common.dtsi     | 647 ++++++++++++++++++
>  3 files changed, 705 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5420-chagallwifi.dts
>  create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..be7a493ff1a1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -220,6 +220,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5420-arndale-octa.dtb \
>  	exynos5420-peach-pit.dtb \
>  	exynos5420-smdk5420.dtb \
> +	exynos5420-chagallwifi.dtb \

The name is something like Chagall WiFi, Chagall-WiFi or other
variations, because the device family name is Chagall and WiFi is variant.
Therefore here, patch 1/3, the compatible and all names, please make:
 - exynos5420-chagall-wifi.dtb
 - "samsung,chagall-wifi"
etc.

>  	exynos5422-odroidhc1.dtb \
>  	exynos5422-odroidxu3.dtb \
>  	exynos5422-odroidxu3-lite.dtb \
> diff --git a/arch/arm/boot/dts/exynos5420-chagallwifi.dts b/arch/arm/boot/dts/exynos5420-chagallwifi.dts
> new file mode 100644
> index 000000000000..51eb2bbe6bf6
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-chagallwifi.dts
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos5420 Chagallwifi board device tree source
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Copyright (c) 2022 Henrik Grimler
> + */
> +
> +/dts-v1/;
> +#include "exynos5420-galaxy-tab-common.dtsi"

Do you plan to have more Galaxy Tab versions?

> +
> +/ {
> +	model = "Samsung Chagallwifi based on exynos5420";

"Chagall WiFi"?

> +	compatible = "samsung,chagallwifi", "samsung,exynos5420", \
> +		     "samsung,exynos5";
> +};
> +
> +&s2mps11 {
> +	regulators {
> +		ldo15_reg: LDO15 {

Please define these regulator nodes in DTSI (only name needed and
comment like you have there) and override them by label (&ldo15_reg { ...).

> +			/* Unused */
> +			regulator-name = "VDD_LDO15";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		ldo17_reg: LDO17 {
> +			regulator-name = "VDD_IRLED_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3350000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo28_reg: LDO28 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO28";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		ldo29_reg: LDO29 {
> +			regulator-name = "VDD_TCON_1V8";
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <1900000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> new file mode 100644
> index 000000000000..cbcf1c117b67
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> @@ -0,0 +1,647 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Base DT for Samsung's family of tablets based on Exynos5420.
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Copyright (c) 2022 Henrik Grimler
> + */
> +
> +/dts-v1/;
> +#include "exynos5420.dtsi"
> +#include "exynos5420-cpus.dtsi"
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/samsung,s2mps11.h>
> +
> +/ {
> +	compatible = "samsung,exynos5420", "samsung,exynos5";

Skip the compatible. It duplicates exynos5420.dtsi and does not bring
any more information here.

> +	chassis-type = "tablet";
> +
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +	};
> +
> +	memory@20000000 {
> +		device_type = "memory";
> +		reg = <0x20000000 0xc0000000>;
> +	};
> +
> +	firmware@2073000 {
> +		compatible = "samsung,secure-firmware";
> +		reg = <0x02073000 0x1000>;
> +	};
> +
> +	fixed-rate-clocks {
> +		oscclk {
> +			compatible = "samsung,exynos5420-oscclk";
> +			clock-frequency = <24000000>;
> +		};
> +
> +		xxti {
> +			compatible = "samsung,clock-xxti";
> +			clock-frequency = <24000000>;
> +		};
> +
> +		xusbxti {
> +			compatible = "samsung,clock-xusbxti";
> +			clock-frequency = <24000000>;
> +		};

Just keep one clock - oscclk. We treat it as alias of xxti, even though
it might not be exactly alias. I am not sure about real differences, but
anyway the driver does not care about xxti and xusbxti. xusbxti appears
in Exynos5420 only partially, e.g. not in all places like ballmap. Other
boards have only oscclk, so let's do the same.

> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +
> +		power {

key-power and so on.

> +			debounce-interval = <10>;
> +			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
> +			label = "Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +
> +		home {
> +			debounce-interval = <10>;
> +			gpios = <&gpx0 5 GPIO_ACTIVE_LOW>;
> +			label = "Home";
> +			linux,code = <KEY_HOME>;
> +			wakeup-source;
> +		};
> +
> +		volume-up {
> +			debounce-interval = <10>;
> +			gpios = <&gpx0 2 GPIO_ACTIVE_LOW>;
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		volume-down {
> +			debounce-interval = <10>;
> +			gpios = <&gpx0 3 GPIO_ACTIVE_LOW>;
> +			label = "Volume Down";
> +			linux,code = <KEY_VOLUMEDOWN>;
> +		};
> +	};
> +};
> +
> +&cci {
> +	/* CCI is disabled in hardware */
> +	status = "disabled";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&buck2_reg>;
> +};
> +
> +&cpu4 {
> +	cpu-supply = <&buck6_reg>;
> +};
> +
> +&gpu {
> +	status = "okay";
> +	mali-supply = <&buck4_reg>;
> +};
> +
> +&hsi2c_7 {
> +	status = "okay";
> +
> +	s2mps11: pmic@66 {
> +		compatible = "samsung,s2mps11-pmic";
> +		reg = <0x66>;
> +
> +		interrupt-parent = <&gpx3>;
> +		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&s2mps11_irq>;
> +
> +		s2mps11_osc: clocks {
> +			compatible = "samsung,s2mps11-clk";
> +			#clock-cells = <1>;
> +			clock-output-names = "s2mps11_ap", "s2mps11_cp",
> +					     "s2mps11_bt";
> +		};
> +
> +		buck1_reg: BUCK1 {

All regulators should be under node "regulators". It should not work
properly without it, e.g. check
/sys/kernel/debug/regulator/regulator_summary if values match ones you
define.

> +			regulator-name = "VDD_MIF_1V1";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1300000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +				regulator-suspend-microvolt = <1100000>;

Property is deprecated and I am not sure what is it's purpose since, the
regulator is off in suspend.

> +			};
> +		};
> +
> +		buck2_reg: BUCK2 {
> +			regulator-name = "VDD_ARM_1V0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <12500>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		buck3_reg: BUCK3 {
> +			regulator-name = "VDD_INT_1V0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +				regulator-suspend-microvolt = <1100000>;

Same.

> +			};
> +		};
> +
> +		buck4_reg: BUCK4 {
> +			regulator-name = "VDD_G3D_1V0";
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <1400000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			regulator-ramp-delay = <12500>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		buck5_reg: BUCK5 {
> +			regulator-name = "VDD_MEM_1V2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		buck6_reg: BUCK6 {
> +			regulator-name = "VDD_KFC_1V0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		buck7_reg: BUCK7 {
> +			regulator-name = "VIN_LLDO_1V4";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1500000>;
> +			regulator-always-on;
> +		};
> +
> +		buck8_reg: BUCK8 {
> +			regulator-name = "VIN_MLDO_2V0";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2100000>;
> +			regulator-always-on;
> +		};
> +
> +		buck9_reg: BUCK9 {
> +			regulator-name = "VIN_HLDO_3V5";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3500000>;
> +			regulator-always-on;
> +		};
> +
> +		buck10_reg: BUCK10 {
> +			regulator-name = "VDD_CAM_ISP_1V0";
> +			regulator-min-microvolt = <750000>;
> +			regulator-max-microvolt = <3550000>;
> +		};
> +
> +		ldo1_reg: LDO1 {
> +			regulator-name = "VDD_ALIVE_1.0V";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-always-on;
> +		};
> +
> +		ldo2_reg: LDO2 {
> +			regulator-name = "VDD_APIO_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo3_reg: LDO3 {
> +			regulator-name = "VDD_APIO_MMC2_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo4_reg: LDO4 {
> +			regulator-name = "VDD_ADC_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo5_reg: LDO5 {
> +			/* Unused */
> +			regulato-name = "VDD_LDO5";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		ldo6_reg: LDO6 {
> +			regulator-name = "VDD_MIPI_1V0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo7_reg: LDO7 {
> +			regulator-name = "VDD_MIPI_PLL_ABB1_18V";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo8_reg: LDO8 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +		ldo9_reg: LDO9 {
> +			regulator-name = "VDD_UOTG_3V0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo10_reg: LDO10 {
> +			regulator-name = "VDDQ_PRE_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo11_reg: LDO11 {
> +			regulator-name = "VDD_HSIC_1V0";
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo12_reg: LDO12 {
> +			regulator-name = "VDD_HSIC_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +		};
> +
> +		ldo13_reg: LDO13 {
> +			regulator-name = "VDD_APIO_MMC2_2V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo14_reg: LDO14 {
> +			regulator-name = "VDD_MOTOR_3V0";
> +			regulator-min-microvolt = <3000000>;
> +			regulator-max-microvolt = <3000000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		/*
> +		 * LDO15 varies between devices and is
> +		 * specified in the device dts
> +		 */

Do it like ldo25 in arch/arm/boot/dts/exynos4412-midas.dtsi. Comment is
good.

> +
> +		ldo16_reg: LDO16 {
> +			regulator-name = "VDD_AP_2V8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +			};
> +		};
> +
> +		/*
> +		 * LDO17 varies between devices and is
> +		 * specified in the device dts
> +		 */
> +
> +		ldo18_reg: LDO18 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO18";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +		};
> +
> +
> +		ldo19_reg: LDO19 {
> +			regulator-name = "VDD_VTF_2V8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo20_reg: LDO20 {
> +			regulator-name = "VDD_CAM1_CAM_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo21_reg: LDO21 {
> +			regulator-name = "VDD_CAM_IO_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo22_reg: LDO22 {
> +			regulator-name = "VDD_CAM0_S_CORE_1V1";
> +			regulator-min-microvolt = <1050000>;
> +			regulator-max-microvolt = <1200000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo23_reg: LDO23 {
> +			regulator-name = "VDD_MIFS_1V1";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1100000>;
> +			regulator-always-on;
> +
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +			};
> +		};
> +
> +		ldo24_reg: LDO24 {
> +			regulator-name = "VDD_TSP_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo25_reg: LDO25 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO25";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3950000>;
> +		};
> +
> +		ldo26_reg: LDO26 {
> +			regulator-name = "VDD_CAM0_AF_2V8";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <2800000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo27_reg: LDO27 {
> +			regulator-name = "VDD_G3DS_1V0";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <1000000>;
> +			regulator-always-on;
> +
> +			regulator-state-mem {
> +				regulator-on-in-suspend;
> +			};
> +		};
> +
> +		/*
> +		 * LDO28 and LDO29 varies between devices and
> +		 * are specified in the device dts
> +		 */
> +
> +		ldo30_reg: LDO30 {
> +			regulator-name = "VDD_TOUCH_1V8";
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <1900000>;

Name is 1.8V, voltage is 1.9V. Double check this one :)

> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo31_reg: LDO31 {
> +			regulator-name = "VDD_GRIP_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +			regulator-boot-on;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo32_reg: LDO32 {
> +			regulator-name = "VDD_TSP_1V8";
> +			regulator-min-microvolt = <1900000>;
> +			regulator-max-microvolt = <1900000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo33_reg: LDO33 {
> +			regulator-name = "VDD_MHL_1V8";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo34_reg: LDO34 {
> +			regulator-name = "VDD_MHL_3V3";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo35_reg: LDO35 {
> +			regulator-name = "VDD_SIL_1V2";
> +			regulator-min-microvolt = <1200000>;
> +			regulator-max-microvolt = <1200000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +
> +		ldo36_reg: LDO36 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO36";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3950000>;
> +		};
> +
> +		ldo37_reg: LDO37 {
> +			/* Unused */
> +			regulator-name = "VDD_LDO37";
> +			regulator-min-microvolt = <800000>;
> +			regulator-max-microvolt = <3950000>;
> +		};
> +
> +		ldo38_reg: LDO38 {
> +			regulator-name = "VDD_KEY_LED_3V3";
> +			regulator-min-microvolt = <2500000>;
> +			regulator-max-microvolt = <3300000>;
> +
> +			regulator-state-mem {
> +				regulator-off-in-suspend;
> +			};
> +		};
> +	};
> +};
> +
> +&mixer {
> +	status = "okay";
> +};
> +
> +/* Internal storage */
> +&mmc_0 {
> +	status = "okay";
> +	non-removable;
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	pinctrl-names = "default", "output";
> +	clk_pin = &sd0_clk;
> +	clk_val = <0x3>;

I think these two are not supported properties.

> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +	vmmc-supply = <&ldo3_reg>;
> +	vqmmc-supply = <&ldo13_reg>;
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +};
> +
> +/* External sdcard */
> +&mmc_2 {
> +	status = "okay";
> +	card-detect-delay = <200>;
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;

You should define here also pins, something like Arndale Octa has.

> +};
> +
> +&pinctrl_0 {
> +	s2mps11_irq: s2mps11-irq-pins {
> +		samsung,pins = "gpx3-2";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> +		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
> +		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV1>;
> +	};
> +};
> +


Best regards,
Krzysztof
