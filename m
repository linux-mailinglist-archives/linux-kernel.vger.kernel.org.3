Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF1659FC53
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237296AbiHXNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbiHXNyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:54:52 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B629F7E317
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:53:09 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b9so12684941qka.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=aFrzc4EVs8mhahc/oN0YA6pJviRrO2jnMiLvsQfb3cc=;
        b=VWSPsIfCI2hMtcLYQCa6GqkdGrz11Kq+elD+EN2F87F5Ym6+VrE3F85UaQmPd11Qyz
         ZVprzh7JYHisIXpXZipnPqtWyRQMsJ+DCbV1R3pEBSww241ppbNHeHjUu0r6TqZpvTw4
         /pAeZHe1BpQUKzXrmAGLWhO75a4dPzA6yO1peC/fxNFV9ekJcykFThOMGx1yjkCj2wLF
         iTbQ5bNlYKBDbKCt81npIQ9mUh7gLL7s6urhohFn+UwEyrmuEGmDyiJiQ/X4n6cWpp/R
         +uYd0XLweIfQ0JOFpJVOnteTztIZIWnLPCxsigpe3DFWcBGcIKRE/US5UKxiGEtuB1UV
         m+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=aFrzc4EVs8mhahc/oN0YA6pJviRrO2jnMiLvsQfb3cc=;
        b=p2xsj9K6KonG6G11FwP6IB4FfEOYq6uKtP9tnxgnLzY0opr/aJnCwRHZ22ZlePb69n
         fuu8T3FUIPKyyCu4M0ofE4taRu6GQRl19ImQU6+H9d6SSg+kRuiaAdiuVHWNXlH4NpNg
         2IUhE0EL2E75yguqYdKu1U4vsIn7wSsv4OQY/heSgbwDXKFUcVO2WdfKFAWEzeEFi1K7
         u71sPPtBtP1Dc7aT8IbFrzElrhrcm2mvjlaA+R8fFN+embYdmThEyjjs+bCYq5c6gJPZ
         GbMQ17PJPe0vl4U4wbz5Tr7LTtaK8nEcxnRB0Sj2eTQiVCUPwHWm0Dy29B2cBkK1hsfl
         wx1Q==
X-Gm-Message-State: ACgBeo2hcsTmCvOVL5jkxjfueoTQq91IMYaDVHYDICeeU0J/LK4wSU1N
        ca+lFNt+UKe/nGOugWUoRFs=
X-Google-Smtp-Source: AA6agR6MoGegyBt+MHW+c4UIxqrzRTEZyoEdKTB8Qv8cLYpWehLoDfRE7/rpaGsRbqiBUj/pv/Bfxw==
X-Received: by 2002:a05:620a:573:b0:6bb:2865:e3cc with SMTP id p19-20020a05620a057300b006bb2865e3ccmr20021125qkp.15.1661349188761;
        Wed, 24 Aug 2022 06:53:08 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id n18-20020a05620a295200b006b9593e2f68sm16835404qkp.4.2022.08.24.06.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:53:08 -0700 (PDT)
Date:   Wed, 24 Aug 2022 06:53:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Subject: Re: [PATCH v2 3/3] lib/find_bit: optimize find_next_bit() functions
Message-ID: <YwYtQ7t+3grPF16n@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-4-yury.norov@gmail.com>
 <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve4QTSs_mSB7uMqOK4q+A-z-O1tc2k5=2qaRHTdAC3yog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:19:05PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 4:56 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Over the past couple years, the function _find_next_bit() was extended
> > with parameters that modify its behavior to implement and- zero- and le-
> > flavors. The parameters are passed at compile time, but current design
> > prevents a compiler from optimizing out the conditionals.
> >
> > As find_next_bit() API grows, I expect that more parameterss will be added.
> 
> parameters
> 
> > Current designs would require more conditional code in _find_next_bit(),
> > which would bloat the helper even more and make it barely readable.
> >
> > This patch replaces _find_next_bit() with a macro FIND_NEXT_BIT, and adds
> > a set of wrappers, so that the compile-time optimization becomes possible.
> >
> > The common logic is moved to the new macro, and all flavors may be
> > generated by providing an EXPRESSION macro parameter, like in this example:
> >
> >   #define FIND_NEXT_BIT(EXPRESSION, size, start) ...
> >
> >   find_next_xornot_and_bit(addr1, addr2, addr3, size, start)
> >   {
> >         return FIND_NEXT_BIT(addr1[idx] ^ ~addr2[idx] & addr3[idx], size, start);
> >   }
> >
> > The EXPRESSION may be of any complexity, as soon as it only refers
> > the bitmap(s) and an iterator idx.
> 
> ...
> 
> > +#define FIND_NEXT_BIT(EXPRESSION, size, start)                                 \
> > +({                                                                             \
> > +       unsigned long mask, idx, tmp, sz = (size), __start = (start);           \
> > +                                                                               \
> > +       if (unlikely(__start >= sz))                                            \
> > +               goto out;                                                       \
> > +                                                                               \
> > +       mask = word_op(BITMAP_FIRST_WORD_MASK(__start));                        \
> > +       idx = __start / BITS_PER_LONG;                                          \
> > +                                                                               \
> > +       for (tmp = (EXPRESSION) & mask; !tmp; tmp = (EXPRESSION)) {             \
> 
> for (unsigned long tmp ...;
> But hey, why not loop over idx (which probably should be named as
> offset)

Offset in structure, index in array, isn't?

> as I proposed in the first patch? You will drop a lot of
> divisions / multiplications, no?

Those divisions and multiplications are optimized away, and
what you suggested blows up the EXPRESSION.

I tried like this:
   mask = word_op(BITMAP_FIRST_WORD_MASK(__start));
   idx = __start / BITS_PER_LONG;
   tmp = (EXPRESSION);

   while (1) {
        if (tmp) {
               sz = min(idx * BITS_PER_LONG + __ffs(word_op(tmp)), sz);
               break;
        }

        if (++idx > sz)
                break;

        tmp = (EXPRESSION);
   } 

And it generated the same code, but looks less expressive to me.
If you have some elegant approach in mind - can you please share
it, and how the generated code looks?

Thanks,
Yury
