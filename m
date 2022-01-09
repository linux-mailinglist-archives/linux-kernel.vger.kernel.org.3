Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A61D488978
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 14:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235567AbiAINCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 08:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiAINCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 08:02:39 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD7DC06173F;
        Sun,  9 Jan 2022 05:02:39 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m4so1039648edb.10;
        Sun, 09 Jan 2022 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I86LEEvrQ/QcdOpqixMeebdWSFgBbeMYSxutXt26E0g=;
        b=fz8Jg6XfMGpzpdlC3drISYB7O5aPfYJP+pD330axQ93b32bKVlmOancdUiBXeUa+IG
         dkde3+XzAdl6i9cWCKX9MxSUDjAK0GPWjEmOZYPcBDZBOgY/IiPOzj1J/U+HpHQwlSZA
         O3LJHdftp1b+RLIfeiMRziy2yMsk0ALuRuezNk5xQxoYPztqh1lYjihLtseYjMRvfwwH
         MKU9jpw+tG40CkiZhlLBCPWJlnDB+SWjKLLdDMfM+YmrmgH+bk7Iq98dosnIAV2J1nMU
         7Vg3/pZaf+UH7ZjDUiYJZYGtR2fWEGrNWuRIBmda/28bLqoyU1046GaTWBjL0M0raODO
         uEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I86LEEvrQ/QcdOpqixMeebdWSFgBbeMYSxutXt26E0g=;
        b=I76LcFvzfDDtiUc7bHDi/eXVWnLIWxfM5BK66vxq/nejfBrp+lrdrHx75dy+QXCbhy
         S95fYtqc2+YYCsPL83iABZ/oHbXaORyl8NwqTiDWfufUAmADbCILiu+6C54f0CcLukgy
         P6nucftcdPYd0pQFTQHnxkoekT2N3STMsp1zdV9L7TIDDbYScVxMUhv6JpNS8h7S8ykN
         TtOVD1N3V6OkZ8HE0wcWvri91fu1l5RX1/BGtImV8Log/qiW9NS0msmMRI/phU5JgPvA
         kHrNuywfmdoDx3e17FUA6WjqiXbhIU63R87xAFKtzbmFI1luCxkiCjZWUvFHpLJfNTIm
         UA8A==
X-Gm-Message-State: AOAM533QWO6X/lXfJHKmj4Gs1KEErVFdIrIrBDI2pndW7OCsSsLV9IAY
        VDSEYcf32xfvNif/5KL398PsHUb6S/IEIxwP6eg=
X-Google-Smtp-Source: ABdhPJxjELSLk5Z9rzw2AIT6D+g+7h7MuSM6BMs6aqHVYx9RCIJm+iK+Ok/msWIqu/m82mURNUlqRiO0QPD24K9j9q0=
X-Received: by 2002:a17:906:e0d9:: with SMTP id gl25mr4934446ejb.44.1641733357745;
 Sun, 09 Jan 2022 05:02:37 -0800 (PST)
MIME-Version: 1.0
References: <20220108205319.2046348-1-liambeguin@gmail.com> <20220108205319.2046348-10-liambeguin@gmail.com>
In-Reply-To: <20220108205319.2046348-10-liambeguin@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 9 Jan 2022 15:02:01 +0200
Message-ID: <CAHp75Vd-FOV7BL0VjhGLyC5fhYXbW3x-hC5J1VvMT9W3Kfc_0Q@mail.gmail.com>
Subject: Re: [PATCH v12 09/16] iio: afe: rescale: fix accuracy for small
 fractional scales
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

On Sat, Jan 8, 2022 at 10:53 PM Liam Beguin <liambeguin@gmail.com> wrote:
>
> The approximation caused by integer divisions can be costly on smaller
> scale values since the decimal part is significant compared to the
> integer part. Switch to an IIO_VAL_INT_PLUS_NANO scale type in such
> cases to maintain accuracy.

...

> +               tmp = 1 << *val2;

Unfortunately, potential UB is still here. I think you missed a subtle
detail in the implementation of BIT()/BIT_ULL(). Let's put it here:

  #define BIT(nr) (UL(1) << (nr))

where

  #define UL(x) (_UL(x))
  #define _UL(x) (_AC(x, UL))

For non-assembler case

  #define __AC(X,Y) (X##Y)
  #define _AC(X,Y) __AC(X,Y)

Now you may easily see the difference.

...

> +               rem2 = *val % (int)tmp;
> +               *val = *val / (int)tmp;
> +
> +               *val2 = rem / (int)tmp;

Hmm... You divide s64 by 10^9, which means that the maximum value can
be ~10^10 / 2 (because 2^64-1 ~= 10^19), but this _might_ be bigger
than 'int' can hold. Can you confirm that tmp can't be so big?

-- 
With Best Regards,
Andy Shevchenko
