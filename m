Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADB4DD1F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiCRAdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiCRAdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:33:39 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AB58292DA9;
        Thu, 17 Mar 2022 17:32:22 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22I0Pv9f001636;
        Thu, 17 Mar 2022 19:25:57 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22I0Ptsh001632;
        Thu, 17 Mar 2022 19:25:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 17 Mar 2022 19:25:55 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
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
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Message-ID: <20220318002555.GP614@gate.crashing.org>
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com> <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <878rt8gwxa.fsf@oldenburg.str.redhat.com> <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 01:36:19PM -0700, Linus Torvalds wrote:
>         asm volatile("# __raw_save_flags\n\t"
>                      "pushf ; pop %0"
>                      : "=rm" (flags)
>                      : /* no input */
>                      : "memory");

> And is that "memory" clobber because it modifies the memory location
> just below the current stack pointer?
> 
> No, not really - outside the kernel that might be an issue, but we
> already have to build the kernel with -mno-red-zone, so if the
> compiler uses that memory location, that would be a *HUGE* compiler
> bug already.

There is the problem though that this might extend the stack, which
isn't marked up anywhere, so the static checkers do not see the stack
overflow, and it won't be noticed until runtime.  Or do the checkers
consider such cases?

> So the "memory" clobber has absolutely nothing to do with the fact
> that 'pushf' updates the stack pointer, writes to that location, and
> the popf then undoes it.
> 
> It's literally because we don't want the compiler to move non-spill
> memory accesses around it (or other asm statements wiht memory
> clobbers), regardless of the fact that the sequence doesn't really
> read or write memory in any way that is relevant to the compiler.

Well, that, or the write of the code didn't consider this, just went
"writes memory, so we clobber".

> > GCC doesn't have barriers in the built-ins (if we are talking about
> > __builtin_ia32_readeflags_u64 and __builtin_ia32_writeeflags_u64).  I
> > expect they are actually pretty useless, and were merely added for
> > completeness of the intrinsics headers.
> 
> Yeah, without any kinds of ordering guarantees, I think those builtins
> are basically only so in name. They might as well return a random
> value - they're not *useful*, because they don't have any defined
> behavior.

No ordering wrt any other code, yes.  Which is not anything you can
solve in only the builtin -- you need to consider the other code that
you order with as well, change that code as well.

> I mean, we *could* certainly use "read eflags" in the kernel, and yes,
> in theory it would be lovely if we didn't have to encode it as a
> "pushf/pop" sequence, and the compiler tracked the stack pointer for
> us, and perhaps combined it with other stack pointer changes to the
> point where the "popf" would never happen, it would just undo the %rsp
> change at function exit time.
> 
> So yes, a builtin can improve code generation.

Yes, and they are much easier to write, and can be written correctly by
lookenspeepers who just *have* to twist every knob that they can -- more
easily than inline asm anyway, which is unforgiving to the extreme.

They are also much easier to read usually, make for cleaner code.  They
certainly have their place.  But they should stay there, too :-)


Segher
