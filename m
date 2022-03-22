Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92184E3F35
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbiCVNOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbiCVNOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:14:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9FF83B0E;
        Tue, 22 Mar 2022 06:12:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32C11B81CF8;
        Tue, 22 Mar 2022 13:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33944C340EC;
        Tue, 22 Mar 2022 13:12:44 +0000 (UTC)
Date:   Tue, 22 Mar 2022 09:12:42 -0400
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
Message-ID: <20220322091242.1ad0206b@gandalf.local.home>
In-Reply-To: <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
References: <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
        <20220321121549.1c8588c5@gandalf.local.home>
        <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
        <20220321124551.3d73660b@gandalf.local.home>
        <Yjis6hJKUj/WrSwK@hirez.programming.kicks-ass.net>
        <20220321125419.0a20415c@gandalf.local.home>
        <YjmAz0MbdW4Q1Cnv@hirez.programming.kicks-ass.net>
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

On Tue, 22 Mar 2022 08:54:55 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 21, 2022 at 12:54:19PM -0400, Steven Rostedt wrote:
> > On Mon, 21 Mar 2022 17:50:50 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >   
> > > > This also assumes that we need to trace everything that is marked. I
> > > > mentioned in another email, what do we do if we only trace funcA?    
> > > 
> > > Like I said later on; if we inhibit tail-calls to notrace, this goes
> > > away.  
> > 
> > Please no. The number of "notrace" functions is increasing to the point
> > that it's starting to make function tracing useless in a lot of
> > circumstances. I've already lost my ability to see when user space goes
> > into the kernel (which I have to hack up custom coding to enable again).  
> 
> I really can't follow the argument there, nor on IRC.
> 
> Suppose:
> 
> notrace func_B()
> {
> 	...
> }
> 
> func_A()
> {
> 	...
> 	return func_B();
> }
> 
> then inhibiting tail calls would end up looking like:

If we inhibit tail calls, then we do not need to make func_B notrace.

> 
> func_A:
> 	call __fentry__
> 	...
> 	call func_B
> 	call __fexit__
> 	ret
> 
> Then A is fully traced, B is invisible, as per spec. What is the
> problem?

The above is fine, but then func_B is not a tail call and can also be
traced.

> 
> The problem you initially had, of doing a tail-call into a notrace, was
> that the __fexit__ call went missing, because notrace will obviously not
> have that. But that's avoided by inhibiting all tail-calls between
> notrace and !notrace functions (note that notrace must also not
> tail-call !notrace).

I'm confused by the above. Why can't a notrace tail call a !notrace?
If we tail call to a

func_B:
	call __fentry__
	...
	call __fexit__
	ret

then the fentry and fexit show a perfectly valid trace of func_B.


> 
> Your worry seems to stem about loosing visiblilty of !notrace functions,
> but AFAICT that doesn't happen.

My worry is:

func_A:
	call __fentry__
	...
	jmp func_B

Where do we do the call __fexit__ ?

That was the original concern, and I think the proposed solutions have
convoluted our thoughts about what we are trying to fix. So let's go back
to the beginning, and see how to deal with it.

That is, we have:

func_C:
	call __fenty__
	...
	call func_A:
	...
	call func_B:
	...
	call __fexit__
	ret

func_A:
	call __fentry__
	...
	jmp func_B

func_B:
	call __fentry__
	...
	call __fexit__
	ret

Where the above is C calling A and B as normal functions, A calling B as a
tail call and B just being a normal function called by both A and C (and
many other functions).

And note, I do not want to limit function tracing (which does not rely on
__fexit__) just because we can't figure out how to handle __fexit__.

-- Steve
