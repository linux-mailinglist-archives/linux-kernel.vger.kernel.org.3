Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A1D4A4A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379386AbiAaPZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241253AbiAaPZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:25:27 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A946CC061714;
        Mon, 31 Jan 2022 07:25:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id s5so43952856ejx.2;
        Mon, 31 Jan 2022 07:25:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZpTwQbsdQIcLvs0GlHH3Sy9+qB+TTqkyu/4auTBwhQ=;
        b=f0fdBDvc/U0tP++/HdZQemlXc5Mq7TuJC6L5B16+S8XxtkWozVEXPG60N5l4KvLj/A
         vWEeGNcz+WrKjT5UHPfxOOaSSxW8KrvSCivTUJX6WQheF15Y2UrEMD0EHp9jgo6CqfAj
         BALXi09sH1qvWNanWt8WNt9PeyUoCxs1cbcgrdZslIhiDAzhla9MMgzEabvEu9qODgC1
         wikwe56XB4jEuEcVsXOnOlXHvkhdspnj4SA7zimG+Sf7XFxEX9lZTl5NQa3oLNNyQpG+
         k7ZoBEL2/xrsijdkCLUrzMNCspI8CGUT1InHQ2zouEv1aAZ4LyZkuIRj43H0SfyxaFSo
         4UDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZpTwQbsdQIcLvs0GlHH3Sy9+qB+TTqkyu/4auTBwhQ=;
        b=JnsnpGSQLn3P3E6hE4fFw4rWWM7YxsNn3aUAweMTPqUg5X13tMqfiVneT+nFUWQPi9
         xXnBH0QpYlBRIyWe4oQdlGlbpFwsxyrylncM72VvLTLhWm1z53RgnXTALfypOo8iqNvi
         KSbuu0BP/APCF06QEWujGzSPuJimFGKQytmTrcV0wmtP7gmrAAHfN75loRMJs2E7a76M
         0tXJXbseFEG0T+KI8CK0GjqaWhIfJWG0YyFzyOMF3tLvsYze4rk7I3M3p2th1xy9B8/F
         bN2ZkCGryBXw4f82YDQFcYjJSXLyN7lHe0nRzmVY4evL8XlmJLvqtJv+UdZ6Pdu8Qfzl
         6TvQ==
X-Gm-Message-State: AOAM533LMQgnZeOaUnserf9JpCVljBoJK1NBCGfztuSn8j3DX2Uf2Mra
        04HlF2+2+KkoWVePTp/xzTh4KR6HNhyzAhBp3hU=
X-Google-Smtp-Source: ABdhPJz2/6sFMRc13j6S/0wictvBM+DewEiYKr5lNQLfSjtAj/yXj0gmr0pBEwXlu51A+QFCE7VGXQwXTLeWjM6cHHU=
X-Received: by 2002:a17:906:c14d:: with SMTP id dp13mr17906272ejc.132.1643642724327;
 Mon, 31 Jan 2022 07:25:24 -0800 (PST)
MIME-Version: 1.0
References: <20220130161101.1067691-1-liambeguin@gmail.com>
 <20220130161101.1067691-7-liambeguin@gmail.com> <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
In-Reply-To: <5da96dc7-696b-1bc0-a111-f6108ecfa54c@axentia.se>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 31 Jan 2022 17:23:47 +0200
Message-ID: <CAHp75VcDMfnkRvh5Rmxqc_R0ML5Eq4GCFL_QAkess7OLAQkg7w@mail.gmail.com>
Subject: Re: [PATCH v13 06/11] iio: afe: rescale: make use of units.h
To:     Peter Rosin <peda@axentia.se>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 4:50 PM Peter Rosin <peda@axentia.se> wrote:
> On 2022-01-30 17:10, Liam Beguin wrote:

...

> > -             tmp = div_s64_rem(tmp, 1000000000LL, &rem);
> > +             tmp = div_s64_rem(tmp, GIGA, &rem);
>
> It is NOT easy for me to say which of GIGA/NANO is most fitting.

What do you mean? The idea behind is the use of the macro depending on
the actual power of 10 in use (taking into account the sign of the
exponent part).

> There are a couple of considerations:
>
> A) 1000000000 is just a big value (GIGA fits). Something big is
>    needed to not lose too much precision.

Does it have a physical meaning?

> B) 1000000000 is what the IIO core uses to print fractional-log
>    values with nano precision (NANO fits). This is not really
>    relevant in this context.

Same question.

> C) 1000000000 makes the int-plus-nano and fractional-log cases
>    align (NANO fits). This last consideration is introduced with
>    patch 4/11.
>
> There is simply no correct define to use.

Huh?!
I believe the answer to the A and B -- yes, which means there are the
correct and incorrect variants to use.

> And whichever define is
> chosen makes the other interpretation less obvious. Which is not
> desirable, obscures things and make both GIGA and NANO bad
> options.

The (main) idea of the macros is to avoid mistyping 0s in the numbers
and miscalculations. Besides that it also provides the same type for
the constants.

> So, I stepped back to the description provided by Andy in the
> comments of v11:
>
> On 2021-12-22 19:59, Andy Shevchenko wrote:
> | You should get the proper power after the operation.
> | Write a formula (mathematically speaking) and check each of them for this.
> |
> | 10^-5/10^-9 == 1*10^4 (Used NANO)
> | 10^-5/10^9 == 1/10^-14 (Used GIGA)
> |
> | See the difference?
>
> No, I don't really see the difference, that just makes me totally
> confused.

Sounds like we have a chat here between physicists and computer
science folks :-)

Let's try again, does the value in the tmp variable above have a
_physical_ meaning? (I believe so, because all IIO subsystem is about
physical values)

> Dividing by 10^-9 or multiplying by 10^9 is as we all
> know exactly the same, and the kernel cannot deal directly with
> 10^-9 so both will look the same in code (multiplying by 10^9).

Yes, and using proper macro makes much cleaner the mathematical and
physical point of view to the values.

> So,
> you must be referring to the "real formula" behind the code. But
> in that case, if the "real formula" behind the (then equivalent)
> code had instead been
>
>         10^-5*10^9 == 1*10^4 (Used GIGA)
>         10^-5*10^-9 == 1/10^-14 (Used NANO)
>
> the outcome is the opposite. NANO turns GIGA and vice versa.

Again, one needs to think carefully about the meaning.
That's the point. If we do not understand the proper values and their
scales, perhaps that is the issue we should solve first?

> Since you can express the same thing differently in math too, it
> all crumbles for me. Because of this duality, it will be a matter
> of taste if GIGA or NANO fits best in any given instance. Sometimes
> (perhaps commonly) it will be decidedly easy to pick one of them,
> but in other cases (see above) we will end up with a conflict.
>
> What to do then? Or, what am I missing?

Physical meaning of the values, certainly.

> My taste says NANO in this case, since A) is just some big number
> and not really about units and B) is as stated not really relevant.
> Which makes C) win the argument for me.

...

> >               *val2 = rem / (int)tmp;
> >               if (rem2)
> > -                     *val2 += div_s64((s64)rem2 * 1000000000LL, tmp);
> > +                     *val2 += div_s64((s64)rem2 * GIGA, tmp);
>
> Here, 1000000000 matches the above use. If we go with NANO above,
> we should go with NANO here as well.

Why? (Maybe you are right, maybe not)

...

> SI-defines that are a bit confusing to me.

Yeah, people hate mathematics at scholls, at university, in life...

-- 
With Best Regards,
Andy Shevchenko
