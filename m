Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F774E413C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbiCVO2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbiCVO0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:26:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C662D13F48;
        Tue, 22 Mar 2022 07:25:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A411615BE;
        Tue, 22 Mar 2022 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781C1C340EC;
        Tue, 22 Mar 2022 14:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647959121;
        bh=ZJy4jdo44xK7N2rkd/X1voMeDEE0lojYlDBJmgmcmhU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MPq7XyYuZOLpWAJVUwMdRZF7wvfqt9CnUvtuCNcd2EOsQR8wjlPn5L4wm70eaJTdv
         vkzjJCsXqKJRIfx3XxKJit/vwbEzEbdq9BeTJkdXy3os6LpfO254lsfS9Jk2YyFeab
         0foNkCXdYPv45Wi0TF9u/KImGJNoBq+WovUGkxJERZBvh2OhX47pJtUJOIkVXICiYs
         lqkp5A/NqVfp2Zjzul9P5+zkGMJNR6ZnzLItF6WzdG2BQ6yiUNU147qlqeXuEkknXz
         qVCy43qgJNPbH6x+fl1YL+MfS87lnvE9cWDnsQkit56gHkYwSNJa2Qe3KU37/mFn+a
         FQvJKCHe2gzJw==
Date:   Tue, 22 Mar 2022 23:25:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
Message-Id: <20220322232515.97d8e2d66d051881bcfe3ce0@kernel.org>
In-Reply-To: <20220321121209.3b95e406@gandalf.local.home>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
        <20220321112805.1393f9b9@gandalf.local.home>
        <YjiiDFHIQg78QwSb@hirez.programming.kicks-ass.net>
        <20220321121209.3b95e406@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2022 12:12:09 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 21 Mar 2022 17:04:28 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Mon, Mar 21, 2022 at 11:28:05AM -0400, Steven Rostedt wrote:
> > > On Mon, 21 Mar 2022 14:04:05 +0100
> > > Peter Zijlstra <peterz@infradead.org> wrote:  
> > 
> > > > Also, folks, I'm thinking we should start to move to __fexit__, if CET
> > > > SHSTK ever wants to come to kernel land return trampolines will
> > > > insta-stop working.
> > > > 
> > > > Hjl, do you think we could get -mfexit to go along with -mfentry ?  
> > 
> > > int funcA () {
> > > 	[..]
> > > 	return funcB();
> > > }  
> > 
> > > This currently works with function graph and kretprobe tracing because of
> > > the shadow stack. Let's say we traced both funcA and funcB
> > > 
> > > funcA:
> > > 	call __fentry__  
> > 			push funcA on trace-stack
> > > 
> > > 	[..]
> > > 	jmp funcB
> > > 
> > > funcB:
> > > 	call __fentry__  
> > 			push funcB on trace-stack
> > > 
> > > 	[..]  
> > 	call __fexit__
> > 			pop trace-stack until empty

This seems wrong. We don't pop the trace-stack until empty, but we will
record the real stack pointer at funcA.

> > 			  'exit funcB'
> > 			  'exit funcA'
> 
> And what happens if funcC called funcA and it too was on the stack. We pop
> that too? But it's not done yet, because calling of funcA was not a tail
> call.

Thus when the funcC is called, the trace-stack will be poped until funcA,
because we can see the real stack pointer at the 'ret'.
So the funcC is still on the trace-stack after that.

Thank you,


> 
> -- Steve
> 
> 
> > 
> > > 	ret  
> > 
> > > 
> > > That is, the current algorithm traces the end of both funcA and funcB
> > > without issue, because of how the shadow stack works.  
> > 
> > And it all works, no? Or what am I missing?
> 
> 
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
