Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CAA4ACBDF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 23:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243790AbiBGWMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 17:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243692AbiBGWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:12:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF9BC0612A4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:12:12 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u6so29595902lfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFN1ZYBqoyYBut+IHT4rtno8V8itQS4yOxwKeKCtmn4=;
        b=DO1SsmMoZUPb8EpqEdwHK7B5xPPAQPJVqR4moEEUUS19EXPRjKIcJvUyNowKDRrUuX
         mcrC07VGFDcXhkaKsml15IF3S1BWurAGrnREufMQVhdour7Qxru/+BISVmcki+3DotLo
         zHbHVVdCjjbD/sCjBscxYVh3yLL2Il9MbEIXe06erS1zFXCLDw+xJQ7SOUJE1vIeK1yd
         z6OrvvBm/gvqyd9GQWPvXvTGwFxdfshMjbbbNRibU9purQbIbC95bEYQto8V3bR7d1ov
         g84sFOxVvuw+33dvJlhOmHfKKzsN+h7vVAUF1dmS5Wwot9B6cAyfUvgxglqPUxia5yiD
         nfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFN1ZYBqoyYBut+IHT4rtno8V8itQS4yOxwKeKCtmn4=;
        b=Ss0gajvXZ2BYscRQNFohmkl3tJ5xmHF7UDsevn37RwD6m7DxOesNRHL62MF2SNUnqb
         sy6PnZ6BRsuex3iQZfE54Sre5F8Y5FXtv/u8jFIE5Pg86q0nas7f28WRAWiGRyFqJ8CS
         E+eK0vHPBvcpJplivqngK+oijq6vcZm40f09DDxgz175FQ7ZXTuM1ctnD9ResZlbdtG0
         zIkfBdTJFsB5dJCQQCBcKHZo6JS+Qrpcq7r5TVya/HbMRXyaDWjDncHX9y7j6EffLpfn
         OUIWZYF8Jxqn9iv/8yqLmcAdtan+cROYsfcZvDquVoiTBAv/GnUfT40LLPE6E2eUgN8E
         JoRA==
X-Gm-Message-State: AOAM53214qVXALFT5CPE9+QFzt4hpX+yqaIn43r0PlvOkW8MCzb85xNy
        TY0COvKI9OB8aA8kO85OZBi7FsJj0z+YeUsvlnDHNg==
X-Google-Smtp-Source: ABdhPJxw3i4RCdalhojC+MhyaF6SAJt6gNdZ18G4Mssyxvj2N+4Vbk9x6zcG3vBGyPmTfV+iG9cTrKeLTbKYP4kuO2g=
X-Received: by 2002:ac2:4c17:: with SMTP id t23mr1027082lfq.240.1644271930244;
 Mon, 07 Feb 2022 14:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20211229021258.176670-1-morbo@google.com> <20220204005742.1222997-1-morbo@google.com>
In-Reply-To: <20220204005742.1222997-1-morbo@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Feb 2022 14:11:58 -0800
Message-ID: <CAKwvOdk=VdDo1fhWJVa4eO0UjuQwtV9kC-cJd0J9-6guU2vafA@mail.gmail.com>
Subject: Re: [PATCH v3] x86: use builtins to read eflags
To:     Bill Wendling <morbo@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

On Thu, Feb 3, 2022 at 4:57 PM Bill Wendling <morbo@google.com> wrote:
>
> GCC and Clang both have builtins to read and write the EFLAGS register.
> This allows the compiler to determine the best way to generate this
> code, which can improve code generation.
>
> This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> chooses to be conservative in these situations, and so uses memory
> instead of registers. This is a known issue, which is currently being
> addressed.
>
> However, using builtins is benefiical in general, because it removes the

s/benefiical/beneficial/

> burden of determining what's the way to read the flags register from the
> programmer and places it on to the compiler, which has the information
> needed to make that decision. Indeed, this piece of code has had several
> changes over the years, some of which were pinging back and forth to
> determine the correct constraints to use.
>
> With this change, Clang generates better code:
>
> Original code:
>         movq    $0, -48(%rbp)
>         #APP
>         # __raw_save_flags
>         pushfq
>         popq    -48(%rbp)
>         #NO_APP
>         movq    -48(%rbp), %rbx
>
> New code:
>         pushfq
>         popq    %rbx
>         #APP

But it also forces frame pointers due to another bug in LLVM.
https://godbolt.org/z/6badWaGjo
For x86_64, we default to CONFIG_UNWINDER_ORC=y, not
CONFIG_UNWINDER_FRAME_POINTER=y.  So this change would make us use
registers instead of stack slots (improvement), but then force frame
pointers when we probably didn't need or want them (deterioration) for
all released versions of clang.

I think we should fix https://reviews.llvm.org/D92695 first before I'd
be comfortable signing off on this kernel change.  Again, I think we
should test out Phoebe's recommendation
https://reviews.llvm.org/D92695#inline-1086936
or do you already have a fix that I haven't yet been cc'ed on, perhaps?

>
> Note that the stack slot in the original code is no longer needed in the
> new code, saving a small amount of stack space.
>
> There is no change to GCC's ouput:
>
> Original code:
>
>         # __raw_save_flags
>         pushf ; pop %r13        # flags
>
> New code:
>
>         pushfq
>         popq    %r13    # _23
>
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
> v3: - Add blurb indicating that GCC's output hasn't changed.
> v2: - Kept the original function to retain the out-of-line symbol.
>     - Improved the commit message.
>     - Note that I couldn't use Nick's suggestion of
>
>         return IS_ENABLED(CONFIG_X86_64) ? ...
>
>       because Clang complains about using __builtin_ia32_readeflags_u32 in
>       64-bit mode.
> ---
>  arch/x86/include/asm/irqflags.h | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 87761396e8cc0..f31a035f3c6a9 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -19,20 +19,11 @@
>  extern inline unsigned long native_save_fl(void);
>  extern __always_inline unsigned long native_save_fl(void)
>  {
> -       unsigned long flags;
> -
> -       /*
> -        * "=rm" is safe here, because "pop" adjusts the stack before
> -        * it evaluates its effective address -- this is part of the
> -        * documented behavior of the "pop" instruction.
> -        */
> -       asm volatile("# __raw_save_flags\n\t"
> -                    "pushf ; pop %0"
> -                    : "=rm" (flags)
> -                    : /* no input */
> -                    : "memory");
> -
> -       return flags;
> +#ifdef CONFIG_X86_64
> +       return __builtin_ia32_readeflags_u64();
> +#else
> +       return __builtin_ia32_readeflags_u32();
> +#endif
>  }
>
>  static __always_inline void native_irq_disable(void)
> --
> 2.35.0.263.gb82422642f-goog
>


-- 
Thanks,
~Nick Desaulniers
