Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA3C46FA78
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhLJFfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 00:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbhLJFfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 00:35:18 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1A9C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 21:31:43 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id o1so14905986uap.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 21:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NSNhFbAC6FtTfpwe02NJ8rlES2tisGIzao8IpuqYzs=;
        b=CThoUzj3So7BHGMlrTEYkm/Rn7xYDoWEhb5eQn7kvU41dfJUtXTnNMd6RyCs1wAm+P
         dYHC5KPtHqOa2tJPKaLS6guTrKhxogEUQ7/+fAwFbaUWc3qan6BxuYofUPKHCC012601
         zBmLXSydRJiUuvLKrXJFUxhCfrSS/R9xymMBmCmTDpDlvv5C3uWGBuGeWZt49FkyxoBQ
         5uVHHCK8QOG+fDKVRxx44ESplutf7Cgh+5C0N2YKxsLLZiUpO2U4lsb1FiKPgy7uvmv6
         noIwRGytRvLS0OwcMy8Y+0o0o1IJaNSUuDvFR5Dp/sy6SeZ/b+OfaEHQ8S9Vm+G2txxK
         Xreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NSNhFbAC6FtTfpwe02NJ8rlES2tisGIzao8IpuqYzs=;
        b=aQyCWIIJ1ipUrB30MvYP8W2x82fWDKHR5xT9D12XJddbtKUcKLySGCvXB/SpWTN9Ig
         DCS60SB4waYAPaJfJITTR+5ogxRVBJL6jqVGBA62dqebBUjaKhjo+Dw94tk2L/ks03Bh
         nm5VE5SWSkvqCUxdB6sjlsbpJWimVgAhXJfuHNch9hqOFGfwjAKzHpzT5Ew02act1tMQ
         WIe6BnopxPd6i4kq08UYpRH7dX0AwtxAIEcCvcBAh2mY+isqhOy1QIDv9EjFfpBMoYK3
         XA3sb4o2w0PFa1cAjA2yz2jfhREwk2vU2rNQOShu//LEJEm1p3XJyeNUV6WXIxtMQiJK
         xHMQ==
X-Gm-Message-State: AOAM533Vl3yTA+Avizddemop9E5BNQDTq9x9vsLe+KJ9w62Vz97XG7Zw
        j2QGaXN4yiveRzSxevmyvBe4soTwdn+8VV1a9J+/xQ==
X-Google-Smtp-Source: ABdhPJw6Pnmp0hS1+T6/efrw023zC6xpQqnaN7GQxTlfC35vV6DS5QBcaR0UfXO+tVhlxsZ0dr2QDNZpXKpYAwWs4+Q=
X-Received: by 2002:ab0:3b12:: with SMTP id n18mr26872614uaw.2.1639114302934;
 Thu, 09 Dec 2021 21:31:42 -0800 (PST)
MIME-Version: 1.0
References: <20211207054019.1455054-1-sharinder@google.com>
 <20211207054019.1455054-5-sharinder@google.com> <BYAPR13MB2503F47AA79D51CDE321AB21FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
In-Reply-To: <BYAPR13MB2503F47AA79D51CDE321AB21FD6E9@BYAPR13MB2503.namprd13.prod.outlook.com>
From:   Harinder Singh <sharinder@google.com>
Date:   Fri, 10 Dec 2021 11:01:32 +0530
Message-ID: <CAHLZCaE5XLcrLrN5xEETfE3eKS8K4p5oQgAWSoqLJWm9WK7XLg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] Documentation: kunit: Reorganize documentation
 related to running tests
To:     tim.bird@sony.com
Cc:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tim,

Thanks for your comments.

See my comments below.

On Tue, Dec 7, 2021 at 11:03 PM <Tim.Bird@sony.com> wrote:
>
> > -----Original Message-----
> > From: Harinder Singh <sharinder@google.com>
> >
> > Consolidate documentation running tests into two pages: "run tests with
> > kunit_tool" and "run tests without kunit_tool".
> >
> > Signed-off-by: Harinder Singh <sharinder@google.com>
> > ---
> >  Documentation/dev-tools/kunit/index.rst       |   4 +
> >  Documentation/dev-tools/kunit/run_manual.rst  |  57 ++++
> >  Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++++++++++++
> >  Documentation/dev-tools/kunit/start.rst       |   4 +-
> >  4 files changed, 311 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
> >  create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst
> >
> > diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
> > index 75e4ae85adbb..c0d1fd749cd2 100644
> > --- a/Documentation/dev-tools/kunit/index.rst
> > +++ b/Documentation/dev-tools/kunit/index.rst
> > @@ -10,6 +10,8 @@ KUnit - Linux Kernel Unit Testing
> >
> >       start
> >       architecture
> > +     run_wrapper
> > +     run_manual
> >       usage
> >       kunit-tool
> >       api/index
> > @@ -98,6 +100,8 @@ How do I use it?
> >
> >  *   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
> >  *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
> > +*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
> > +*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
> >  *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
> >  *   Documentation/dev-tools/kunit/tips.rst - best practices with
> >      examples.
> > diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
> > new file mode 100644
> > index 000000000000..71e6d6623f88
> > --- /dev/null
> > +++ b/Documentation/dev-tools/kunit/run_manual.rst
> > @@ -0,0 +1,57 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +============================
> > +Run Tests without kunit_tool
> > +============================
> > +
> > +If we do not want to use kunit_tool (For example: we want to integrate
> > +with other systems, or run tests on real hardware), we can
> > +include KUnit in any kernel, read out results, and parse manually.
> > +
> > +.. note:: KUnit is not designed for use in a production system. It is
> > +          possible that tests may reduce the stability or security of
> > +          the system.
> > +
> > +Configure the Kernel
> > +====================
> > +
> > +KUnit tests can run without kunit_tool. This can be useful, if:
> > +
> > +- We have an existing kernel configuration to test.
> > +- Need to run on real hardware (or using an emulator/VM kunit_tool
> > +  does not support).
> > +- Wish to integrate with some existing testing systems.
> > +
> > +KUnit is configured with the ``CONFIG_KUNIT`` option, and individual
> > +tests can also be built by enabling their config options in our
> > +``.config``. KUnit tests usually (but don't always) have config options
> > +ending in ``_KUNIT_TEST``. Most tests can either be built as a module,
> > +or be built into the kernel.
> > +
> > +.. note ::
> > +
> > +     We can enable the ``KUNIT_ALL_TESTS`` config option to
> > +     automatically enable all tests with satisfied dependencies. This is
> > +     a good way of quickly testing everything applicable to the current
> > +     config.
> > +
> > +Once we have built our kernel (and/or modules), it is simple to run
> > +the tests. If the tests are built-in, then will run automatically on the
>
> then will run -> they will run
> (or 'then they will run')
>

Done

> > +kernel boot. The results will be written to the kernel log (``dmesg``)
> > +in TAP format.
> > +
>
> The rest looks OK to me.
>
> You can add a 'Reviewed-by' for me if you want.
>  -- Tim
>

Regards,
Harinder Singh
