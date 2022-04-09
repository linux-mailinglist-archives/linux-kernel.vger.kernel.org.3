Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762114FAACF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiDIUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDIUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 16:38:42 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9853B558
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 13:36:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id s18so1114238ejr.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 13:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7D4Aaibw1apIEE8gsX+ApdqU6ylj2WHbi6A+8seUpYQ=;
        b=ncWRxj97LJMXygmt/AKz+7Rs8ZQT38CCLIRace5PaU9qYsLHuiGJ5UKRtsr+HiUAiF
         4j5upESyYy+4Q/Pr2ODQQu6BIUgnS0WFtb8Oiv0ah54DUrDT3QVL2mbuqx+af7ZE0EOo
         CFVabsCZi+1Sg91a5k57mUJwX+CBbBevyFj2I0h7EBC8YwUv1b1PqsOBp9oDqVUbrYVa
         lpf003729MbI6WLkU8f6mjIIAnDkx3t/BJdlMl9DLMlzRxWbE97jFtJ0Fc46gVHlixps
         JieZevCNOeklDAVcY+SQuoqN1zTSHUI8tQKWZxibSlPTuk+Et4XeDP8HH0t/R6Xzj63c
         8IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7D4Aaibw1apIEE8gsX+ApdqU6ylj2WHbi6A+8seUpYQ=;
        b=SnHQwPB8JRAEkhXj5ObwlplUbG+0fiUA74yyk2mFAlmOqVVSClEm+fGcfNGGf0VsMV
         B5g1I8rtb9O4oQJL9UGniouKEFXtC5clKaBvf4ticRTjDVrNkn/nVo6yqkS3nl+13Vz0
         jQxqLJ7X+rhwUkzToyagOhCjQZHPgEdMWOwaoGs8M0kFHdvXzZbdKHi/cvWwWo6lOdYm
         bF6zvV5yYs1vxA4ygpJUcQC7nMnjH5X+azwmKl3IpDVCSv6BKogIIfFSQ1XzuxMEZnNC
         FoT+IQO5Hlfj/NTafqMFnMrm9imsdcEOybsGXkLM5Kwv2TRUSq0/qRD8HZJ3TXs2lXpx
         VwRg==
X-Gm-Message-State: AOAM533NxAHUvNl0fZBxlBzTrG+Ht5WOq53FprGrUek4ewBR4PFbV3RQ
        E1xI8klWBNfnGRQKlsnNIaOgnIbstMSrModDwGipfFJbXR9tSg==
X-Google-Smtp-Source: ABdhPJzUVnJ9fCRFvnF1CecBOE2+6+3iCPQEfg90TNS1Di7u0BolMX/Mt0lRsUv0edygOyQBQyuXmNnSarbD0i5a1pg=
X-Received: by 2002:a17:907:10ce:b0:6e7:116:10d0 with SMTP id
 rv14-20020a17090710ce00b006e7011610d0mr23523072ejb.101.1649536590019; Sat, 09
 Apr 2022 13:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220330145910.1946-1-andriy.shevchenko@linux.intel.com> <20220330145910.1946-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220330145910.1946-3-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 9 Apr 2022 22:36:19 +0200
Message-ID: <CAMRc=MfhHrtoKRfSAKGk14_a3L945HC3zJWhqtewruDPM6-DVg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Move error message out of a spinlock
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 4:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> An error path is a slow path, no need to block other CPUs
> when printing error messages.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index f956c533f218..062d127d9a0d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -289,7 +289,6 @@ static int gpiodev_add_to_list(struct gpio_device *gdev)
>                 }
>         }
>
> -       dev_err(&gdev->dev, "GPIO integer space overlap, cannot add chip\n");
>         return -EBUSY;
>  }
>
> @@ -724,6 +723,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
>         ret = gpiodev_add_to_list(gdev);
>         if (ret) {
>                 spin_unlock_irqrestore(&gpio_lock, flags);
> +               chip_err(gc, "GPIO integer space overlap, cannot add chip\n");
>                 goto err_free_label;
>         }
>
> --
> 2.35.1
>

Applied, thanks!

Bart
