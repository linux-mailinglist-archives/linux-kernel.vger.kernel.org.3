Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2234A9AFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359319AbiBDOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:31:27 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55082 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359316AbiBDObZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:31:25 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 214EV9Zp051915;
        Fri, 4 Feb 2022 08:31:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643985069;
        bh=EVPxkx563eY9pKGLzAMKeoMwB4VmQ09hAOPqEf69704=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RNvvrMeVPAQLEsExh+9uc8yQorORMcDdiCIiVVFiEBCuIy3V2hAQyg6sOa/lScykO
         K+m0MxQYJxp75/YT1TX986ICjIbgAMwwOsxG5TXH+z8CzD1XN9T1MlrYSkplhUN6aY
         TIegW2hLJsTkI9vZMqxaEpfi9yrFQSu5UQWid8wo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 214EV9jf120799
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Feb 2022 08:31:09 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 4
 Feb 2022 08:31:08 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 4 Feb 2022 08:31:08 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 214EV8mC016025;
        Fri, 4 Feb 2022 08:31:08 -0600
Date:   Fri, 4 Feb 2022 08:31:08 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>, <tony@atomide.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <soc@kernel.org>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: ti: k3-am65: disable optional
 peripherals by default
Message-ID: <20220204143108.653qk2ihnlhsr5aa@prior>
References: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220203140240.973690-1-matthias.schiffer@ew.tq-group.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob, Tony, Arnd, SoC maintainers,

On 15:02-20220203, Matthias Schiffer wrote:
> All peripherals that require pinmuxing or other configuration to work
> should be disabled by default. Dependent DTS are adjusted accordingly.

https://lore.kernel.org/linux-arm-kernel/20201112183538.6805-1-nm@ti.com/
reversal all over again.

Is there a specific pattern we are intending to use here? Because, if we
are going down this path (which would be a major churn across multiple
downstream trees as well) - I'd rather have this as a documented
standard and not just a TI approach and will need to be done across all
K3 devices.

Are you aware of such a documented guideline, rather than "word of
mouth"? Maybe I have'nt looked deep enough, but checking..

> 
> The following nodes are now "disabled" according to dtx_diff and were not
> overridden to "okay", as they define no pinctrl:


> k3-am654-base-board:
> - mcu_i2c0
> - mcu_spi0..2
> - mcu_uart0
> - cal
> - main_i2c3
> - ehrpwm0..5
> - main_uart1..2
> - main_spi1..4
> 
> k3-am65-iot2050*:
> - mci_spi1..2
> - cal
> - ehrpwm0..5
> - main_spi0..4
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
[...]

> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index ce8bb4a61011e..5aa425d1ba802 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -64,6 +64,7 @@ serdes0: serdes@900000 {
>  		ti,serdes-clk = <&serdes0_clk>;

[...]

> @@ -1337,6 +1388,7 @@ icssg2_mdio: mdio@32400 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			bus_freq = <1000000>;
> +			status = "disabled";
>  		};
>  	};
>  };
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 8d592bf41d6f1..57ac3a493adbe 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -22,11 +22,12 @@ phy_gmii_sel: phy@4040 {
>  
>  	mcu_uart0: serial@40a00000 {
>  		compatible = "ti,am654-uart";
> -			reg = <0x00 0x40a00000 0x00 0x100>;
> -			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
> -			clock-frequency = <96000000>;
> -			current-speed = <115200>;
> -			power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
> +		reg = <0x00 0x40a00000 0x00 0x100>;
> +		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
> +		clock-frequency = <96000000>;
> +		current-speed = <115200>;
> +		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;

When doing these kind of changes, do not include ancillary tab cleanups.
keep such cleanups separate patch.

> +		status = "disabled";

>  	};
>  
>  	mcu_ram: sram@41c00000 {
> @@ -46,6 +47,7 @@ mcu_i2c0: i2c@40b00000 {
>  		clock-names = "fck";
>  		clocks = <&k3_clks 114 1>;
>  		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>  	};
>  
>  	mcu_spi0: spi@40300000 {
> @@ -56,6 +58,7 @@ mcu_spi0: spi@40300000 {
>  		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		status = "disabled";
>  	};
>  
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D)/Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
