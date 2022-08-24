Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2740A59F91C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiHXMLS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 Aug 2022 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236554AbiHXMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:11:13 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4E261D87
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:11:11 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-32a09b909f6so455076917b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:11:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=vssqVG+YXSj6gRHoUIAB1p3FH/P288mmnDBJ3dNJIZ0=;
        b=ST7809x4It6b+b0+y4SjtzCUVwIrWiFrleTxFScKo8rwu4N9YcrmO8j4iSPpEz1W8X
         +Z63UrK1/oxNXwzcU9fMJ/TmV4q3kPjzVon6+8DYWK/fFsaNcW0u2c850/5iIPUI1kNg
         estnEQEtue1vuywj8iQHVwL4j1uD0N9tUGSrqnQQsL6e6pknpFhlvq4ZrthvTm4W373v
         VL+zoLa6EXSswzFsi0IC5fr9j5/j7lvmxEM0XRRx+xtQ4M5VZvQ5cLQGsX/VeXjmhbtt
         38/GJ9lcE9Knf33dQyMOxCKHDsiOYn1LV37Am3KHAiGYIXXQEOeiCejY7py+rcnUdMTz
         /B1w==
X-Gm-Message-State: ACgBeo3bzex1IkUOh4I1A+dLjWC+1UtlO34C/8XJtAmhb97SUB84z/4V
        YpsHyMZ4bKzSSeaqT/uVjtafHPugxqk8Xm309lw=
X-Google-Smtp-Source: AA6agR5kmKkOGbn2J8y1sxBjTA119Piw2hUCIQEiQwTZC9CaH7kY8xIkNNeIvXFpm30T/Ek1vZc/VUCo71ffO7etAy0=
X-Received: by 2002:a81:6f43:0:b0:335:9e7e:ad25 with SMTP id
 k64-20020a816f43000000b003359e7ead25mr30442176ywc.518.1661343070674; Wed, 24
 Aug 2022 05:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220511160319.1045812-1-mailhol.vincent@wanadoo.fr>
 <20220812114438.1574-1-mailhol.vincent@wanadoo.fr> <20220812114438.1574-3-mailhol.vincent@wanadoo.fr>
 <YwT+5GGCOKoTjfQZ@zn.tnic> <CAKwvOdnc-Js8x4sv0j23crtYP73sRkNexom5ydm=r=8rYgc_5Q@mail.gmail.com>
 <YwUR35I7+5JbLvMM@zn.tnic> <CAMZ6Rq+-Ld41cXt+Qy3a7nkQrDp3RK-BJYW0j=HCyKH-x9S3tw@mail.gmail.com>
 <YwXkuW3rSYY7ZJT+@zn.tnic>
In-Reply-To: <YwXkuW3rSYY7ZJT+@zn.tnic>
From:   Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date:   Wed, 24 Aug 2022 21:10:59 +0900
Message-ID: <CAMZ6RqLugOnskOpyUS6OjdcdnwoXz-E8Bsw2qNaabDPYJ=139A@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed. 24 Aug 2022 at 17:43, Borislav Petkov <bp@alien8.de> wrote:
> On Wed, Aug 24, 2022 at 05:31:20AM +0900, Vincent MAILHOL wrote:
> > If the fact that __ffs(0) is undefined is a concern,
>
> So what is of concern is I'm looking at those *ffs things and they look
> like a real mess:

I agree that the thing is a mess. Especially the naming: adding
underscores when the behaviour is different is misleading. I think
that ctzl() would have been a better name than __ffs().

>  * Undefined if no bit exists, so code should check against 0 first.
>  */
> static __always_inline unsigned long __ffs(unsigned long word)
> {
>         asm("rep; bsf %1,%0"
>
> and that's TZCNT.

Not exactly, this is TZCNT for x86_64 but for x86, it will be BSF…

> And nowhere in TZCNT's description does it talk about undefined behavior
> - it is all defined.
>
> So I have no clue what that comment is supposed to mean?

It means that __ffs() is not a x86_64 specific function. Each
architecture is free to provide an optimized implementation and are
free to ignore __ffs(0) because this is undefined.
For ffs(0) to be defined, every architecture would have to produce the
same result, and this is not the case.

> Then:
>
>  * ffs - find first set bit in word
>  * @x: the word to search
>  *
>  * This is defined the same way as the libc and compiler builtin ffs
>  * routines, therefore differs in spirit from the other bitops.
>  *
>  * ffs(value) returns 0 if value is 0 or the position of the first
>  * set bit if value is nonzero. The first (least significant) bit
>  * is at position 1.
>
> while
>
> "Built-in Function: int __builtin_ctz (unsigned int x)
>
>     Returns the number of trailing 0-bits in x, starting at the least significant bit position. If x is 0, the result is undefined."
>
> as previously pasted.
>
> So ffs() doesn't have undefined behavior either.
>
> I guess it wants to say, it is undefined in the *respective* libc or
> compiler helper implementation. And that should be explained.
>
> > I can add a safety net:
>
> Nah, no need. It seems this "behavior" has been the case a long time so
> callers should know better (or have burned themselves properly :)).
>
> > There is an index issue. __ffs() starts at 0 but ffs() starts at one.
> > i.e.: __ffs(0x01) is 0 but ffs(0x01) is 1.
> > Aside from the zero edge case, ffs(x) equals __ffs(x) + 1. This
> > explains why __fss(0) is undefined.
>
> I'd love to drop the undefined thing and start counting at 1 while
> keeping the 0 case the special one.
>
> But that ship has sailed a long time ago - look at all the __ffs() and
> ffs() callers.

ACK. I do not believe that this is something which can be changed now.
At least, I am not willing to start such a crusade.

> Back to your patch: I think the text should be fixed to say that both
> ffs() and __ffs()'s kernel implementation doesn't have undefined results

NACK. __ffs(0) is an undefined behaviour (c.f. TZCNT instruction for
x86_64 and BSF instruction for x86). Even if x86_64 and x86 had the
same behaviour that would still not be OK as it may fool developers
into believing that __ffs(0) is defined kernel wide and would result
in non portable code.

> but since it needs to adhere to the libc variants' API, it treats 0
> differently. They surely can handle 0 as input.
>
> I.e., I'd like to see a comment there explaining the whole difference
> between ffs() and __ffs() so that people are aware.

This would be helpful but the priority would then be to modify asm-generic:
https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bitops/__ffs.h#L11

Regardless, I do not think that the comment of __ffs() and ffs() is
related to this patch series.

> Btw, pls do
>
> s/variable___ffs/variable__ffs/g
>
> Two underscores are just fine.

OK for me. The rationale was to name it variable_<function_name>()
thus the three underscores. But I will also be happy with two
underscores.


Yours sincerely,
Vincent Mailhol
