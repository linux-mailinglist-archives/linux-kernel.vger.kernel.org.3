Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2354B574EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiGNNTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiGNNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:19:44 -0400
Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C615D0C6;
        Thu, 14 Jul 2022 06:19:43 -0700 (PDT)
Received: from tarshish (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.tkos.co.il (Postfix) with ESMTPS id AB87F440F68;
        Thu, 14 Jul 2022 16:19:20 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
        s=default; t=1657804761;
        bh=rC0OqKZ10lqLln3fBLyz//cFKspAfwxL4UXaVjVi8XU=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=MrTieGt7XR0JWNrlhEggY6RFpCNTkj4S/I29D/r7E9iLRoiiNEjgQw8yvijyGUY18
         USwelBx/a/W0eH1BaP1mzhtFoM9EGuDIkyQdwKwH7qQFtHooAFVTAkQSU6Nc+jVVkM
         XTerN+TiDMSh98lyFqFChgc5phW+3acfas1dwnG8BDaaQsH0Y6dVmCULYnlDgSSUGF
         n70TM89gabXhe2/ccNloA4yxCXHBI7WYa/82TCDja8IbKO+p3UOwH50XvzjcbJeL1c
         xtOXwehx2xeSIwpMNT+0h9FfXyONjU4gbsY8wNl8dUO7GlHNyoaFZurmpxRm0YhQcW
         WuYOR6YQikoEQ==
References: <20220714115515.5748-1-pali@kernel.org>
User-agent: mu4e 1.8.2; emacs 27.1
From:   Baruch Siach <baruch@tkos.co.il>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K?= =?utf-8?Q?=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] gpio: mvebu: Fix check for pwm support on non-A8K
 platforms
Date:   Thu, 14 Jul 2022 16:14:27 +0300
In-reply-to: <20220714115515.5748-1-pali@kernel.org>
Message-ID: <87lesvde6s.fsf@tarshish>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pali,

On Thu, Jul 14 2022, Pali Roh=C3=A1r wrote:
> pwm support incompatible with Armada 80x0/70x0 API is not only in
> Armada 370, but also in Armada XP, 38x and 39x. So basically every non-A8K
> platform. Fix check for pwm support appropriately.
>
> Fixes: 85b7d8abfec7 ("gpio: mvebu: add pwm support for Armada 8K/7K")
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> ---
>  drivers/gpio/gpio-mvebu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index 2db19cd640a4..70a22b68c034 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -793,8 +793,7 @@ static int mvebu_pwm_probe(struct platform_device *pd=
ev,
>  	u32 offset;
>  	u32 set;
>=20=20
> -	if (of_device_is_compatible(mvchip->chip.of_node,
> -				    "marvell,armada-370-gpio")) {
> +	if (mvchip->soc_variant !=3D MVEBU_GPIO_SOC_VARIANT_A8K) {

The 'if' condition that follow the 'else' below become always true:

       } else if (mvchip->soc_variant =3D=3D MVEBU_GPIO_SOC_VARIANT_A8K) {

I would suggest to keep the '=3D=3D MVEBU_GPIO_SOC_VARIANT_A8K' condition,
and reverse the if/else order, because positive logic is more readable.

There is also another 'else' below that is dead code with this patch.

baruch

>  		/*
>  		 * There are only two sets of PWM configuration registers for
>  		 * all the GPIO lines on those SoCs which this driver reserves


--=20
                                                     ~. .~   Tk Open Systems
=3D}------------------------------------------------ooO--U--Ooo------------=
{=3D
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
