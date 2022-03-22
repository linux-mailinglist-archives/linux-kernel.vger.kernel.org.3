Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44104E440F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbiCVQTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbiCVQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:19:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB638D699;
        Tue, 22 Mar 2022 09:17:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AB39612B4;
        Tue, 22 Mar 2022 16:17:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EABFC340EC;
        Tue, 22 Mar 2022 16:17:31 +0000 (UTC)
Date:   Tue, 22 Mar 2022 12:17:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        mhiramat@kernel.org, ast@kernel.org, hjl.tools@gmail.com,
        rick.p.edgecombe@intel.com, rppt@kernel.org,
        linux-toolchains@vger.kernel.org, Andrew.Cooper3@citrix.com,
        ndesaulniers@google.com
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220322121729.5947afc4@gandalf.local.home>
In-Reply-To: <Yjnvsrp8253bxWPA@hirez.programming.kicks-ass.net>
References: <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
        <20220321124551.3d73660b@gandalf.local.home>
        <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
        <20220321125419.0a20415c@gandalf.local.home>
        <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
        <20220322091242.1ad0206b@gandalf.local.home>
        <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
        <20220322110438.25c2a760@gandalf.local.home>
        <Yjnvsrp8253bxWPA@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Mar 2022 16:48:02 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 22, 2022 at 11:04:38AM -0400, Steven Rostedt wrote:
> 
> > > In recap:
> > > 
> > > 	__fentry__ -- push on trace-stack
> > > 	__ftail__  -- mark top-most entry complete
> > > 	__fexit__  -- mark top-most entry complete;
> > > 	              pop all completed entries  
> > 
> > Again, this would require that the tail-calls are also being traced.  
> 
> Which is why we should inhibit tail-calls if the function is notrace.
> 
> > > inhibit tail-calls to notrace.  
> > 
> > Just inhibiting tail-calls to notrace would work without any of the above.  
> 
> I'm lost again; what? Without any of the above you got nothing because
> return-trampoline will not work.


I think this got "lost in translation".

 "Inhibiting tail-calls to notrace"

Is a bit ambiguous because of the "to notrace" which would be different if
I had said "on notrace" which I may have screwed up the grammar here. Let
me be more precise.

 "Limiting tail-calls to only notrace functions"

That I think is a bit less ambiguous. English sucks.

> 
> > But my fear is that will cause a noticeable performance impact.  
> 
> Most code isn't in fact notrace, and call+ret aren't *that* expensive.

  "isn't in fact notrace" Ug! Double negatives!

This gets even more confusing when we are saying "notrace" which is a
negative. We should probably just say "traced" functions which makes
communication a bit more straight forward.

> 
> > > It's function graph tracing, kretprobes and whatever else this rethook
> > > stuff is about that needs this because return trampolines will stop
> > > working somewhere in the not too distant future.  
> > 
> > Another crazy solution is to have:
> > 
> > func_A:
> > 	call __fentry__
> > 	...
> > tail:	jmp 1f 
> > 	call 1f  
> 	
> > 	call __fexit__
> > 	ret
> > 1:	jmp func_B
> > 
> > 
> > where the compiler tells us about "tail:" and that we know that func_A ends
> > with a tail call, and if we want to trace the end of func_A we convert that
> > jmp 1f into a nop. And then we call the func_B and it's return comes back
> > to where we call __fexit__ and then return normally.  
> 
> At that point giving us something like:
> 
> 1:
> 	pushsection __ftail_loc
> 	.long	1b - .
> 	popsection
> 
> 	jmp.d32	func_B
> 	call	__fexit__
> 	ret
> 
> is smaller and simpler, we can patch the jmp.d32 to call when tracing.
> The only problem is SLS, that might wants an int3 after jmp too
> ( https://www.amd.com/en/corporate/product-security/bulletin/amd-sb-1026 ).
> 
> That does avoid the need for __ftail__ I suppose.

Which is basically what I said earlier ;-)

  https://lore.kernel.org/all/20220321122259.28146a7a@gandalf.local.home/

> Or maybe another solution is:
> 
> funcA:
> 	[..]
> 	jmp funcB
> 	call __fexit__
> 	ret
> 
> And if funcA is being traced, we change jmp to a call.
> 
> 	[..]
> 	call funcB
> 	call __fexit__
> 	ret
> 
> Such that we only remove the tail calls if we enable tracing on the
> function with the tail call.

-- Steve
