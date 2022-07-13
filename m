Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6095731A6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiGMI4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiGMI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:56:11 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB966D214F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:56:10 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glk-linux-kernel-4@m.gmane-mx.org>)
        id 1oBYAB-000ABm-R4
        for linux-kernel@vger.kernel.org; Wed, 13 Jul 2022 10:56:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Date:   Wed, 13 Jul 2022 10:56:00 +0200
Message-ID: <90594bd1-0ff1-0510-6d49-45d9935514b6@wanadoo.fr>
References: <20220713084247.3090353-1-bbara93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     linux-input@vger.kernel.org
Content-Language: en-US
In-Reply-To: <20220713084247.3090353-1-bbara93@gmail.com>
Cc:     linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 13/07/2022 à 10:42, Benjamin Bara a écrit :
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> This enables the usage of "can_sleep" GPIO chips as "pin up" GPIO.
> This might be the case if the GPIO chip is an expander behind i2c.

Hi,

should you care and/or should there be a v2, some nitpick below.

CJ

> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>   drivers/input/touchscreen/tsc2007.h      |  1 +
>   drivers/input/touchscreen/tsc2007_core.c | 38 ++++++++++++++++++++----
>   2 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/tsc2007.h b/drivers/input/touchscreen/tsc2007.h
> index 69b08dd6c8df..29bd1ff22c72 100644
> --- a/drivers/input/touchscreen/tsc2007.h
> +++ b/drivers/input/touchscreen/tsc2007.h
> @@ -78,6 +78,7 @@ struct tsc2007 {
>   	bool			stopped;
>   
>   	int			(*get_pendown_state)(struct device *);
> +	int			(*get_pendown_state_cansleep)(struct device *);
>   	void			(*clear_penirq)(void);
>   
>   	struct mutex		mlock;
> diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
> index 3e871d182c40..0ad4c3c41297 100644
> --- a/drivers/input/touchscreen/tsc2007_core.c
> +++ b/drivers/input/touchscreen/tsc2007_core.c
> @@ -20,6 +20,7 @@
>   #include <linux/module.h>
>   #include <linux/slab.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/gpio/driver.h>
>   #include <linux/input.h>
>   #include <linux/interrupt.h>
>   #include <linux/i2c.h>
> @@ -108,6 +109,14 @@ bool tsc2007_is_pen_down(struct tsc2007 *ts)
>   	return ts->get_pendown_state(&ts->client->dev);
>   }
>   
> +bool tsc2007_is_pen_down_cansleep(struct tsc2007 *ts)
> +{
> +	if (!ts->get_pendown_state_cansleep)
> +		return true;
> +
> +	return ts->get_pendown_state_cansleep(&ts->client->dev);
> +}
> +
>   static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>   {
>   	struct tsc2007 *ts = handle;
> @@ -115,7 +124,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>   	struct ts_event tc;
>   	u32 rt;
>   
> -	while (!ts->stopped && tsc2007_is_pen_down(ts)) {
> +	while (!ts->stopped && tsc2007_is_pen_down_cansleep(ts)) {
>   
>   		/* pen is down, continue with the measurement */
>   
> @@ -125,7 +134,7 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
>   
>   		rt = tsc2007_calculate_resistance(ts, &tc);
>   
> -		if (!rt && !ts->get_pendown_state) {
> +		if (!rt && !ts->get_pendown_state_cansleep) {
>   			/*
>   			 * If pressure reported is 0 and we don't have
>   			 * callback to check pendown state, we have to
> @@ -229,6 +238,14 @@ static int tsc2007_get_pendown_state_gpio(struct device *dev)
>   	return gpiod_get_value(ts->gpiod);
>   }
>   
> +static int tsc2007_get_pendown_state_gpio_cansleep(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct tsc2007 *ts = i2c_get_clientdata(client);
> +
> +	return gpiod_get_value_cansleep(ts->gpiod);
> +}
> +
>   static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
>   {
>   	u32 val32;
> @@ -264,10 +281,21 @@ static int tsc2007_probe_properties(struct device *dev, struct tsc2007 *ts)
>   	if (IS_ERR(ts->gpiod))
>   		return PTR_ERR(ts->gpiod);
>   
> -	if (ts->gpiod)
> -		ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
> -	else
> +	if (ts->gpiod) {
> +		/* to support detection during the hard IRQ, the GPIO chip is required to not sleep.

There should be /* alone on the first line of the comment.

> +		 * this might be the case if the GPIO is e.g. behind an i2c-based GPIO expander.
> +		 * it is fine to sleep later in the soft IRQ, as it is threaded.
> +		 */
> +		ts->get_pendown_state_cansleep = tsc2007_get_pendown_state_gpio_cansleep;
> +		if (gpiod_to_chip(ts->gpiod) && !gpiod_to_chip(ts->gpiod)->can_sleep) {
> +			ts->get_pendown_state = tsc2007_get_pendown_state_gpio;
> +		} else {
> +			dev_dbg(dev, "Pen down GPIO chip can sleep\n");
> +		}

Un-needed extra { } around each branch of this "if".

Just my 2c,
CJ

> +
> +	} else {
>   		dev_warn(dev, "Pen down GPIO is not specified in properties\n");
> +	}
>   
>   	return 0;
>   }


