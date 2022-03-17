Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67DF94DD0E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbiCQWqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiCQWqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:46:19 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAD5B29C960;
        Thu, 17 Mar 2022 15:45:01 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 22HMbwbL028517;
        Thu, 17 Mar 2022 17:37:58 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 22HMbuFG028514;
        Thu, 17 Mar 2022 17:37:56 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 17 Mar 2022 17:37:56 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Message-ID: <20220317223756.GM614@gate.crashing.org>
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com> <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Mar 17, 2022 at 12:45:30PM -0700, Bill Wendling wrote:
> On Thu, Mar 17, 2022 at 11:52 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> > It is perhaps telling that the LLVM discussion I found seems to talk
> > more about the performance impact, not about the fact that THE
> > GENERATED CODE WAS WRONG.
> >
> I think that's a bit unfair. There seemed to be a general consensus
> that the code was wrong and needed to be fixed. However, the compiler
> is also expected to generate the most performant code that it can.

I think Linus' point is that correctness is required, and performance
is just a nice to have.  I don't think you disagree, I sure don't :-)

> > In fact, gcc pretty much documents that "cc" clobbers doesn't do
> > anything on x86, and isn't needed. It just assumes that the arithmetic
> > flags always get clobbered, because on x86 that's pretty much the
> > case. They have sometimes been added for documentation purposes in the
> > kernel, but that's all they are.

GCC on x86 clobbers the arithmetic flags in every asm.  Long ago the x86
port still used CC0 (an internal representation of the condition code
flags), which acted effectively like clobbering the flags on every
instruction (CC0 will finally be gone in GCC 12 btw).  The x86 port
stopped using CC0 (and so started using the automatic "cc" clobber, to
keep old inline asm working) in 1999 :-)

"cc" is a valid clobber on every port, but it doesn't necessarily do
anything, and if it does, it does not necessarily correspond to any more
specific register, neither to a GCC register nor to a hardware register.
It also is not really useful for generic code, since the asm itself is
by nature pretty much target-specific :-)

> > But the whole "you can't move _other_ things that you don't even
> > understand around this either" is equally important. A "disable
> > interrupts" could easily be protecting a "read and modify a CPU MSR
> > value" too - no real "memory" access necessarily involved, but
> > "memory" is the only way we can tell you "don't move this".
> >
> And yet that's not guaranteed. From
> https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html:
> 
> ```
> Note that the compiler can move even volatile asm instructions
> relative to other code, including across jump instructions. For
> example, on many targets there is a system register that controls the
> rounding mode of floating-point operations. Setting it with a volatile
> asm statement, as in the following PowerPC example, does not work
> reliably.
> 
>   asm volatile("mtfsf 255, %0" : : "f" (fpenv));
>   sum = x + y;
> 
> The solution is to reference the "sum" variable in the asm:
> 
>   asm volatile ("mtfsf 255,%1" : "=X" (sum) : "f" (fpenv));
> ```
> 
> Note that the solution _isn't_ to add a "memory" clobber, because it's
> not guaranteed to work, as it's explicitly defined to be a read/write
> _memory_ barrier, despite what kernel writers wish it would do.

It doesn't work because *other* code can change the fp environment as
well; adding "memory" clobbers to both asms will keep them in order (if
they both are not deleted, etc).  This hinders optimisation very
seriously for code like this btw, another important reason to not do it
here.

And what is "memory" here anyway?  New memory items can be added very
late in the pass pipeline, and anything done in an earlier pass will
not have considered those of course.  The most important case of this
(but not the only case) is new slots on the stack.

> Your assertion that compilers don't know about control registers isn't
> exactly true. In the case of "pushf/popf", those instructions know
> about the eflags registers. All subsequent instructions that read or
> modify eflags also know about it. In essence, the compiler can
> determine its own clobber list, which include MSRs.

The compiler only knows about some bits in the flags register.  The
compiler does not know about most machine resources, including all of
the model-specific registers.


Segher
