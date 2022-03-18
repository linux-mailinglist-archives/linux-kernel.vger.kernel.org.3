Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D924DD28F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiCRBw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiCRBw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:52:26 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051C4196091
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:51:06 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h14so11869725lfk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzHOurcRZLEPdx5A8AtvMQus3L3vLI1jvcmAUoK7M3M=;
        b=QipcaPzemhcgIfEJYN144w0FnjRfqRUr/lWiEGEPhGe/qWrPlffischpqBrRPHT5m3
         Qe3ydqH/K9tObWP9AdmckmHt49bsCYrU9T+CBDF9fX8Zs8e9aORdJWAYCX4yUAPM9H/j
         m9xf6179ufuVV3J1o5iE6xXJG7Ck51v7CCX+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzHOurcRZLEPdx5A8AtvMQus3L3vLI1jvcmAUoK7M3M=;
        b=O5Bko5Yh2iTx1LrWhmMe43gGCKDW3gX5kQXMGVm43gXIEV9g6N7jgg/Le4FbbVcRm8
         EbBcDJPJtnMYsZlDm1++RX4a8jCVrZ3mCmVZnEXog2i0JosZfAvAskP6218nTHHExr5/
         /f+lDXLql10nthGHGckpoqs6FLUOhnut4OS6L1z3ANnLkjN0WR17Syv1N0THw7Prb0q3
         eKCPgkQk4bR78eAMh+OdhElxV9YGp+LdqX616nGz+UGfym/jHRYQUzRDtxjOZMbmWwi+
         bFGo3KEY9YDqae2YVtuoFCBgzXo0PxoP18tg7mH+OYjXPxQ7FBt+zOkKgLiHvDo0VCeB
         LXAw==
X-Gm-Message-State: AOAM532CK2+QZ3bDvaFYxaobiRHGv2Po/RX6zqd+RXQeviKadaezcUzB
        PU9/Wnn2ZqH3SDEfZikt5pZaLCFiC+yX4bzCyeA=
X-Google-Smtp-Source: ABdhPJyS8w8KP8QHVxUF5utZJmcOh+7Pt49EDbeAnk1mqoF9zTrfepHNiZgR0YdvGed/PS6l6Qz4Sw==
X-Received: by 2002:a05:6512:34d2:b0:44a:b81:85c2 with SMTP id w18-20020a05651234d200b0044a0b8185c2mr674454lfr.689.1647568263931;
        Thu, 17 Mar 2022 18:51:03 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id i27-20020a198c5b000000b004487eabc006sm612491lfj.253.2022.03.17.18.51.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 18:51:03 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id h11so9585601ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:51:02 -0700 (PDT)
X-Received: by 2002:a05:651c:1509:b0:249:6cd6:96d8 with SMTP id
 e9-20020a05651c150900b002496cd696d8mr685036ljf.358.1647568262431; Thu, 17 Mar
 2022 18:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <878rt8gwxa.fsf@oldenburg.str.redhat.com> <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
 <20220318002555.GP614@gate.crashing.org> <CAHk-=wjRfJijS5yJsLFzyJS6HFh46q8Eu6EvjGGjJSZ1+m74_Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjRfJijS5yJsLFzyJS6HFh46q8Eu6EvjGGjJSZ1+m74_Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 18:50:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibzB9fSXZf79FhjAvoLsPP0YG4VKjQy0jZE8BZj8uBOg@mail.gmail.com>
Message-ID: <CAHk-=wibzB9fSXZf79FhjAvoLsPP0YG4VKjQy0jZE8BZj8uBOg@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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

On Thu, Mar 17, 2022 at 6:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Now, compare that to just using inline asm: it's trivial, and we've
> used it basically unchanged for three decades.

Ok, so going _really_ far back, we used to have them literally written out:

        __asm__ __volatile__("pushfl ; popl %0 ; cli":"=r" (flags));

in random code, and then in October 1992 switched those nasty things
to instead use

   #define cli() __asm__ __volatile__ ("cli"::)

    #define save_flags(x) \
    __asm__ __volatile__("pushfl ; popl %0":"=r" (x))

and the code was changed to actually use

        save_flags(flags);
        cli();

instead of that open-coded raw asm.

And the "memory" clobber was added early June, 1993:

   #define save_flags(x) \
  -__asm__ __volatile__("pushfl ; popl %0":"=r" (x))
  +__asm__ __volatile__("pushfl ; popl %0":"=r" (x)::"memory")

so that thing really has existed in pretty much that exact form for
almost 30 years.

There's been tweaks since (the "=r" became "=g" before becoming "=rm",
comments have been added, "pushfl" became just "pushf" with x86-64,
and the thing has moved around and is now called "native_save_fl()" in
a completely different header file etc)

But at no point was it ever as buggy as the actual gcc intrinsic seems
to be today, nor have we needed to check for compiler versions etc.

                  Linus
