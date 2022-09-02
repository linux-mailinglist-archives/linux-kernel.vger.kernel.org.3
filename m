Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C7F5AB44C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbiIBOw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236663AbiIBOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:52:31 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735541090AF;
        Fri,  2 Sep 2022 07:16:19 -0700 (PDT)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8D132240004;
        Fri,  2 Sep 2022 14:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662128178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jvFVFQ3gZPFCZ+CyZwVWo8EeYLlNEP4xM0MnhWw0ToE=;
        b=CsizKOruepUqRO6dfvpO3S4Ua7yv1vWk3Lbq7/HmImQdjte/A8y250pyLeJ5VjpXnR8yWM
        nzsI4PmwJVB3T4QAULUTfDYd/+cO94MEy7N/lhkj1AgxNCfocOWtHMPQbTsEZsZTfdrLiv
        B2PWt8wG1QsI/tovpc0ruJfjIOesMZFWkIGGwdwQoI5EG5uq/PzHWaBcM9nX2ffbeKJQhg
        iuiV0WGCTjuPu9AQpMHYgnu9w+jUWCnAzg2cYCgcQX6V0u8kza63Eb3X7zNBQeowarHlXB
        Kon17A95D7LxVbod3yUJ1NOCbwKRDAwiwwUkHcuDvTav1Vl+OoWdrbFnYZVGkQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH 2/2] ARM: dts: kirkwood: lsxl: remove first ethernet port
In-Reply-To: <20220816001026.830127-2-michael@walle.cc>
References: <20220816001026.830127-1-michael@walle.cc>
 <20220816001026.830127-2-michael@walle.cc>
Date:   Fri, 02 Sep 2022 16:16:15 +0200
Message-ID: <87wnaleua8.fsf@BL-laptop>
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

Michael Walle <michael@walle.cc> writes:

> Both the Linkstation LS-CHLv2 and the LS-XHL have only one ethernet
> port. This has always been wrong, i.e. the board code used to set up
> both ports, but the driver will play nice and return -ENODEV if the
> assiciated PHY is not found. Nevertheless, it is wrong. Remove it.
>
> Fixes: 876e23333511 ("ARM: kirkwood: add gigabit ethernet and mvmdio device tree nodes")
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied on mvebu/dt

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/kirkwood-lsxl.dtsi | 11 -----------
>  1 file changed, 11 deletions(-)
>
> diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> index 321a40a98ed2..88b70ba1c8fe 100644
> --- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
> @@ -218,22 +218,11 @@ hdd_power: regulator@2 {
>  &mdio {
>  	status = "okay";
>  
> -	ethphy0: ethernet-phy@0 {
> -		reg = <0>;
> -	};
> -
>  	ethphy1: ethernet-phy@8 {
>  		reg = <8>;
>  	};
>  };
>  
> -&eth0 {
> -	status = "okay";
> -	ethernet0-port@0 {
> -		phy-handle = <&ethphy0>;
> -	};
> -};
> -
>  &eth1 {
>  	status = "okay";
>  	ethernet1-port@0 {
> -- 
> 2.30.2
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
