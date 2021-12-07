Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6446B798
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 10:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhLGJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 04:42:50 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60406
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhLGJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 04:42:49 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CD3543F1AF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638869958;
        bh=uEdzsbh7DUFjaEW1MrJ3iwdHbloi/JPYU0s/FsrdtCc=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qjNF7NlO6lm4p4ZtfYN2vwf7XLh3/dv0xFFdlOiqh+VxBeHP47NZSHl74jgP8a+W5
         gK4QOrM1tPrNlm0xnaq4a61dykS+iJ0e1N/rEPO275/TnnXrT9stQrc+9kTN7NBISZ
         tovEtleJLWOZd10JqpSH+aLfygLAXB5bDVYid1b7pnuvzQcycdJUeBLyDx2pUIzy+v
         Y8ukbxIGm7o/w5auZlORQtq+Rx+YjXSG8RaDdDcyI4j/GvyM+8imsHlXWBm2zNxmpt
         UdGu+bn14/YVVNEoheOeYIxYfFxCT8lKBtBj3+ekPSkWhM4SWQEH1jciOBMC7RBDWM
         OPvxxnh1mczEQ==
Received: by mail-lj1-f199.google.com with SMTP id h17-20020a05651c125100b0021ba28cf54dso4321881ljh.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 01:39:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uEdzsbh7DUFjaEW1MrJ3iwdHbloi/JPYU0s/FsrdtCc=;
        b=U9ydQ4G03z/qJ9mpVWihW2Ffw6fJCJ2jARC5cEBpT+HXhthzISXg3vO3rvvIaw8f9V
         4jZPqlQzNsdCGLb6TIN3fcci0VeWgMkCBoyirPBdLcf3TIooT32ldFPR5EwEQbn5J+a4
         whL+7kJH8v+cBQuXvUSr/CASHftRj6l0nG5so7W8D2pgAXHyXREGziRREHnDiTL28pUA
         jOnlK4wOmOF67+hCI5KGo2tfSiDodtolxPwgIr/2iR2Ia9f9kunHSePwZuTEMy/bQ5uC
         kYajVIWwLhcAs+atgL5VKCemaAIPuda/c8Se9NK0m/OLLBAWHtAFD3kOxMs/6DWDPBD4
         P05w==
X-Gm-Message-State: AOAM530ORyOaSRp21AFjy6KMQbRfxpg4P7T3/DWC72B0j6NC1RZWIv8T
        cjaEqrgw0Yf4LPZ6qEUWIsD+6uEdJryJjuDvTKFNUhDJhvMBgcsOvLzWwzRB0RVQds6kpzLnVuF
        q/4MkZekZBZ9gVNJ8MUs8cn0hdSo54humNnLljgMh0w==
X-Received: by 2002:a2e:b171:: with SMTP id a17mr40101091ljm.56.1638869955350;
        Tue, 07 Dec 2021 01:39:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPF6dRMijVa0sGb1VmTlmIH0YN7kNVz2/ncEi8oClJ5+ecKq1odNRNHOYLWYQQZaa/hP32Rw==
X-Received: by 2002:a2e:b171:: with SMTP id a17mr40101072ljm.56.1638869955129;
        Tue, 07 Dec 2021 01:39:15 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id w17sm1585450ljh.15.2021.12.07.01.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 01:39:14 -0800 (PST)
Message-ID: <2ec3ed8f-e012-b6ac-b3ea-67f766902b41@canonical.com>
Date:   Tue, 7 Dec 2021 10:39:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-8-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211206153124.427102-8-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2021 16:31, David Virag wrote:
> Add initial Exynos7885 device tree nodes with dts for the Samsung Galaxy
> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> Currently this includes some clock support, UART support, and I2C nodes.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---
> Changes in v2:
>   - Remove address-cells, and size-cells from dts, since they are
>     already in the dtsi.
>   - Lower case hex in memory node
>   - Fix node names with underscore instead of hyphen
>   - Fix line breaks
>   - Fix "-key" missing from gpio keys node names
>   - Use the form without "key" in gpio key labels on all keys
>   - Suffix pin configuration node names with "-pins"
>   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
>   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
>   - Add comment about Arm PMU
>   - Rename "clock-oscclk" to "osc-clock"
>   - Include exynos-syscon-restart.dtsi instead of rewriting its contents
> 
> Changes in v3:
>   - Fix typo (seperate -> separate)
> 
> Changes in v4:
>   - Fixed leading 0x in clock-controller nodes
>   - Actually suffixed pin configuration node names with "-pins"
>   - Seperated Cortex-A53 and Cortex-A73 PMU
> 
>  arch/arm64/boot/dts/exynos/Makefile           |   7 +-
>  .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
>  .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865 ++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
>  4 files changed, 1402 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
> 

(...)

> +
> +	gpp8: gpp8 {
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +	};
> +
> +	/* DECON TE */
> +	decon_f_te_on: decon_f_te_on-pins {
> +		samsung,pins = "gpc0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
> +	};
> +
> +	decon_f_te_off: decon_f_te_off-pins {

Drop these, similarly to FIMC. Only one pin configuration will be used
when you add DECON support, not two. If you wish to keep one, the proper
for DECON operating state, this also needs fixing of underscores->hyphens.

> +		samsung,pins = "gpc0-3";
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +	};
> +

(...)

> diff --git a/arch/arm64/boot/dts/exynos/exynos7885.dtsi b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> new file mode 100644
> index 000000000000..cc7a5ce0c103
> --- /dev/null
> +++ b/arch/arm64/boot/dts/exynos/exynos7885.dtsi
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung Exynos7885 SoC device tree source
> + *
> + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2021 Dávid Virág
> + *
> + */
> +
> +#include <dt-bindings/clock/exynos7885.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "samsung,exynos7885";
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	interrupt-parent = <&gic>;
> +
> +	aliases {
> +		pinctrl0 = &pinctrl_alive;
> +		pinctrl1 = &pinctrl_dispaud;
> +		pinctrl2 = &pinctrl_fsys;
> +		pinctrl3 = &pinctrl_top;
> +	};
> +
> +	arm-a53-pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 218 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 219 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu0>,
> +				     <&cpu1>,
> +				     <&cpu2>,
> +				     <&cpu3>,
> +				     <&cpu4>,
> +				     <&cpu5>;
> +	};
> +
> +	arm-a73-pmu {
> +		compatible = "arm,cortex-a73-pmu";
> +		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpu6>,
> +				     <&cpu7>;
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +				core4 {
> +					cpu = <&cpu4>;
> +				};
> +				core5 {
> +					cpu = <&cpu5>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpu6>;
> +				};
> +				core1 {
> +					cpu = <&cpu7>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@100 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x100>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu1: cpu@101 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x101>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu2: cpu@102 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x102>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu3: cpu@103 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x103>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu4: cpu@200 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x200>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu5: cpu@201 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x201>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu6: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +		};
> +
> +		cpu7: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +		cpu_suspend = <0xc4000001>;
> +		cpu_off = <0x84000002>;
> +		cpu_on = <0xc4000003>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		/* Hypervisor Virtual Timer interrupt is not wired to GIC */
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +
> +	fixed-rate-clocks {
> +		oscclk: osc-clock {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <26000000>;
> +			clock-output-names = "oscclk";
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x0 0x20000000>;
> +
> +		chipid@10000000 {
> +			compatible = "samsung,exynos850-chipid";
> +			reg = <0x10000000 0x24>;
> +		};
> +
> +		gic: interrupt-controller@12301000 {
> +			compatible = "arm,gic-400";
> +			#interrupt-cells = <3>;
> +			#address-cells = <0>;
> +			interrupt-controller;
> +			reg = <0x12301000 0x1000>,
> +			      <0x12302000 0x2000>,
> +			      <0x12304000 0x2000>,
> +			      <0x12306000 0x2000>;
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) |
> +						 IRQ_TYPE_LEVEL_HIGH)>;
> +		};
> +
> +		cmu_peri: clock-controller@10010000 {
> +			compatible = "samsung,exynos7885-cmu-peri";
> +			reg = <0x10010000 0x8000>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&oscclk>,
> +				 <&cmu_top CLK_DOUT_PERI_BUS>,
> +				 <&cmu_top CLK_DOUT_PERI_SPI0>,
> +				 <&cmu_top CLK_DOUT_PERI_SPI1>,
> +				 <&cmu_top CLK_DOUT_PERI_UART0>,
> +				 <&cmu_top CLK_DOUT_PERI_UART1>,
> +				 <&cmu_top CLK_DOUT_PERI_UART2>,
> +				 <&cmu_top CLK_DOUT_PERI_USI0>,
> +				 <&cmu_top CLK_DOUT_PERI_USI1>,
> +				 <&cmu_top CLK_DOUT_PERI_USI2>;
> +			clock-names = "oscclk",
> +				      "dout_peri_bus",
> +				      "dout_peri_spi0",
> +				      "dout_peri_spi1",
> +				      "dout_peri_uart0",
> +				      "dout_peri_uart1",
> +				      "dout_peri_uart2",
> +				      "dout_peri_usi0",
> +				      "dout_peri_usi1",
> +				      "dout_peri_usi2";
> +		};
> +
> +		cmu_core: clock-controller@12000000 {
> +			compatible = "samsung,exynos7885-cmu-core";
> +			reg = <0x12000000 0x8000>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&oscclk>,
> +				 <&cmu_top CLK_DOUT_CORE_BUS>,
> +				 <&cmu_top CLK_DOUT_CORE_CCI>,
> +				 <&cmu_top CLK_DOUT_CORE_G3D>;
> +			clock-names = "oscclk", "dout_core_bus", "dout_core_cci", "dout_core_g3d";
> +		};
> +
> +		cmu_top: clock-controller@12060000 {
> +			compatible = "samsung,exynos7885-cmu-top";
> +			reg = <0x12060000 0x8000>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&oscclk>;
> +			clock-names = "oscclk";
> +		};
> +
> +		pinctrl_alive: pinctrl@11cb0000 {
> +			compatible = "samsung,exynos7885-pinctrl";
> +			reg = <0x11cb0000 0x1000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			wakeup-interrupt-controller {
> +				compatible = "samsung,exynos7-wakeup-eint";
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		pinctrl_dispaud: pinctrl@148f0000 {

Let's bring some order - put pinctrl nodes within each other ordered by
unit address. The ordering of other nodes is okay, we never actually
enforced any logic here.

> +			compatible = "samsung,exynos7885-pinctrl";
> +			reg = <0x148f0000 0x1000>;
> +			interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_fsys: pinctrl@13430000 {
> +			compatible = "samsung,exynos7885-pinctrl";
> +			reg = <0x13430000 0x1000>;
> +			interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		pinctrl_top: pinctrl@139b0000 {
> +			compatible = "samsung,exynos7885-pinctrl";
> +			reg = <0x139b0000 0x1000>;
> +			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +


Best regards,
Krzysztof
