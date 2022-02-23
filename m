Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA84C1DC2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242693AbiBWVcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiBWVcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:32:14 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369E03CA49
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:31:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id hw13so124396ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z4ZVkt8qZMy2gYEg/eldrrEE9UadTptB/fCse20u77k=;
        b=uH3iTz2QGOOXGOs7gP4GUWmAmCSbm7JwqXRf/KvtFUe2MV934uQIEoIMfozDrL5ffI
         trMtsQ83jy0lfEhG5pRbtwCDZ9MRFRvNXLlAx8KIx7JlIU0C4uSOG2+dfonx4pBCMZc5
         lCttbFooWLazs/0fKKgsXUpOI2xQxA6W88Zyb/Vlu1KxU+IXRnQtmiE1gk4negHvoB//
         CLuSgzLmqazAqFFZnawz8ktkav2/oByCKPSNbfqx6/W5e3Lkmg+5Z0w/Hs9akdqYS5OW
         SGNTWMWIQzdkDoiX3xmdCm2Vc/yiUYSRWYfP6I7nYvtSi5AsYULM0LBXA/yKyVubEDjQ
         zZ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z4ZVkt8qZMy2gYEg/eldrrEE9UadTptB/fCse20u77k=;
        b=A5miXaqjPmoqG6LdEXZddRk18FGp7xyjDYRJMoxmMLFBTTbceUiCmmVjw0Pi3PupAr
         aFdtsgVe3wg05wH6ViCvHtPtk2Zm1K8/q+P0ijI9NTLiErbnXxpts6pC1dcH2HcBN0V/
         J3wgxG/6nmZK73DqM3dWkyjcQ1vL5drit+/t4EXpGMlREykCIetZpUDvulL3663Jr6ub
         n9sf+Eq8MR2LfhpMNFoHANIu4jP/MNw1/2rCv1PcZ09Ohh80P5bzoDbCLf4Ag2eZz8jX
         CYll1UBthYWUw2Y2Xz7uaji0a8BJs8micgMIFoF+JfSySAwErVvyOKnhwMMBGrykAN/E
         P8QQ==
X-Gm-Message-State: AOAM5312UMkIOFxmaJ2ltFM7pGPWXNsFMrtp/qjmT7szvpxT6tqTrUFe
        HEw8uQHbOuHp+Q5COk1Q8tL7JJjA2Cu9e4AJhC6UwQ==
X-Google-Smtp-Source: ABdhPJwGY42pBBzmTXzQxtK8kQ3OvjcZRZjenfG79d42ZtNsrmQbmI2eEfrJx7GQiFK4Ji4rSTRHC8jqjQ1/5CRtQ3s=
X-Received: by 2002:a17:906:1393:b0:6ba:dfb1:4435 with SMTP id
 f19-20020a170906139300b006badfb14435mr1282305ejc.736.1645651903755; Wed, 23
 Feb 2022 13:31:43 -0800 (PST)
MIME-Version: 1.0
References: <20220216202655.194795-1-shreeya.patel@collabora.com>
In-Reply-To: <20220216202655.194795-1-shreeya.patel@collabora.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 23 Feb 2022 22:31:33 +0100
Message-ID: <CAMRc=MckPeT01V-iqXSk-eO4CYFD6aRP1yOaQXGUri5o2=tqZQ@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: Return EPROBE_DEFER if gc->to_irq is NULL
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 9:27 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> We are racing the registering of .to_irq when probing the
> i2c driver. This results in random failure of touchscreen
> devices.
>
> Following explains the race condition better.
>
> [gpio driver] gpio driver registers gpio chip
> [gpio consumer] gpio is acquired
> [gpio consumer] gpiod_to_irq() fails with -ENXIO
> [gpio driver] gpio driver registers irqchip
> gpiod_to_irq works at this point, but -ENXIO is fatal
>
> We could see the following errors in dmesg logs when gc->to_irq is NULL
>
> [2.101857] i2c_hid i2c-FTS3528:00: HID over i2c has not been provided an Int IRQ
> [2.101953] i2c_hid: probe of i2c-FTS3528:00 failed with error -22
>
> To avoid this situation, defer probing until to_irq is registered.
> Returning -EPROBE_DEFER would be the first step towards avoiding
> the failure of devices due to the race in registration of .to_irq.
> Final solution to this issue would be to avoid using gc irq members
> until they are fully initialized.
>
> This issue has been reported many times in past and people have been
> using workarounds like changing the pinctrl_amd to built-in instead
> of loading it as a module or by adding a softdep for pinctrl_amd into
> the config file.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=209413
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
>
> ---
> Changes in v5
>   - Improve explanation in commit message and sending it to the correct
> email address.
>
> Changes in v4
>   - Remove blank line and make the first letter of the sentence
> capital.
>
> Changes in v3
>   - Fix the error reported by kernel test robot.
>
> Changes in v2
>   - Add a condition to check for irq chip to avoid bogus error.
> ---
>  drivers/gpio/gpiolib.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 3859911b61e9..a3d14277f17c 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -3147,6 +3147,16 @@ int gpiod_to_irq(const struct gpio_desc *desc)
>
>                 return retirq;
>         }
> +#ifdef CONFIG_GPIOLIB_IRQCHIP
> +       if (gc->irq.chip) {
> +               /*
> +                * Avoid race condition with other code, which tries to lookup
> +                * an IRQ before the irqchip has been properly registered,
> +                * i.e. while gpiochip is still being brought up.
> +                */
> +               return -EPROBE_DEFER;
> +       }
> +#endif
>         return -ENXIO;
>  }
>  EXPORT_SYMBOL_GPL(gpiod_to_irq);
> --
> 2.30.2
>

Queued for fixes, thanks!

Bart
