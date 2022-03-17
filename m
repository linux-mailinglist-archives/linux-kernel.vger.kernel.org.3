Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0AE4DCD1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbiCQSBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCQSBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:01:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5654121C06A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:00:25 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o6so8295403ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PSDVOiZ+HutKa0nVlAlxy3lnVgp/wMEu5kd9R+z/5Tc=;
        b=tb4hnlSM6JqyzxX6epcBdHCINgiwN77Fs0OC4yimDWrBhgYrOZLPey/Hu0Weqz1fAf
         RB0x02d7dS30jKNAmHj2xbXPIH3QFy5SXyYP6hCr3VhtG4IVNSbuM8LscWbDN1eDCbb8
         y5UdhahnT/9rREU+55ZFwP00dlvcS/EnwOk5TQ7O/K0If1sutqHLkyEu5sKUyEqNumtd
         53siqnZ9kmf52GYdL5gIvhLsAGt7nXxucrMAoeM2VIJysnl7cLMEdx289CBpMlFMwpQm
         6OzQVtD4fu1QI9vOvKgdtoC2d645lx8wxyIrisU6gIZx1N04vmyn2PQCiqdW5dALqN+1
         Tc2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PSDVOiZ+HutKa0nVlAlxy3lnVgp/wMEu5kd9R+z/5Tc=;
        b=ajX70s9JgRJfzAzvitv86WTZRMdQvWNnihAFQt199dm6LO37If5u6zxXsAexQS1GTf
         CpP0pHfRK8UqidV/Ef2k7SwEXoirZN3I9FPVZHcgq5kzsBO09EN3PokiF6Lqj3IAmvCi
         m6+4l2wFn8MnlF3ZdY0fB35z3AfMc1A/1B6X4SsGxrl748OuDuRHpwyltaXfjXwTIFBD
         7ZGsV8RWiSvMYgdYrUOtvUUsxvJo7Jomy4JdNTDJKcrDD9eZOELB09nTfzR+h2zMz9KD
         QMFqsRvUQgLXjGkCoz5u2XfYIR2QZoPVWNOdBqdRZhoNQXaUkHtWqhc+y80nj1Tnrycg
         0K1g==
X-Gm-Message-State: AOAM531Z27S3R/nHN/R8DXGwbZKYtSwPAdkK4TuTyxSqVkjF2uXjmfS/
        XgESqP5W3VYH6chfA6gV14n39JU+C343AaKRxBqgag==
X-Google-Smtp-Source: ABdhPJxsKISb2L8QmquW5Bh8tKxK1MXPmMfPDi2jjKfSm//vudSBeTEIvpDeAY2CPecszBCc/lyfeohsFbUqkdAQyl4=
X-Received: by 2002:a2e:3004:0:b0:223:c126:5d1a with SMTP id
 w4-20020a2e3004000000b00223c1265d1amr3707048ljw.408.1647540023447; Thu, 17
 Mar 2022 11:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
In-Reply-To: <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Mar 2022 11:00:11 -0700
Message-ID: <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 17, 2022 at 8:43 AM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On March 15, 2022 12:19:40 AM PDT, Bill Wendling <morbo@google.com> wrote=
:
> >On Mon, Mar 14, 2022 at 6:08 PM H. Peter Anvin <hpa@zytor.com> wrote:
> >>
> >> My only concern is this: how does this affect the placement of these s=
equences in relation to the things they need to protect?
> >>
> >With clang (and I assume it's similar with gcc), the
> >__builtin_ia32_readeflags_u{64|32} builtins specify that the EFLAGS
> >register is used (and the stack pointer is modified). Instructions
> >that may change EFLAGS are marked as defining EFLAGS, and clang and
> >gcc are careful not to move instructions that access EFLAGS past them.
> >
> >One change you may see due to this patch is the compiler moving the
> >"pop %..." instruction away from the "pushf" instruction. This could
> >happen if the compiler determines that it could produce better code by
> >doing so---e.g. to reduce register pressure. The "gcc -O2" example
> >below shows this code movement.
> >
> >-bw
> >
> >> On March 14, 2022 4:07:23 PM PDT, Bill Wendling <morbo@google.com> wro=
te:
> >>>
> >>> On Tue, Mar 1, 2022 at 12:19 PM Bill Wendling <morbo@google.com> wrot=
e:
> >>>>
> >>>>
> >>>>  Clang generates good code when the builtins are used. On one benchm=
ark,
> >>>>  a hotspot in kmem_cache_free went from using 5.18% of cycles poppin=
g to
> >>>>  a memory address to 0.13% popping to a register. This benefit is
> >>>>  magnified given that this code is inlined in numerous places in the
> >>>>  kernel.
> >>>>
> >>>>  The builtins also help GCC. It allows GCC (and Clang) to reduce reg=
ister
> >>>>  pressure and, consequently, register spills by rescheduling
> >>>>  instructions. It can't happen with instructions in inline assembly,
> >>>>  because compilers view inline assembly blocks as "black boxes," who=
se
> >>>>  instructions can't be rescheduled.
> >>>>
> >>>>  Another benefit of builtins over asm blocks is that compilers are a=
ble
> >>>>  to make more precise inlining decisions, since they no longer need =
to
> >>>>  rely on imprecise measures based on newline counts.
> >>>>
> >>>>  A trivial example demonstrates this code motion.
> >>>>
> >>>>          void y(void);
> >>>>          unsigned long x(void) {
> >>>>                  unsigned long v =3D __builtin_ia32_readeflags_u64()=
;
> >>>>                  y();
> >>>>                  return v;
> >>>>          }
> >>>>
> >>>>  GCC at -O1:
> >>>>          pushq   %rbx
> >>>>          pushfq
> >>>>          popq    %rbx
> >>>>          movl    $0, %eax
> >>>>          call    y
> >>>>          movq    %rbx, %rax
> >>>>          popq    %rbx
> >>>>          ret
> >>>>
> >>>>  GCC at -O2:
> >>>>          pushq   %r12
> >>>>          pushfq
> >>>>          xorl    %eax, %eax
> >>>>          popq    %r12
> >>>>          call    y
> >>>>          movq    %r12, %rax
> >>>>          popq    %r12
> >>>>          ret
> >>>>
> EFLAGS is a mishmash of different things, only some of which are visible =
to the compiler, and the semantics of which are totally different.
>
> Changing IF, changing DF, changing AC, and changing the arithmetic flags =
have *enormously* different properties. The compiler can't know how the sem=
antics of a particular instance is, at least without being explicitly told =
(giving it a some kind of mask of bits that could change.)

EFLAGS is defined as the lower 16 bits of FLAGS register, yeah? Aren't
IF, DF, and AC all within those range of bits?  Yes; there's no way to
express finer grain resolution that you only care to read/write an
individual bitfield and not the whole register; EFLAGS is the finest
range.  Even if the compiler determined via the use of the results of
reading eflags that only a particular bitfield was needed, I'm pretty
sure there's no instructions in X86 for reading these individual
fields.  So I don't understand your point; the finest grain resolution
the compiler has to work with is the whole EFLAGS register, not
individual bits like IF, DF, or AC.  (I triple checked this with the
maintainer of LLVM's x86 backend).

> The memory barrier is needed for IF changes, for example.

Shouldn't native_irq_disable/native_irq_enable be declaring that they
clobber "cc" then?
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Clobbers-and-Scratch-R=
egisters

> This feels like "let's fix LLVM by hacking the kernel in dangerous ways" =
once again!

Even if the behavior of llvm was changed, you'd _still_ get better
codegen for _both_ compilers by using the intrinsics.

Another issue is that when multiple constraints are used, the order
they're selected in is unspecified.
https://gcc.gnu.org/onlinedocs/gcc/Constraints.html#Constraints if you
want to look.
I could ask GCC folks if they want to specify that behavior; doing so
does take away some freedom from implementations, so they may choose
not to.

> We rely on "memory" as compiler barriers *all over the place*.

Ah, your concern is about removing the explicit "memory"
clobber/compiler barrier. Now you're earlier question "how does this
affect the placement of these sequences in relation to the things they
need to protect?" makes sense.  Is the concern a call to
native_save_fl() being re-ordered with respect to a call to
native_irq_disable()/native_irq_enable()? Or do you have a call site
of native_save_fl() that you have concrete concerns about?

> This is especially so since this appears to be a suboptimal code generati=
on issue and not a correctness issue; your change is likely to promote the =
former (underoptimizing) to the latter (overoptimizing.)

How so? Are you going to ignore the example posted above (`x()`)? Can
you help me understand via code and disassembly that can demonstrate
your claim?
--=20
Thanks,
~Nick Desaulniers
