Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4178D4B5E77
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 00:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbiBNXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 18:53:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiBNXxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 18:53:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FEF27173
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:53:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f37so7406994lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLpszrz2XbhK8hQIyggzqGqnVBM/+oIg/TVgQPiwx7Q=;
        b=nHU5+GXtQBcn0+LMXl+dFkDs8InirQfDocIDNYZGbhJzNaVTI+kslHwnBlMsyS/1pe
         MUHTkoUhBHy2ECBs0LJLtSRzB7d69j/Kp4cqYL1/dgP+vQ48I3bCZUmMoYwlvEDjDQc4
         MezmrUSciLzfMSJo9BWk567ugujw1FZUufyuzI8eQTVNaZ38v/ZVSPcAwbI5AhrRP6/2
         i9zM43z+NlDQcE5iITGdziHtxCxvDPr/7zzmg0SIOik1kN9AsXiU423wsLPz1YmDLKWW
         29rUaAFPJ0fbmcZa7/iGJANDot7bkDwTv0a4CgeV9xW3nFtMpnlozMDRpyaO7Oh+w3PC
         At8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLpszrz2XbhK8hQIyggzqGqnVBM/+oIg/TVgQPiwx7Q=;
        b=wFQ0Tz6seI08/ETHAKNoJfoH8GVd7D0nOSEm5joAXeaZHQtE/WO9uuzdOCCutXKG9J
         isBB9lv2eB/RtdI/CHCF4bLfyTclz3hZRvozJf4Wf9qJBr99KngAj4HJtn2x7I/MaZLJ
         8EL6HUfCIOUG1K0jQmVyW3H3WIIUMFTjRiMTNq2Vj/gWf6g6MUCegd5nDNBybV4KRche
         jwAB+R9A6sl+at7sUzGfyl50kNExh4XHoi/GJbCMrbPAcKfSjA0nGtn898DdhG9xQdIJ
         fy1u5ZAyH/C4/6Ih+rzEODxK/S0RjVUiwtBUyhcUHpKNE9+kfMLgqfxvuqP6mrEoZaOE
         ED9g==
X-Gm-Message-State: AOAM530mH5aHhTCXA7TNJn6zGzI1ODrkoa2doNx5DMsApIMS71K2vfwM
        3n77A20/Lr7HjLKV6qi969oO8LaAShe+dnGJLXOJNA==
X-Google-Smtp-Source: ABdhPJy9Ripq6XcGdhDxsNU7aoM8isWBdS8htxRLdNlnNS/NuTCpxlUfHXc9NkvvH8APOUJ3+7vB1kSenltpjaQcA8A=
X-Received: by 2002:a05:6512:3f97:: with SMTP id x23mr1133872lfa.550.1644882816258;
 Mon, 14 Feb 2022 15:53:36 -0800 (PST)
MIME-Version: 1.0
References: <20211229021258.176670-1-morbo@google.com> <20220204005742.1222997-1-morbo@google.com>
 <CAKwvOdk=VdDo1fhWJVa4eO0UjuQwtV9kC-cJd0J9-6guU2vafA@mail.gmail.com> <0d93ea4d847b42ca9c5603cb97cbda8a@AcuMS.aculab.com>
In-Reply-To: <0d93ea4d847b42ca9c5603cb97cbda8a@AcuMS.aculab.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 14 Feb 2022 15:53:24 -0800
Message-ID: <CAKwvOdmXxmYgqEOT4vSbN60smSkQRcc3B5duQAhaaYoaDo=Riw@mail.gmail.com>
Subject: Re: [PATCH v3] x86: use builtins to read eflags
To:     David Laight <David.Laight@aculab.com>,
        Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Tue, Feb 8, 2022 at 1:14 AM David Laight <David.Laight@aculab.com> wrote:
>
> From: Nick Desaulniers
> > Sent: 07 February 2022 22:12
> >
> > On Thu, Feb 3, 2022 at 4:57 PM Bill Wendling <morbo@google.com> wrote:
> > >
> > > GCC and Clang both have builtins to read and write the EFLAGS register.
> > > This allows the compiler to determine the best way to generate this
> > > code, which can improve code generation.
> > >
> > > This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> > > chooses to be conservative in these situations, and so uses memory
> > > instead of registers. This is a known issue, which is currently being
> > > addressed.
>
> How much performance would be lost by just using "=r"?

It adds undue register pressure.  When native_save_fl() is inlined
into callers, requiring an operand to be in a register clobbers it, so
we may need to insert stack spills + reloads for values produced
before but consumed after the asm stmt if we run out of registers to
allocate for the live range.

Looking at the disassembly of native_save_fl() or calls to
__builtin_ia32_readeflags_u64() in isolation are less interesting than
what happens once native_save_fl() starts getting inlined into
callers.

>
> You get two instructions if the actual target is memory.
> This might be a marginal code size increase - but not much,
> It might also slow things down if the execution is limited
> by the instruction decoder.

"=rm" vs "=r" is more so about whether the operands to the asm are
required to be in memory or not, rather than number of instructions
generated.

>
> But on Intel cpu 'pop memory' is 2 uops, exactly the same
> as 'pop register' 'store register' (and I think amd is similar).
> So the actual execution time is exactly the same for both.

Page 10 of Agner Fog's
https://www.agner.org/optimize/instruction_tables.pdf
shows that a pop to memory is 3 "ops" while pop to register is 2. Page
9 defines "ops" as

    Number of macro-operations issued from instruction decoder to
schedulers. Instructions with more than 2 macro-operations use
microcode.

Internally, it looks like we have benchmarks that show that
kmem_cache_free spends 5.18% of cycles in that pop-to-memory
instruction (looks like this is CONFIG_SLAB).  Further,
native_save_fl() is called by local_irq_save() all over the kernel.
After this patch, the hot spot disappears from the profile (the
push+pop becomes 0.003% of samples from 5.18%).

So I think with those above two notes, that should answer the question
"why is any of this important?"

Further, page 10 also notes that push to memory is 2 "ops" and push to
register is 1, but that doesn't make a difference in the profiles.

Additionally, I compare the disassembly of kmem_cache_free
(CONFIG_SLAB) before+after this patch. There is no difference for GCC,
but you can see quite an improvement for clang:
https://gist.github.com/nickdesaulniers/7f143bae821d86603294bf00b8bd5074
This is the kind of info I would give Thomas when he asks about
changes to GCC codegen.

To the point I made last Friday about support for actually released
versions of clang, here's how v4 of the patch makes clang codegen
worse. This is ToT llvm with f3481f43bbe2c8a24e74210d310cf3be291bf52d
reverted. (That's the commit that fixed the forcibly inserted stack
frame).
https://gist.github.com/nickdesaulniers/b4d0f6e26f8cbef0ae4c5352cfeaca67

Specifically, CONFIG_UNWINDER_FRAME_POINTER=y is improved;
CONFIG_UNWINDER_ORC=y is made worse (for all released versions of
clang, since they don't yet have
f3481f43bbe2c8a24e74210d310cf3be291bf52d).

Therefore, v5 of this patch should have something like:

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index f31a035f3c6a..2d2d4d8ab823 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -19,7 +19,12 @@
 extern inline unsigned long native_save_fl(void);
 extern __always_inline unsigned long native_save_fl(void)
 {
-#ifdef CONFIG_X86_64
+/* clang would force frame pointers via the builtins until clang-14 */
+#if defined(CC_IS_CLANG) && defined(UNWINDER_ORC) && CLANG_VERSION < 140000
+       unsigned long flags;
+       asm volatile ("pushf; pop %0" : "=rm"(flags));
+       return flags;
+#elif defined(CONFIG_X86_64)
        return __builtin_ia32_readeflags_u64();
 #else
        return __builtin_ia32_readeflags_u32();

(though I would keep the existing code and comment for the complex
case, rather than blindly applying my full diff above; and I would
wait for https://github.com/llvmbot/llvm-project/pull/42 to actually
be merged before claiming clang was fixed. oh, looks like it just was.
I'd add `Link: https://github.com/llvm/llvm-project/issues/46875`
explicitly to the commit message.)

Then once clang-14 is the minimally supported version of clang
according to Documentation/process/changes.rst we can drop the
existing inline asm and simply retain the builtins.

Thomas also asked in review of v1 that additional info about previous
commits be included in the commit message.
https://lore.kernel.org/llvm/87o85faum5.ffs@tglx/

Finally, if we need exhaustive proof that the builtins are better for
codegen, even with GCC, I think this case demonstrates so perfectly:
https://godbolt.org/z/5n3Eov1xT

Because compilers treat inline asm a black boxes, they can't schedule
instructions in the inline asm with instructions lowered from the
surrounding C statements.  With the compiler builtins, they now can,
because the assembler isn't involved.  Perhaps noting that in the
commit message would help improve the first paragraph of the commit
message of v4.

>
> Also it looks like clang's builtin is effectively "=r".

It's not; it's closer to how "=rm" should work; add register pressure
and you may find a memory operand rather than a register operand.  But
the builtin is resolved by different machinery than the inline asm.
The inline asm is conservative in the presence of both r and m and
picks m to avoid undue register pressure; r and m together is treated
as "r or m" with a priority for m.  In this case, we'd prefer r's
codegen when possible.

I read "=rm" as "r" or "m"; we'd prefer if llvm chose "r" for most
cases, but it will choose "m" conservatively which is legal by the
"or". "r" would be more precise for what we want. I'm not sure if
there are configs that could exhaust the register allocator though if
"m" was not specified as an option.

AFAICT
commit ab94fcf528d1 ("x86: allow "=rm" in native_save_fl()")
does not cite register exhaustion as a reason to permit "m", so
perhaps the version from
commit f1f029c7bfbf ("x86: fix assembly constraints in native_save_fl()")
would be preferred.  That said, who knows how "r" will affect codegen
elsewhere, which is why my suggested diff above retains "=rm" as the
constraint for the fallback code. "No functional change" for released
versions of clang.

> Compiling:
> long fl;
> void native_save_fl(void) {
>        fl = __builtin_ia32_readeflags_u64();
> }
> Not only generates a stack frame, it also generates:
> pushf; pop %rax; mov mem, %rax.

https://github.com/llvm/llvm-project/issues/46875

--
Thanks,
~Nick Desaulniers
