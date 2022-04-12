Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E2C4FE029
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354015AbiDLMWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355649AbiDLMTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:19:20 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD716EB2B;
        Tue, 12 Apr 2022 04:22:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u19so11521649lff.4;
        Tue, 12 Apr 2022 04:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zjgmtbSNoF2mZGEsUPtkbHFRRKP9FVVfefhVkGjbZfQ=;
        b=kw7VIsEmf0U7Z1+NXfv7iOK5PQ4KvemOjD1kg7x00UfHoZBB6h+D0CwqbHh/cPuD/0
         jIzEDCOy3vOueU+zlC5BzNs0rj0zc9mi7spq2cjU+5ty2WqyiQ+j7XyVHW/SHZrHkCHx
         dSJkq1KezLVvbrG9ftDwj9TNLduLwhGKekHcdYWyT4yPUNmw+Yf0xVDYIyy09OcdopqK
         nF/oww7ylgFAEA8CvC0fgY4UaSm8qezYVw8PEnwv6ltNKS9jMtWVCd1W36o6vgpjjCoQ
         /06F6sHqA/I/MnWUGKJy78L6W8bdbVwzQ19FsIqb5OZffEsH97VUrLA+9Cr5aWhre0oJ
         vYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjgmtbSNoF2mZGEsUPtkbHFRRKP9FVVfefhVkGjbZfQ=;
        b=oH363yHHYJQLyRtZwl/a1DqJP94Q6OxBnyYMBEDuxOUIE6qLeC7fIHYmCS4Agpcfe3
         mSgEXvPR8PuSsfPkhJ9aVPnIpV+UkPoIIUrxscYlRZqSPY4wYIB+z5nnd63Rrm/1yHqj
         RmovF2bjcbpXOM0YjKyfvEdw6QCUphgKTjPqTn6Jcwguagl33Yj0d8XtcZrJNFkirEDJ
         4t9oO7jx+qFaqjd9qkocLO8hXjVspglNDc5QQEP+kjUMSm/JBYuahGlknBcmKmEKx4ba
         lAeYdKddoI95zYwTiI6kM2GscLBAdt/zgKtzC+LT45Bk2x9F3ABKlmyW3E6teeVcVVa3
         kQGQ==
X-Gm-Message-State: AOAM530h9i5hUzENRQ9O3KIoxrtfYZlkoZkYs06y5bgWApnytnDyMABx
        +Q5KtCjiEnPosL5wQO3E4QM=
X-Google-Smtp-Source: ABdhPJwJo/oL6k4laov0OagaQyfUqPDx2IzYl7OYrblARpn+RJ3AYqSpMjIVyTxiG67PDc5twJ17Gw==
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id y3-20020ac24203000000b004488053d402mr24213683lfh.687.1649762562723;
        Tue, 12 Apr 2022 04:22:42 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id b19-20020a056512305300b0044a9638b343sm3612948lfb.303.2022.04.12.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:22:41 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:22:39 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        broonie@kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, olof@lixom.net, dac2@pensando.io,
        linux-gpio@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Message-ID: <20220412112239.cucvqqlfsdpjnzju@mobilestation>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406233648.21644-12-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 04:36:48PM -0700, Brad Larson wrote:
> Add Pensando common and Elba SoC specific device nodes
> 
> Signed-off-by: Brad Larson <brad@pensando.io>
> ---
> Change from V3:
> - Changed to dual copyright (GPL-2.0+ OR MIT)
> - Minor changes from review input
> 
>  arch/arm64/boot/dts/Makefile                  |   1 +
>  arch/arm64/boot/dts/pensando/Makefile         |   3 +
>  arch/arm64/boot/dts/pensando/elba-16core.dtsi | 189 ++++++++++++++++++
>  .../boot/dts/pensando/elba-asic-common.dtsi   |  98 +++++++++
>  arch/arm64/boot/dts/pensando/elba-asic.dts    |  28 +++
>  .../boot/dts/pensando/elba-flash-parts.dtsi   | 106 ++++++++++
>  arch/arm64/boot/dts/pensando/elba.dtsi        | 189 ++++++++++++++++++
>  7 files changed, 614 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/pensando/Makefile
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-16core.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-asic.dts
>  create mode 100644 arch/arm64/boot/dts/pensando/elba-flash-parts.dtsi
>  create mode 100644 arch/arm64/boot/dts/pensando/elba.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> new file mode 100644
> index 000000000000..7a89df68fdf7
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba-asic-common.dtsi
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020-2022, Pensando Systems Inc.
> + */
> +
> +&ahb_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&emmc_clk {
> +	clock-frequency = <200000000>;
> +};
> +
> +&flash_clk {
> +	clock-frequency = <400000000>;
> +};
> +
> +&ref_clk {
> +	clock-frequency = <156250000>;
> +};
> +
> +&qspi {
> +	status = "okay";
> +	flash0: flash@0 {
> +		compatible = "jedec,spi-nor";
> +		reg = <0>;
> +		spi-max-frequency = <40000000>;
> +		spi-rx-bus-width = <2>;
> +		m25p,fast-read;
> +		cdns,read-delay = <0>;
> +		cdns,tshsl-ns = <0>;
> +		cdns,tsd2d-ns = <0>;
> +		cdns,tchsh-ns = <0>;
> +		cdns,tslch-ns = <0>;
> +	};
> +};
> +
> +&gpio0 {
> +	status = "okay";
> +};
> +
> +&emmc {
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
> +&wdt0 {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	clock-frequency = <100000>;
> +	status = "okay";
> +	rtc@51 {
> +		compatible = "nxp,pcf85263";
> +		reg = <0x51>;
> +	};
> +};
> +
> +&spi0 {
> +	num-cs = <4>;
> +	cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
> +		   <&porta 7 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +	spi0_cs0@0 {
> +		compatible = "semtech,sx1301";	/* Enable spidev */
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <0>;
> +	};
> +
> +	spi0_cs1@1 {
> +		compatible = "semtech,sx1301";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <1>;
> +	};
> +
> +	spi0_cs2@2 {
> +		compatible = "semtech,sx1301";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <2>;
> +		interrupt-parent = <&porta>;
> +		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	spi0_cs3@3 {
> +		compatible = "semtech,sx1301";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <12000000>;
> +		reg = <3>;
> +	};
> +};

[...]

> diff --git a/arch/arm64/boot/dts/pensando/elba.dtsi b/arch/arm64/boot/dts/pensando/elba.dtsi
> new file mode 100644
> index 000000000000..10e06eb8cda6
> --- /dev/null
> +++ b/arch/arm64/boot/dts/pensando/elba.dtsi
> @@ -0,0 +1,189 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (c) 2020-2022, Pensando Systems Inc.
> + */
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "dt-bindings/interrupt-controller/arm-gic.h"
> +
> +/ {
> +	model = "Elba ASIC Board";
> +	compatible = "pensando,elba";
> +	interrupt-parent = <&gic>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	dma-coherent;
> +
> +	ahb_clk: oscillator0 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	emmc_clk: oscillator2 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	flash_clk: oscillator3 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	ref_clk: oscillator4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-0.2";
> +		method = "smc";
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a72-pmu";
> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	soc: soc {
> +		compatible = "simple-bus";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		i2c0: i2c@400 {
> +			compatible = "snps,designware-i2c";
> +			reg = <0x0 0x400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			i2c-sda-hold-time-ns = <480>;
> +			snps,sda-timeout-ms = <750>;
> +			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		wdt0: watchdog@1400 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0x0 0x1400 0x0 0x100>;
> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +
> +		qspi: spi@2400 {
> +			compatible = "pensando,elba-qspi", "cdns,qspi-nor";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x2400 0x0 0x400>,
> +			      <0x0 0x7fff0000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&flash_clk>;
> +			cdns,fifo-depth = <1024>;
> +			cdns,fifo-width = <4>;
> +			cdns,trigger-address = <0x7fff0000>;
> +			status = "disabled";
> +		};
> +
> +		spi0: spi@2800 {
> +			compatible = "pensando,elba-spi";
> +			reg = <0x0 0x2800 0x0 0x100>;

> +			pensando,syscon-spics = <&mssoc 0x2468>;

I am wondering do you really need to define the
"pensando,syscon-spics" property as accepting a phandle with an
additional argument? That would have been justified if you had at
least two SPI controllers with different CS override registers. AFAICS
you've got only one here. So you can simplify the bindings by defining
the property like "pensando,syscon" (with no "spics" suffix) which
accepts the syscon phandle alone. Respective SPICS offset can be
locally declared in the driver as a macro with respective name.

-Sergey


> +			clocks = <&ahb_clk>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			num-cs = <2>;
> +			status = "disabled";
> +		};
> +
> +		gpio0: gpio@4000 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			compatible = "snps,dw-apb-gpio";
> +			reg = <0x0 0x4000 0x0 0x78>;
> +			status = "disabled";
> +
> +			porta: gpio-port@0 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <0>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +				interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-controller;
> +				interrupt-parent = <&gic>;
> +				#interrupt-cells = <2>;
> +			};
> +
> +			portb: gpio-port@1 {
> +				compatible = "snps,dw-apb-gpio-port";
> +				reg = <1>;
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +				ngpios = <8>;
> +			};
> +		};
> +
> +		uart0: serial@4800 {
> +			compatible = "ns16550a";
> +			reg = <0x0 0x4800 0x0 0x100>;
> +			clocks = <&ref_clk>;
> +			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +			reg-shift = <2>;
> +			reg-io-width = <4>;
> +		};
> +
> +		gic: interrupt-controller@800000 {
> +			compatible = "arm,gic-v3";
> +			#interrupt-cells = <3>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges;
> +			interrupt-controller;
> +			reg = <0x0 0x800000 0x0 0x200000>,	/* GICD */
> +			      <0x0 0xa00000 0x0 0x200000>;	/* GICR */
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +
> +			/*
> +			 * Elba specific pre-ITS is enabled using the
> +			 * existing property socionext,synquacer-pre-its
> +			 */
> +			gic_its: msi-controller@820000 {
> +				compatible = "arm,gic-v3-its";
> +				msi-controller;
> +				#msi-cells = <1>;
> +				reg = <0x0 0x820000 0x0 0x10000>;
> +				socionext,synquacer-pre-its =
> +							<0xc00000 0x1000000>;
> +			};
> +		};
> +
> +		emmc: mmc@30440000 {
> +			compatible = "pensando,elba-sd4hc", "cdns,sd4hc";
> +			clocks = <&emmc_clk>;
> +			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
> +			reg = <0x0 0x30440000 0x0 0x10000>,
> +			      <0x0 0x30480044 0x0 0x4>;	/* byte-lane ctrl */
> +			cdns,phy-input-delay-sd-highspeed = <0x4>;
> +			cdns,phy-input-delay-legacy = <0x4>;
> +			cdns,phy-input-delay-sd-uhs-sdr50 = <0x6>;
> +			cdns,phy-input-delay-sd-uhs-ddr50 = <0x16>;
> +			mmc-ddr-1_8v;
> +			status = "disabled";
> +		};
> +
> +		mssoc: mssoc@307c0000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0x307c0000 0x0 0x3000>;
> +		};
> +	};
> +};
> -- 
> 2.17.1
> 
