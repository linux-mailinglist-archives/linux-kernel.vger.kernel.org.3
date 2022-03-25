Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38174E72CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358938AbiCYMRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbiCYMRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:17:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7645E4D9FC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:15:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 375B412FC;
        Fri, 25 Mar 2022 05:15:35 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22AE33F73B;
        Fri, 25 Mar 2022 05:15:34 -0700 (PDT)
Date:   Fri, 25 Mar 2022 12:15:28 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <nathan@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: clang memcpy calls
Message-ID: <Yj2yYFloadFobRPx@lakrids>
References: <YjxTt3pFIcV3lt8I@zn.tnic>
 <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkw0Bbm+=ZyViXQhBE1L6uSbvkstHJuHpQ21tzJRftgAw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:43:46AM -0700, Nick Desaulniers wrote:
> On Thu, Mar 24, 2022 at 4:19 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Hi folks,
> >
> > so I've been looking at a recent objtool noinstr warning from clang
> > builds:
> >
> > vmlinux.o: warning: objtool: sync_regs()+0x20: call to memcpy() leaves .noinstr.text section
> >
> > The issue is that clang generates a memcpy() call when a struct copy
> > happens:
> >
> >         if (regs != eregs)
> >                 *regs = *eregs;
> 
> Specifically, this is copying one struct pt_regs to another. It looks
> like the sizeof struct pt_regs is just large enough to have clang emit
> the libcall.
> https://godbolt.org/z/scx6aa8jq
> Otherwise clang will also use rep; movsq; when -mno-sse -O2 is set and
> the structs are below ARBITRARY_THRESHOLD.  Should ARBITRARY_THRESHOLD
> be raised so that we continue to inline the memcpy? *shrug*
> 
> Though, looking at the compiled memcpy (`llvm-objdump -D
> --disassemble-symbols=memcpy vmlinux`), maybe we *should* try harder.
> Filed
> https://github.com/llvm/llvm-project/issues/54535.
> 
> > see below for asm output.
> >
> > While gcc does simply generate an actual "rep; movsq".
> >
> > So, how hard would it be to make clang do that too pls?
> 
> As Mark said in the sibling reply; I don't know of general ways to
> inhibit libcall optimizations on the level you're looking for, short
> of heavy handy methods of disabling optimizations entirely.  There's
> games that can be played with -fno-builtin-*, but they're not super
> portable, and I think there's a handful of *blessed* functions that
> must exist in any env, freestanding or not: memcpy, memmove, memset,
> and memcmp for which you cannot yet express "these do not exist."

Talking with Peter on IRC, I think there's an oversight on the compiler
side here w.r.t. the expectations around these blessed functions, since
either:

a) The compiler expects the out-of-line implementations of functions
   ARE NOT instrumented by address-sanitizer.

   If this is the case, then it's legitimate for the compiler to call
   these functions anywhere, and we should NOT instrument the kernel
   implementations of these. If the compiler wants those instrumented it
   needs to add the instrumentation in the caller.

b) The compiler expects the out-of-line implementations of functions
   ARE instrumented by address-sanitizer.

   If this is the case, the compiler MUST NOT generate implicit calls to
   these "blessed" functions from functions marked with:

     __attribute__((no_sanitize_address)).

   ... or the compiler is violating the premise of that attribute.

   AFAICT The two options for the compiler here are:

   1) Always inline an uninstrumented form of the function in this case

   2) Have distinct instrumented/uninstrumented out-of-line
      implementations, and call the uninstrumented form in this case.

To see what clang and GCC do today, I hacked the following in:

| diff --git a/init/main.c b/init/main.c
| index 65fa2e41a9c0..30406c472b5d 100644
| --- a/init/main.c
| +++ b/init/main.c
| @@ -1637,3 +1637,31 @@ static noinline void __init kernel_init_freeable(void)
|  
|         integrity_load_keys();
|  }
| +
| +void
| +test_implicit_memcpy(struct task_struct *dest,
| +                    const struct task_struct *src)
| +{
| +       *dest = *src;
| +}
| +
| +void
| +test_explicit_memcpy(struct task_struct *dest,
| +                    const struct task_struct *src)
| +{
| +       memcpy(dest, src, sizeof(*dest));
| +}
| +
| +void __no_sanitize_address
| +test_implicit_memcpy_nokasan(struct task_struct *dest,
| +                            const struct task_struct *src)
| +{
| +       *dest = *src;
| +}
| +
| +void __no_sanitize_address
| +test_explicit_memcpy_nokasan(struct task_struct *dest,
| +                            const struct task_struct *src)
| +{
| +       memcpy(dest, src, sizeof(*dest));
| +}


For arm64, GCC 11.1.0, KASAN_OUTLINE I see:

| <test_implicit_memcpy>:
|        d503245f        bti     c
|        d503233f        paciasp
|        a9be7bfd        stp     x29, x30, [sp, #-32]!
|        910003fd        mov     x29, sp
|        a90153f3        stp     x19, x20, [sp, #16]
|        aa0103f3        mov     x19, x1
|        aa0003f4        mov     x20, x0
|        d281c001        mov     x1, #0xe00                      // #3584
|        940b9534        bl      ffff8000082f9d90 <__asan_storeN>
|        aa1303e0        mov     x0, x19
|        d281c001        mov     x1, #0xe00                      // #3584
|        940b951e        bl      ffff8000082f9d44 <__asan_loadN>
|        aa1303e1        mov     x1, x19
|        aa1403e0        mov     x0, x20
|        d281c002        mov     x2, #0xe00                      // #3584
|        940b98c5        bl      ffff8000082fabf0 <memcpy>
|        a94153f3        ldp     x19, x20, [sp, #16]
|        a8c27bfd        ldp     x29, x30, [sp], #32
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_explicit_memcpy>:
|        d503245f        bti     c
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        d281c002        mov     x2, #0xe00                      // #3584
|        910003fd        mov     x29, sp
|        940b98bb        bl      ffff8000082fabf0 <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_implicit_memcpy_nokasan>:
|        d503245f        bti     c
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        d281c002        mov     x2, #0xe00                      // #3584
|        910003fd        mov     x29, sp
|        940b98b2        bl      ffff8000082fabf0 <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_explicit_memcpy_nokasan>:
|        d503245f        bti     c
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        d281c002        mov     x2, #0xe00                      // #3584
|        910003fd        mov     x29, sp
|        940b98a7        bl      ffff8000082fabf0 <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret

For x86_64, GCC 11.1.0, KASAN_OUTLINE I see:

| <test_implicit_memcpy>:
|        41 54                   push   %r12
|        49 89 fc                mov    %rdi,%r12
|        55                      push   %rbp
|        48 89 f5                mov    %rsi,%rbp
|        be 40 1c 00 00          mov    $0x1c40,%esi
|        e8 0d 9a 32 00          call   ffffffff8132b0f0 <__asan_storeN>
|        48 89 ef                mov    %rbp,%rdi
|        be 40 1c 00 00          mov    $0x1c40,%esi
|        e8 f0 99 32 00          call   ffffffff8132b0e0 <__asan_loadN>
|        4c 89 e7                mov    %r12,%rdi
|        48 89 ee                mov    %rbp,%rsi
|        b9 88 03 00 00          mov    $0x388,%ecx
|        f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)
|        5d                      pop    %rbp
|        41 5c                   pop    %r12
|        c3                      ret   
| 
| <test_explicit_memcpy>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e9 b6 9f 32 00          jmp    ffffffff8132b6d0 <memcpy>
| 
| 
| <test_implicit_memcpy_nokasan>:
|        b9 88 03 00 00          mov    $0x388,%ecx
|        f3 48 a5                rep movsq %ds:(%rsi),%es:(%rdi)
|        c3                      ret    
| 
| <test_explicit_memcpy_nokasan>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e9 96 9f 32 00          jmp    ffffffff8132b6d0 <memcpy>

So from those examples it seems GCC falls into bucket (a), and assumes the
blessed functions ARE NOT instrumented.

We can make this noinstr-safe AND get instrumentation for the first two cases
by removing the instrumentation from the out-of-line copies (always using
noinstr asm implementations) and using ifdeffery to make the explicit calls
target as distinct kasan_instrumented_memcpy() or similar...


For arm64, clang 13.0.0, KASAN_OUTLINE I see:

| <test_implicit_memcpy>:
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        910003fd        mov     x29, sp
|        5281c002        mov     w2, #0xe00                      // #3584
|        940c0f66        bl      ffff8000083185fc <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_explicit_memcpy>:
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        910003fd        mov     x29, sp
|        5281c002        mov     w2, #0xe00                      // #3584
|        940c0f5e        bl      ffff8000083185fc <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_implicit_memcpy_nokasan>:
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        910003fd        mov     x29, sp
|        5281c002        mov     w2, #0xe00                      // #3584
|        940c0f56        bl      ffff8000083185fc <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret
| 
| <test_explicit_memcpy_nokasan>:
|        d503233f        paciasp
|        a9bf7bfd        stp     x29, x30, [sp, #-16]!
|        910003fd        mov     x29, sp
|        5281c002        mov     w2, #0xe00                      // #3584
|        940c0f4e        bl      ffff8000083185fc <memcpy>
|        a8c17bfd        ldp     x29, x30, [sp], #16
|        d50323bf        autiasp
|        d65f03c0        ret

For x86_64, clang 13.0.0, KASAN_OUTLINE I see:

| <test_implicit_memcpy>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e8 d6 94 36 00          call   ffffffff8136a830 <memcpy>
|        c3                      ret  
| 
| <test_explicit_memcpy>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e8 c6 94 36 00          call   ffffffff8136a830 <memcpy>
|        c3                      ret    
| 
| 
| <test_implicit_memcpy_nokasan>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e9 b6 94 36 00          jmp    ffffffff8136a830 <memcpy>
| 
| 
| <test_explicit_memcpy_nokasan>:
|        ba 40 1c 00 00          mov    $0x1c40,%edx
|        e9 a6 94 36 00          jmp    ffffffff8136a830 <memcpy>

... for which the first two suggests clang thinks the blessed functions *are*
instrumented, which means that generating calls to those in the latter two
cases is a bug.

We can make this noinstr-safe as with the GCC case, but we'll lose the
desirable instrumentation for the test_implicit_memcpy() case.

I think something has to change on the compiler side here (e.g. as per
options above), and we should align GCC and clang on the same
approach...

Thanks,
Mark.
