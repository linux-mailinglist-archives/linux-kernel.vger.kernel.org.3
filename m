Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C314B79DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbiBOVGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:06:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiBOVGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:06:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495DD2A721
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uvMluQdN0GSPuEJBcDu2YtcMnFGhEbHkw4SETZERvO0=; b=Rt5N2dtwUV7yCxceA3dKBG7Jec
        DN0oXg1X/475ee26Wl+i80jXWzL36PEZHfWtFuolqqKIAmfheMVxDPoaAdPrZIc7XRpqmyJJWIcfn
        Tc5jGPiry2KXhNSK++FitBh3laLYzLUOq1JapJoodBvcjrJrs1xQpBrmXc8vlkso96NNzKlQ6NDOn
        PdhT9FvvKCy+vJTylcgyFZ3YEGMYOWjhCkvcIPMbHsUCoxtXCGTNCzjmTrFjOBVGCVZwUiU8svxrl
        Yp51OVSq4cQvGa8BRlbEbg8C4oJYGzALwc2ucGwqleaBJyBq4Mkx4VqAHi3fedOUaQbuNZPxSRR1R
        QhMyXUUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK51D-00EB2o-Ti; Tue, 15 Feb 2022 21:05:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B154987956; Tue, 15 Feb 2022 22:05:50 +0100 (CET)
Date:   Tue, 15 Feb 2022 22:05:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        X86 ML <x86@kernel.org>, hjl.tools@gmail.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220215210550.GD23216@worktop.programming.kicks-ass.net>
References: <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
 <202202151129.1A5C5FE42@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202202151129.1A5C5FE42@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 12:03:12PM -0800, Kees Cook wrote:
> On Tue, Feb 15, 2022 at 08:56:03AM -0800, Sami Tolvanen wrote:
> > On Mon, Feb 14, 2022 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> > > > I'm fine with adding a trap mode that's used by default, but having
> > > > more helpful diagnostics when something fails is useful even in
> > > > production systems in my experience. This change results in a vmlinux
> > > > that's another 0.92% smaller.
> > >
> > > You can easily have the exception generate a nice warning, you can even
> > > have it continue. You really don't need a call for that.
> > 
> > Sure, but wouldn't that require us to generate something like
> > __bug_table, so we know where the CFI specific traps are?
> 
> It also means the trap handler needs to do a bunch of instruction
> decoding to find the address that was going to be jumped to, etc.

arch/x86/kernel/alternative.c:apply_retpolines() has all that, since we
need to to know that to re-write the thunk-call.

> > > > In this case the function has two indirect calls and Clang seems to
> > > > prefer to emit just one ud2.
> > >
> > > That will not allow you to recover from the exception. UD2 is not an
> > > unconditional fail. It should have an out-going edge in this case too.
> > 
> > Yes, CFI failures are not recoverable in that code. In fact, LLVM
> > assumes that the llvm.trap intrinsic (i.e. ud2) never returns, but I
> > suppose we could just use an int3 instead. I assume that's sufficient
> > to stop speculation?
> 
> Peter, is there a reason you want things in the specific order of:
> 
> cmp, je-to-call, trap, call
> 
> Isn't it more run-time efficient to have an out-of-line failure of
> the form:
> 
> cmp, jne-to-trap, call, ...code..., trap, jmp-to-call
> 
> I thought the static label stuff allowed the "default out of line"
> option, as far as pessimizing certain states, etc? The former is certainly
> code-size smaller, though, yes, but doesn't it waste space in the cache
> line for the unlikely case, etc?

Mostly so that we can deduce the address of the trap from the retpoline
site, also the above has a fairly high chance of using jcc.d32 which is
actually larger than jcc.d8+ud2.
