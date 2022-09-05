Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762655AC86E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiIEBJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiIEBJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:09:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828F6269;
        Sun,  4 Sep 2022 18:09:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 174CB6104A;
        Mon,  5 Sep 2022 01:09:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98A7C433C1;
        Mon,  5 Sep 2022 01:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662340167;
        bh=fAiEswLHsp8nl/7ncVB2cMMYuE6HK3WXb3iwGc/QnY8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X86oYWvuuTviIA6Sne4N+5Tzoj1aDPaAfBgebfPo6i+atcW7KoQ3jfHelKT4dkHo0
         trYtoCRkUu4Y2XhQpaxAtqh31b1hqIeqRHKn9gx2kx5mA9JZLJ1QtDy8w7CRdYwyuS
         6sDbbjIXp0TWifKhVUvjmzR0fukwdB9cIT7DzNzQBjqzw2W5v02qTCQpvDx0uqLR3/
         rMVJqq3r7+k303fDjGLCK/upAFJkIKdKWIkmuPyycgK3C+gkM5MQNSWirhFijFoCnF
         znER9wSHZBafmc9k2P25LfrPyml+0s8v780LoSYel7fqqKYtczxK3gktfuQw7B8KgH
         6ayodvb4aV38g==
Date:   Mon, 5 Sep 2022 09:09:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 09/11] arm64: dts: ls1043a: use a pseudo-bus to constrain
 usb and sata dma size
Message-ID: <20220905010921.GQ1728671@dragon>
References: <20220824223700.32442-1-leoyang.li@nxp.com>
 <20220824223700.32442-10-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824223700.32442-10-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:37:00PM -0500, Li Yang wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Wrap the usb and sata controllers in an intermediate simple-bus and use
> it to constrain the dma address size of these usb controllers to the 40
> bits that they generate toward the interconnect.  This is required
> because the SoC uses 48 bits address sizes and this mismatch would lead
> to smmu context faults because the usb generates 40-bit addresses while
> the smmu page tables are populated with 48-bit wide addresses.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 92 ++++++++++---------
>  1 file changed, 50 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 20888aceb5f4..1942ab84ab1c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -815,51 +815,59 @@ QORIQ_CLK_PLL_DIV(1)>,
>  					    QORIQ_CLK_PLL_DIV(1)>;
>  		};
>  
> -		usb0: usb@2f00000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0x2f00000 0x0 0x10000>;
> -			interrupts = <0 60 0x4>;
> -			dr_mode = "host";
> -			snps,quirk-frame-length-adjustment = <0x20>;
> -			snps,dis_rxdet_inp3_quirk;
> -			usb3-lpm-capable;
> -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> -			status = "disabled";
> -		};
> +		aux_bus: aux_bus {
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			compatible = "simple-bus";
> +			ranges;
> +			dma-ranges = <0x0 0x0 0x0 0x0 0x100 0x00000000>;
> +
> +			usb0: usb@2f00000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x2f00000 0x0 0x10000>;
> +				interrupts = <0 60 0x4>;

While at it, use define for polarity cell?

Shawn

> +				dr_mode = "host";
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,dis_rxdet_inp3_quirk;
> +				usb3-lpm-capable;
> +				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +				status = "disabled";
> +			};
>  
> -		usb1: usb@3000000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0x3000000 0x0 0x10000>;
> -			interrupts = <0 61 0x4>;
> -			dr_mode = "host";
> -			snps,quirk-frame-length-adjustment = <0x20>;
> -			snps,dis_rxdet_inp3_quirk;
> -			usb3-lpm-capable;
> -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> -			status = "disabled";
> -		};
> +			usb1: usb@3000000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x3000000 0x0 0x10000>;
> +				interrupts = <0 61 0x4>;
> +				dr_mode = "host";
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,dis_rxdet_inp3_quirk;
> +				usb3-lpm-capable;
> +				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +				status = "disabled";
> +			};
>  
> -		usb2: usb@3100000 {
> -			compatible = "snps,dwc3";
> -			reg = <0x0 0x3100000 0x0 0x10000>;
> -			interrupts = <0 63 0x4>;
> -			dr_mode = "host";
> -			snps,quirk-frame-length-adjustment = <0x20>;
> -			snps,dis_rxdet_inp3_quirk;
> -			usb3-lpm-capable;
> -			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> -			status = "disabled";
> -		};
> +			usb2: usb@3100000 {
> +				compatible = "snps,dwc3";
> +				reg = <0x0 0x3100000 0x0 0x10000>;
> +				interrupts = <0 63 0x4>;
> +				dr_mode = "host";
> +				snps,quirk-frame-length-adjustment = <0x20>;
> +				snps,dis_rxdet_inp3_quirk;
> +				usb3-lpm-capable;
> +				snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
> +				status = "disabled";
> +			};
>  
> -		sata: sata@3200000 {
> -			compatible = "fsl,ls1043a-ahci";
> -			reg = <0x0 0x3200000 0x0 0x10000>,
> -				<0x0 0x20140520 0x0 0x4>;
> -			reg-names = "ahci", "sata-ecc";
> -			interrupts = <0 69 0x4>;
> -			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> -					    QORIQ_CLK_PLL_DIV(1)>;
> -			dma-coherent;
> +			sata: sata@3200000 {
> +				compatible = "fsl,ls1043a-ahci";
> +				reg = <0x0 0x3200000 0x0 0x10000>,
> +					<0x0 0x20140520 0x0 0x4>;
> +				reg-names = "ahci", "sata-ecc";
> +				interrupts = <0 69 0x4>;
> +				clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
> +						    QORIQ_CLK_PLL_DIV(1)>;
> +				dma-coherent;
> +			};
>  		};
>  
>  		msi1: msi-controller1@1571000 {
> -- 
> 2.37.1
> 
