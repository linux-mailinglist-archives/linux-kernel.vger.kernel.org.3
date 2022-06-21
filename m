Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9DE65535E5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352717AbiFUPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350448AbiFUPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:21:55 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA50D252BD;
        Tue, 21 Jun 2022 08:21:53 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1o3fh4-0001zL-06; Tue, 21 Jun 2022 17:21:30 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 349D9C01AA; Tue, 21 Jun 2022 17:19:45 +0200 (CEST)
Date:   Tue, 21 Jun 2022 17:19:45 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        paul@crapouillou.net, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mips: dts: ingenic: Add TCU clock to x1000/x1830
 tcu device node
Message-ID: <20220621151945.GA12322@alpha.franken.de>
References: <20220617121805.738157-1-aidanmacdonald.0x0@gmail.com>
 <20220617121805.738157-2-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617121805.738157-2-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 01:18:05PM +0100, Aidan MacDonald wrote:
> This clock is a gate for the TCU hardware block on these SoCs, but
> it wasn't included in the device tree since the ingenic-tcu driver
> erroneously did not request it.
> 
> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  arch/mips/boot/dts/ingenic/x1000.dtsi | 5 +++--
>  arch/mips/boot/dts/ingenic/x1830.dtsi | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index b0a034b468bb..42e69664efd9 100644
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
> diff --git a/arch/mips/boot/dts/ingenic/x1830.dtsi b/arch/mips/boot/dts/ingenic/x1830.dtsi
> index dbf21afaccb1..65a5da71c199 100644
> --- a/arch/mips/boot/dts/ingenic/x1830.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1830.dtsi
> @@ -104,8 +104,9 @@ tcu: timer@10002000 {
>  
>  		clocks = <&cgu X1830_CLK_RTCLK>,
>  			 <&cgu X1830_CLK_EXCLK>,
> -			 <&cgu X1830_CLK_PCLK>;
> -		clock-names = "rtc", "ext", "pclk";
> +			 <&cgu X1830_CLK_PCLK>,
> +			 <&cgu X1830_CLK_TCU>;
> +		clock-names = "rtc", "ext", "pclk", "tcu";
>  
>  		interrupt-controller;
>  		#interrupt-cells = <1>;
> -- 
> 2.35.1

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
