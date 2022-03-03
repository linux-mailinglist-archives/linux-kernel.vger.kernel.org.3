Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4124CBA07
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiCCJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiCCJVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:21:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E6B16AA4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 01:20:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35BDD61C31
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21679C004E1;
        Thu,  3 Mar 2022 09:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646299236;
        bh=BujV7lNeAWkNsMofyT66pdBcFGsUyYMTJ5RRJQhoH8w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UvnHTsEIHOU3TOu3c/X0BUVu6evrc6wo5Q1SFWDfvADwgZlV0gRM6SBbsr6cknc/8
         TC7//pjpGSwYltyiVkVW2lmGo+2DZJ6h1DRAy7tQ8Mh4g8FpZcay1b4tYqFt3OZztj
         773ndMVdHHJqO3VquWWfz2ZZjj8/pU/nEkbgQdV0i7N8NJlNUGfeQpzCp9wJxoHxzF
         7WCeT8BisYu5g3wmGvUAD9+1gq3BjgLR7z+217t9sN2Mq/l2c8Dfnh0s7DJ7vsJpNi
         32LWikPC0jYsW1zRmAz6E2sZ2XeXOg2n/4e1tzHCOlyTn+K7rpZclJ1ZRCtdS8qcF7
         5rnhtpdGqoJVg==
Message-ID: <32165383-5ccf-e6a1-92ef-cde14c401eaa@kernel.org>
Date:   Thu, 3 Mar 2022 11:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V1] extcon/usb: Remove disable irq operation in system
 sleep.
Content-Language: en-US
To:     Bruce Chen <brucechen251@gmail.com>, bruce.chen@unisoc.com,
        myungjoo.ham@samsung.com, cw00.choi@samsung.com,
        linux-kernel@vger.kernel.org,
        Aswath Govindraju <a-govindraju@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     orsonzhai@gmail.com, gengcixi@gmail.com, baolin.wang7@gmail.com,
        zhang.lyra@gmail.com
References: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <1646292963-20570-1-git-send-email-brucechen251@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+TI folks Aswath & Vignesh.

Hi Bruce,

On 03/03/2022 09:36, Bruce Chen wrote:
> From: Bruce Chen <bruce.chen@unisoc.com>
> 
> If disable vbus/id irq, it will lead to wakeup system fail
> in unisoc platform. In unisoc platform, Irq enable and irq
> wakeup are the same interrupt line. So remove disable vbus/id
> irq operation is a way to solve the issue> 
> Signed-off-by: Bruce Chen <bruce.chen@unisoc.com>
> ---
>  drivers/extcon/extcon-usb-gpio.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-usb-gpio.c b/drivers/extcon/extcon-usb-gpio.c
> index f2b65d9..40d967a 100644
> --- a/drivers/extcon/extcon-usb-gpio.c
> +++ b/drivers/extcon/extcon-usb-gpio.c
> @@ -226,16 +226,6 @@ static int usb_extcon_suspend(struct device *dev)
>  		}
>  	}
>  
> -	/*
> -	 * We don't want to process any IRQs after this point
> -	 * as GPIOs used behind I2C subsystem might not be
> -	 * accessible until resume completes. So disable IRQ.
> -	 */

I think the reason this was added was that if USB cable is plugged/unplugged
while system was suspending it was causing some faults on TI DRA7 EVM
at usb_irq_handler()/usb_extcon_detect_cable() when it tries to read GPIO status
when I2C based GPIO controller was used but already suspended.
But looks like disabling the IRQ is not the right approach either so your patch
is right.

However I'm not sure if the above issue will still exist on DRA7 and other TI EVMS
using ID/VBUS GPIO over I2C device.

Let's wait for Aswath/Vignesh to confirm. If no issues I'm OK with this patch.

> -	if (info->id_gpiod)
> -		disable_irq(info->id_irq);
> -	if (info->vbus_gpiod)
> -		disable_irq(info->vbus_irq);
> -
>  	if (!device_may_wakeup(dev))
>  		pinctrl_pm_select_sleep_state(dev);
>  
> @@ -267,11 +257,6 @@ static int usb_extcon_resume(struct device *dev)
>  		}
>  	}
>  
> -	if (info->id_gpiod)
> -		enable_irq(info->id_irq);
> -	if (info->vbus_gpiod)
> -		enable_irq(info->vbus_irq);
> -
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &info->wq_detcable, 0);
>  

cheers,
-roger
