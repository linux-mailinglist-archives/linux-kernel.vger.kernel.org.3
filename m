Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417454B797C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243103AbiBOUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:54:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiBOUyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:54:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0972F27159
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=STnj2ybwZv05qCjMTqaXWuXN0Sm5uRuBvdpB6J67Jg0=; b=o++5p4UyKYULUAc9XC40okIKxv
        p9pPp+HvcJo46VATvElhowtSi+6FB7H2feZPLxDPHk1AkWihA23qMIj4IsNq9zaUTEt8913L+IM4l
        nFS/JGmwP1+I/zScTHdItmu7EIiDyHDpqRr6bai9qTIniHz5b5AwLu0ksN/owOGXTe0RmDtnyT0M2
        Yz8euY75y/El0mSE0isb+8qiguE50bRr92wSRlFUqUhkagz9flQTo2aqXRZL2ewrEVZDtu5W8PtkN
        Js0Lx/dWZE7xNmwOzqAv9YOGDgjwsF3VvSnuH5L4Lc9ZHw7M404pCUPyJrlpMbDOcwqRkCZ9F/ee0
        seBCiFgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nK4pb-00ABAC-Jx; Tue, 15 Feb 2022 20:53:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC34B987956; Tue, 15 Feb 2022 21:53:49 +0100 (CET)
Date:   Tue, 15 Feb 2022 21:53:49 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Joao Moreira <joao@overdrivepizza.com>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        hjl.tools@gmail.com, Josh Poimboeuf <jpoimboe@redhat.com>,
        andrew.cooper3@citrix.com, LKML <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20220215205349.GC23216@worktop.programming.kicks-ass.net>
References: <20211122170805.338489412@infradead.org>
 <6ebb0ab131c522f20c094294d49091fc@overdrivepizza.com>
 <202202081541.900F9E1B@keescook>
 <ad6c2633f39e39583bc5c5eaf7ccbe52@overdrivepizza.com>
 <202202082003.FA77867@keescook>
 <9ea50c51ee8db366430c9dc697a83923@overdrivepizza.com>
 <20220211133803.GV23216@worktop.programming.kicks-ass.net>
 <CABCJKuciRBnz4JxBDJC=+kuJn4pU2uBkWPBov7-VL2o2j0F4SA@mail.gmail.com>
 <20220214222550.GB23216@worktop.programming.kicks-ass.net>
 <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKuf-wouSCh4u43GPQHPPgG=mqOGboSoHPQRfmgQSBkFrMg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 08:56:03AM -0800, Sami Tolvanen wrote:
> On Mon, Feb 14, 2022 at 2:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > On Mon, Feb 14, 2022 at 01:38:18PM -0800, Sami Tolvanen wrote:
> > > I'm fine with adding a trap mode that's used by default, but having
> > > more helpful diagnostics when something fails is useful even in
> > > production systems in my experience. This change results in a vmlinux
> > > that's another 0.92% smaller.
> >
> > You can easily have the exception generate a nice warning, you can even
> > have it continue. You really don't need a call for that.
> 
> Sure, but wouldn't that require us to generate something like
> __bug_table, so we know where the CFI specific traps are?

Yes, but since you're going to emit a retpoline, and objtool already
generates a list of retpoline sites, we can abuse that. If the
instruction after the trap is a retpoline site, we a CFI fail.

> > > In this case the function has two indirect calls and Clang seems to
> > > prefer to emit just one ud2.
> >
> > That will not allow you to recover from the exception. UD2 is not an
> > unconditional fail. It should have an out-going edge in this case too.
> 
> Yes, CFI failures are not recoverable in that code. In fact, LLVM
> assumes that the llvm.trap intrinsic (i.e. ud2) never returns, but I
> suppose we could just use an int3 instead. I assume that's sufficient
> to stop speculation?

It is. int3 is also smaller by one byte, but the exception is already
fairly complicated, but I can see if we can make it work.

> > Also, you really should add a CS prefix to the retpoline thunk call if
> > you insist on using r11 (or any of the higher regs).
> 
> I actually didn't touch the retpoline thunk call, that's exactly the
> code Clang normally generates.

Yeah, and it needs help, also see:

  https://lore.kernel.org/lkml/20211119165630.276205624@infradead.org/

Specifically, clang needs to:

 - CS prefix stuff the retpoline thunk call/jmp;
 - stop doing conditional indirect tail-calls.

