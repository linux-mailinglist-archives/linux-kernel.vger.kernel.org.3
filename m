Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851EE4DE41A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiCRWgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232757AbiCRWgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:36:02 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762F330CDBA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:34:42 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2601:646:8600:40c1:8f0c:2533:51ff:d719])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 22IMXbqB1001693
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 18 Mar 2022 15:33:37 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 22IMXbqB1001693
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022030301; t=1647642819;
        bh=x1v0nq7kPt+f8iXcRaBG2tod+dalRNQHXEngMUyoFv0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=wfzhfJmKI+EcGGBuGNNF7MHAcSmVBdhnqjh1Owep4oDnpzdedjVJFdokB68gVc1/u
         ux6CpQ/XYpQnL/ZSjL4J7Edmi9UhV7/8aJUqqiZ0DavgKLcdZ2jSbKYn3ygpLyWJ3A
         IPKBLexhQ6Q6ISTLI3U2f0AFAilY3aH4LCicE8rmzejW4eRETUHTTRZUNFzVN2cWCR
         zcNp/uM0VqkCdejBzTg8jXdnZv2pcjPkSU1h7APbF1U/MZjuabG5EBIAbHVQt3rkaE
         z/AlQhsfx70EW2kCGJ9Htt4uT2hwVw/cMsUwE5M7VF1L3sZOgzzZByNn0uocvnnFN3
         +cg4QnKbJ5pfg==
Date:   Fri, 18 Mar 2022 15:33:31 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-toolchains <linux-toolchains@vger.kernel.org>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
User-Agent: K-9 Mail for Android
In-Reply-To: <20220318220901.GS614@gate.crashing.org>
References: <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com> <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com> <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com> <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com> <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com> <20220318220901.GS614@gate.crashing.org>
Message-ID: <8F6F31A0-0AFC-477D-8B5F-9E8B308CDDAA@zytor.com>
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

On March 18, 2022 3:09:01 PM PDT, Segher Boessenkool <segher@kernel=2Ecrash=
ing=2Eorg> wrote:
>On Fri, Mar 18, 2022 at 11:19:28AM -0700, Linus Torvalds wrote:
>> Or rather, it's not the redzoning itself, but the fact that the
>> compiler might use the word under the stack for random other things,
>> and the pushf will then corrupt some local variable storage=2E
>>=20
>> I think it would be lovely to solve that in inline asm itself some way
>> - by marking the stack pointer clobbered or something=2E
>
>Inline assembler does not allow you to change the stack pointer, in
>principle=2E  You have to return everything to its original state before
>you return control from the asm code, and you have to deal with what
>happens if am interrupt comes in halfway through the asm, and all other
>ABI things that may happen on your platform=2E
>
>> Because you have the same issue if an inline asm might need to do a
>> function call - think magic calling conventions etc, but also possibly
>> slow-path cases=2E
>
>Yes=2E  The compiler itself can deal with all the red zone restrictions -=
-
>precisely *because* it is in full control of the stack frame -- but
>those restrictions are very real=2E  It generally is a very good idea to
>have a redzone though, without it you pay much more than necessary for
>frame setup and teardown in leaf functions (similar to some of what the
>misnamed "shrink-wrapping" optimisation does, but the two are mostly
>independent, the benefits add up)=2E
>
>> As mentioned, it's not an issue for the kernel proper due to
>> -mno-red-zone which we need for entirely unrelated reasons=2E
>
>It might help to have some special clobber syntax that says "this asm
>clobbers the red zone", so the compiler can arrange for the red zone to
>contain nothing during the asm (it already does the same for function
>calls, for example)=2E
>
>How bad is it to do the fail-safe general solution here though?  I=2Ee=2E=
,
>write actual assembler code:
>
># u16 getflags(void);
>getflags:
>	pushf
>	pop %ax
>	ret
>
>(or whatever the syntax is, my x86 is rusty)=2E
>
>> Side note and kind of related: we do have this in the kernel:
>>=20
>>   register unsigned long current_stack_pointer asm(_ASM_SP);
>>   #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)
>>=20
>> which *might* also solve the redzoning issue=2E
>
>The GCC documentation of inline asm says
>  Another restriction is that the clobber list should not contain the
>  stack pointer register=2E  This is because the compiler requires the
>  value of the stack pointer to be the same after an 'asm' statement as
>  it was on entry to the statement=2E  However, previous versions of GCC
>  did not enforce this rule and allowed the stack pointer to appear in
>  the list, with unclear semantics=2E  This behavior is deprecated and
>  listing the stack pointer may become an error in future versions of
>  GCC=2E
>
>> In the kernel we need it not because of redzoned stack use, but
>> because we need the stack frame to be set up properly or objtool
>> complains=2E
>
>If the kernel has special rules for the stack, it had better teach the
>compiler about this special ABI, or there will be tears eventually=2E  If
>the kernel requires only what the standard ABIs provide, it can trust
>the compiler to do that correctly, this is one of the core jobs of a
>compiler!
>
>
>Segher

It is extremely common for inline assembly to be written using push/pop or=
 call sequences, and not just because of eflags=2E In the kernel redzone is=
 (currently) not supported (with FRED exception handling it would be possib=
le to support it as a kernel-wide compile-time option), but there needs to =
be a way to communicate this to the compiler=2E 
