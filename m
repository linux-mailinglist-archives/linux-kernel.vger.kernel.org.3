Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7FD574EDE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiGNNTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbiGNNTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:19:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A9152FE1;
        Thu, 14 Jul 2022 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=qkksVEBsCjPaHx8+ptjtKd+HcC8nBi1sTfjXD4WRlds=; b=xw
        9yGMi+YrNTJOLYxGMkDGA/cxANj5nCGoB1T4gTZEUWTLyH8KAVlqkHDE+0PkAyVDqeYnMq+3zuLkD
        UTIgAmlodwQvB1zBQDqk/SRiw3bPM8K/iKejcDHcfnV9hShqqotoA9hYkWGgo4WjeMKFPwIg1qtzt
        t7PeoKg0megdni4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oBykd-00AHn5-Lx; Thu, 14 Jul 2022 15:19:31 +0200
Date:   Thu, 14 Jul 2022 15:19:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] gpio: mvebu: Fix check for pwm support on non-A8K
 platforms
Message-ID: <YtAX427pw+3tnV84@lunn.ch>
References: <20220714115515.5748-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714115515.5748-1-pali@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 01:55:12PM +0200, Pali Rohár wrote:
> pwm support incompatible with Armada 80x0/70x0 API is not only in
> Armada 370, but also in Armada XP, 38x and 39x. So basically every non-A8K
> platform. Fix check for pwm support appropriately.
> 
> Fixes: 85b7d8abfec7 ("gpio: mvebu: add pwm support for Armada 8K/7K")
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
>  drivers/gpio/gpio-mvebu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 2db19cd640a4..70a22b68c034 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -793,8 +793,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
>  	u32 offset;
>  	u32 set;
>  
> -	if (of_device_is_compatible(mvchip->chip.of_node,
> -				    "marvell,armada-370-gpio")) {
> +	if (mvchip->soc_variant != MVEBU_GPIO_SOC_VARIANT_A8K) {
>  		/*
>  		 * There are only two sets of PWM configuration registers for
>  		 * all the GPIO lines on those SoCs which this driver reserves

The current code is:

        if (of_device_is_compatible(mvchip->chip.of_node,
                                    "marvell,armada-370-gpio")) {
                /*
                 * There are only two sets of PWM configuration registers for
                 * all the GPIO lines on those SoCs which this driver reserves
                 * for the first two GPIO chips. So if the resource is missing
                 * we can't treat it as an error.
                 */
                if (!platform_get_resource_byname(pdev, IORESOURCE_MEM, "pwm"))
                        return 0;
                offset = 0;
        } else if (mvchip->soc_variant == MVEBU_GPIO_SOC_VARIANT_A8K) {
                int ret = of_property_read_u32(dev->of_node,
                                               "marvell,pwm-offset", &offset);
                if (ret < 0)
                        return 0;
        } else {
                return 0;
        }

With your change, don't we end up with:

	if (foo)
	    .....
	else if (!foo)
	    .....
	else
	    .....

The static analysers are going to complain about this.

    Andrew
