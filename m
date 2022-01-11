Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9260848A7F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348316AbiAKGv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348300AbiAKGv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:51:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1089C061748
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 22:51:25 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v6so30990714wra.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 22:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IM5W/Do7NMlYTnx0RNfS6RyBqs/1P2u0MCvgsjOndUM=;
        b=d0Y7RgLXgN5yz3ryczwAgNTySCmKqSPTHSORuGWUtAWtZvlfcghl780Hr8UcnjCPNa
         gZo3NBMZm1h/0CF4bnQwxnAaXWC8qp4iwK5lgWWSV6axhbn8+90OfceDsDqdxKjO6TCV
         qpLV5+5pMVd+dJCfe+wY8LDyB2O6BsFBwqtb9oEATAId223gWeDiQrdLgg0SDrAWbF0d
         2CW8uhx0kL37wQaBZ9dla1zSg8XtXNU0csMsKUMeVX3xb0PtNIYlHw1zWuL4BRyBU4wO
         2FwBTLa3H2Aml1sGlNBTLusnvdkpQ1C1khV2Ybe2iY5732bCd5+R+xhWt2EX+ITIwR38
         rwzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IM5W/Do7NMlYTnx0RNfS6RyBqs/1P2u0MCvgsjOndUM=;
        b=1ydlFMv7A5rGcFp1r+er1sPpjUHwrpJMd8eyJuPUYcI+PrEoJvqahEcZZ23q4HtuMv
         XhgG7V5VDMGTOwMws7o/uXEn+a0bd5smfyP45X3ey4B+KRcnNbOBheKY404j3DLNzAw/
         wlTDcMqUY15nVtnorn7IxoQmTiKoVrz+3u5GRpQV+UXYPuUQB+ZNFJf68skVJZ8PpapN
         qxcLaQCHkxeaKU4kQhIoXi+Ksx21QVoTTYvo5xS1d5IToY7owK8xJAWoBMtpCLBY03FC
         3tV6lM6PqzNl0MyQRjT4qBUVgUblz31hGwNkMOJQY30951NL+yTzYnwYRJP7meSr15Zm
         ERfg==
X-Gm-Message-State: AOAM533ewMnOsMb1udm4k+I1ydGRdn3cdJi/WQck7Re0nnkKw4Hj6pNe
        228s/AXAhDKj2DqIIDV+iCYJ8EhlAIWXE0M7IXo+2g==
X-Google-Smtp-Source: ABdhPJx2q8C8lZLQabs45/I+MJFiNjIQ5ZwkUC1LDv1f/0BxVIHE3gX1cPZZbG6Qhpm0QIjAeX5EOMxFAdBI/rwjr9Q=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr2453391wrn.177.1641883884468;
 Mon, 10 Jan 2022 22:51:24 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-3-dlatypov@google.com>
 <CAFd5g45HcdzB_CTNRRpH8BFbBvG0nDS4_6VUj3Tqx8XOuVTNOQ@mail.gmail.com> <CAGS_qxqhhu=Jy+vwWZGZLRG4qW5=ZJ8t7QbjtL54onc4-NFnrw@mail.gmail.com>
In-Reply-To: <CAGS_qxqhhu=Jy+vwWZGZLRG4qW5=ZJ8t7QbjtL54onc4-NFnrw@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Jan 2022 14:51:13 +0800
Message-ID: <CABVgOSkyJvM=beWD8PM-sobHnVNRyqQYQpjeBYhbUEP4Lz8bLA@mail.gmail.com>
Subject: Re: [PATCH 2/6] kunit: move check if assertion passed into the macros
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 6:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> On Mon, Jan 10, 2022 at 2:21 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> > >
> > > Currently the code always calls kunit_do_assertion() even though it does
> > > nothing when `pass` is true.
> > >
> > > This change moves the `if(!(pass))` check into the macro instead
> > > and renames the function to kunit_failed_assertion().
> > > I feel this a  bit easier to read and understand.
> > >
> > > This has the potential upside of avoiding a function call that does
> > > nothing most of the time (assuming your tests are passing) but comes
> > > with the downside of generating a bit more code and branches.
> > >
> > > This also means we don't have to initialize structs that we don't need,
> > > which will become a tiny bit more expensive if we switch over to using
> > > static variables to try and reduce stack usage. (There's runtime code
> > > to check if the variable has been initialized yet or not).
> > >
> > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> >
> > Tiny nit, see below. Otherwise:
> >
> > Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
> >
> > > ---
> > >  include/kunit/test.h | 20 ++++++++++----------
> > >  lib/kunit/test.c     | 13 ++++---------
> > >  2 files changed, 14 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/include/kunit/test.h b/include/kunit/test.h
> > > index b26400731c02..690a28dfc795 100644
> > > --- a/include/kunit/test.h
> > > +++ b/include/kunit/test.h
> > > @@ -770,18 +770,18 @@ void __printf(2, 3) kunit_log_append(char *log, const char *fmt, ...);
> > >   */
> > >  #define KUNIT_SUCCEED(test) do {} while (0)
> > >
> > > -void kunit_do_assertion(struct kunit *test,
> > > -                       struct kunit_assert *assert,
> > > -                       bool pass,
> > > -                       const char *fmt, ...);
> > > +void kunit_failed_assertion(struct kunit *test,
> > > +                           struct kunit_assert *assert,
> > > +                           const char *fmt, ...);
> >
> > Tiny nit: I think this should be kunit_fail_assertion. I think
> > functions should be in the active tense, imperative mood since when
> > you call a function you are telling it to do something.
> >
> > Also, do we need to worry about this getting confused with KUNIT_FAIL,
> > or KUNIT_FAIL_ASSERTION:
>
> So do we want to try and pick a different name from
> kunit_fail_assertion() to avoid confusion with the macro?
> That's partly why I went with past tense.
> Perhaps: "kunit_do_assertion() => kunit_do_failed_assertion()" instead?

I'm not particularly picky about the name personally. But if I had to
join the bikeshedding, I'd probably go with kunit_assertion_fail() or
similar (kunit_assertion_failed works too, past-tense-wise.)

But kunit_do_fail{,ed}_assertion() would work too.


>
> Tangent: we have some similar confusing names, e.g. KUNIT_ASSERTION is
> both the name of a macro and an enum (kunit_assert_type), and those
> have the exact same case.
>
> >
> > https://elixir.bootlin.com/linux/v5.16/source/include/kunit/test.h#L788
> >
> > ?
> >
> > >  #define KUNIT_ASSERTION(test, pass, assert_class, INITIALIZER, fmt, ...) do {  \
> > > -       struct assert_class __assertion = INITIALIZER;                         \
> > > -       kunit_do_assertion(test,                                               \
> > > -                          &__assertion.assert,                                \
> > > -                          pass,                                               \
> > > -                          fmt,                                                \
> > > -                          ##__VA_ARGS__);                                     \
> > > +       if (!(pass)) {                                                         \
> > > +               struct assert_class __assertion = INITIALIZER;                 \
> > > +               kunit_failed_assertion(test,                                   \
> > > +                                      &__assertion.assert,                    \
> > > +                                      fmt,                                    \
> > > +                                      ##__VA_ARGS__);                         \
> > > +       }                                                                      \
> > >  } while (0)
> > >
> > >
> > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > index c7ed4aabec04..5ad671745483 100644
> > > --- a/lib/kunit/test.c
> > > +++ b/lib/kunit/test.c
> > > @@ -275,16 +275,11 @@ static void __noreturn kunit_abort(struct kunit *test)
> > >         WARN_ONCE(true, "Throw could not abort from test!\n");
> > >  }
> > >
> > > -void kunit_do_assertion(struct kunit *test,
> > > -                       struct kunit_assert *assert,
> > > -                       bool pass,
> > > -                       const char *fmt, ...)
> > > +void kunit_failed_assertion(struct kunit *test,
> > > +                           struct kunit_assert *assert,
> > > +                           const char *fmt, ...)
> > >  {
> > >         va_list args;
> > > -
> > > -       if (pass)
> > > -               return;
> > > -
> > >         va_start(args, fmt);
> > >
> > >         assert->message.fmt = fmt;
> > > @@ -297,7 +292,7 @@ void kunit_do_assertion(struct kunit *test,
> > >         if (assert->type == KUNIT_ASSERTION)
> > >                 kunit_abort(test);
> > >  }
> > > -EXPORT_SYMBOL_GPL(kunit_do_assertion);
> > > +EXPORT_SYMBOL_GPL(kunit_failed_assertion);
> > >
> > >  void kunit_init_test(struct kunit *test, const char *name, char *log)
> > >  {
> > > --
> > > 2.34.1.575.g55b058a8bb-goog
> > >
