Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE6A5AA48C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbiIBAmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiIBAmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:42:05 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57487A1A75
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:42:04 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-33dc31f25f9so2983157b3.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8fC2rZWTgCYBntka/As3bCqt2A+cDoDbQGtV1oAG1Rc=;
        b=ER6EgofVxaIkfGpF5IPTjAU3nGc5gnsGWCFnIl+9d7a6tw4JZiLCjN5l5frKYONGtF
         2EHhBBk2iqkd7WJp0I4dN8LvUuL5eJ4P7oAV/x6+pE7CYI3SXLV6j7Ubinlqr1RYmKEq
         YyLIleN6U3nzXnAODOf9j1KlrUiHAO6vXNdN7yi/3JYhKHptUKJUrv2oqevEZtYG/G4z
         SuQRmYJ2lFikgajR6mzaACT5jOt3mOWBtobiIdscyqjePs4bPzlV8uZk8kvSm++I6axa
         BtoNdjEaED/OMi9cmRSApgjmOjFpJ7O10h1vta8lj74D/xXWJOhlV9L9+Ja00yVJsM+8
         DpHA==
X-Gm-Message-State: ACgBeo00poazeqR5J8b7elAJjs3F9C3r+FM7z+xkaDl4KRuArI8Ldm/x
        U52XrpzOo4HUG2JctP2UBDXK/HV4tMQweV6NL7c=
X-Google-Smtp-Source: AA6agR4qmd4h+RQhX/5BiuXjh/WdzAhWTCrnHQLr66XukbfP+zqT2pWK5eS96aPP7+tD4XVdijaxbYnRq1d49FV1B34=
X-Received: by 2002:a81:4ccf:0:b0:32f:cccf:cef7 with SMTP id
 z198-20020a814ccf000000b0032fcccfcef7mr25416327ywa.191.1662079323488; Thu, 01
 Sep 2022 17:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr> <Yw8hJS9f6SofG4/6@yury-laptop>
 <YxArx4UGoSQXljQd@yury-laptop> <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
 <YxC+eShQLDor0B9D@yury-laptop>
In-Reply-To: <YxC+eShQLDor0B9D@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Fri, 2 Sep 2022 09:41:52 +0900
Message-ID: <CAMZ6RqJs0Ujg3hTSURbtueynhAh_-pqwyzemytLeq1i0Kq2ufg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] x86/asm/bitops: optimize ff{s,z} functions for
 constant expressions
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, David Howells <dhowells@redhat.com>,
        Jan Beulich <JBeulich@suse.com>,
        Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        Joe Perches <joe@perches.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu. 1 Sep. 2022 at 23:19, Yury Norov <yury.norov@gmail.com> wrote:
> On Thu, Sep 01, 2022 at 07:30:10PM +0900, Vincent MAILHOL wrote:
> > On Tue. 1 sept. 2022 at 12:49, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Wed, Aug 31, 2022 at 01:54:01AM -0700, Yury Norov wrote:
> > > > On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> > > > > The compilers provide some builtin expression equivalent to the ffs(),
> > > > > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > > > > assembly which produces better code than the builtin
> > > > > functions. However, such assembly code can not be folded when used
> > > > > with constant expressions.
> > > > >
> > > > > This series relies on __builtin_constant_p to select the optimal solution:
> > > > >
> > > > >   * use kernel assembly for non constant expressions
> > > > >
> > > > >   * use compiler's __builtin function for constant expressions.
> > > > >
> > > > >
> > > > > ** Statistics **
> > > > >
> > > > > Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> > > > > of __ffs() and ffz() calls (details of the calculation in each patch).
> > > >
> > > > Hi Vincent,
> > > >
> > > > Can you please add a test for this? We've recently added a very similar
> > > > test_bitmap_const_eval() in lib/test_bitmap.c.
> > > >
> > > > dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
> > > > assertions")
> > > >
> > > > Would be nice to have something like this for ffs() and ffz() in
> > > > lib/test_bitops.c.
> > > >
> > > > Please keep me in loop in case of new versions.
> >
> > Hi Yury,
> >
> > My patch only takes care of the x86 architecture.
>
> OK, I just realized that you started submitting this at least back in May.
>
> For me, v6 is good enough and well-described. So, for the series:
> Reviewed-by: Yury Norov <yury.norov@gmail.com>

Thanks for the review!

> How are you going to merge it? If you haven't a specific tree in mind
> already, I can take it in my bitmap tree because  ffs and ffz are closely
> related to find_bit() functions.

I never thought of a specific tree. I just CCed the x86 architecture
maintainers according to get_maintainer.pl and was expecting it to go
through the x86/asm branch of the tip tree. But I am perfectly fine if
it goes through your tree.

So same as Nick's comment below, unless Borislav still has concern on
the v6, please take it in your tree.

> > Assuming some other
> > architectures are not optimized yet, adding such a test might break
> > some builds. I am fine with adding the test, however, I will not write
> > patches for the other architecture because I do not have the
> > environment to compile and test it.
> >
> > Does it still make sense to add the test before fixing all the architectures?
>
> All-arches fix should begin with changing the ffs design. Namely, there
> should be a generic ffs() in include/linux/bitops.h,

Currently, the generic ffl, ffs, flz are under:
/include/asm-generic/bitops

especially, here is the generic ffs():
https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bitops/ffs.h

Isn't this sufficient?

> and arch-specific
> arch__ffs() in arch/xxx/include/asm/bitops.h; like we do for the set_bit()
> family. I have a feeling that it's far beyond the scope of your series.
>
> The test is a different story. Good tests are always welcome, even if
> they don't cover all the arches.

ACK. I will add the test in a different patch *after* this series gets
accepted. But to be clear, I will not fix other architectures.

> > > Also, what about fls? Is there any difference with ffs/ffz wrt compile
> > > time optimizations? If not, would be great if the series will take
> > > care of it too.
> >
> > Agree. The fls() and fls64() can use __builtin_ctz() and
> > __builtin_ctzll(). However, those two functions are a bit less
> > trivial. I wanted to have this first series approved first before
> > working on *fls*().
>
> OK, the test and fls() can be a matter of a follow-up series, taking
> into account how long are these 2 patches moving.

ACK.

> Thanks,
> Yury
