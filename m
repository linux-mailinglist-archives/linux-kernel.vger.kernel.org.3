Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F03A6599CCE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349334AbiHSNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349323AbiHSNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:12:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF0BA61D1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 06:12:40 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oP1ne-0000PI-Ts; Fri, 19 Aug 2022 15:12:34 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oP1nb-0008LN-HJ; Fri, 19 Aug 2022 15:12:31 +0200
Date:   Fri, 19 Aug 2022 15:12:31 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Gireesh.Hiremath@in.bosch.com
Cc:     linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dmitry.torokhov@gmail.com,
        mkorpershoek@baylibre.com, davidgow@google.com,
        swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Message-ID: <20220819131231.nzi26cbrpgfrycl2@pengutronix.de>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gireesh,

On 22-08-19, Gireesh.Hiremath@in.bosch.com wrote:
> From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Switch from gpio API to gpiod API

Nice change.

Did you checked the users of this driver? This change changes the
behaviour for actice_low GPIOs. A quick check showed that at least on
upstream board: arch/arm/mach-pxa/palmtc.c uses active low GPIOs.

> Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> 
> Gbp-Pq: Topic apertis/guardian
> Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch

Please drop this internal tags.

> ---
>  drivers/input/keyboard/matrix_keypad.c | 84 ++++++++++----------------
>  include/linux/input/matrix_keypad.h    |  4 +-
>  2 files changed, 33 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 30924b57058f..b99574edad9c 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -15,11 +15,10 @@
>  #include <linux/interrupt.h>
>  #include <linux/jiffies.h>
>  #include <linux/module.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  
>  struct matrix_keypad {
> @@ -49,11 +48,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
>  	bool level_on = !pdata->active_low;
>  
>  	if (on) {
> -		gpio_direction_output(pdata->col_gpios[col], level_on);
> +		gpiod_direction_output(pdata->col_gpios[col], level_on);

Now strange things can happen, if active_low is set and you specified
GPIO_ACTIVE_LOW within the device-tree. We need a way to move to gpiod
and keep the current behaviour.

>  	} else {
> -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
>  		if (!pdata->drive_inactive_cols)
> -			gpio_direction_input(pdata->col_gpios[col]);
> +			gpiod_direction_input(pdata->col_gpios[col]);
>  	}
>  }
>  
> @@ -78,7 +77,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
>  static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
>  			 int row)
>  {
> -	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
> +	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
>  			!pdata->active_low : pdata->active_low;
>  }
>  
> @@ -91,7 +90,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
>  		enable_irq(pdata->clustered_irq);
>  	else {
>  		for (i = 0; i < pdata->num_row_gpios; i++)
> -			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
> +			enable_irq(gpiod_to_irq(pdata->row_gpios[i]));
>  	}
>  }
>  
> @@ -104,7 +103,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
>  		disable_irq_nosync(pdata->clustered_irq);
>  	else {
>  		for (i = 0; i < pdata->num_row_gpios; i++)
> -			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
> +			disable_irq_nosync(gpiod_to_irq(pdata->row_gpios[i]));
>  	}
>  }
>  
> @@ -230,7 +229,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
>  static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
>  {
>  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> -	unsigned int gpio;
> +	struct gpio_desc *gpio;
>  	int i;
>  
>  	if (pdata->clustered_irq > 0) {
> @@ -242,7 +241,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
>  			if (!test_bit(i, keypad->disabled_gpios)) {
>  				gpio = pdata->row_gpios[i];
>  
> -				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
> +				if (enable_irq_wake(gpiod_to_irq(gpio)) == 0)
>  					__set_bit(i, keypad->disabled_gpios);
>  			}
>  		}
> @@ -252,7 +251,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
>  static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
>  {
>  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> -	unsigned int gpio;
> +	struct gpio_desc *gpio;
>  	int i;
>  
>  	if (pdata->clustered_irq > 0) {
> @@ -264,7 +263,7 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
>  		for (i = 0; i < pdata->num_row_gpios; i++) {
>  			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
>  				gpio = pdata->row_gpios[i];
> -				disable_irq_wake(gpio_to_irq(gpio));
> +				disable_irq_wake(gpiod_to_irq(gpio));
>  			}
>  		}
>  	}
> @@ -308,27 +307,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  
>  	/* initialized strobe lines as outputs, activated */
>  	for (i = 0; i < pdata->num_col_gpios; i++) {
> -		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
> -		if (err) {
> -			dev_err(&pdev->dev,
> -				"failed to request GPIO%d for COL%d\n",
> -				pdata->col_gpios[i], i);
> -			goto err_free_cols;
> -		}
> -
> -		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
> +		gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
>  	}
>  
>  	for (i = 0; i < pdata->num_row_gpios; i++) {
> -		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
> -		if (err) {
> -			dev_err(&pdev->dev,
> -				"failed to request GPIO%d for ROW%d\n",
> -				pdata->row_gpios[i], i);
> -			goto err_free_rows;
> -		}
> -
> -		gpio_direction_input(pdata->row_gpios[i]);
> +		gpiod_direction_input(pdata->row_gpios[i]);
>  	}
>  
>  	if (pdata->clustered_irq > 0) {
> @@ -344,7 +327,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  	} else {
>  		for (i = 0; i < pdata->num_row_gpios; i++) {
>  			err = request_any_context_irq(
> -					gpio_to_irq(pdata->row_gpios[i]),
> +					gpiod_to_irq(pdata->row_gpios[i]),
>  					matrix_keypad_interrupt,
>  					IRQF_TRIGGER_RISING |
>  					IRQF_TRIGGER_FALLING,
> @@ -352,7 +335,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  			if (err < 0) {
>  				dev_err(&pdev->dev,
>  					"Unable to acquire interrupt for GPIO line %i\n",
> -					pdata->row_gpios[i]);
> +					i);
>  				goto err_free_irqs;
>  			}
>  		}
> @@ -364,15 +347,12 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  
>  err_free_irqs:
>  	while (--i >= 0)
> -		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
> +		free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
>  	i = pdata->num_row_gpios;
>  err_free_rows:
>  	while (--i >= 0)
> -		gpio_free(pdata->row_gpios[i]);
> +		gpiod_put(pdata->row_gpios[i]);
>  	i = pdata->num_col_gpios;
> -err_free_cols:
> -	while (--i >= 0)
> -		gpio_free(pdata->col_gpios[i]);
>  
>  	return err;
>  }
> @@ -386,14 +366,14 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
>  		free_irq(pdata->clustered_irq, keypad);
>  	} else {
>  		for (i = 0; i < pdata->num_row_gpios; i++)
> -			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
> +			free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
>  	}
>  
>  	for (i = 0; i < pdata->num_row_gpios; i++)
> -		gpio_free(pdata->row_gpios[i]);
> +		gpiod_put(pdata->row_gpios[i]);
>  
>  	for (i = 0; i < pdata->num_col_gpios; i++)
> -		gpio_free(pdata->col_gpios[i]);
> +		gpiod_put(pdata->col_gpios[i]);
>  }
>  
>  #ifdef CONFIG_OF
> @@ -402,7 +382,8 @@ matrix_keypad_parse_dt(struct device *dev)
>  {
>  	struct matrix_keypad_platform_data *pdata;
>  	struct device_node *np = dev->of_node;
> -	unsigned int *gpios;
> +	struct gpio_desc **gpios;
> +	struct gpio_desc *desc;
>  	int ret, i, nrow, ncol;
>  
>  	if (!np) {
> @@ -416,8 +397,8 @@ matrix_keypad_parse_dt(struct device *dev)
>  		return ERR_PTR(-ENOMEM);
>  	}
>  
> -	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
> -	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
> +	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
> +	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
>  	if (nrow <= 0 || ncol <= 0) {
>  		dev_err(dev, "number of keypad rows/columns not specified\n");
>  		return ERR_PTR(-EINVAL);
> @@ -429,9 +410,6 @@ matrix_keypad_parse_dt(struct device *dev)
>  	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
>  			of_property_read_bool(np, "linux,wakeup"); /* legacy */
>  
> -	if (of_get_property(np, "gpio-activelow", NULL))
> -		pdata->active_low = true;
> -

This removes backward compatibility, please don't do that.

Regards,
  Marco

>  	pdata->drive_inactive_cols =
>  		of_property_read_bool(np, "drive-inactive-cols");
>  
> @@ -441,7 +419,7 @@ matrix_keypad_parse_dt(struct device *dev)
>  
>  	gpios = devm_kcalloc(dev,
>  			     pdata->num_row_gpios + pdata->num_col_gpios,
> -			     sizeof(unsigned int),
> +			     sizeof(*gpios),
>  			     GFP_KERNEL);
>  	if (!gpios) {
>  		dev_err(dev, "could not allocate memory for gpios\n");
> @@ -449,17 +427,17 @@ matrix_keypad_parse_dt(struct device *dev)
>  	}
>  
>  	for (i = 0; i < nrow; i++) {
> -		ret = of_get_named_gpio(np, "row-gpios", i);
> -		if (ret < 0)
> +		desc = devm_gpiod_get_index(dev, "row", i, GPIOD_IN);
> +		if (IS_ERR(desc))
>  			return ERR_PTR(ret);
> -		gpios[i] = ret;
> +		gpios[i] = desc;
>  	}
>  
>  	for (i = 0; i < ncol; i++) {
> -		ret = of_get_named_gpio(np, "col-gpios", i);
> -		if (ret < 0)
> +		desc = devm_gpiod_get_index(dev, "col", i, GPIOD_IN);
> +		if (IS_ERR(desc))
>  			return ERR_PTR(ret);
> -		gpios[nrow + i] = ret;
> +		gpios[nrow + i] = desc;
>  	}
>  
>  	pdata->row_gpios = gpios;
> diff --git a/include/linux/input/matrix_keypad.h b/include/linux/input/matrix_keypad.h
> index 9476768c3b90..8ad7d4626e62 100644
> --- a/include/linux/input/matrix_keypad.h
> +++ b/include/linux/input/matrix_keypad.h
> @@ -59,8 +59,8 @@ struct matrix_keymap_data {
>  struct matrix_keypad_platform_data {
>  	const struct matrix_keymap_data *keymap_data;
>  
> -	const unsigned int *row_gpios;
> -	const unsigned int *col_gpios;
> +	struct gpio_desc **row_gpios;
> +	struct gpio_desc **col_gpios;
>  
>  	unsigned int	num_row_gpios;
>  	unsigned int	num_col_gpios;
> -- 
> 2.20.1
> 
> 
