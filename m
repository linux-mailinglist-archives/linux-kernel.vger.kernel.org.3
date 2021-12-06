Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A85469A2C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345807AbhLFPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345878AbhLFPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:05:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC2DC0698CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:01:39 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id e3so44275487edu.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 07:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rx5WAdQgjQYUCUZMzb32WIOm3fil4JEYgpwFBPU8zKs=;
        b=IPbhCarYqsh/4Wq5Lr1kUUW/BtDobSHyDFJ2AK+R9dhWTehtS93HZQY7q6cfTwpAII
         Oj52t13kQwbTOOcSEQPZqEEGWnght/mrwIWIlczKwHH7ML0sMjVI30kwSw5PgU65sTCJ
         0DxRN5IVvsfOkxymtxkwMxPIDPbBlgDCwF3SQaUpeQJxMLcGD2C7TFX4u0fu+Pr6hQ6y
         zLxuIv/Z3oPp/wsVv9dS6AIU1yQ1EFoBX9h/Z1aytVPR3C3DDJi6uODkibjIb7s8kmXI
         vrfnKQ/zzUb51fvEvKxur1uf7Bf/CRjFNz3IFK0qzVJXqMWXtVpgLS9ynsXDtOweIMJN
         9CfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rx5WAdQgjQYUCUZMzb32WIOm3fil4JEYgpwFBPU8zKs=;
        b=lRbDK8FlwrCDPVswlAyd8uczzO+16L7Egqa59GZxDflghrmYlaB6E+1Fj71L7ztZVg
         PsiIrQFyN2NYHkxZ637VoP0ii5kb78tSxrFYeBCJjOjWghl88syC263zr40KjwtGCmMX
         Al5RQIaIMubQnB+oAaxBf1xM7KWic1zptYdZK26Rzh/LH4FNWeuypztzv/kN1EUVLA15
         Z+9d/QSnSuC21T/1eXXj8IhTOHYMd9PNGoeEZsAVQY2DaENDkFViTR0YQG6B1TofIEvZ
         3rqCV5FxWUISeas6IMCr6ub8KYoYYfsw1YBkI3kl1O12aSTI196JiD+CJ8+qQsfU48df
         eCAQ==
X-Gm-Message-State: AOAM532Cr/KvQmPu5RB/yL6avuOv4hCgolC5OZw/mrkaH0I679Qg+GYd
        bJ1ZZTxoqTy6gJSLGFplgOU6Iojxmtzae+ogXvRso2Hmp7715GTB
X-Google-Smtp-Source: ABdhPJzxD0ZDyRJnuncz7yUaU5TRZM2LaW7rbNql/zgBMCZCfT8faSEd9txG9QvT2c92je2h2IJypVeTECPXvFOgsts=
X-Received: by 2002:a17:907:75f0:: with SMTP id jz16mr47037953ejc.77.1638802896192;
 Mon, 06 Dec 2021 07:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20211202134034.14048-1-brgl@bgdev.pl> <20211202134034.14048-2-brgl@bgdev.pl>
In-Reply-To: <20211202134034.14048-2-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 6 Dec 2021 16:01:25 +0100
Message-ID: <CAMRc=MfBvFzww_wZ=afjUY4aSnyKyL2ZXLmfWbu_u3tnZ8J0Ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] gpiolib: check the 'ngpios' property in core
 gpiolib code
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Johan Hovold <johan@kernel.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 2:40 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Several drivers read the 'ngpios' device property on their own, but
> since it's defined as a standard GPIO property in the device tree bindings
> anyway, it's a good candidate for generalization. If the driver didn't
> set its gc->ngpio, try to read the 'ngpios' property from the GPIO
> device's firmware node before bailing out.
>
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v1 -> v2:
> - use device_property_read_u32() instead of fwnode_property_read_u32()
> - reverse the error check logic
>
> v2 -> v3:
> - don't shadow errors other than -ENODATA in device_property_read_u32()
>
> v3 -> v4:
> - also make sure we return -EINVAL when the device 'ngpios' property is
>   set to 0 (thanks Andy!)
>
>  drivers/gpio/gpiolib.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ede8b8a7aa18..bd9b8cb53476 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -599,6 +599,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         int base = gc->base;
>         unsigned int i;
>         int ret = 0;
> +       u32 ngpios;
>
>         /*
>          * First: allocate and populate the internal stat container, and
> @@ -646,6 +647,26 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>                 goto err_free_dev_name;
>         }
>
> +       /*
> +        * Try the device properties if the driver didn't supply the number
> +        * of GPIO lines.
> +        */
> +       if (gc->ngpio == 0) {
> +               ret = device_property_read_u32(&gdev->dev, "ngpios", &ngpios);
> +               if (ret == -ENODATA)
> +                       /*
> +                        * -ENODATA means that there is no property found and
> +                        * we want to issue the error message to the user.
> +                        * Besides that, we want to return different error code
> +                        * to state that supplied value is not valid.
> +                        * */
> +                       ngpios = 0;
> +               else if (ret)
> +                       goto err_free_descs;
> +
> +               gc->ngpio = ngpios;
> +       }
> +
>         if (gc->ngpio == 0) {
>                 chip_err(gc, "tried to insert a GPIO chip with zero lines\n");
>                 ret = -EINVAL;
> --
> 2.25.1
>

Queued for next.

Bart
