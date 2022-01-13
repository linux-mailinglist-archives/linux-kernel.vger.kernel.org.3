Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E248648D8A3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiAMNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 08:17:00 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:52164
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232469AbiAMNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 08:16:59 -0500
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7DE4B3F1C6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 13:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642079818;
        bh=SWu9GtzKfAAkAqkjGVyrQ+gsbFPqLjPr4PE2qBi1LSQ=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=b4xoQy2OW9DhZyqOfSZ2U2WKW+0O8AjZhoCk1XlwkSGwESS9EjjH2T9tMFGBLIACq
         rbT2VuGEFlZc3CyzeRPmQ/qN17C1oUgxFyyhmRohhZpi3nRiJJ7F04XEMVpPX3qRi+
         xfw55jTLtrUPiN1StIlgjsEmDVAmBAZnB7WBNNeobFTV4aD6W1uiMExKWStlNbRBgg
         K7JI48hG9gFvF/5ZCH01YL+KNE/c3rEHqFErGXiLagSOBV1sq0kCl3U3qm4GLI0yxk
         wjAN0WSs08ecdbW5Jjl4kXTd0mtfz9lZz3wg1aLxRhWwSV955w/14UnST4sE8V4mow
         /jHn9/KanBgAg==
Received: by mail-wm1-f72.google.com with SMTP id n13-20020a05600c3b8d00b0034979b7e200so1220756wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 05:16:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SWu9GtzKfAAkAqkjGVyrQ+gsbFPqLjPr4PE2qBi1LSQ=;
        b=1yugV9CIPMQZcr7jkZWpvAWfjOrI6NykG+omikD3GJ5JynupYqjmpNpKG93tb11fzL
         7/S4LNpHySLqQ3Nn7fxPwqkvuxKCYO7T9cKKq8wlsKHWKDMb6jE3Hi4P206ulDzBLQuU
         duP5tTZ1tBFC50tmJHbJVWZ7dOe0xKKdTBqZMLzx5BfhWykzYEaCLNrKvMz3NoHhu8O3
         +td5RTjGg0+hEvPskuWxCf7hoMUbQetg7yc5aePwM6Q4WJP9cGwa4UB5ZzXatvZB/4bh
         iINIIJLI3OYt4PgUQfm6okVHmVpfUWdEw8D18zRXBBhhoi5DSZ/6DS/erOp2Xj61UZi+
         s54w==
X-Gm-Message-State: AOAM531W+zZiWMHETHMocFyYF/qvK4pC2UhEgt6I6O6P/FYncgJht9l1
        HaKmt38poBW2WQlbIKGM/ZepBJWErdwgQ8kpxX8byHA26aL+xc/nY7K+tBs6qKJCq8qJJJkWQNB
        f8D5fQkPWiY0+FOJ5aEeAUV3PFV+PO16sO/suvCbhyg==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr3804461wmb.156.1642079816758;
        Thu, 13 Jan 2022 05:16:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwEcBSM+qw3BDvyUY4p30/6o2t8M47GLa1F3YbSnQ1XPnrrkzAQ+41UGc+05usdsl87EE/aXw==
X-Received: by 2002:a1c:cc08:: with SMTP id h8mr3804434wmb.156.1642079816383;
        Thu, 13 Jan 2022 05:16:56 -0800 (PST)
Received: from [192.168.0.30] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p62sm2403557wmp.10.2022.01.13.05.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jan 2022 05:16:55 -0800 (PST)
Message-ID: <55c22c3a-57ea-3320-ccb9-f03643563235@canonical.com>
Date:   Thu, 13 Jan 2022 14:16:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 14/23] arm64: dts: fsd: Add initial device tree support
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, s.nawrocki@samsung.com,
        linux-samsung-soc@vger.kernel.org, pankaj.dubey@samsung.com,
        linux-fsd@tesla.com, Arjun K V <arjun.kv@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Sriranjani P <sriranjani.p@samsung.com>,
        Chandrasekar R <rcsekar@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
 <CGME20220113122413epcas5p46cb2cafb73936c423017240f98f72845@epcas5p4.samsung.com>
 <20220113121143.22280-15-alim.akhtar@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220113121143.22280-15-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2022 13:11, Alim Akhtar wrote:
> Add initial device tree support for "Full Self-Driving" (FSD) SoC
> This SoC contain three clusters of four cortex-a72 CPUs and various
> peripheral IPs.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> Signed-off-by: Sriranjani P <sriranjani.p@samsung.com>
> Signed-off-by: Chandrasekar R <rcsekar@samsung.com>
> Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  MAINTAINERS                        |   8 +
>  arch/arm64/Kconfig.platforms       |   6 +
>  arch/arm64/boot/dts/Makefile       |   1 +
>  arch/arm64/boot/dts/tesla/Makefile |   3 +
>  arch/arm64/boot/dts/tesla/fsd.dts  | 140 ++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi | 715 +++++++++++++++++++++++++++++
>  6 files changed, 873 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/tesla/Makefile
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd.dts
>  create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7168aa..02d56909c5e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2726,6 +2726,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/tegra-cec.txt
>  F:	drivers/media/cec/platform/tegra/
>  
> +ARM/TESLA FSD SoC SUPPORT
> +M:	Alim Akhtar <alim.akhtar@samsung.com>
> +M:	linux-fsd@tesla.com
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-samsung-soc@vger.kernel.org
> +S:	Maintained
> +F:	arch/arm64/boot/dts/tesla*
> +

+Cc Arnd,

Please Cc all SoC maintainers in new sub-architecture submissions, so
Olof and Arnd.

>  ARM/TETON BGA MACHINE SUPPORT
>  M:	"Mark F. Brown" <mark.brown314@gmail.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 54e3910e8b9b..bb8a047c2359 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -267,6 +267,12 @@ config ARCH_TEGRA
>  	help
>  	  This enables support for the NVIDIA Tegra SoC family.
>  
> +config ARCH_TESLA_FSD
> +	bool "ARMv8 based Tesla platform"
> +	select ARCH_EXYNOS

How similar it is? I think it is better to duplicate Exynos
selections/options here, instead of selecting entire ARCH. If this would
require "depends on ARCH_EXYNOS || ARCH_TESLA_FSD" everywhere in the
drivers, it's a hint that it is not a separate SoC but it is an Exynos,
so it might not need a new sub-architecture.


> +	help
> +	  Support for ARMv8 based Tesla platforms.
> +
>  config ARCH_SPRD
>  	bool "Spreadtrum SoC platform"
>  	help
> diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> index 639e01a4d855..1ba04e31a438 100644
> --- a/arch/arm64/boot/dts/Makefile
> +++ b/arch/arm64/boot/dts/Makefile
> @@ -27,6 +27,7 @@ subdir-y += rockchip
>  subdir-y += socionext
>  subdir-y += sprd
>  subdir-y += synaptics
> +subdir-y += tesla
>  subdir-y += ti
>  subdir-y += toshiba
>  subdir-y += xilinx
> diff --git a/arch/arm64/boot/dts/tesla/Makefile b/arch/arm64/boot/dts/tesla/Makefile
> new file mode 100644
> index 000000000000..a9818cda6b08
> --- /dev/null
> +++ b/arch/arm64/boot/dts/tesla/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +dtb-$(CONFIG_ARCH_TESLA_FSD) += \
> +	fsd.dtb
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dts b/arch/arm64/boot/dts/tesla/fsd.dts
> new file mode 100644
> index 000000000000..e9bbd3284de9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/tesla/fsd.dts

No, this is not a fsd.dts, but some board. You call FSD a SoC, so this
should have different name.

> @@ -0,0 +1,140 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tesla FSD board device tree source
> + *
> + * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
> + *		https://www.samsung.com
> + * Copyright (c) 2017-2021 Tesla, Inc.
> + *		https://www.tesla.com
> + */
> +
> +/dts-v1/;
> +#include "fsd.dtsi"
> +
> +/ {
> +	model = "Tesla Full Self-Driving (FSD) SoC";

Wrong model, this is DTS, not DTSI.

> +	compatible = "tesla,fsd";

Missing compatible for board.

> +
> +	aliases {
> +		serial0 = &serial_0;
> +		serial1 = &serial_1;
> +	};
> +
> +	chosen {
> +		stdout-path = &serial_0;
> +		linux,initrd-start = <0xE0000000>;
> +		linux,initrd-end = <0xE4F00000>;
> +		bootargs = "console=ttySAC0,115200n8
> +			earlycon=exynos4210,0x14180000 root=/dev/ram0
> +			init=/linuxrc";

These are not bootargs matching SoC. earlycon is purely a debug option.
console is duplicating stdout-path. root and init are also not a part of
DTSI or DTS.

> +	};
> +
> +	memory@80000000 {
> +		device_type = "memory";
> +		reg = <0x0 0x80000000 0x2 0x00000000>;
> +	};
> +};
> +
> +&fin_pll {
> +	clock-frequency = <24000000>;
> +};
> +
> +&serial_0 {
> +	status = "okay";
> +};
> +
> +&serial_1 {
> +	status = "okay";
> +};
> +
> +&clock_cmu {
> +	status = "okay";
> +};
> +
> +&clock_imem {
> +	status = "okay";
> +};
> +
> +&clock_peric {
> +	status = "okay";
> +};

The labels/overrides are with weird order... looks like a mess. Anyway,
clocks should be always enabled, why board has to enable them?

> +
> +&smmu_isp {
> +	status = "okay";
> +};
> +
> +&clock_fsys0 {
> +	status = "okay";
> +};
> +
> +&clock_fsys1 {
> +	status = "okay";
> +};
> +
> +&smmu_peric {
> +	status = "okay";

The same as clocks.

> +};
> +
> +&smmu_imem {
> +	status = "okay";
> +};
> +
> +&smmu_fsys0 {
> +	status = "okay";
> +};
> +
> +&hsi2c_0 {
> +	status = "okay";

This looks wrong. There is nothing attached.

> +};
> +
> +&hsi2c_1 {
> +	status = "okay";

Same here and other I2C.

> +};
> +
> +&hsi2c_2 {
> +	status = "okay";
> +};
> +
> +&hsi2c_3 {
> +	status = "okay";
> +};
> +
> +&hsi2c_4 {
> +	status = "okay";
> +};
> +
> +&hsi2c_5 {
> +	status = "okay";
> +};
> +
> +&hsi2c_6 {
> +	status = "okay";
> +};
> +
> +&hsi2c_7 {
> +	status = "okay";
> +};
> +
> +&pwm_0 {
> +	status = "okay";

Nope, nope.

> +};
> +
> +&pwm_1 {
> +	status = "okay";
> +};
> +
> +&mdma0 {
> +	status = "okay";

Can you imagine SoC with disabled DMA?

> +};
> +
> +&mdma1 {
> +	status = "okay";
> +};
> +
> +&pdma0 {
> +	status = "okay";
> +};
> +
> +&pdma1 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
> new file mode 100644
> index 000000000000..47cd9f20566e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> @@ -0,0 +1,715 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tesla Full Self-Driving SoC device tree source
> + *
> + * Copyright (c) 2017-2022 Samsung Electronics Co., Ltd.
> + *		https://www.samsung.com
> + * Copyright (c) 2017-2022 Tesla, Inc.
> + *		https://www.tesla.com
> + */
> +
> +#include <dt-bindings/clock/fsd-clk.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +	compatible = "tesla,fsd";

Same compatible as board - nope.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	aliases {
> +		watchdog0 = &watchdog_0;
> +		watchdog1 = &watchdog_1;
> +		watchdog2 = &watchdog_2;

I think watchdogs do not need/use aliases.

> +		hsi2c0 = &hsi2c_0;
> +		hsi2c1 = &hsi2c_1;
> +		hsi2c2 = &hsi2c_2;
> +		hsi2c3 = &hsi2c_3;
> +		hsi2c4 = &hsi2c_4;
> +		hsi2c5 = &hsi2c_5;
> +		hsi2c6 = &hsi2c_6;
> +		hsi2c7 = &hsi2c_7;
> +	};
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpucl0_0>;
> +				};
> +				core1 {
> +					cpu = <&cpucl0_1>;
> +				};
> +				core2 {
> +					cpu = <&cpucl0_2>;
> +				};
> +				core3 {
> +					cpu = <&cpucl0_3>;
> +				};
> +			};
> +
> +			cluster1 {
> +				core0 {
> +					cpu = <&cpucl1_0>;
> +				};
> +				core1 {
> +					cpu = <&cpucl1_1>;
> +				};
> +				core2 {
> +					cpu = <&cpucl1_2>;
> +				};
> +				core3 {
> +					cpu = <&cpucl1_3>;
> +				};
> +			};
> +
> +			cluster2 {
> +				core0 {
> +					cpu = <&cpucl2_0>;
> +				};
> +				core1 {
> +					cpu = <&cpucl2_1>;
> +				};
> +				core2 {
> +					cpu = <&cpucl2_2>;
> +				};
> +				core3 {
> +					cpu = <&cpucl2_3>;
> +				};
> +			};
> +		};
> +
> +		/* Cluster 0 */
> +		cpucl0_0: cpu@0 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x000>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl0_1: cpu@1 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x001>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl0_2: cpu@2 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x002>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl0_3: cpu@3 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x003>;
> +				enable-method = "psci";
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		/* Cluster 1 */
> +		cpucl1_0: cpu@100 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x100>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl1_1: cpu@101 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x101>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl1_2: cpu@102 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x102>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl1_3: cpu@103 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x103>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		/* Cluster 2 */
> +		cpucl2_0: cpu@200 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x200>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl2_1: cpu@201 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x201>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl2_2: cpu@202 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x202>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		cpucl2_3: cpu@203 {
> +				device_type = "cpu";
> +				compatible = "arm,cortex-a72";
> +				reg = <0x0 0x203>;
> +				enable-method = "psci";
> +				clock-frequency = <2400000000>;
> +				cpu-idle-states = <&CPU_SLEEP>;
> +				next-level-cache = <&L2_0>;
> +		};
> +
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP: cpu-sleep {
> +				idle-state-name = "c2";
> +				compatible = "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param = <0x0010000>;
> +				entry-latency-us = <30>;
> +				exit-latency-us = <75>;
> +				min-residency-us = <300>;
> +				status = "okay";

No need for status.

> +			};
> +		};
> +
> +		L2_0: l2-cache0 {

lowercase letters in label.

> +			compatible = "cache";

You miss here some properties. Does your DTSI/DTS pass dtschema validation?

> +		};
> +	};
> +
> +	arm-pmu {
> +		compatible = "arm,armv8-pmuv3";
> +		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-affinity = <&cpucl0_0>, <&cpucl0_1>, <&cpucl0_2>,
> +				     <&cpucl0_3>, <&cpucl1_0>, <&cpucl1_1>,
> +				     <&cpucl1_2>, <&cpucl1_3>, <&cpucl2_0>,
> +				     <&cpucl2_1>, <&cpucl2_2>, <&cpucl2_3>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci";
> +		method = "smc";
> +		cpu_on = <0xC4000003>;
> +		cpu_suspend = <0xC4000001>;
> +		cpu_off = <0x84000002>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,

Not sure - don't you need CPU mask?

> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	fin_pll: clock {
> +		compatible = "fixed-clock";
> +		clock-output-names = "fin_pll";
> +		#clock-cells = <0>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x0 0x0 0x0 0x0 0x0 0x18000000>;
> +		dma-ranges = <0x0 0x0 0x0 0x0 0x10 0x0>;
> +
> +		gic: interrupt-controller@10400000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			interrupt-controller;
> +			reg =	<0x0 0x10400000 0x0 0x10000>, /* GICD */
> +				<0x0 0x10600000 0x0 0x200000>; /* GICR_RD+GICR_SGI */
> +		};
> +
> +		smmu_isp: iommu@12100000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0x0 0x12100000 0x0 0x10000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <11>;
> +			interrupts = <GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
> +				     <GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
> +				     <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
> +				     <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
> +				     /* Performance counter interrupts */
> +				     <GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_CSI   */
> +				     <GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_0  */
> +				     <GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_DP_1  */
> +				     <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_0 */
> +				     <GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_ISP_1 */
> +				     <GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_0 */
> +				     <GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH>, /* for CAM_MFC_1 */
> +				     /* Per context non-secure context interrupts, 0-7 interrupts */
> +				     <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
> +				     <GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
> +				     <GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
> +				     <GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_3 */
> +				     <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_4 */
> +				     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_5 */
> +				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_6 */
> +				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_7 */
> +			status = "disabled";
> +		};
> +
> +		smmu_imem: iommu@10200000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0x0 0x10200000 0x0 0x10000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <7>;
> +			interrupts = <GIC_SPI 438 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
> +				     <GIC_SPI 439 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
> +				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
> +				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
> +				     /* Performance counter interrupts */
> +				     <GIC_SPI 441 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_0 */
> +				     <GIC_SPI 442 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS1_1 */
> +				     <GIC_SPI 443 IRQ_TYPE_LEVEL_HIGH>, /* for IMEM_0  */
> +				     /* Per context non-secure context interrupts, 0-3 interrupts */
> +				     <GIC_SPI 446 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
> +				     <GIC_SPI 447 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_1 */
> +				     <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_2 */
> +				     <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_3 */
> +			status = "disabled";
> +		};
> +
> +		smmu_peric: iommu@14900000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0x0 0x14900000 0x0 0x10000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <5>;
> +			interrupts = <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
> +				     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
> +				     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
> +				     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
> +				     /* Performance counter interrupts */
> +				     <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>, /* for PERIC */
> +				     /* Per context non-secure context interrupts, 0-1 interrupts */
> +				     <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
> +				     <GIC_SPI 195 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
> +			status = "disabled";
> +		};
> +
> +		smmu_fsys0: iommu@15450000 {
> +			compatible = "arm,mmu-500";
> +			reg = <0x0 0x15450000 0x0 0x10000>;
> +			#iommu-cells = <2>;
> +			#global-interrupts = <5>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>, /* Global secure fault */
> +				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>, /* Global non-secure fault */
> +				     <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>, /* Combined secure interrupt */
> +				     <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>, /* Combined non-secure interrupt */
> +				     /* Performance counter interrupts */
> +				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>, /* for FSYS0   */
> +				     /* Per context non-secure context interrupts, 0-1 interrupts */
> +				     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>, /* for CONTEXT_0 */
> +				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>; /* for CONTEXT_1 */
> +			status = "disabled";
> +		};
> +
> +		clock_cmu: clock-controller@11C10000 {
> +			compatible = "tesla,fsd-clock-cmu";
> +			reg = <0x0 0x11C10000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>;
> +			clock-names = "fin_pll";
> +			status = "disabled";

This explains why DTS has to enable basic SoC features... why do you
disable your clock controllers?

> +		};
> +
> +		clock_imem: clock-controller@10010000 {
> +			compatible = "tesla,fsd-clock-imem";
> +			reg = <0x0 0x10010000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>,
> +				<&clock_cmu DOUT_CMU_IMEM_TCUCLK>,
> +				<&clock_cmu DOUT_CMU_IMEM_ACLK>,
> +				<&clock_cmu DOUT_CMU_IMEM_DMACLK>;
> +			clock-names = "fin_pll",
> +				"dout_cmu_imem_tcuclk",
> +				"dout_cmu_imem_aclk",
> +				"dout_cmu_imem_dmaclk";
> +			status = "disabled";
> +		};
> +
> +		clock_peric: clock-controller@14010000 {
> +			compatible = "tesla,fsd-clock-peric";
> +			reg = <0x0 0x14010000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>,
> +				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV4>,
> +				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV36>,
> +				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV3_TBUCLK>,
> +				<&clock_cmu DOUT_CMU_PERIC_SHARED0DIV20>,
> +				<&clock_cmu DOUT_CMU_PERIC_SHARED1DIV4_DMACLK>;
> +			clock-names = "fin_pll",
> +				"dout_cmu_pll_shared0_div4",
> +				"dout_cmu_peric_shared1div36",
> +				"dout_cmu_peric_shared0div3_tbuclk",
> +				"dout_cmu_peric_shared0div20",
> +				"dout_cmu_peric_shared1div4_dmaclk";
> +			status = "disabled";
> +		};
> +
> +		clock_fsys0: clock-controller@15010000 {
> +			compatible = "tesla,fsd-clock-fsys0";
> +			reg = <0x0 0x15010000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>,
> +				<&clock_cmu DOUT_CMU_PLL_SHARED0_DIV6>,
> +				<&clock_cmu DOUT_CMU_FSYS0_SHARED1DIV4>,
> +				<&clock_cmu DOUT_CMU_FSYS0_SHARED0DIV4>;
> +			clock-names = "fin_pll",
> +				"dout_cmu_pll_shared0_div6",
> +				"dout_cmu_fsys0_shared1div4",
> +				"dout_cmu_fsys0_shared0div4";
> +			status = "disabled";
> +		};
> +
> +		clock_fsys1: clock-controller@16810000 {
> +			compatible = "tesla,fsd-clock-fsys1";
> +			reg = <0x0 0x16810000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>,
> +				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV8>,
> +				<&clock_cmu DOUT_CMU_FSYS1_SHARED0DIV4>;
> +			clock-names = "fin_pll",
> +				"dout_cmu_fsys1_shared0div8",
> +				"dout_cmu_fsys1_shared0div4";
> +			status = "disabled";
> +		};
> +
> +		clock_mfc: clock-controller@12810000 {
> +			compatible = "tesla,fsd-clock-mfc";
> +			reg = <0x0 0x12810000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>;
> +			clock-names = "fin_pll";
> +			status = "disabled";
> +		};
> +
> +		clock_csi: clock-controller@12610000 {
> +			compatible = "tesla,fsd-clock-cam_csi";
> +			reg = <0x0 0x12610000 0x0 0x3000>;
> +			#clock-cells = <1>;
> +			clocks = <&fin_pll>;
> +			clock-names = "fin_pll";
> +			status = "disabled";
> +		};
> +
> +		mdma0: mdma@10100000 {

Node name: just dma to be generic. Schema does not enforce it but might
at some point.

> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0x10100000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +			clocks = <&clock_imem IMEM_DMA0_IPCLKPORT_ACLK>;
> +			clock-names = "apb_pclk";
> +			iommus = <&smmu_imem 0x800 0x0>;
> +			status = "disabled";
> +		};
> +
> +		mdma1: mdma@10110000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0x10110000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +			clocks = <&clock_imem IMEM_DMA1_IPCLKPORT_ACLK>;
> +			clock-names = "apb_pclk";
> +			iommus = <&smmu_imem 0x801 0x0>;
> +			status = "disabled";
> +		};
> +
> +		pdma0: pdma@14280000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0x14280000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +			clocks = <&clock_peric PERIC_DMA0_IPCLKPORT_ACLK>;
> +			clock-names = "apb_pclk";
> +			iommus = <&smmu_peric 0x2 0x0>;
> +			status = "disabled";
> +		};
> +
> +		pdma1: pdma@14290000 {
> +			compatible = "arm,pl330", "arm,primecell";
> +			reg = <0x0 0x14290000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			#dma-channels = <8>;
> +			#dma-requests = <32>;
> +			clocks = <&clock_peric PERIC_DMA1_IPCLKPORT_ACLK>;
> +			clock-names = "apb_pclk";
> +			iommus = <&smmu_peric 0x1 0x0>;
> +			status = "disabled";
> +		};
> +
> +		mct: mct@10040000 {
> +			compatible = "samsung,exynos4210-mct";
> +			reg = <0x0 0x10040000 0x0 0x800>;
> +			interrupts = <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 456 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 460 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 461 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 462 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 464 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 465 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>,
> +				<GIC_SPI 470 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&fin_pll>, <&clock_imem IMEM_MCT_PCLK>;
> +			clock-names = "fin_pll", "mct";
> +		};
> +
> +		serial_0: serial@14180000 {
> +			compatible = "samsung,exynos4210-uart";
> +			reg = <0x0 0x14180000 0x0 0x100>;
> +			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma1 0>, <&pdma1 1>;
> +			dma-names = "tx", "rx";
> +			clocks = <&clock_peric PERIC_PCLK_UART0>,
> +				 <&clock_peric PERIC_SCLK_UART0>;
> +			clock-names = "uart", "clk_uart_baud0";
> +			status = "disabled";
> +		};
> +
> +		serial_1: serial@14190000 {
> +			compatible = "samsung,exynos4210-uart";
> +			reg = <0x0 0x14190000 0x0 0x100>;
> +			interrupts = <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&pdma1 2>, <&pdma1 3>;
> +			dma-names = "tx", "rx";
> +			clocks = <&clock_peric PERIC_PCLK_UART1>,
> +				 <&clock_peric PERIC_SCLK_UART1>;
> +			clock-names = "uart", "clk_uart_baud0";
> +			status = "disabled";
> +		};
> +
> +		pmu_system_controller: system-controller@11400000 {
> +			compatible = "samsung,exynos7-pmu", "syscon";
> +			reg = <0x0 0x11400000 0x0 0x5000>;
> +		};
> +
> +		watchdog_0: watchdog@100A0000 {

lowercase hex addresses. Here, in reg below and all other nodes.

> +			compatible = "samsung,exynos7-wdt";
> +			reg = <0x0 0x100A0000 0x0 0x100>;
> +			interrupts = <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH>;
> +			samsung,syscon-phandle = <&pmu_system_controller>;
> +			clocks = <&fin_pll>;
> +			clock-names = "watchdog";
> +			interrupt-mode = <1>;

This property looks unsupported. Did you run dtschema checks?

Best regards,
Krzysztof
