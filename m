Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3164FD80B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbiDLJlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389932AbiDLJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:24:22 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9482926ADB;
        Tue, 12 Apr 2022 01:39:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v15so11409831edb.12;
        Tue, 12 Apr 2022 01:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/h7cVVserNqUb3YyYC9xHnLSaItStAPV1/7k0c5Uc38=;
        b=oG8NoJx4rLD9iGB0rQxfTkpmikuRl+uEX+dLf92eoRrPh4Q24PCaTFMW1AFyeeivWy
         FE8UrS0Hw5PfWqz8a0nGjS9cgQm/FJEanbo+cymkkBhKyN3LGfhZd8lQzwmV0CG0QlLu
         JaZSRc9WIH0ciykVTxVkrKBd//oOTyAtMTswBUBR6JLNfN6luY49Bkr+2dEdP7ZBncjT
         IfGB3ZL+tu35IfSPKXgXin7U6TV9E4mDRav9UxXaR9yjfqesOHZpqwKf/5simE2mXwvY
         4Ra4OolPViSeDmqopUG8JLhPBFFHA9DQiQYclEksF+R2QtzOiUaErAL/FUHzWBGMGiHg
         JhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/h7cVVserNqUb3YyYC9xHnLSaItStAPV1/7k0c5Uc38=;
        b=CoZj2IN6JjeFsqA4rhQt4e4OAjUi0VZvcdQXjWy0EwoAhAJYOLWNL2Bj5ZAregy8im
         hWbxN2QlOXbXSBc6IcajWb8dWL90eYxEAX9W+SXzaCqJA/CzU5m3j79t34wp/F4PyUAp
         Zn/Lbzx9egHOh3GmqvdtINRW/hXCxL+hH4hThXiV677O20b4sGprgDayTSLc8o4f3qP0
         dWeq6HPlKwNs+mm3SKAwIDQbIrj0ZpzNHaPKVUzJ/ApXQo0zvgpDh2Grt4/p7+lQ15he
         7aLCQesDBSlbQKBf8Tbt/Uuwk8CuisoTESLXjbas4lHh3+8mNmTaeS1pt3oYnLgEUOyy
         cqPA==
X-Gm-Message-State: AOAM531ks29yoY4nUmdtqDf+cf1OutsDnY+naNPyj3TcDrZoTe/C7835
        2+9CmCafO1sSj9g9Juo+SGl6cXqmx1P78ZGDIKo=
X-Google-Smtp-Source: ABdhPJz9T3JpupKlqRf7GpnslB1SuvXlu2IUplRT6C7G/KJGAAneW539NGav1r0nAc5Zm8hYK3IeM1NR9WozbXE5Nzs=
X-Received: by 2002:a50:fe19:0:b0:41d:84be:6541 with SMTP id
 f25-20020a50fe19000000b0041d84be6541mr6395337edt.270.1649752790968; Tue, 12
 Apr 2022 01:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VePiCm6wH7aXcbnrt-4nntqx99s45wYk3+C2AKs=Usang@mail.gmail.com>
 <20220412070355.139507-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220412070355.139507-1-andrei.lalaev@emlid.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 11:35:38 +0300
Message-ID: <CAHp75VceMuo8u5FpMvtg_YgZwEYbSJ2JCa4DXLvBRfC7c-ZAkg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
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

On Tue, Apr 12, 2022 at 10:13 AM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:
> On Mon, Apr 11, 2022 at 7:55 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

...

> > On top of that, it would be nice to be sure that at least all current
> > in-kernel users (meaning all DTS provided so far by the kernel) do
> > interpret it as start,size.
>
> I checked the DTS and only 36 of them use "gpio-reserved-ranges".
> The 33 of them use tuple with the second element that is less than the first.
> So it means that the maintainers interpreted it as "start,size".
>
> And only 3 of them use one tuple with the second element is greater than the first.
> The list of this DTS:
>     1. arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
>         AngeloGioacchino Del Regno added it in the commit 9da65e441d4d
>         ("arm64: dts: qcom: Add support for SONY Xperia X Performance / XZ / XZs (msm8996, Tone platform)")
>         But in another commit 8b36c824b9a77 ("arm64: dts: qcom: sdm630-xperia-nile: Add all RPM and fixed regulators")
>         he clearly interpreted it as "start,size" because the second element
>         is less than the first.
>
>     2. arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dts
>         The same maintainer as for the previous DTS.
>         He added "reserved-range" in the commit 122d2c5f31b6e
>         ("arm64: dts: qcom: Add support for MSM8998 F(x)tec Pro1 QX1000")
>
>     3. arch/arm64/boot/dts/qcom/sa8155p-adp.dts
>         Bhupesh Sharma added it in the commit 12dd4ebda47ab
>         ("arm64: dts: qcom: Fix usb entries for SA8155p adp board")
>
> Should I ask these maintainers how they interpreted this property?

Ideally it would be nice to have their responses. Meanwhile...

> > Otherwise this will be an (unacceptable) ABI change and hence documentation
> > would need to be fixed with variable names in the code
>
> I want you to notice that "of_gpiochip_init_valid_mask" uses "bitmap_clear"
> that clears "nbits" bits starting from the "start". So it can't be interpreted
> as "start,end". That's why I think everyone interprets it as "start,size" because
> it works like "start,size" and the documentation tells it is "start,size".

...meanwhile try to compress above into a few sentences and put it to
the commit message explaining that the de facto use of the values
seems as start,size and questioned DTSes have been asked for an
explanation from the current maintainers.

I'm now 99% confident that your patch is correct.
Thanks for doing all this analysis.

-- 
With Best Regards,
Andy Shevchenko
