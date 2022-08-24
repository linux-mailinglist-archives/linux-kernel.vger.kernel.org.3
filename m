Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A2859FB1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238128AbiHXNT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiHXNTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:19:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E22A40C
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:19:25 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id j1so12787060qvv.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 06:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=xtE2mk3voHJepArBh3DxMrm9zljGAH16TMIXNGTqNOQ=;
        b=HoWvk64nsFWq6kacuM+0l4AKgdSxnM4zZ2WtsLXCBmeECGhnbdyJIN0UpzYlQaxpDZ
         8b6h4Z6ef9Y5nsXMRd0LPLXDHQ7jnq5zisI07zCuJzxzcVIT2QSSmPIx5njBCbTj+qdi
         NRiMGLcsStFsOh30ni9jJAE28ty2ug/r51CFD1aWgeMn5mun61EvQYLyjbbycN7ObS27
         JS8Xk6OeElAQ8/V07BKHTtnC9pL8grkP7Dfa2cPwuL833sO0y2XrwmpSv2kYPFaj1xZg
         uQvK/0WE0/DphB3r7uGI4nWCLUt8NnDqNffgzgON1Uu1ohfK+7WjUAbg7ixDrzq/0KTz
         wnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=xtE2mk3voHJepArBh3DxMrm9zljGAH16TMIXNGTqNOQ=;
        b=hN0zLVUD1TB20LiBjjZZ7mFCrduAVz5arlbdpu4iksYY3Z/ExMRsTBoK+3O+MnVZoo
         n3rrPAI/NDMyxwjx00dD4yqEeu0SZ4Ko/UCViUQKYaT1/8KKzPU4btRxLt5A2CMkqp1V
         qJBoO4O9auzFVLgFCmzGKOmvQ09hXyNFpqaihVR10kKvbHIup3yGhpo37E4MbtOZr6Oz
         vi2zF88YrOXfy5qhqLbENmrFqHMIJFhJ4AFaF3l3tjaGEYL2BE3A8AU0PzSJwYqaVTXo
         UoGrBnUqWySDV1cl+MVT/A06fmX6f3snIIxdOiPjopTYmr/BQ8hngF3R4G9zQyoW8Skh
         hTsA==
X-Gm-Message-State: ACgBeo3nMfrdCZMZ+ViNW16LKWy/eKcstDk6XWv79sK3Bqk4h2gODR/i
        1Bp1Gt9UYwapdZfBGqTZWQg=
X-Google-Smtp-Source: AA6agR7utI91N4Q2b5jN1IIdlNub/usFU2jo07OhswviK5NQ/TVOiimD2AfIjTjSBlqjJZsazvT5kQ==
X-Received: by 2002:a05:6214:20cb:b0:496:ae67:2121 with SMTP id 11-20020a05621420cb00b00496ae672121mr24185482qve.95.1661347164163;
        Wed, 24 Aug 2022 06:19:24 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:2270:5a54:d9d9:c2a4:527e])
        by smtp.gmail.com with ESMTPSA id p11-20020a05622a00cb00b00342b7e4241fsm13069893qtw.77.2022.08.24.06.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 06:19:23 -0700 (PDT)
Date:   Wed, 24 Aug 2022 06:19:22 -0700
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
Subject: Re: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
Message-ID: <YwYlWjlWO3fFrtQp@yury-laptop>
References: <20220824012624.2826445-1-yury.norov@gmail.com>
 <20220824012624.2826445-2-yury.norov@gmail.com>
 <CAHp75VcB08oTrB8R9Zyo4Ja=c_XqybqdCw46fY4_MNqvSSCtLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcB08oTrB8R9Zyo4Ja=c_XqybqdCw46fY4_MNqvSSCtLQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:10:02PM +0300, Andy Shevchenko wrote:
> On Wed, Aug 24, 2022 at 4:51 AM Yury Norov <yury.norov@gmail.com> wrote:
> >
> > Now that we have many flavors of find_first_bit(), and expect even more,
> > it's better to have one macro that generates optimal code for all and makes
> > maintaining of slightly different functions simpler.
> >
> > The logic common to all versions is moved to the new macro, and all the
> > flavors are generated by providing an EXPRESSION macro-parameter, like
> > in this example:
> >
> >   #define FIND_FIRST_BIT(EXPRESSION, size) ...
> >
> >   find_first_ornot_and_bit(addr1, addr2, addr3, size)
> >   {
> >         return FIND_NEXT_BIT(addr1[idx] | ~addr2[idx] & addr3[idx], size);
> >   }
> >
> > The EXPRESSION may be of any complexity, as soon as it only refers
> > the bitmap(s) and an iterator idx.
> >
> > The 'word_op' is here to allow the macro to generate code for _le
> > versions on big-endian machines; used in the following patches.
> 
> ...
> 
> > +#ifndef word_op
> > +#define word_op
> > +#endif
> 
> Not sure about the naming without namespace. Perhaps __ffs_word_op?
> 
> > +#define FIND_FIRST_BIT(EXPRESSION, size)                                       \
> > +({                                                                             \
> > +       unsigned long idx, val, sz = (size);                                    \
> > +                                                                               \
> > +       for (idx = 0; idx * BITS_PER_LONG < sz; idx++) {                        \
> 
> I think we can do slightly better:
> 
> for (unsigned long idx = 0; idx < sz; idx += BITS_PER_LONG) {
>   unsigned long val;

This will blow up the EXPRESSION. We can mitigate it on user side:
  find_first_bit(addr, size)
  {
        return FIND_FIRST_BIT(addr[idx/BITS_PER_LONG], size);
  }

But to me it's a wtf++.

And generated code looks almost the same, except that
on x86_64 your version is bigger. Compare before:
0000000000000000 <_find_first_bit>:
   0:   mov    %rsi,%rax
   3:   test   %rsi,%rsi
   6:   je     35 <_find_first_bit+0x35>
   8:   xor    %edx,%edx
   a:   jmp    19 <_find_first_bit+0x19>
   c:   add    $0x40,%rdx               // Track bits and
  10:   add    $0x8,%rdi                // index separately
  14:   cmp    %rax,%rdx
  17:   jae    35 <_find_first_bit+0x35>
  19:   mov    (%rdi),%rcx
  1c:   test   %rcx,%rcx
  1f:   je     c <_find_first_bit+0xc>
  21:   tzcnt  %rcx,%rcx
  26:   add    %rdx,%rcx
  29:   cmp    %rcx,%rax
  2c:   cmova  %rcx,%rax
  30:   jmp    35 <_find_first_bit+0x35>
  35:   jmp    3a <_find_first_bit+0x3a>
  3a:   nopw   0x0(%rax,%rax,1)

And after:
0000000000000000 <_find_first_bit>:
   0:   mov    %rsi,%rax
   3:   test   %rsi,%rsi
   6:   je     39 <_find_first_bit+0x39>
   8:   xor    %edx,%edx
   a:   jmp    15 <_find_first_bit+0x15>
   c:   add    $0x40,%rdx               // Track bits only
  10:   cmp    %rdx,%rax 
  13:   jbe    39 <_find_first_bit+0x39>
  15:   mov    %rdx,%rcx
  18:   shr    $0x6,%rcx                // But divide here
  1c:   mov    (%rdi,%rcx,8),%rcx
  20:   test   %rcx,%rcx
  23:   je     c <_find_first_bit+0xc>
  25:   tzcnt  %rcx,%rcx
  2a:   add    %rcx,%rdx
  2d:   cmp    %rdx,%rax
  30:   cmova  %rdx,%rax
  34:   jmp    39 <_find_first_bit+0x39>
  39:   jmp    3e <_find_first_bit+0x3e>
  3e:   xchg   %ax,%ax                  // Which adds 4 bytes to .text 

Thanks,
Yury

> > +               val = (EXPRESSION);                                             \
> > +               if (val) {                                                      \
> > +                       sz = min(idx * BITS_PER_LONG + __ffs(word_op(val)), sz);\
> 
> sz = min(idx + __ffs(...));
> 
> > +                       break;                                                  \
> > +               }                                                               \
> > +       }                                                                       \
> > +                                                                               \
> > +       sz;                                                                     \
> > +})
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
