Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268448AA64
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349257AbiAKJXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349224AbiAKJXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:23:15 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6EC06173F;
        Tue, 11 Jan 2022 01:23:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id o6so64594813edc.4;
        Tue, 11 Jan 2022 01:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdmddZoLPqnTqmjCQ4od3WcJNa5BhdUvuEmcIx7UK40=;
        b=BBIkrzV9hu3XILNZw6ejZtSs4TWoRA23764jFCMQKfcQeTy5pE0W4KHtdmUOKHbqG4
         ++KrEeS5dkXYmA1fB1QRfjDc3mhkDByTOLmAWA92B+zZ2E45CoZ4jQ0sm0xMsPDXOiuz
         Hjp+AgPlYlFFbF0neRDeZEuJi67S9jFTkavKTrBqY9by5cJsKB6VfFfEKSFD5cK3C/Ky
         DKpiGZhIsHEqqWKvILrG9YpGsLGy9c30RugN7tR0S9i181pugGPG2dI07kfR2gBKgqki
         ZqDuG4QPZ9RyqRdPLHz1IW3rbTek96iG5ciZa8EqKoUNCDPzBmONiiygmPjLpEFjexv1
         cWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdmddZoLPqnTqmjCQ4od3WcJNa5BhdUvuEmcIx7UK40=;
        b=TU8sAPGf/oMuOxWCUVSVTCpsFk8uqsNMDDiFor7LdelCm7zD7VK22sKxtuO/0wqmTX
         m7xD1ZoBbKRf5WpjdmWPSEWKV2lxCKfHuBMLsfG97FudCW3CISBmSEPlGFCO9eJG+gCy
         LGwCRxM6Z7cUL/D0PphBgOZDfYCNMeFv4u43ypV8/TjVwSTfGFQAAO1i/+LgqF0MUSbS
         cWjNa/wBNEIzGcaJotoAXZDjsW0hMKhT7u5cQZuG5K/YbJyz7QI827A1T8V8HU8G5XWg
         mSJ7Y4qpqDWHuyfkIzahYKrBgLuOqh94G/RrdRjOXMRrxXH59D0KSLcN5y2kCLyrxPdo
         MaQA==
X-Gm-Message-State: AOAM531nvDSlbycx3dmS0OnQPWBwre72nGPHgWEgdphMO5u9RFaCVkFU
        jq/DTp29D04RIO25vKmYCGEB5Ou3dE/ZKrJNEL4=
X-Google-Smtp-Source: ABdhPJwpyWAE46cJUBpIFpUJdmN6NrsJkFYy8FePhQLt7goonuQk/AzaB1hCqVEHLFwriCPBnXLy58qJJ+O1++W3Ma4=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr2876393ejj.636.1641892993058;
 Tue, 11 Jan 2022 01:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20220111074703.3677392-1-cosmin.tanislav@analog.com> <20220111074703.3677392-2-cosmin.tanislav@analog.com>
In-Reply-To: <20220111074703.3677392-2-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 11 Jan 2022 11:21:25 +0200
Message-ID: <CAHp75VeyJY3K+UgwXqkkRkPRHgbQhbFVRmjrzKb0-xwc=yC2NA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: addac: ad74413r: correct comparator gpio
 getters mask usage
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 9:47 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> The value of the GPIOs is currently altered using offsets rather
> than masks. Make use of __assign_bit and the BIT macro to turn
> the offsets into masks.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
> V1 -> V2
>  * add Fixes tag
>  * use __assign_bit
>  * remove bitmap_zero
>
> V2 -> V3
>  * add back line between real_offset declaration and __assign_bit call
>  * move before patch 2
> ---
>  drivers/iio/addac/ad74413r.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
> index 6ea3cd933d05..b13cd5407df3 100644
> --- a/drivers/iio/addac/ad74413r.c
> +++ b/drivers/iio/addac/ad74413r.c
> @@ -134,7 +134,6 @@ struct ad74413r_state {
>  #define AD74413R_CH_EN_MASK(x)         BIT(x)
>
>  #define AD74413R_REG_DIN_COMP_OUT              0x25
> -#define AD74413R_DIN_COMP_OUT_SHIFT_X(x)       x
>
>  #define AD74413R_REG_ADC_RESULT_X(x)   (0x26 + (x))
>  #define AD74413R_ADC_RESULT_MAX                GENMASK(15, 0)
> @@ -316,7 +315,7 @@ static int ad74413r_gpio_get(struct gpio_chip *chip, unsigned int offset)
>         if (ret)
>                 return ret;
>
> -       status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
> +       status &= BIT(real_offset);
>
>         return status ? 1 : 0;
>  }
> @@ -337,8 +336,7 @@ static int ad74413r_gpio_get_multiple(struct gpio_chip *chip,
>         for_each_set_bit_from(offset, mask, chip->ngpio) {
>                 unsigned int real_offset = st->comp_gpio_offsets[offset];
>
> -               if (val & BIT(real_offset))
> -                       *bits |= offset;
> +               __assign_bit(offset, bits, val & BIT(real_offset));
>         }
>
>         return ret;
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
