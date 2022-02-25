Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665094C472D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbiBYOPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiBYOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:15:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B0921DA016;
        Fri, 25 Feb 2022 06:14:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF705106F;
        Fri, 25 Feb 2022 06:14:38 -0800 (PST)
Received: from [10.57.39.47] (unknown [10.57.39.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A17A63F5A1;
        Fri, 25 Feb 2022 06:14:36 -0800 (PST)
Message-ID: <2939d801-586d-85fd-97ef-d42925ddecce@arm.com>
Date:   Fri, 25 Feb 2022 14:14:31 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 1/4] arm64: dts: rockchip: move power domain PD_PIPE to
 rk356x
Content-Language: en-GB
To:     Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Simon Xue <xxm@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
 <20220225131602.2283499-2-michael.riesch@wolfvision.net>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220225131602.2283499-2-michael.riesch@wolfvision.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-25 13:15, Michael Riesch wrote:
> The power domain PD_PIPE was moved to the RK3568 specific dtsi but
> is available on the RK3566 as well. Move it back to the shared dtsi.

Note that a corresponding definition does already exist in rk3568.dtsi. 
That one *could* inherit the base definition and only override the 
"pm_qos" property, but looking back to the original patch series it 
seems like not doing that was a deliberate choice.

Robin.

> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>   arch/arm64/boot/dts/rockchip/rk3568.dtsi | 16 ----------------
>   arch/arm64/boot/dts/rockchip/rk356x.dtsi | 14 ++++++++++++++
>   2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> index 91a0b798b857..ecc0f3015915 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
> @@ -100,19 +100,3 @@ opp-1992000000 {
>   		opp-microvolt = <1150000 1150000 1150000>;
>   	};
>   };
> -
> -&power {
> -	power-domain@RK3568_PD_PIPE {
> -		reg = <RK3568_PD_PIPE>;
> -		clocks = <&cru PCLK_PIPE>;
> -		pm_qos = <&qos_pcie2x1>,
> -			 <&qos_pcie3x1>,
> -			 <&qos_pcie3x2>,
> -			 <&qos_sata0>,
> -			 <&qos_sata1>,
> -			 <&qos_sata2>,
> -			 <&qos_usb3_0>,
> -			 <&qos_usb3_1>;
> -		#power-domain-cells = <0>;
> -	};
> -};
> diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> index 8b9fae3d348a..742f5adcdf2b 100644
> --- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
> @@ -490,6 +490,20 @@ power-domain@RK3568_PD_RKVENC {
>   					 <&qos_rkvenc_wr_m0>;
>   				#power-domain-cells = <0>;
>   			};
> +
> +			power-domain@RK3568_PD_PIPE {
> +				reg = <RK3568_PD_PIPE>;
> +				clocks = <&cru PCLK_PIPE>;
> +				pm_qos = <&qos_pcie2x1>,
> +					 <&qos_pcie3x1>,
> +					 <&qos_pcie3x2>,
> +					 <&qos_sata0>,
> +					 <&qos_sata1>,
> +					 <&qos_sata2>,
> +					 <&qos_usb3_0>,
> +					 <&qos_usb3_1>;
> +				#power-domain-cells = <0>;
> +			};
>   		};
>   	};
>   
