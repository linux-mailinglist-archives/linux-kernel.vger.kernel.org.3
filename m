Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDC4B7AFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 00:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiBOXGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 18:06:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiBOXGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 18:06:10 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F77E3891
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:05:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id y9so735663pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 15:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xFoXp1iXxwPnqPJm6+R4iAU7d160QC7MYGNnmZh/iBg=;
        b=kQ3XkCI8aIjA5Ugam7/F4NKdZ3ib0Caocmpb4cMY+oXEk7UdngLyy7C5ZthE2yi4T+
         8ancU/wgUoU8Ie/JRkBYI1vQi5P7ZRB8cOA+jrBJRKXuxHUy9R1SJCWzN2TK/GFlCF5V
         XSHRhRkKiZFOBTRHm3pDqNPDRTvyKEPS1YWEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xFoXp1iXxwPnqPJm6+R4iAU7d160QC7MYGNnmZh/iBg=;
        b=RxTr0c+RTXy1MmSSwD7lmAQT3pUzGke1A/lQjMnhVLMvMlARv2itpM3He1V18bKr0E
         HiGLp8CtKSUs5O7zv5e1uoEEmnk+2Nu/dhiNcIu/nIvm18bTxup1qNqSE1losVu2H4Yl
         OA9AY7mRawhYbnOxNuTFBQ1Y/1J34tR+AEobJx8jmjou3OXwDIEzSYOJZYNFAySzkKTY
         N5pFdueEH5gSN9TJfSsZKKZ49b6O+2Ls/PRAruUbCxasCxmbMpWhZZrJfhlwquyS9KTb
         A1uDT1QwQGahzZcWitRt8ktfEpMNmYDOMRmuyG9QSZlWahtJOjuWFJBZiK/xGOQ/kqUv
         GWcA==
X-Gm-Message-State: AOAM533QJzTvDOjTT9wwAN322fShRI0PvbPBmfPqH1+dtIj1LBRg8GcP
        +BhlBovMUH0F6Pssr5zSfm/rFA==
X-Google-Smtp-Source: ABdhPJxpn8JTzN/X/F3Jqc5MxaE4ad0yPJLGCRgLTY9lFi2ex5Wt3LFUet9W6MXnAIXxEQ2uWDtQUQ==
X-Received: by 2002:a17:902:cf07:: with SMTP id i7mr1278462plg.137.1644966359102;
        Tue, 15 Feb 2022 15:05:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pj8sm9590566pjb.54.2022.02.15.15.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 15:05:58 -0800 (PST)
Date:   Tue, 15 Feb 2022 15:05:57 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        X86 ML <x86@kernel.org>, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <202202151503.91E9B76B@keescook>
References: <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
 <202202151129.1A5C5FE42@keescook>
 <20220215210550.GD23216@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215210550.GD23216@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 10:05:50PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 15, 2022 at 12:03:12PM -0800, Kees Cook wrote:
> > On Tue, Feb 15, 2022 at 08:56:03AM -0800, Sami Tolvanen wrote:
> > > On Mon, Feb 14, 2022 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> > > > > I'm fine with adding a trap mode that's used by default, but having
> > > > > more helpful diagnostics when something fails is useful even in
> > > > > production systems in my experience. This change results in a vmlinux
> > > > > that's another 0.92% smaller.
> > > >
> > > > You can easily have the exception generate a nice warning, you can even
> > > > have it continue. You really don't need a call for that.
> > > 
> > > Sure, but wouldn't that require us to generate something like
> > > __bug_table, so we know where the CFI specific traps are?
> > 
> > It also means the trap handler needs to do a bunch of instruction
> > decoding to find the address that was going to be jumped to, etc.
> 
> arch/x86/kernel/alternative.c:apply_retpolines() has all that, since we
> need to to know that to re-write the thunk-call.

Ah, okay, well that makes things easier. :)

> > > > > In this case the function has two indirect calls and Clang seems to
> > > > > prefer to emit just one ud2.
> > > >
> > > > That will not allow you to recover from the exception. UD2 is not an
> > > > unconditional fail. It should have an out-going edge in this case too.
> > > 
> > > Yes, CFI failures are not recoverable in that code. In fact, LLVM
> > > assumes that the llvm.trap intrinsic (i.e. ud2) never returns, but I
> > > suppose we could just use an int3 instead. I assume that's sufficient
> > > to stop speculation?
> > 
> > Peter, is there a reason you want things in the specific order of:
> > 
> > cmp, je-to-call, trap, call
> > 
> > Isn't it more run-time efficient to have an out-of-line failure of
> > the form:
> > 
> > cmp, jne-to-trap, call, ...code..., trap, jmp-to-call
> > 
> > I thought the static label stuff allowed the "default out of line"
> > option, as far as pessimizing certain states, etc? The former is certainly
> > code-size smaller, though, yes, but doesn't it waste space in the cache
> > line for the unlikely case, etc?
> 
> Mostly so that we can deduce the address of the trap from the retpoline
> site, also the above has a fairly high chance of using jcc.d32 which is
> actually larger than jcc.d8+ud2.

Ah, yeah, that's an interesting point.

Still, I worry about finding ways to convinces Clang to emit precisely
cmp/je/trap/call, but I guess we'll catch it immediately if it doesn't.
:P

-- 
Kees Cook
