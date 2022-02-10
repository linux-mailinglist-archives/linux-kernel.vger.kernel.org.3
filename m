Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E84B0DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241584AbiBJMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:37:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241557AbiBJMhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:37:12 -0500
X-Greylist: delayed 1905 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 04:37:12 PST
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5203625FB;
        Thu, 10 Feb 2022 04:37:12 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4F1152223A;
        Thu, 10 Feb 2022 13:37:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644496630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s542OxdyRq6chzgnpbj408GyTF3ohoqeIM9rJK29+yo=;
        b=t/Lbe1ojweY5/FAhGcd6LmMAG2KytX3v4ZNvPHnD1xd42d08N7YEy1wFHG2CZDO4olHcTu
        b9i8H2qmtTi1zCc79skUBKTL0bMGxYXJEybyae0pGXHvRgenuuHvcx/OQp0RpT8KUAeHy8
        h+7QKtRCWQfpA9VsDRhPQxaq44sl1m4=
From:   Michael Walle <michael@walle.cc>
To:     tudor.ambarus@microchip.com
Cc:     Kavyasree.Kotagiri@microchip.com, Manohar.Puri@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, olof@lixom.net, robh+dt@kernel.org,
        soc@kernel.org, Tudor.Ambarus@microchip.com,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board pcb8291
Date:   Thu, 10 Feb 2022 13:37:04 +0100
Message-Id: <20220210123704.477826-1-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <42662481-51a4-2a4b-e39b-d3b8401cbb2c@microchip.com>
References: <42662481-51a4-2a4b-e39b-d3b8401cbb2c@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>  arch/arm/boot/dts/Makefile            |   2 +
>  arch/arm/boot/dts/lan966x.dtsi        | 237 ++++++++++++++++++++++++++
>  arch/arm/boot/dts/lan966x_pcb8291.dts |  61 +++++++

Please rename this to lan966x-pcb8921.dts. All (most?) of the device
tree files use the dash as a seperator between the SoC and the board.

> diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
> new file mode 100644
> index 000000000000..91ee9e0684f4
> --- /dev/null
> +++ b/arch/arm/boot/dts/lan966x.dtsi
> @@ -0,0 +1,237 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * lan966x.dtsi - Device Tree Include file for Microchip LAN966 family SoC
> + *
> + * Copyright (C) 2021 Microchip Technology, Inc. and its subsidiaries
> + *
> + * Author: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> + *
> + */
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/mfd/atmel-flexcom.h>
> +#include <dt-bindings/dma/at91.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/clock/microchip,lan966x.h>
> +
> +/ {
> +	model = "Microchip LAN966 family SoC";
> +	compatible = "microchip,lan966";

Undocumented compatible string. I see that the actual board
is documented in
  Documentation/devicetree/bindings/arm/atmel-at91.yaml

But as Arnd mentioned, this doesn't really make sense here
as you have to override it in the actual board dts anyway.

> +	interrupt-parent = <&gic>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			clock-frequency = <600000000>;
> +			reg = <0x0>;
> +		};
> +	};
> +
> +	clocks {
> +		sys_clk: sys_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <162500000>;
> +		};
> +
> +		cpu_clk: cpu_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <600000000>;
> +		};
> +
> +		ddr_clk: ddr_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <300000000>;
> +		};
> +
> +		nic_clk: nic_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
> +	clks: clock-controller@e00c00a8 {
> +		compatible = "microchip,lan966x-gck";
> +		#clock-cells = <1>;
> +		clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> +		clock-names = "cpu", "ddr", "sys";
> +		reg = <0xe00c00a8 0x38>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <37500000>;
> +		arm,cpu-registers-not-fw-configured;
> +	};
> +
> +	soc {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		flx0: flexcom@e0040000 {
> +			compatible = "atmel,sama5d2-flexcom";

Are these expected to be exactly the same between the lan966x and the
sama5d2 or do you need something like

compatible = "microchip,lan966x-flexcom", "atmel,sama5d2-flexcom";

for the case when you need to make SoC specific settings/workarounds?

> +			reg = <0xe0040000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM0>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0040000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		flx1: flexcom@e0044000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0044000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM1>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0044000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		trng: trng@e0048000 {

Tudor already mentioned this..

> +			compatible = "atmel,at91sam9g45-trng";
> +			reg = <0xe0048000 0x100>;
> +			clocks = <&nic_clk>;
> +		};
> +
> +		aes: aes@e004c000 {

.. and this ..

> +			compatible = "atmel,at91sam9g46-aes";
> +			reg = <0xe004c000 0x100>;
> +			interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(13)>,
> +			       <&dma0 AT91_XDMAC_DT_PERID(12)>;
> +			dma-names = "rx", "tx";
> +			clocks = <&nic_clk>;
> +			clock-names = "aes_clk";
> +		};
> +
> +		flx2: flexcom@e0060000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0060000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM2>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0060000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		flx3: flexcom@e0064000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0064000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0064000 0x800>;
> +			status = "disabled";
> +
> +			usart3: serial@200 {
> +				compatible = "atmel,at91sam9260-usart";
> +				reg = <0x200 0x200>;
> +				interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&nic_clk>;
> +				clock-names = "usart";
> +				atmel,fifo-size = <32>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		dma0: dma-controller@e0068000 {
> +			compatible = "microchip,sama7g5-dma";
> +			reg = <0xe0068000 0x1000>;
> +			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +			#dma-cells = <1>;
> +			clocks = <&nic_clk>;
> +			clock-names = "dma_clk";
> +		};
> +
> +		sha: sha@e006c000 {

.. and this one.

> +			compatible = "atmel,at91sam9g46-sha";
> +			reg = <0xe006c000 0xec>;
> +			interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
> +			dmas = <&dma0 AT91_XDMAC_DT_PERID(14)>;
> +			dma-names = "tx";
> +			clocks = <&nic_clk>;
> +			clock-names = "sha_clk";
> +		};
> +
> +		flx4: flexcom@e0070000 {
> +			compatible = "atmel,sama5d2-flexcom";
> +			reg = <0xe0070000 0x100>;
> +			clocks = <&clks GCK_ID_FLEXCOM4>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x0 0xe0070000 0x800>;
> +			status = "disabled";
> +		};
> +
> +		timer0: timer@e008c000 {
> +			compatible = "snps,dw-apb-timer";
> +			reg = <0xe008c000 0x400>;
> +			clocks = <&nic_clk>;
> +			clock-names = "timer";
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +		};
> +
> +		watchdog: watchdog@e0090000 {
> +			compatible = "snps,dw-wdt";
> +			reg = <0xe0090000 0x1000>;
> +			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&nic_clk>;
> +		};
> +
> +		can0: can@e081c000 {
> +			compatible = "bosch,m_can";
> +			reg = <0xe081c000 0xfc>, <0x00100000 0x4000>;
> +			reg-names = "m_can", "message_ram";
> +			interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "int0", "int1";
> +			clocks = <&clks GCK_ID_MCAN0>, <&clks GCK_ID_MCAN0>;
> +			clock-names = "hclk", "cclk";
> +			assigned-clocks = <&clks GCK_ID_MCAN0>;
> +			assigned-clock-rates = <40000000>;
> +			bosch,mram-cfg = <0x0 0 0 64 0 0 32 32>;
> +			status = "disabled";
> +		};
> +
> +		gpio: pinctrl@e2004064 {
> +			compatible = "microchip,lan966x-pinctrl";
> +			reg = <0xe2004064 0xb4>,
> +			    <0xe2010024 0x138>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&gpio 0 0 78>;
> +			interrupt-controller;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			#interrupt-cells = <2>;
> +		};
> +
> +		gic: interrupt-controller@e8c11000 {
> +			compatible = "arm,gic-400", "arm,cortex-a7-gic";
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			reg = <0xe8c11000 0x1000>,
> +			      <0xe8c12000 0x2000>,
> +			      <0xe8c14000 0x2000>,
> +			      <0xe8c16000 0x2000>;
> +		};
> +	};
> +};

Overall most of the referenced bindings lack a proper yaml version :/

-michael
