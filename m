Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0555B4A801F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 09:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbiBCIEh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Feb 2022 03:04:37 -0500
Received: from mail-ua1-f46.google.com ([209.85.222.46]:35818 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiBCIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 03:04:35 -0500
Received: by mail-ua1-f46.google.com with SMTP id m90so3780288uam.2;
        Thu, 03 Feb 2022 00:04:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tQv5LD/cgbiE7FIrokd4eJrbJYiLRJK3S6XRnywILyw=;
        b=7do9hpyj2WTT3P3Yt/bE+niRMLmy1xL+5NNPJanKe3+jYkr0oPfXrQZ95vgVH9pV/o
         sLSNQzFz8Dglrwur713VCEC9mjT/I8gwesZJHjZysOP74vilIWZImknS8u7Hw3ktwAaJ
         I4qMHZi5/MpAToueC7E2gYzkfCVLHZb2gIGW5GaW/8h4+m32tfwUQ9+KYTInGOMqhMtD
         hvTIpztFMyOjlGyGn8RiWhC1MPudzQe0nh/O38Nbe8jlQWAg74dPQDwJ9pILTyR5okGM
         H/rQYf8wVmRBNslrLm2LzsqQ/uEBkB2tkJu7vwpIZ4ZMHmqd7RPLk//37Nrj5Dem05Hv
         uKTg==
X-Gm-Message-State: AOAM5337mTh0JjJl0lEWlZ9nfEF52Xcdz4l5HAaRrPtkAGmD71MGAqdc
        YqDIzEzc1aw8h8658q9q6i4BSUadWIKvTA==
X-Google-Smtp-Source: ABdhPJyfO3PhvmPjX6xnqfeCL97HwTCRK4R2wqM2/6k0RDpDcR4EoGXPQEnorY4DhYbPYm5LghAhUA==
X-Received: by 2002:a67:c58b:: with SMTP id h11mr12880341vsk.82.1643875474595;
        Thu, 03 Feb 2022 00:04:34 -0800 (PST)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id 10sm6468235uaq.9.2022.02.03.00.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Feb 2022 00:04:34 -0800 (PST)
Received: by mail-ua1-f51.google.com with SMTP id m90so3780243uam.2;
        Thu, 03 Feb 2022 00:04:34 -0800 (PST)
X-Received: by 2002:ab0:6f0d:: with SMTP id r13mr11231577uah.114.1643875473946;
 Thu, 03 Feb 2022 00:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20220130183653.491292-1-keescook@chromium.org>
 <20220202160149.GA2322037@roeck-us.net> <202202021237.487D3DE73@keescook> <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
In-Reply-To: <5ff18cff-6cfd-1f85-da74-1e5660a1a250@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 3 Feb 2022 09:04:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
Message-ID: <CAMuHMdWssK2=NFc6NO-inQg5dWxZP4Wv41K3J3RqRXThXatovw@mail.gmail.com>
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kees Cook <keescook@chromium.org>, Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Thu, Feb 3, 2022 at 12:12 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 2/2/22 12:52, Kees Cook wrote:
> > On Wed, Feb 02, 2022 at 08:01:49AM -0800, Guenter Roeck wrote:
> >> On Sun, Jan 30, 2022 at 10:36:53AM -0800, Kees Cook wrote:
> >>> Add a simple test for strlen() functionality, including using it as a
> >>> constant expression.
> >>>
> >>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> >>> Cc: Peter Rosin <peda@axentia.se>
> >>> Signed-off-by: Kees Cook <keescook@chromium.org>
> >>> ---
> >>> I'll be taking this as part of my Clang FORTIFY_SOURCE series.
> >>> ---
> >>>   lib/test_string.c | 37 +++++++++++++++++++++++++++++++++++++
> >>>   1 file changed, 37 insertions(+)
> >>>
> >>> diff --git a/lib/test_string.c b/lib/test_string.c
> >>> index 9dfd6f52de92..59994f552c48 100644
> >>> --- a/lib/test_string.c
> >>> +++ b/lib/test_string.c
> >>> @@ -179,6 +179,38 @@ static __init int strnchr_selftest(void)
> >>>     return 0;
> >>>   }
> >>>
> >>> +/*
> >>> + * Unlike many other string functions, strlen() can be used in
> >>> + * static initializers when string lengths are known at compile
> >>> + * time. (i.e. Under these conditions, strlen() is a constant
> >>> + * expression.) Make sure it can be used this way.
> >>> + */
> >>> +static const int strlen_ce = strlen("tada, a constant expression");
> >>> +
> >>
> >> This results in:
> >>
> >> lib/test_string.c:188:30: error: initializer element is not constant
> >>    188 | static const int strlen_ce = strlen("tada, a constant expression");
> >>
> >> for several of my tests. I don't think you can mandate that a compiler
> >> implements this.
> >
> > Which tests?
> >
>
> Some examples:
>
> Build reference: next-20220202
> Compiler version: m68k-linux-gcc (GCC) 11.2.0
>
> Building m68k:defconfig ... failed
> --------------
> Error log:
> lib/test_string.c:188:30: error: initializer element is not constant
>    188 | static const int strlen_ce = strlen("tada, a constant expression");
>
> Building mips:malta_defconfig:nocd:smp:net,e1000:initrd ... failed
> ------------
> Error log:
> lib/test_string.c:188:30: error: initializer element is not constant
>   static const int strlen_ce = strlen("tada, a constant expression");
>
> Building i386:q35:Broadwell:defconfig:smp:ata:net,rtl8139:hd ... failed
> ------------
> Error log:
> lib/test_string.c:188:30: error: initializer element is not constant
>    188 | static const int strlen_ce = strlen("tada, a constant expression");
>
> i386 and is defconfig + CONFIG_STRING_SELFTEST=y; mips is
> malta_defconfig + CONFIG_STRING_SELFTEST=y. All use gcc 11.2.
>
> There may be more, but there are so many failures in -next right now
> that I may be missing some.
>
> > This property of strlen() is already required by our builds (this is how
> > I tripped over it). For example:
> >
> > drivers/firmware/xilinx/zynqmp-debug.c:
> >
> > #define PM_API(id)               {id, #id, strlen(#id)}
> > static struct pm_api_info pm_api_list[] = {
> >          PM_API(PM_GET_API_VERSION),
> >          PM_API(PM_QUERY_DATA),
> > };
>
> I do not think that it is a C standard that strlen() on a constant string
> must be compile-time evaluated and result in a constant.

Not if -ffreestanding, which is what several architectures are
using nowadays, to a.o. prevent gcc from replacing calls to stdlib
functions to other stdlib functions (e.g. strncat() -> strlen() +
store, strncmp() -> strcmp()), which breaks linking if the latter is
only provided inline.

> Anyway, key difference, I think, is the presence of an architecture-specific
> version of strlen(), or the maybe non-presence of __HAVE_ARCH_STRLEN,
> or the definition of strlen() in include/linux/fortify-string.h.

It works after dropping -ffreestanding.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
