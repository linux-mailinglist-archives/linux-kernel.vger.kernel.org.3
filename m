Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81048CD2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357682AbiALUlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357703AbiALUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:41:29 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBFCC061751
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:41:28 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l16-20020a17090a409000b001b2e9628c9cso7223830pjg.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HNujz4kMn/4ZYTwXUR+Cc+AqJUJ4Ie/adlWgWAXYdZk=;
        b=SmJAOBbclolNCR4/WQY3wyRsLI85oupsTeOu9LOt9vSC5HiQAMxNXfzvA7yy3FBCGB
         35X6KTCaN31AAH6idR4U8F7uMgnqLiGqgGWsrmjEPPmLzriTAUcLerL8wEkUYje3WbHR
         uM5yTYIoJrmMhJUCdoWwnqh8mvprQEZEm9S/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HNujz4kMn/4ZYTwXUR+Cc+AqJUJ4Ie/adlWgWAXYdZk=;
        b=8F56LiebhL0aEczZk9QRw9clI6T1g6uuLRw1nbGKnFuxsgjTPNzxfkeLQoNYkNgUiP
         o1LdEcfWu/eqDo0uyYpOZyGGmuXEJB5GUZsUNuzF0Se6s8+ITOHmrzz6yGn553M2FIpL
         +u69VpTZAK6nOJfggpYMOjPIrGUdcm2Gwbs0fnh1g16j25uoP2qVpAyc0hhqNBKF/E9p
         F6MR22zgLdFl8JVFxTuDtf05s1gzw7py01d4AWOliXXu3hpbepughMCyMmBVxlk34ScC
         ae7p1tYOyeJyF2CyivZZkxwUt82uEBrCD5CWYVmN9YP0gESctU9l7SqtRbcNueu5aKIX
         u/CA==
X-Gm-Message-State: AOAM53362C/RGyX6VDqZ9xX+abApVE/qfXmXm4SN0tFHKkbWxoQcFzy2
        DkFwk+xnpBLGZ4M60VHkTX8sRQ==
X-Google-Smtp-Source: ABdhPJxGbGIvRCR4uqhdWUJhCVeb456pVbNeu0tJOoom887A81IdKzyVCWxxFk0xewSvT4GkX/QL8A==
X-Received: by 2002:aa7:93ba:0:b0:4bd:bbca:1936 with SMTP id x26-20020aa793ba000000b004bdbbca1936mr1056122pff.43.1642020088302;
        Wed, 12 Jan 2022 12:41:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id on16sm486616pjb.9.2022.01.12.12.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:41:27 -0800 (PST)
Date:   Wed, 12 Jan 2022 12:41:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Ralph Siemsen <ralph.siemsen@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] eeprom: at25: Restore missing allocation
Message-ID: <202201121240.C9A4613D36@keescook>
References: <20220107232409.1331599-1-keescook@chromium.org>
 <CAHp75VdqK7h63fz-cPaQ2MGaVdaR2f1Fb5kKCZidUG3RwLsAVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdqK7h63fz-cPaQ2MGaVdaR2f1Fb5kKCZidUG3RwLsAVA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 01:36:12PM +0200, Andy Shevchenko wrote:
> On Sat, Jan 8, 2022 at 1:01 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Building under CONFIG_FORTIFY_SOURCE=y and -Warray-bounds complained about
> > strncpy() being used against an empty object. It turns out this was due to
> > the at25 allocation going missing during a conflict resolution. Restore
> > this, and while we're here take the opportunity to do another strncpy()
> > replacement, since it's use is deprecated[1].
> >
> > Seen as:
> >
> > In function 'strncpy',
> >     inlined from 'at25_fw_to_chip.constprop' at drivers/misc/eeprom/at25.c:312:2:
> > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> >    48 | #define __underlying_strncpy    __builtin_strncpy
> >       |                                 ^
> > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> >    59 |         return __underlying_strncpy(p, q, size);
> >       |                ^~~~~~~~~~~~~~~~~~~~
> > In function 'strncpy',
> >     inlined from 'at25_fram_to_chip' at drivers/misc/eeprom/at25.c:373:2,
> >     inlined from 'at25_probe' at drivers/misc/eeprom/at25.c:453:10:
> > ./include/linux/fortify-string.h:48:33: warning: '__builtin_strncpy' offset [0, 9] is out of the bounds [0, 0] [-Warray-bounds]
> >    48 | #define __underlying_strncpy    __builtin_strncpy
> >       |                                 ^
> > ./include/linux/fortify-string.h:59:16: note: in expansion of macro '__underlying_strncpy'
> >    59 |         return __underlying_strncpy(p, q, size);
> >       |                ^~~~~~~~~~~~~~~~~~~~
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings
> 
> Thanks!
> With or without the below comment being addressed
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks!

> 
> > Fixes: af40d16042d6 ("Merge v5.15-rc5 into char-misc-next")
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Jiri Prchal <jiri.prchal@aksignal.cz>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/misc/eeprom/at25.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> > index c3305bdda69c..1a19fa5728c8 100644
> > --- a/drivers/misc/eeprom/at25.c
> > +++ b/drivers/misc/eeprom/at25.c
> > @@ -309,7 +309,7 @@ static int at25_fw_to_chip(struct device *dev, struct spi_eeprom *chip)
> >         u32 val;
> >         int err;
> >
> > -       strncpy(chip->name, "at25", sizeof(chip->name));
> > +       strscpy(chip->name, "at25", sizeof(chip->name));
> >
> >         err = device_property_read_u32(dev, "size", &val);
> >         if (err)
> > @@ -370,7 +370,7 @@ static int at25_fram_to_chip(struct device *dev, struct spi_eeprom *chip)
> >         u8 id[FM25_ID_LEN];
> >         int i;
> >
> > -       strncpy(chip->name, "fm25", sizeof(chip->name));
> > +       strscpy(chip->name, "fm25", sizeof(chip->name));
> >
> >         /* Get ID of chip */
> >         fm25_aux_read(at25, id, FM25_RDID, FM25_ID_LEN);
> > @@ -440,6 +440,10 @@ static int at25_probe(struct spi_device *spi)
> >                 return -ENXIO;
> >         }
> >
> > +       at25 = devm_kzalloc(&spi->dev, sizeof(struct at25_data), GFP_KERNEL);
> 
> I would use sizeof(*at25) but I think you restored the exact context.

Yeah, I just restore the chunk exactly as it was.

Greg, should I send a v2 with this adjusted?

-Kees

> 
> > +       if (!at25)
> > +               return -ENOMEM;
> > +
> >         mutex_init(&at25->lock);
> >         at25->spi = spi;
> >         spi_set_drvdata(spi, at25);
> > --
> > 2.30.2
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

-- 
Kees Cook
