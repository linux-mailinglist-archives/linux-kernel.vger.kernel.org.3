Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA044964C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382021AbiAUSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381885AbiAUSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:06:36 -0500
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04911C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 10:06:35 -0800 (PST)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 5A26810008D; Fri, 21 Jan 2022 18:06:31 +0000 (UTC)
Date:   Fri, 21 Jan 2022 18:06:31 +0000
From:   Sean Young <sean@mess.org>
To:     Luiz Sampaio <sampaio.ime@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 11/31] media: rc: changing LED_* from enum led_brightness
 to actual value
Message-ID: <Yer2J+96wy7wSDSs@gofer.mess.org>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
 <20220121165436.30956-12-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121165436.30956-12-sampaio.ime@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 01:54:16PM -0300, Luiz Sampaio wrote:
> The enum led_brightness, which contains the declaration of LED_OFF,
> LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
> max_brightness.
> ---
>  drivers/media/rc/rc-main.c     | 4 ++--
>  drivers/media/rc/redrat3.c     | 4 ++--
>  drivers/media/rc/ttusbir.c     | 4 ++--
>  drivers/media/rc/winbond-cir.c | 6 +++---
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> index b90438a71c80..76580f1920e2 100644
> --- a/drivers/media/rc/rc-main.c
> +++ b/drivers/media/rc/rc-main.c
> @@ -641,7 +641,7 @@ static void ir_do_keyup(struct rc_dev *dev, bool sync)
>  	dev_dbg(&dev->dev, "keyup key 0x%04x\n", dev->last_keycode);
>  	del_timer(&dev->timer_repeat);
>  	input_report_key(dev->input_dev, dev->last_keycode, 0);
> -	led_trigger_event(led_feedback, LED_OFF);
> +	led_trigger_event(led_feedback, 0);
>  	if (sync)
>  		input_sync(dev->input_dev);
>  	dev->keypressed = false;
> @@ -812,7 +812,7 @@ static void ir_do_keydown(struct rc_dev *dev, enum rc_proto protocol,
>  			dev->device_name, keycode, protocol, scancode);
>  		input_report_key(dev->input_dev, keycode, 1);
>  
> -		led_trigger_event(led_feedback, LED_FULL);
> +		led_trigger_event(led_feedback, 255);
>  	}
>  
>  	/*
> diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
> index cb22316b3f00..7c255f7d790c 100644
> --- a/drivers/media/rc/redrat3.c
> +++ b/drivers/media/rc/redrat3.c
> @@ -855,7 +855,7 @@ static void redrat3_brightness_set(struct led_classdev *led_dev, enum
>  	struct redrat3_dev *rr3 = container_of(led_dev, struct redrat3_dev,
>  									led);
>  
> -	if (brightness != LED_OFF && atomic_cmpxchg(&rr3->flash, 0, 1) == 0) {
> +	if (brightness != 0 && atomic_cmpxchg(&rr3->flash, 0, 1) == 0) {
>  		int ret = usb_submit_urb(rr3->flash_urb, GFP_ATOMIC);
>  		if (ret != 0) {
>  			dev_dbg(rr3->dev, "%s: unexpected ret of %d\n",
> @@ -919,7 +919,7 @@ static void redrat3_led_complete(struct urb *urb)
>  		break;
>  	}
>  
> -	rr3->led.brightness = LED_OFF;
> +	rr3->led.brightness = 0;
>  	atomic_dec(&rr3->flash);
>  }
>  
> diff --git a/drivers/media/rc/ttusbir.c b/drivers/media/rc/ttusbir.c
> index 629787d53ee1..a295112644c3 100644
> --- a/drivers/media/rc/ttusbir.c
> +++ b/drivers/media/rc/ttusbir.c
> @@ -44,7 +44,7 @@ static enum led_brightness ttusbir_brightness_get(struct led_classdev *led_dev)
>  {
>  	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
>  
> -	return tt->led_on ? LED_FULL : LED_OFF;
> +	return tt->led_on ? 255 : 0;
>  }
>  
>  static void ttusbir_set_led(struct ttusbir *tt)
> @@ -70,7 +70,7 @@ static void ttusbir_brightness_set(struct led_classdev *led_dev, enum
>  {
>  	struct ttusbir *tt = container_of(led_dev, struct ttusbir, led);
>  
> -	tt->led_on = brightness != LED_OFF;
> +	tt->led_on = brightness != 0;
>  
>  	ttusbir_set_led(tt);
>  }
> diff --git a/drivers/media/rc/winbond-cir.c b/drivers/media/rc/winbond-cir.c
> index 94efb035d21b..d14e495a8641 100644
> --- a/drivers/media/rc/winbond-cir.c
> +++ b/drivers/media/rc/winbond-cir.c
> @@ -265,7 +265,7 @@ wbcir_led_brightness_get(struct led_classdev *led_cdev)
>  	if (inb(data->ebase + WBCIR_REG_ECEIR_CTS) & WBCIR_LED_ENABLE)
>  		return LED_FULL;

You missed this one.

Thanks
Sean

>  	else
> -		return LED_OFF;
> +		return 0;
>  }
>  
>  static void
> @@ -277,7 +277,7 @@ wbcir_led_brightness_set(struct led_classdev *led_cdev,
>  					       led);
>  
>  	wbcir_set_bits(data->ebase + WBCIR_REG_ECEIR_CTS,
> -		       brightness == LED_OFF ? 0x00 : WBCIR_LED_ENABLE,
> +		       brightness == 0 ? 0x00 : WBCIR_LED_ENABLE,
>  		       WBCIR_LED_ENABLE);
>  }
>  
> @@ -1167,7 +1167,7 @@ wbcir_remove(struct pnp_dev *device)
>  	led_classdev_unregister(&data->led);
>  
>  	/* This is ok since &data->led isn't actually used */
> -	wbcir_led_brightness_set(&data->led, LED_OFF);
> +	wbcir_led_brightness_set(&data->led, 0);
>  
>  	release_region(data->wbase, WAKEUP_IOMEM_LEN);
>  	release_region(data->ebase, EHFUNC_IOMEM_LEN);
> -- 
> 2.34.1
