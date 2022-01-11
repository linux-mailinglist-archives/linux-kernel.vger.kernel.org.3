Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D624B48A86A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbiAKH3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 02:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiAKH3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 02:29:18 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87BCC06173F;
        Mon, 10 Jan 2022 23:29:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id m4so21968557edb.10;
        Mon, 10 Jan 2022 23:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=12jsSOU5ZNxy84ETQ5LSrudrwcQeLCeYfKiSaDp1ftY=;
        b=hjbl3rn/DvVDqV9U+a5izOL62rKLOSaKxYvpUKendFVHeuuIfK0nSd0ebg7bffAEnL
         f4Gh5h4GFaoaNlaWAMlM2rmOgVaEoxubrRsoZOwkvQSl01hmX3W5t6R1RJ6U68XLHMxK
         YZkQK8j6PSHjZSMO00ixmcDx2Z/6/Iuox8WRAUXwn0xWClXpRYIbo7RoqD9pmigVcKBB
         D6r3xUfWAEWS3UDxruurk38lYYr4yD80e0jljnCTnGwsRu/Yot/7zoRDndnXbyS4wRVt
         c9SnFr2Wi1obbMTyGR8Rnay0TkXx6S059ewkHftkAkkMWlg84l+XU2bFJXZ5le5Abwa6
         xRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=12jsSOU5ZNxy84ETQ5LSrudrwcQeLCeYfKiSaDp1ftY=;
        b=MR5GHwgvTFGFx5oqk5eDKrucRSMizuLx5+DO4tRGXOb2eAlWSsC1KRJK0XWdaRCX3a
         YALQHli0CEKe18rXTFOPuCCl+7ZtzAxkHR3UCfrCeRG9Js0SykvuotogrVghf8pqk+me
         RHzQo0nHqtdPZf6nQ85m7D7bpi/y2P9F1cfBfYHZd0MUsDCT2prdCRwoNbeAbr3stVNM
         HlZxklK+qwCOIew2shL+pGWnuH4TCx+BKJ904bYtgBnu/wGMqGnzvlqNAJtdbZzg5GPS
         le/i43bfwDUoF8dk1FbRP+EbpCXjzgCTSmZL3c1IQxKoIr7rnTmNW/KGa3CEs1yIk2P7
         93zw==
X-Gm-Message-State: AOAM5322T7pqDiebPc1UuV4dB/IOH3eKBHXzaWTc08c3ZVq9iz4xJzpm
        e2It91crE6wFCbUeJs8J/s0=
X-Google-Smtp-Source: ABdhPJzZAeYEy5k8zkJyHiJB7jbeV8xIKIsvwPQztjRd7ouQe7D3cvPQ5dk924wzjHCCdmVgAiBICw==
X-Received: by 2002:a05:6402:160d:: with SMTP id f13mr3128349edv.247.1641886156356;
        Mon, 10 Jan 2022 23:29:16 -0800 (PST)
Received: from [192.168.0.182] ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id v16sm4708637edc.4.2022.01.10.23.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 23:29:16 -0800 (PST)
Message-ID: <9d98ad20-617d-b57f-3b87-e001b6999fba@gmail.com>
Date:   Tue, 11 Jan 2022 09:29:15 +0200
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
 <CAHp75VckhARFUX3F0F7MLiHzpdqgKiVpDxoYNZVwSsB7ZK2=hQ@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VckhARFUX3F0F7MLiHzpdqgKiVpDxoYNZVwSsB7ZK2=hQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/22 01:14, Andy Shevchenko wrote:
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
> 
>     -
> 
> 
> This blank line should be kept. Isn’t checkpatch complaining about?

Nope, doesn't seem to, even with the --strict option.

> 
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
