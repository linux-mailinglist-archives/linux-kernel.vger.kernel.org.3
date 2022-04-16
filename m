Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E168350352E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiDPI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiDPI3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:29:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FC33A08;
        Sat, 16 Apr 2022 01:26:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id u18so12283489eda.3;
        Sat, 16 Apr 2022 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixYukh5lcPmdBMweBnkornJe58aw5tIVg5x4oR/k4ic=;
        b=ANDTUvdhwV/3lpttLPtcVsHcQWoIW8nCVC5TRHMRKdXkkgco2TZ/R7Yg5INFF7GGAQ
         EmnmPhwi0d9VGCsB9njNzDiX5ybwd2P7j91Vm8w7kBksYh+pKKboA2njsKUS/2xA1fix
         AebYfNvyIC3t5EfMrOAKAYmKrwN3ji0jcpH81Dj5JA2QdUyWFAFXrwoAaa4LgdUzTNmX
         XCk0/9EtWGkRrLGK9Ly3dUwpmH4GQEjvrnzDkrNExHZMw5bNb8qR6k4WbDbUade4SyeY
         9oIgHR7vIfx6s2b/kc23s+gl/Sw+cTZ1+oyn3OxpBQ4rx5SRItRcZwEOnO5+3/uIHSlN
         G5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixYukh5lcPmdBMweBnkornJe58aw5tIVg5x4oR/k4ic=;
        b=W5KvYBDH8/kbT58mCxdf4gMdOKJHPDI4ZO3HbOSJQ2nb7fOGsyaNvJif6OvK3ZDCcC
         pFTYjtBj9TO6cdgjf9YYCuyk7WAfqQR9M9M5o/39JM2K12jHmXHKsYLabQd2JoB4MsQ0
         75Atfsp6Jo8Yl9Ej59/CgmrIaXKoKQa2jm+ryVOpjVkjDpjjlaWQz3kxqcR9Rqd0rYLq
         J2o8jOJjIIZfjEszZTwx+LGPZ+wbYGUqEZkWTaUMYWFJuBfhvvnpejDoTuNgLSV60zxX
         PvheQwSleKwvK/zHm88PzzivOcJ2v3uGn9Es2cmfq+CZhI0YrrKetNBY6GbakDzLhSMz
         ot4Q==
X-Gm-Message-State: AOAM531bQ8tEH7RP4mr4ha3s4PCuLMlwfDKIOnOYiNKtQJTNt/Lcz6K1
        /E8YCaRN5IIIDo34sxVeOsEKIDBI1WWU8NvhrsQ=
X-Google-Smtp-Source: ABdhPJwdg54Fb4NlQ50SlhCchCw49y9IEn5kqQsD5RZVVgFK2JAIE+SusdeKLGFWtmQchPfhPs2WikuitqYfQEwfeq4=
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id
 i23-20020a05640200d700b004130673ba2fmr2820550edu.29.1650097588767; Sat, 16
 Apr 2022 01:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220415070710.220785-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220415070710.220785-1-andrei.lalaev@emlid.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:25:52 +0300
Message-ID: <CAHp75VdzVj12K=iGY78tdyULyZAL4=fKAX9rBuCyfNXdUeg3MQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: of: fix bounds check for 'gpio-reserved-ranges'
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 10:09 AM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:
>
> Gpiolib interprets the elements of "gpio-reserved-ranges" as "start,size"
> because it clears "size" bits starting from the "start" bit in the according
> bitmap. So it has to use "greater" instead of "greater or equal" when performs
> bounds check to make sure that GPIOs are in the available range.
> Previous implementation skipped ranges that include the last GPIO in
> the range.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 726cb3ba4969 ("gpiolib: Support 'gpio-reserved-ranges' property")
> Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>
> ---
> I wrote the mail to the maintainers
> (https://lore.kernel.org/linux-gpio/20220412115554.159435-1-andrei.lalaev@emlid.com/T/#u)
> of the questioned DTSes (because I couldn't understand how the maintainers
> interpreted this property), but I haven't received a response.
> Since the questioned DTSes use "gpio-reserved-ranges = <0 4>"
> (i.e., the beginning of the range), this patch doesn't affect these DTSes at all.
> TBH this patch doesn't break any existing DTSes because none of them
> reserve gpios at the end of range.
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index ae1ce319cd78..7e5e51d49d09 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -910,7 +910,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
>                                            i, &start);
>                 of_property_read_u32_index(np, "gpio-reserved-ranges",
>                                            i + 1, &count);
> -               if (start >= chip->ngpio || start + count >= chip->ngpio)
> +               if (start >= chip->ngpio || start + count > chip->ngpio)
>                         continue;
>
>                 bitmap_clear(chip->valid_mask, start, count);
> --
> 2.25.1
>


-- 
With Best Regards,
Andy Shevchenko
