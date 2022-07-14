Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3109A575670
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 22:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240525AbiGNUjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiGNUjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 16:39:49 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BC422E0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:39:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y4so3914813edc.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TExNSZ/s/035rcwvcGhKf8b3mCtg1+8MAx2E+0mZs0k=;
        b=QlimJt9jnXA9WGUrrQpsyCnanjLLw2jppJeg8tlDJyUjoU7EVZkhjwQfw1utPbJFYw
         V2J/VhZUmpGT/0AOkO/cGcOvDnr/166nGbtK/23TIpPRTkOHY0byi1fwM5PVz2v65CaC
         CGxmh6/85iCwDd/Ru/CPAYbK8QhOpNrWTrRyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TExNSZ/s/035rcwvcGhKf8b3mCtg1+8MAx2E+0mZs0k=;
        b=p3sU8ocDWUtN5XERyvV71L5gL58j8+/DbbU07TtK0+z2w+r7LEPHZkfvK3rjgJysWW
         Qk1T1y/Il2nAidLu83x6twkmfXbZFa3RGsy2MjwDL0095ObYpaEW5uoqJQlEYA/psUgL
         XrCzToqcNqdFzgHJMIKb3/6x2dkdtnSXR97JMyrORDiL3pxiBa9rIFClLJAzPK6+Es6Z
         /kosi2wy8YR3CTTOdtR3le1acuIFJfSJaUBKGr1V3jbopyTuCu7br7dowC4fgGduEplS
         CGvbdycNi8eJl9YEB6ooauadgnpEJQjan+LC23ypXK4TocA0BMnn3hiAmC0MH/twe+lV
         PXMg==
X-Gm-Message-State: AJIora+lrwht2ZP1j9qEjsgd1pHlVJ88jR6ChPCvfaDKcCb19D38kqOm
        pZiUnl9SGvOzBlTU55pHwGpVKb99QqUWJsQJ3tE=
X-Google-Smtp-Source: AGRyM1vUZ8+qkOcG5O7a5PEGyqG9omOnCYqjvTIzBbrPShYDWCSPZTdb2VuI3n4fj5aExC1+Ez5JCQ==
X-Received: by 2002:a05:6402:2549:b0:43a:dcf2:27f8 with SMTP id l9-20020a056402254900b0043adcf227f8mr14632764edb.143.1657831186903;
        Thu, 14 Jul 2022 13:39:46 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709063a9200b007030c97ae62sm1090567ejd.191.2022.07.14.13.39.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 13:39:43 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id r2so3068952wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 13:39:41 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr9427301wrb.442.1657831181447; Thu, 14
 Jul 2022 13:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220712183238.844813653@linuxfoundation.org> <CA+G9fYtntg7=zWSs-dm+n_AUr_u0eBOU0zrwWqMeXZ+SF6_bLw@mail.gmail.com>
 <eb63e4ce-843f-c840-060e-6e15defd3c4d@roeck-us.net> <CAHk-=wj5cOA+fbGeV15kvwe6YGT54Wsk8F2UGoekVQLTPJz_pw@mail.gmail.com>
 <CAHk-=wgq1soM4gudypWLVQdYuvJbXn38LtvJMtnLZX+RTypqLg@mail.gmail.com>
 <Ys/bYJ2bLVfNBjFI@nazgul.tnic> <CAHk-=wjdafFUFwwQNvNQY_D32CBXnp6_V=DL2FpbbdstVxafow@mail.gmail.com>
 <YtBLe5AziniDm/Wt@nazgul.tnic>
In-Reply-To: <YtBLe5AziniDm/Wt@nazgul.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 Jul 2022 13:39:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wghZB60WCh5M_Y0n1qGYbg-1fvWFnU-bV-4j1bQM1qE5A@mail.gmail.com>
Message-ID: <CAHk-=wghZB60WCh5M_Y0n1qGYbg-1fvWFnU-bV-4j1bQM1qE5A@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/78] 5.15.55-rc1 review
To:     Borislav Petkov <bp@alien8.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Slade Watkins <slade@sladewatkins.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>
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

On Thu, Jul 14, 2022 at 10:02 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jul 14, 2022 at 09:51:40AM -0700, Linus Torvalds wrote:
> > Oh, absolutely. Doing an -rc7 is normal.
>
> Good. I'm gathering all the fallout fixes and will send them to you on
> Sunday, if nothing unexpected happens.

Btw, I assume that includes the clang fix for the
x86_spec_ctrl_current section attribute.

That's kind of personally embarrassing that it slipped through: I do
all my normal test builds that I actually *boot* with clang.

But since I kept all of the embargoed stuff outside my normal trees,
it also meant that the test builds I did didn't have my "this is my
clang tree" stuff in it.

And so I - like apparently everybody else - only did those builds with gcc.

And gcc for some reason doesn't care about this whole "you redeclared
that variable with a different attribute" thing.

And sadly, our percpu accessor functions don't verify these things
either, so you can write code like this:

    unsigned long myvariable;

    unsigned long test_fn(void)
    {
        return this_cpu_read(myvariable);
    }

and the compiler will not complain about anything at all, and happily
generate completely nonsensical code like

        movq %gs:myvariable(%rip), %rax

for it, which will do entirely the wrong thing because 'myvariable'
wasn't allocated in the percpu section.

In the 'x86_spec_ctrl_current' case, that nonsensical code _worked_
(with gcc), because despite the declaration being for a regular
variable, the actual definition was in the proper segment.

But that 'myvariable' thing above does end up being another example of
how we are clearly missing some type checkng in this area.

I'm not sure if there's any way to get that section mismatch at
compile-time at all. For the static declarations, we could just make
DECLARE_PER_CPU() add some prefix/postfix to the name (and obviously
then do it at use time too).

We have that '__pcpu_scope_##name' thing to make sure of globally
unique naming due to the whole weak type thing. I wonder if we could
do something similar to verify that "yes, this has been declared as a
percpu variable" at use time?

                   Linus
