Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289D5AB574
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbiIBPkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237257AbiIBPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:40:10 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A644412D1D;
        Fri,  2 Sep 2022 08:26:54 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 506CC24000B;
        Fri,  2 Sep 2022 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662132408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Fy626xV2Tm3CJTKs+qGrHJzBs+5FD/GqesK+YQ4VxZ8=;
        b=kvYHlfx7mJ7l3cuSrG9Ck0a7V2/NsWG611ygKtIStRQ1FyQFtqt0N5HdDF8OxMYBvVI9m8
        aJzc0nF1aprBpGjuyqPKOUOIh0RGw7m6fX1W6J6fH+tvq9gMPxTMbh6Y9PuczH3ovS4hkx
        L5fsd/f61G10IqEP5xAZIxF1ZpUCJuTEgRPU+BRP9aftXRY1vRXSVSP1Zqxc5XwaOzxDrZ
        be0waZiXNqatBzNjI7TRvy6NfqdRUGFxtRvzSwxKOWtCGmnGHSmKmx30grz4ia+0tMpTkK
        Huu2u/IzpuKVpo+jimgkT7ie7dSzzwHzCQDL6oRSzbosxDHTwhJufOOcR91bLg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vadym.kochan@plvision.eu
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] arm64: dts: marvell: 98dx25xx: use correct property for
 i2c gpios
In-Reply-To: <20220901022808.691198-1-chris.packham@alliedtelesis.co.nz>
References: <20220901022808.691198-1-chris.packham@alliedtelesis.co.nz>
Date:   Fri, 02 Sep 2022 17:26:46 +0200
Message-ID: <87fsh9er0p.fsf@BL-laptop>
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

> Use the correct names for scl-gpios and sda-gpios so that the generic
> i2c recovery code will find them. While we're here set the
> GPIO_OPEN_DRAIN flag on the gpios.
>
> Fixes: b795fadfc46b ("arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied on mvebu/dt64

Thanks,

Gregory
> ---
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> index 80b44c7df56a..881bf948d1df 100644
> --- a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> @@ -117,8 +117,8 @@ i2c0: i2c@11000{
>  				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&i2c0_pins>;
>  				pinctrl-1 = <&i2c0_gpio>;
> -				scl_gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
> -				sda_gpio = <&gpio0 27 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&gpio0 26 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +				sda-gpios = <&gpio0 27 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  				status = "disabled";
>  			};
>  
> @@ -136,8 +136,8 @@ i2c1: i2c@11100{
>  				pinctrl-names = "default", "gpio";
>  				pinctrl-0 = <&i2c1_pins>;
>  				pinctrl-1 = <&i2c1_gpio>;
> -				scl_gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
> -				sda_gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
> +				scl-gpios = <&gpio0 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
> +				sda-gpios = <&gpio0 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>  				status = "disabled";
>  			};
>  
> -- 
> 2.37.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
