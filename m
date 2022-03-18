Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A134DE4A0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241557AbiCRXuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241551AbiCRXuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:50:10 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C506F52E47;
        Fri, 18 Mar 2022 16:48:49 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22INgDNB014381;
        Fri, 18 Mar 2022 18:42:13 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22INgCLj014380;
        Fri, 18 Mar 2022 18:42:12 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Fri, 18 Mar 2022 18:42:12 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20220318234212.GU614@gate.crashing.org>
References: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com> <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com> <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com> <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2022 at 04:10:55PM -0700, Linus Torvalds wrote:
> It would be lovely to have some explicit model for "I want the frame
> to have been set up for backtraces", but here we are.

So please define exactly what that *means*?  Preferably portably, but I
reckon at least some of it will have to be machine-specific (and ABI-
specific).  But it needs to be well-defined, clearly defined, defined at
all, and *documented* :-)

> Marking '%rsp
> used makes the compiler understand it's not a leaf function.

As I said before, this is explicitly incorrect code.  Always was, but
it is documented since a while (since GCC 9).  Clobbering the stack
pointer can never be correct, the stack pointer after an asm has to be
identical to the one before that asm!

> And while we have other uses for it that then use the actual value,
> those don't care about the exact value of the stack pointer register,
> they just want "give me a pointer that is contained within the current
> stack", because we control the stack allocation and do funky things
> there. So "any random stack pointer value in this function" is
> perfectly fine and expected.

You can use %rsp as *input* operand just fine, which is all you need for
that.

> But for user mode, it would probably be a great idea to also have a "I
> cannot use a redzone in this function" thing. The kernel can't use it
> because we have nested exceptions, but maybe some day even the kernel
> could make use of (controlled) red-zoning.

Yes.  We just have to figure out what the exact semantics we want is,
and how to express that in a target-independent way, and then relatedly
what a good name for it would be ("redzone" in the clobber list is the
best I can come up with right now, but that may have to change).


Segher
