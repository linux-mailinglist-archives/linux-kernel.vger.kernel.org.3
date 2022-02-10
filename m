Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9C84B0B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbiBJKwN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Feb 2022 05:52:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240086AbiBJKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:52:11 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E282E122;
        Thu, 10 Feb 2022 02:52:12 -0800 (PST)
Date:   Thu, 10 Feb 2022 10:52:01 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] clk: ingenic-tcu: Fix missing TCU clock for X1000 SoC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <PU437R.PYKJZT9CEDWM@crapouillou.net>
In-Reply-To: <20220209230145.18943-1-aidanmacdonald.0x0@gmail.com>
References: <20220209230145.18943-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aidan,

Le mer., févr. 9 2022 at 23:01:47 +0000, Aidan MacDonald 
<aidanmacdonald.0x0@gmail.com> a écrit :
> The X1000 does have a TCU clock gate, so pass it to the driver.
> Without this the TCU can be gated automatically, which prevents
> timers from running and stops register writes from taking effect.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
>  drivers/clk/ingenic/tcu.c             | 2 +-

The Device Tree changes should be split into their own patch.

Cheers,
-Paul

>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi 
> b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 8bd27edef216..c69df8eb158e 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -111,8 +111,9 @@ tcu: timer@10002000 {
> 
>  		clocks = <&cgu X1000_CLK_RTCLK>,
>  			 <&cgu X1000_CLK_EXCLK>,
> -			 <&cgu X1000_CLK_PCLK>;
> -		clock-names = "rtc", "ext", "pclk";
> +			 <&cgu X1000_CLK_PCLK>,
> +			 <&cgu X1000_CLK_TCU>;
> +		clock-names = "rtc", "ext", "pclk", "tcu";
> 
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index 77acfbeb4830..9c86043f673a 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -320,7 +320,7 @@ static const struct ingenic_soc_info 
> jz4770_soc_info = {
>  static const struct ingenic_soc_info x1000_soc_info = {
>  	.num_channels = 8,
>  	.has_ost = false, /* X1000 has OST, but it not belong TCU */
> -	.has_tcu_clk = false,
> +	.has_tcu_clk = true,
>  };
> 
>  static const struct of_device_id __maybe_unused 
> ingenic_tcu_of_match[] __initconst = {
> --
> 2.34.1
> 


