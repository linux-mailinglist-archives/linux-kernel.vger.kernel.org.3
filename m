Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEBE4DE46E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiCRXMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiCRXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:12:44 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC5DA111DE3;
        Fri, 18 Mar 2022 16:11:23 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22IN4QwF013108;
        Fri, 18 Mar 2022 18:04:26 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22IN4P7s013107;
        Fri, 18 Mar 2022 18:04:25 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 18 Mar 2022 18:04:25 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Message-ID: <20220318230425.GT614@gate.crashing.org>
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com> <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 02:39:34PM -0700, Linus Torvalds wrote:
> I think compiler people should see inline asm as a really *good*
> thing, because it allows people to have that "I'm going to do
> something that nobody normal does, look away now" kind of escape
> clause, letting the compiler concentrate on the things it does best.

There is a reason that we have the GCC inline asm extension at all.  It
is not because the compiler developers think it is useless ;-)

It often *is* abused, or used in wrong, dangerous ways.  This often will
go undetected for a long time, for all the same reasons you want to have
inline asm in the first place (it is an escape hatch, much of what you
do with it is outside of what the compiler can (and does) know about)!

> Yes, I realize inline asm isn't something compiler people love. And
> yes, I realize that it might not give optimal code.

Some of us do love it.  But it should not be used when you do not need
it, indeed to get better machine code genereated, but much more
importantly to get more correct code, and much simpler code, simpler to
read code.  All these things are connected.

> (And here I separate 'intrinsic' and generic compiler builtins. I love
> the builtins that allow me to tell the compiler something, or the
> compiler to tell me something about the code: __builtin_unreachable()
> and __builtin_constant_p() are both wonderful examples of those kinds
> of things)

I don't know what you mean when you say "intrinsic".  It is a worse name
than a "built-in function", which is either not a function or not a
built-in thing, so that name is rubbish; both "compiler intrinsic" and
"intrinsic function" are even worse though!

I like to say "builtin", which has no other meaning in the English
language, so it cannot be easily understood to have properties it
doesn't, not just from a misleading name anyway.

And yes, __builtin_unreachable() is nicer than having to write "1/0" in
all those places, it is much clearer.  It is undefined behaviour to
execute it exactly the same though.

__builtin_constant_p() is a curious one: it returns whether the compiler
knows its argument to be constant, which is something C does not define
(*cannot* define).  It is a curse as well as a blessing, moving from
compiler bversion to compiler version can return false instead of true
on the same expression, or the other way around, and the same when
trying out different compilers of course.

> But an intrinsic for some odd target-specific thing that can't even be
> portably generalized? Give me inline asm any day.

The vast majority of compiler builtins are for simple transformations
that the machine can do, for example with vector instructions.  Using
such builtins does *not* instruct the compiler to use those machine
insns, even if the builtin name would suggest that; instead, it asks to
have code generated that has such semantics.  So it can be optimised by
the compiler, much more than what can be done with inline asm.

It also can be optimised better by the compiler than if you would
open-code the transforms (if you ask to frobnicate something, the
compiler will know you want to frobnicate that thing, and it will not
always recognise that is what you want if you just write it out in more
general code).

Well-chosen builtin names are also much more readable than the best
inline asm can ever be, and it can express much more in a much smaller
space, without so much opportunity to make mistakes, either.

Builtins are good!

> We can do things with inline asms that the compiler can't even _dream_
> of, like the whole instruction rewriting thing we use.

Yes.  Inline asm is good as well!  Both things have their places.

Some builtins are not well-conceived.  And some inline asm has the
same problem :-(

> I'd much rather have a powerful generic concept (eg "asm goto" is
> lovely) than a specialized intrinsic that does only one thing, and
> doesn't even do it well because it's untested and badly defined.

Being generally applicable is a double-edged sword.  The trick is to
have things more general when reasonable, and not when not.


Segher
