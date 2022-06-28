Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B3155EAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiF1RXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbiF1RX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:23:26 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C605F2D1F0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:23:24 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id u14so18386480qvv.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7a9uw7xwjGqPRQqY1yb1sbID6LzC3CRVQFUu2rtKuVw=;
        b=kuIgtnZugIgrCoQ2szIFHgKx2Z2B0TdEc3P0bG5DturMnnsmoHmgM22eNRHtJyJ9FF
         z/sCIRfo1rnPR9e5CWaudeH/etUOfT4gf92RJ+p3GepiwIaq64jzCKaSz7pInb9UEFwM
         uRXy6n2tjrhpWd032bYu05t4d9s1IurkIFuPaJ2MuMvedGpx7F515tGraB7QlfBdMeC5
         BA+b8l1BRC3tro3IjSGkiNwunhp5e+9RxCNQwEwEsmAgCH02XxAL1psx91g53QzVrMCf
         Wn/LvKXIAnmZqOjmYIDYf+JyMuk8IaIbdBIh3AZD6PiOueI/TRUs5IewtW1yCxbFwiDy
         6Usw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7a9uw7xwjGqPRQqY1yb1sbID6LzC3CRVQFUu2rtKuVw=;
        b=Ehbctk9j07/KduIGpA7j0wHVyNamACoKLUbS05ASef3AI8TaE8rWZ7DiqqEp6nTyjJ
         Gztlrp7LgYjtphxQ82D9YcyxpciNKS6YxB7giD9uZnxYOB+0vOdjAfC+8G+fMMIEKR9E
         nmGKKb6xRHy2gaSfeDsAmBIz1XWO+d54MSsucWP6foauvYElu3D3UIGRdW+xFcPLZ0/R
         4f+wZhw315fOJWbM4msKpl22KGllAsEC+jnQAMGBhT6JdlmN7cTpcCfF4ADgkhyh+0KM
         Iwul7DZQA4JNszA1QVhJCu+VrEwnNG64at9SudUdJ/IqPlx2MuWTKGgRB5L0oWxiWiMV
         QSZQ==
X-Gm-Message-State: AJIora9ANatlx/WwH/nk0iWyWylCDMfcme5vsxQkOzzKGHEXW7HPuXwP
        RNcdNo8wTKTcxstjCZFwVw==
X-Google-Smtp-Source: AGRyM1sBOIKYUcU93DKs8yJJkoa9dQ0/94D5Fq3apoISJdDTjhiP9VeWZCuOycN7adxiCYh3wMbQ3A==
X-Received: by 2002:ac8:5e0a:0:b0:31b:f15f:76b with SMTP id h10-20020ac85e0a000000b0031bf15f076bmr3298669qtx.502.1656437003234;
        Tue, 28 Jun 2022 10:23:23 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id b12-20020a05620a0f8c00b006a34a22bc60sm11080269qkn.9.2022.06.28.10.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 10:23:22 -0700 (PDT)
Date:   Tue, 28 Jun 2022 13:23:21 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v5whatever, now with typechecking] vsprintf: %pf(%p)
Message-ID: <20220628172321.gbgfif7zgz5ny3mo@moria.home.lan>
References: <20220628032439.3314451-1-kent.overstreet@gmail.com>
 <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGMNvKaVuSDD7y2JeK+NsNyXtqZEusOLmEw9uE+0ZySg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 09:46:46PM -0700, Linus Torvalds wrote:
>     // type warning *and* link-time failure
>     extern int not_a_pointer;
> 
>     extern int pretty_print_int(int *);
>     extern int pretty_print_long_long(long long *);
> 
>     #define __PP_FN(ptr) _Generic(*(ptr),               \
>         int:            pretty_print_int,       \
>         long long:      pretty_print_long_long, \
>         default:        not_a_pointer )
> 
>     #define __PP_CHECK(fn,ptr)  \
>         __PP_MAGIC+(__typeof__ ((fn)(ptr)))0, fn, ptr
> 
>    #define pretty_fn(fn,ptr) &(struct pretty_print_struct) \
>        { __PP_CHECK(__PP_FN(ptr), ptr) }
> 
>     #define pretty_print(ptr) pretty_fn(__PP_FN(ptr), ptr)
> 
>     void test_me(int val)
>     {
>         printf("%pf\n", pretty_print(&val));
>     }

Your version is nicer for the simpler cases, but it's not general enough for
what I'm looking at.

 - We need to be able to specify the pretty-printer function, and not just have
   one per type

From the commit message for my patch converting %p[iI] pretty printers to
printbuf style pretty printers:

     %piS     -> prt_sockaddr_zeropad
     %pIS     -> prt_sockaddr
     %pISc    -> prt_sockaddr_compressed
     %pISfc   -> prt_sockaddr_flow_compressed
     %pISp    -> prt_sockaddr_port
     %pISpc   -> prt_sockaddr_port_compressed
     %pISpsc  -> prt_sockaddr_port_scope_compressed
     %pISpfc  -> prt_sockaddr_port_flow_compressed
     %pISpfsc -> prt_sockaddr_port_scope_flow_compressed

That's just sockaddrs, and I limited it to creating functions for the printk
formats that are actually currently in use.

What we _really_ want is just to have a separate flags argument to prt_sockaddr,
but in the current code only pointer arguments are supported.

 - We need pretty-printer functions that take variable numbers of arguments, and
   not just for a flags argument

In my OOM report patch series, I'm doing

printk("%pf()", CALL_PP(slabs_to_text));
printk("%pf()", CALL_PP(shrinkers_to_text));

We want slabs_to_text and shrinkers_to_text to be pretty-printers instead of
just calling printk directly so that procfs/sysfs/whatever the current fashion
is can also dump the same report.

And in bcachefs, I've got a bunch of pretty-printers that need a pointer to the
filesystem object in addition to a pointer to the object they're printing so
that they can decode all kinds of things. Pretty sure this is going to come up
elsewhere (other filesystems, for sure).

Also:

I want the pretty-printer function to be specified explicitly, so that when
reading the code we can cscope to it. When we're doing a function call, even
indirectly, _I want the name of that function in front of me_ and I think that
is one of the major advantages of this approach vs. our current %p extensions.

BUT

Maybe we can get rid of specifying the arguments in the format string, and have
it be just %pf instead of %pf(...).

The struct call_pp needs to handle a variable number of arguments, not just one
as in your example, and I really do want it to handle integer arguments, and not
just pointer arguments.

So here's the $20 million question: Can we, safely, on all archictectures, treat
all arguments as ulongs as long as the actual function arguments are either
pointers or integers not bigger than a ulong? Or are there crazy architectures
out there where passing pointers is different from passing integers in the ABI?

We'd also really like to be able to pass u64s too - prt_u64() is now a standard
pretty-printer, along with prt_u64_human_readable()!

Because yeah fundamentally the reason for the %pf(%p,%llu) thing is that we know
how to pass those types through varargs to sprintf, and libffi is a thing so we
know that the future we'll be able to do constructed function calls including
with u64 arguments, so this seems solvable.

But maybe serializing them before the call in struct call_pp isn't actually any
harder, and actually it gets around the fact that C promotes all ints smaller
than ints to ints in varargs, so that's nice.

I need to think about this some more.
