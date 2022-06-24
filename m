Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593C55A47C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 00:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFXWrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 18:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXWrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75548895B;
        Fri, 24 Jun 2022 15:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 459C6623FE;
        Fri, 24 Jun 2022 22:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB00C34114;
        Fri, 24 Jun 2022 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656110831;
        bh=Ca3HUp39Q0d3xmJxhaLir8O9ecIOzJGm3bv6w+0zQ+I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HXh0pzsyyEk8HfvYHyOoUCPxe54mkeZuIsw5jveaIiS+zPXuH43k978V3HMPuqwvj
         /xfsKnq4B7JdsojOO1DCar56dWUtBS8SjkM4g/QoU9vsgOhSBJaJDJETSSxyYrqkR8
         RBCPHgT+uhOEX8nkjLR0w3NR1902W3KqzTfLE5V3rugQRs+gShFV11KFgTI+19+89A
         jxNaUuBLuyV41uoGn14lm3z6Treu2tTGYwqqNBZMfV7IlBSFxPaef6Y9C8IJtHV1f5
         GH0N0xNtP66kQ+/tUBilxTbtq+D3RqiNjztOAjUCne9mQh0CCoe+7bTvR5PGR8FpJD
         kuBbEiwB27lbw==
Message-ID: <e07e2591-6913-cb51-021b-125c3c60b2fc@kernel.org>
Date:   Fri, 24 Jun 2022 17:47:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv3] arm64: dts: altera: socfpga_stratix10: move clocks out
 of soc node
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
References: <c90eb127-fa5a-2231-106d-5054e0097281@kernel.org>
 <20220624162159.3403541-1-niravkumar.l.rabara@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20220624162159.3403541-1-niravkumar.l.rabara@intel.com>
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



On 6/24/22 11:21, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> The clocks are not part of the SoC but provided on the board
> (external oscillators). Moving them out of soc node.
> 
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> ---
>   .../boot/dts/altera/socfpga_stratix10.dtsi    | 56 +++++++++----------
>   .../dts/altera/socfpga_stratix10_socdk.dts    | 10 ++--
>   .../altera/socfpga_stratix10_socdk_nand.dts   | 10 ++--
>   3 files changed, 36 insertions(+), 40 deletions(-)
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
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
> index 0ab676c639a1..847a7c01f5af 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_socdk_nand.dts
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
> @@ -126,6 +120,10 @@ partition@200000 {
>   	};
>   };
>   
> +&osc1 {
> +	clock-frequency = <25000000>;
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };


Applied!

Thanks,
Dinh
