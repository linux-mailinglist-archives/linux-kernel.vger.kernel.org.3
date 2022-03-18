Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFEE4DD263
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 02:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiCRBXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 21:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiCRBXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 21:23:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8902A4564
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:21:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s25so9513713lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b/pNbzgcdYJjSh+ACj0n1pQjCDJGCCGjloF/JdGNGSo=;
        b=dTK+uo+Jz568eICd2gFrkZaobtquyTLeKqTZIsWeFh8G+SUpzTGAJXhBoZXX4qGMFK
         OeEsQc3mooLTyuDiZs/fiz3l75SR99l/LHN+ZhVgwUnB9r+RMj/zfPEEFAsUtSaKjGEx
         7NDWm4uqPJjO5ZFjWHOgeB/nPhAXtIogQJuf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b/pNbzgcdYJjSh+ACj0n1pQjCDJGCCGjloF/JdGNGSo=;
        b=F07oB85iP270Y+DOUONdiHq28TLp7wT6rjxYYcPNZdZwYju0X7n7yvIuKsoTwhul/1
         /7IkgU5wwjxpKtTwpXILpNXWMwTyKSfCAXJ0O0CTrMv7LM/JlSou2po5uheJGvNsGTLw
         40ZkTSDWbaGGJ0PnXwpqXbB0Mc5ZD1bW7cj52RGEdm8gf6KyFttpHXti7OLhk8a6Dhx+
         w7k53ETSC7NmmSqEEmfwe4RqzI6mArLMKOrfIwYsSN5h2o4Tex/hzVEk6lMMWNSpXiqu
         2Br27SqAF4/u3rFscbG7jD+4W/ByekAwpfWjQqJxZVdOCw1wsvt9/pabhj+ZQvXTOVQ6
         f30w==
X-Gm-Message-State: AOAM530SvFDS0uDG4hYY0NRRE5srC6kCJ4wvMI1xgOjn2yzWYAHa7JtL
        WdcEyBXFnbx7J7Sm59E0DlkCiBKepN2XhrbF2sQ=
X-Google-Smtp-Source: ABdhPJzK1NuzZE3U+rVNNqevR4jur6+G9WElXntnAvXXFNa8F8vpRYvzEVQmn7WxJRJySxjn3m3s8A==
X-Received: by 2002:a2e:2a45:0:b0:246:430d:805 with SMTP id q66-20020a2e2a45000000b00246430d0805mr4732594ljq.439.1647566505647;
        Thu, 17 Mar 2022 18:21:45 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i4-20020a2ea224000000b002496423e49asm335663ljm.95.2022.03.17.18.21.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 18:21:44 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id c15so9483616ljr.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 18:21:42 -0700 (PDT)
X-Received: by 2002:a2e:9b10:0:b0:247:f28c:ffd3 with SMTP id
 u16-20020a2e9b10000000b00247f28cffd3mr4728907lji.152.1647566502600; Thu, 17
 Mar 2022 18:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220210223134.233757-1-morbo@google.com> <20220301201903.4113977-1-morbo@google.com>
 <CAGG=3QWh90r5C3gmTj9zxiJb-mwD=PGqGwZZTjAfyi1NCb1_9w@mail.gmail.com>
 <AC3D873E-A28B-41F1-8BF4-2F6F37BCEEB4@zytor.com> <CAGG=3QVu5QjQK8m2FWiYn-XQuVBjUGXcbznSbK22jVMB5GAutw@mail.gmail.com>
 <F5296439-4CA3-4F31-BD91-5ED1510BC382@zytor.com> <CAKwvOdkk-C8HMemKs4+yoxvNDgTLmvZG1rmwjVXBqhsQ-cED5g@mail.gmail.com>
 <CAHk-=whJfKN8Jag=8DS=pbZR3TY90znUOP6Km+TLRJ9dZEgNqw@mail.gmail.com>
 <878rt8gwxa.fsf@oldenburg.str.redhat.com> <CAHk-=wiZtg-E5s1CEZgaSE=e38vFoP3y2aV-4R82jqmcUoD0Aw@mail.gmail.com>
 <20220318002555.GP614@gate.crashing.org>
In-Reply-To: <20220318002555.GP614@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 18:21:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRfJijS5yJsLFzyJS6HFh46q8Eu6EvjGGjJSZ1+m74_Q@mail.gmail.com>
Message-ID: <CAHk-=wjRfJijS5yJsLFzyJS6HFh46q8Eu6EvjGGjJSZ1+m74_Q@mail.gmail.com>
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

On Thu, Mar 17, 2022 at 5:31 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Thu, Mar 17, 2022 at 01:36:19PM -0700, Linus Torvalds wrote:
> >
> > So yes, a builtin can improve code generation.
>
> Yes, and they are much easier to write, and can be written correctly by
> lookenspeepers who just *have* to twist every knob that they can -- more
> easily than inline asm anyway, which is unforgiving to the extreme.

What?

They aren't easier for the user: they are entirely undocumented, they
can't be fvound anywhere sane, and even if you do find them, you don't
actually have a clue which compiler version implements them.

If you know about the name - and how would you? - one of the first
google hits when you try to figure out what it does is the gcc
bugzilla about how they are undocumented:

    https://gcc.gnu.org/bugzilla//show_bug.cgi?id=92137

and then when you look at that bugzilla, the reply to the "it's
undocumented" is _literally_

    "You shouldn't use those, they are for internal use only.  That's
the reason they are not documented"

so I call BS on them being "easier to write".

I also call BS on the "can be written correctly", since the actual gcc
built-in is not just undocumented, it is also (a) badly defined in
that there is no chance in hell it can ever do anything sane thanks to
missing serialization definitions, and (b) clearly seriously buggy and
generates completely bogus code as Andrew Cooper found out.

Now, compare that to just using inline asm: it's trivial, and we've
used it basically unchanged for three decades.

So seriously: when I say "yes, a builtin can improve code generation",
I mean it purely in the theoretical sense.

Because in the *practical* sense that actually takes reality into
account, I can unequivocally say that the built-in is pure and utter
garbage, should never be used, and should actively be deleted from the
gcc source base because it's so fundamentally broken.

Do you really want to make arguments that are counter-factual when the
facts are *this* clear?

                  Linus
