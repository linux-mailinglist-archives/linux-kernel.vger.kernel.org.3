Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0878651F92C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238367AbiEIJfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237985AbiEIJDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:03:14 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AAB1F2D4E;
        Mon,  9 May 2022 01:59:20 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4040060007;
        Mon,  9 May 2022 08:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652086709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U5akIdDJMA918kHVeaD7i8OAyc7tkvrEggEeV1bPsrU=;
        b=iKuTHEQnWjVPXjepUTc+lXdj3UOlHjvQqyp6A+KGvVdAoOfTv5cQYMWxYE/+5vvbatIdmC
        MKeceG5AJh86KzuemZUzBCFSdOIU9x30h+6rtJEyHz4AD3wQLzogKPoJ6go/Oq5RKUggsS
        M+oUM9vFXMsvD7lfFru9oQsazbI/RKiomPtNDFvqJYDVNXEbKhoBqi6RmUkfjXlkYiF8ns
        OCMobAtojXyx9h4J3qYLjGKbuRnyGFg78WmjOvQGjDfW94fuZVGdo5yJQciWaLJIqOCm5c
        ypXrRknf0Ccnjvhj0c5aWyIycEayIgQEiBhYIHRaO2ImGbMktqXl6vs44r54hg==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Robert Marko <robert.marko@sartura.hr>, andrew@lunn.ch,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pali@kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v3 2/3] arm64: dts: marvell: espressobin-ultra: add PHY
 and switch reset pins
In-Reply-To: <20210928170919.691845-2-robert.marko@sartura.hr>
References: <20210928170919.691845-1-robert.marko@sartura.hr>
 <20210928170919.691845-2-robert.marko@sartura.hr>
Date:   Mon, 09 May 2022 10:57:33 +0200
Message-ID: <87h75zrsle.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Marko <robert.marko@sartura.hr> writes:

> Both the Topaz switch and 88E1512 PHY have their reset and interrupts
> connected to the SoC.
>
> So, define the Topaz and 88E1512 reset pins in the DTS.
>
> Defining the interrupt pins wont work as both the 88E1512 and the
> Topaz switch uses active LOW IRQ signals but the A37xx GPIO controller
> only supports edge triggers.
> 88E1512 would require special setup anyway as its INT pin is shared with
> the LED2 and you first need to configure it as INT.
>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>


Applied on mvebu/dt64

Thanks,

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> index 610ff6f385c7..7c786d218f1b 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
> @@ -114,12 +114,16 @@ &usb3 {
>  &mdio {
>  	extphy: ethernet-phy@1 {
>  		reg = <1>;
> +
> +		reset-gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
>  	};
>  };
>  
>  &switch0 {
>  	reg = <3>;
>  
> +	reset-gpios = <&gpiosb 23 GPIO_ACTIVE_LOW>;
> +
>  	ports {
>  		switch0port1: port@1 {
>  			reg = <1>;
> -- 
> 2.31.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
