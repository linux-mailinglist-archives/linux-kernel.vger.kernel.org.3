Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A8B4DCF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiCQUPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCQUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:15:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B0B173F4F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:14:13 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w12so10857529lfr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1u5q2Fm4MKNSsi+YVIn0z3cE8RvugcBBiZ6jMBBsc+o=;
        b=Tv2P+GkdHQ/LpT1WXU2lG9YK+/viOPEc9xA3aFbRpn5HE8wBlRYZRSMfrlMRLReqn8
         FfQMBXciwuNxWmd88d70YuCLr0zVBwq3S5RTSCGUfYfmNs8iXpjiPwyWiiDO5PjwFKOb
         +/jwQ63ou7dGVUxmBColYJjRnqJvo+Ct4FjJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1u5q2Fm4MKNSsi+YVIn0z3cE8RvugcBBiZ6jMBBsc+o=;
        b=Hpe+0MdTRz5SfX5tRzRZNyeuXOaUYdYhoN6kG9A2stRJnh3ggnwD+YBUZ7795KMSkQ
         ZdTehPmmA6/+i/sE9hH94JFfMn/BKoKcGr4beF9VCwLse5BfM8JvJaNu2urJ+aA9zxm/
         PxAATk0s5ARZpceicInJ1D1YUR0fOI8MIlHav5v4tk4UmTDWZs5JTl6mFmdMbiBz6UK7
         yqbt4AAtiNaR4SB3pA46sBv8r3nA1cw2EFTeMb2ZnIJQiY3+u/GlCjx3GOM4WZyL6mj+
         kkPZZHRv2O1xc6DKD3Gj5g4H1vnWM6VktJ9EDeJiHxJGoz+cVlHhUtHTwJMx/ihY/3OI
         8Jgg==
X-Gm-Message-State: AOAM5310LvbyLy+HdImrT+EK9vLx9A/sGZ3U4lWbI6NKfx/Hb8NtJkk+
        acRhZTKmYz0vixNo52Pwsgc68DLYrESzPS6Bne0=
X-Google-Smtp-Source: ABdhPJwttrpDdn2RjQIOr9itk1JAXMXZd2VLWDBJNp+CYExHW7Y6f27DqK84/RdQ8IpiDimBTAgrRA==
X-Received: by 2002:a05:6512:2245:b0:44a:727:5fb with SMTP id i5-20020a056512224500b0044a072705fbmr646643lfu.665.1647548051646;
        Thu, 17 Mar 2022 13:14:11 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id m24-20020a197118000000b00448bb0df9ffsm460447lfc.140.2022.03.17.13.14.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 13:14:10 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id q5so8692405ljb.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:14:10 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr3952516lja.443.1647548049927; Thu, 17
 Mar 2022 13:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
In-Reply-To: <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 13:13:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
Message-ID: <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Thu, Mar 17, 2022 at 12:45 PM Bill Wendling <morbo@google.com> wrote:
>
> On Thu, Mar 17, 2022 at 11:52 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > But the whole "you can't move _other_ things that you don't even
> > understand around this either" is equally important. A "disable
> > interrupts" could easily be protecting a "read and modify a CPU MSR
> > value" too - no real "memory" access necessarily involved, but
> > "memory" is the only way we can tell you "don't move this".
> >
> And yet that's not guaranteed. From
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html:

That's my point exactly.

The 'volatile' part of 'asm volatile' is almost meaningless.

As a result, we mark pretty much all system instructions as being
memory clobbers, because that actually works.

Whether they actually clobber memory or not is immaterial, and is not
why we do it.

> Note that the solution _isn't_ to add a "memory" clobber, because it's
> not guaranteed to work, as it's explicitly defined to be a read/write
> _memory_ barrier, despite what kernel writers wish it would do.

The solution you quote *ALSO* doesn't work, because they used a
pointless example that was made-up in order to get to that solution.

Nobody cares about an operation being ordered wrt an addition.

Mostly kernel people care about an operation being ordered wrt
something that the compiler DOES NOT KNOW ABOUT, and there is no way
to actually tell the compiler, exactly because the compiler has no
effin idea about it.

But the other thing kernel people care about is ordering those
operations wrt externally visible things - like modifying memory. So
an MSR write (or a write to a register like %CR0) may not itself
directly read or modify memory at all, but there are other reasons why
it might need to be ordered with any memory operations around it
anyway, because some of those memory operations may be indirectly
relevant (ie maybe they are page table writes and you just changed the
page table pointer in %CR0, and now - even if you don't access the
particular memory location, speculation may cause TLB fills to happen
at any time).

You can't tell the compiler "this eflags operation must be ordered wrt
this MSR write" - because even if the compiler knows about eflags, it
doesn't know about things like page table contents or specific MSR
bits, or whatever.

In a perfect world, we could actually enumerate resources we cared
about somehow. But that world is not the world we live in.

So we end up basically having exactly *ONE* resource we can use as a
"the compiler knows about this, and lets us use it as a
synchronization point".

That one resource is "memory". You may not like it, but you have
absolutely zero realistic alternatives, do you?

> Your assertion that compilers don't know about control registers isn't
> exactly true. In the case of "pushf/popf", those instructions know
> about the eflags registers. All subsequent instructions that read or
> modify eflags also know about it. In essence, the compiler can
> determine its own clobber list, which include MSRs.

Nope.

I think you are thinking of the arm64 MSR's. As far as I know, no
compiler out there - and certainly not the complete set of compilers
we support - know a thing about x86 msr registers. It's all inline
asm.

And honestly, no sane person would _want_ a compiler worrying about x86 MSR's.

A compiler should do a good job at the basic instruction set, adn then
give us the escapes for the unusual cases.

Stop believing that a compiler can deal with every part of system
programming and that everything should be intrinsics. Because you
don't have all the intrinsics we need anyway.

            Linus
