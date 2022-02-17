Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D178F4BA6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243594AbiBQRJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:09:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiBQRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:09:48 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097822ED41
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:09:31 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i6so192694pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Dwl+mjTsdeEYTair1mMTtpTeImSMgOp5wqm/i7EaMZI=;
        b=lNySuXZi9PWkDCsEsWA5s/aDCn9Q/P8U8/jOf7kIj9+WZlTrw0XTUtwDzbDdbxDwO9
         BJBqc9xisgsq/b9T8j/intX7fb0d6zc0IlUKFGOgqy3TbxmlWXOhe/kPZmPr24ts2Ztc
         /FcQQy83RJSzbTteBPxJMPVcPvhLFdO8nuB+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dwl+mjTsdeEYTair1mMTtpTeImSMgOp5wqm/i7EaMZI=;
        b=10xUUikInl+eg7BiDBzeUUX10/wJqHY7Z9fQQ/YKOtwrNhIT52nFCAAjRF6u2+U9LB
         4GIxBs96JQzc99aPlJaqRUrtWO0tMbz68gvBiOrXvDTSiCaSILOG35go//S0Xj3TG3mB
         t14bHgv180hJfH+y9dS0k3b7I9c7a9MnpYx5lMXcuEQ6e8JGNAyIhFq4Yua/k5xJ8YvB
         UHAXlLNIOmNHYAQ+zm+qopN5VTq8HTrUdesOH51iEz/t2DL12vgTONDjl5HdyKzpLkVi
         CyxgMNL9djIZiOIkM+fbwEjG+3H5x3F1uxJOv2fqztvTBr7khsd/GNuX6cBnsyKi8R4g
         T+lQ==
X-Gm-Message-State: AOAM533mBIUfQx0GxQpmFY5yjOgwbH1TJZRnUXdqcABc/9byGC0j8U+d
        clC1loW0ypsxtPx0mADxB+mllA==
X-Google-Smtp-Source: ABdhPJyr3MX+FeVZJm0oiiflOCd+a89srZf+enZRLXqPokyQb9O/C1bMU/eIoKQY1G0xgMvqtUJhEA==
X-Received: by 2002:a63:d252:0:b0:363:271c:fe63 with SMTP id t18-20020a63d252000000b00363271cfe63mr3180632pgi.524.1645117770920;
        Thu, 17 Feb 2022 09:09:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p10sm132876pfo.209.2022.02.17.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 09:09:30 -0800 (PST)
Date:   Thu, 17 Feb 2022 09:09:29 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lib: overflow: Convert to Kunit
Message-ID: <202202170903.E39554DF@keescook>
References: <20220216224153.2242451-1-keescook@chromium.org>
 <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGS_qxoOYjOtX6BQm-ozcarnazyED2vocd4iV+VdDVnMWpjWjg@mail.gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 02:57:12PM -0800, Daniel Latypov wrote:
> On Wed, Feb 16, 2022 at 2:42 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > Convert overflow unit tests to KUnit, for better integration into the
> > kernel self test framework. Includes a rename of test_overflow.c to
> > overflow_kunit.c, and CONFIG_TEST_OVERFLOW to CONFIG_OVERFLOW_KUNIT_TEST.
> >
> > $ ./tools/testing/kunit/kunit.py config
> > ...
> > $ ./tools/testing/kunit/kunit.py run overflow
> 
> JFYI, you can run this as a one-liner via
> 
> $ ./tools/testing/kunit/kunit.py run --kunitconfig /dev/stdin <<EOF
> CONFIG_KUNIT=y
> CONFIG_TEST_OVERFLOW=y
> EOF
> 
> The above is taken from my own duplicate version of this patch
> [1] https://lore.kernel.org/linux-kselftest/20210503211536.1384578-1-dlatypov@google.com/

Ah-ha! I thought I remembered this conversion being proposed before but
I totally failed to find it. Thank you! I'll compare/adjust this patch
and add you as Co-developed-by.

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
> > Cc: Vitor Massaru Iha <vitor@massaru.org>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Co-developed-by: Vitor Massaru Iha <vitor@massaru.org>
> > Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> > Link: https://lore.kernel.org/lkml/20200720224418.200495-1-vitor@massaru.org/
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Reviewed-by: Daniel Latypov <dlatypov@google.com>
> 
> Looks good to me, some minor nits/suggestions wrt KUnit usage.
> Nice to see this test converted over!

Thanks!

> [...]
> > index f6530fce799d..4cc27b9926a1 100644
> > --- a/lib/test_overflow.c
> > +++ b/lib/overflow_kunit.c
> > @@ -1,9 +1,13 @@
> >  // SPDX-License-Identifier: GPL-2.0 OR MIT
> >  /*
> > - * Test cases for arithmetic overflow checks.
> > + * Test cases for arithmetic overflow checks. See:
> > + * https://www.kernel.org/doc/html/latest/dev-tools/kunit/kunit-tool.html#configuring-building-and-running-tests
> > + *     ./tools/testing/kunit/kunit.py config
> > + *     ./tools/testing/kunit/kunit.py run overflow [--raw_output]
> >   */
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> We can drop the pr_fmt now, I think

My instinct is to leave these in place just so that anything weird that
gets inlined and sneaks a pr_*() call into the code will have a
meaningful prefix.

> [...]
> > @@ -510,30 +477,28 @@ static int __init test_ ## func (void *arg)                               \
> >                                                                         \
> >         /* Tiny allocation test. */                                     \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg, 1);\
> > -       if (!ptr) {                                                     \
> > -               pr_warn(#func " failed regular allocation?!\n");        \
> > -               return 1;                                               \
> > -       }                                                               \
> > +       KUNIT_EXPECT_FALSE_MSG(test, !ptr,                              \
> > +                           #func " failed regular allocation?!\n");    \
> 
> Optional: we can consider using KUNIT_ASSERT_NOT_ERR_OR_NULL_MSG() here.
> It's a more heavy handed than just a `return` on failure, but if the
> regular allocation failed, we're probably justified in bailing out on
> the whole test case.

Yeah, I think it might work here. Earlier I hadn't figured out how to
convert each test separately, but now an ASSERT makes sense.

> 
> > +       if (!ptr)                                                       \
> > +               return;                                                 \
> >         free ## want_arg (free_func, arg, ptr);                         \
> >                                                                         \
> >         /* Wrapped allocation test. */                                  \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
> >                                                           a * b);       \
> > -       if (!ptr) {                                                     \
> > -               pr_warn(#func " unexpectedly failed bad wrapping?!\n"); \
> > -               return 1;                                               \
> > -       }                                                               \
> > +       KUNIT_EXPECT_FALSE_MSG(test, !ptr,                              \
> > +                           #func " unexpectedly failed bad wrapping?!\n"); \
> > +       if (!ptr)                                                       \
> > +               return;                                                 \
> >         free ## want_arg (free_func, arg, ptr);                         \
> >                                                                         \
> >         /* Saturated allocation test. */                                \
> >         ptr = alloc ## want_arg ## want_gfp ## want_node (func, arg,    \
> >                                                    array_size(a, b));   \
> > -       if (ptr) {                                                      \
> > -               pr_warn(#func " missed saturation!\n");                 \
> > +       KUNIT_EXPECT_FALSE_MSG(test, ptr,                               \
> > +                           #func " missed saturation!\n");             \
> > +       if (ptr)                                                        \
> 
> We can instead do
> 
> if (ptr) {
>   KUNIT_FAIL(test, #func "missed saturation!");
>  free...()
> }
> 
> IMO, it's a bit easier to read that way, but not that important.

Ah yes, good. That's much better.

I will respin and resend...

-- 
Kees Cook
