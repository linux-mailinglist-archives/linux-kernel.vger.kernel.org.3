Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC5F4DCE17
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiCQSyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiCQSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:54:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD4E2220F9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:52:47 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id y17so8418151ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWE7ZJ9hpebJWcE2cZFbACGv2btEDEVbeAE9VoY9EiI=;
        b=CZfJIPwgLVlnZ/hWoJNx1l13U+oWobomaEsiXFNSc3E9eB53oh+jwCoQRkojtujA1b
         ktLaaOnQ8y1nP8beK9ieQ2wFmdLtKQa0yIPe/u6fYJgi6W2gs7AI0IbdWZpJKUE4/Fry
         hlRz2iZhPfT3IxS9LxKkes0PVNWKqbbL9G08w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWE7ZJ9hpebJWcE2cZFbACGv2btEDEVbeAE9VoY9EiI=;
        b=zQ3d6lQCJt017IbLw302bhAf4u0rBKzPkIPDT6/Vv8ENpRBBTdD4KgKLz7gd/iaXUS
         crqaOtipIf1Rrjc0WuedkiRInF/h1VfjmCNo/UAc5FLLO7LGCdpxw5C8UsvNY7j9JXp3
         N5L/wAEJ/NT3fOgXTzMOdgBdwsquscl2CbDuscjjdFdcQHbr1b+lz1GvBrTppQRK6xot
         V7hyEhVWqTnyNB+gJX5L32FFTN442ogcM+kUaIYaOUqcgh/Et3uJFiAW1craYoHkHh2f
         6b5MOHgN1JkwLv+DUUpXfos8m8Zg3KRAgxYuumSIGlt7WCWSiHeN46amP2npkCytNWQy
         lVCw==
X-Gm-Message-State: AOAM533Aj1xM4rmP9aEW6ST8vB/zZbpKKXEsInrnHtTXtG8L8ukv2pAG
        UV88ui/fIioGz8E6KsmOUpMWmGCoYck5QiUd
X-Google-Smtp-Source: ABdhPJwmIo+QAZ1dqXKkBWS8Tjyyb6ZXhnWQ9wzA5V7a5mYOg4TQviWtc4DQNsEnPRGZuNx/kl823g==
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id e9-20020a2e5009000000b00247d7383e90mr3887692ljb.229.1647543165275;
        Thu, 17 Mar 2022 11:52:45 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id bu9-20020a056512168900b004489c47d241sm508033lfb.32.2022.03.17.11.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 11:52:43 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w12so10522253lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:52:43 -0700 (PDT)
X-Received: by 2002:ac2:4203:0:b0:448:8053:d402 with SMTP id
 y3-20020ac24203000000b004488053d402mr3728431lfh.687.1647543162903; Thu, 17
 Mar 2022 11:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
In-Reply-To: <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 11:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
Message-ID: <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ I got cc'd in the middle of the discussion, so I might be missing
some context or pointing something out that was already discussed ]

On Thu, Mar 17, 2022 at 11:00 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> > >One change you may see due to this patch is the compiler moving the
> > >"pop %..." instruction away from the "pushf" instruction. This could
> > >happen if the compiler determines that it could produce better code by
> > >doing so---e.g. to reduce register pressure. The "gcc -O2" example
> > >below shows this code movement.

Honestly, that part worries me a _lot_.

Why?

Because clang in particular has already messed up eflags handling
once, by spilling condition codes (in the form of eflags) onto the
stack, and then loading them later with a "popf".

And it did so across a function call THAT MODIFIED 'IF'. This was a
major bug in clang back in 2015 or so, and made it unusable for the
kernel.

See for example

    https://lore.kernel.org/all/CA+icZUU7y5ATSLV_0TGzi5m5deWADLmAMBkAT32FKGyUWNSJSA@mail.gmail.com/

for some kernel discussion, and separately

    https://lists.llvm.org/pipermail/llvm-dev/2015-July/088774.html

for just llvm discussions.

It is perhaps telling that the LLVM discussion I found seems to talk
more about the performance impact, not about the fact that THE
GENERATED CODE WAS WRONG.

That compiler bug would basically enable or disable interrupts in
random places - because clang developers thought that 'eflags' is only
about the condition codes.

> EFLAGS is defined as the lower 16 bits of FLAGS register, yeah?

No. EFLAGS is a 32-bit register.

A lot of the high bits end up being reserved, but not all of them. AC,
VIF/VIP are all in the upper 16 bits.

Also:

> So I don't understand your point; the finest grain resolution
> the compiler has to work with is the whole EFLAGS register, not
> individual bits like IF, DF, or AC.  (I triple checked this with the
> maintainer of LLVM's x86 backend)

You can actually operate on EFLAGS at multiple granularities.

 - normal pushf/popf. Don't do it unless you are doing system software.

 - You *can* (but you really *really* should not) operate on only the
lower 16 bits, with "popfw". Don't do it - it doesn't help, requires
an operand size override, and is just bad.

 - you can use lahf/sahc to load/store only the arithmetic flags
into/from AH. Deprecated, and going away, but historically supported.

 - you can obviously use arithmetic and setcc to modify/read the
arithmetic flags properly.

A compiler should NEVER think that it can access eflags natively with
pushf/popf. Clang thought it could do so, and clang was WRONG.

The absolutely only case that a compiler should ever worry about and
do is that last case above: arithmetic instructions that set the
flags, and 'jcc', 'setcc', 'cmov', 'adc' etc that test it./

Yes, yes, that complete mental breakdown with pushf/popf did get
fixed, but it really makes me very wary of thinking that we should
ever use a built-in that compiler writers really fundamentally got so
wrong before.

What would make me think that you'd get it right now? In user space,
you'll basically never actually see the whole system flags issues, so
your test-cases would never work or be very contrieved. You'd have to
really work at it to see the problems.

> > The memory barrier is needed for IF changes, for example.
>
> Shouldn't native_irq_disable/native_irq_enable be declaring that they
> clobber "cc" then?
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers

No. Once again: compilers don't understand system flags in eflags.

In fact, gcc pretty much documents that "cc" clobbers doesn't do
anything on x86, and isn't needed. It just assumes that the arithmetic
flags always get clobbered, because on x86 that's pretty much the
case. They have sometimes been added for documentation purposes in the
kernel, but that's all they are.

So you can find that "cc" clobber in a few places in the kernel, but
it's pointless.

The reason pushf/popf need to have a memory clobber is so that the
compiler will not move it around other things that have memory
clobbers.

Because memory clobbers are things that compilers *UNDERSTAND*.

Put another way: when you see that "memory" clobber in an inline asm,
don't think that it means "this modifies or uses memory".

That may be the documentation, and that may be how compiler people
think about them, but that's just wrong.

What *kernel* people think is "this makes the compiler not do stupid things".

Because compilers really don't understand things like system registers
and system flags, and the subtle issues they have, and the ordering
requirements they have. Never have, and never will.

And compilers really don't understand - or care about - things like
"cc", because compiler people think it's about arithmetic flags, and
would do things like "oh, I'll just save and restore the flags over
this since the asm modifies it".

Note that "eflags" is just the tip of the iceberg here. This is true
for a lot of other cases.

Yes, when you have something like a "disable interrupts", the compiler
really must not move memory accesses around it, because the interrupt
flag may in fact be protecting that memory access from becoming a
deadlock.

But the whole "you can't move _other_ things that you don't even
understand around this either" is equally important. A "disable
interrupts" could easily be protecting a "read and modify a CPU MSR
value" too - no real "memory" access necessarily involved, but
"memory" is the only way we can tell you "don't move this".

Particularly since both the clang people and gcc people have actively
been trying to weaken the "volatile" semantics (which would have
generally been the logically consistent model - thinking if inline asm
to be visible in the machine model, and not being able to move them
around for those reasons).

> > This feels like "let's fix LLVM by hacking the kernel in dangerous ways" once again!
>
> Even if the behavior of llvm was changed, you'd _still_ get better
> codegen for _both_ compilers by using the intrinsics.

No.

"moving instructions around a bit" is not better code generation when
the end result DOES NOT WORK.

And honestly, we have absolutely zero reason to believe that it would work.

If it turns out that "pop to memory" is a big deal for performance,
let's just change the "=rm" to "=r" and be done with it. Problem
solved. We already used to do that on the "pushf" side, but these days
we avoid "popfl" entirely and do a conditional jump over a "sti"
instead.

Because maybe moving that "pop" by a few inbstructions helps a bit,
but if you move the "pushf" noticeably, you've just created a big big
problem.

A bug you've had once already.

                 Linus
