Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C7E535E48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350431AbiE0K3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350952AbiE0K2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:28:43 -0400
Received: from smtp.smtpout.orange.fr (smtp03.smtpout.orange.fr [80.12.242.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2BB128176
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:28:28 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.191.102])
        by smtp.orange.fr with ESMTPA
        id uXCinkUD34LtquXCinnN3M; Fri, 27 May 2022 12:28:27 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 27 May 2022 12:28:27 +0200
X-ME-IP: 90.11.191.102
Message-ID: <159368be-82fa-f42c-9658-88cd0e1f1882@wanadoo.fr>
Date:   Fri, 27 May 2022 12:28:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] drivers: input: Directly use ida_alloc()/free()
Content-Language: en-CA
To:     keliu <liuke94@huawei.com>, dmitry.torokhov@gmail.com,
        marcoshalano@gmail.com, michael@michaelcullen.name,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220527103740.3442548-1-liuke94@huawei.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220527103740.3442548-1-liuke94@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 27/05/2022 à 12:37, keliu a écrit :
> Use ida_alloc()/ida_free() instead of deprecated
> ida_simple_get()/ida_simple_remove() .
> 
> Signed-off-by: keliu <liuke94@huawei.com>
> ---
>   drivers/input/input.c         | 8 ++++----
>   drivers/input/joystick/xpad.c | 6 +++---
>   2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/input.c b/drivers/input/input.c
> index 1365c9dfb5f2..1e4a275795f9 100644
> --- a/drivers/input/input.c
> +++ b/drivers/input/input.c
> @@ -2618,15 +2618,15 @@ int input_get_new_minor(int legacy_base, unsigned int legacy_num,
>   	 * locking is needed here.
>   	 */
>   	if (legacy_base >= 0) {
> -		int minor = ida_simple_get(&input_ida,
> +		int minor = ida_alloc_range(&input_ida,
>   					   legacy_base,
> -					   legacy_base + legacy_num,
> +					   legacy_base + legacy_num - 1,

You got my point, things are going in the right direction.
This one is correct...

>   					   GFP_KERNEL);
>   		if (minor >= 0 || !allow_dynamic)
>   			return minor;
>   	}
>   
> -	return ida_simple_get(&input_ida,
> +	return ida_alloc_range(&input_ida,
>   			      INPUT_FIRST_DYNAMIC_DEV, INPUT_MAX_CHAR_DEVICES,

... but you missed the -1 here.

Also maybe an explanation of why this -1 are introduced would help 
reviewers. (if needed, I think I already wrote some, just ask)

CJ

>   			      GFP_KERNEL);
>   }
> @@ -2641,7 +2641,7 @@ EXPORT_SYMBOL(input_get_new_minor);
>    */
>   void input_free_minor(unsigned int minor)
>   {
> -	ida_simple_remove(&input_ida, minor);
> +	ida_free(&input_ida, minor);
>   }
>   EXPORT_SYMBOL(input_free_minor);
>   
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index 18190b529bca..fafc0d5703dc 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -1456,7 +1456,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>   	if (!led)
>   		return -ENOMEM;
>   
> -	xpad->pad_nr = ida_simple_get(&xpad_pad_seq, 0, 0, GFP_KERNEL);
> +	xpad->pad_nr = ida_alloc(&xpad_pad_seq, GFP_KERNEL);
>   	if (xpad->pad_nr < 0) {
>   		error = xpad->pad_nr;
>   		goto err_free_mem;
> @@ -1479,7 +1479,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
>   	return 0;
>   
>   err_free_id:
> -	ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
> +	ida_free(&xpad_pad_seq, xpad->pad_nr);
>   err_free_mem:
>   	kfree(led);
>   	xpad->led = NULL;
> @@ -1492,7 +1492,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
>   
>   	if (xpad_led) {
>   		led_classdev_unregister(&xpad_led->led_cdev);
> -		ida_simple_remove(&xpad_pad_seq, xpad->pad_nr);
> +		ida_free(&xpad_pad_seq, xpad->pad_nr);
>   		kfree(xpad_led);
>   	}
>   }

