Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638F94D4A12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 15:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345641AbiCJOmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiCJOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:30:53 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A20A186BB6;
        Thu, 10 Mar 2022 06:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=X+z54Gq/Kh0PoKxHLLeQbmlP658ai3SMxXoXeIbzp88=; b=UF7VNzrBw+MgOPrTTrt86DqHf9
        yfuXVm0+wA5PHjD/wcSGjxcR/eLBRatyK9mipxXSRFmEikACiHeyoj6ZnfJRbSDZm8yhvnVE5eNWt
        ocCLxQgk9LabkFtUDr+X4Ltk/Xz7aduFICybsHliO23Sgp6lwI6WXjwzka9HowCWcieA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nSJk2-00A8zy-Kx; Thu, 10 Mar 2022 15:26:10 +0100
Date:   Thu, 10 Mar 2022 15:26:10 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        kostap@marvell.com, robert.marko@sartura.hr,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 3/4] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <YioKgjhEnqylB24M@lunn.ch>
References: <20220310030039.2833808-1-chris.packham@alliedtelesis.co.nz>
 <20220310030039.2833808-4-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310030039.2833808-4-chris.packham@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 04:00:38PM +1300, Chris Packham wrote:
> The 98DX2530 SoC is the Control and Management CPU integrated into
> the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
> referred to as AlleyCat5 and AlleyCat5X).
> 
> These files have been taken from the Marvell SDK and lightly cleaned
> up with the License and copyright retained.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     This has a number of undocumented compatible strings. I've got the SDK
>     source so I'll either bring through whatever drivers are needed or look
>     at for an in-tree alternative (e.g. there is SDK code for a ac5-gpio but
>     the existing marvell,orion-gpio seems to cover what is needed if you use
>     an appropriate binding).

Hi Chris

My understand is, you don't add nodes for which there is no
driver. The driver and its binding needs to be reviewed and accepted
before users of it are added.

> +	mvDma {
> +		compatible = "marvell,mv_dma";
> +		memory-region = <&prestera_rsvd>;
> +		status = "okay";
> +	};

Is this different to the existing Marvell XOR engine?

> +			mdio: mdio@20000 {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				compatible = "marvell,orion-mdio";
> +				reg = <0x22004 0x4>;
> +				clocks = <&core_clock>;
> +				phy0: ethernet-phy@0 {
> +					reg = < 0 0 >;
> +				};

This embedded PHY looks wrong. reg should be a single value.

Is the PHY internal? Generally, the PHY is put in the .dts file, but
if it is internal, that the .dtsi would be correct.

> +				sdhci0: sdhci@805c0000 {
> +					compatible = "marvell,ac5-sdhci", "marvell,armada-ap806-sdhci";

This additional compatible should be added to the existing binding
document.

> +			eth0: ethernet@20000 {
> +				compatible = "marvell,armada-ac5-neta";

So it is not compatible with plain nata?

> +				reg = <0x0 0x20000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&core_clock>;
> +				status = "disabled";
> +				phy-mode = "sgmii";
> +			};
> +
> +			eth1: ethernet@24000 {
> +				compatible = "marvell,armada-ac5-neta";
> +				reg = <0x0 0x24000 0x0 0x4000>;
> +				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&core_clock>;
> +				status = "disabled";
> +				phy-mode = "sgmii";
> +				fixed-link {
> +					speed = <100>;
> +					full-duplex;
> +				};

Fast Ethernet? Yet SGMII?

> +			/* USB0 is a host USB */
> +			usb0: usb@80000 {
> +				compatible = "marvell,ac5-ehci", "marvell,orion-ehci";

Please add this compatible to the binding.

> +		pcie0: pcie@800a0000 {
> +			compatible = "marvell,ac5-pcie", "snps,dw-pcie";

Please add this ...

> +			spiflash0: spi-flash@0 {
> +				compatible = "spi-nor";
> +				spi-max-frequency = <50000000>;
> +				spi-tx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
> +				spi-rx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
> +				reg = <0>;
> +
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				partition@0 {
> +					label = "spi_flash_part0";
> +					reg = <0x0 0x800000>;
> +				};
> +
> +				parition@1 {
> +					label = "spi_flash_part1";
> +					reg = <0x800000 0x700000>;
> +				};
> +
> +				parition@2 {
> +					label = "spi_flash_part2";
> +					reg = <0xF00000 0x100000>;
> +				};

The partitioning of the flash i would expect to be board specific, so
belongs on the .dts file.

> +		nand: nand@805b0000 {
> +			compatible = "marvell,ac5-nand-controller";

The current NAND driver does not work?

> +		prestera {
> +			compatible = "marvell,armada-ac5-switch";
> +			interrupts = <GIC_SPI 0x23 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "okay";
> +		};

Here we have to be careful with naming. I assume Marvell in kernel
Pretera driver does not actually work on the prestera hardware? That
driver assumes you are running Marvell firmware on this SoC, and have
a host running that driver which talks to the SoC firmware?

The name perstera seems O.K, and the compatible
marvell,armada-ac5-switch makes it clear the prestera driver cannot be
used. However, until we do actually have a driver, i don't think this
node should be added.

> +		watchdog@80216000 {
> +			compatible = "marvell,ac5-wd";

Not compatible with the existing watchdog driver?

    Andrew
