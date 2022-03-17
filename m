Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6243D4DD04E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiCQVlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 17:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiCQVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 17:41:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084B17ADA9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:39:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id bn33so8989150ljb.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPG2uGymrQaAjdz0Rd104PLEPknS8uFaRtBuaevCxHA=;
        b=UTEyURlny0M3Sp02wOFqvyBlNYSNglScLLJjYWs3wxSUqoupmURo3mj/gHB5Z5k5pX
         HPh7nIvN1DWQ+l9DF+cwJKe+pvcdckJZl8UzsZy52K+blalTvbo7u0/7Tl3LRt1+aGoJ
         f+zhtUKsWIWSZtd2Flxj/uhYm1p/LwCawziUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPG2uGymrQaAjdz0Rd104PLEPknS8uFaRtBuaevCxHA=;
        b=KMGCh3L4RTOUJ9vh7nD3Tom9QLImaS/PV0upq4q+jUVrebCKq83plEwPq5ttBAZeGN
         sS0HpySprkSe+YZWowz5I2JsXHnd5cEDcgcrSCJanwL8nThby7oHBVy7WlNFyVjoXKYL
         arpykKMOERhl74ABJlr6ihSXTh+RrepRLQsGi2I4YwGNkKNaf1QUE83FV05wX0TWe9Ei
         YXNu2AYsNvZ74+n+bDERHVYzXCOinN6/dTrVZa1NGBw3UyC8ghr8q3zE6nGK5bgg1j/b
         za5hPSjk0kmfdy8BnSDqF3QYYQenZoDcfSLG88D4H28NpYS5em5s9/YEmO6F+adGvNNt
         Lz4w==
X-Gm-Message-State: AOAM531JIZ4wnLMnEgI5J7Dj+bLYczDZSzdHG6KQrUJCdeuZ64QK97aJ
        LjXLCeyvTttYvCmXFax0lu6XAPeKJhdQ0pICcZY=
X-Google-Smtp-Source: ABdhPJxhve/GgqJd+jMFWwsask2qbiYLAh8H/vClCzDiRnh7Ttf9JH7tOWmqFXKZXuAK1iJedSpqIA==
X-Received: by 2002:a2e:22c5:0:b0:249:278b:7f6d with SMTP id i188-20020a2e22c5000000b00249278b7f6dmr4387098lji.397.1647553193713;
        Thu, 17 Mar 2022 14:39:53 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id h2-20020a05651c124200b002492835aa87sm554075ljh.118.2022.03.17.14.39.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 14:39:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id y17so8942813ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:39:50 -0700 (PDT)
X-Received: by 2002:a2e:a78f:0:b0:249:21ce:6d53 with SMTP id
 c15-20020a2ea78f000000b0024921ce6d53mr4157427ljf.164.1647553190688; Thu, 17
 Mar 2022 14:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com> <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
In-Reply-To: <fd89333f-e470-a295-baf6-a736c55caeb5@citrix.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 14:39:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
Message-ID: <CAHk-=wj47CG0Y9GOFmGg4AYFvXhRFDX9x7E2Uxo9k-UX2wgR4g@mail.gmail.com>
Subject: Re: [PATCH v5] x86: use builtins to read eflags
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
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

On Thu, Mar 17, 2022 at 2:06 PM Andrew Cooper <Andrew.Cooper3@citrix.com> wrote:
>
> I was idly playing with this builtin in response to the thread, and
> found that GCC has a far more serious bug than Clang had.

Heh. Yeah, that's bad.

But it kind of fits my argument: compiler intrinsics aren't
necessarily such a wonderful thing. They hardly get any testing at all
unless they are some very very core thing.

I will personally *always* prefer some generic "escape clause" over a
compiler that thinks it knows better.

I think compiler people should see inline asm as a really *good*
thing, because it allows people to have that "I'm going to do
something that nobody normal does, look away now" kind of escape
clause, letting the compiler concentrate on the things it does best.

Yes, I realize inline asm isn't something compiler people love. And
yes, I realize that it might not give optimal code.

But think of it a bit like casts - it adds complexity to the language,
and it might make some optimizations harder or even impossible - but
it makes the language much more powerful and allows you to do things
that you simply couldn't do without it.

There's a reason people use C instead of Pascal or FORTRAN. Those
casts, and that pointer arithmetic - the bane of many optimizations -
are really really good things.

Intrinsics should generally be shunned, not seen as a "this is an
alternative to inline asm". They should only exist for situations
where you can show "look, I can do so much better", and have a
test-suite for it and a real-life case where it gives you a clear and
undeniable uplift on a meaningful load.

(And here I separate 'intrinsic' and generic compiler builtins. I love
the builtins that allow me to tell the compiler something, or the
compiler to tell me something about the code: __builtin_unreachable()
and __builtin_constant_p() are both wonderful examples of those kinds
of things)

But an intrinsic for some odd target-specific thing that can't even be
portably generalized? Give me inline asm any day.

We can do things with inline asms that the compiler can't even _dream_
of, like the whole instruction rewriting thing we use.

I'd much rather have a powerful generic concept (eg "asm goto" is
lovely) than a specialized intrinsic that does only one thing, and
doesn't even do it well because it's untested and badly defined.

               Linus
