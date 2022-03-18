Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A938D4DE46F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241446AbiCRXMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbiCRXMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:12:35 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F41B111DD8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:11:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id p15so5548404lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w17JTccyG7Hu5QzrK8YkGK5ZNCS3sFkaT90voeSdkM8=;
        b=cLQTEpkdWC2iejrFcbaeZaTYVZtnf6ppDlPoWHG3WLuvfgvVuinp5NMg79PXPpdFvH
         gZtv89SFNJBweBpXijc5Z7vKFrmBIaNpI7tR2i6bK9UlWPOJDDmdW0uGNlVgllDgowTV
         p3FHr8IyH/D68PKslFErhgQipgSB//BagoF2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w17JTccyG7Hu5QzrK8YkGK5ZNCS3sFkaT90voeSdkM8=;
        b=Z+i9+l2jMoC+4AJTBwaW53m/S54q5rbb/MfI333a64/2Zy4p1aiquB+Z7gpaet96pJ
         BqicgO9C0i13Mm2pY0sEhH5+VTvicd/Bs7U17n2TgV7g9EZo6K13HyQKKw+cA6TWbFwO
         /7vc971Xq0a4HOt268uphazj87S1CNHHcshEYdePUX5y1cTGSLxnzXKYFkVkHU0yzE/G
         iGdtUQx90u12PUBecTmeoIW6WMgrBSO0fIkFwR9zD4R7fMyAhlZWj4xCA9tYYMWWs5sC
         nmckdsaxYJc5eS1TTlZrmIF9w2z6PIaKVcYLKbJHDE9E65akZX+i2kGv9imbQG1sBcvc
         JrVg==
X-Gm-Message-State: AOAM532aAqsvlvnnnbarY2tEEeJU1kdWsDNQqleWiQoY6k37RVQ8u0md
        pfeqNRtYorV5S9dW7tgPvZUrDU9yOd8/zeACPkU=
X-Google-Smtp-Source: ABdhPJwapTFbycsdKmugj4M8DR+sIXLlteEFCAFR+MYg/Zys7dB/KRyscTRrCBa9DxkdDjkmhhUsrQ==
X-Received: by 2002:a05:6512:308e:b0:448:3826:6d68 with SMTP id z14-20020a056512308e00b0044838266d68mr7078610lfd.184.1647645073333;
        Fri, 18 Mar 2022 16:11:13 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e3-20020a196743000000b0044311216c42sm1036630lfj.307.2022.03.18.16.11.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 16:11:12 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id s25so13095175lji.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:11:12 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr7817380ljg.176.1647645071884; Fri, 18
 Mar 2022 16:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org> <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
 <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com>
In-Reply-To: <9a97330b-e5ee-7b7e-4c7a-cfdf15032094@citrix.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 16:10:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
Message-ID: <CAHk-=wgKBme-SdbkSxbQ4+c6tZdvY2fe1wP1TgJeuDAf+AgwMg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Fri, Mar 18, 2022 at 2:48 PM Andrew Cooper <Andrew.Cooper3@citrix.com> wrote:
>
> As such, I'm not sure how current_stack_pointer can work as intended in
> all cases...

So as mentioned, the kernel doesn't really care, since for the kernel
that inline asm use is more of a "get proper backtraces" thing. The
compiler thinks the function is a leaf function, doesn't set up a
frame for a call that  happens inside the inline asm.

The code *works* without it, but the frame annotations aren't right.

And obviously we don't actually *(change* the stack pointer. Or
rather, a call will do exactly as with pushf/pop: rsp gets updated
there but gets put right back.

See commit 317c2ce77d8a ("x86/alternatives: Add stack frame dependency
to alternative_call_2()") for some details.

And yes, that trick then caused problems with clang, and we did
f5caf621ee35 ("x86/asm: Fix inline asm call constraints for Clang")
that created the current situation.

It would be lovely to have some explicit model for "I want the frame
to have been set up for backtraces", but here we are. Marking '%rsp
used makes the compiler understand it's not a leaf function.

And while we have other uses for it that then use the actual value,
those don't care about the exact value of the stack pointer register,
they just want "give me a pointer that is contained within the current
stack", because we control the stack allocation and do funky things
there. So "any random stack pointer value in this function" is
perfectly fine and expected.

But for user mode, it would probably be a great idea to also have a "I
cannot use a redzone in this function" thing. The kernel can't use it
because we have nested exceptions, but maybe some day even the kernel
could make use of (controlled) red-zoning.

            Linus
