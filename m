Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC9A47A04D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 12:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhLSLFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 06:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhLSLFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 06:05:37 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935B5C061574;
        Sun, 19 Dec 2021 03:05:36 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id j21so22096008edt.9;
        Sun, 19 Dec 2021 03:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D8Wo6P86udUrMcKv2I4dmw18ULaeqRo28Xqqp2K2xN0=;
        b=UbUFPVYlx4sX12Mpz7R3BTcxi8qfwUVrtgG2pa6S7a0iYfvD+3b/RFNoVAWwxKpdqb
         4+9fOPDR64/1sBC/boM/uoKGV5eSpWcJEt0xMunv7u7OEsB5tBxGcQL2Kacf5A9S/S86
         3bugRgCbL69cGzIr0Q75FfT4l93kG4sicmN6MKKMe/YtyVBi9lJf6JZ4e4LE1jVEdm1d
         kwZYc++x+3VCVUV8+oQ+txgs75Q8ur1ZByX/sgS0On+52NRt4lMtIovDtvjrhl2qpLMe
         4X2xXBDPgCUdM2X7SrTBqJC5moRaXohtGKgKkfNU/J2rNTB3eqQY/jd1wTZe5C+8bqGw
         ETWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D8Wo6P86udUrMcKv2I4dmw18ULaeqRo28Xqqp2K2xN0=;
        b=3QEINs0TSfMS76FFggpFo3AnuIbsgJO5AwcvL8eyUU+fwjS3FdhpoF5pNQlRGPq1yY
         bjcS6X4PoAtS5GQhmFwz6R1fC08AYNHmPBtkqZht5KEX7NXUjNHc//iwfSxsJaqW+Bnc
         P3EYJC7+kIO17qW8P0EcdjB/Da3KriYLavF2Qt7ht1fzjeIT0ysdA1kfafPSBOFKdVOj
         2cMYLItZay8JK9iYfJnosQyqaHgxCatWrEqwsbsBnThW0kJtP3y9LgtvKi+91K4l4yBS
         MSkEtzf1Fo0eV1QgB8yWH2yE/FjZQdRXJkHnUaUYKapuxOW/GRXDAHRCi/miuDMdapOD
         RZsg==
X-Gm-Message-State: AOAM533Fr8UvHiDE3CkehsnOkdqbdIywacgkZpWIaoAicS1gT7NXAJtU
        WhpSrEdw/dHd9DqqFMdgAGJuj63NsSIx6b7c2rQ=
X-Google-Smtp-Source: ABdhPJx9pEwuEYJwjhPEdlK1QpzutFYKqEf7NqNjE91fZEuIRc6qKv49xVb9XAff9cZCIcaa6n3KHTRbRBnYu2qnQDg=
X-Received: by 2002:a05:6402:270c:: with SMTP id y12mr11047178edd.258.1639911934984;
 Sun, 19 Dec 2021 03:05:34 -0800 (PST)
MIME-Version: 1.0
References: <20211123164902.35370-1-wsa+renesas@sang-engineering.com>
 <20211123164902.35370-2-wsa+renesas@sang-engineering.com> <YZ024q/r7Hc3TpMt@smile.fi.intel.com>
 <Yb2skaWF7cx6PHLO@kunai>
In-Reply-To: <Yb2skaWF7cx6PHLO@kunai>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Dec 2021 13:04:58 +0200
Message-ID: <CAHp75VcV35r_54FXRGS31VT7W0LV6-U+PJOL46L49ro-T_hp4A@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] gpio: add sloppy logic analyzer using polling
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 18, 2021 at 11:21 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> > > +Result is a .sr file to be consumed with PulseView or sigrok-cli from the free
> > > +`sigrok`_ project. It is a zip file which also contains the binary sample data
> > > +which may be consumed by other software. The filename is the logic analyzer
> > > +instance name plus a since-epoch timestamp.
> > > +
> > > +.. _sigrok: https://sigrok.org/
> >
> > Alas, yet another tool required... (Sad thoughts since recently has installed
> > PicoScope software).
>
> ? For sure, another tool is required. Do you want the analyzer itself to
> output pretty SVG files? :)

I mean that there are similar functionality in different tools and for
one purpose you need one, for another another and there is no format
file convertors available (as far as my shallow googling shows).

...

> > > +   if (ret >= 0 && ret != priv->descs->ndescs)
> >
> > > +           ret = -ENODATA;
> >
> > Don't remember if we already discussed this error code, but data is there,
> > it's not correct. EBADSLT? EBADR? ECHRNG?
>
> In your V1 review, you suggested -ENODATA. I will pick yet another one,
> but it really matters zero in practice.

Ah, okay, then choose the one you think fits most.

...

> > Do we really need the 'probe%02u=' part? It's redundant since it may be derived
> > from the line number of the output (and it always in [1..ndescs+1]).
>
> It makes creating the .sr-file a lot easier. If you feel strong about
> it, then you can later remove it and also update the script, I'd say.

No strong opinion, I don't know the Sigrok tool and its file format,
so I can't tell if it makes sense or doesn't.

...

> > `> /dev/null 2>&1` is idiomatic. And I think there is actually a subtle
> > difference between two.
>
> What is the difference? Does it matter here?

I'm a bit lost in the context here, but the ' > /dev/null 2>&1' means
to redirect stdout to the /dev/null followed by redirecting stderr to
stdout (which is redirected to /dev/null). The other construction
might have side effects IIRC.

...

> > > +                   [ "$chan" != "$elem" ] && [ "$chan" -le $max_chans ] || fail "Trigger syntax error: $elem"
> >
> > No need to execute `test` twice:
> >
> >                       [ "$chan" != "$elem" -a "$chan" -le $max_chans ] || fail "Trigger syntax error: $elem"
>
> I read that '-a' and '-o' are deprecated. Dunno where but looking again
> I found this: https://stackoverflow.com/questions/20449680/boolean-operators-a-o-in-bash

The SO talks about _bash_, your script is a plain Shell one, right?
And for the record, I don't like bashisms in some generic code, like
the one we use with Linux kernel.

...

> > > +   taskset "$1" echo 1 > "$lasysfsdir"/capture || fail "Capture error! Check kernel log"
> >
> > Shouldn't this function setup signal TRAPs?
>
> To do what?

To clean up the garbage it may leave in case of the interrupted run, no?

...

> > $@ is better, actually one should never use $*.
>
> What difference does it make when expanding into a string?

The difference is on how the  "foo bar" (with double quotes!) will be
represented. In your case it will be translated as "foo" and "bar", in
the case I'm saying it will be "foo bar".

-- 
With Best Regards,
Andy Shevchenko
