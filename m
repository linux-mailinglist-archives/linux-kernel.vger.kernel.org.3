Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B5D4E427D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiCVPGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234323AbiCVPGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:06:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E24F80224;
        Tue, 22 Mar 2022 08:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B4960B38;
        Tue, 22 Mar 2022 15:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22F1C340ED;
        Tue, 22 Mar 2022 15:04:39 +0000 (UTC)
Date:   Tue, 22 Mar 2022 11:04:38 -0400
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
Message-ID: <20220322110438.25c2a760@gandalf.local.home>
In-Reply-To: <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
References: <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
        <20220321124551.3d73660b@gandalf.local.home>
        <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
        <20220321125419.0a20415c@gandalf.local.home>
        <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
        <20220322091242.1ad0206b@gandalf.local.home>
        <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
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

On Tue, 22 Mar 2022 15:35:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 22, 2022 at 09:12:42AM -0400, Steven Rostedt wrote:
> 
> > > Suppose:
> > > 
> > > notrace func_B()
> > > {
> > > 	...
> > > }
> > > 
> > > func_A()
> > > {
> > > 	...
> > > 	return func_B();
> > > }
> > > 
> > > then inhibiting tail calls would end up looking like:  
> > 
> > If we inhibit tail calls, then we do not need to make func_B notrace.  
> 
> Dude, you're arguing in circles :-( the notrace was a given.

Why is it notrace? Sorry to be dense, but it's not a given to me.

> 
> > > func_A:
> > > 	call __fentry__
> > > 	...
> > > 	call func_B
> > > 	call __fexit__
> > > 	ret
> > > 
> > > Then A is fully traced, B is invisible, as per spec. What is the
> > > problem?  
> > 
> > The above is fine, but then func_B is not a tail call and can also be
> > traced.  
> 
> Again, B is notrace as a given. This was all about how to deal with
> notrace functions.


No, it was about how to deal with notrace functions that were tail calls.
That was what I had an issue with. Because the solution you proposed had
func_A depend on func_B executing its call __fexit__ which it would not, if
it was not traced.

> 
> I suggested inhibiting tail-call to notrace, you said no. You now seem to
> agree that solves it.

I said inhibiting tail-calls was a solution, but only inhibiting it to
notrace would probably have a significant performance impact.

I thought you were talking about adding notrace to tail calls, not the
other way around. Maybe that is our confusion in this conversation.

> 
> > > The problem you initially had, of doing a tail-call into a notrace, was
> > > that the __fexit__ call went missing, because notrace will obviously not
> > > have that. But that's avoided by inhibiting all tail-calls between
> > > notrace and !notrace functions (note that notrace must also not
> > > tail-call !notrace).  
> > 
> > I'm confused by the above. Why can't a notrace tail call a !notrace?
> > If we tail call to a
> > 
> > func_B:
> > 	call __fentry__
> > 	...
> > 	call __fexit__
> > 	ret
> > 
> > then the fentry and fexit show a perfectly valid trace of func_B.  
> 
> Bah; I thought I had a case this morning, but now I can't seem to recall
> :/

That happens to all of us ;-)

> 
> > > Your worry seems to stem about loosing visiblilty of !notrace functions,
> > > but AFAICT that doesn't happen.  
> > 
> > My worry is:
> > 
> > func_A:
> > 	call __fentry__
> > 	...
> > 	jmp func_B
> > 
> > Where do we do the call __fexit__ ?  
> 
> In B (or wherever if B again does a tail-call).

But there's no guarantee that the call __fexit__ will not be a nop in
func_B. Remember, these are all turned on and off. If we just trace func_A
and not func_B, we will never have a call __fexit__ for func_A.

> 
> > That was the original concern, and I think the proposed solutions have
> > convoluted our thoughts about what we are trying to fix. So let's go back
> > to the beginning, and see how to deal with it.
> > 
> > That is, we have:
> > 
> > func_C:
> > 	call __fenty__
> > 	...
> > 	call func_A:
> > 	...
> > 	call func_B:
> > 	...
> > 	call __fexit__
> > 	ret
> > 
> > func_A:
> > 	call __fentry__
> > 	...  
> 	call __ftail__
> > 	jmp func_B
> > 
> > func_B:
> > 	call __fentry__
> > 	...
> > 	call __fexit__
> > 	ret
> > 
> > Where the above is C calling A and B as normal functions, A calling B as a
> > tail call and B just being a normal function called by both A and C (and
> > many other functions).  
> 
> We need the __ftail__ thing to mark the trace-stack entry of func_A as
> complete, then any future __fexit__ will be able to pop all completed
> entries.
> 
> In recap:
> 
> 	__fentry__ -- push on trace-stack
> 	__ftail__  -- mark top-most entry complete
> 	__fexit__  -- mark top-most entry complete;
> 	              pop all completed entries

Again, this would require that the tail-calls are also being traced.

> 
> inhibit tail-calls to notrace.

Just inhibiting tail-calls to notrace would work without any of the above.
But my fear is that will cause a noticeable performance impact.

> 
> > And note, I do not want to limit function tracing (which does not rely on
> > __fexit__) just because we can't figure out how to handle __fexit__.  
> 
> I'm not following. Regular function tracing needs none of this.

The regular function tracing does not need this. Only function graph
tracing. I was thinking you were *adding* notrace to tail calls and such,
which is what I was against. But apparently that is not what you were
saying.

> 
> It's function graph tracing, kretprobes and whatever else this rethook
> stuff is about that needs this because return trampolines will stop
> working somewhere in the not too distant future.

Another crazy solution is to have:

func_A:
	call __fentry__
	...
tail:	jmp 1f 
	call 1f
	call __fexit__
	ret
1:	jmp func_B


where the compiler tells us about "tail:" and that we know that func_A ends
with a tail call, and if we want to trace the end of func_A we convert that
jmp 1f into a nop. And then we call the func_B and it's return comes back
to where we call __fexit__ and then return normally.

-- Steve
