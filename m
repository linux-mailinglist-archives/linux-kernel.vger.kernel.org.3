Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC574AD512
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 10:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355405AbiBHJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 04:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbiBHJfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:35:09 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EDC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:35:08 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id st12so25593811ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=quDJ3umqwDRDYxNgvq9o71O19aurlvjSn5/hOL8u+aM=;
        b=KZLySUyhVy6hJ9xrGZnS6glvmfJzugTF1acMvl1ToV1KzBtJA4t8e73qh1eWPpBEM6
         Br8KuNUzDGmPcO4Ez07UAqzu8LDkdYDE51VITMA/l+1Bgr/VlfW8JtwxbUlrfYieukBh
         kgySwu+jazZBlB92UdJl8VDjoQNeskkRs5zlvpYYh+3oKTj/vIVonC7K9kK+paBNTj5x
         EFmZp0DUzdzK0lZjUfpkJ5S1znFHxWhBzWQsTDu49Ze8pyAEv2MVpYEFouSa11A54cxm
         4hSXOUoOabE9q3Vio5o5jWH/6yIeuRqew46wOvV9n92YYcYO4hJq4ajr1O1wz5fyyJME
         jrQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=quDJ3umqwDRDYxNgvq9o71O19aurlvjSn5/hOL8u+aM=;
        b=YpQYpCmSzl42JLXyRwZsuWwKTs6s1wRAOkfeKTcx8DSQuz+Onb5neO/SgPBBQUkc/G
         iMQtcvgbk1ZGUQuaQ0IbdYyBQUipXdbYiugmRSwiBEBBf+NtewcWjBFMCAOgOq25gd80
         RUBV9T2EKAfqVjWFTBICDsk3gpU4XtjezEBM+0tNJp6rOEFbHrbeW8ADk01TH30am388
         cU75j1bDKX8xI9DJil1tAG9t5ZIhlx+3gbKhoXDuXCn+W/48q5AsONUctz+CgjFPOkB6
         lmdvSMhGzbIuUCw89Xlh3UXEjYMWqc3od/d1NWxxcjQ0rRKk1e8CRCmOXq/lHEtyOo8r
         CqjA==
X-Gm-Message-State: AOAM531+lEp9QuXh1OSIsqTp5nXGZM/wEXO4Ca3ItzBU5QZEitVQYidh
        LMevvfYEN00w9fD/RxHxR4IRW5s+bc8ag1v/o3CMSw==
X-Google-Smtp-Source: ABdhPJxnKUfXXtUegbcd0ki3qTfhWc7r+/QECoEfxKEa/1iaYSaYu+SO5betcJ1/kE4YNh5MAStsKhYCZWtsqMYwS2o=
X-Received: by 2002:a17:907:728c:: with SMTP id dt12mr2871733ejc.697.1644312907429;
 Tue, 08 Feb 2022 01:35:07 -0800 (PST)
MIME-Version: 1.0
References: <20220201152758.40391-1-andriy.shevchenko@linux.intel.com> <20220201152758.40391-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220201152758.40391-2-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 10:34:56 +0100
Message-ID: <CAMRc=Md-5tumCZOazoP+3O_Kc0wDDMixh-oxzwXkG5xmCuFL5A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] gpiolib: Never return internal error codes to user space
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Suresh Balakrishnan <suresh.balakrishnan@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 4:28 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Currently it's possible that character device interface may return
> the error codes which are not supposed to be seen by user space.
> In this case it's EPROBE_DEFER.
>
> Wrap it to return -ENODEV instead as sysfs does.
>
> Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
> Fixes: 61f922db7221 ("gpio: userspace ABI for reading GPIO line events")
> Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
> Reported-by: Suresh Balakrishnan <suresh.balakrishnan@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c  |  6 +++---
>  drivers/gpio/gpiolib-sysfs.c |  7 ++-----
>  drivers/gpio/gpiolib.h       | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index c7b5446d01fd..ffa0256cad5a 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -330,7 +330,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>                         goto out_free_lh;
>                 }
>
> -               ret = gpiod_request(desc, lh->label);
> +               ret = gpiod_request_user(desc, lh->label);
>                 if (ret)
>                         goto out_free_lh;
>                 lh->descs[i] = desc;
> @@ -1378,7 +1378,7 @@ static int linereq_create(struct gpio_device *gdev, void __user *ip)
>                         goto out_free_linereq;
>                 }
>
> -               ret = gpiod_request(desc, lr->label);
> +               ret = gpiod_request_user(desc, lr->label);
>                 if (ret)
>                         goto out_free_linereq;
>
> @@ -1764,7 +1764,7 @@ static int lineevent_create(struct gpio_device *gdev, void __user *ip)
>                 }
>         }
>
> -       ret = gpiod_request(desc, le->label);
> +       ret = gpiod_request_user(desc, le->label);
>         if (ret)
>                 goto out_free_le;
>         le->desc = desc;
> diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
> index 4098bc7f88b7..44c1ad51b3fe 100644
> --- a/drivers/gpio/gpiolib-sysfs.c
> +++ b/drivers/gpio/gpiolib-sysfs.c
> @@ -475,12 +475,9 @@ static ssize_t export_store(struct class *class,
>          * they may be undone on its behalf too.
>          */
>
> -       status = gpiod_request(desc, "sysfs");
> -       if (status) {
> -               if (status == -EPROBE_DEFER)
> -                       status = -ENODEV;
> +       status = gpiod_request_user(desc, "sysfs");
> +       if (status)
>                 goto done;
> -       }
>
>         status = gpiod_set_transitory(desc, false);
>         if (!status) {
> diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
> index 30bc3f80f83e..c31f4626915d 100644
> --- a/drivers/gpio/gpiolib.h
> +++ b/drivers/gpio/gpiolib.h
> @@ -135,6 +135,18 @@ struct gpio_desc {
>
>  int gpiod_request(struct gpio_desc *desc, const char *label);
>  void gpiod_free(struct gpio_desc *desc);
> +
> +static inline int gpiod_request_user(struct gpio_desc *desc, const char *label)
> +{
> +       int ret;
> +
> +       ret = gpiod_request(desc, label);
> +       if (ret == -EPROBE_DEFER)
> +               ret = -ENODEV;
> +
> +       return ret;
> +}
> +
>  int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
>                 unsigned long lflags, enum gpiod_flags dflags);
>  int gpio_set_debounce_timeout(struct gpio_desc *desc, unsigned int debounce);
> --
> 2.34.1
>

Queued for fixes, thanks!

Bart
