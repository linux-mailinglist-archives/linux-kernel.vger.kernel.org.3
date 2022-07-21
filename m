Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816ED57CA22
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 13:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiGUL6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 07:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbiGUL6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 07:58:44 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 Jul 2022 04:58:43 PDT
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DAC34A801;
        Thu, 21 Jul 2022 04:58:42 -0700 (PDT)
Date:   Thu, 21 Jul 2022 13:53:03 +0200
From:   Alexander Dahl <ada@thorsis.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
Message-ID: <Ytk+H/w78QWov0nL@ada.ifak-system.com>
Mail-Followup-To: Marcus Folkesson <marcus.folkesson@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcus,

Am Thu, Jul 21, 2022 at 11:34:21AM +0200 schrieb Marcus Folkesson:
> 74hc4094 and 75hc4094 works similar to 74x164 but has an additional
               ^^

That 75 is probably a typo, isn't it?

Greets
Alex

> storage latch associated with each stage for strobing data from the
> serial input to parallell buffer tri-state output.
> 
> Add support for an optional strobe pin.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/gpio/gpio-74x164.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/gpio/gpio-74x164.c b/drivers/gpio/gpio-74x164.c
> index e00c33310517..4a1c4de358e4 100644
> --- a/drivers/gpio/gpio-74x164.c
> +++ b/drivers/gpio/gpio-74x164.c
> @@ -21,6 +21,7 @@ struct gen_74x164_chip {
>  	struct gpio_chip	gpio_chip;
>  	struct mutex		lock;
>  	struct gpio_desc	*gpiod_oe;
> +	struct gpio_desc	*gpiod_strobe;
>  	u32			registers;
>  	/*
>  	 * Since the registers are chained, every byte sent will make
> @@ -66,6 +67,10 @@ static void gen_74x164_set_value(struct gpio_chip *gc,
>  		chip->buffer[bank] &= ~(1 << pin);
>  
>  	__gen_74x164_write_config(chip);
> +
> +	/*  Latch data to output pins*/
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
>  	mutex_unlock(&chip->lock);
>  }
>  
> @@ -87,6 +92,10 @@ static void gen_74x164_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>  		chip->buffer[bank] |= bitmask;
>  	}
>  	__gen_74x164_write_config(chip);
> +
> +	/*  Latch data to output pins*/
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
>  	mutex_unlock(&chip->lock);
>  }
>  
> @@ -129,6 +138,12 @@ static int gen_74x164_probe(struct spi_device *spi)
>  
>  	gpiod_set_value_cansleep(chip->gpiod_oe, 1);
>  
> +	chip->gpiod_strobe = devm_gpiod_get_optional(&spi->dev, "strobe",
> +			GPIOD_OUT_LOW);
> +	if (IS_ERR(chip->gpiod_strobe))
> +		return PTR_ERR(chip->gpiod_strobe);
> +
> +
>  	spi_set_drvdata(spi, chip);
>  
>  	chip->gpio_chip.label = spi->modalias;
> @@ -153,6 +168,10 @@ static int gen_74x164_probe(struct spi_device *spi)
>  		goto exit_destroy;
>  	}
>  
> +	/*  Latch data to output pins*/
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 1);
> +	gpiod_set_value_cansleep(chip->gpiod_strobe, 0);
> +
>  	ret = gpiochip_add_data(&chip->gpio_chip, chip);
>  	if (!ret)
>  		return 0;
> @@ -182,6 +201,8 @@ MODULE_DEVICE_TABLE(spi, gen_74x164_spi_ids);
>  static const struct of_device_id gen_74x164_dt_ids[] = {
>  	{ .compatible = "fairchild,74hc595" },
>  	{ .compatible = "nxp,74lvc594" },
> +	{ .compatible = "ti,cd54hc4094" },
> +	{ .compatible = "ti,cd74hc4094" },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, gen_74x164_dt_ids);
> -- 
> 2.36.1
> 
