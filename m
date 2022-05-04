Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6163951AC59
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376598AbiEDSJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377052AbiEDSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:09:08 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F10F5933D;
        Wed,  4 May 2022 10:24:55 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0EA971C0BBE; Wed,  4 May 2022 19:24:54 +0200 (CEST)
Date:   Wed, 4 May 2022 19:24:53 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz, andy.shevchenko@gmail.com,
        openbmc@lists.ozlabs.org, joel@jms.id.au
Subject: Re: [PATCH v3 4/4] leds: pca955x: Add HW blink support
Message-ID: <20220504172453.GG1623@bug>
References: <20220411162033.39613-1-eajames@linux.ibm.com>
 <20220411162033.39613-5-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411162033.39613-5-eajames@linux.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Support blinking using the PCA955x chip. Use PWM0 for blinking
> instead of LED_HALF brightness. Since there is only one frequency
> and brightness register for any blinking LED, track the blink state
> of each LED and only support one HW blinking frequency. If another
> frequency is requested, fallback to software blinking.

WHat happens to LED_HALF support in this case? Could we only do the accelerated blinking
if HALF support is not needed?

Best regards,
									Pavel

> ---
>  drivers/leds/leds-pca955x.c | 222 +++++++++++++++++++++++++++---------
>  1 file changed, 168 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/leds/leds-pca955x.c b/drivers/leds/leds-pca955x.c
> index 61f3cb84a945..7c156de215d7 100644
> --- a/drivers/leds/leds-pca955x.c
> +++ b/drivers/leds/leds-pca955x.c
> @@ -62,6 +62,8 @@
>  #define PCA955X_GPIO_HIGH	LED_OFF
>  #define PCA955X_GPIO_LOW	LED_FULL
>  
> +#define PCA955X_BLINK_DEFAULT_MS	1000
> +
>  enum pca955x_type {
>  	pca9550,
>  	pca9551,
> @@ -74,6 +76,7 @@ struct pca955x_chipdef {
>  	int			bits;
>  	u8			slv_addr;	/* 7-bit slave address mask */
>  	int			slv_addr_shift;	/* Number of bits to ignore */
> +	int			blink_div;	/* PSC divider */
>  };
>  
>  static struct pca955x_chipdef pca955x_chipdefs[] = {
> @@ -81,26 +84,31 @@ static struct pca955x_chipdef pca955x_chipdefs[] = {
>  		.bits		= 2,
>  		.slv_addr	= /* 110000x */ 0x60,
>  		.slv_addr_shift	= 1,
> +		.blink_div	= 44,
>  	},
>  	[pca9551] = {
>  		.bits		= 8,
>  		.slv_addr	= /* 1100xxx */ 0x60,
>  		.slv_addr_shift	= 3,
> +		.blink_div	= 38,
>  	},
>  	[pca9552] = {
>  		.bits		= 16,
>  		.slv_addr	= /* 1100xxx */ 0x60,
>  		.slv_addr_shift	= 3,
> +		.blink_div	= 44,
>  	},
>  	[ibm_pca9552] = {
>  		.bits		= 16,
>  		.slv_addr	= /* 0110xxx */ 0x30,
>  		.slv_addr_shift	= 3,
> +		.blink_div	= 44,
>  	},
>  	[pca9553] = {
>  		.bits		= 4,
>  		.slv_addr	= /* 110001x */ 0x62,
>  		.slv_addr_shift	= 1,
> +		.blink_div	= 44,
>  	},
>  };
>  
> @@ -119,7 +127,9 @@ struct pca955x {
>  	struct pca955x_led *leds;
>  	struct pca955x_chipdef	*chipdef;
>  	struct i2c_client	*client;
> +	unsigned long active_blink;
>  	unsigned long active_pins;
> +	unsigned long blink_period;
>  #ifdef CONFIG_LEDS_PCA955X_GPIO
>  	struct gpio_chip gpio;
>  #endif
> @@ -170,7 +180,8 @@ static inline int pca955x_ledstate(u8 ls, int led_num)
>  
>  /*
>   * Write to frequency prescaler register, used to program the
> - * period of the PWM output.  period = (PSCx + 1) / 38
> + * period of the PWM output.  period = (PSCx + 1) / coeff
> + * Where for pca9551 chips coeff = 38 and for all other chips coeff = 44
>   */
>  static int pca955x_write_psc(struct pca955x *pca955x, int n, u8 val)
>  {
> @@ -251,6 +262,20 @@ static int pca955x_read_pwm(struct pca955x *pca955x, int n, u8 *val)
>  	return 0;
>  }
>  
> +static int pca955x_read_psc(struct pca955x *pca955x, int n, u8 *val)
> +{
> +	u8 cmd = pca955x_num_input_regs(pca955x->chipdef->bits) + (2 * n);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(pca955x->client, cmd);
> +	if (ret < 0) {
> +		dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n", __func__, n, ret);
> +		return ret;
> +	}
> +	*val = (u8)ret;
> +	return 0;
> +}
> +
>  static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
>  {
>  	struct pca955x_led *pca955x_led = led_to_pca955x(led_cdev);
> @@ -270,7 +295,10 @@ static enum led_brightness pca955x_led_get(struct led_classdev *led_cdev)
>  		ret = LED_OFF;
>  		break;
>  	case PCA955X_LS_BLINK0:
> -		ret = LED_HALF;
> +		ret = pca955x_read_pwm(pca955x, 0, &pwm);
> +		if (ret)
> +			return ret;
> +		ret = 256 - pwm;
>  		break;
>  	case PCA955X_LS_BLINK1:
>  		ret = pca955x_read_pwm(pca955x, 1, &pwm);
> @@ -299,29 +327,36 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
>  	if (ret)
>  		goto out;
>  
> -	switch (value) {
> -	case LED_FULL:
> -		ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_ON);
> -		break;
> -	case LED_OFF:
> -		ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_OFF);
> -		break;
> -	case LED_HALF:
> -		ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK0);
> -		break;
> -	default:
> -		/*
> -		 * Use PWM1 for all other values.  This has the unwanted
> -		 * side effect of making all LEDs on the chip share the
> -		 * same brightness level if set to a value other than
> -		 * OFF, HALF, or FULL.  But, this is probably better than
> -		 * just turning off for all other values.
> -		 */
> -		ret = pca955x_write_pwm(pca955x, 1, 255 - value);
> -		if (ret)
> +	if (test_bit(pca955x_led->led_num, &pca955x->active_blink)) {
> +		if (value == LED_OFF) {
> +			clear_bit(pca955x_led->led_num, &pca955x->active_blink);
> +			ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_OFF);
> +		} else {
> +			ret = pca955x_write_pwm(pca955x, 0, 256 - value);
>  			goto out;
> -		ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK1);
> -		break;
> +		}
> +	} else {
> +		switch (value) {
> +		case LED_FULL:
> +			ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_ON);
> +			break;
> +		case LED_OFF:
> +			ls = pca955x_ledsel(ls, bit, PCA955X_LS_LED_OFF);
> +			break;
> +		default:
> +			/*
> +			 * Use PWM1 for all other values. This has the unwanted
> +			 * side effect of making all LEDs on the chip share the
> +			 * same brightness level if set to a value other than
> +			 * OFF or FULL. But, this is probably better than just
> +			 * turning off for all other values.
> +			 */
> +			ret = pca955x_write_pwm(pca955x, 1, 255 - value);
> +			if (ret)
> +				goto out;
> +			ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK1);
> +			break;
> +		}
>  	}
>  
>  	ret = pca955x_write_ls(pca955x, reg, ls);
> @@ -332,6 +367,94 @@ static int pca955x_led_set(struct led_classdev *led_cdev,
>  	return ret;
>  }
>  
> +static u8 pca955x_period_to_psc(struct pca955x *pca955x, unsigned long p)
> +{
> +	p *= pca955x->chipdef->blink_div;
> +	p /= MSEC_PER_SEC;
> +	p -= 1;
> +
> +	return p;
> +}
> +
> +static unsigned long pca955x_psc_to_period(struct pca955x *pca955x, u8 psc)
> +{
> +	unsigned long p = psc;
> +
> +	p += 1;
> +	p *= MSEC_PER_SEC;
> +	p /= pca955x->chipdef->blink_div;
> +
> +	return p;
> +}
> +
> +static int pca955x_led_blink(struct led_classdev *led_cdev,
> +			     unsigned long *delay_on, unsigned long *delay_off)
> +{
> +	struct pca955x_led *pca955x_led = led_to_pca955x(led_cdev);
> +	struct pca955x *pca955x = pca955x_led->pca955x;
> +	unsigned long p = *delay_on + *delay_off;
> +	int ret;
> +
> +	mutex_lock(&pca955x->lock);
> +
> +	if (p) {
> +		if (*delay_on != *delay_off) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		if (p < pca955x_psc_to_period(pca955x, 0) ||
> +		    p > pca955x_psc_to_period(pca955x, 0xff)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	} else {
> +		p = pca955x->active_blink ? pca955x->blink_period :
> +			PCA955X_BLINK_DEFAULT_MS;
> +	}
> +
> +	if (!pca955x->active_blink ||
> +	    pca955x->active_blink == BIT(pca955x_led->led_num) ||
> +	    pca955x->blink_period == p) {
> +		u8 psc = pca955x_period_to_psc(pca955x, p);
> +
> +		if (!test_and_set_bit(pca955x_led->led_num,
> +				      &pca955x->active_blink)) {
> +			u8 ls;
> +			int reg = pca955x_led->led_num / 4;
> +			int bit = pca955x_led->led_num % 4;
> +
> +			ret = pca955x_read_ls(pca955x, reg, &ls);
> +			if (ret)
> +				goto out;
> +
> +			ls = pca955x_ledsel(ls, bit, PCA955X_LS_BLINK0);
> +			ret = pca955x_write_ls(pca955x, reg, ls);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		if (pca955x->blink_period != p) {
> +			pca955x->blink_period = p;
> +			ret = pca955x_write_psc(pca955x, 0, psc);
> +			if (ret)
> +				goto out;
> +		}
> +
> +		p = pca955x_psc_to_period(pca955x, psc);
> +		p /= 2;
> +		*delay_on = p;
> +		*delay_off = p;
> +	} else {
> +		ret = -EBUSY;
> +	}
> +
> +out:
> +	mutex_unlock(&pca955x->lock);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_LEDS_PCA955X_GPIO
>  /*
>   * Read the INPUT register, which contains the state of LEDs.
> @@ -487,8 +610,9 @@ static int pca955x_probe(struct i2c_client *client)
>  	u8 ls1[4];
>  	u8 ls2[4];
>  	struct pca955x_platform_data *pdata;
> +	u8 psc0;
> +	bool keep_psc0 = false;
>  	bool set_default_label = false;
> -	bool keep_pwm = false;
>  	char default_label[8];
>  	enum pca955x_type chip_type;
>  	const void *md = device_get_match_data(&client->dev);
> @@ -552,6 +676,7 @@ static int pca955x_probe(struct i2c_client *client)
>  	mutex_init(&pca955x->lock);
>  	pca955x->client = client;
>  	pca955x->chipdef = chip;
> +	pca955x->blink_period = PCA955X_BLINK_DEFAULT_MS;
>  
>  	init_data.devname_mandatory = false;
>  	init_data.devicename = "pca955x";
> @@ -581,15 +706,21 @@ static int pca955x_probe(struct i2c_client *client)
>  			led = &pca955x_led->led_cdev;
>  			led->brightness_set_blocking = pca955x_led_set;
>  			led->brightness_get = pca955x_led_get;
> +			led->blink_set = pca955x_led_blink;
>  
>  			if (pdata->leds[i].default_state ==
> -			    LEDS_GPIO_DEFSTATE_OFF)
> +			    LEDS_GPIO_DEFSTATE_OFF) {
>  				ls2[reg] = pca955x_ledsel(ls2[reg], bit,
>  							  PCA955X_LS_LED_OFF);
> -			else if (pdata->leds[i].default_state ==
> -				   LEDS_GPIO_DEFSTATE_ON)
> +			} else if (pdata->leds[i].default_state ==
> +				   LEDS_GPIO_DEFSTATE_ON) {
>  				ls2[reg] = pca955x_ledsel(ls2[reg], bit,
>  							  PCA955X_LS_LED_ON);
> +			} else if (pca955x_ledstate(ls2[reg], bit) ==
> +				   PCA955X_LS_BLINK0) {
> +				keep_psc0 = true;
> +				set_bit(i, &pca955x->active_blink);
> +			}
>  
>  			init_data.fwnode = pdata->leds[i].fwnode;
>  
> @@ -617,20 +748,6 @@ static int pca955x_probe(struct i2c_client *client)
>  				return err;
>  
>  			set_bit(i, &pca955x->active_pins);
> -
> -			/*
> -			 * For default-state == "keep", let the core update the
> -			 * brightness from the hardware, then check the
> -			 * brightness to see if it's using PWM1. If so, PWM1
> -			 * should not be written below.
> -			 */
> -			if (pdata->leds[i].default_state ==
> -			    LEDS_GPIO_DEFSTATE_KEEP) {
> -				if (led->brightness != LED_FULL &&
> -				    led->brightness != LED_OFF &&
> -				    led->brightness != LED_HALF)
> -					keep_pwm = true;
> -			}
>  		}
>  	}
>  
> @@ -642,22 +759,19 @@ static int pca955x_probe(struct i2c_client *client)
>  		}
>  	}
>  
> -	/* PWM0 is used for half brightness or 50% duty cycle */
> -	err = pca955x_write_pwm(pca955x, 0, 255 - LED_HALF);
> -	if (err)
> -		return err;
> -
> -	if (!keep_pwm) {
> -		/* PWM1 is used for variable brightness, default to OFF */
> -		err = pca955x_write_pwm(pca955x, 1, 0);
> -		if (err)
> -			return err;
> +	if (keep_psc0) {
> +		err = pca955x_read_psc(pca955x, 0, &psc0);
> +	} else {
> +		psc0 = pca955x_period_to_psc(pca955x, pca955x->blink_period);
> +		err = pca955x_write_psc(pca955x, 0, psc0);
>  	}
>  
> -	/* Set to fast frequency so we do not see flashing */
> -	err = pca955x_write_psc(pca955x, 0, 0);
>  	if (err)
>  		return err;
> +
> +	pca955x->blink_period = pca955x_psc_to_period(pca955x, psc0);
> +
> +	/* Set PWM1 to fast frequency so we do not see flashing */
>  	err = pca955x_write_psc(pca955x, 1, 0);
>  	if (err)
>  		return err;
> -- 
> 2.27.0

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
