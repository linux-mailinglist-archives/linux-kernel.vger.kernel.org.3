Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73804C5DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiB0Re0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiB0ReZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:34:25 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA71A3B0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:33:47 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id u2so1263421ple.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r3V1p7PJfbcnc241Rj0vp4HKOhUxkZJ6zgydSZ91/kY=;
        b=XMieCkjw8mkwjHfO1Kf8OkVa68g6fnoB5pzlZhfIrZZW1jeB57UjoBz9355UZyhyFL
         5/Cvt1uXijJORzDAA2K8CpSgbN9Hp9OLPAtmjPCYTv3rYUgiKCik461ve9HlGsNGGsHa
         7cWxIa3rkJCxXniao/t2f/1EG3YPpxnpQYZd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r3V1p7PJfbcnc241Rj0vp4HKOhUxkZJ6zgydSZ91/kY=;
        b=cqeQz+QyMwL/nLqEyrxRhAkR3hGqpYRHLZYAwdfZnmw1rI4i/AHu8pSHmwswDMB3at
         y5jEKXihkbdEwZUy0XE5+sAVLY5w+Rhz+nid01tIZm2IMYk2CRdFFV2Dve3qomyfSbR+
         dLgQy6z+gecPp7RtGBcYzwC0+l3ExMaD7fScMbtonYCA3Y19fmOwMOiZjWg2ZjFQ9bdJ
         PlqiFJGGCcwodpcQJgDpG/+9+Iqdmx67/oy84ZBFVqld5lRigaqrALAfCGH7BcMZyqm1
         +cd5e/q1/j9TTcmagH+6S9tl1VRH6OxmWLjVjWBA+Dxq3S3zyjBw2zTl3IkzfBMwZcAS
         ChQQ==
X-Gm-Message-State: AOAM530rmiah1ZBtbMDPeUfMoFc0jjFz28UBZyOxAXzsKNnWEePpMYoP
        8w1zQ16va8JFw1CGjc9KZg32Cw==
X-Google-Smtp-Source: ABdhPJz/3WJGL8SYDkY1BfUaXM2Qe/Gd/I/m4uOr3ePHylsJY5bnoEBuunW2qbmTQtPSbOS7i5GO6Q==
X-Received: by 2002:a17:902:b906:b0:14f:76a0:ad48 with SMTP id bf6-20020a170902b90600b0014f76a0ad48mr16904324plb.79.1645983227254;
        Sun, 27 Feb 2022 09:33:47 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j2-20020a655582000000b00372b2b5467asm8268095pgs.10.2022.02.27.09.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 09:33:46 -0800 (PST)
Date:   Sun, 27 Feb 2022 09:33:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] lib: overflow: Convert to Kunit
Message-ID: <202202270929.5FD6A89B@keescook>
References: <20220224054825.1853314-1-keescook@chromium.org>
 <CABVgOS=TWVh649_Vjo3wnMu9gZnq66gkV-LtGgsksAWMqc+MSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOS=TWVh649_Vjo3wnMu9gZnq66gkV-LtGgsksAWMqc+MSA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 03:57:17PM +0800, David Gow wrote:
> On Thu, Feb 24, 2022 at 1:48 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert overflow unit tests to KUnit, for better integration into the
> > kernel self test framework. Includes a rename of test_overflow.c to
> > overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
> >
> > $ ./tools/testing/kunit/kunit.py config
> > ...
> (This 'config' step should be unnecessary... See below)

Ah yeah. I've removed that now.

> > $ ./tools/testing/kunit/kunit.py run overflow
> > ...
> > [14:33:51] Starting KUnit Kernel (1/1)...
> > [14:33:51] ============================================================
> > [14:33:51] ================== overflow (11 subtests) ==================
> > [14:33:51] [PASSED] u8_overflow_test
> > [14:33:51] [PASSED] s8_overflow_test
> > [14:33:51] [PASSED] u16_overflow_test
> > [14:33:51] [PASSED] s16_overflow_test
> > [14:33:51] [PASSED] u32_overflow_test
> > [14:33:51] [PASSED] s32_overflow_test
> > [14:33:51] [PASSED] u64_overflow_test
> > [14:33:51] [PASSED] s64_overflow_test
> > [14:33:51] [PASSED] overflow_shift_test
> > [14:33:51] [PASSED] overflow_allocation_test
> > [14:33:51] [PASSED] overflow_size_helpers_test
> > [14:33:51] ==================== [PASSED] overflow =====================
> > [14:33:51] ============================================================
> > [14:33:51] Testing complete. Passed: 11, Failed: 0, Crashed: 0, Skipped: 0, Errors: 0
> > [14:33:51] Elapsed time: 12.525s total, 0.001s configuring, 12.402s building, 0.101s running
> >
> > Cc: David Gow <davidgow@google.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> > Co-developed-by: Daniel Latypov <dlatypov@google.com>
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > Link: https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > Link: https://lore.kernel.org/lkml/CAKwvOdm62iA1dNiC6Q11UJ-MnTqtc4kXkm-ubPaFMK824_k0nw@mail.gmail.com
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > v1: https://lore.kernel.org/lkml/20220216224153.2242451-1-keescook@chromium.org/
> > v2: Fixed up the authorship more, pulled in other prior changes (Daniel)
> 
> This looks good to me. Some of the test cases _could_ probably be done
> as parameterised tests (given they're already basically table-driven),
> but I admit that could end up being excessively verbose.

In the end there was so much churn already I decided to leave it as-is.

> Apart from my not being able to find a tree this applies cleanly on,
> the tests work well here.

Ah, sorry about that! (More below...)

> Reviewed-by: David Gow <davidgow@google.com>

Thanks!

> [...]
> > @@ -600,127 +554,118 @@ struct __test_flex_array {
> >         unsigned long data[];
> ">  };
> >
> > -static int __init test_overflow_size_helpers(void)
> > +static void overflow_size_helpers_test(struct kunit *test)
> >  {
> >         /* Make sure struct_size() can be used in a constant expression. */
> >         u8 ce_array[struct_size((struct __test_flex_array *)0, data, 55)];
> >         struct __test_flex_array *obj;
> >         int count = 0;
> > -       int err = 0;
> >         int var;
> >         volatile int unconst = 0;
> 
> Where does this variable declaration (and its use below) come from?
> It's not in the version of the "overflow: Implement size_t saturating
> arithmetic helpers" patch in linux-next:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=6312fc63aee9d2fef2f9c4d42e57e5b46828f0dc
> 
> It all works if I add it in manually, but it does make applying the
> change as-is something of a pain.

Ah, thanks for noticing that! It looks like I failed to send an update
for that patch. I'll resend this portion of my tree.

-Kees

-- 
Kees Cook
