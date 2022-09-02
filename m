Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD35AB3FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbiIBOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237021AbiIBOqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:46:48 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38B9187B70;
        Fri,  2 Sep 2022 07:07:10 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 98EB0240018;
        Fri,  2 Sep 2022 14:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662127564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cIxl/8nO5srbR/poMG8SlAF7azsfFCvutkSt8Y54VY=;
        b=CgA20ngD3xd+T1QweSoML5aiBVAh0PHP7bPlhtYFeDdPAwO7vSSCtg2e0DDED1MIOrdwiE
        JARgh5KD5jIJSzDMagYs8Czuvm7MO8O23gBmA9HrxFXeWEG2rbfPaav1Z9Wkr1AAoEz9L1
        0Duk/ounF87LuIEg9BFpxP0AQJjtBTdVVm9KdacGewG+q92DjWZJo6Hbg4vN4j7NmqBjIm
        vawA/ar01h3Orb/9Y4Gl3m8iFeLxqX2KLSNE81oSr1NJyt0seGrfyfxa/LKnDZ/Ojlkguf
        ohiTcDvE/hJTLeQHZjCvBYKFLnz+VKerG5aGdnXNBMAlhf85m9jidbJvOp2bhQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] arm64: dts: marvell: Add UART1-3 for AC5/AC5X
In-Reply-To: <20220803011623.3607642-1-chris.packham@alliedtelesis.co.nz>
References: <20220803011623.3607642-1-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 02 Sep 2022 16:06:01 +0200
Message-ID: <878rn1g9bq.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Packham <chris.packham@alliedtelesis.co.nz> writes:

> The AC5/AC5X SoC has 4 UART blocks. Add the additional UART1-3 blocks to
> the base dtsi file.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>
> Notes:
>     This applies on top of the series adding the AC5/AC5X SoC which is in
>     Gregory's mvebu/dt64 tree but hasn't made it to Linus's (yet).
>
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index 80b44c7df56a..914fcf9e2c24 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -95,6 +95,36 @@ uart0: serial@12000 {
>  				status = "okay";
>  			};
>  
> +			uart1: serial@12100 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x11000 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-io-width = <1>;
> +				clocks = <&cnm_clock>;
> +				status = "disabled";
> +			};
> +
> +			uart2: serial@12200 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x12200 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-io-width = <1>;
> +				clocks = <&cnm_clock>;
> +				status = "disabled";
> +			};
> +
> +			uart3: serial@12300 {
> +				compatible = "snps,dw-apb-uart";
> +				reg = <0x12300 0x100>;
> +				reg-shift = <2>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +				reg-io-width = <1>;
> +				clocks = <&cnm_clock>;
> +				status = "disabled";
> +			};
> +
>  			mdio: mdio@22004 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -- 
> 2.37.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
