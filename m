Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A7C4CC249
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 17:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233912AbiCCQIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 11:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbiCCQIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 11:08:05 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2027B198D1D;
        Thu,  3 Mar 2022 08:07:17 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC9AC4001B;
        Thu,  3 Mar 2022 16:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646323636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h/V2fl+WKVWANDZw1/vLE1+4r0C4bFnhRl+F59/e1W8=;
        b=FBGJrfWaZUm2AGLBZhTuqfxz4xWi7LZ5kL203xwZs/b5cVH2P6C8SL3VSz6spVx7dMo54Z
        y9jbrfARgLxLXmeOY/1fzGrM52xiIdWuwAb43xOfV4F7GqxzQURV6L+I35FgG2Z3ljZEIQ
        ZwaP4P/lLaoCFyOBkLzcIZb6LoXP1AxjxZ5gfuds7R3i3KiLhQ/5t6q7mInrKX+Fkv683E
        gZLcg1KTC13htzBWPdIHl7q8VwazN2fBuzTbA/48RNPK5swORQUkSXTtyc8w59nonrRO6u
        WlSFhyLTraK59na3ZeRgf9iG+Yk8ej/goti8uLbSwzaAAbs9B2FZxhKlIafs1A==
Date:   Thu, 3 Mar 2022 17:07:15 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     a.zummo@towertech.it, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] ARM: dts: at91: Move rtt node properties from
 "dts" file to "dtsi" file
Message-ID: <YiDns7xc5mTg7WzH@piout.net>
References: <20220303140626.38129-1-sergiu.moga@microchip.com>
 <20220303140626.38129-2-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303140626.38129-2-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2022 16:06:22+0200, Sergiu Moga wrote:
> Move the properties of the rtt node of RTT IPs from the "dts" file to the
> "dtsi" file, since it is more IP specific than it is board specific.
> 

The fact that it uses a specific GPBR register makes it board specific
so I don't really agree with this patch.

> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> ---
>  arch/arm/boot/dts/at91-sam9x60ek.dts   | 5 -----
>  arch/arm/boot/dts/at91-sama7g5ek.dts   | 4 ----
>  arch/arm/boot/dts/at91sam9260.dtsi     | 1 +
>  arch/arm/boot/dts/at91sam9260ek.dts    | 1 -
>  arch/arm/boot/dts/at91sam9g45.dtsi     | 1 +
>  arch/arm/boot/dts/at91sam9m10g45ek.dts | 1 -
>  arch/arm/boot/dts/sam9x60.dtsi         | 1 +
>  arch/arm/boot/dts/sama7g5.dtsi         | 1 +
>  8 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
> index b1068cca4228..97ff91346cb4 100644
> --- a/arch/arm/boot/dts/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
> @@ -656,11 +656,6 @@ kernel@200000 {
>  	};
>  };
>  
> -&rtt {
> -	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> -	status = "okay";
> -};
> -
>  &shutdown_controller {
>  	debounce-delay-us = <976>;
>  	status = "okay";
> diff --git a/arch/arm/boot/dts/at91-sama7g5ek.dts b/arch/arm/boot/dts/at91-sama7g5ek.dts
> index ccf9e224da78..b7416d9469e3 100644
> --- a/arch/arm/boot/dts/at91-sama7g5ek.dts
> +++ b/arch/arm/boot/dts/at91-sama7g5ek.dts
> @@ -708,10 +708,6 @@ &pwm {
>  	status = "disabled"; /* Conflict with leds. */
>  };
>  
> -&rtt {
> -	atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> -};
> -
>  &sdmmc0 {
>  	bus-width = <8>;
>  	non-removable;
> diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91sam9260.dtsi
> index 7368347c9357..66d11c8f1a9b 100644
> --- a/arch/arm/boot/dts/at91sam9260.dtsi
> +++ b/arch/arm/boot/dts/at91sam9260.dtsi
> @@ -713,6 +713,7 @@ rtc@fffffd20 {
>  				reg = <0xfffffd20 0x10>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>  				clocks = <&pmc PMC_TYPE_CORE PMC_SLOW>;
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9260ek.dts b/arch/arm/boot/dts/at91sam9260ek.dts
> index ce96345d28a3..6932dab42f2e 100644
> --- a/arch/arm/boot/dts/at91sam9260ek.dts
> +++ b/arch/arm/boot/dts/at91sam9260ek.dts
> @@ -118,7 +118,6 @@ shdwc@fffffd10 {
>  			};
>  
>  			rtc@fffffd20 {
> -				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 2ab730fd6472..fd308e2c15e8 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -929,6 +929,7 @@ rtc@fffffd20 {
>  				reg = <0xfffffd20 0x10>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>  				clocks = <&clk32k>;
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index b6256a20fbc7..07bfa8ef715d 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -220,7 +220,6 @@ pwm0: pwm@fffb8000 {
>  			};
>  
>  			rtc@fffffd20 {
> -				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/sam9x60.dtsi b/arch/arm/boot/dts/sam9x60.dtsi
> index ec45ced3cde6..57ba47c54043 100644
> --- a/arch/arm/boot/dts/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/sam9x60.dtsi
> @@ -693,6 +693,7 @@ rtt: rtt@fffffe20 {
>  				reg = <0xfffffe20 0x20>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
>  				clocks = <&clk32k 0>;
> +				atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  			};
>  
>  			pit: timer@fffffe40 {
> diff --git a/arch/arm/boot/dts/sama7g5.dtsi b/arch/arm/boot/dts/sama7g5.dtsi
> index eddcfbf4d223..1530d88ce80f 100644
> --- a/arch/arm/boot/dts/sama7g5.dtsi
> +++ b/arch/arm/boot/dts/sama7g5.dtsi
> @@ -138,6 +138,7 @@ rtt: rtt@e001d020 {
>  			reg = <0xe001d020 0x30>;
>  			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&clk32k 0>;
> +			atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
>  		};
>  
>  		clk32k: clock-controller@e001d050 {
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
