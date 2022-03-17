Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9874DCFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiCQVL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiCQVL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:11:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D6E111DEF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:10:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so2816941pjm.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Plv3qFJV4Lb71g1Cd3cAsDGLjYDWIwI/2QmHRRATbM=;
        b=GsA2phHoKS3U+n8Q+EKkao1i2kLYoXBiTwVxlNflDcHfrWF1kVZ3ya+EF0m7ANPm7/
         uSkG6ZPYThP1KALJnZonIggc4+Qbc3BLrX67TnXQ/tcFBU9yv8f60/ejL5Znzp4dl/fI
         TDLSSvtK3NpSB3G9m0WtnXqAaifVcl+W6YiUXbEw6ascIF9cRDcgkGxZaf2vBtMPr5ON
         Rof96we0l6PJZPace6iXgeQL8ewmyusPrAvS7iQbcQedc2ol0MWDD4+Tq9h2mABOJvrp
         l24xn1xvaELgFSBYZiCtunufIPdl1x/nfZiwpFGYgeGaaisFepwT/fPc2ssFOLCkLQk1
         hbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Plv3qFJV4Lb71g1Cd3cAsDGLjYDWIwI/2QmHRRATbM=;
        b=0U8BM37OtbwrMAIk0PqeMA6YyV1p7Yh3Zoek2mqAaCpjWHnoPzxTeaPxzP+gGKP/cE
         Awc5cpR2kHuZGUeKpKaCmbgRH6AlQi/hxq0O1/MAwY/8J0burwO3qyOHRFdiJOsxsjlT
         ozDvlWV3/hj1ep5idyXnTc4k3moJoPS9g9g2tAc3BiEn7HaFernzVZnMuziZbtWeLhz9
         K1Sz3Wr3KCCTcOvtKRK9Nv2TVSNI2NcEf8/gnH5K3Wt17WLSxKnyLSxbHyDqJvtqqU/w
         t650rBpVwtlyVH+NvoQP7Ad0Rw2QR8JlJ6f0AnDbfmglbaDCBq6Awm4QEDyK7Nnrtt8w
         wjkQ==
X-Gm-Message-State: AOAM5329P1ipFfuQTigLbsbaXEBQU303RjPU3jo4NvWw3aSy3Ix/Mp1Y
        X8bqA4L1jupj/a4sa6kmL+zf7HFjxJJdvgESf0fm
X-Google-Smtp-Source: ABdhPJxC8OIOPRXGPhnWhN6huylqzUCmakX11MfWKeA7T21PbxLjlgXH2PvpNewX8QzF31AqO4WjQOulXIuIUkPKaSs=
X-Received: by 2002:a17:90b:1d83:b0:1bf:39d7:207d with SMTP id
 pf3-20020a17090b1d8300b001bf39d7207dmr18277640pjb.130.1647551438363; Thu, 17
 Mar 2022 14:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <CAGG=3QW2ey2w91TxqJ6tzfJOswhTce2e0QTW7kAWyvxeiO+VNg@mail.gmail.com> <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
In-Reply-To: <CAHk-=whn3iYE7gZM4vHx1kFhWBD2P9Wvmcyj8OOqv=y_7nemGQ@mail.gmail.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 17 Mar 2022 14:10:27 -0700
Message-ID: <CAGG=3QWC9VS9RdGFTwY8VGqujDnFYnRTT1dQ6kkVr+0SRk6COg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 1:14 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 17, 2022 at 12:45 PM Bill Wendling <morbo@google.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 11:52 AM Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > But the whole "you can't move _other_ things that you don't even
> > > understand around this either" is equally important. A "disable
> > > interrupts" could easily be protecting a "read and modify a CPU MSR
> > > value" too - no real "memory" access necessarily involved, but
> > > "memory" is the only way we can tell you "don't move this".
> > >
> > And yet that's not guaranteed. From
> > https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html:
>
> That's my point exactly.
>
> The 'volatile' part of 'asm volatile' is almost meaningless.
>
> As a result, we mark pretty much all system instructions as being
> memory clobbers, because that actually works.
>
For now.

> Whether they actually clobber memory or not is immaterial, and is not
> why we do it.
>
I understand that. My point is that it's not a guarantee that the
compiler won't change in the future.

> > Note that the solution _isn't_ to add a "memory" clobber, because it's
> > not guaranteed to work, as it's explicitly defined to be a read/write
> > _memory_ barrier, despite what kernel writers wish it would do.
>
> The solution you quote *ALSO* doesn't work, because they used a
> pointless example that was made-up in order to get to that solution.
>
> Nobody cares about an operation being ordered wrt an addition.
>
It's a short example to demonstrate what they meant. I doubt it was
meant to be definitive. And I'm not suggesting that it's a general
solution to the "we want the ordering to be this and don't change it!"
issue. I'm just pointing out that even the current code isn't
guaranteed to remain ordered.

> Mostly kernel people care about an operation being ordered wrt
> something that the compiler DOES NOT KNOW ABOUT, and there is no way
> to actually tell the compiler, exactly because the compiler has no
> effin idea about it.
>
> But the other thing kernel people care about is ordering those
> operations wrt externally visible things - like modifying memory. So
> an MSR write (or a write to a register like %CR0) may not itself
> directly read or modify memory at all, but there are other reasons why
> it might need to be ordered with any memory operations around it
> anyway, because some of those memory operations may be indirectly
> relevant (ie maybe they are page table writes and you just changed the
> page table pointer in %CR0, and now - even if you don't access the
> particular memory location, speculation may cause TLB fills to happen
> at any time).
>
> You can't tell the compiler "this eflags operation must be ordered wrt
> this MSR write" - because even if the compiler knows about eflags, it
> doesn't know about things like page table contents or specific MSR
> bits, or whatever.
>
> In a perfect world, we could actually enumerate resources we cared
> about somehow. But that world is not the world we live in.
>
> So we end up basically having exactly *ONE* resource we can use as a
> "the compiler knows about this, and lets us use it as a
> synchronization point".
>
> That one resource is "memory". You may not like it, but you have
> absolutely zero realistic alternatives, do you?
>
> > Your assertion that compilers don't know about control registers isn't
> > exactly true. In the case of "pushf/popf", those instructions know
> > about the eflags registers. All subsequent instructions that read or
> > modify eflags also know about it. In essence, the compiler can
> > determine its own clobber list, which include MSRs.
>
> Nope.
>
> I think you are thinking of the arm64 MSR's. As far as I know, no
> compiler out there - and certainly not the complete set of compilers
> we support - know a thing about x86 msr registers. It's all inline
> asm.
>
> And honestly, no sane person would _want_ a compiler worrying about x86 MSR's.
>
It's true that a compiler won't take a seemingly unrelated resource
(MSR) into account ("unrelated" only in that the ordering is important
to the programmer, but the compiler doesn't see an interaction and
thus may move it). There was a discussion on that topic here:

https://lore.kernel.org/lkml/CAMj1kXFnUuWLyy5q-fAV1jwZobTCNHqhKSN3mF98frsJ4ai4Ow@mail.gmail.com/T/#md85de238571dfe2bb4e4a822e6c983fb7a5ecf60

I don't think a conclusion was reached about preventing a reordering.

-bw
