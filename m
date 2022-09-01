Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276B75A94A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbiIAKa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiIAKaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:30:24 -0400
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C0BD117
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:30:22 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id e71so7983276ybh.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=o0dNB2dEotiHbBAgc7JJeptZGUlaTEB/UzQJO7GfLf0=;
        b=bspJqr6d2pNTsTde3J/UZTklopjaOq0xQ657lWZba3kWfZ39ts0XRC6i0lMDVKm1/a
         lmSUBSAs+KvDq6OOV0bVfk3iClwt0D2Bmukd23jGf3Xp6MFkGWFc9uBjb5GRShZDEwCJ
         z6W9dRPllVhxxz2y5dVE6sG9qn1JwnxqGDAq6qP0ArJ5wh7oH6AO4Iqg86PvFjVkfd78
         sQqc2MjhRojfpnRh0hzRLrqsxyf/MUeBi6MGHqG70yVSBpa13NKBAdpprvNIYXYxqO4u
         SmFGHGrzO2+SOYzVGggZ4p8I8h6G/Ic/68W2dkCqiQXL4QLOp3lngn/RjSmG2w98Ged0
         m6rw==
X-Gm-Message-State: ACgBeo1ZL4r5F6//ba0oN9gv9Dj/pKXJNSj3kmKvWaLJPxD0un4149Dw
        a5ZiLibGovDJJ2+RLKUt2+UooS9vkssvWI7G97M=
X-Google-Smtp-Source: AA6agR4eU/leGtZXqINtxP77iUKDVvRtNJm8A9wHt1oClNaG3THlQmhcG79vWTs7fJxTbIYhOgNqLGK9Xo6zlfsq7M8=
X-Received: by 2002:a25:34d8:0:b0:6a2:2cc3:3b2d with SMTP id
 b207-20020a2534d8000000b006a22cc33b2dmr431315yba.142.1662028221974; Thu, 01
 Sep 2022 03:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220831075742.295-1-mailhol.vincent@wanadoo.fr> <Yw8hJS9f6SofG4/6@yury-laptop>
 <YxArx4UGoSQXljQd@yury-laptop>
In-Reply-To: <YxArx4UGoSQXljQd@yury-laptop>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Thu, 1 Sep 2022 19:30:10 +0900
Message-ID: <CAMZ6Rq+XVWGEEHr9t5dkXN0E36hkpMb5kNEZJmMFgtJxyQntsg@mail.gmail.com>
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

On Tue. 1 sept. 2022 at 12:49, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Aug 31, 2022 at 01:54:01AM -0700, Yury Norov wrote:
> > On Wed, Aug 31, 2022 at 04:57:40PM +0900, Vincent Mailhol wrote:
> > > The compilers provide some builtin expression equivalent to the ffs(),
> > > __ffs() and ffz() functions of the kernel. The kernel uses optimized
> > > assembly which produces better code than the builtin
> > > functions. However, such assembly code can not be folded when used
> > > with constant expressions.
> > >
> > > This series relies on __builtin_constant_p to select the optimal solution:
> > >
> > >   * use kernel assembly for non constant expressions
> > >
> > >   * use compiler's __builtin function for constant expressions.
> > >
> > >
> > > ** Statistics **
> > >
> > > Patch 1/2 optimizes 26.7% of ffs() calls and patch 2/2 optimizes 27.9%
> > > of __ffs() and ffz() calls (details of the calculation in each patch).
> >
> > Hi Vincent,
> >
> > Can you please add a test for this? We've recently added a very similar
> > test_bitmap_const_eval() in lib/test_bitmap.c.
> >
> > dc34d5036692c ("lib: test_bitmap: add compile-time optimization/evaluations
> > assertions")
> >
> > Would be nice to have something like this for ffs() and ffz() in
> > lib/test_bitops.c.
> >
> > Please keep me in loop in case of new versions.

Hi Yury,

My patch only takes care of the x86 architecture. Assuming some other
architectures are not optimized yet, adding such a test might break
some builds. I am fine with adding the test, however, I will not write
patches for the other architecture because I do not have the
environment to compile and test it.

Does it still make sense to add the test before fixing all the architectures?

> Also, what about fls? Is there any difference with ffs/ffz wrt compile
> time optimizations? If not, would be great if the series will take
> care of it too.

Agree. The fls() and fls64() can use __builtin_ctz() and
__builtin_ctzll(). However, those two functions are a bit less
trivial. I wanted to have this first series approved first before
working on *fls*().


Yours sincerely,
Vincent Mailhol
