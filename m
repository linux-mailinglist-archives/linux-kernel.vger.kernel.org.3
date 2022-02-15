Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843BC4B634D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 07:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbiBOGOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 01:14:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbiBOGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 01:14:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE262F7451;
        Mon, 14 Feb 2022 22:14:28 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h14-20020a17090a130e00b001b88991a305so1680668pja.3;
        Mon, 14 Feb 2022 22:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGkUNGwV+ViRiVqpjq4ZAj2dh3yppjtbQnl5/yidUs0=;
        b=Ya8vNF9pBA3DXZif23ztEwjerGsnlhe6mPp8HhDtgJjxUJN/kyHEf+g7lOYOPNpVCb
         /tttUxbzQ3s7g3HPLJ+PTGQFPjE7D1bMPQpU7yGX5UTwjKJ7g6g2gCQ6g1tKT91D0XBD
         J/qWzP0X76R7ViUz8ihfgO1QXOPoR52VB2WKGG79zpcoFSjIMlAO9/aSYy8Muabus7gp
         KlQGvu+BT98IGLHwhVwAXvrl7ctp3Kpu4q0ZlN7ah57lgrZXjEj4KdoXcQzGG7ojbkja
         GoRR/0hnJ2wocBJa30g3nZlT63BPUiLwKmonwunbo+ha6qFeDZsjStYSY1WbuQ1/UCoW
         BKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGkUNGwV+ViRiVqpjq4ZAj2dh3yppjtbQnl5/yidUs0=;
        b=6oJNZfMC6mQvrUsLtDqBZ9y9/AVRZbumBx0b8wkbM23PozTPmZfA8mGszzQi1kHqtJ
         4SmpZJOGOWYNO/kry9NHV7uqBTyqRgI6XR5KB3A3q7OP9Pi8QcdHzkQX0LfuT6AHbg5Q
         7y71iCzdAbRVIOQzslh2ulyY9LZeO5YP1C3HJPJqQLMfeDYKprYbkcMfmQkwbJoE7uhT
         NZzzZLt1pwdAplSKtP5TuH8J+LX/4wmJKROZsmD9cmkrxfx+CT3eAqOfkjhzbVIqqKAV
         UqcISHbn1e+VoRGgdNwa0wuWdBljNgYk1USoJPTAM0zSQFpyrH1GUkUP+r+vCFetBEx6
         2Big==
X-Gm-Message-State: AOAM532/LMZpj0UslTOijFKUsmg9K7PkPhPHuuIAlgAx6sL00m0vknw9
        DTA3wCOX0xFMe1K8fFtR+Cs=
X-Google-Smtp-Source: ABdhPJxjivd/uYGEmvJeE+unIr+uEC1tEVKFoNTI/Je7HA2tRorbU9xZknMsw+kXvmK65NVyPpa4Cg==
X-Received: by 2002:a17:902:ceca:: with SMTP id d10mr2729007plg.48.1644905667807;
        Mon, 14 Feb 2022 22:14:27 -0800 (PST)
Received: from google.com ([2620:15c:202:201:fffe:8570:13af:4c81])
        by smtp.gmail.com with ESMTPSA id l8sm1380012pgt.77.2022.02.14.22.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 22:14:26 -0800 (PST)
Date:   Mon, 14 Feb 2022 22:14:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Danilo Krummrich <danilokrummrich@dk-develop.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/3] input: ps2-gpio: use ktime for IRQ timekeeping
Message-ID: <YgtEwMQMrp3uQinK@google.com>
References: <20220211212258.80345-1-danilokrummrich@dk-develop.de>
 <20220211212258.80345-2-danilokrummrich@dk-develop.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211212258.80345-2-danilokrummrich@dk-develop.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Danilo,

On Fri, Feb 11, 2022 at 10:22:56PM +0100, Danilo Krummrich wrote:
> Using jiffies for the IRQ timekeeping is not sufficient for two reasons:
> 
> (1) Usually jiffies have a resolution of 1ms to 10ms. The IRQ intervals
>     based on the clock frequency of PS2 protocol specification (10kHz -
>     16.7kHz) are between ~60us and 100us only. Therefore only those IRQ
>     intervals can be detected which are either at the end of a transfer
>     or are overly delayed. While this is sufficient in most cases, since
>     we have quite a lot of ways to detect faulty transfers, it can
>     produce false positives in rare cases: When the jiffies value
>     changes right between two interrupt that are in time, we wrongly
>     assume that we missed one or more clock cycles.
> 
> (2) Some gpio controllers (e.g. the one in the bcm283x chips) may generate
>     spurious IRQs when processing interrupts in the frequency given by PS2
>     devices.
> 
> Both issues can be fixed by using ktime resolution for IRQ timekeeping.
> 
> However, it is still possible to miss clock cycles without detecting
> them. When the PS2 device generates the falling edge of the clock signal
> we have between ~30us and 50us to sample the data line, because after
> this time we reach the next rising edge at which the device changes the
> data signal already. But, the only thing we can detect is whether the
> IRQ interval is within the given period. Therefore it is possible to
> have an IRQ latency greater than ~30us to 50us, sample the wrong bit on
> the data line and still be on time with the next IRQ. However, this can
> only happen when within a given transfer the IRQ latency increases
> slowly.
> 
> ___            ______            ______            ______            ___
>    \          /      \          /      \          /      \          /
>     \        /        \        /        \        /        \        /
>      \______/          \______/          \______/          \______/
> 
>     |-----------------|                 |--------|
>          60us/100us                      30us/50us
> 
> Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> ---
>  drivers/input/serio/ps2-gpio.c | 81 ++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/serio/ps2-gpio.c b/drivers/input/serio/ps2-gpio.c
> index 8970b49ea09a..7fef4176bdd1 100644
> --- a/drivers/input/serio/ps2-gpio.c
> +++ b/drivers/input/serio/ps2-gpio.c
> @@ -19,6 +19,7 @@
>  #include <linux/of.h>
>  #include <linux/jiffies.h>
>  #include <linux/delay.h>
> +#include <linux/timekeeping.h>
>  
>  #define DRIVER_NAME		"ps2-gpio"
>  
> @@ -44,6 +45,29 @@
>  
>  #define PS2_CMD_RESEND		0xfe
>  
> +/* The PS2 protocol specifies a clock frequency between 10kHz and 16.7kHz,
> + * therefore the maximal interrupt interval should be 100us and the minimum
> + * interrupt interval should be ~60us. Let's allow +/- 20us for frequency
> + * deviations and interrupt latency.
> + *
> + * The data line must be samples after ~30us to 50us after the falling edge,
> + * since the device updates the data line at the rising edge.
> + *
> + * ___            ______            ______            ______            ___
> + *    \          /      \          /      \          /      \          /
> + *     \        /        \        /        \        /        \        /
> + *      \______/          \______/          \______/          \______/
> + *
> + *     |-----------------|                 |--------|
> + *          60us/100us                      30us/50us
> + */
> +#define PS2_CLK_FREQ_MIN_HZ		10000
> +#define PS2_CLK_FREQ_MAX_HZ		16700
> +#define PS2_CLK_MIN_INTERVAL_US		((1000 * 1000) / PS2_CLK_FREQ_MAX_HZ)
> +#define PS2_CLK_MAX_INTERVAL_US		((1000 * 1000) / PS2_CLK_FREQ_MIN_HZ)
> +#define PS2_IRQ_MIN_INTERVAL_US		(PS2_CLK_MIN_INTERVAL_US - 20)
> +#define PS2_IRQ_MAX_INTERVAL_US		(PS2_CLK_MAX_INTERVAL_US + 20)
> +
>  struct ps2_gpio_data {
>  	struct device *dev;
>  	struct serio *serio;
> @@ -59,6 +83,8 @@ struct ps2_gpio_data {
>  	struct completion tx_done;
>  	struct mutex tx_mutex;
>  	struct delayed_work tx_work;
> +	ktime_t tx_start;
> +	ktime_t tx_end;
>  };
>  
>  static int ps2_gpio_open(struct serio *serio)
> @@ -118,6 +144,7 @@ static void ps2_gpio_tx_work_fn(struct work_struct *work)
>  						    struct ps2_gpio_data,
>  						    tx_work);
>  
> +	drvdata->tx_start = ktime_get();
>  	enable_irq(drvdata->irq);
>  	gpiod_direction_output(drvdata->gpio_data, 0);
>  	gpiod_direction_input(drvdata->gpio_clk);
> @@ -128,20 +155,33 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
>  	unsigned char byte, cnt;
>  	int data;
>  	int rxflags = 0;
> -	static unsigned long old_jiffies;
> +	static ktime_t t_last, t_now;
> +	s64 us_delta;
>  
>  	byte = drvdata->rx_byte;
>  	cnt = drvdata->rx_cnt;
>  
> -	if (old_jiffies == 0)
> -		old_jiffies = jiffies;
> +	t_now = ktime_get();
> +	if (t_last == 0)

Instead of checking this every time, do you think we could seed the
value in ps2_gpio_open() (and also make it per-port, not static)?

> +		t_last = t_now;
>  
> -	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
> +	/* We need to consider spurious interrupts happening right after a TX xfer
> +	 * finished.
> +	 */
> +	if (unlikely(ktime_us_delta(t_now, drvdata->tx_end) <
> +		     PS2_IRQ_MIN_INTERVAL_US))
> +		goto end;
> +
> +	us_delta = ktime_us_delta(t_now, t_last);
> +	if (us_delta > PS2_IRQ_MAX_INTERVAL_US && cnt) {
>  		dev_err(drvdata->dev,
>  			"RX: timeout, probably we missed an interrupt\n");
>  		goto err;
> +	} else if (us_delta < PS2_IRQ_MIN_INTERVAL_US && t_now != t_last) {
> +		/* Ignore spurious IRQs. */
> +		goto end;
>  	}
> -	old_jiffies = jiffies;
> +	t_last = t_now;
>  
>  	data = gpiod_get_value(drvdata->gpio_data);
>  	if (unlikely(data < 0)) {
> @@ -205,7 +245,7 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
>  			goto err;
>  		}
>  		cnt = byte = 0;
> -		old_jiffies = 0;
> +
>  		goto end; /* success */
>  	default:
>  		dev_err(drvdata->dev, "RX: got out of sync with the device\n");
> @@ -217,7 +257,6 @@ static irqreturn_t ps2_gpio_irq_rx(struct ps2_gpio_data *drvdata)
>  
>  err:
>  	cnt = byte = 0;
> -	old_jiffies = 0;
>  	__ps2_gpio_write(drvdata->serio, PS2_CMD_RESEND);
>  end:
>  	drvdata->rx_cnt = cnt;
> @@ -229,20 +268,34 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
>  {
>  	unsigned char byte, cnt;
>  	int data;
> -	static unsigned long old_jiffies;
> +	static ktime_t t_last, t_now;
> +	s64 us_delta;
>  
>  	cnt = drvdata->tx_cnt;
>  	byte = drvdata->tx_byte;
>  
> -	if (old_jiffies == 0)
> -		old_jiffies = jiffies;
> +	t_now = ktime_get();
> +	if (t_last == 0)
> +		t_last = t_now;
> +
> +	/* There might be pending IRQs since we disabled IRQs in __ps2_gpio_write().
> +	 * We can expect at least one clock period until the device generates the
> +	 * first falling edge after releasing the clock line.
> +	 */
> +	if (unlikely(ktime_us_delta(t_now, drvdata->tx_start) <
> +		     PS2_CLK_MIN_INTERVAL_US))
> +		goto end;
>  
> -	if ((jiffies - old_jiffies) > usecs_to_jiffies(100)) {
> +	us_delta = ktime_us_delta(t_now, t_last);
> +	if (us_delta > PS2_IRQ_MAX_INTERVAL_US && cnt > 1) {
>  		dev_err(drvdata->dev,
>  			"TX: timeout, probably we missed an interrupt\n");
>  		goto err;
> +	} else if (us_delta < PS2_IRQ_MIN_INTERVAL_US && t_now != t_last) {
> +		/* Ignore spurious IRQs. */
> +		goto end;
>  	}
> -	old_jiffies = jiffies;
> +	t_last = t_now;
>  
>  	switch (cnt) {
>  	case PS2_START_BIT:
> @@ -283,11 +336,11 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
>  			goto err;
>  		}
>  
> +		drvdata->tx_end = ktime_get();
>  		drvdata->mode = PS2_MODE_RX;
>  		complete(&drvdata->tx_done);
>  
>  		cnt = 1;
> -		old_jiffies = 0;
>  		goto end; /* success */
>  	default:
>  		/* Probably we missed the stop bit. Therefore we release data
> @@ -303,7 +356,6 @@ static irqreturn_t ps2_gpio_irq_tx(struct ps2_gpio_data *drvdata)
>  
>  err:
>  	cnt = 1;
> -	old_jiffies = 0;
>  	gpiod_direction_input(drvdata->gpio_data);
>  	__ps2_gpio_write(drvdata->serio, drvdata->tx_byte);
>  end:
> @@ -399,6 +451,7 @@ static int ps2_gpio_probe(struct platform_device *pdev)
>  	drvdata->serio = serio;
>  	drvdata->dev = dev;
>  	drvdata->mode = PS2_MODE_RX;
> +	drvdata->tx_end = 0;
>  
>  	/* Tx count always starts at 1, as the start bit is sent implicitly by
>  	 * host-to-device communication initialization.
> -- 
> 2.34.1
> 

Thanks.

-- 
Dmitry
