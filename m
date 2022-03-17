Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4374DCA40
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbiCQPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiCQPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:45:35 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664D2124C22
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 08:44:18 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2601:646:8600:40c1:d475:90a3:59ac:cd29])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 22HFhDj13844364
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 17 Mar 2022 08:43:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 22HFhDj13844364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022030301; t=1647531795;
        bh=iq7D6YdA1OTaJKtGzHn3iVLZ8tu7Cn5WGhKt1lMbUNE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=FGGpOi5jXQsuhUVdjmtqKkHmgtFolfieKStMhL05nhc+qKYArn8sUvDrGTYQQVoZ9
         1IOkQ0kl4oyQ5tXST3po09J7EWljTNdz4Hh2ez+nB7xZJTgmmYPwLBiT0WzuJlw6We
         IXuwtKS5Z2l6dyJsuqvzluYHB5kEqMQg42t4yLFhlRBYb9ZfxaBGMSokmMSkgZO1e4
         v9faz0O9pibu+yqo3eKomvCaB6BZ+xQ0QTa2p2j8mhB7cDkfNiihqEnZquriSAOaza
         rjp8fT89eAhhpTuorD3nguGhESih1b2z1TDh7XAqHRjOro7TYoiy2/0TwefT4O2OHh
         VrNXgggb5PvJg==
Date:   Thu, 17 Mar 2022 08:43:06 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Bill Wendling <morbo@google.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
User-Agent: K-9 Mail for Android
In-Reply-To: <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com> <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
Message-ID: <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 15, 2022 12:19:40 AM PDT, Bill Wendling <morbo@google=2Ecom> wrote=
:
>On Mon, Mar 14, 2022 at 6:08 PM H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> My only concern is this: how does this affect the placement of these se=
quences in relation to the things they need to protect?
>>
>With clang (and I assume it's similar with gcc), the
>__builtin_ia32_readeflags_u{64|32} builtins specify that the EFLAGS
>register is used (and the stack pointer is modified)=2E Instructions
>that may change EFLAGS are marked as defining EFLAGS, and clang and
>gcc are careful not to move instructions that access EFLAGS past them=2E
>
>One change you may see due to this patch is the compiler moving the
>"pop %=2E=2E=2E" instruction away from the "pushf" instruction=2E This co=
uld
>happen if the compiler determines that it could produce better code by
>doing so---e=2Eg=2E to reduce register pressure=2E The "gcc -O2" example
>below shows this code movement=2E
>
>-bw
>
>> On March 14, 2022 4:07:23 PM PDT, Bill Wendling <morbo@google=2Ecom> wr=
ote:
>>>
>>> On Tue, Mar 1, 2022 at 12:19 PM Bill Wendling <morbo@google=2Ecom> wro=
te:
>>>>
>>>>
>>> Bump for review=2E
>>>
>>> -bw
>>>
>>>>  This issue arose due to Clang's issue with the "=3Drm" constraint=2E=
 Clang
>>>>  chooses to be conservative in these situations and always uses memor=
y
>>>>  instead of registers, resulting in sub-optimal code=2E (This is a kn=
own
>>>>  issue, which is currently being addressed=2E)
>>>>
>>>>  This function has gone through numerous changes over the years:
>>>>
>>>>    - The original version of this function used the "=3Dg" constraint=
,
>>>>      which has the following description:
>>>>
>>>>        Any register, memory or immediate integer operand is allowed,
>>>>        except for registers that are not general registers=2E
>>>>
>>>>    - This was changed to "=3Dr" in commit f1f029c7bfbf ("x86: fix ass=
embly
>>>>      constraints in native_save_fl()"), because someone noticed that:
>>>>
>>>>        the offset of the flags variable from the stack pointer will
>>>>        change when the pushf is performed=2E gcc doesn't attempt to
>>>>        understand that fact, and address used for pop will still be t=
he
>>>>        same=2E It will write to somewhere near flags on the stack but=
 not
>>>>        actually into it and overwrite some other value=2E
>>>>
>>>>    - However, commit f1f029c7bfbf ("x86: fix assembly constraints in
>>>>      native_save_fl()") was partially reverted in commit ab94fcf528d1
>>>>      ("x86: allow "=3Drm" in native_save_fl()"), because the original
>>>>      reporter of the issue was using a broken x86 simulator=2E The
>>>>      justification for this change was:
>>>>
>>>>        "=3Drm" is allowed in this context, because "pop" is explicitl=
y
>>>>        defined to adjust the stack pointer *before* it evaluates its
>>>>        effective address, if it has one=2E  Thus, we do end up writin=
g to
>>>>        the correct address even if we use an on-stack memory argument=
=2E
>>>>
>>>>  Clang generates good code when the builtins are used=2E On one bench=
mark,
>>>>  a hotspot in kmem_cache_free went from using 5=2E18% of cycles poppi=
ng to
>>>>  a memory address to 0=2E13% popping to a register=2E This benefit is
>>>>  magnified given that this code is inlined in numerous places in the
>>>>  kernel=2E
>>>>
>>>>  The builtins also help GCC=2E It allows GCC (and Clang) to reduce re=
gister
>>>>  pressure and, consequently, register spills by rescheduling
>>>>  instructions=2E It can't happen with instructions in inline assembly=
,
>>>>  because compilers view inline assembly blocks as "black boxes," whos=
e
>>>>  instructions can't be rescheduled=2E
>>>>
>>>>  Another benefit of builtins over asm blocks is that compilers are ab=
le
>>>>  to make more precise inlining decisions, since they no longer need t=
o
>>>>  rely on imprecise measures based on newline counts=2E
>>>>
>>>>  A trivial example demonstrates this code motion=2E
>>>>
>>>>          void y(void);
>>>>          unsigned long x(void) {
>>>>                  unsigned long v =3D __builtin_ia32_readeflags_u64();
>>>>                  y();
>>>>                  return v;
>>>>          }
>>>>
>>>>  GCC at -O1:
>>>>          pushq   %rbx
>>>>          pushfq
>>>>          popq    %rbx
>>>>          movl    $0, %eax
>>>>          call    y
>>>>          movq    %rbx, %rax
>>>>          popq    %rbx
>>>>          ret
>>>>
>>>>  GCC at -O2:
>>>>          pushq   %r12
>>>>          pushfq
>>>>          xorl    %eax, %eax
>>>>          popq    %r12
>>>>          call    y
>>>>          movq    %r12, %rax
>>>>          popq    %r12
>>>>          ret
>>>>
>>>>  Link: https://gist=2Egithub=2Ecom/nickdesaulniers/b4d0f6e26f8cbef0ae=
4c5352cfeaca67
>>>>  Link: https://github=2Ecom/llvm/llvm-project/issues/20571
>>>>  Link: https://gcc=2Egnu=2Eorg/onlinedocs/gcc/Simple-Constraints=2Eht=
ml#Simple-Constraints
>>>>  Link: https://godbolt=2Eorg/z/5n3Eov1xT
>>>>  Signed-off-by: Bill Wendling <morbo@google=2Ecom>
>>>>  Reviewed-by: Nick Desaulniers <ndesaulniers@google=2Ecom>
>>>> ________________________________
>>>>  v5: - Incorporate Nick's suggestion to limit the change to Clang >=
=3D 14=2E0 and
>>>>        GCC=2E
>>>>  v4: - Clang now no longer generates stack frames when using these bu=
iltins=2E
>>>>      - Corrected misspellings=2E
>>>>  v3: - Add blurb indicating that GCC's output hasn't changed=2E
>>>>  v2: - Kept the original function to retain the out-of-line symbol=2E
>>>>      - Improved the commit message=2E
>>>>      - Note that I couldn't use Nick's suggestion of
>>>>
>>>>          return IS_ENABLED(CONFIG_X86_64) ? =2E=2E=2E
>>>>
>>>>        because Clang complains about using __builtin_ia32_readeflags_=
u32 in
>>>>        64-bit mode=2E
>>>> ________________________________
>>>>   arch/x86/include/asm/irqflags=2Eh | 10 ++++++++++
>>>>   1 file changed, 10 insertions(+)
>>>>
>>>>  diff --git a/arch/x86/include/asm/irqflags=2Eh b/arch/x86/include/as=
m/irqflags=2Eh
>>>>  index 87761396e8cc=2E=2E2eded855f6ab 100644
>>>>  --- a/arch/x86/include/asm/irqflags=2Eh
>>>>  +++ b/arch/x86/include/asm/irqflags=2Eh
>>>>  @@ -19,6 +19,11 @@
>>>>   extern inline unsigned long native_save_fl(void);
>>>>   extern __always_inline unsigned long native_save_fl(void)
>>>>   {
>>>>  +#if defined(CC_IS_CLANG) && defined(UNWINDER_ORC) && CLANG_VERSION =
< 140000
>>>>  +       /*
>>>>  +        * Clang forced frame pointers via the builtins until Clang-=
14=2E Use
>>>>  +        * this as a fall-back until the minimum Clang version is >=
=3D 14=2E0=2E
>>>>  +        */
>>>>          unsigned long flags;
>>>>
>>>>          /*
>>>>  @@ -33,6 +38,11 @@ extern __always_inline unsigned long native_save_=
fl(void)
>>>>                       : "memory");
>>>>
>>>>          return flags;
>>>>  +#elif defined(CONFIG_X86_64)
>>>>  +       return __builtin_ia32_readeflags_u64();
>>>>  +#else
>>>>  +       return __builtin_ia32_readeflags_u32();
>>>>  +#endif
>>>>   }
>>>>
>>>>   static __always_inline void native_irq_disable(void)
>>>>  --
>>>>  2=2E35=2E1=2E574=2Eg5d30c73bfb-goog
>>>>

EFLAGS is a mishmash of different things, only some of which are visible t=
o the compiler, and the semantics of which are totally different=2E

Changing IF, changing DF, changing AC, and changing the arithmetic flags h=
ave *enormously* different properties=2E The compiler can't know how the se=
mantics of a particular instance is, at least without being explicitly told=
 (giving it a some kind of mask of bits that could change=2E) The memory ba=
rrier is needed for IF changes, for example=2E

This feels like "let's fix LLVM by hacking the kernel in dangerous ways" o=
nce again! We rely on "memory" as compiler barriers *all over the place*=2E=
 This is especially so since this appears to be a suboptimal code generatio=
n issue and not a correctness issue; your change is likely to promote the f=
ormer (underoptimizing) to the latter (overoptimizing=2E)

To whatever extent my vote matters these days:

Nacked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>


