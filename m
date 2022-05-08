Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB651EC5E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 11:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbiEHJQ5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 May 2022 05:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbiEHJQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 05:16:55 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B137213
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 02:13:05 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id y2so19962401ybi.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 02:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SDA5FDwJEY6Sjd/rkwLVsRftMm4AEBLlTFhWKOrKnGI=;
        b=K2jQ1dIxTHKKZibVnhI655NTti5v3Yp1r+wOKCXVdl1ps/RHSCSt0IRb3+RYTMeOf8
         rGZq2jbf12oM2VctmBccpSlFESONVHz6FhSxbTDb3vpYQJC2gm+D0Y36x08HpdMlxYLK
         rF+AYZGaeFpWsPOTEd3FyNIfDKmPApf15T8Wsd2WXi7CuwNdbW86Pok+g3WLCHdzHm0k
         emScVLc6U6sc/97ZgMZ6aXweyJ+g9a+gEfkOwWiGXqwroeA6cpyZN1lkiAJ0YJuluKvD
         9FdY/MKImKR5k8ko7qSj5cIjB4TnDmpmxbn3O9/tUPTmvaW9F7ybzFt3Pf4vuwl3DIxO
         Yy5Q==
X-Gm-Message-State: AOAM530qZoPAoZJyD68Y3wQSTsnijD9u611M8Ef1bQ0/xoGSv7GPCNqj
        qYOup+cJDdmUmqqUK3GwRL28v8Pk4ywEVBQ92DI=
X-Google-Smtp-Source: ABdhPJx9MKoVtBYpwIoXWHMsHISNVJu/qkB/setlD6JoVsH0YHfGW9J9KOAaP984WgYMFZQkcNe1wZrkTm5E8P5oX0A=
X-Received: by 2002:a25:e705:0:b0:645:781a:f870 with SMTP id
 e5-20020a25e705000000b00645781af870mr8262403ybh.630.1652001183959; Sun, 08
 May 2022 02:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
 <YmhZSZWg9YZZLRHA@yury-laptop> <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
In-Reply-To: <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Sun, 8 May 2022 18:12:52 +0900
Message-ID: <CAMZ6RqJm7RCEadisHPUc8kQj2WLE2BQgXQ7b3ooNVxK5O6BL9Q@mail.gmail.com>
Subject: Re: [PATCH] linux/find: ignore -Wtype-limits to reduce W=2 warnings
 by 34% tree-wide
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, gcc@gcc.gnu.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 27 Apr 2022 at 11:58, Vincent MAILHOL
<mailhol.vincent@wanadoo.fr> wrote:
> + Alexander Lobakin <alexandr.lobakin@intel.com>
> On Wed. 27 Apr 2022 at 05:42, Yury Norov <yury.norov@gmail.com> wrote:
> > + gcc@gcc.gnu.org
> > + Rikard Falkeborn <rikard.falkeborn@gmail.com>
> >
> > On Wed, Apr 27, 2022 at 01:16:58AM +0900, Vincent Mailhol wrote:
> > > find_first_bit(), find_first_and_bit(), find_first_and_bit() and
> > > find_first_and_bit() all invokes GENMASK(size - 1, 0).
> > >
> > > This triggers below warning when compiled with W=2.
> > >
> > > | ./include/linux/find.h: In function 'find_first_bit':
> > > | ./include/linux/bits.h:25:36: warning: comparison of unsigned
> > > | expression in '< 0' is always false [-Wtype-limits]
> > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > |       |                                    ^
> > > | ./include/linux/build_bug.h:16:62: note: in definition of macro
> > > | 'BUILD_BUG_ON_ZERO'
> > > |    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > > |       |                                                              ^
> > > | ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
> > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > |       |                 ^~~~~~~~~~~~~~
> > > | ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > > |    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > |       |          ^~~~~~~~~~~~~~~~~~~
> > > | ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
> > > |   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > |       |                                             ^~~~~~~
> > >
> > > linux/find.h being a widely used header file, above warning show up in
> > > thousand of files which include this header (either directly on
> > > indirectly).
> > >
> > > Because it is a false positive, we just silence -Wtype-limits flag
> > > locally to remove the spam. clang does not warn about it, so we just
> > > apply the diag_ignore() directive to gcc.
> > >
> > > By doing so, the warnings for a W=2 build are reduced by
> > > 34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
> > > allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
> > > and after: 340097.
> > >
> > > For reference, past proposal to modify GENMASK_INPUT_CHECK() was
> > > rejected in:
> > > https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/
> >
> > So, here is nothing wrong with the kernel code and we have an alternative
> > compiler (clang) that doesn't throw Wtype-limits. It sounds to me like an
> > internal GCC problem, and I don't understand how hiding broken Wtype-limits
> > on kernel side would help people to improve GCC.
> >
> > On the thread you mentioned above:
> >
> > > > > > Have you fixed W=1 warnings?
> > > > > > Without fixing W=1 (which makes much more sense, when used with
> > > > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > > > >
> > > > > How is this connected?
> > > >
> > > > By priorities.
> > > > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> > >
> > > *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> > > if speaking of priorities.
> > >
> > > I do not understand why I should be forbidden to fix a W=2 in the
> > > file which I am maintaining on the grounds that some code to which
> > > I do not care still has some W=1.
> >
> > If you are concerned about a particular driver - why don't you silence
> > the warning in there? Or alternatively build it with clang?
>
> Sorry if my previous comments looked selfish. I used the first
> person to illustrate my point but because this W=2 appears in
> thousands of files my real intent is to fix it for everybody, not
> only for myself.
>
> > With all that, I think that the right way to go is to fix the root
> > cause of this churn - broken Wtype-limits in GCC, and after that move
> > Wtype-limits to W=1. Anything else looks hacky to me.
>
> Why is this use of __diag_ignore() hacky compared when compared
> to the other use of __diag_ignore() or the use of -Wno-something
> in local Makefiles?
>
> I did my due diligence and researched GCC’s buzilla before
> sending this patch. There is an opened ticket here:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86647

I would like to withdraw the above statement. After looking
deeper, this is not related to the GCC bug in the above link.

I was misled by the __is_constexpr() in GENMASK_INPUT_CHECK():

| #define GENMASK_INPUT_CHECK(h, l) \
|     (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
|         __is_constexpr((l) > (h)), (l) > (h), 0)))

and because of that, I was assuming that the parameters were
constant.

But actually, in the expression GENMASK(size - 1, 0), the first
member is not necessarily constant. The thing is that the warning
check occurs before the evaluation of __builtin_choose_expr() and
so, it sees the comparaison (l) > (h) and triggers the warning
even if the expression is not constant and will be eventually
discarded later.

On the contrary, for example, GENMASK(9U, 0) works fine (no
warning).

GCC man pages says:

| -Wtype-limits:
|       Warn if a comparison is always true or always false due
|       to the limited range of the data type, but do not warn
|       for constant expressions.  For example, warn if an
|       unsigned variable is compared against zero with "<"
|       or ">=".

So actually, GCC behaves exactly as expected here: emit a warning
when comparing a non-constant unsigned variable against zero.

In the particular case of GENMASK(), it is harmless, yes, but
regardless, -Wtype-limits is not broken here.

We might argue against the definition of -Wtype-limits, but I
personally think it is good as is so I will not push GCC guys to
fix what I do not consider anymore to be a bug on their side.

On GCC side, the only thing which could be changed would be to
evaluate __builtin_choose_expr() before checking for
warnings. But I doubt this is something feasible without creating
many side effects on performance.

If we refuse to modify GENMASK() or __diag_ignore() it, then all
I see left is to move -Wtype-limits to W=3.

> In a perfect word, yes, all false positives should be fixed in
> the compiler, but the reality is that this bug was reported in
> July 2018, nearly four years ago. GCC developers have their own
> priorities and fixing this bug does not appear to be part of
> those. And I do not have the knowledge of GCC's internals to fix
> this myself.  So what do we do next, blame GCC and do nothing or
> silence it on our side in order to have a mininfull W=2 output?
>
>
> Yours sincerely,
> Vincent Mailhol
