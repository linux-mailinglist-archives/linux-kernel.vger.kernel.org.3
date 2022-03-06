Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5E84CEE22
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiCFWVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCFWVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:21:01 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA712AB3;
        Sun,  6 Mar 2022 14:20:08 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qx21so28141024ejb.13;
        Sun, 06 Mar 2022 14:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t7cCKN/grIlDzxZe3323XIBV7lMKhMz1VElpS8eUsnk=;
        b=IXP8154F0LChfJ4IOVDCrzDOaDuBPvscSbF688LBkwWMTDFANWLPQhGF/3GSGd4VUZ
         AFwImp6teOFafDqbjS7u/7U8/PcMjFJC81so5oK71Akqs+jw80EK0ym8d5OCKXS6Tbrf
         X7yRPAlgGaRcdAhZwm8V9mNtNcGOQJf76KmM+Fw5eKnVg/PnHeOsXDE6vCgRoDTew5Z4
         5w6FqWq0KYM21mxMIm6QqDuTtJFHlytrc3lQqqJhV723y5d4SI7JuLZT4Dp929Rvv259
         9hyk63uXbUs0zQ/0KWnAsrqrFHYMvtSmfzyuKBvemFTxRPsu7qC2b+nDUqLis7kuU2Kw
         mvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t7cCKN/grIlDzxZe3323XIBV7lMKhMz1VElpS8eUsnk=;
        b=lz1+FgtuOE30r/NNU+j99pKQh5KupMlPjRV+k1yZcJxWq6d2DCxPag6XKy4GI1H1ru
         UwyZNh9Pg+muuSXd8R4CcMTPTV5aCAF/05dkMIeuSZMqWSgO5ROoucVjy9vXBqMSdl3W
         9dlTVQLcNzyd6+nI3B3UIpGuWNJjZZX4EFoaujOms1T0cj3k7rrvxmLZrqmSozs+23F/
         QSNGwGm4/NE0zFNlrl6LNtmi/i9LRIPNRDfFcwPO51D+WUQwATzdv9lCDxQMp0l1YDLc
         yKSX/l9Z0I4Qiab5log9zNjh7RlE299cUby2gaMZ5qlIn3prerLIyuBNcxFJtZZO7jhZ
         O+NQ==
X-Gm-Message-State: AOAM533k4/62hf7Ut7iRCR6b8LXdcNqkO+o53TpMaS5pJfxQ8FBnqwUx
        pJxC4AhVdN7KeZebHQG2e5WM1jjuLEE2SLVtvso=
X-Google-Smtp-Source: ABdhPJxPgVRkC/Yq5Uns3ZeTams1DgSElaulFcfNHjcAnYMB2quGz/MtwoImbZbPdf4zLI/TaaMvcA2rtV7TMqHHjTs=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr7182609ejc.132.1646605206814; Sun, 06
 Mar 2022 14:20:06 -0800 (PST)
MIME-Version: 1.0
References: <20220306193420.99714-1-brgl@bgdev.pl>
In-Reply-To: <20220306193420.99714-1-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 00:19:30 +0200
Message-ID: <CAHp75Vfgsa5Ru5aA7Bx_mV--h-GFKSX9Uocf+njvh8Rc1yNTow@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: check for overflow when reading the 'ngpios' property
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Mon, Mar 7, 2022 at 12:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> The ngpio fields both in struct gpio_device as well as gpio_chip are
> 16-bit unsigned integers. Let's not risk an overflow and check if the
> property value represented as a 32-bit unsigned integer is not greater
> than U16_MAX.

...

> +               if (ngpios > U16_MAX) {
> +                       ret = EINVAL;
> +                       goto err_free_descs;
> +               }

I don't think it's a fatal error in this case. I would perhaps print a
warning and simply use a masked (which is done implicitly by an
assignment of the different type) value. Note, the above is buggy on
the buggy DTs, where the upper part of the value is not used. After
this patch you effectively make a regression on, yes, broken DTs.

-- 
With Best Regards,
Andy Shevchenko
