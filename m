Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBA54D4D73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245332AbiCJPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344831AbiCJPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:14:39 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A064361A16;
        Thu, 10 Mar 2022 07:13:37 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 99B2C1F45A03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646925215;
        bh=4u16TKyOx9l3g8MNeKHr33B+GKfmXMiGf2Tr2LY7To4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=F6M5gDcCnmuWxpdlkI9HH7ygVt5N1YadlitkgJIHE096Vlb8hMFOf1ur0rzpr0s8N
         z499ZXHsymqO/RKPsY+GhAHY0duDcfK/TsN6DBQdqdBdTvta4Bg4tuBKDqS6HhyxNg
         yA1mv8gkdNR9Aj5p34pDlgQC1l5agq5wfTkmXV14KUW6pdghScSqxhPQ4hOXjs5ggc
         GjEiU6KdWB6HHKmmLKwmHSdUl4i2DFsL4T6Tb6d0uuIZu7MyDxJaw9DYuIBHecTETx
         Pt8Mqd1byeDsApq+WJ3UBSWiZyi496D2fkDVCr4tZBrwSOnIIU70MZPCtLwSnTyC5L
         IbR/5dLXDBF6w==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, andy.shevchenko@gmail.com
Subject: Re: [PATCH] gpio: Restrict usage of gc irq members before
 initialization
Organization: Collabora
References: <20220310132108.225387-1-shreeya.patel@collabora.com>
Date:   Thu, 10 Mar 2022 10:13:31 -0500
In-Reply-To: <20220310132108.225387-1-shreeya.patel@collabora.com> (Shreeya
        Patel's message of "Thu, 10 Mar 2022 18:51:07 +0530")
Message-ID: <87bkydc02s.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shreeya Patel <shreeya.patel@collabora.com> writes:

> gc irq members are exposed before they could be completely
> initialized and this leads to race conditions.
>
> One such issue was observed for the gc->irq.domain variable which
> was accessed through the I2C interface in gpiochip_to_irq() before
> it could be initialized by gpiochip_add_irqchip(). This resulted in
> Kernel NULL pointer dereference.
>
> To avoid such scenarios, restrict usage of gc irq members before
> they are completely initialized.
>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
>
> Following is the NULL pointer dereference Oops for reference :-
>
> kernel: Call Trace:
> kernel:  gpiod_to_irq+0x53/0x70
> kernel:  acpi_dev_gpio_irq_get_by+0x113/0x1f0
> kernel:  i2c_acpi_get_irq+0xc0/0xd0
> kernel:  i2c_device_probe+0x28a/0x2a0
> kernel:  really_probe+0xf2/0x460
> kernel:  driver_probe_device+0xe8/0x160
> kernel:  ? driver_allows_async_probing+0x50/0x50
> kernel:  bus_for_each_drv+0x8f/0xd0
> kernel:  __device_attach_async_helper+0x9f/0xf0
> kernel:  async_run_entry_fn+0x2e/0x110
> kernel:  process_one_work+0x214/0x3e0
> kernel:  worker_thread+0x4d/0x3d0
> kernel:  ? process_one_work+0x3e0/0x3e0
> kernel:  kthread+0x133/0x150
> kernel:  ? kthread_associate_blkcg+0xc0/0xc0
> kernel:  ret_from_fork+0x22/0x30
> kernel: CR2: 0000000000000028
> kernel: ---[ end trace d0f5a7a0e0eb268f ]---
> kernel: RIP: 0010:gpiochip_to_irq+0x47/0xc0
>
>  drivers/gpio/gpiolib.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index defb7c464b87..2c6f382ff159 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -90,6 +90,7 @@ static int gpiochip_irqchip_init_valid_mask(struct gpio_chip *gc);
>  static void gpiochip_irqchip_free_valid_mask(struct gpio_chip *gc);
>  
>  static bool gpiolib_initialized;
> +bool gc_irq_initialized;

What if you have more than one gc?  this needs to be an attribute of the
gc, not global.

>  
>  static inline void desc_set_label(struct gpio_desc *d, const char *label)
>  {
> @@ -1593,6 +1594,8 @@ static int gpiochip_add_irqchip(struct gpio_chip *gc,
>  
>  	acpi_gpiochip_request_interrupts(gc);
>  
> +	gc_irq_initialized = true;
> +

this assignment can be reordered by the compiler, in which
case (gc->domain == NULL && gc_irq_initialized == true).

>  	return 0;
>  }
>  
> @@ -3138,7 +3141,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
>  
>  	gc = desc->gdev->chip;
>  	offset = gpio_chip_hwgpio(desc);
> -	if (gc->to_irq) {
> +	if (gc->to_irq && gc_irq_initialized) {
>  		int retirq = gc->to_irq(gc, offset);
>  
>  		/* Zero means NO_IRQ */

-- 
Gabriel Krisman Bertazi
