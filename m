Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE825731A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiGMI4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235127AbiGMI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:56:11 -0400
Received: from smtp.smtpout.orange.fr (smtp01.smtpout.orange.fr [80.12.242.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8397C04D3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 01:56:09 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id BYABo66oB3kbdBYABofk55; Wed, 13 Jul 2022 10:56:07 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 13 Jul 2022 10:56:07 +0200
X-ME-IP: 90.11.190.129
Message-ID: <9d799a6a-edbd-c7d7-1b20-b033fe38bcf7@wanadoo.fr>
Date:   Wed, 13 Jul 2022 10:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] Input: tsc2007 - enable GPIO chips that can sleep
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Richard Leitner <richard.leitner@skidata.com>
References: <20220713084247.3090353-1-bbara93@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220713084247.3090353-1-bbara93@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

