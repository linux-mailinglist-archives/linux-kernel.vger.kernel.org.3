Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222D5AC868
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIEBGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIEBGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:06:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916DB26AEF;
        Sun,  4 Sep 2022 18:06:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DFD4B80E4F;
        Mon,  5 Sep 2022 01:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8EDC433D6;
        Mon,  5 Sep 2022 01:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662340007;
        bh=WHlHuifdgAP3L07PRo0ZESVFpJt3mJTHJqUFvycAowI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bwNk0ThxJwpFzzWy8saa5YQp49fQMKD/CsU0saAAVH26vYzyNsv5avmW1q6U8HjkY
         hIXkSS4kLxoOd2XVRy6b6J4p448ainTNkro/Te4IC6V0+u7rKg/QumMlKIMcpDhepr
         /9XsZkng8utT8ExKZwFoyy43/s2H8b7h5fGUKOFAZwMRONF4Or9YtZsPpZeIti5K3n
         g6OfQVcKv44vvavHXf79/juUDwNh1Sj/CUpjwpHemMb66ayz8lfPJvYbxZToKOZb9D
         2PkmEsbildcfZWo0gjFTKf3/pgo6//fx4zl/lutTkwYR2UZZM7D3uvfi3RiEKnuOtD
         /qrN1oGXWK2YQ==
Date:   Mon, 5 Sep 2022 09:06:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Ying <ying.zhang22455@nxp.com>
Subject: Re: [PATCH 08/11] arm64: dts: ls1043a: add gpio based i2c recovery
 information
Message-ID: <20220905010642.GP1728671@dragon>
References: <20220824223700.32442-1-leoyang.li@nxp.com>
 <20220824223700.32442-9-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824223700.32442-9-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:36:59PM -0500, Li Yang wrote:
> Add scl-gpios property for i2c recovery and add SoC specific compatible
> string for SoC specific fixup.
> 
> Signed-off-by: Zhang Ying <ying.zhang22455@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index b37244acf16a..20888aceb5f4 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -538,7 +538,7 @@ dspi1: spi@2110000 {
>  		};
>  
>  		i2c0: i2c@2180000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2180000 0x0 0x10000>;
> @@ -553,7 +553,7 @@ i2c0: i2c@2180000 {
>  		};
>  
>  		i2c1: i2c@2190000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x2190000 0x0 0x10000>;
> @@ -561,11 +561,12 @@ i2c1: i2c@2190000 {
>  			clock-names = "i2c";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> +			scl-gpios = <&gpio4 2 0>;

Could you use the polarity define from include/dt-bindings/gpio/gpio.h?

Shawn

>  			status = "disabled";
>  		};
>  
>  		i2c2: i2c@21a0000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x21a0000 0x0 0x10000>;
> @@ -573,11 +574,12 @@ i2c2: i2c@21a0000 {
>  			clock-names = "i2c";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> +			scl-gpios = <&gpio4 10 0>;
>  			status = "disabled";
>  		};
>  
>  		i2c3: i2c@21b0000 {
> -			compatible = "fsl,vf610-i2c";
> +			compatible = "fsl,ls1043a-i2c", "fsl,vf610-i2c";
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  			reg = <0x0 0x21b0000 0x0 0x10000>;
> @@ -585,6 +587,7 @@ i2c3: i2c@21b0000 {
>  			clock-names = "i2c";
>  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
>  					    QORIQ_CLK_PLL_DIV(1)>;
> +			scl-gpios = <&gpio4 12 0>;
>  			status = "disabled";
>  		};
>  
> -- 
> 2.37.1
> 
