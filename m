Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE524D951A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbiCOHVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345345AbiCOHVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:21:08 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957C4AE26
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:19:52 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id z16so18236877pfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 00:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p6a+ldiuXESu4qxXGLzCnVcToyGykG8cnSUJjrZSQGk=;
        b=XfmeXGN74t17L1BFQbR7/m90bVFPgD96D0wRoiR1no2Afczoyz7KefF2F19z+S2D72
         s7rwtI1TXV4RHN2/ra47AllVCgx4vmZ+S1Q4Xj8kKRjo6GpWbzEsekyh8ueaJjQmlWRG
         8MTIq4oQmWvSEhpCMAQwb/2irUXgi8TlXL3MnQbHs8UnnBg24rZ/ecxoLg8uPyEnveDX
         3lP3my/DQkkKj2ay6xn/WZAXnu9S+wIXttDlK/Vhcqr2ZHrBtpzUjz76C/K1I7RdzltL
         dTYPHETRgbUj5Ys7TFyvv/QvWJOrJT7BWZuCDv8e9iIo+IKjTZUJJyPSoI9rgW1xXxAR
         cLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p6a+ldiuXESu4qxXGLzCnVcToyGykG8cnSUJjrZSQGk=;
        b=489JlQWD3iukaAvNHn3KUG31eOiyxkMubMcUAzhXIQ1NAN1staC2cYrA/toz+qzAj6
         GiHiiZd5wOs19G65H6A1fWFkkyCN246NemuVV1gK1tW/BLByyuCE4d2W5rhfFtp0avdA
         JNMPnsSq6SNHO0BRzB/6Uo3fy8Fn4i0Tcw/71WqlLlitc30MEWuEINo6Xtw0uw/z43oD
         oq66VlBBqD+I4aPcNJ8F8mTrzOKYKtw58uqxcNPVTXrXqFS1D79JPrHqdyj726cJwk5g
         JMCC4sKCWjnPI1Q0fnLJCT3hredAQ8o2FyWASMc4dl3BIb7wthsQVV3fpTsXK6ucM+Rl
         BE7Q==
X-Gm-Message-State: AOAM533EX7Lcl1vYF3outtkqeg0FSO3k6ARNErQ4zo8+OAfx8kepzwwY
        AjklPbE5WOO8m8zwfEm53B1q0t74ZNVuoWgsnwV2
X-Google-Smtp-Source: ABdhPJwDanBd0HC6cmWxvTTs2OyG7r1sqAWmV7ySSFTcT8DLEthzhhmJLZoslQFRxcp34sWAxzqDxJvCep1a8qx6HdA=
X-Received: by 2002:a63:8348:0:b0:380:bcc4:861f with SMTP id
 h69-20020a638348000000b00380bcc4861fmr22998547pge.151.1647328791308; Tue, 15
 Mar 2022 00:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
In-Reply-To: <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
From:   Bill Wendling <morbo@google.com>
Date:   Tue, 15 Mar 2022 00:19:40 -0700
Message-ID: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 6:08 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> My only concern is this: how does this affect the placement of these sequences in relation to the things they need to protect?
>
With clang (and I assume it's similar with gcc), the
__builtin_ia32_readeflags_u{64|32} builtins specify that the EFLAGS
register is used (and the stack pointer is modified). Instructions
that may change EFLAGS are marked as defining EFLAGS, and clang and
gcc are careful not to move instructions that access EFLAGS past them.

One change you may see due to this patch is the compiler moving the
"pop %..." instruction away from the "pushf" instruction. This could
happen if the compiler determines that it could produce better code by
doing so---e.g. to reduce register pressure. The "gcc -O2" example
below shows this code movement.

-bw

> On March 14, 2022 4:07:23 PM PDT, Bill Wendling <morbo@google.com> wrote:
>>
>> On Tue, Mar 1, 2022 at 12:19 PM Bill Wendling <morbo@google.com> wrote:
>>>
>>>
>> Bump for review.
>>
>> -bw
>>
>>>  This issue arose due to Clang's issue with the "=rm" constraint. Clang
>>>  chooses to be conservative in these situations and always uses memory
>>>  instead of registers, resulting in sub-optimal code. (This is a known
>>>  issue, which is currently being addressed.)
>>>
>>>  This function has gone through numerous changes over the years:
>>>
>>>    - The original version of this function used the "=g" constraint,
>>>      which has the following description:
>>>
>>>        Any register, memory or immediate integer operand is allowed,
>>>        except for registers that are not general registers.
>>>
>>>    - This was changed to "=r" in commit f1f029c7bfbf ("x86: fix assembly
>>>      constraints in native_save_fl()"), because someone noticed that:
>>>
>>>        the offset of the flags variable from the stack pointer will
>>>        change when the pushf is performed. gcc doesn't attempt to
>>>        understand that fact, and address used for pop will still be the
>>>        same. It will write to somewhere near flags on the stack but not
>>>        actually into it and overwrite some other value.
>>>
>>>    - However, commit f1f029c7bfbf ("x86: fix assembly constraints in
>>>      native_save_fl()") was partially reverted in commit ab94fcf528d1
>>>      ("x86: allow "=rm" in native_save_fl()"), because the original
>>>      reporter of the issue was using a broken x86 simulator. The
>>>      justification for this change was:
>>>
>>>        "=rm" is allowed in this context, because "pop" is explicitly
>>>        defined to adjust the stack pointer *before* it evaluates its
>>>        effective address, if it has one.  Thus, we do end up writing to
>>>        the correct address even if we use an on-stack memory argument.
>>>
>>>  Clang generates good code when the builtins are used. On one benchmark,
>>>  a hotspot in kmem_cache_free went from using 5.18% of cycles popping to
>>>  a memory address to 0.13% popping to a register. This benefit is
>>>  magnified given that this code is inlined in numerous places in the
>>>  kernel.
>>>
>>>  The builtins also help GCC. It allows GCC (and Clang) to reduce register
>>>  pressure and, consequently, register spills by rescheduling
>>>  instructions. It can't happen with instructions in inline assembly,
>>>  because compilers view inline assembly blocks as "black boxes," whose
>>>  instructions can't be rescheduled.
>>>
>>>  Another benefit of builtins over asm blocks is that compilers are able
>>>  to make more precise inlining decisions, since they no longer need to
>>>  rely on imprecise measures based on newline counts.
>>>
>>>  A trivial example demonstrates this code motion.
>>>
>>>          void y(void);
>>>          unsigned long x(void) {
>>>                  unsigned long v = __builtin_ia32_readeflags_u64();
>>>                  y();
>>>                  return v;
>>>          }
>>>
>>>  GCC at -O1:
>>>          pushq   %rbx
>>>          pushfq
>>>          popq    %rbx
>>>          movl    $0, %eax
>>>          call    y
>>>          movq    %rbx, %rax
>>>          popq    %rbx
>>>          ret
>>>
>>>  GCC at -O2:
>>>          pushq   %r12
>>>          pushfq
>>>          xorl    %eax, %eax
>>>          popq    %r12
>>>          call    y
>>>          movq    %r12, %rax
>>>          popq    %r12
>>>          ret
>>>
>>>  Link: https://gist.github.com/nickdesaulniers/b4d0f6e26f8cbef0ae4c5352cfeaca67
>>>  Link: https://github.com/llvm/llvm-project/issues/20571
>>>  Link: https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
>>>  Link: https://godbolt.org/z/5n3Eov1xT
>>>  Signed-off-by: Bill Wendling <morbo@google.com>
>>>  Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>>> ________________________________
>>>  v5: - Incorporate Nick's suggestion to limit the change to Clang >= 14.0 and
>>>        GCC.
>>>  v4: - Clang now no longer generates stack frames when using these builtins.
>>>      - Corrected misspellings.
>>>  v3: - Add blurb indicating that GCC's output hasn't changed.
>>>  v2: - Kept the original function to retain the out-of-line symbol.
>>>      - Improved the commit message.
>>>      - Note that I couldn't use Nick's suggestion of
>>>
>>>          return IS_ENABLED(CONFIG_X86_64) ? ...
>>>
>>>        because Clang complains about using __builtin_ia32_readeflags_u32 in
>>>        64-bit mode.
>>> ________________________________
>>>   arch/x86/include/asm/irqflags.h | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>>  diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
>>>  index 87761396e8cc..2eded855f6ab 100644
>>>  --- a/arch/x86/include/asm/irqflags.h
>>>  +++ b/arch/x86/include/asm/irqflags.h
>>>  @@ -19,6 +19,11 @@
>>>   extern inline unsigned long native_save_fl(void);
>>>   extern __always_inline unsigned long native_save_fl(void)
>>>   {
>>>  +#if defined(CC_IS_CLANG) && defined(UNWINDER_ORC) && CLANG_VERSION < 140000
>>>  +       /*
>>>  +        * Clang forced frame pointers via the builtins until Clang-14. Use
>>>  +        * this as a fall-back until the minimum Clang version is >= 14.0.
>>>  +        */
>>>          unsigned long flags;
>>>
>>>          /*
>>>  @@ -33,6 +38,11 @@ extern __always_inline unsigned long native_save_fl(void)
>>>                       : "memory");
>>>
>>>          return flags;
>>>  +#elif defined(CONFIG_X86_64)
>>>  +       return __builtin_ia32_readeflags_u64();
>>>  +#else
>>>  +       return __builtin_ia32_readeflags_u32();
>>>  +#endif
>>>   }
>>>
>>>   static __always_inline void native_irq_disable(void)
>>>  --
>>>  2.35.1.574.g5d30c73bfb-goog
>>>
