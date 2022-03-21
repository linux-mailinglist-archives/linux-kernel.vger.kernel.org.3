Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF144E2F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351986AbiCUSGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351980AbiCUSGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:06:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4C015CB6D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:05:07 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z16so16185128pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VSE/zjzMF4GUAODi9hUWbSKALcdRpi7FbYvoQ5n/zHE=;
        b=fcyAfSP5auLlxa8uxnRYod/EMf7JE1qAALckx8tRF9JKQppHhU9QysjLogLKyxYU6a
         2R0dvGNpSM3MjBR8fOWEDbotvhLJ42Pxjh1OR471p6ss5wu8DTreSiar/deSJfqS5Bz0
         ZJrDvhsTfX+rv0DePsGh8eO9zBQS5Q1E1B9m1Dl2X5V7XOPM9zbO8xspgoNJrJraHldJ
         0/lC1CNncq0xlOpMy1ldeuil3tJ8rYv0pzU/bwMTuDCOBr8j27BAiw2yTlVByaNLzcAH
         MBY/ZTGVla0e3oHRwwiI3404xKCORRZ7UC0HAgiiacCLYjqVGDFCnIPNgeysH1TGdgfN
         R6lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VSE/zjzMF4GUAODi9hUWbSKALcdRpi7FbYvoQ5n/zHE=;
        b=ZpfmML6g/mh2DhCejk0y/rEVZFcJMwCWNLht8b3cgNXQ2kS4nWNfxl047rhDhWVCoF
         Z1Z69U2qoqoV5tL7l5ZnmngySCLjEfJ9CRzBoxtH1dB8CBR+JxMqixNF2luS82a1Ad/W
         oTdKDQQNooZcJLoMYGPU45oBkvTA6rBYQnSpudzLNOSq2AVcbRolLAzPL2rnASzpKbHd
         Vgejidnw+lgKQaknbJ75GpNOnRe+MkPaRjac1ddvssxh7+o8jYtV5PKFB3UtaLHxOvFy
         fcBUOrSoCdRbvyQEvd4V7XaauoalCcLWvBVYuEBJPMPnkARngxnCuLh7UHjJ8Zey/uO4
         dRgA==
X-Gm-Message-State: AOAM531c58B38ZlBLZtKcSi4H3kikQNTRuPWMnFOLSrqwfQ1O9Oz2oT7
        ACGe9RgBrM/jMP5bLZyCn5d89Fu1p47A/HRk+/pf
X-Google-Smtp-Source: ABdhPJxhYv/ZbgyMx8y9NX4YnmX8FOmzPsTIfGrBazZdrmJADnDkiyJf7MEXQnfVPRrCwcTuhFqiH2ta2wyZE1ZbcL4=
X-Received: by 2002:a63:1613:0:b0:382:2a7f:5ca1 with SMTP id
 w19-20020a631613000000b003822a7f5ca1mr13980696pgl.151.1647885906868; Mon, 21
 Mar 2022 11:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220316213055.2351342-1-morbo@google.com> <20220319222228.4160598-1-morbo@google.com>
 <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
In-Reply-To: <CAHk-=wh4B42bYZmGoY8=UsqHDuq_th2KN7TmXuTnhwyYWzQ5pg@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 21 Mar 2022 11:04:55 -0700
Message-ID: <CAGG=3QWPAF4wtb93LJiv5Hz1pM+dvwM1+NNG8cr7813k-gpUTA@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: acpi: use correct format characters
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 3:55 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So I think that clang warning is only annoying, not helpful, but:
>
> On Sat, Mar 19, 2022 at 3:22 PM Bill Wendling <morbo@google.com> wrote:
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index a5495ad31c9c..92dd9b8784f2 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -388,9 +388,9 @@ static acpi_status acpi_gpiochip_alloc_event(struct acpi_resource *ares,
> >
> >         if (pin <= 255) {
> >                 char ev_name[5];
> > -               sprintf(ev_name, "_%c%02hhX",
> > +               sprintf(ev_name, "_%c%02X",
>
> This part I approve of.
>
> >                         agpio->triggering == ACPI_EDGE_SENSITIVE ? 'E' : 'L',
> > -                       pin);
> > +                       (unsigned char)pin);
>
> But this cast seems pointless and wrong.
>
You're right. I was trying to ensure that the patch didn't change
behavior. But the cast achieves nothing. Thanks!

-bw

> Casts in general are bad, and should be avoided unless there's a real
> reason for them. And that reason doesn't seem to exist. We don't
> actually want to truncate the value of 'pin', and just a few lines
> earlier actually checked that it is in range.
>
> And if 'pin' can't be negative - it comes from a 'u16' table
> dereference - but even if it could have been that would have been a
> different bug here anyway (and should have been fixed by tightening
> the check).
>
> So the cast doesn't add anything - not for humans, and not for a
> compiler that could just optimize it away because it saw the range
> check.
>
> End result: just fix the pointless 'hh' in the print specifier. It
> doesn't add anything, and only causes problems. Anybody who uses '%02X
> to print a byte should only use it for byte values - and the code
> already does.
>
> Of course, the _reason_ for this all was a warning that was pointless
> to begin with, and should never have existed. Clang was not smart
> enough to take the range knowledge that it _could_ have taken into
> account, and instead wrote out a completely bogus warning.
>
> It's completely bogus not just because clang didn't do a sufficiently
> good job of range analysis - it's completely bogus because a 'varargs'
> function DOES NOT TAKE arguments of type 'char'.
>
> So the *only* reason to use '%hhX' in the first place is that you
> *want* the sprintf() to actually limit the value to a byte for you
> (possibly because you have a signed char, know it will sign-extend to
> 'int', and want to limit it back to 8 bits).
>
> If you *actually* had a 'unsigned char' to begin with, you'd be
> completely insane to use %hhX. It's just pointless.
>
> So warning that '%hhX' is paired with an 'int' is all just completely
> mindless and wrong.
>
>               Linus
