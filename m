Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF7A512B42
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243458AbiD1GJr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 28 Apr 2022 02:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbiD1GJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:09:41 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1921D25C4D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:06:26 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-2f7d621d1caso41441457b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=APPD6QTkyORQ7TyPOP/Uba+9M6fAiKD2mBI+axZPK2k=;
        b=1zgWW8K4XkdLOa1dhmVnTihFOt0ElP9NLKW0sok8++CJp1SvwFj0VJXuyNKs6Ps9CY
         BLKECmw23MAVp/xDFT6tBfnMRgWfO0rf0UgK5GwqwK7EBJovoP7zpXFU+ecaifVp/uUe
         XZ2+mqck+dnAXW+5xrhTBSfTKuO3gp8jmxVDOZFMRvVkKIrT58gdMc99VRpz/Y8b+LUJ
         SsYrZ2OvW8Eg9JIbr0z0fwQ3kBVa6omb8tGCjO/jTHaXihEH5tev3VJkwzBlVRDAgEsu
         UenZ3Nns8PuzsG0CyhQjSEA+Fp2tuPctLFQxRWi0YPlyPrhsmLAxeb6LoGtBdjN6RS/Y
         CTQQ==
X-Gm-Message-State: AOAM530sKg+UHaXX7NHbYekcMNyiHHGJ1JfnjzAkYTqm4+HZf9McVTUy
        L30F1dDN/qfoCHk40Sb8fl+u/MyPBzu0rs2ZP0U=
X-Google-Smtp-Source: ABdhPJz/L2PgYTqs3UNI7zK+hLZyWlCVYo7c6aDU5AKb7/oeqMNhvyZ2GqjQ4vkm8C13SmAsyX6OMLfrdzP15IhMNUg=
X-Received: by 2002:a81:34f:0:b0:2f7:bbb1:1576 with SMTP id
 76-20020a81034f000000b002f7bbb11576mr27403494ywd.45.1651125984895; Wed, 27
 Apr 2022 23:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220426161658.437466-1-mailhol.vincent@wanadoo.fr>
 <YmhZSZWg9YZZLRHA@yury-laptop> <CAMZ6RqJuUPuEJQvyHZr0Gxzh9ZZ2iACTHe3XE70jZ38hmePfuA@mail.gmail.com>
 <YmlNYt0qVgVPz1+2@yury-laptop>
In-Reply-To: <YmlNYt0qVgVPz1+2@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 28 Apr 2022 15:06:14 +0900
Message-ID: <CAMZ6RqL0UpNWodr8UmpDr4yd1nytgm_8jb68yOg+rZNSepYh=A@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 27 Apr 2022 at 23:04, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Apr 27, 2022 at 11:58:58AM +0900, Vincent MAILHOL wrote:
> > + Alexander Lobakin <alexandr.lobakin@intel.com>
> >
> > On Wed. 27 Apr 2022 at 05:42, Yury Norov <yury.norov@gmail.com> wrote:
> > > + gcc@gcc.gnu.org
> > > + Rikard Falkeborn <rikard.falkeborn@gmail.com>
> > >
> > > On Wed, Apr 27, 2022 at 01:16:58AM +0900, Vincent Mailhol wrote:
> > > > find_first_bit(), find_first_and_bit(), find_first_and_bit() and
> > > > find_first_and_bit() all invokes GENMASK(size - 1, 0).
> > > >
> > > > This triggers below warning when compiled with W=2.
> > > >
> > > > | ./include/linux/find.h: In function 'find_first_bit':
> > > > | ./include/linux/bits.h:25:36: warning: comparison of unsigned
> > > > | expression in '< 0' is always false [-Wtype-limits]
> > > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > > |       |                                    ^
> > > > | ./include/linux/build_bug.h:16:62: note: in definition of macro
> > > > | 'BUILD_BUG_ON_ZERO'
> > > > |    16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> > > > |       |                                                              ^
> > > > | ./include/linux/bits.h:25:17: note: in expansion of macro '__is_constexpr'
> > > > |    25 |                 __is_constexpr((l) > (h)), (l) > (h), 0)))
> > > > |       |                 ^~~~~~~~~~~~~~
> > > > | ./include/linux/bits.h:38:10: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> > > > |    38 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> > > > |       |          ^~~~~~~~~~~~~~~~~~~
> > > > | ./include/linux/find.h:119:45: note: in expansion of macro 'GENMASK'
> > > > |   119 |                 unsigned long val = *addr & GENMASK(size - 1, 0);
> > > > |       |                                             ^~~~~~~
> > > >
> > > > linux/find.h being a widely used header file, above warning show up in
> > > > thousand of files which include this header (either directly on
> > > > indirectly).
> > > >
> > > > Because it is a false positive, we just silence -Wtype-limits flag
> > > > locally to remove the spam. clang does not warn about it, so we just
> > > > apply the diag_ignore() directive to gcc.
> > > >
> > > > By doing so, the warnings for a W=2 build are reduced by
> > > > 34%. Benchmark was done with gcc 11.2.1 on Linux v5.17 x86_64
> > > > allyesconfig (except CONFIG_WERROR). Beforethe patch: 515496 warnings
> > > > and after: 340097.
> > > >
> > > > For reference, past proposal to modify GENMASK_INPUT_CHECK() was
> > > > rejected in:
> > > > https://lore.kernel.org/all/20220304124416.1181029-1-mailhol.vincent@wanadoo.fr/
> > >
> > > So, here is nothing wrong with the kernel code and we have an alternative
> > > compiler (clang) that doesn't throw Wtype-limits. It sounds to me like an
> > > internal GCC problem, and I don't understand how hiding broken Wtype-limits
> > > on kernel side would help people to improve GCC.
> > >
> > > On the thread you mentioned above:
> > >
> > > > > > > Have you fixed W=1 warnings?
> > > > > > > Without fixing W=1 (which makes much more sense, when used with
> > > > > > > WERROR=y && COMPILE_TEST=y) this has no value.
> > > > > >
> > > > > > How is this connected?
> > > > >
> > > > > By priorities.
> > > > > I don't see much value in fixing W=2 per se if the code doesn't compile for W=1.
> > > >
> > > > *My code* compiles for W=1. For me, fixing this W=2 in the next in line
> > > > if speaking of priorities.
> > > >
> > > > I do not understand why I should be forbidden to fix a W=2 in the
> > > > file which I am maintaining on the grounds that some code to which
> > > > I do not care still has some W=1.
> > >
> > > If you are concerned about a particular driver - why don't you silence
> > > the warning in there? Or alternatively build it with clang?
> >
> > Sorry if my previous comments looked selfish. I used the first
> > person to illustrate my point but because this W=2 appears in
> > thousands of files my real intent is to fix it for everybody, not
> > only for myself.
>
> Globally, we have not yet fixed W=1, that's why W=2 isn't that important.
> (If the above statement is wrong - can someone explain me the logic of
> splitting warnings by levels?)

W=2 is important for the files which have their W=1 fixed. If W=2
output is blotted by warnings from include files, triage becomes
painful and W=2 loses its meaning.

Very lousy should be in W=3. Here I see a way to remove the noise
while still keeping this particular warning in W=2, which I think
is the best compromise.

If you want a very concrete example, in the past, I sent patch
[1] which modified 32 files. While doing so, I forgot to
initialize a stack variable (c.f. [2]). A W=2 would have caught
this issue (c.f. -Wmaybe-uninitialized). I would like to prevent
these issues from occurring again and having a less noisy W=2 is
a tremendous life improvement to do so.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc4b08c31b5c51352f258032cc65e884b3e61e6a
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c579792562837ec2e64b006cfc9423e4177a4d26

> Locally you cleared W=1, which is great, and I understand that you'd
> like to have clean W=2 too.
>
> > > With all that, I think that the right way to go is to fix the root
> > > cause of this churn - broken Wtype-limits in GCC, and after that move
> > > Wtype-limits to W=1. Anything else looks hacky to me.
> >
> > Why is this use of __diag_ignore() hacky compared when compared
> > to the other use of __diag_ignore() or the use of -Wno-something
> > in local Makefiles?
>
> __diag_ignore() is not hacky when it's well-justified. Globally
> there's a single user of __diag_ignore() - SYSCALL_DEFINE, and
> it looks well-justified to me:
>     The new warning seems reasonable in principle, but it doesn't
>     help us here, since we rely on the type mismatch to sanitize the
>     system call arguments. After I reported this as GCC PR82435, a new
>     -Wno-attribute-alias option was added that could be used to turn the
>     warning off globally on the command line, but I'd prefer to do it a
>     little more fine-grained.
>
> Locally, there are just 3 users of the macro in the codebase. All
> they appeal to local issues, i.e. don't shut up warnings because
> they are broken.
>
> In case of Wtype-limits, the proposed solution is hacky because it
> silences broken warning instead of fixing compiler.
>
> > I did my due diligence and researched GCC’s buzilla before
> > sending this patch. There is an opened ticket here:
> > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=86647
> >
> > In a perfect word, yes, all false positives should be fixed in
> > the compiler, but the reality is that this bug was reported in
> > July 2018, nearly four years ago. GCC developers have their own
> > priorities and fixing this bug does not appear to be part of
> > those. And I do not have the knowledge of GCC's internals to fix
> > this myself.  So what do we do next, blame GCC and do nothing or
> > silence it on our side in order to have a mininfull W=2 output?
>
> 1. Yes, do blame GCC and disable Wtype-limits locally where W=1
>    is clean.

NAK. I refuse to submit local changes when a global solution
exists.

It would require a bigger effort. Will also need to explain to
local branch maintainers why the fix should be local and not
global. And honestly, silencing three or four W=2 locally is not
worth the effort of creating the patch.

It will also be harder to manage. If GCC eventually fixes the
bug, we would have dozens of patches scattered all over the tree
to clean up.

> 2. Use clang.

As a matter of fact, GCC remains the default compiler for the
Linux kernel. Clang is optional.

Also, let me repeat: my intent is to improve life for others. I
patched GENMASK_INPUT_CHECK on my local tree, so I am fine. Just
want to avoid other people having to do it manually.

> 3. Move Wtype-limits to W=3.

Yes, if this patch gets rejected, I will do so. This is
absolutely not my favorite option though. By doing so, we will
lose the other relevant finding of -Wtype-limits. But I still
prefer this rather than doing nothing.

> 4. Test Wtype-limits in Makefile, and enable it if not broken.

Would be a good solution if results were inconsistent between
each version of GCC. Here, I don’t think we need to go this
far. Just using some ifdef CONFIG_CC_IS_CLANG
in Makefile.extrawarn should be enough to enable it at W=1 for
clang.

> My main objection is that this patch puts dirt in *my* selfish area
> of responsibility.

*selfish* summarises pretty well the global feeling this thread
gives me. Arguments such as it is not my fault, let’s blame
others or this does not benefit *my* area does not make the
discussion move forward.

Many patches are a trade off. I understand that this patch is
aesthetic, but I expect you to make a fair judgement of
benefit (removing one third of W=2) vs. drawback (adding
three "hacky" lines locally).

> The code that causes issues is GENMASK_INPUT_CHECK,
> but the suggested patch modifies find.h - an innocent random user.

My prefered approach is to modify GENMASK_INPUT_CHECK() which was
rejected. __diag_ignore() can not be applied inside
GENMASK_INPUT_CHECK(). find.h is the only header using the
pattern GENMASK_INPUT_CHECK(unsigned, 0), this is why I send a
patch for *your* area.

> The argument that we need to silence find_bit because it clears 34%
> of warnings doesn't work for me. Instead, we'd push GCC community
> to provide proper fix and clear 34% of warnings.

The fact is this bug seldomly occurs. Those 34% come from a
single line of code so why should it be a priority for GCC
guys? I will add a comment in GCC’s bugzilla. But I can not
control how GCC developers prioritize bug fixes.


With that said, it seems I will not be able to convince you
despite other people in this thread sharing my thoughts.
If you still reject this patch after those explanations, I will
not insist more and send another patch to move -Wtype-limits to
W=3 (not without regrets).


Yours sincerely,
Vincent Mailhol
