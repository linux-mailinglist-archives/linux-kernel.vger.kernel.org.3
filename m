Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4364DE3F0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiCRWRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiCRWRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:17:07 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDEA42DF3FB;
        Fri, 18 Mar 2022 15:15:46 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22IM93Hc011038;
        Fri, 18 Mar 2022 17:09:03 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22IM91UT011037;
        Fri, 18 Mar 2022 17:09:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 18 Mar 2022 17:09:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Message-ID: <20220318220901.GS614@gate.crashing.org>
References: <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com> <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 11:19:28AM -0700, Linus Torvalds wrote:
> Or rather, it's not the redzoning itself, but the fact that the
> compiler might use the word under the stack for random other things,
> and the pushf will then corrupt some local variable storage.
> 
> I think it would be lovely to solve that in inline asm itself some way
> - by marking the stack pointer clobbered or something.

Inline assembler does not allow you to change the stack pointer, in
principle.  You have to return everything to its original state before
you return control from the asm code, and you have to deal with what
happens if am interrupt comes in halfway through the asm, and all other
ABI things that may happen on your platform.

> Because you have the same issue if an inline asm might need to do a
> function call - think magic calling conventions etc, but also possibly
> slow-path cases.

Yes.  The compiler itself can deal with all the red zone restrictions --
precisely *because* it is in full control of the stack frame -- but
those restrictions are very real.  It generally is a very good idea to
have a redzone though, without it you pay much more than necessary for
frame setup and teardown in leaf functions (similar to some of what the
misnamed "shrink-wrapping" optimisation does, but the two are mostly
independent, the benefits add up).

> As mentioned, it's not an issue for the kernel proper due to
> -mno-red-zone which we need for entirely unrelated reasons.

It might help to have some special clobber syntax that says "this asm
clobbers the red zone", so the compiler can arrange for the red zone to
contain nothing during the asm (it already does the same for function
calls, for example).

How bad is it to do the fail-safe general solution here though?  I.e.,
write actual assembler code:

# u16 getflags(void);
getflags:
	pushf
	pop %ax
	ret

(or whatever the syntax is, my x86 is rusty).

> Side note and kind of related: we do have this in the kernel:
> 
>   register unsigned long current_stack_pointer asm(_ASM_SP);
>   #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
> 
> which *might* also solve the redzoning issue.

The GCC documentation of inline asm says
  Another restriction is that the clobber list should not contain the
  stack pointer register.  This is because the compiler requires the
  value of the stack pointer to be the same after an 'asm' statement as
  it was on entry to the statement.  However, previous versions of GCC
  did not enforce this rule and allowed the stack pointer to appear in
  the list, with unclear semantics.  This behavior is deprecated and
  listing the stack pointer may become an error in future versions of
  GCC.

> In the kernel we need it not because of redzoned stack use, but
> because we need the stack frame to be set up properly or objtool
> complains.

If the kernel has special rules for the stack, it had better teach the
compiler about this special ABI, or there will be tears eventually.  If
the kernel requires only what the standard ABIs provide, it can trust
the compiler to do that correctly, this is one of the core jobs of a
compiler!


Segher
