Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C349FE10
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbiA1Q3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiA1Q3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:29:42 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1178C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:29:42 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id h14so6443012plf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 08:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4xDtUS2VtuCr0Qb4hVvnnUvCySjUeQQihblMbDnwQHM=;
        b=QV/MmPQWPgSoOy4dP77wt9pWZS0FAg4ESGF2IKv7+QuqqIeMFH1QkC31L8YxkehpFz
         f7TcW+/ELmnwnDkDQPj4LOP13GGAGIX6DmdOVfPrWtwIvsXm7v7qQqudC07SN/cXXAMv
         sEWf2h3wcUGAEDhVJlPa5qMRzQeRAMqeV6LIf/Rq/QpgwOP2Q3onbivecTOgWy+8DF4Y
         M3ZZZh0GvoDIU4Zp08SAB2kcyohqoL2pfpo5QtUq/L/rn5aci60D395FOsubUqvL5qIi
         IPmaAta578nuGYMkvQwOdTbYPBhZ5H1wiaoOWBouBiocqWTB3Y0+/RDGg1nGRgZ5sQJN
         8wYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4xDtUS2VtuCr0Qb4hVvnnUvCySjUeQQihblMbDnwQHM=;
        b=X/V55CJWgpM0X2Ii+OGyktYkGhVCqB20leqXhH/JlknLdcEBYavsQaxb/D3YJlsU+V
         15Yk/zJIXpWVIQierCZaGFXNc93Tp9MG6loEZH7QDU8ngkqXxJIMURXSuA1+xzcgyIbO
         ITPTBEhHyg7fuTRbG2/DqAbELqL2IiLu3tAUGzn/pdWBQxgSPEt4vk5w9c7UH+uCV1pD
         SsZg3MUXQo7RoK2dWvqaah6HHaQawKdws67YyWDAynSMntTv/cHdua9gw6Qg9rWzotLG
         GV3GOhhaX0CL+fewgGYVJ5Txq0eeFzOpc0P3Ag9S+tj7a/mUkztQywVXNVMqSpgkwerp
         35Kg==
X-Gm-Message-State: AOAM5332h3N0PGDFt5kuWvQLKNt4azMIGc78k/0my2aEbnWLTMex5oAf
        eHZcc5YIl9tzujfjYoZ8A/H9WQ==
X-Google-Smtp-Source: ABdhPJzKFCZGm3oWvz0iogboERcHFJWKAN3FzB2q4ReutSTe3FD0c0Pj66F/uc8sB4GUXgDl7q36ug==
X-Received: by 2002:a17:902:ea06:: with SMTP id s6mr8904330plg.161.1643387382043;
        Fri, 28 Jan 2022 08:29:42 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g11sm8439019pfj.21.2022.01.28.08.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:29:41 -0800 (PST)
Date:   Fri, 28 Jan 2022 16:29:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io, James Y Knight <jyknight@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH v2 4/5] x86/uaccess: Implement
 unsafe_try_cmpxchg_user()
Message-ID: <YfQZ8cXPDraUqLMN@google.com>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.852009966@infradead.org>
 <YfIAsHQv5Q84fOqO@google.com>
 <YfI9Y5l0fQAKuJav@google.com>
 <YfJsNcYNH8JTHrM/@hirez.programming.kicks-ass.net>
 <YfMruK8/1izZ2VHS@google.com>
 <CAKwvOdmPkCuYuMRBSeK7DaK-wrdH5+C0gL63eqJ1buHsmueFsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmPkCuYuMRBSeK7DaK-wrdH5+C0gL63eqJ1buHsmueFsg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022, Nick Desaulniers wrote:
> On Thu, Jan 27, 2022 at 3:33 PM Sean Christopherson <seanjc@google.com> wrote:
> > Regarding the param number, gcc also appears to have a goof with asm goto and "+m",
> > but bumping the param number in that case remedies its woes.
> >
> >   $echo 'int foo(int *x) { asm goto (".long (%l1) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null
> >   <stdin>: In function ‘foo’:
> >   <stdin>:1:19: error: invalid 'asm': '%l' operand isn't a label
> >
> >   $ echo 'int foo(int *x) { asm goto (".long (%l2) - .\n": "+m"(*x) ::: bar); return *x; bar: return 0; }' | gcc -x c - -c -o /dev/null
> 
> Right, so in fixing the above issue with tied outputs, I noticed that
> the GCC implementation of asm goto with outputs had different
> behavior. I changed clang's implementation in clang-14 (same patch
> series) to match:
> https://reviews.llvm.org/rG5c562f62a4ee15592f5d764d0710553a4b07a6f2
> This comment summarizes most of my thoughts on the issue:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=98096#c7
> Specifically the quote "It appears to me that the GCC decision here
> was accidental, and that when pointed out, the bug was simply
> documented rather than fixed."

I guess that makes a certain amount of sense, but wow that is subtle, confusing,
and potentially dangerous.  Looks like the hidden inputs are numbered after all
explicit inputs, otherwise there would be broken code left and right, but it means
that a typo like so:

  echo 'int foo(int x) { asm ("xor %0, %0; xor %2, %2" : "+a"(x) : "b"(x)); return x; return 0; }' | clang -x c - -c -o tmp.o

will compile cleanly.

> Though I think compatibility between compilers is ultimately more
> important.  There's no standards bodies involved in these extension,
> which is simultaneously more flexible, yet can also lead to
> differences in implementations like this. Thanks for attending my TED
> talk.
> 
> >
> >
> > So my immediate question: how do we want to we deal with this in the kernel?  Keeping
> > in mind that I'd really like to send this to stable@ to fix the KVM mess.
> >
> > I can think of few options that are varying degrees of gross.
> >
> >   1) Use a more complex sequence for probing CC_HAS_ASM_GOTO_OUTPUT.
> >
> >   2) Use an output-only "=m" operand.
> >
> >   3) Use an input register param.
> >
> > Option #1 has the obvious downside of the fancier asm goto for  __get_user_asm()
> > and friends being collateral damage.  The biggest benefit is it'd reduce the
> > likelihood of someone else having to debug similar errors, which was quite painful.
> 
> Right; I assumed we'd hit this at some point, as soon as people wanted
> to used tied outputs with asm goto.  I'd rather have a different
> Kconfig test for working tied outputs, 

Is it all tied outputs, or just "+m"?  E.g. using "+r" compiles cleanly.

  echo 'int foo(int x) { asm goto ("xor %0, %0;.long (%l[bar]) - .\n": "+r"(x) ::: bar); return x; bar: return 0; }' | clang -x c - -c -o /dev/null

It might be a moot point as I can't find any instances of "+"-anything in conjunction
with asm_volatile_goto, i.e. adding CC_HAS_ASM_GOTO_OUTPUT_TIED_OUTPUTS won't create
an inconsistency with existing code.

Regardless, I like that idea.

> and that all uses in the kernels used the symbolic references which are much
> more readable and less confusing than the rules for numbered references
> (which are bug prone IMO).

100% agree, even though it takes me twice as long to write because I can never
remember the syntax :-)  Converting all existing usage is probably a fools errand,
but adding a checkpatch rule would get us going in the right direction.
