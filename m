Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811FC48FE34
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 18:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbiAPRhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 12:37:20 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49974
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235887AbiAPRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 12:37:18 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 280B13F17B
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642354637;
        bh=d8Rxpb1DVvCCKOBa3tH+wuRa4fXuavOCbPjy2KJ4qmo=;
        h=Message-ID:Date:MIME-Version:Subject:To:References:From:
         In-Reply-To:Content-Type;
        b=eZ5CdegY2YnHiDQucJoBghHXIr+NZvyv2lfzbr+H2vJx2QaKSwDhAs8vejl7scYLV
         NjWaj4SGQScVv2L+J+CPT9fhdBs+4i/nPbWm/Vr8MQwnrigJvy4QuPuz91aTwNqicn
         JzB4uTUR/B6vqUxB9pIZRO3ZtCJ2PTdMiMY5jSyo9FR6AhYRnJf2uZTN81Ulq/VtQk
         /vZ3wD6WDieqQZY9RFQcgrf9563Cwz4gHh1/ptw9jbNWz6aOeC52zHT5KGOI2bCsaj
         MUOf46BtJxQocvp/kGn7oGXGKjnghEhMMg5Ppd/Ux+aMDez57qF06g9kJBgDJvMmxc
         mpe67kqDgIFfw==
Received: by mail-ed1-f70.google.com with SMTP id s9-20020aa7d789000000b004021d03e2dfso1960839edq.18
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 09:37:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=d8Rxpb1DVvCCKOBa3tH+wuRa4fXuavOCbPjy2KJ4qmo=;
        b=00WdoDEAQqrNgdKWYfFACaBXUs8se3+xonvaAhSR8dh7lZor8xNkVXS+T8/lgteljl
         /DyFV2AFEPwmaFcsHO/2Y4fBqWGwVr9a9h0qN5yK6IYt57gVEcAgZZFfipmq0h6NA8Fv
         frlbZ8qS+tkVuYhJZO2BYqGcPYcp8mgIE6BXEEtfTWbO20/3sTW1ltwXK5/9nI/xTOxD
         MZOQKGERHj1DZfqZTUX2ZGPHQMZDesi0DYUdWWVc0qDp+U3dw8sa3VgfRk+psHlXO2cd
         iovrlVbImkevmjES3lAREHMCbtGS7K4uJ0mLUf2oNq84r3S+Jd7YePdEM+9YwuaTZUQj
         0HUQ==
X-Gm-Message-State: AOAM531Y+xMBUOERfphG2MhnCpUE1CdRAh0/2j+oZs9ZK5mCi5NsT67G
        AgSzlUGC/m/iA6kNpBX2EYdrzkFDLU8k5DUMyBqZaFQqqyRYObC2KGFzuUwI/HpWjMufRGVi8l+
        zUjfLGS92qwE71osW+PNTSM9pLpnDiz+xXCMfaPzKMw==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr1624335edd.337.1642354636680;
        Sun, 16 Jan 2022 09:37:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNhUPOd1XpQ2Kxhemh5FZkaGPURuar0gitP/oBWCCNLcZFIW4Fp6+chb9eRYlIgpjJp3Nnsw==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr1624321edd.337.1642354636450;
        Sun, 16 Jan 2022 09:37:16 -0800 (PST)
Received: from [192.168.0.35] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id b2sm4764400edv.37.2022.01.16.09.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 09:37:16 -0800 (PST)
Message-ID: <ca8c4613-a058-6cde-f9e6-8530f142a821@canonical.com>
Date:   Sun, 16 Jan 2022 18:37:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v3 3/3] ARM: dts: Add support for Samsung Chagall WiFi
Content-Language: en-US
To:     Henrik Grimler <henrik@grimler.se>, semen.protsenko@linaro.org,
        virag.david003@gmail.com, martin.juecker@gmail.com,
        cw00.choi@samsung.com, m.szyprowski@samsung.com,
        alim.akhtar@samsung.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220116165035.437274-1-henrik@grimler.se>
 <20220116165035.437274-4-henrik@grimler.se>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220116165035.437274-4-henrik@grimler.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2022 17:50, Henrik Grimler wrote:
> Chagall WiFi, with product name Samsung Galaxy Tab S 10.5", is based
> on Exynos 5420.  This device is one of several tablet models released
> in 2014 based on Exynos 5420.
> 
> The device tree added here contains support for:
> 
> - UART
> - eMMC
> - SD card
> - USB
> 
> CCI has been disabled in the hardware, enabling it would require
> (de-)soldering a resistor on the board.  Trying to boot with it
> enabled in kernel makes the device hang when CCI is probed.
> Exynos5420-arndale-octa also has had CCI disabled due to issues, see
> commit 25217fef3551 ("ARM: dts: disable CCI on exynos5420 based
> arndale-octa").
> 
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/exynos5420-chagall-wifi.dts |  65 ++
>  .../dts/exynos5420-galaxy-tab-common.dtsi     | 666 ++++++++++++++++++
>  3 files changed, 732 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos5420-chagall-wifi.dts
>  create mode 100644 arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 0de64f237cd8..088fcedb3212 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -220,6 +220,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
>  	exynos5420-arndale-octa.dtb \
>  	exynos5420-peach-pit.dtb \
>  	exynos5420-smdk5420.dtb \
> +	exynos5420-chagall-wifi.dtb \
>  	exynos5422-odroidhc1.dtb \
>  	exynos5422-odroidxu3.dtb \
>  	exynos5422-odroidxu3-lite.dtb \
> diff --git a/arch/arm/boot/dts/exynos5420-chagall-wifi.dts b/arch/arm/boot/dts/exynos5420-chagall-wifi.dts
> new file mode 100644
> index 000000000000..2cc5cd01e8c6
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-chagall-wifi.dts
> @@ -0,0 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's Exynos5420 Chagall WiFi board device tree source
> + *
> + * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + * Copyright (c) 2022 Henrik Grimler
> + */
> +
> +/dts-v1/;
> +#include "exynos5420-galaxy-tab-common.dtsi"
> +
> +/ {
> +	model = "Samsung Chagall WiFi based on Exynos5420";
> +	compatible = "samsung,chagall-wifi", "samsung,exynos5420", \
> +		     "samsung,exynos5";
> +};
> +
> +&ldo15_reg {
> +	/* Unused */
> +	regulator-name = "VDD_LDO15";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +};
> +
> +&ldo17_reg {
> +	regulator-name = "VDD_IRLED_3V3";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3350000>;
> +	regulator-always-on;
> +	regulator-boot-on;
> +
> +	regulator-state-mem {
> +		regulator-off-in-suspend;
> +	};
> +};
> +
> +&ldo28_reg {
> +	/* Unused */
> +	regulator-name = "VDD_LDO28";
> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +};
> +
> +&ldo29_reg {
> +	regulator-name = "VDD_TCON_1V8";
> +	regulator-min-microvolt = <1900000>;
> +	regulator-max-microvolt = <1900000>;
> +
> +	regulator-state-mem {
> +		regulator-off-in-suspend;
> +	};
> +};
> +
> +&ldo31_reg {
> +	regulator-name = "VDD_GRIP_1V8";
> +	regulator-min-microvolt = <1800000>;
> +	regulator-max-microvolt = <1800000>;
> +	regulator-always-on;
> +	regulator-boot-on;
> +
> +	regulator-state-mem {
> +		regulator-off-in-suspend;
> +	};
> +};
> diff --git a/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> new file mode 100644
> index 000000000000..119e4e7a8328
> --- /dev/null
> +++ b/arch/arm/boot/dts/exynos5420-galaxy-tab-common.dtsi
> @@ -0,0 +1,666 @@
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
> +	chassis-type = "tablet";
> +
> +	/*
> +	 * To successfully boot the mainline kernel with the stock
> +	 * bootloader (SBOOT), the tlb needs to be flushed after the
> +	 * page table pointer has been updated in __common_mmu_cache_on.
> +	 * The same hack is also needed to boot exynos4412-i9300 with
> +	 * stock bootloader, and probably other Samsung devices of
> +	 * similar age.  See
> +	 * https://lore.kernel.org/all/1355276466-18295-1-git-send-email-arve@android.com
> +	 * for more details.
> +	 */
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
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +
> +		key-power {
> +			debounce-interval = <10>;
> +			gpios = <&gpx2 2 GPIO_ACTIVE_LOW>;
> +			label = "Power";
> +			linux,code = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +
> +		key-home {
> +			debounce-interval = <10>;
> +			gpios = <&gpx0 5 GPIO_ACTIVE_LOW>;
> +			label = "Home";
> +			linux,code = <KEY_HOME>;
> +			wakeup-source;
> +		};
> +
> +		key-volume-up {
> +			debounce-interval = <10>;
> +			gpios = <&gpx0 2 GPIO_ACTIVE_LOW>;
> +			label = "Volume Up";
> +			linux,code = <KEY_VOLUMEUP>;
> +		};
> +
> +		key-volume-down {
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
> +	pmic@66 {
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
> +		regulators {
> +			buck1_reg: BUCK1 {
> +				regulator-name = "VDD_MIF_1V1";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1300000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck2_reg: BUCK2 {
> +				regulator-name = "VDD_ARM_1V0";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck3_reg: BUCK3 {
> +				regulator-name = "VDD_INT_1V0";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck4_reg: BUCK4 {
> +				regulator-name = "VDD_G3D_1V0";
> +				regulator-min-microvolt = <700000>;
> +				regulator-max-microvolt = <1400000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck5_reg: BUCK5 {
> +				regulator-name = "VDD_MEM_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			buck6_reg: BUCK6 {
> +				regulator-name = "VDD_KFC_1V0";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			buck7_reg: BUCK7 {
> +				regulator-name = "VIN_LLDO_1V4";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1500000>;
> +				regulator-always-on;
> +			};
> +
> +			buck8_reg: BUCK8 {
> +				regulator-name = "VIN_MLDO_2V0";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2100000>;
> +				regulator-always-on;
> +			};
> +
> +			buck9_reg: BUCK9 {
> +				regulator-name = "VIN_HLDO_3V5";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3500000>;
> +				regulator-always-on;
> +			};
> +
> +			buck10_reg: BUCK10 {
> +				regulator-name = "VDD_CAM_ISP_1V0";
> +				regulator-min-microvolt = <750000>;
> +				regulator-max-microvolt = <3550000>;
> +			};
> +
> +			ldo1_reg: LDO1 {
> +				regulator-name = "VDD_ALIVE_1.0V";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +			};
> +
> +			ldo2_reg: LDO2 {
> +				regulator-name = "VDD_APIO_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo3_reg: LDO3 {
> +				regulator-name = "VDD_APIO_MMC01_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo4_reg: LDO4 {
> +				regulator-name = "VDD_ADC_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo5_reg: LDO5 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO5";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo6_reg: LDO6 {
> +				regulator-name = "VDD_MIPI_1V0";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo7_reg: LDO7 {
> +				regulator-name = "VDD_MIPI_PLL_ABB1_18V";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo8_reg: LDO8 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +			ldo9_reg: LDO9 {
> +				regulator-name = "VDD_UOTG_3V0";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "VDDQ_PRE_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo11_reg: LDO11 {
> +				regulator-name = "VDD_HSIC_1V0";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "VDD_HSIC_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +			};
> +
> +			ldo13_reg: LDO13 {
> +				regulator-name = "VDD_APIO_MMC2_2V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo14_reg: LDO14 {
> +				regulator-name = "VDD_MOTOR_3V0";
> +				regulator-min-microvolt = <3000000>;
> +				regulator-max-microvolt = <3000000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "LDO15";
> +				/*
> +				 * LDO15 varies between devices and is
> +				 * specified in the device dts
> +				 */
> +			};
> +
> +			ldo16_reg: LDO16 {
> +				regulator-name = "VDD_AP_2V8";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +				regulator-always-on;
> +				regulator-boot-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			ldo17_reg: LDO17 {
> +				regulator-name = "LDO17";
> +				/*
> +				 * LDO17 varies between devices and is
> +				 * specified in the device dts
> +				 */
> +			};
> +
> +			ldo18_reg: LDO18 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO18";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +			};
> +
> +
> +			ldo19_reg: LDO19 {
> +				regulator-name = "VDD_VTF_2V8";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo20_reg: LDO20 {
> +				regulator-name = "VDD_CAM1_CAM_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo21_reg: LDO21 {
> +				regulator-name = "VDD_CAM_IO_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo22_reg: LDO22 {
> +				regulator-name = "VDD_CAM0_S_CORE_1V1";
> +				regulator-min-microvolt = <1050000>;
> +				regulator-max-microvolt = <1200000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo23_reg: LDO23 {
> +				regulator-name = "VDD_MIFS_1V1";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1100000>;
> +				regulator-always-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			ldo24_reg: LDO24 {
> +				regulator-name = "VDD_TSP_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo25_reg: LDO25 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO25";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
> +			ldo26_reg: LDO26 {
> +				regulator-name = "VDD_CAM0_AF_2V8";
> +				regulator-min-microvolt = <2800000>;
> +				regulator-max-microvolt = <2800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo27_reg: LDO27 {
> +				regulator-name = "VDD_G3DS_1V0";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +
> +				regulator-state-mem {
> +					regulator-on-in-suspend;
> +				};
> +			};
> +
> +			ldo28_reg: LDO28 {
> +				regulator-name = "LDO28";
> +				/*
> +				 * LDO28 varies between devices and is
> +				 * specified in the device dts
> +				 */
> +			};
> +
> +			ldo29_reg: LDO29 {
> +				regulator-name = "LDO29";
> +				/*
> +				 * LDO29 varies between devices and is
> +				 * specified in the device dts
> +				 */
> +			};
> +
> +			ldo30_reg: LDO30 {
> +				regulator-name = "VDD_TOUCH_1V8";
> +				regulator-min-microvolt = <1900000>;
> +				regulator-max-microvolt = <1900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo31_reg: LDO31 {
> +				regulator-name = "LDO31";
> +				/*
> +				 * LDO31 varies between devices and is
> +				 * specified in the device dts
> +				 */
> +			};
> +
> +			ldo32_reg: LDO32 {
> +				regulator-name = "VDD_TSP_1V8";
> +				regulator-min-microvolt = <1900000>;
> +				regulator-max-microvolt = <1900000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo33_reg: LDO33 {
> +				regulator-name = "VDD_MHL_1V8";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo34_reg: LDO34 {
> +				regulator-name = "VDD_MHL_3V3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo35_reg: LDO35 {
> +				regulator-name = "VDD_SIL_1V2";
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <1200000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
> +			};
> +
> +			ldo36_reg: LDO36 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO36";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
> +			ldo37_reg: LDO37 {
> +				/* Unused */
> +				regulator-name = "VDD_LDO37";
> +				regulator-min-microvolt = <800000>;
> +				regulator-max-microvolt = <3950000>;
> +			};
> +
> +			ldo38_reg: LDO38 {
> +				regulator-name = "VDD_KEY_LED_3V3";
> +				regulator-min-microvolt = <2500000>;
> +				regulator-max-microvolt = <3300000>;
> +
> +				regulator-state-mem {
> +					regulator-off-in-suspend;
> +				};
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
> +	bus-width = <8>;
> +	cap-mmc-highspeed;
> +	card-detect-delay = <200>;
> +	mmc-hs200-1_8v;
> +	non-removable;
> +	pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8>;
> +	pinctrl-names = "default";
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	vqmmc-supply = <&ldo3_reg>;
> +};
> +
> +/* External sdcard */
> +&mmc_2 {
> +	status = "okay";
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	card-detect-delay = <200>;
> +	pinctrl-0 = <&sd2_clk &sd2_cmd &mmc2_cd &sd2_bus1 &sd2_bus4>;
> +	pinctrl-names = "default";
> +	samsung,dw-mshc-ciu-div = <3>;
> +	samsung,dw-mshc-ddr-timing = <0 2>;
> +	samsung,dw-mshc-sdr-timing = <0 4>;
> +	sd-uhs-sdr50;
> +	vmmc-supply = <&ldo19_reg>;
> +	vqmmc-supply = <&ldo13_reg>;
> +};
> +
> +&pinctrl_0 {
> +	mmc2_cd: sd2-cd-pins {
> +		samsung,pins = "gpx2-4";

Interesting... I looked at vendor sources to board-chagall and standard
pin gpc2-2 is mentioned as PULL down and not-connected comment.

gpx2-4 seems not mentioned at all, unless other board files are actually
used.

Anyway, if it works for you, it's good.

Rest looks ok, I'll apply after the merge window.

Best regards,
Krzysztof
