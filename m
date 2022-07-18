Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78134578E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiGRXv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiGRXvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:51:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB67AA1B3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 16:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T/yu627okIMF8pkzQTskW4G+bhjAWqQn59g/hCVl4vQ=; b=hgJ42YjXJVq2yjLkZQvnstNq+6
        sSU18LaePJgiL6nPI6CmL6Sfj5A5yPouYQ9JlomEinMYdB87P25obqtiAKs2O0Cxc8etiGc9kxQEz
        0cqeIzu0KZAE9wlWfG5TNdeoakUJZ8a8E2gY25IC2SKtoNQBjc5rSc9FaOotiVmCDc6fK12LIoWIT
        aX9lxo0gtVU+K1kgaNOggqB6J+PoKYHydbCa2TYqM/jGKWajLMzTT6tWoZtxc8v9PmjP+eJwCZZCB
        aTy9oy+3HK76s1+WOFOy6yBAxa62TkIDZ5/dlF4eH/JyTG7bqhaLzQK+y5odZ3l0mmRdB1BW6xi2Z
        5I01jivg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDaWC-00D9eD-Tu; Mon, 18 Jul 2022 23:51:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 64DF99802A7; Tue, 19 Jul 2022 01:51:14 +0200 (CEST)
Date:   Tue, 19 Jul 2022 01:51:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch 00/38] x86/retbleed: Call depth tracking mitigation
Message-ID: <YtXx8r5zfqZ12M04@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <87wncauslw.ffs@tglx>
 <87tu7euska.ffs@tglx>
 <CAHk-=wjpzVRU0Yr_0DJSB_bKHW3_74UucNpJBjxfHPo_R=PYNg@mail.gmail.com>
 <87o7xmup5t.ffs@tglx>
 <YtXOMPpmx8TcFtOX@worktop.programming.kicks-ass.net>
 <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKufACEoUz=SVakAFVKhhwFb6biaPdiC_1cA=NRAUiak5hQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 03:48:04PM -0700, Sami Tolvanen wrote:
> On Mon, Jul 18, 2022 at 2:18 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Jul 18, 2022 at 10:44:14PM +0200, Thomas Gleixner wrote:
> > > And we need input from the Clang folks because their CFI work also puts
> > > stuff in front of the function entry, which nicely collides.
> >
> > Right, I need to go look at the latest kCFI patches, that sorta got
> > side-tracked for working on all the retbleed muck :/
> >
> > Basically kCFI wants to preface every (indirect callable) function with:
> >
> > __cfi_\func:
> >         int3
> >         movl $0x12345678, %rax
> >         int3
> >         int3
> > \func:
> 
> Yes, and in order to avoid scattering the code with call target
> gadgets, the preamble should remain immediately before the function.

I think we have a little room, but yes, -6 is just right to hit the UD2.

> > Ofc, we can still put the whole:
> >
> >         sarq    $5, PER_CPU_VAR(__x86_call_depth);
> >         jmp     \func_direct
> >
> > thing in front of that.
> 
> Sure, that would work.

So if we assume \func starts with ENDBR, and further assume we've fixed
up every direct jmp/call to land at +4, we can overwrite the ENDBR with
part of the SARQ, that leaves us 6 more byte, placing the immediate at
-10 if I'm not mis-counting.

Now, the call sites are:

41 81 7b fa 78 56 34 12		cmpl	$0x12345678, -6(%r11)
74 02				je	1f
0f 0b				ud2
e8 00 00 00 00		1:	call	__x86_indirect_thunk_r11

That means the offset of +10 lands in the middle of the CALL
instruction, and since we only have 16 thunks there is a limited number
of byte patterns available there.

This really isn't as nice as the -6 but might just work well enough,
hmm?

> > But it does somewhat destroy the version I had that only needs the
> > 10 bytes padding for the sarq.
> 
> There's also the question of how function alignment should work in the
> KCFI case. Currently, the __cfi_ preamble is 16-byte aligned, which
> obviously means the function itself isn't.

That seems unfortunate, at least the intel parts have a 16 byte i-fetch
window (IIRC) so aligning the actual instructions at 16 bytes gets you
the best bang for the buck wrt ifetch (functions are random access and
not sequential).

Also, since we're talking at least 4 bytes more padding over the 7 that
are required by the kCFI scheme, the FineIBT alternative gets a little
more room to breathe. I'm thinking we can have the FineIBT landing site
at -16.

__fineibt_\func:
	endbr64				# 4
	xorl	$0x12345678, %r10d	# 7
	je	\func+4			# 2
	ud2				# 2

\func:
	nop4
	...

With the callsite looking like:

	nop7
	movl	$0x12345678, %r10d	# 7
	call	*%r11			# 3

or something like that (everything having IBT has eIBRS at the very
least).
