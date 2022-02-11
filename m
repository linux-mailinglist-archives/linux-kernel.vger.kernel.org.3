Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DCF4B2D7F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352808AbiBKTZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 14:25:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbiBKTZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 14:25:49 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DA4CF2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:25:48 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id k25so24934193ejp.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GD2hJleO+BGH7uHOhMKE9GqyrPE46e0JW2MnbUpSxGM=;
        b=drfDVDdeD8zFrAGVCcIkHw8cHfErxBrAfhUyN91kJxJKe7SFJCF1p34U300RUKCKXs
         IsYGGcezgrgOoB2pMWJkGVYIZH1t3Nf9qUroRrLaUJP2QZxM6apgtBrpZC2+QmcgpLLH
         BD8DCL8/XZztvmMGrPeUUFBlGgIPvar6eCDf/qW0jcwBavP4r176sqNGpI3+zJ8HJf6b
         YcnRoVVXqfafFaxH9MB2a3CJ9kQdcIWYkfLxOdjlip+Ux+iD13NsD/2y86Jyw+KhmLjX
         A6Gq5jqdYkVmxjgRrMeXlf4v46aWr5kSthyjIVdiJBf0Z6drQa+3kt33IEpNGLCsuKSI
         RAew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GD2hJleO+BGH7uHOhMKE9GqyrPE46e0JW2MnbUpSxGM=;
        b=qbRLqAnMYnb5wYtUAHx3VqiVQqGiA7yTDme8bF+4E6ylSw7p5uSrL4a+JlabSNnnuk
         1DiKjRjVI12cOaJ7kmSA49AmrD3PIBm2zWrEaI3So/m5/9j3O2farZcnt7ka5iDNsBsL
         hhug8rBrale5VUpW2/6MM3F98GT3KNr07UUl9rE46O33jZe0TBQfOawIaLQEwftxCS1o
         EPDBRQoS11UMQmVvZmpOcSRve4hb5b7f4DC4wCqPUuep7EadX6e5ZdB82TUbjretIzpN
         jEEAJY+fmG8ujstYTK2KtK/jqy0bbyFWKCrT+YbUYLBFWxnX6LTOTMD6YRbcw/7FLHnt
         ZkLQ==
X-Gm-Message-State: AOAM531P9P8k3AB3nZQ3IC/IQv4URaRLj/kLCsPFzQHqTtUmRKYdTOdJ
        3LsD3Q3U7LeEoTKBSWp1MsfuXWs+f1StecRE732h
X-Google-Smtp-Source: ABdhPJypX/j9HQ9UKdN5Q/EButffbsswHumKPBUPD8F3DELLeUuIF/73MuElgNl5Ate/M9VWPJk6xBwOmP/PC1qeyu4=
X-Received: by 2002:a17:906:2811:: with SMTP id r17mr2621343ejc.31.1644607546332;
 Fri, 11 Feb 2022 11:25:46 -0800 (PST)
MIME-Version: 1.0
References: <20220204005742.1222997-1-morbo@google.com> <20220210223134.233757-1-morbo@google.com>
 <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com>
In-Reply-To: <cb2ff5da9b704a9792549a9433dc0ac8@AcuMS.aculab.com>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 11 Feb 2022 11:25:34 -0800
Message-ID: <CAGG=3QXvSt=d94iqSV-Y9JVNc+pt-WOZGpSeW--fp=w2ttMvUA@mail.gmail.com>
Subject: Re: [PATCH v4] x86: use builtins to read eflags
To:     David Laight <David.Laight@aculab.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Juergen Gross <jgross@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 8:40 AM David Laight <David.Laight@aculab.com> wrote:
> From: Bill Wendling
> > Sent: 10 February 2022 22:32
> >
> > GCC and Clang both have builtins to read and write the EFLAGS register.
> > This allows the compiler to determine the best way to generate this
> > code, which can improve code generation.
> >
> > This issue arose due to Clang's issue with the "=rm" constraint.  Clang
> > chooses to be conservative in these situations, and so uses memory
> > instead of registers. This is a known issue, which is currently being
> > addressed.
> >
> > However, using builtins is beneficial in general, because it removes the
> > burden of determining what's the way to read the flags register from the
> > programmer and places it on to the compiler, which has the information
> > needed to make that decision.
>
> Except that neither gcc nor clang attempt to make that decision.
> They always do pushf; pop ax;
>
It looks like both GCC and Clang pop into virtual registers. The
register allocator is then able to determine if it can allocate a
physical register or if a stack slot is required.

> ...
> > v4: - Clang now no longer generates stack frames when using these builtins.
> >     - Corrected misspellings.
>
> While clang 'head' has been fixed, it seems a bit premature to say
> it is 'fixed' enough for all clang builds to use the builtin.
>
True, but it's been cherry-picked into the clang 14.0.0 branch, which
is scheduled for release in March.

> Seems better to change it (back) to "=r" and comment that this
> is currently as good as __builtin_ia32_readeflags_u64() and that
> clang makes a 'pigs breakfast' of "=rm" - which has only marginal
> benefit.
>
That would be okay as far as code generation is concerned, but it does
place the burden of correctness back on the programmer. Also, it was
that at some point, but was changed to "=rm" here. :-)

commit ab94fcf528d127fcb490175512a8910f37e5b346
Author: H. Peter Anvin <hpa@zytor.com>
Date:   Tue Aug 25 16:47:16 2009 -0700

    x86: allow "=rm" in native_save_fl()

    This is a partial revert of f1f029c7bfbf4ee1918b90a431ab823bed812504.

    "=rm" is allowed in this context, because "pop" is explicitly defined
    to adjust the stack pointer *before* it evaluates its effective
    address, if it has one.  Thus, we do end up writing to the correct
    address even if we use an on-stack memory argument.

    The original reporter for f1f029c7bfbf4ee1918b90a431ab823bed812504 was
    apparently using a broken x86 simulator.

    [ Impact: performance ]

    Signed-off-by: H. Peter Anvin <hpa@zytor.com>
    Cc: Gabe Black <spamforgabe@umich.edu>


> Changing to __builtin_ia32_readeflags_u64() may be worth while
> if/when the compilers will generate pushf; pop mem; for it.
>
I was able to come up with an example where GCC generates "pushf ; pop mem":

  https://godbolt.org/z/9rocjdoaK

(Clang generates a variation of "pop mem," and is horrible code, but
it's meant for demonstration purposes only.) One interesting thing
about the use of the builtins is that if at all possible, the "pop"
instruction may be moved away from the "pushf" if it's safe and would
reduce register pressure.

-bw
