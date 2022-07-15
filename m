Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE9E576730
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiGOTLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiGOTLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:11:16 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FAE402CC;
        Fri, 15 Jul 2022 12:11:15 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1FA18993;
        Fri, 15 Jul 2022 21:11:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1657912273;
        bh=c3uyxB2MmrAa8po96PTo2NR+WAA78v7/sF+HW/0PaCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LK4oZTkkgx+vyCyWQoTl9FqQY/jyo/N1Mg4k0ctYb1jfp9Vdj1I4RKCXk0E72EHqi
         QafJCG3W2IpyjasxN9K5CImLAdypT+px8YRn+3f2r+q0Gsczzc5fMYk1zVfKHkwMda
         pDT2B4I5DepIrIaoupMHVeKN0MriUUydRzDqSC+o=
Date:   Fri, 15 Jul 2022 22:10:41 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, ribalda@chromium.org
Subject: Re: [PATCH RESEND v2] media: uvcvideo: Fix memory leak in
 uvc_gpio_parse
Message-ID: <YtG7sRuSIeZNhzNK@pendragon.ideasonboard.com>
References: <20220108170439.49984-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220108170439.49984-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi José,

Thank you for the patch.

On Sat, Jan 08, 2022 at 06:04:39PM +0100, José Expósito wrote:

I can't believe I've managed to ignore this patch for so long :-( Sorry.

> Previously the unit buffer was allocated before checking the IRQ for
> privacy GPIO.
> In case of error, the unit buffer was leaked.
> 
> Allocate the unit buffer after the IRQ to avoid it.
> 
> Addresses-Coverity-ID: 1474639 ("Resource leak")
> Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
> v2: Add Fixes and Reviewed-by tags
> ---
>  drivers/media/usb/uvc/uvc_driver.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index 7c007426e082..9e83e2002710 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -1533,10 +1533,6 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>  	if (IS_ERR_OR_NULL(gpio_privacy))
>  		return PTR_ERR_OR_ZERO(gpio_privacy);
>  
> -	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> -	if (!unit)
> -		return -ENOMEM;
> -
>  	irq = gpiod_to_irq(gpio_privacy);
>  	if (irq < 0) {
>  		if (irq != EPROBE_DEFER)
> @@ -1545,6 +1541,10 @@ static int uvc_gpio_parse(struct uvc_device *dev)
>  		return irq;
>  	}
>  
> +	unit = uvc_alloc_entity(UVC_EXT_GPIO_UNIT, UVC_EXT_GPIO_UNIT_ID, 0, 1);
> +	if (!unit)
> +		return -ENOMEM;
> +
>  	unit->gpio.gpio_privacy = gpio_privacy;
>  	unit->gpio.irq = irq;
>  	unit->gpio.bControlSize = 1;

-- 
Regards,

Laurent Pinchart
