Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4142A4B8BFF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 16:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiBPPEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 10:04:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbiBPPED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 10:04:03 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C844F1E14AA
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:03:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y17so4371273edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 07:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QR6kF3NDauewMwhdBcPvkGHHiftVGqN/glWIcotOZ6s=;
        b=1yUtvArENeRe+QUGatHmNqL7cloOVUIJBDUXImckeUL3MXqiimN8zBCf2miRnsEAHm
         vpbY5BvkqLQRXPBWJmaETJf2cKCkuFkt3vsGK4k102citBnfnIpa4ftQQjSxRRymErX0
         ILpXysNIYyDt2xxj9ugshsjvecWqCV4n50Gtsyx01P1KVMr5ShB0Prd9ZeeStnIGINAX
         /t3J7SUxSAvvGfkgZBEp5nHYgZ6RRbPoHNdHxzoNL+b3gWlcU35wjUBCC75ZWfRQD89d
         97Q0a2/aFWHayJuVjdVlTAUny0l//oQRNoPeGIVm1mIrdMcf6CaPM4jmNlH80p39uGY0
         wlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QR6kF3NDauewMwhdBcPvkGHHiftVGqN/glWIcotOZ6s=;
        b=tTx3Qk65NEXA3fsmtwzbq5WFUO2gXctwlKkwc950aNueSchDb6gLiH2eCZO6Cs10s7
         /3E/QBX/Zh3/suDF2ryLEpHLTtq/GwvrGUiMRKFdIgUKhDsmt7+wGSi+oC0expJM7v1/
         0rZPYwNkspuSrXtVGqnBfmvKkjH9TNzl6QnlrklO24womBzATFyJ2Nu36uBPkl6cWAA6
         P24CrKoF4MQwxpkKwoRk4irYxZSLFlvwDBnwldaN6pUotbNRFCgjHG3LUc1Vc5cXn6VX
         BuvKB8F/TNRsWQ5XL8xzIuj3a0e9ZKR4fZ8VqVHQKgwKaVsMbGPnVDZUYbuEeYUIAfZS
         ea4A==
X-Gm-Message-State: AOAM530tjVMiZsdC+84ngzV+XV+JbMCJaagtJPKy0Ne63lGG66tyBnI7
        EHpxzrVowMBi7YzgVUs+kYilRT62MPcQYuCt4qDLUw==
X-Google-Smtp-Source: ABdhPJwlwGZyfw/wIAZ3K4LtKrPNZwF2WoPZ86kZpCEe3a9Nte7DFnu/yr1obcNEIg8dg7DTD3w43fQwDcrE2H5N9es=
X-Received: by 2002:a05:6402:5194:b0:409:97ec:3bdc with SMTP id
 q20-20020a056402519400b0040997ec3bdcmr3504968edd.314.1645023829365; Wed, 16
 Feb 2022 07:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220209113117.25760-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Feb 2022 16:03:38 +0100
Message-ID: <CAMRc=McRYRCa6A_Gynm-u-Ph9Z4L-cqT9_0e81M1_6nQ+yLDXw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] gpiolib: sysfs: Move sysfs_emit() calls outside of
 the mutex lock
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

On Wed, Feb 9, 2022 at 12:31 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In a few places we perform sysfs_emit() operations under mutex that
> do not require any locking. Move them outside of the mutex locks.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-sysfs.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 78ca7dee8b64..57d8ecab53b7 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -61,17 +61,16 @@ static ssize_t direction_show(struct device *dev,
>  {
>         struct gpiod_data *data = dev_get_drvdata(dev);
>         struct gpio_desc *desc = data->desc;
> -       ssize_t                 status;
> +       int value;
>
>         mutex_lock(&data->mutex);
>
>         gpiod_get_direction(desc);
> -       status = sysfs_emit(buf, "%s\n",
> -                           test_bit(FLAG_IS_OUT, &desc->flags) ? "out" : "in");
> +       value = !!test_bit(FLAG_IS_OUT, &desc->flags);
>
>         mutex_unlock(&data->mutex);
>
> -       return status;
> +       return sysfs_emit(buf, "%s\n", value ? "out" : "in");
>  }
>
>  static ssize_t direction_store(struct device *dev,
> @@ -108,12 +107,13 @@ static ssize_t value_show(struct device *dev,
>         mutex_lock(&data->mutex);
>
>         status = gpiod_get_value_cansleep(desc);
> -       if (status >= 0)
> -               status = sysfs_emit(buf, "%zd\n", status);
>
>         mutex_unlock(&data->mutex);
>
> -       return status;
> +       if (status < 0)
> +               return status;
> +
> +       return sysfs_emit(buf, "%zd\n", status);
>  }
>
>  static ssize_t value_store(struct device *dev,
> @@ -238,7 +238,6 @@ static ssize_t edge_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
>  {
>         struct gpiod_data *data = dev_get_drvdata(dev);
> -       ssize_t status = 0;
>         int i;
>
>         mutex_lock(&data->mutex);
> @@ -247,12 +246,13 @@ static ssize_t edge_show(struct device *dev,
>                 if (data->irq_flags == trigger_types[i].flags)
>                         break;
>         }
> -       if (i < ARRAY_SIZE(trigger_types))
> -               status = sysfs_emit(buf, "%s\n", trigger_types[i].name);
>
>         mutex_unlock(&data->mutex);
>
> -       return status;
> +       if (i >= ARRAY_SIZE(trigger_types))
> +               return 0;
> +
> +       return sysfs_emit(buf, "%s\n", trigger_types[i].name);
>  }
>
>  static ssize_t edge_store(struct device *dev,
> @@ -324,16 +324,15 @@ static ssize_t active_low_show(struct device *dev,
>  {
>         struct gpiod_data *data = dev_get_drvdata(dev);
>         struct gpio_desc *desc = data->desc;
> -       ssize_t                 status;
> +       int value;
>
>         mutex_lock(&data->mutex);
>
> -       status = sysfs_emit(buf, "%d\n",
> -                           !!test_bit(FLAG_ACTIVE_LOW, &desc->flags));
> +       value = !!test_bit(FLAG_ACTIVE_LOW, &desc->flags);
>
>         mutex_unlock(&data->mutex);
>
> -       return status;
> +       return sysfs_emit(buf, "%d\n", value);
>  }
>
>  static ssize_t active_low_store(struct device *dev,
> --
> 2.34.1
>

Applied all three, thanks Andy!

Bart
