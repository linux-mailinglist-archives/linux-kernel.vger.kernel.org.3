Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1998511732
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233991AbiD0McD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbiD0McA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:32:00 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40654B1D6;
        Wed, 27 Apr 2022 05:28:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l18so3068786ejc.7;
        Wed, 27 Apr 2022 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kw5zpz+aCMYY/HztCabKV/LfJ4jXBfWWw5oj9qpGGgQ=;
        b=VF9kZoHIFtLaDXLxUr9UK/2X3+5f5xDllVy0udiAJApqdvwWAUbue7nXjVoBn+aNKf
         nrzws7ygH3l8Vm2eBOsSc9giQXV/2tL4lXxJhBm+FkjjnEL4WIr76ube/GsWCyTvEdMv
         hspop4aKriUuwak1HiYUdf+NoZli8UAus1GtwAfwub/hQ1jENRMYXRmWSMJMH7J0kRc+
         W+4gVs3dvmpizUMcNpjTkLzjwNR+tv1EG6yUB32e1KFtUWV7Eh+JS/O+g2fUrwa7Zmv6
         YDYauZVT84KaEeCfF1/utfqq9TfNzBkI+TER9Td2Mo84YZ1C/jcnRbrRP0XEEGwrDywj
         hOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kw5zpz+aCMYY/HztCabKV/LfJ4jXBfWWw5oj9qpGGgQ=;
        b=i8ZWw1/+ikjm5qrA6OXkrMrly5Biv/xGF8NcGpzs9IT/mn+49h7Uok2Grzwc24asqs
         SQPhdB3FaCB56N1ZJ64YxPpHXpApaFU6Tikgl1dy+mb+fCoeKbylHl0lwI5hcfBELscl
         WGRsGJJHlgTVqn37OANDeYDbx2GFKcf3NIQp4/VRij3ziulMTW5UVehVvS9rccLEqcYS
         6AvWtYruUzp/drKzVwWXOWmkvVm7vW+OKpRbh+1qZZlyGMB4SYT2Taza1hTFk/BsnXHn
         5DirmHO6UUtLVTjLkZ41ZvNDIi2Ha3R7qiVwyu9/49/WMWIjf8twfRjsSlKPRzoY8MPA
         cERw==
X-Gm-Message-State: AOAM531MDT7/G01eOuMemUXqav5Ou76xs5pPD4oex8aieDxL1pOCkwYo
        26fsSrGgedrdt8CWD/YHjyLHxU9PP8gYflZvkXgArwOHaz9oBrP3
X-Google-Smtp-Source: ABdhPJzAk0GUYlozJK8nur+vVombMrYz2DlytyZQpkqw+X81AdAFT4PwWnQLob0uQTOXw7t5sa3PZvoAdHd7FQ/sUsI=
X-Received: by 2002:a17:907:6d22:b0:6f3:a9e5:d074 with SMTP id
 sa34-20020a1709076d2200b006f3a9e5d074mr9316782ejc.639.1651062527496; Wed, 27
 Apr 2022 05:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220420211105.14654-1-jagathjog1996@gmail.com> <20220420211105.14654-2-jagathjog1996@gmail.com>
In-Reply-To: <20220420211105.14654-2-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 27 Apr 2022 14:28:11 +0200
Message-ID: <CAHp75VdKVAz7gs8r0Mp1_4LoG4+QZg0JepTVffHyDw9-ggq-Wg@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] iio: accel: bma400: Fix the scale min and max
 macro values
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 11:11 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Changing the scale macro values to match the bma400 sensitivity
> for 1 LSB of all the available ranges.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400.h | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bma400.h b/drivers/iio/accel/bma400.h
> index c4c8d74155c2..80330c7ce17f 100644
> --- a/drivers/iio/accel/bma400.h
> +++ b/drivers/iio/accel/bma400.h
> @@ -83,8 +83,27 @@
>  #define BMA400_ACC_ODR_MIN_WHOLE_HZ 25
>  #define BMA400_ACC_ODR_MIN_HZ       12
>
> -#define BMA400_SCALE_MIN            38357
> -#define BMA400_SCALE_MAX            306864
> +/*
> + * BMA400_SCALE_MIN macro value represents m/s^2 for 1 LSB before
> + * converting to micro values for +-2g range.
> + *
> + * For +-2g - 1 LSB = 0.976562 milli g = 0.009576 m/s^2
> + * For +-4g - 1 LSB = 1.953125 milli g = 0.019153 m/s^2
> + * For +-16g - 1 LSB = 7.8125 milli g = 0.076614 m/s^2
> + *
> + * The raw value which is used to select the different ranges is determined
> + * by the first bit set position from the scale value, so BMA400_SCALE_MIN
> + * should be odd.
> + *
> + * Scale values for +-2g, +-4g, +-8g and +-16g are populated into bma400_scales
> + * array by left shifting BMA400_SCALE_MIN.
> + * e.g.:
> + * To select +-2g = 9577 << 0 = raw value to write is 0.
> + * To select +-8g = 9577 << 2 = raw value to write is 2.
> + * To select +-16g = 9577 << 3 = raw value to write is 3.
> + */
> +#define BMA400_SCALE_MIN            9577
> +#define BMA400_SCALE_MAX            76617
>
>  #define BMA400_NUM_REGULATORS       2
>  #define BMA400_VDD_REGULATOR        0
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
