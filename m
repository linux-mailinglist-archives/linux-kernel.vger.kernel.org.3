Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE094D45A5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 12:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241573AbiCJL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241561AbiCJL2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 06:28:35 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D309FF2;
        Thu, 10 Mar 2022 03:27:33 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id hw13so10902884ejc.9;
        Thu, 10 Mar 2022 03:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxa1NnYR8j/XIXPuu7RmPrFzq9a1elgEFCKBxJFkaXg=;
        b=qUKlqVEZnqn1N7FpHgDzNtb/hZ7AEY/iMZMM7wvYiebLHkLcSBbJE/ajxNJyIsIHQy
         tD/vkytpLlRW+wbOXO/8Ds14p/vYqYGwSsMXUPBbPrIPk12ng9SasCzw2SR+RzVi5GIl
         gvWTpPFLTrmVwvUQu/Qa1bpYLEpQ1LoZTOtUcAQYeScnp1sccGhLdWB5EBWWDwgcoiTz
         XbF/UHVzFs9uslDe/YvkPMmOZNOzAIiqKdUHeNTaXywB7ipe++9lvNrbBJPSiQcGTa9n
         HDvSWCdCEGme+p/qHWNDb7XRFYqAR1xAkchFAm3a1KDDGmyrzKObzBqL+atoNAad3HDY
         Uojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxa1NnYR8j/XIXPuu7RmPrFzq9a1elgEFCKBxJFkaXg=;
        b=Nz372D0Czp07VOc0ZzV07NeAuWam7qJYV2Rorz16LjXQUd2SAXK2/soKLPW3es1bAs
         h0yw3UqiAcC7sLXVTLpKDscRXTptrIqZCGV048NnqTyH3HmPN50z1Pn+rcfqKLWf24yz
         gnrjw4wOCuFdaNHVbEu+3eLcRQiws7AWcKIjXwQ7IcuukkXkibqT/OBF4QWXJeQpzXSf
         iuzWhQK7c8rNRhHgPvR71TZnCI995L21JBXRtjW5E8RBZvbjNhlz0o3Nfrh8bXCQ8nVo
         LWO1fOrd/nsyuC+lKi2IBIcgUI4Dql3CsX4093FHuyxctUZD11hNz6gV7PtuQGiXo04X
         Pmmw==
X-Gm-Message-State: AOAM532iqLxxl2qz0KgiYESPfG//tSVcQk4FsO6z2D3ZlLsAzKUbumAS
        fVe/8NusVK1pIVNZJq/pVqTCBip5fbbIs3Ovi6U=
X-Google-Smtp-Source: ABdhPJyyd+NMDS+SKxCCsV3dOGCg1IgjK7szmEs2qpr9CGv91olzYG09zyTWZ66vBMEOpZBzJvjdBH71djZU7RUt6Wg=
X-Received: by 2002:a17:907:6e01:b0:6d0:562c:e389 with SMTP id
 sd1-20020a1709076e0100b006d0562ce389mr3801168ejc.497.1646911652222; Thu, 10
 Mar 2022 03:27:32 -0800 (PST)
MIME-Version: 1.0
References: <20220308181847.3276-1-kris@embeddedTS.com>
In-Reply-To: <20220308181847.3276-1-kris@embeddedTS.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 10 Mar 2022 13:26:56 +0200
Message-ID: <CAHp75VcOuJxeDobrGMMAjF92hcCxefmswHQyuUv4sF5FEU2m9w@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ts4900: Do not set DAT and OE together
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
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

Bart, side note: I can't see your for-current in Linux Next for a few
days, is everything okay?

On Wed, Mar 9, 2022 at 1:47 AM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> From: Mark Featherston <mark@embeddedTS.com>
>
> This works around an issue with the hardware where both OE and
> DAT are exposed in the same register. If both are updated
> simultaneously, the harware makes no guarantees that OE or DAT

hardware

the OE

> will actually change in any given order and may result in a
> glitch of a few ns on a GPIO pin when changing direction and value
> in a single write.
>
> Setting direction to input now only affects OE bit. Setting

the OE bit

> direction to output updates DAT first, then OE.
>
> Fixes: 9c6686322d74 ("gpio: add Technologic I2C-FPGA gpio support")

>

There must be no blank lines in the tag block.

> Signed-off-by: Mark Featherston <mark@embeddedTS.com>
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

...

> + * Copyright (C) 2015-2018 Technologic Systems

Not sure it's a valid change for a simple fix.

...

> -       /*
> -        * This will clear the output enable bit, the other bits are
> -        * dontcare when this is cleared
> +       /* Only clear the OE bit here, requires a RMW. Prevents potential issue
> +        * with OE and data getting to the physical pin at different times.
>          */

Keep the proper style for multi-line comments.

...

> +       /* If changing from an input to an output, we need to first set the
> +        * proper data bit to what is requested and then set OE bit. This

the OE bit

> +        * prevents a glitch that can occur on the IO line
> +        */

Keep the proper style.

-- 
With Best Regards,
Andy Shevchenko
