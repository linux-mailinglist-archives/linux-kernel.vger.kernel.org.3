Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEC34D900B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343570AbiCNXIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbiCNXIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:08:45 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AEC3A701
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:07:35 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w4so14771851ply.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pDvJxNeK4/mp+PjAiryte2+Q60A5QsH2N8XihtD3jS4=;
        b=BjuT7+qODcVbRzwA28zATXb9bRIgKBC67hrj8WBPuHbfdUoWwwrCjsZ1W2nJJ1iKJW
         gRIDRDZs9S4FeFpEGFdxBh3S6BWXD6sdKcKUIWwIy3xk/C6ArG2Qx0awVKp6/6MKWFOa
         OK3zM28cWxjfGv/gP19br1WHeR+PIhhLuuphWKESlXlGjUFYI2lSOWJ6gHJ5tCtWwFQK
         kS/bzZ1L/3J8oPvO34MSoGnxtY0GR/1wB5+MDAU9xBCNCJdcA6tF1qtAZDuK1vl9IKyw
         1rht4B5Z3qmRTqTVGfeN5tTxAVIPcAUi+xezNnhsOrSoRluP7+sVRKM2JwnGOaceIkeO
         DpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pDvJxNeK4/mp+PjAiryte2+Q60A5QsH2N8XihtD3jS4=;
        b=XtOqCAqulSI5QXJ6SKkonX2EcuYA5noG2nb7i/3NluKMmlpqj3EgDXPL9AHTDxm5Uq
         iSH/NmLbdfgu39r/XwwK0vpbAjRZPNlPSoIKuwg78n8Na4RRJLwJHf5/Gi5d4Q/JO4VK
         KWXYJN/LNbMlRs4pSIggAKEm9eX4j2ZwcZrM0bl9l/c6xhGzc8ewk4JbHlDDgBXzIfl/
         LXezqlcKE7np48jSTnJg0ZmCPvhmxqqmVEeRlVqP1BcRAEyFzFhkZawbSM3m4afv8vOg
         1+nMDraF6rxxz/OFDAkiIknKBJ0TfXqz99lXp+T1pCMFQIobrQggZ2L3BvZkLEjv3fa6
         WU3w==
X-Gm-Message-State: AOAM532IdvTjjDLTuvtD9x6mMFa3JkIDlldmfj5Qn2aMlol9cr3aBjGw
        ToopVftMNNCYZvQNZIYSHIXZgslnUu3IS6G7Wmpe
X-Google-Smtp-Source: ABdhPJzJx+G0De3nXifA4Rs8Uzx1ACdv6yI+B41RIfT/tQphbU/QURIeihiiMh+b1rzkjJ/F9OBW7IU8EwyI3LKC//w=
X-Received: by 2002:a17:902:720a:b0:151:d7d7:6ac0 with SMTP id
 ba10-20020a170902720a00b00151d7d76ac0mr24866948plb.128.1647299254414; Mon, 14
 Mar 2022 16:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
In-Reply-To: <20220301201903.4113977-1-morbo@google.com>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 14 Mar 2022 16:07:23 -0700
Message-ID: <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev
Cc:     LKML <linux-kernel@vger.kernel.org>
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

On Tue, Mar 1, 2022 at 12:19 PM Bill Wendling <morbo@google.com> wrote:
>
Bump for review.

-bw

> This issue arose due to Clang's issue with the "=rm" constraint. Clang
> chooses to be conservative in these situations and always uses memory
> instead of registers, resulting in sub-optimal code. (This is a known
> issue, which is currently being addressed.)
>
> This function has gone through numerous changes over the years:
>
>   - The original version of this function used the "=g" constraint,
>     which has the following description:
>
>       Any register, memory or immediate integer operand is allowed,
>       except for registers that are not general registers.
>
>   - This was changed to "=r" in commit f1f029c7bfbf ("x86: fix assembly
>     constraints in native_save_fl()"), because someone noticed that:
>
>       the offset of the flags variable from the stack pointer will
>       change when the pushf is performed. gcc doesn't attempt to
>       understand that fact, and address used for pop will still be the
>       same. It will write to somewhere near flags on the stack but not
>       actually into it and overwrite some other value.
>
>   - However, commit f1f029c7bfbf ("x86: fix assembly constraints in
>     native_save_fl()") was partially reverted in commit ab94fcf528d1
>     ("x86: allow "=rm" in native_save_fl()"), because the original
>     reporter of the issue was using a broken x86 simulator. The
>     justification for this change was:
>
>       "=rm" is allowed in this context, because "pop" is explicitly
>       defined to adjust the stack pointer *before* it evaluates its
>       effective address, if it has one.  Thus, we do end up writing to
>       the correct address even if we use an on-stack memory argument.
>
> Clang generates good code when the builtins are used. On one benchmark,
> a hotspot in kmem_cache_free went from using 5.18% of cycles popping to
> a memory address to 0.13% popping to a register. This benefit is
> magnified given that this code is inlined in numerous places in the
> kernel.
>
> The builtins also help GCC. It allows GCC (and Clang) to reduce register
> pressure and, consequently, register spills by rescheduling
> instructions. It can't happen with instructions in inline assembly,
> because compilers view inline assembly blocks as "black boxes," whose
> instructions can't be rescheduled.
>
> Another benefit of builtins over asm blocks is that compilers are able
> to make more precise inlining decisions, since they no longer need to
> rely on imprecise measures based on newline counts.
>
> A trivial example demonstrates this code motion.
>
>         void y(void);
>         unsigned long x(void) {
>                 unsigned long v = __builtin_ia32_readeflags_u64();
>                 y();
>                 return v;
>         }
>
> GCC at -O1:
>         pushq   %rbx
>         pushfq
>         popq    %rbx
>         movl    $0, %eax
>         call    y
>         movq    %rbx, %rax
>         popq    %rbx
>         ret
>
> GCC at -O2:
>         pushq   %r12
>         pushfq
>         xorl    %eax, %eax
>         popq    %r12
>         call    y
>         movq    %r12, %rax
>         popq    %r12
>         ret
>
> Link: https://gist.github.com/nickdesaulniers/b4d0f6e26f8cbef0ae4c5352cfeaca67
> Link: https://github.com/llvm/llvm-project/issues/20571
> Link: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
> Link: https://godbolt.org/z/5n3Eov1xT
> Signed-off-by: Bill Wendling <morbo@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> v5: - Incorporate Nick's suggestion to limit the change to Clang >= 14.0 and
>       GCC.
> v4: - Clang now no longer generates stack frames when using these builtins.
>     - Corrected misspellings.
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
>  arch/x86/include/asm/irqflags.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
> index 87761396e8cc..2eded855f6ab 100644
> --- a/arch/x86/include/asm/irqflags.h
> +++ b/arch/x86/include/asm/irqflags.h
> @@ -19,6 +19,11 @@
>  extern inline unsigned long native_save_fl(void);
>  extern __always_inline unsigned long native_save_fl(void)
>  {
> +#if defined(CC_IS_CLANG) && defined(UNWINDER_ORC) && CLANG_VERSION < 140000
> +       /*
> +        * Clang forced frame pointers via the builtins until Clang-14. Use
> +        * this as a fall-back until the minimum Clang version is >= 14.0.
> +        */
>         unsigned long flags;
>
>         /*
> @@ -33,6 +38,11 @@ extern __always_inline unsigned long native_save_fl(void)
>                      : "memory");
>
>         return flags;
> +#elif defined(CONFIG_X86_64)
> +       return __builtin_ia32_readeflags_u64();
> +#else
> +       return __builtin_ia32_readeflags_u32();
> +#endif
>  }
>
>  static __always_inline void native_irq_disable(void)
> --
> 2.35.1.574.g5d30c73bfb-goog
>
