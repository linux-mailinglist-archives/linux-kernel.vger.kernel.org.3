Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B1A48614E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbiAFIMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jan 2022 03:12:51 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59003 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiAFIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:12:50 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A79E61C0006;
        Thu,  6 Jan 2022 08:12:47 +0000 (UTC)
Date:   Thu, 6 Jan 2022 09:12:46 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liang Yang <liang.yang@amlogic.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: nand: meson: fix controller clock
Message-ID: <20220106091246.08ca66e0@xps13>
In-Reply-To: <20220106033130.37623-1-liang.yang@amlogic.com>
References: <20220106033130.37623-1-liang.yang@amlogic.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



liang.yang@amlogic.com wrote on Thu, 6 Jan 2022 11:31:30 +0800:

> Change-Id: I1425b491d8b95061e1ce358ef33143433fc94d24
> ---
>  .../bindings/mtd/amlogic,meson-nand.txt        | 18 +++---------------

I forgot to mention, while you're at it, after fixing the bindings,
could you please convert it to yaml?

>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> index 5794ab1147c1..37f16fe4fe66 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.txt
> @@ -14,11 +14,6 @@ Required properties:
>  - clock-names: Should contain the following:
>  	"core" - NFC module gate clock
>  	"device" - device clock from eMMC sub clock controller
> -	"rx" - rx clock phase
> -	"tx" - tx clock phase
> -
> -- amlogic,mmc-syscon	: Required for NAND clocks, it's shared with SD/eMMC
> -				controller port C
>  
>  Optional children nodes:
>  Children nodes represent the available nand chips.
> @@ -28,11 +23,6 @@ see Documentation/devicetree/bindings/mtd/nand-controller.yaml for generic bindi
>  
>  Example demonstrate on AXG SoC:
>  
> -	sd_emmc_c_clkc: mmc@7000 {
> -		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> -		reg = <0x0 0x7000 0x0 0x800>;
> -	};
> -
>  	nand-controller@7800 {
>  		compatible = "amlogic,meson-axg-nfc";
>  		reg = <0x0 0x7800 0x0 0x100>;
> @@ -41,11 +31,9 @@ Example demonstrate on AXG SoC:
>  		interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>  
>  		clocks = <&clkc CLKID_SD_EMMC_C>,
> -			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
> -			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
> -		clock-names = "core", "device", "rx", "tx";
> -		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
> +			<&clkc CLKID_FCLK_DIV2>;
> +		clock-names = "core", "device";
> +		sd_emmc_c_clkc = <0xffe07000>;
>  
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&nand_pins>;


Thanks,
Miquèl
