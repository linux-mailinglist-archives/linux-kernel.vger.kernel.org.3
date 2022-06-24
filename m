Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9B559CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbiFXOxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbiFXOxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:53:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F6581702;
        Fri, 24 Jun 2022 07:49:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C4C46B82929;
        Fri, 24 Jun 2022 14:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC909C34114;
        Fri, 24 Jun 2022 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656082173;
        bh=pZY+pA5AINAjtnkof1xdlWisxtGnP3HBGU+2ebSV7h8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U4iDyQPS3eVRP4fTQRv7+TVyY6fpy+8zlZxcb+T8qyL7dtsvRNfnudWqIEWGQPkoj
         +Hcpkq2nJpImcv/t3xq5Fi/nJ7oYjamstZd+E5WKH0Bay189S7iYCdMaW/1VCqddLT
         yS1EoPCqxs3SmEP1nrR/RYKvUOGIMbjHaXDnoBrOB+TpLMY1nIXOPBn4oT7uxnM5XV
         GqZgK8Uwvx/kE3+g4byAthuGKTJHSprbfW2zw53H7MsRgfWUn+3hcBfazu3pjnPvG4
         KIaF8DHOsSgciPBkTZTRoqBMKBkN+ikGFfYwATGBGWYCHax+2SBs1N6L0jzAhJMYnR
         bsRaAE38EiePg==
Message-ID: <c90eb127-fa5a-2231-106d-5054e0097281@kernel.org>
Date:   Fri, 24 Jun 2022 09:49:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] arm64: dts: altera: socfpga_stratix10: move clocks out of
 soc node
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <20220624031017.3247656-1-niravkumar.l.rabara@intel.com>
 <20220624115911.3389627-1-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220624115911.3389627-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/22 06:59, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> The clocks are not part of the SoC but provided on the board
> (external oscillators). Moving them out of soc node.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   .../boot/dts/altera/socfpga_stratix10.dtsi    | 56 +++++++++----------
>   .../dts/altera/socfpga_stratix10_socdk.dts    | 10 ++--
>   2 files changed, 32 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index aa2bba75265f..5c7d926d18f7 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> @@ -97,6 +97,34 @@ intc: interrupt-controller@fffc1000 {
>   		      <0x0 0xfffc6000 0x0 0x2000>;
>   	};
>   
> +	clocks {
> +		cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		cb_intosc_ls_clk: cb-intosc-ls-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		f2s_free_clk: f2s-free-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		osc1: osc1 {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +		};
> +
> +		qspi_clk: qspi-clk {
> +			#clock-cells = <0>;
> +			compatible = "fixed-clock";
> +			clock-frequency = <200000000>;
> +		};
> +	};
> +
>   	soc {
>   		#address-cells = <1>;
>   		#size-cells = <1>;
> @@ -119,34 +147,6 @@ clkmgr: clock-controller@ffd10000 {
>   			#clock-cells = <1>;
>   		};
>   
> -		clocks {
> -			cb_intosc_hs_div2_clk: cb-intosc-hs-div2-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			cb_intosc_ls_clk: cb-intosc-ls-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			f2s_free_clk: f2s-free-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			osc1: osc1 {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -			};
> -
> -			qspi_clk: qspi-clk {
> -				#clock-cells = <0>;
> -				compatible = "fixed-clock";
> -				clock-frequency = <200000000>;
> -			};
> -		};
> -
>   		gmac0: ethernet@ff800000 {
>   			compatible = "altr,socfpga-stmmac-a10-s10", "snps,dwmac-3.74a", "snps,dwmac";
>   			reg = <0xff800000 0x2000>;
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> index 5159cd5771dc..48424e459f12 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk.dts
> @@ -52,12 +52,6 @@ ref_033v: regulator-v-ref {
>   	};
>   
>   	soc {
> -		clocks {
> -			osc1 {
> -				clock-frequency = <25000000>;
> -			};
> -		};
> -
>   		eccmgr {
>   			sdmmca-ecc@ff8c8c00 {
>   				compatible = "altr,socfpga-s10-sdmmc-ecc",
> @@ -113,6 +107,10 @@ &mmc {
>   	bus-width = <4>;
>   };
>   
> +&osc1 {
> +	clock-frequency = <25000000>;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };

What about arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts?

Also for future versions, please use a 'PATCHv#".

