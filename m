Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369854CE4DA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiCEMoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbiCEMoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:44:11 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA8F19E736
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:43:19 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id k92so372718pjh.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 04:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6I7agjgBZdPJNhwWlPUcnFUH8tMRs9qQunLYsOnvYEc=;
        b=CIqrRcdh9qY/FvV1NSumtB+Co6pPhdR9FpRPHe1DkhTCrcClk6HCGRZ4GMs+Y2Nb1B
         mFF07DLUPKw6c9/Zbe/JzCsVGVacTSnWDxOcupUAoaQUvscN+A1zQsZB1+3H+tm8+GBc
         xgmJLNiKRc380L9unRwxcrbwZklcEHULdDnct8yG64CjOKDRcagKvEVKrSiYH4/qXR6T
         EDA5LLLllub9irHdDP3hMjkQoUIXJnhfRVzwjpfqyDV4GnvGKk+dZJNaYVgjeWKsmXv8
         PJTyc6ul4AI4wA1SHbj1DcP3kV+EKadzgcPr7ZBCg8zj5jgXbVV8B7+cehzJLNLlHegw
         KSKg==
X-Gm-Message-State: AOAM5317FotO1ft2ggKfXEOzpQJskbqHIQl80KdN2c6YsjMJjut16Yfi
        JKsAufLfNM0Ll1Lcs4SOqawNEAfSPfVOAzIoaCtiB8dEeaReug==
X-Google-Smtp-Source: ABdhPJyRJo9qa/d4hPGgqr++nWaFwDveOEMcenKbKX8N5kRLFongizZatfh3GkIasw/IOnABbD6XgfQ+eCzAdY/2xsw=
X-Received: by 2002:a17:902:e54b:b0:150:241d:c564 with SMTP id
 n11-20020a170902e54b00b00150241dc564mr3215522plf.61.1646484199012; Sat, 05
 Mar 2022 04:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20220304124416.1181029-1-mailhol.vincent@wanadoo.fr> <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
In-Reply-To: <CAHp75VeT3LbdbSaiwcC2YW40LnA2h8ADtGva-CKU_xh8Edi0nw@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sat, 5 Mar 2022 21:43:07 +0900
Message-ID: <CAMZ6RqJL2G=i-x3wwBD92devAxdNcnmwfDqz30+GFGobp21s+Q@mail.gmail.com>
Subject: Re: [PATCH] linux/bits.h: fix -Wtype-limits warnings in GENMASK_INPUT_CHECK()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue. 5 Mar 2022 at 03:46, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Fri, Mar 4, 2022 at 7:36 PM Vincent Mailhol
> <mailhol.vincent@wanadoo.fr> wrote:
> >
>
> > This pattern is harmless but because it occurs in header files
> > (example find_first_bit() from linux/find.h [1]) and because of the
> > include hell, the macro GENMASK_INPUT_CHECK() is accountable for 31%
> > (164714/532484) of all warnings when compiling all modules at W=2
> > level.
>
> Have you fixed W=1 warnings?

I am not sure to which W=1 warnings you are referring to.
linux/bits.h does yield any W=1 warnings if this is your concern.

Concerning other files, it depends. linux/bits.h is
included (either directly or indirectly) in thousands of files,
some of which would yield some W=1, some of which would not.

> Without fixing W=1 (which makes much more sense, when used with
> WERROR=y && COMPILE_TEST=y) this has no value.

Let me try to explain why I think this has some value. I am the
maintainer of one driver:
drivers/net/can/usb/etas_es58x/
When I compile it, with W=1, no warnings. When I compile it with W=2,
this is the output:

$ make W=2 drivers/net/can/usb/etas_es58x/etas_es58x.o
  CALL    scripts/checksyscalls.sh
<stdin>:21: warning: macro "__IGNORE_stat64" is not used [-Wunused-macros]
<stdin>:22: warning: macro "__IGNORE_lstat64" is not used [-Wunused-macros]
<stdin>:75: warning: macro "__IGNORE_llseek" is not used [-Wunused-macros]
<stdin>:159: warning: macro "__IGNORE_madvise1" is not used [-Wunused-macros]
  CALL    scripts/atomic/check-atomics.sh
  DESCEND objtool
  CC [M]  drivers/net/can/usb/etas_es58x/es58x_core.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_core.c:13:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
In file included from ./include/linux/container_of.h:5,
                 from ./include/linux/kernel.h:21,
                 from drivers/net/can/usb/etas_es58x/es58x_core.c:13:
./include/linux/find.h: In function 'find_first_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/find.h: In function 'find_first_and_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/find.h: In function 'find_first_zero_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/find.h: In function 'find_last_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
  CC [M]  drivers/net/can/usb/etas_es58x/es581_4.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es581_4.c:12:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
In file included from ./include/linux/container_of.h:5,
                 from ./include/linux/kernel.h:21,
                 from drivers/net/can/usb/etas_es58x/es581_4.c:12:
./include/linux/find.h: In function 'find_first_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/find.h: In function 'find_first_and_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/find.h: In function 'find_first_zero_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/find.h: In function 'find_last_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
  CC [M]  drivers/net/can/usb/etas_es58x/es58x_fd.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:14:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
In file included from ./include/linux/container_of.h:5,
                 from ./include/linux/kernel.h:21,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:14:
./include/linux/find.h: In function 'find_first_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
  119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/find.h: In function 'find_first_and_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:144:55: note: in expansion of macro 'GENMASK'
  144 |                 unsigned long val = *addr1 & *addr2 &
GENMASK(size - 1, 0);
      |                                                       ^~~~~~~
./include/linux/find.h: In function 'find_first_zero_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:166:46: note: in expansion of macro 'GENMASK'
  166 |                 unsigned long val = *addr | ~GENMASK(size - 1, 0);
      |                                              ^~~~~~~
./include/linux/find.h: In function 'find_last_bit':
./include/linux/bits.h:25:36: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                    ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                 ^~~~~~~~~~~~~~
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
./include/linux/bits.h:25:48: warning: comparison of unsigned
expression in '< 0' is always false [-Wtype-limits]
   25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
      |                                                ^
./include/linux/build_bug.h:16:62: note: in definition of macro
'BUILD_BUG_ON_ZERO'
   16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
      |                                                              ^
./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
   38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
      |          ^~~~~~~~~~~~~~~~~~~
./include/linux/find.h:187:45: note: in expansion of macro 'GENMASK'
  187 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
      |                                             ^~~~~~~
  LD [M]  drivers/net/can/usb/etas_es58x/etas_es58x.o


None of these are from the driver, only from the includes.
After this patch, the output becomes:

$ make W=2 drivers/net/can/usb/etas_es58x/etas_es58x.o
  CALL    scripts/checksyscalls.sh
<stdin>:21: warning: macro "__IGNORE_stat64" is not used [-Wunused-macros]
<stdin>:22: warning: macro "__IGNORE_lstat64" is not used [-Wunused-macros]
<stdin>:75: warning: macro "__IGNORE_llseek" is not used [-Wunused-macros]
<stdin>:159: warning: macro "__IGNORE_madvise1" is not used [-Wunused-macros]
  CALL    scripts/atomic/check-atomics.sh
  DESCEND objtool
  CC [M]  drivers/net/can/usb/etas_es58x/es58x_core.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_core.c:13:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
  CC [M]  drivers/net/can/usb/etas_es58x/es581_4.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es581_4.c:12:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
  CC [M]  drivers/net/can/usb/etas_es58x/es58x_fd.o
In file included from ./include/linux/bitops.h:33,
                 from ./include/linux/kernel.h:22,
                 from drivers/net/can/usb/etas_es58x/es58x_fd.c:14:
./arch/x86/include/asm/bitops.h:283:28: warning: declaration of 'ffs'
shadows a built-in function [-Wshadow]
  283 | static __always_inline int ffs(int x)
      |                            ^~~
  LD [M]  drivers/net/can/usb/etas_es58x/etas_es58x.o

The output gets reduced from 375 lines to only 30 lines.

This is a tremendous life improvement for me (considering the ffs
shadowing, I would also like to fix it, but this is not the topic
here).  Generally speaking, when I develop a new file, I would
like to periodically compile it at W=2 but the warnings for
linux/bits.h makes it painful (to stay polite).

As mentioned in the patch, linux/bits.h is responsible for 164714
W=2 warnings tree wide. So I guess that many other developers who
have a W=1 clean project would be reluctant to address the W=2
due to the polluted output.


> NAK.

Are you willing to change your decision following my comments?


Yours sincerely,
Vincent Mailhol
