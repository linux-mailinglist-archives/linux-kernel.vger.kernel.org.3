Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D96E4DCEFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 20:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiCQTrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 15:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiCQTrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 15:47:00 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9A243718
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:45:42 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id p8so7630543pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 12:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSmw10ZWQdRXdgcJ3u41Wj71hgTjI3BEc50wKUXVLWs=;
        b=gPjQ5TplXLMcZCpaEC9X3PjTfZYLbH0hkMwdcjDju6mOrYe25JROMydqyK+9alTwze
         nI2gwGVtyDBr3n9Ci7FgiNkj4uITWRlUnqCrG5dyoN9Pfe93zbbEnZnl2eLGf+Yy55HH
         0gHuIEu/2QYDCW+RuCq7YCbqGpt4fzc2tvVYNR9i8BPBafswwb3vUXFchMDuzhh6/5dG
         siClIC5OA8npx2AgBFzvWFtVDmqFfN8prRBachAD/IqseJWzx0g092is1TkE+Dkf5RyH
         OKBLPpuaO+HpX0Vp+FAI8sxXOHGwZnhjtDlmX8qcElKlIlnLptgWXHS51S3nz17oAVrd
         Yp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSmw10ZWQdRXdgcJ3u41Wj71hgTjI3BEc50wKUXVLWs=;
        b=ayFqAAyYIGIyQUfOJbYLlsypNXj531IqTpE8TFmipxqH+wizahB02CFcEFTmtHcvjE
         1ER4EK5vYiIr8yAk1r8ampDXXVrMWN2SGpe8/mrxx2oSpScx3h9az0Xzkeim/acpE0UY
         hzEgKE0LtzkzyhF2gqqhc+XHlYzf1PHkmSF9+Ga9wp3bexux5FohP97Fiz/fgiaDDv4w
         aKyEaX6qw0I6MgKnrXE52WV+h3Nxsz5duzT4+xYr8i0sp8KdTqleWR/6C92Y8EfVx2kD
         kHJ/QpICk5DcAhvqTWQiqEYrXMJZdd6z58hRB0KwlJJ4diy9Hy+z0eEoLfk2k4fGbt0M
         3YdA==
X-Gm-Message-State: AOAM530fqp79Ma5xbYzstGYev18GnF87MUMmvW4uwxaA+Yf4AjkC/I9S
        /R9/xFaxVSD2H3TjVt7cHfhjjirUGAeaFNcVWBrl
X-Google-Smtp-Source: ABdhPJw33MLed/mMzmZl9280rvcUvut4pFr3P2K7N9WAcmlAcZJf5I471YnfDun8+JhgRESdVinoi4dUJtQR12GshE4=
X-Received: by 2002:a63:1613:0:b0:382:2a7f:5ca1 with SMTP id
 w19-20020a631613000000b003822a7f5ca1mr59852pgl.151.1647546341928; Thu, 17 Mar
 2022 12:45:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
In-Reply-To: <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 17 Mar 2022 12:45:30 -0700
Message-ID: <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 11:52 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> [ I got cc'd in the middle of the discussion, so I might be missing
> some context or pointing something out that was already discussed ]
>
> On Thu, Mar 17, 2022 at 11:00 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > > >One change you may see due to this patch is the compiler moving the
> > > >"pop %..." instruction away from the "pushf" instruction. This could
> > > >happen if the compiler determines that it could produce better code by
> > > >doing so---e.g. to reduce register pressure. The "gcc -O2" example
> > > >below shows this code movement.
>
> Honestly, that part worries me a _lot_.
>
> Why?
>
> Because clang in particular has already messed up eflags handling
> once, by spilling condition codes (in the form of eflags) onto the
> stack, and then loading them later with a "popf".
>
> And it did so across a function call THAT MODIFIED 'IF'. This was a
> major bug in clang back in 2015 or so, and made it unusable for the
> kernel.
>
> See for example
>
>     https://lore.kernel.org/all/CA+icZUU7y5ATSLV_0TGzi5m5deWADLmAMBkAT32FKGyUWNSJSA@mail.gmail.com/
>
> for some kernel discussion, and separately
>
>     https://lists.llvm.org/pipermail/llvm-dev/2015-July/088774.html
>
> for just llvm discussions.
>
I can't account for LLVM's past sins. That particular issue was fixed
of course. This change will only generate "pushf/popf" (actually just
"pushf" here) only when explicitly used.

> It is perhaps telling that the LLVM discussion I found seems to talk
> more about the performance impact, not about the fact that THE
> GENERATED CODE WAS WRONG.
>
I think that's a bit unfair. There seemed to be a general consensus
that the code was wrong and needed to be fixed. However, the compiler
is also expected to generate the most performant code that it can.

> That compiler bug would basically enable or disable interrupts in
> random places - because clang developers thought that 'eflags' is only
> about the condition codes.
>
> > EFLAGS is defined as the lower 16 bits of FLAGS register, yeah?
>
> No. EFLAGS is a 32-bit register.
>
> A lot of the high bits end up being reserved, but not all of them. AC,
> VIF/VIP are all in the upper 16 bits.
>
> Also:
>
> > So I don't understand your point; the finest grain resolution
> > the compiler has to work with is the whole EFLAGS register, not
> > individual bits like IF, DF, or AC.  (I triple checked this with the
> > maintainer of LLVM's x86 backend)
>
> You can actually operate on EFLAGS at multiple granularities.
>
>  - normal pushf/popf. Don't do it unless you are doing system software.
>
>  - You *can* (but you really *really* should not) operate on only the
> lower 16 bits, with "popfw". Don't do it - it doesn't help, requires
> an operand size override, and is just bad.
>
>  - you can use lahf/sahc to load/store only the arithmetic flags
> into/from AH. Deprecated, and going away, but historically supported.
>
>  - you can obviously use arithmetic and setcc to modify/read the
> arithmetic flags properly.
>
> A compiler should NEVER think that it can access eflags natively with
> pushf/popf. Clang thought it could do so, and clang was WRONG.
>
> The absolutely only case that a compiler should ever worry about and
> do is that last case above: arithmetic instructions that set the
> flags, and 'jcc', 'setcc', 'cmov', 'adc' etc that test it./
>
> Yes, yes, that complete mental breakdown with pushf/popf did get
> fixed, but it really makes me very wary of thinking that we should
> ever use a built-in that compiler writers really fundamentally got so
> wrong before.
>
> What would make me think that you'd get it right now? In user space,
> you'll basically never actually see the whole system flags issues, so
> your test-cases would never work or be very contrieved. You'd have to
> really work at it to see the problems.
>
As pointed out above, the LLVM people agreed with your sentiment here:
never generate "pushf/popf" unless explicitly told to do so. This
patch isn't trying to walk that back, just that when "pushf/popf" is
explicitly asked for it allows LLVM and GCC to generate the best
instruction sequence.

> > > The memory barrier is needed for IF changes, for example.
> >
> > Shouldn't native_irq_disable/native_irq_enable be declaring that they
> > clobber "cc" then?
> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-Registers
>
> No. Once again: compilers don't understand system flags in eflags.
>
> In fact, gcc pretty much documents that "cc" clobbers doesn't do
> anything on x86, and isn't needed. It just assumes that the arithmetic
> flags always get clobbered, because on x86 that's pretty much the
> case. They have sometimes been added for documentation purposes in the
> kernel, but that's all they are.
>
> So you can find that "cc" clobber in a few places in the kernel, but
> it's pointless.
>
> The reason pushf/popf need to have a memory clobber is so that the
> compiler will not move it around other things that have memory
> clobbers.
>
> Because memory clobbers are things that compilers *UNDERSTAND*.
>
> Put another way: when you see that "memory" clobber in an inline asm,
> don't think that it means "this modifies or uses memory".
>
> That may be the documentation, and that may be how compiler people
> think about them, but that's just wrong.
>
> What *kernel* people think is "this makes the compiler not do stupid things".
>
> Because compilers really don't understand things like system registers
> and system flags, and the subtle issues they have, and the ordering
> requirements they have. Never have, and never will.
>
> And compilers really don't understand - or care about - things like
> "cc", because compiler people think it's about arithmetic flags, and
> would do things like "oh, I'll just save and restore the flags over
> this since the asm modifies it".
>
> Note that "eflags" is just the tip of the iceberg here. This is true
> for a lot of other cases.
>
> Yes, when you have something like a "disable interrupts", the compiler
> really must not move memory accesses around it, because the interrupt
> flag may in fact be protecting that memory access from becoming a
> deadlock.
>
> But the whole "you can't move _other_ things that you don't even
> understand around this either" is equally important. A "disable
> interrupts" could easily be protecting a "read and modify a CPU MSR
> value" too - no real "memory" access necessarily involved, but
> "memory" is the only way we can tell you "don't move this".
>
And yet that's not guaranteed. From
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html:

```
Note that the compiler can move even volatile asm instructions
relative to other code, including across jump instructions. For
example, on many targets there is a system register that controls the
rounding mode of floating-point operations. Setting it with a volatile
asm statement, as in the following PowerPC example, does not work
reliably.

  asm volatile("mtfsf 255, %0" : : "f" (fpenv));
  sum = x + y;

The solution is to reference the "sum" variable in the asm:

  asm volatile ("mtfsf 255,%1" : "=X" (sum) : "f" (fpenv));
```

Note that the solution _isn't_ to add a "memory" clobber, because it's
not guaranteed to work, as it's explicitly defined to be a read/write
_memory_ barrier, despite what kernel writers wish it would do.

Your assertion that compilers don't know about control registers isn't
exactly true. In the case of "pushf/popf", those instructions know
about the eflags registers. All subsequent instructions that read or
modify eflags also know about it. In essence, the compiler can
determine its own clobber list, which include MSRs.

-bw

> Particularly since both the clang people and gcc people have actively
> been trying to weaken the "volatile" semantics (which would have
> generally been the logically consistent model - thinking if inline asm
> to be visible in the machine model, and not being able to move them
> around for those reasons).
>
> > > This feels like "let's fix LLVM by hacking the kernel in dangerous ways" once again!
> >
> > Even if the behavior of llvm was changed, you'd _still_ get better
> > codegen for _both_ compilers by using the intrinsics.
>
> No.
>
> "moving instructions around a bit" is not better code generation when
> the end result DOES NOT WORK.
>
> And honestly, we have absolutely zero reason to believe that it would work.
>
> If it turns out that "pop to memory" is a big deal for performance,
> let's just change the "=rm" to "=r" and be done with it. Problem
> solved. We already used to do that on the "pushf" side, but these days
> we avoid "popfl" entirely and do a conditional jump over a "sti"
> instead.
>
> Because maybe moving that "pop" by a few inbstructions helps a bit,
> but if you move the "pushf" noticeably, you've just created a big big
> problem.
>
> A bug you've had once already.
>
>                  Linus
