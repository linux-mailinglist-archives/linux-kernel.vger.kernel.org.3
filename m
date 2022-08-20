Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C92F59AA57
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 03:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244364AbiHTA7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbiHTA7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:59:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1CDB7750;
        Fri, 19 Aug 2022 17:59:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s206so4915302pgs.3;
        Fri, 19 Aug 2022 17:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=7ETiwQl3PE0gS3p1yZNKwRLbYB4yEgnAjiWaZl01Ej4=;
        b=a/XWSoSzLWgIYfGj2MZNh1oL1HQQ6on2vA08OqrU1/QBqWKjmVfCK7zJMJ598XPLmr
         GXYWcKKC7LiPhSnjmed/SKOb3yg9r35RvgbMWfYARvIq53bKZP14pRf/oKH0I3Ho+24m
         KaAnO/YUecgjDkR5s2bxaKySyRHTmBqLRpkoz4Rxi6jnkPb/3lnTItH2L2Hgpn/i6utj
         pFj5g3DCIXTeAQpdqAwi5fcSN6r2u2pwsxHxH+MsVo7Zf7iMN+exvqF5INAHDRD3p2p/
         QlPtkRrxv5LcfiO6r+Efb8Or0UiVhebVco1Q+fJMcS6D9l72eeouIW/aR0KGzAmW2BK6
         /j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=7ETiwQl3PE0gS3p1yZNKwRLbYB4yEgnAjiWaZl01Ej4=;
        b=PpC1F/wLaiQ0NWWn+bktTQAeGAy+tD79fi1GCcRpGO9nuOuMz80m4eYvcPNpw7mo6i
         Mh78cbg1Zcgv69UHw0ExeIJ5DE79wWoU4VT+bE1oGYLeiIKW06tAqaOsXujdNHZN15rT
         F5ZtT2Z2vIws8flGNSmUIgQEId1LoaVhOEMuLzfnZUP8ajHGwaW5JFkPtQYgeEl/IzHd
         gqsdLEIE4/RR/ui6HVSj6myYqe5jTvUKCuFLZjGxqair/TV5KOi6I8jalup0Dby5ctNe
         JIV0ZufHWmba+p/pJWClOV2nRoSN9D4lbRJKq3ON0dKwfPQU5vdYA303Ciwny7LeIT6Q
         WjXg==
X-Gm-Message-State: ACgBeo2qXgEyHqy2itFEFCjV2BkUSyIa+Y5dS1H/BPYJ7X9YBQDd7h/1
        B1aACA5VMu0bAwgrNCNg3c4=
X-Google-Smtp-Source: AA6agR4Yw4tRLyNAtVcmJT1HTpVfPAO85/rYniawHc+CrHlz8wh/Q5fwWOEFhLgBXXABEqBtJ73Q0A==
X-Received: by 2002:a63:8749:0:b0:41d:89d4:ce3d with SMTP id i70-20020a638749000000b0041d89d4ce3dmr7978965pge.344.1660957154929;
        Fri, 19 Aug 2022 17:59:14 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:3e7:2d3d:d921:7f8a])
        by smtp.gmail.com with ESMTPSA id g2-20020a63f402000000b0040d75537824sm3272643pgi.86.2022.08.19.17.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:59:14 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:59:11 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Gireesh.Hiremath@in.bosch.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, bcousson@baylibre.com,
        tony@atomide.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mkorpershoek@baylibre.com,
        davidgow@google.com, swboyd@chromium.org, fengping.yu@mediatek.com,
        y.oudjana@protonmail.com, rdunlap@infradead.org,
        colin.king@intel.com, sjoerd.simons@collabora.co.uk,
        VinayKumar.Shettar@in.bosch.com,
        Govindaraji.Sivanantham@in.bosch.com, anaclaudia.dias@de.bosch.com
Subject: Re: [PATCH v3 1/3] driver: input: matric-keypad: switch to gpiod
Message-ID: <YwAx38N0ICE37Vu9@google.com>
References: <20220819065946.9572-1-Gireesh.Hiremath@in.bosch.com>
 <20220819131231.nzi26cbrpgfrycl2@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819131231.nzi26cbrpgfrycl2@pengutronix.de>
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 03:12:31PM +0200, Marco Felsch wrote:
> Hi Gireesh,
> 
> On 22-08-19, Gireesh.Hiremath@in.bosch.com wrote:
> > From: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > 
> > Switch from gpio API to gpiod API
> 
> Nice change.
> 
> Did you checked the users of this driver? This change changes the
> behaviour for actice_low GPIOs. A quick check showed that at least on
> upstream board: arch/arm/mach-pxa/palmtc.c uses active low GPIOs.
> 
> > Signed-off-by: Gireesh Hiremath <Gireesh.Hiremath@in.bosch.com>
> > 
> > Gbp-Pq: Topic apertis/guardian
> > Gbp-Pq: Name driver-input-matric-keypad-switch-gpio-to-gpiod.patch
> 
> Please drop this internal tags.
> 
> > ---
> >  drivers/input/keyboard/matrix_keypad.c | 84 ++++++++++----------------
> >  include/linux/input/matrix_keypad.h    |  4 +-
> >  2 files changed, 33 insertions(+), 55 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> > index 30924b57058f..b99574edad9c 100644
> > --- a/drivers/input/keyboard/matrix_keypad.c
> > +++ b/drivers/input/keyboard/matrix_keypad.c
> > @@ -15,11 +15,10 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/jiffies.h>
> >  #include <linux/module.h>
> > -#include <linux/gpio.h>
> > +#include <linux/gpio/consumer.h>
> >  #include <linux/input/matrix_keypad.h>
> >  #include <linux/slab.h>
> >  #include <linux/of.h>
> > -#include <linux/of_gpio.h>
> >  #include <linux/of_platform.h>
> >  
> >  struct matrix_keypad {
> > @@ -49,11 +48,11 @@ static void __activate_col(const struct matrix_keypad_platform_data *pdata,
> >  	bool level_on = !pdata->active_low;
> >  
> >  	if (on) {
> > -		gpio_direction_output(pdata->col_gpios[col], level_on);
> > +		gpiod_direction_output(pdata->col_gpios[col], level_on);
> 
> Now strange things can happen, if active_low is set and you specified
> GPIO_ACTIVE_LOW within the device-tree. We need a way to move to gpiod
> and keep the current behaviour.
> 
> >  	} else {
> > -		gpio_set_value_cansleep(pdata->col_gpios[col], !level_on);
> > +		gpiod_set_value_cansleep(pdata->col_gpios[col], !level_on);
> >  		if (!pdata->drive_inactive_cols)
> > -			gpio_direction_input(pdata->col_gpios[col]);
> > +			gpiod_direction_input(pdata->col_gpios[col]);
> >  	}
> >  }
> >  
> > @@ -78,7 +77,7 @@ static void activate_all_cols(const struct matrix_keypad_platform_data *pdata,
> >  static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
> >  			 int row)
> >  {
> > -	return gpio_get_value_cansleep(pdata->row_gpios[row]) ?
> > +	return gpiod_get_value_cansleep(pdata->row_gpios[row]) ?
> >  			!pdata->active_low : pdata->active_low;
> >  }
> >  
> > @@ -91,7 +90,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
> >  		enable_irq(pdata->clustered_irq);
> >  	else {
> >  		for (i = 0; i < pdata->num_row_gpios; i++)
> > -			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
> > +			enable_irq(gpiod_to_irq(pdata->row_gpios[i]));
> >  	}
> >  }
> >  
> > @@ -104,7 +103,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
> >  		disable_irq_nosync(pdata->clustered_irq);
> >  	else {
> >  		for (i = 0; i < pdata->num_row_gpios; i++)
> > -			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
> > +			disable_irq_nosync(gpiod_to_irq(pdata->row_gpios[i]));
> >  	}
> >  }
> >  
> > @@ -230,7 +229,7 @@ static void matrix_keypad_stop(struct input_dev *dev)
> >  static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
> >  {
> >  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> > -	unsigned int gpio;
> > +	struct gpio_desc *gpio;
> >  	int i;
> >  
> >  	if (pdata->clustered_irq > 0) {
> > @@ -242,7 +241,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
> >  			if (!test_bit(i, keypad->disabled_gpios)) {
> >  				gpio = pdata->row_gpios[i];
> >  
> > -				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
> > +				if (enable_irq_wake(gpiod_to_irq(gpio)) == 0)
> >  					__set_bit(i, keypad->disabled_gpios);
> >  			}
> >  		}
> > @@ -252,7 +251,7 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
> >  static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
> >  {
> >  	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
> > -	unsigned int gpio;
> > +	struct gpio_desc *gpio;
> >  	int i;
> >  
> >  	if (pdata->clustered_irq > 0) {
> > @@ -264,7 +263,7 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
> >  		for (i = 0; i < pdata->num_row_gpios; i++) {
> >  			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
> >  				gpio = pdata->row_gpios[i];
> > -				disable_irq_wake(gpio_to_irq(gpio));
> > +				disable_irq_wake(gpiod_to_irq(gpio));
> >  			}
> >  		}
> >  	}
> > @@ -308,27 +307,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
> >  
> >  	/* initialized strobe lines as outputs, activated */
> >  	for (i = 0; i < pdata->num_col_gpios; i++) {
> > -		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
> > -		if (err) {
> > -			dev_err(&pdev->dev,
> > -				"failed to request GPIO%d for COL%d\n",
> > -				pdata->col_gpios[i], i);
> > -			goto err_free_cols;
> > -		}
> > -
> > -		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
> > +		gpiod_direction_output(pdata->col_gpios[i], !pdata->active_low);
> >  	}
> >  
> >  	for (i = 0; i < pdata->num_row_gpios; i++) {
> > -		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
> > -		if (err) {
> > -			dev_err(&pdev->dev,
> > -				"failed to request GPIO%d for ROW%d\n",
> > -				pdata->row_gpios[i], i);
> > -			goto err_free_rows;
> > -		}
> > -
> > -		gpio_direction_input(pdata->row_gpios[i]);
> > +		gpiod_direction_input(pdata->row_gpios[i]);
> >  	}
> >  
> >  	if (pdata->clustered_irq > 0) {
> > @@ -344,7 +327,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
> >  	} else {
> >  		for (i = 0; i < pdata->num_row_gpios; i++) {
> >  			err = request_any_context_irq(
> > -					gpio_to_irq(pdata->row_gpios[i]),
> > +					gpiod_to_irq(pdata->row_gpios[i]),
> >  					matrix_keypad_interrupt,
> >  					IRQF_TRIGGER_RISING |
> >  					IRQF_TRIGGER_FALLING,
> > @@ -352,7 +335,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
> >  			if (err < 0) {
> >  				dev_err(&pdev->dev,
> >  					"Unable to acquire interrupt for GPIO line %i\n",
> > -					pdata->row_gpios[i]);
> > +					i);
> >  				goto err_free_irqs;
> >  			}
> >  		}
> > @@ -364,15 +347,12 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
> >  
> >  err_free_irqs:
> >  	while (--i >= 0)
> > -		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
> > +		free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
> >  	i = pdata->num_row_gpios;
> >  err_free_rows:
> >  	while (--i >= 0)
> > -		gpio_free(pdata->row_gpios[i]);
> > +		gpiod_put(pdata->row_gpios[i]);
> >  	i = pdata->num_col_gpios;
> > -err_free_cols:
> > -	while (--i >= 0)
> > -		gpio_free(pdata->col_gpios[i]);
> >  
> >  	return err;
> >  }
> > @@ -386,14 +366,14 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
> >  		free_irq(pdata->clustered_irq, keypad);
> >  	} else {
> >  		for (i = 0; i < pdata->num_row_gpios; i++)
> > -			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
> > +			free_irq(gpiod_to_irq(pdata->row_gpios[i]), keypad);
> >  	}
> >  
> >  	for (i = 0; i < pdata->num_row_gpios; i++)
> > -		gpio_free(pdata->row_gpios[i]);
> > +		gpiod_put(pdata->row_gpios[i]);
> >  
> >  	for (i = 0; i < pdata->num_col_gpios; i++)
> > -		gpio_free(pdata->col_gpios[i]);
> > +		gpiod_put(pdata->col_gpios[i]);
> >  }
> >  
> >  #ifdef CONFIG_OF
> > @@ -402,7 +382,8 @@ matrix_keypad_parse_dt(struct device *dev)
> >  {
> >  	struct matrix_keypad_platform_data *pdata;
> >  	struct device_node *np = dev->of_node;
> > -	unsigned int *gpios;
> > +	struct gpio_desc **gpios;
> > +	struct gpio_desc *desc;
> >  	int ret, i, nrow, ncol;
> >  
> >  	if (!np) {
> > @@ -416,8 +397,8 @@ matrix_keypad_parse_dt(struct device *dev)
> >  		return ERR_PTR(-ENOMEM);
> >  	}
> >  
> > -	pdata->num_row_gpios = nrow = of_gpio_named_count(np, "row-gpios");
> > -	pdata->num_col_gpios = ncol = of_gpio_named_count(np, "col-gpios");
> > +	pdata->num_row_gpios = nrow = gpiod_count(dev, "row");
> > +	pdata->num_col_gpios = ncol = gpiod_count(dev, "col");
> >  	if (nrow <= 0 || ncol <= 0) {
> >  		dev_err(dev, "number of keypad rows/columns not specified\n");
> >  		return ERR_PTR(-EINVAL);
> > @@ -429,9 +410,6 @@ matrix_keypad_parse_dt(struct device *dev)
> >  	pdata->wakeup = of_property_read_bool(np, "wakeup-source") ||
> >  			of_property_read_bool(np, "linux,wakeup"); /* legacy */
> >  
> > -	if (of_get_property(np, "gpio-activelow", NULL))
> > -		pdata->active_low = true;
> > -
> 
> This removes backward compatibility, please don't do that.

I do not think there is a reasonable way of keeping the compatibility
while using gpiod API (sans abandoning polarity handling and using
*_raw() versions of API).

I would adjust the DTSes in the kernel and move on, especially given
that the DTSes in the kernel are inconsistent - they specify
gpio-activelow attribute while specifying "action high" in gpio
properties).

Thanks.

-- 
Dmitry
