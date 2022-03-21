Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5DF4E2D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349779AbiCUQNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbiCUQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:13:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B6129811;
        Mon, 21 Mar 2022 09:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4487BB81440;
        Mon, 21 Mar 2022 16:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD07C340E8;
        Mon, 21 Mar 2022 16:12:11 +0000 (UTC)
Date:   Mon, 21 Mar 2022 12:12:09 -0400
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
Message-ID: <20220321121209.3b95e406@gandalf.local.home>
In-Reply-To: <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
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

On Mon, 21 Mar 2022 17:04:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Mar 21, 2022 at 11:28:05AM -0400, Steven Rostedt wrote:
> > On Mon, 21 Mar 2022 14:04:05 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:  
> 
> > > Also, folks, I'm thinking we should start to move to __fexit__, if CET
> > > SHSTK ever wants to come to kernel land return trampolines will
> > > insta-stop working.
> > > 
> > > Hjl, do you think we could get -mfexit to go along with -mfentry ?  
> 
> > int funcA () {
> > 	[..]
> > 	return funcB();
> > }  
> 
> > This currently works with function graph and kretprobe tracing because of
> > the shadow stack. Let's say we traced both funcA and funcB
> > 
> > funcA:
> > 	call __fentry__  
> 			push funcA on trace-stack
> > 
> > 	[..]
> > 	jmp funcB
> > 
> > funcB:
> > 	call __fentry__  
> 			push funcB on trace-stack
> > 
> > 	[..]  
> 	call __fexit__
> 			pop trace-stack until empty
> 			  'exit funcB'
> 			  'exit funcA'

And what happens if funcC called funcA and it too was on the stack. We pop
that too? But it's not done yet, because calling of funcA was not a tail
call.

-- Steve


> 
> > 	ret  
> 
> > 
> > That is, the current algorithm traces the end of both funcA and funcB
> > without issue, because of how the shadow stack works.  
> 
> And it all works, no? Or what am I missing?



