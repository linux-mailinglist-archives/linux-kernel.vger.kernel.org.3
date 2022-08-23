Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D245A59ED8C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbiHWUli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiHWUlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:41:02 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901E01014
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:31:32 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-335624d1e26so410455737b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 13:31:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=FvOQiT0TsbXNUArqe4thB3SqDZo6X/Lj2phpd0Hb6sc=;
        b=tsUki6rLVe8OJMkrVaW2RbKF20cfN9cd+DVRnoWuMuIJ9ybwhjRmbxome3lclrjolT
         HvF5SzKGpxkmjscEdc6LYSjWcXQ71HZVrHJvhfAWN3lEUNZhwjOyRRRbCcimjWf5Vv/a
         Nk8m75nTB7lGMyp6U4vyVNM2J6umDdxq8qbrHDV5xjzbhkIL35NE0R9s+I0YwAz6063x
         dlf8Hc8/D7SG6iISN7Ic4ffsbM/kr/gCph/9NY+OaRRDe0sq2VIRgIJmRJ3dLnW5Gvq6
         NVFLMVj8KtS7cUypmU052vVRbF8P2wcg8R3P3cHifjyhucqqhaoSmj3QYidDaZN26qq7
         gXtA==
X-Gm-Message-State: ACgBeo0qEz+MzbI0JDceodzoN2dGl0s52ashicnDbbPp7UIex0IGp8tr
        6xzBUZaq/t93FMuRzvA8fMFtikPMv0BjMWt6/9g=
X-Google-Smtp-Source: AA6agR6q56i0cQRjgvbMl29HdVBJzNz3wM0i/Vh6AJG7KbArhisaujcGwstd41SPk7iZmpWjD50jFAxmXzZlQ2jes1o=
X-Received: by 2002:a25:7455:0:b0:68e:e73f:5fd5 with SMTP id
 p82-20020a257455000000b0068ee73f5fd5mr24329275ybc.20.1661286691491; Tue, 23
 Aug 2022 13:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr> <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic> <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic>
In-Reply-To: <YwUR35I7+5JbLvMM@zn.tnic>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 24 Aug 2022 05:31:20 +0900
Message-ID: <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] x86/asm/bitops: __ffs,ffz: use __builtin_ctzl to
 evaluate constant expressions
To:     Borislav Petkov <bp@alien8.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 24 Aug. 2022 at 02:43, Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Aug 23, 2022 at 10:12:17AM -0700, Nick Desaulniers wrote:
> > Callers of these need to guard against zero input, as the pre-existing
> > comment notes:
> >
> > >> Undefined if no bit exists, so code should check against 0 first.

If the fact that __ffs(0) is undefined is a concern, I can add a safety net:

  #define __ffs(word) \
          (__builtin_constant_p(word) ? \
                  (unsigned long)__builtin_ctzl(word) +
BUILD_BUG_ON_ZERO(word): \
                  variable___ffs(word))

It will only catch the constant expression but still better than
nothing (this comment also applies to the other functions undefined
when the argument is zero).

Also, if this aspect was unclear, I can add a comment in the commit
log to explain.

> This is just silly.
>
> And then there's
>
>  * ffs(value) returns 0 if value is 0 or the position of the first
>  * set bit if value is nonzero. The first (least significant) bit
>  * is at position 1.
>  */
> static __always_inline int ffs(int x)
>
> Can we unify the two and move the guard against 0 inside the function
> or, like ffs() does, have it return 0 if value is 0?

There is an index issue. __ffs() starts at 0 but ffs() starts at one.
i.e.: __ffs(0x01) is 0 but ffs(0x01) is 1.
Aside from the zero edge case, ffs(x) equals __ffs(x) + 1. This
explains why __fss(0) is undefined.


Yours sincerely,
Vincent Mailhol
