Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CBE4A5E6A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 15:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239404AbiBAOiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 09:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbiBAOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 09:38:03 -0500
Received: from the.earth.li (the.earth.li [IPv6:2a00:1098:86:4d:c0ff:ee:15:900d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25621C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 06:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
        s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YMgFDARZ8YQji3moecO8LwsGl27AxxFF8y0lNToU7bA=; b=ZVmM79jZzl/eRmbRGhzTPuLdTr
        f27jNFx1qLsm9yLNX4guFrhe0YoBYQYrUb79/ScF0ldTm8gvJs3NduLXd6mBKhrGDSjU5mfA+OIng
        DLaxaY50TD4cCJNElW6e7umg0fb1ZqHVZtZWelB0paL/bbCv2brZAYqRUVyNmZx/KxKHbzMAM17aU
        o+azkaGC+k8o5oBjglQeg8BEFFvOzL71vsmUAvJ1XYStki/7uh5Y3LmpkeCokNN49KPpElxKUiXfo
        sqvMOEg6t4KAxv8T7U8KlNkhHvmuKhFcDz4r0sCUBs2AfEn8s3cGVaDzlGj7J26V7Druzw18KVOjk
        vsm0+ZRQ==;
Received: from noodles by the.earth.li with local (Exim 4.94.2)
        (envelope-from <noodles@earth.li>)
        id 1nEuIB-00C7KX-3q; Tue, 01 Feb 2022 14:37:59 +0000
Date:   Tue, 1 Feb 2022 14:37:59 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] ARM: dts: qcom: add gsbi6 missing definition for
 ipq8064
Message-ID: <YflFx91iRey7N4uv@earth.li>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
 <20220118012051.21691-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118012051.21691-3-ansuelsmth@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 02:20:32AM +0100, Ansuel Smith wrote:
> Add gsbi6 missing definition for ipq8064.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  arch/arm/boot/dts/qcom-ipq8064.dtsi | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> index cc6ca9013ab1..094125605bea 100644
> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
> @@ -665,6 +665,33 @@ spi@1a280000 {
>  			};
>  		};
>  
> +		gsbi6: gsbi@16500000 {
> +			status = "disabled";
> +			compatible = "qcom,gsbi-v1.0.0";
> +			cell-index = <6>;
> +			reg = <0x16500000 0x100>;
> +			clocks = <&gcc GSBI6_H_CLK>;
> +			clock-names = "iface";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			syscon-tcsr = <&tcsr>;
> +
> +			gsbi6_i2c: i2c@16580000 {
> +				compatible = "qcom,i2c-qup-v1.1.1";
> +				reg = <0x16580000 0x1000>;
> +				interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
> +
> +				clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
> +				clock-names = "core", "iface";
> +				status = "disabled";
> +
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};

Can you include the SPI definition too? The RB3011 has its SPI LCD
living here.

		gsbi6_spi: spi@16580000 {
			compatible = "qcom,spi-qup-v1.1.1";
			reg = <0x16580000 0x1000>;
			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;

			clocks = <&gcc GSBI6_QUP_CLK>, <&gcc GSBI6_H_CLK>;
			clock-names = "core", "iface";
			status = "disabled";

			#address-cells = <1>;
			#size-cells = <0>;
		};

> +		};
> +
>  		gsbi7: gsbi@16600000 {
>  			status = "disabled";
>  			compatible = "qcom,gsbi-v1.0.0";
> -- 
> 2.33.1
> 

J.

-- 
] https://www.earth.li/~noodles/ []  "send me the rhubarb" -- Martin   [
]  PGP/GPG Key @ the.earth.li    [] Brooks on the risks of dog poo in  [
] via keyserver, web or email.   []              compost               [
] RSA: 4096/0x94FA372B2DA8B985   []                                    [
