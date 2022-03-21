Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA2C4E2E40
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351338AbiCUQmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346336AbiCUQmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:42:35 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D306C904;
        Mon, 21 Mar 2022 09:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1alXXCG8SsafVFyYpDrzAC/fb1eFuk40wMrMnE1w1g4=; b=da6+RkwQDrJD49bGvpI587bS/z
        Ix8hy/7rZ9D03IZro7vw6f12P+9tYcDPF3OkgoLPCreLurjZjL6J8lDnP3+7p8hO7U7b/U5JboxjB
        +Wjw9lIOqeBFA6GZKvcSmIsZkkb+89edMIXGK8hvaEMS7fqaoqekUq7IXlAh+DShYIsZUIpy9KrD9
        zNwKqsae/S7qS9U0ga9Bz6qU3GYGfsJcFQ8UCx8qOlaUy4E93qM+ba8cPOafHvpA3Wkr9yc9VtwYI
        6UQ6SQuk0K5w0l7mtZK6iXNcpBlwFEvnJaYufmc9ne2i4+I1uOj+C5TxISnIJs3M1npeLovQk/Ksd
        NHA54u+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWL59-00Akib-U9; Mon, 21 Mar 2022 16:40:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D75443001CD;
        Mon, 21 Mar 2022 17:40:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ACD622DB8D795; Mon, 21 Mar 2022 17:40:32 +0100 (CET)
Date:   Mon, 21 Mar 2022 17:40:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <YjiqgPL+pPGkOgCv@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
 <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
 <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
 <20220321112805.1393f9b9@gandalf.local.home>
 <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
 <20220321121209.3b95e406@gandalf.local.home>
 <20220321121549.1c8588c5@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321121549.1c8588c5@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 12:15:49PM -0400, Steven Rostedt wrote:
> On Mon, 21 Mar 2022 12:12:09 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > > funcB:
> > > > 	call __fentry__    
> > > 			push funcB on trace-stack  
> > > > 
> > > > 	[..]    
> > > 	call __fexit__
> > > 			pop trace-stack until empty
> > > 			  'exit funcB'
> > > 			  'exit funcA'  
> > 
> > And what happens if funcC called funcA and it too was on the stack. We pop
> > that too? But it's not done yet, because calling of funcA was not a tail
> > call.

Hmm, yeah, how about we have __ftail__ mark the left function.

func_B()
{
	...
}

func_A()
{
	...
	return func_B();
}

func_C()
{
	func_A();
	...
	return;
}

func_B:
	call __fentry__	/* push func_B */
	...
	call __fexit__	/* pop 1 + tails */
	ret

func_A:
	call __fentry__ /* push func_A */
	...
	call __ftail__  /* mark func_A tail */
	jmp func_B

func_C:
	call __fentry__ /* push func_C */
	call func_A;
	...
	call __fexit__  /* pop 1 + tails */
	ret;


Then the stack at the end of func_B looks something like:

	func_C
	func_A (tail)
	func_B

And it will pop func_B plus all tails (func_A).

> And I just thought of another issue, where even my solution wont fix it.
> What happens if we trace funcA but not funcB? How do we get to trace the
> end of funcA?

Disallow tail calls to notrace?
