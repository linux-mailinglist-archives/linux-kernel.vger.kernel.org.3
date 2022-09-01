Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E105A9F2A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiIASgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIASgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:36:14 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D049B4B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:35:20 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f12so17681536plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GQ28FOAZMVQ3xFZpFJCHY7mAOgvSd7PKD0QPADuR978=;
        b=eSgxG4bqEJiuDEwCInACHRFQuH1JworFCQanpOE1TMTCqAMn6sFg1F/zy3lpOlGrrE
         Jime6pDA7OeHjMdY0aSOhJzKveWFDZc/jCNetPpK43TL/eC1/No8kunMHTeT4cjPyZc+
         1LZBzk1cGlandl2dk1/Rj7FMjX9zsYeWdisVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GQ28FOAZMVQ3xFZpFJCHY7mAOgvSd7PKD0QPADuR978=;
        b=dAeOsfA1XptS7vvdYsG/SG2jUVBnxPuue/7TW7MiPxPJdbSRpvP+Ap9rnXmAtQzKZM
         FkTcRxooxVV2gGdhNlfNI6Xdsrnqa785gd+HZgXgb3UlsXQLxHXPEejOSq3cfw3ejkTD
         ALub+IueybW1hjg1KwR7WgqkoySuh8m31ose+SbC92vFG4zLvfp6OWZO9kyxlb4fhhyJ
         C6MaFA79jQT2gAt0OehOwoy0hUi2WJcF4kLALb+KLHHP+VhLGfnxgl+0cJW2YCw9IKg2
         chJ5kBIgYEwR1/JVtisdzVSsQriBK9pEVKlWUwagRlL2WhcZQrK7OGxGtgE5bLRSm8Gx
         neUw==
X-Gm-Message-State: ACgBeo3VqhCW2DhE14ok2JPyYvA4av0r2wuOcqTbsEqYs9SSoh1rJEuH
        hzfZ+MZKlqq1zn9QN5fP6w9CeuA7hY8qnQ==
X-Google-Smtp-Source: AA6agR740wRqqYij0+Atl0oh/vmBnMJnT3F/mK9gQi37OxPLVw/HqgLQ2S9/LQiSQmIB9AURSD9APg==
X-Received: by 2002:a17:902:cf0b:b0:172:72df:4bc with SMTP id i11-20020a170902cf0b00b0017272df04bcmr31505416plg.44.1662057319219;
        Thu, 01 Sep 2022 11:35:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z3-20020aa79483000000b0052dfe83e19csm14079024pfk.16.2022.09.01.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:35:18 -0700 (PDT)
Date:   Thu, 1 Sep 2022 11:35:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] string: Introduce strtomem() and strtomem_pad()
Message-ID: <202209011123.27D7D67@keescook>
References: <20220831230006.1016236-1-keescook@chromium.org>
 <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdX1H_ssPDJH47kcXhmoAZzYEgJC2zaMp-d_2+VriZYAoA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:39:19AM +0200, Geert Uytterhoeven wrote:
> [...]
> > When the "__nonstring" attributes are missing, the intent of the
> > programmer becomes ambiguous for whether the lack of a trailing NUL
> > in the p.small copy is a bug. Additionally, it's not clear whether
> > the trailing padding in the p.big copy is _needed_. Both cases
> > become unambiguous with:
> >
> > strtomem(p.small, "hello");
> > strtomem_pad(p.big, "hello");
> 
> strtomem_pad(p.big, "hello", 0);

Oops, thanks. I will adjust the example. And actually, instead of these
notes just living in commit logs, I realize I can update the kerndoc
for strncpy with a "here's now to pick a replacement" table...

> > See also https://github.com/KSPP/linux/issues/90
> >
> > Expand the memcpy KUnit tests to include these functions.
> >
> > Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> The idea looks good to me, but I guess Linus has something to
> say, too.
> 
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -260,6 +260,49 @@ static inline const char *kbasename(const char *path)
> >  void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
> >                     int pad);
> >
> > +/**
> > + * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
> > + *
> > + * @dest: Pointer of destination character array (marked as __nonstring)
> > + * @src: Pointer to NUL-terminated string
> > + * @pad: Padding character to fill any remaining bytes of @dest after copy
> > + *
> > + * This is a replacement for strncpy() uses where the destination is not
> > + * a NUL-terminated string, but with bounds checking on the source size, and
> > + * an explicit padding character. If padding is not required, use strtomem().
> > + *
> > + * Note that the size of @dest is not an argument, as the length of @dest
> > + * must be discoverable by the compiler.
> > + */
> > +#define strtomem_pad(dest, src, pad)   do {                            \
> > +       const size_t _dest_len = __builtin_object_size(dest, 1);        \
> > +                                                                       \
> > +       BUILD_BUG_ON(!__builtin_constant_p(_dest_len) ||                \
> > +                    _dest_len == (size_t)-1);                          \
> 
> I think you want to include __must_be_array(dest) here.

I didn't do that for the cases where we may be writing to non-array
destinations (e.g. see the cast from u64 in the strncpy use in
tools/perf/arch/x86/util/intel-pt.c). Since what we need to know is the
object size, it does not strictly need to be an array.

> > [...]
> > +       memset(&wrap, 0xFF, sizeof(wrap));
> > +       KUNIT_EXPECT_EQ_MSG(test, wrap.canary1, -1UL,
> 
> -1L or ULONG_MAX (everywhere)

Yeah, ULONG_MAX looks best. Thanks!

> 
> > +                           "bad initial canary value");
> > +       KUNIT_EXPECT_EQ_MSG(test, wrap.canary2, -1UL,
> > +                           "bad initial canary value");
> > +
> > +       /* Check unpadded copy leaves surroundings untouched. */
> > +       strtomem(wrap.output, input);
> > +       KUNIT_EXPECT_EQ(test, wrap.canary1, -1UL);
> > +       KUNIT_EXPECT_EQ(test, wrap.output[0], input[0]);
> > +       KUNIT_EXPECT_EQ(test, wrap.output[1], input[1]);
> > +       for (int i = 2; i < sizeof(wrap.output); i++)
> 
> unsigned int i (everywhere)

I guess, but why? This could even be u8.

Thanks for the review!

-- 
Kees Cook
