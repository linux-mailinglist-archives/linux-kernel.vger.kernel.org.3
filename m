Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6177546A1BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbhLFQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238218AbhLFQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:50:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8715CC0613F8;
        Mon,  6 Dec 2021 08:47:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 021921F44A9A
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638809233; bh=eySRGQLbNOqYcJFdEtWXKNpdKPAAJqJEFoPWxe6NFEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kG/aqFPaO9FXOBd8S0OrROFiszjPbRsX1/TYXZNyydzGLG4cvxiiMOsApvgabBCuZ
         QotqXTxOCWu1rm4Cuajuqc+iuyy0asath5Trthuh1xyJkfRpxORht3fYUeS/krMXSP
         4IX066p3EI9sLfAD6WsmFQ4HO7X9cWHniJYwYkzxZ4efo4pbmo9h7bcKEMTPD6QIj/
         QC4RA6LUvv1Qpc3mP4WGtaOeewXB4lNT+INj+6iSfyL8Z8PRnRQdwUz+1cXWLjQKEV
         8NW7JfTAPh24h4zOu5bNtWiOjGW+ZGyF8i2aIda/1pbQXmARrX4raSfDsjsbkHzGJ5
         K2SP+BePr2YIg==
Date:   Mon, 6 Dec 2021 11:47:07 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v1 3/5] arm64: dts: mediatek: Correct SPI clock of MT8192
Message-ID: <20211206164707.u4tvsmr7fnkzs5tu@notapiano>
References: <20210825011120.30481-1-chun-jie.chen@mediatek.com>
 <20210825011120.30481-4-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210825011120.30481-4-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 25, 2021 at 09:11:18AM +0800, Chun-Jie Chen wrote:
> update uart0 ~ 7 clocks to the real ones.

Same comment from patch 1. But also here you had a typo: should be spi instead
of uart.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 48 ++++++++++++------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 31d135e18784..d1c85d3e152b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -355,9 +355,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x1100a000 0 0x1000>;
>  			interrupts = <GIC_SPI 159 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI0>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -369,9 +369,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x11010000 0 0x1000>;
>  			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI1>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -383,9 +383,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x11012000 0 0x1000>;
>  			interrupts = <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI2>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -397,9 +397,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x11013000 0 0x1000>;
>  			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI3>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -411,9 +411,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x11018000 0 0x1000>;
>  			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI4>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -425,9 +425,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x11019000 0 0x1000>;
>  			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI5>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -439,9 +439,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x1101d000 0 0x1000>;
>  			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI6>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> @@ -453,9 +453,9 @@
>  			#size-cells = <0>;
>  			reg = <0 0x1101e000 0 0x1000>;
>  			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH 0>;
> -			clocks = <&clk26m>,
> -				 <&clk26m>,
> -				 <&clk26m>;
> +			clocks = <&topckgen CLK_TOP_MAINPLL_D5_D4>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI7>;
>  			clock-names = "parent-clk", "sel-clk", "spi-clk";
>  			status = "disabled";
>  		};
> -- 
> 2.18.0
> 
> 
