Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5998048A863
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348522AbiAKH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiAKH0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:26:22 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B5C06173F;
        Mon, 10 Jan 2022 23:26:21 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id i5so9812157edf.9;
        Mon, 10 Jan 2022 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fDLulooVhTwdWu5IC9b6xR2D6h2T6qJ3J7YaDkUvjm4=;
        b=ccZ80P5Hl5G0RYcdsxN3DGKso8W3ulMLkR9UlyGJTfkvBhOqKXf3RvNnaDX5QTOzWm
         J1C6+acpoCM425NpJ5qd3pj3Rhtl39yEfWGb0e9Q7Az38xcgykrAgiODA8JHWcCaCNrM
         JKhcw3/1Eqlw1yXC6K7A9xiAEFv5H/QJZk68eQ/i0SzB2dy1VJWFFZYK01GHbKZPKdRw
         1P6Zc2Iw+wPn/D8LqjEqqzV/ohxrlNC4rm7wIPG+Md36yp61+rTaNL0zKPJZygdECLpE
         eu97peA/1eoJto6CrFMWDz34z01Q5CmWXtjWHT3ic2G2KD668PaD39nNPtg4ngcCbfBE
         ujhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fDLulooVhTwdWu5IC9b6xR2D6h2T6qJ3J7YaDkUvjm4=;
        b=ettZJkLpIreWfRCkgD72YNYx/JSuf2/Vu9ZC0pbHXHnRGMJ95ylCBq7LUocO42cwMs
         5kS8NTq30i3KYd6VgtxWYm7eWwPrFIV6WgmqO2GM9WPzxn7sKPJDAHWfaXZ1rBnhugnW
         6n8WvIWEnWAU2Runywr5NCosjxj76WiwBvoXVbzTPGFSLIddB2JXkjG3hiePPL54Xw2G
         wUy+EOCot56gKvZrMgGUZZqSkkwtiWGuVEvRg0YiJHbKL4SK9JyjcTQ0wInWk4hjxqGF
         MSDQ2bCFf2gC04yrGmkpgxldvnDA/DR6WCtU8eM8ELK4FiNZoUSwwbb1V9x9kb+lPQWw
         QQrw==
X-Gm-Message-State: AOAM532VCIPPlE/SvA0Tlc0vDn4l1CCKL8ciUsVKPnRv54uKtD3gPPcs
        h1QnGaYeFlgUIf7IeeTo/hE=
X-Google-Smtp-Source: ABdhPJychsDJWROU/7NKf1dMNbo5YoW1zTnNkyU5Zrhc0ooNcqJPbrY1HoKQzVHtGkkM3kik89/Jnw==
X-Received: by 2002:a17:906:2b8a:: with SMTP id m10mr2544856ejg.479.1641885980190;
        Mon, 10 Jan 2022 23:26:20 -0800 (PST)
Received: from [192.168.0.182] ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id r17sm3284811eje.15.2022.01.10.23.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 23:26:19 -0800 (PST)
Message-ID: <892aa3e1-7613-ee17-2784-4e295ab27100@gmail.com>
Date:   Tue, 11 Jan 2022 09:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 3/3] iio: addac: ad74413r: correct comparator gpio
 getters mask usage
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "cosmin.tanislav@analog.com" <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20220110220509.3527402-1-cosmin.tanislav@analog.com>
 <20220110220509.3527402-3-cosmin.tanislav@analog.com>
 <CAHp75VezW0DTvjLb6wOOf+skCv5-bDV38ozNaCq1wX+Oekarfw@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VezW0DTvjLb6wOOf+skCv5-bDV38ozNaCq1wX+Oekarfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 01:12, Andy Shevchenko wrote:
> 
> 
> On Tuesday, January 11, 2022, Cosmin Tanislav <demonsingur@gmail.com 
> <mailto:demonsingur@gmail.com>> wrote:
> 
>     The value of the GPIOs is currently altered using offsets rather
>     than masks. Make use of __assign_bit and the BIT macro to turn
>     the offsets into masks.
> 
>     Fixes: fea251b6a5db ("iio: addac: add AD74413R driver")
> 
> 
> 
> Ss i told you this should go _before_ patch 2.

Sorry, I missed your comment on this.

> 
>     Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com
>     <mailto:cosmin.tanislav@analog.com>>
>     ---
>     V1 -> V2
>       * add Fixes tag
>       * use __assign_bit
>       * remove bitmap_zero
>     ---
>       drivers/iio/addac/ad74413r.c | 7 ++-----
>       1 file changed, 2 insertions(+), 5 deletions(-)
> 
>     diff --git a/drivers/iio/addac/ad74413r.c b/drivers/iio/addac/ad74413r.c
>     index 3d089c0b6f7a..8a8d60e592a8 100644
>     --- a/drivers/iio/addac/ad74413r.c
>     +++ b/drivers/iio/addac/ad74413r.c
>     @@ -134,7 +134,6 @@ struct ad74413r_state {
>       #define AD74413R_CH_EN_MASK(x)         BIT(x)
> 
>       #define AD74413R_REG_DIN_COMP_OUT              0x25
>     -#define AD74413R_DIN_COMP_OUT_SHIFT_X(x)       x
> 
>       #define AD74413R_REG_ADC_RESULT_X(x)   (0x26 + (x))
>       #define AD74413R_ADC_RESULT_MAX                GENMASK(15, 0)
>     @@ -316,7 +315,7 @@ static int ad74413r_gpio_get(struct gpio_chip
>     *chip, unsigned int offset)
>              if (ret)
>                      return ret;
> 
>     -       status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
>     +       status &= BIT(real_offset);
> 
>              return status ? 1 : 0;
>       }
>     @@ -336,9 +335,7 @@ static int ad74413r_gpio_get_multiple(struct
>     gpio_chip *chip,
> 
>              for_each_set_bit(offset, mask, chip->ngpio) {
>                      unsigned int real_offset =
>     st->comp_gpio_offsets[offset];
>     -
>     -               if (val & BIT(real_offset))
>     -                       *bits |= offset;
>     +               __assign_bit(offset, bits, val & BIT(real_offset));
>              }
> 
>              return ret;
>     -- 
>     2.34.1
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
