Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17C753FAFD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240718AbiFGKPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240714AbiFGKPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:15:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2A6C9EE2;
        Tue,  7 Jun 2022 03:15:46 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b8so5644331edj.11;
        Tue, 07 Jun 2022 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+awy/jtO8AUSyEBXiUnjG28q5KgwJhjAtwiUMCK/4w=;
        b=L3g0r5og4iLcJkkaEnjJHC/fhgX0jgWCgjdPwNSjvuL4JmDM2PWcq+cK6d7tvMwngt
         rk4aq2qJmnK6TrGT6S3H5o+TSva2V00FG4u6C09YxTViVZMaP/mXJpeI4hFUjdX3AMTD
         BZXZQeJA5f2MF1rFLU3FqEyOof9t+9zhtl88KuxHRQr9+WwSKSYTv6i2RL3epictTjND
         SSIwrFpntInEwrtWc+5RW1ry6f0lI9fAHDzt2J0LHugPhrdxaKu++qyiccv+C2Q5Z1Wk
         3r/gxSK2dBPaHhzxasbLsBbsvvaYCLsJAZAZmDYEK6LY+sbv6f0U9X0G9mAoucthsmvj
         qktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+awy/jtO8AUSyEBXiUnjG28q5KgwJhjAtwiUMCK/4w=;
        b=qmoX0/ClmkAA5IsjSiw9aS6SSspUcEXlTZqlE0FU/q9lhC4+YTWQEDAQmWA9fZOOOf
         8IhiwbCdDvM+b5nZeJq4C+JYl0TB42ZaNARcWQhS+ie1Mr9xVyYJijoAkLk+yz/tuBke
         ZH1p7/+fEgpwvFr51Ba0QM1X5RpTLuhvtxOe77zkz5Ue5FmlRUKWRqTf/E+GV+8mURLK
         g39b/Fv8kBvrFEjyUafF5HQf/9MUVtd38mJHZL6IsvLe7FlZ4bnj8NszSJ0QWo9vooDl
         FqubAK/DoV1dnTmk3CR9Cpo1394ibq/y/1ZM8RadBmSKNuN5LS8Yb0zPs2jmDH+PFsl6
         japA==
X-Gm-Message-State: AOAM532K4Zr6ufOU/hGTKOWkX5oXApeU6RidyygdSYnbBiAIdNu3RUP/
        mOx00+O/v/1FpxtQXTnxUqkr++hpXosUxYx5JCV2XdFTSK+4bQ==
X-Google-Smtp-Source: ABdhPJyHYBcSP5L+e+/lCSODW1yjbbo+X5QJlKf3rSU0nvX/kDIYub8oTpUy0R8kwHX6UVI3UHMZpAE4KZY3EUJ7Iio=
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id
 o16-20020a056402439000b0042e0b7ee9acmr31240221edc.97.1654596944770; Tue, 07
 Jun 2022 03:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220529134605.12881-1-trix@redhat.com>
In-Reply-To: <20220529134605.12881-1-trix@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 7 Jun 2022 12:15:08 +0200
Message-ID: <CAHp75VeZSU5i1k6W1dgE4kOW5wfRM-jJvmPvi8wCdqQeFVtRbQ@mail.gmail.com>
Subject: Re: [PATCH] serial: core: check if uart_get_info succeeds before using
To:     Tom Rix <trix@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
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

On Sun, May 29, 2022 at 4:09 PM Tom Rix <trix@redhat.com> wrote:
>
> clang static analysis reports this representative issue
> drivers/tty/serial/serial_core.c:2818:9: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
>         return sprintf(buf, "%d\n", tmp.iomem_reg_shift);
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> uart_get_info() is used the *show() functions.  When uart_get_info() fails, what is reported

in the ?

> is garbage.  So check if uart_get_info() succeeded.

...

> -       uart_get_info(port, &tmp);
> +       if (uart_get_info(port, &tmp))
> +               return 0;

I don't think this is correct. If something fails we need to inform the caller.

I think more about

int ret;

ret = uart_get_info(...);
if (ret)
  return ret;

But I haven't looked at the uart_get_info() implementation, so the
above might be wrong.

>         return sprintf(buf, "%d\n", tmp.baud_base * 16);

Ditto for the rest.

-- 
With Best Regards,
Andy Shevchenko
