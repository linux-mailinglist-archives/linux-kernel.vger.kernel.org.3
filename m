Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D209447B99E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 06:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbhLUFnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 00:43:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhLUFnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 00:43:09 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F843C061574;
        Mon, 20 Dec 2021 21:43:08 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id j6so26660582edw.12;
        Mon, 20 Dec 2021 21:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fmR/2OqeSaL3bwGQc4psClXM2rn7wapRvk/2x0G98Bk=;
        b=kMJ+8JEuQLWCtM+aB5Q7fBKeOV1O86YhY5W6RTmLIu3Cuj3DAIgJMgcawjkXBM/D6P
         avagRnhGCMzImCaW2ZurdZwcB706B7GXU0HAHvaE10paBFfSz2Wqbkwua3z7ToSF25P0
         L+L/jcTrWi0grB0hxIGl/FOqCUQbVI+c+AoC1y1nl4rd8tbKxT93h4cYmgeKOa//q3KR
         ccc9lPMWXCDAihLwTDTOMCHksfBhtOLTe4OQ1+vIUUVHH78+a3P7/VChnJMS9ihooqhd
         m5APEiD/w4Bllo0exdPDHiQOoNpvBDaUkkdO7oF8MDL/fieWHpE72jP1uRsoWtDQ3crw
         tBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fmR/2OqeSaL3bwGQc4psClXM2rn7wapRvk/2x0G98Bk=;
        b=4VvYZianW4hfZ16hUNsR/Zaxp20MPqY+mK/dPLGR+ksA87AtLiuB9t96klHL5NshBj
         mvJUJkSZS+szQZJl4xAkV1xymxoqLu4IZMjLPBitKCAoYK/l5lo0Wd1USfODFoJaXnqG
         zPwhTj1xliyGAdWkMpgxY3yf767cqBCk6EO8WDNSXGiUtOtLgCXFH5MFy3MtRW5rRzHU
         eYkjFc053AQdZqOLllK52HDBJQZUGMH/hZg7z08lnyAhm1nXCeFlbsbp9I3sTVTdErNI
         DBEHWFhdbFVkJRXz87Ly5YWAztbn3FCwzY8/CXSDkUkNmOuyDC+GiamtEsjVy5owVJsl
         pfUQ==
X-Gm-Message-State: AOAM531fBenV2cjghWchq4iAZgE5HBEq6fk+jMdg8emqZZjyHlZ/Yoab
        o2C/r8C0PT+r1NF0dk0u/LozLRYDj2mWyjRXIjJYEttOrBvwRr3AVQw=
X-Google-Smtp-Source: ABdhPJx2rCF5AgXg3IpCeewR26zJGoR08zWvV5Ra54dOuM/nVn/uXtBS32YFrWIkXGogA3I6yqszzVkOonVvjRQ7ClI=
X-Received: by 2002:a17:906:a3c6:: with SMTP id ca6mr1279777ejb.639.1640065387201;
 Mon, 20 Dec 2021 21:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20211219223953.16074-1-liambeguin@gmail.com> <20211219223953.16074-4-liambeguin@gmail.com>
In-Reply-To: <20211219223953.16074-4-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Dec 2021 07:42:31 +0200
Message-ID: <CAHp75Ve_vv619-UxdBN+xhWGm32tCJkkN3epVRgCiLF7p6xMOw@mail.gmail.com>
Subject: Re: [PATCH v10 03/14] iio: inkern: make a best effort on offset calculation
To:     Liam Beguin <liambeguin@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 11:17 AM Liam Beguin <liambeguin@gmail.com> wrote:
>
> From: Liam Beguin <lvb@xiphos.com>
>
> iio_convert_raw_to_processed_unlocked() assumes the offset is an
> integer. Make a best effort to get a valid offset value for fractional
> cases without breaking implicit truncations.

...

> +                       offset_val /= (1 << offset_val2);

Besides potentially being problematic (if arg is 31 for the left
shift) why not simply

_val >>= _val2;

?

-- 
With Best Regards,
Andy Shevchenko
