Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6AE4DCF71
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiCQUiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiCQUh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:37:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E054319611F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:36:39 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bt26so10981021lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvCBQhvuhOwtfCqiEm+hthJDaVDRziXPjtYnTX7Px84=;
        b=Pb7vw1v8KqV7vMdCXksuJhYR/Z0TATOJk8MxAWV0eo+m1M/QQOaITAqAhXgsEaNHAn
         OVdl7RDl9aHsjXGHFD1lfodi4HhuuO7ryga88W9mXDwu5HKSYy+CK2HiGm/nVFQxpDaZ
         tIovYJ38do4gLiUn0qYtQGldgNe/vrnYRv+dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvCBQhvuhOwtfCqiEm+hthJDaVDRziXPjtYnTX7Px84=;
        b=X+YaYK7Dn6rkVLsgR60XVPVxFAZN1qxK+u7nVdzZ+g8vpFA0cj5g47QBjKNeKVri6w
         JXONMjx0V6CNAJlOYLBQRmcFmG9+vEnwZ40jQ9R71m9pZpmkkMTftbTDHd2aD0pBWKrJ
         78PqkeIDF0snW/x/5M49e8rmOV7sBjooUygWn9aZzdYG/oo8gQviq29T5sG6+aWXuC9W
         6aOWn8ZsqHl56gOv7TrxW3FZibbQ+kzl2m9Mlav/AcVrFABbO2BPpIjONG9USuQyi//o
         ze+z06IhKl/TGOcj430kH1iZk9cKti50qkhjUo5kJ0YT9kCIT3HspKhnXq+T5oLfy5f6
         hhwQ==
X-Gm-Message-State: AOAM5302myxOMTV3/tvU+PQ5L7LQcfxivHNXlQ+l1NyBY3jy+nJn5w/L
        Ho/cYVE6QFpr8+/fEcXwHrByUV1pI8UuJFv/dKg=
X-Google-Smtp-Source: ABdhPJzANa3MPVUuSvRplTpX2ymg4iN439MwLn4ogA9aQwb4r2DBjjBZk3aJ9s5Fr0M+VO1X7NwTaw==
X-Received: by 2002:a05:6512:2256:b0:449:f79a:e762 with SMTP id i22-20020a056512225600b00449f79ae762mr2885016lfu.261.1647549397852;
        Thu, 17 Mar 2022 13:36:37 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v2-20020ac258e2000000b004483faeb6f6sm525494lfo.280.2022.03.17.13.36.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 13:36:36 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id r22so8823114ljd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:36:36 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr4013908ljf.164.1647549396155; Thu, 17
 Mar 2022 13:36:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <878rt8gwxa.fsf@oldenburg.str.redhat.com>
In-Reply-To: <878rt8gwxa.fsf@oldenburg.str.redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 13:36:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
Message-ID: <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 1:13 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Linus Torvalds:
>
> > You can actually operate on EFLAGS at multiple granularities.
> >
> >  - normal pushf/popf. Don't do it unless you are doing system software.
>
> There's one exception: PUSHF/twiddle/POPF/PUSHF/compare is the
> recommended sequence to detect CPUID support on i386 (in userspace and
> elsewhere).

Yeah.

I do think that hand-crafted sequences using pushf/popf work. But I
think they should be in one single inline asm statement.

Obviously the kernel use of

        asm volatile("# __raw_save_flags\n\t"
                     "pushf ; pop %0"
                     : "=rm" (flags)
                     : /* no input */
                     : "memory");

is exactly that (and yes, I can well believe that we should make "=rm"
be "=r"), or at least show that the "m" case is much more expensive
some way).

Is it optimal that we put the push/pop right next to each other? No.
But it avoids a *lot* of problems.

And is that "memory" clobber because it modifies the memory location
just below the current stack pointer?

No, not really - outside the kernel that might be an issue, but we
already have to build the kernel with -mno-red-zone, so if the
compiler uses that memory location, that would be a *HUGE* compiler
bug already.

So the "memory" clobber has absolutely nothing to do with the fact
that 'pushf' updates the stack pointer, writes to that location, and
the popf then undoes it.

It's literally because we don't want the compiler to move non-spill
memory accesses around it (or other asm statements wiht memory
clobbers), regardless of the fact that the sequence doesn't really
read or write memory in any way that is relevant to the compiler.

> >  - you can use lahf/sahc to load/store only the arithmetic flags
> > into/from AH. Deprecated, and going away, but historically supported.
>
> And these instructions were missing from the original long mode, but
> they were added back.

They're also actively being deprecated, so the "adding back" ends up
being (maybe) temporary.

> GCC doesn't have barriers in the built-ins (if we are talking about
> __builtin_ia32_readeflags_u64 and __builtin_ia32_writeeflags_u64).  I
> expect they are actually pretty useless, and were merely added for
> completeness of the intrinsics headers.

Yeah, without any kinds of ordering guarantees, I think those builtins
are basically only so in name. They might as well return a random
value - they're not *useful*, because they don't have any defined
behavior.

I mean, we *could* certainly use "read eflags" in the kernel, and yes,
in theory it would be lovely if we didn't have to encode it as a
"pushf/pop" sequence, and the compiler tracked the stack pointer for
us, and perhaps combined it with other stack pointer changes to the
point where the "popf" would never happen, it would just undo the %rsp
change at function exit time.

So yes, a builtin can improve code generation.

But if there is no documented barrier guarantees, how do we know that
the read of the eflags the compiler does doesn't migrate around the
code that sets IF or whatever?

So then we'd need compiler intrinsics for 'sti' and 'cli' too. And
then we'd need to have a way to describe the ordering requirements for
*those* wrt all the other things we do (ie locks or whatever other
code that need to be protected from interrupts).

None of which exists.

And even if it ends up existing in newer compiler versions, we'd have
to wait for the better part of a decade (or more) for that to have
percolated everywhere.

And even _then_, the builtin syntax is often easily clumsier and less
flexible than what we get with inline asm (I'm thinking of the
fundamentally mis-designed memory ordering intrinsics).

                    Linus
