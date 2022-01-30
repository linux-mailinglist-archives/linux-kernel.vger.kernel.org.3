Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798024A3904
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356138AbiA3Uep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 15:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244727AbiA3Uen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 15:34:43 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAF2C061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:34:43 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id q63so11799196pja.1
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 12:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7IOZHCJNZdVLsKlAN8UmMORGXdNGmY4XG9mnrfmJGuw=;
        b=QV4Fu43qCgBQrge/+g0f+BFyeec7tqd+zZb+KsIVqjyPa2+8KTmQsBjFmKMa4GKe40
         l+YCP1RGk7CDYKX/F/bBg6XL0WJ5kED64GEhx7PaLymQi5WSoZ1ByUuhZ4/TEM/59JKP
         FdbOeQ1g4JR2P9So2fmDn2lkxdqRX/5OPsoX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7IOZHCJNZdVLsKlAN8UmMORGXdNGmY4XG9mnrfmJGuw=;
        b=a6EQXZ+JqJWaYQSNHLQU+cj0+WICVYK9qEiW6Lt8dpcQ1pXraHO8Lm2WHbF/jFAj4y
         alJuFxrsuP7Fs4BItKLsAKU2lr5c2JMJD9qh7DqcNd7xCBQEQsUrw40cq8/xBpxm1S9c
         gzqp1mDxh/TTS59DBJZEnKqfUXVIAujrFTHGP2ZrpHb1t+aMIhNfpoIYaeBRscJubri6
         bVfySBhm7xM3XaGJIYh4QwfAUebbjuFbeA9jqaeGzJS829kt6pH1J0fPXfVUzf2iifgE
         aYaMX7xG7RJkRLuVHNwA6g45I5h7o5IaVYb86ig8kk3z6C//O3Zi+0pfCE1dFXWlEyDh
         wTAA==
X-Gm-Message-State: AOAM531H+hI5+eHPA89ZBDLp9G/Mf0xd8JzhMktPRCv+y9g1g7S0WH/R
        01+1jOjIueiXoXJDmB0x87OCoA==
X-Google-Smtp-Source: ABdhPJw4yBDg3uS7cAcZfMh1IewxVhrjRAZxYuWwvIIw8kVlS7S/z6VsdX895ZYK9QDlZEQDnCeZAg==
X-Received: by 2002:a17:902:758c:: with SMTP id j12mr17852607pll.34.1643574882799;
        Sun, 30 Jan 2022 12:34:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d22sm9157814pfl.71.2022.01.30.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 12:34:42 -0800 (PST)
Date:   Sun, 30 Jan 2022 12:34:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Peter Rosin <peda@axentia.se>,
        Andy Shevchenko <andy@kernel.org>,
        Matteo Croce <mcroce@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib/test_string.c: Add test for strlen()
Message-ID: <202201301220.529465D6@keescook>
References: <20220130183653.491292-1-keescook@chromium.org>
 <CAHp75Vf9S8jKQGAYRrmSET7YJQNoHMzUC6VVTAOT7DbwcCcc4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf9S8jKQGAYRrmSET7YJQNoHMzUC6VVTAOT7DbwcCcc4Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 08:56:40PM +0200, Andy Shevchenko wrote:
> On Sun, Jan 30, 2022 at 8:36 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Add a simple test for strlen() functionality, including using it as a
> > constant expression.
> 
> ...
> 
> > +/*
> > + * Unlike many other string functions, strlen() can be used in
> > + * static initializers when string lengths are known at compile
> > + * time. (i.e. Under these conditions, strlen() is a constant
> > + * expression.) Make sure it can be used this way.
> > + */
> > +static const int strlen_ce = strlen("tada, a constant expression");
> 
> So, the compiler will replace this by a constant and then eliminate
> the condition completely from the code. Did I understand this
> correctly?

Yup! See: https://godbolt.org/z/nTqPaszTh

There a few rare places in the kernel that do this, which is how
I noticed. (I broke strlen() with the recent FORTIFY changes.)

> > +static __init int strlen_selftest(void)
> > +{
> > +       /* String length ruler:         123456789012345 */
> > +       static const char normal[]   = "I am normal";
> > +       static const char *ptr       = "where do I go?";
> > +       static const char trailing[] = "hidden NULLs\0\0\0";
> > +       static const char leading[]  = "\0\0hidden text";
> > +
> > +       if (strlen(normal) != 11)
> > +               return 0x100001;
> > +       if (strlen(ptr++) != 14)
> > +               return 0x100002;
> > +       if (strlen(ptr++) != 13)
> > +               return 0x100003;
> > +       if (strlen(trailing) != 12)
> > +               return 0x100004;
> > +       if (strlen(leading) != 0)
> > +               return 0x100005;
> 
> > +       if (strlen_ce != 27)
> > +               return 0x100006;
> 
> ...so this part won't ever appear in the assembly (assuming -O2).

Correct, unless strlen() breaks.

> Same to the rest? If so, why is this not a part of the compiler tests?

I wanted to keep everything together -- this includes a macro
side-effect test as well ("ptr++").

-Kees

-- 
Kees Cook
