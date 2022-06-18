Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAC550731
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 00:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiFRV7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 17:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiFRV7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 17:59:41 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8C11836;
        Sat, 18 Jun 2022 14:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=hPwZVqjqA3XpHZGiLRjRZWV7WdEQl0KKtUxIsmGR710=; b=hdCb/DxC+Yp6Wv7AgYCaQfhQP5
        9xD0xbWQ4lkwXZlUgRWW7lvheyysOv3NMspVGfcyRExagtaJ0ZfGZogz1ipl3l8FlsQFdLmCe3ApP
        YQVYTdy6ld6puFY4Ku0LRQIitDjemUCawgGKAwqx+DrdlABMGUpoxpcVsamZ9KSuqVYHMMDw/zRi6
        c22HSKa8y6vmyaIT7Mg7uMHlMoxF/2jIcZQwW3GTyq6legMtCJQ9LwnOm2tRdEa96pOsrpaZgLdlB
        rhaeAdt93WeC56LRw2jHTSlR6/MHx5rFhEIrbk55l+KMlKKCLYMWBdQ/Sllnl5+DhEqEADny1yw0p
        aopxhlzg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2gTF-0092dZ-DZ; Sat, 18 Jun 2022 21:59:10 +0000
Message-ID: <c39a479d-4a3c-9789-7ce2-579ae3c778a6@infradead.org>
Date:   Sat, 18 Jun 2022 14:59:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
Content-Language: en-US
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org, jic23@kernel.org,
        lee.jones@linaro.org, sre@kernel.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com
Cc:     lars@metafoo.de, rafael@kernel.org, quic_gurus@quicinc.com,
        sebastian.reichel@collabora.com, andy.shevchenko@gmail.com,
        michael@walle.cc, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/22 14:40, Aidan MacDonald wrote:
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index f52960d2dfbe..a71e35de333d 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -113,6 +113,20 @@ config PINCTRL_AT91PIO4
>  	  Say Y here to enable the at91 pinctrl/gpio driver for Atmel PIO4
>  	  controller available on sama5d2 SoC.
>  
> +config PINCTRL_AXP192
> +	tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
> +	depends on MFD_AXP20X
> +	depends on OF
> +	select PINMUX
> +	select GENERIC_PINCONF
> +	select GPIOLIB
> +	help
> +	  AXP PMICs provides multiple GPIOs that can be muxed for different

	            provide

> +	  functions. This driver bundles a pinctrl driver to select the function
> +	  muxing and a GPIO driver to handle the GPIO when the GPIO function is
> +	  selected.
> +	  Say Y to enable pinctrl and GPIO support for the AXP192 PMIC.

-- 
~Randy
