Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8364DE0E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 19:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbiCRSVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiCRSVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 14:21:10 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629D72EDC23
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:19:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r22so12338197ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M78EIw6ekAf0vvCqp87n4OrzGuoczE5GJbQpZ5Qld+Y=;
        b=a43MN3lVdbCSoJCJ5SmBk9a6su+AMSWcor3FNmrD7eGH/VrwkCaEgLfY5TSO7taha0
         Nyn5uFudsyLT8lo7UmV2FShc9gCj9EcOw4ROgFuOg+Ey2SBtO1HcsBoe/UzGtfe4cp88
         O6/FuGjLEzXuKavL2vAGjDq1bcAEC8qSvTK2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M78EIw6ekAf0vvCqp87n4OrzGuoczE5GJbQpZ5Qld+Y=;
        b=JgFtCmpSSyPkv6yFF23OLtqaiqYzRnOSV7XQ1XRqWE8hUZh7VLLbLbdsej2jCvtBnk
         HypzjEDnX1+XFUOIvNz9oIuPLAyocInX1OblleVgnr92vXahKURHrLrc9eJYwZ63Clb5
         Forpw4+SqxGn9BOJPM3+p4d1MjHeplmaKPgV5GmBKg0JLpJ+r/n/nUz+/FyUok9DLuDX
         cTne1j5ITECQZ7rss0xwCu8+PH9cdPnW2RQt8mo3P0PMMP7FpMtuksPIZL9B2n4YUJGw
         WaPPu9RajD1ClIvoybaaRERUaSevjob0gy441rdk/yde/q41iLmHGo1JPOWL5a0RaI9T
         9N4w==
X-Gm-Message-State: AOAM531odvmdaXQAuOsmpfth4sSJ4yJIrCmIWSMpjm5u/V1CElfxcetL
        zn9rcokP//41ZqMT8dCs3PjMn7uYUJG59Vf7Y9E=
X-Google-Smtp-Source: ABdhPJznEkwWmGDDf2zxTUTwn51PQnHYOEIBdB2+VkxOikpZpv/eal/tXjcZOkHZixd9a5QASsU3Ag==
X-Received: by 2002:a05:651c:2dc:b0:247:e451:48ae with SMTP id f28-20020a05651c02dc00b00247e45148aemr7033526ljo.248.1647627588979;
        Fri, 18 Mar 2022 11:19:48 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id bu1-20020a056512168100b004437db5e773sm954445lfb.94.2022.03.18.11.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 11:19:46 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id bn33so12331537ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 11:19:45 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr7139883ljg.176.1647627585277; Fri, 18
 Mar 2022 11:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com> <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
 <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
In-Reply-To: <83b33afc-8502-0065-60bc-3a91528632d8@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Mar 2022 11:19:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
Message-ID: <CAHk-=wj1Z_zzY7ADxaarorK5sh2xkwbcHxJTzW=bsYChWJGBGg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
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

On Fri, Mar 18, 2022 at 10:59 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I generally agree.  In this particular case, though, I will keep using
> the builtin in tools/testing/selftests/x86/helpers.h unless we actually
> hit breakage.  This is because this is *user* code, it is compiled with
> the redzone enabled, and the asm code to do the right thing when the
> redzone is enabled is too hairy for me to want to deal with it.

Yeah, redzoning is a problem for "pushf".

Or rather, it's not the redzoning itself, but the fact that the
compiler might use the word under the stack for random other things,
and the pushf will then corrupt some local variable storage.

I think it would be lovely to solve that in inline asm itself some way
- by marking the stack pointer clobbered or something.

Because you have the same issue if an inline asm might need to do a
function call - think magic calling conventions etc, but also possibly
slow-path cases.

As mentioned, it's not an issue for the kernel proper due to
-mno-red-zone which we need for entirely unrelated reasons.

Side note and kind of related: we do have this in the kernel:

  register unsigned long current_stack_pointer asm(_ASM_SP);
  #define ASM_CALL_CONSTRAINT "+r" (current_stack_pointer)

which *might* also solve the redzoning issue.

In the kernel we need it not because of redzoned stack use, but
because we need the stack frame to be set up properly or objtool
complains.

             Linus
