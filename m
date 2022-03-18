Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0224DE09A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 18:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiCRSBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiCRSA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:00:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBE52B26;
        Fri, 18 Mar 2022 10:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63987B82456;
        Fri, 18 Mar 2022 17:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61796C340E8;
        Fri, 18 Mar 2022 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647626374;
        bh=DnhgQQxVOH3bMKPDnLoNfQArYffddzQ5u6wFD2OnS6A=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F9SpeWsTgjwsMojrDShOq/mHAJGifN2wkANWsbgJ5J69nrPcQfMG+Tu9TLWR3uaB4
         ta1BDkDp+cZwCgTRfw3ExVP0aWmzmaAVmmnDRfRNuU3kGvtAjbJo6MZ65QTh7v+I1m
         P9OJu9Z35IX4Dena4O85hCVin3RURminpfbXVFpIWfSIm6kQLOWlKZwa9dGVYgnKfZ
         3h3AAzpimeLKScsd6/Wvqfd8oUNx91kh5LhwMC4y84hpghXP9TyuN867eslGQHgKHi
         KqvqshCoHabejArvOhEKFd13KCLxOfXBCayrrbUuVhH6Qy8oFiYrBlbQrjFyjvpTWv
         xUL3ifm9OsPHA==
Message-ID: <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
Date:   Fri, 18 Mar 2022 10:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] x86: use builtins to read eflags
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
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
References: <20220210223134.233757-1-morbo@google.com>
 <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com>
 <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com>
 <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
 <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 14:39, Linus Torvalds wrote:
> On Thu, Mar 17, 2022 at 2:06 PM Andrew Cooper <Andrew.Cooper3@citrix.com> wrote:
>>
>> I was idly playing with this builtin in response to the thread, and
>> found that GCC has a far more serious bug than Clang had.
> 
> Heh. Yeah, that's bad.
> 
> But it kind of fits my argument: compiler intrinsics aren't
> necessarily such a wonderful thing. They hardly get any testing at all
> unless they are some very very core thing.
> 
> I will personally *always* prefer some generic "escape clause" over a
> compiler that thinks it knows better.
> 
> I think compiler people should see inline asm as a really *good*
> thing, because it allows people to have that "I'm going to do
> something that nobody normal does, look away now" kind of escape
> clause, letting the compiler concentrate on the things it does best.
> 
> Yes, I realize inline asm isn't something compiler people love. And
> yes, I realize that it might not give optimal code.
> 
> But think of it a bit like casts - it adds complexity to the language,
> and it might make some optimizations harder or even impossible - but
> it makes the language much more powerful and allows you to do things
> that you simply couldn't do without it.
> 
> There's a reason people use C instead of Pascal or FORTRAN. Those
> casts, and that pointer arithmetic - the bane of many optimizations -
> are really really good things.
> 
> Intrinsics should generally be shunned, not seen as a "this is an
> alternative to inline asm". They should only exist for situations
> where you can show "look, I can do so much better", and have a
> test-suite for it and a real-life case where it gives you a clear and
> undeniable uplift on a meaningful load.
> 
> (And here I separate 'intrinsic' and generic compiler builtins. I love
> the builtins that allow me to tell the compiler something, or the
> compiler to tell me something about the code: __builtin_unreachable()
> and __builtin_constant_p() are both wonderful examples of those kinds
> of things)
> 
> But an intrinsic for some odd target-specific thing that can't even be
> portably generalized? Give me inline asm any day.
> 
> We can do things with inline asms that the compiler can't even _dream_
> of, like the whole instruction rewriting thing we use.
> 
> I'd much rather have a powerful generic concept (eg "asm goto" is
> lovely) than a specialized intrinsic that does only one thing, and
> doesn't even do it well because it's untested and badly defined.
> 

I generally agree.  In this particular case, though, I will keep using 
the builtin in tools/testing/selftests/x86/helpers.h unless we actually 
hit breakage.  This is because this is *user* code, it is compiled with 
the redzone enabled, and the asm code to do the right thing when the 
redzone is enabled is too hairy for me to want to deal with it.  The 
builtins have their share of problems, but they do seem to work in this 
context.

This isn't at all an argument that we should do the same thing in actual 
kernel code.
