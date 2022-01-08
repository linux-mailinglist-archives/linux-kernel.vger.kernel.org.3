Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE14488340
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 12:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbiAHLgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 06:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiAHLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 06:36:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC0EC061574;
        Sat,  8 Jan 2022 03:36:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id a18so31430084edj.7;
        Sat, 08 Jan 2022 03:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYRn/Fp3acdQ41ODnQ1cE0XJd0M/Kvs9MRUomdtJDaw=;
        b=OS3F2rWU17CcZI0zRB4Xfk3Z8cVgMU/A2YX9Bb3gW/AiFRn2Tqb97ZGj+NX5FxG8bz
         KHw0/U+j74Asg2mDLQJePjhcACT86AlZD0MN0EPgc5ArBUHzBeTqJxBBBZwO5XIP0IHh
         4i9nY28n0BQGALOEPdyPgcEPxOwlJWFLaN0mLhw4Uhq2StpyAPtS2fXD9TbUB/glyidA
         CYBPdqhFQz0n45JCP1MbM79CNNO8eKpdj0Eo/DLYi8PlQR9gQtPJJd1eKZ7gUcFzU3nm
         ueyqFnzq2a0ayxjTg5/5C88dE27Ywltsm5MZx1CN+H25dR4KqMr06qoS7lIX33Ueqk5p
         aaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYRn/Fp3acdQ41ODnQ1cE0XJd0M/Kvs9MRUomdtJDaw=;
        b=Jfzj1Q6cGlRG2onoQFaigHoqiEzw2WxLDvBjEYJhyff/kg8ah9WRl8SiEYRulKCZjz
         JYv9U6lwtcDGKpPkYlsCLEyBt42+/F3Pb/YzhvRWlNBSHuCFkXecWJBjAsLTF/+WPz7k
         6kyhLC3auKmKusOZAEjKOrPNJLLLGtIc7hAVUBcvZVdhIovBXawftbZLlPXhawnVQARd
         GpHWzVH2lvfvLjuySelnPsNs9imTo4HpuY63MKJ/p6TrKJrn8f4F4pSGZGZRNxE1fmva
         IC5rq0hb4kVQodN0KYXnz20OqI3fe1b/LG5B4ZBLsEd1SBYYL90XgL8JTADgiNoFvKKQ
         2KRw==
X-Gm-Message-State: AOAM533M7mai0O+fSP+tmfCFtrGf9d0t/H67vb4PqXysZbieNXTBNQXz
        mdoMHy3JEYjYETKMqH+v7T+aO91aXsU5gHnaAqVN96SA5j8y2Q==
X-Google-Smtp-Source: ABdhPJxPORkzyKOY44ccsJlQq+uFWr7Ezt47t6pPKg+cmSNUXdTnP9uu0M+OcNWvro3oIUcTVd4Z0xhN/U11GYQjpsY=
X-Received: by 2002:a17:907:968c:: with SMTP id hd12mr5079745ejc.639.1641641808269;
 Sat, 08 Jan 2022 03:36:48 -0800 (PST)
MIME-Version: 1.0
References: <20220107232409.1331599-1-keescook@chromium.org>
In-Reply-To: <20220107232409.1331599-1-keescook@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 8 Jan 2022 13:36:12 +0200
Message-ID: <CAHp75VdqK7h63fz-cPaQ2MGaVdaR2f1Fb5kKCZidUG3RwLsAVA@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at25: Restore missing allocation
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
>
> Building under CONFIG_FORTIFY_SOURCE=y and -Warray-bounds complained about
> strncpy() being used against an empty object. It turns out this was due to
> the at25 allocation going missing during a conflict resolution. Restore
> this, and while we're here take the opportunity to do another strncpy()
> replacement, since it's use is deprecated[1].
>
> Seen as:
>
> In function 'strncpy',
>     inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
> ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
>    48 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
>    59 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
> In function 'strncpy',
>     inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
>     inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
> ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
>    48 | #define __underlying_strncpy    __builtin_strncpy
>       |                                 ^
> ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
>    59 |         return __underlying_strncpy(p, q, size);
>       |                ^~~~~~~~~~~~~~~~~~~~
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings

Thanks!
With or without the below comment being addressed
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: af40d16042d6 ("Merge v5.15-rc5 into char-misc-next")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/misc/eeprom/at25.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index c3305bdda69c..1a19fa5728c8 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -309,7 +309,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
>         u32 val;
>         int err;
>
> -       strncpy(chip->name, "at25", sizeof(chip->name));
> +       strscpy(chip->name, "at25", sizeof(chip->name));
>
>         err = device_property_read_u32(dev, "size", &val);
>         if (err)
> @@ -370,7 +370,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
>         u8 id[FM25_ID_LEN];
>         int i;
>
> -       strncpy(chip->name, "fm25", sizeof(chip->name));
> +       strscpy(chip->name, "fm25", sizeof(chip->name));
>
>         /* Get ID of chip */
>         fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
> @@ -440,6 +440,10 @@ static int at25_probe(struct spi_device *spi)
>                 return -ENXIO;
>         }
>
> +       at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);

I would use sizeof(*at25) but I think you restored the exact context.

> +       if (!at25)
> +               return -ENOMEM;
> +
>         mutex_init(&at25->lock);
>         at25->spi = spi;
>         spi_set_drvdata(spi, at25);
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
