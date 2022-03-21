Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E114E2C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350233AbiCUP3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350211AbiCUP3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10FDEE7;
        Mon, 21 Mar 2022 08:28:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5659961047;
        Mon, 21 Mar 2022 15:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3725BC340E8;
        Mon, 21 Mar 2022 15:28:07 +0000 (UTC)
Date:   Mon, 21 Mar 2022 11:28:05 -0400
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
Message-ID: <20220321112805.1393f9b9@gandalf.local.home>
In-Reply-To: <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
References: <20220321140327.777f9554@canb.auug.org.au>
        <Yjh11UjDZogc3foM@hirez.programming.kicks-ass.net>
        <Yjh3xZuuY3QcZ1Bn@hirez.programming.kicks-ass.net>
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

On Mon, 21 Mar 2022 14:04:05 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Ahh, something tracing. I'll go do some patches on top of it.
> 
> Also, folks, I'm thinking we should start to move to __fexit__, if CET
> SHSTK ever wants to come to kernel land return trampolines will
> insta-stop working.
> 
> Hjl, do you think we could get -mfexit to go along with -mfentry ?

If we do every add a -mfexit, we will need to add a __ftail__ call.
Because, the current function exit tracing works for functions, even with
tail calls.


int funcA () {
	[..]
	return funcB();
}

Can turn into:

	[..]
	pop all stack from funcA
	load reg params to funcB
	jmp funcB

Then when funcB does does it's

	[..]
	ret

It will pop the call site of funcA (not the call site of funcB) and return
to wherever called funcA with the proper return values.

This currently works with function graph and kretprobe tracing because of
the shadow stack. Let's say we traced both funcA and funcB

funcA:
	call __fentry__

			Replace caller address with graph_trampoline and
			store the return caller into the shadow stack.

	[..]
	jmp funcB

funcB:
	call __fentry__

			Replace caller address with graph_trampoline and
			store the return caller (which is the
			graph_trampoline that was switched earlier) in the
			shadow stack.

	[..]
	ret

			Returns to the graph_trampoline and we trace the
			return of funcB. Then we pop off the shadow stack
			and jump to that. But the shadow stack had a call
			to the graph_trampoline, which gets called again.

			Returns to the graph_trampoline and we trace the
			return of funcA. Then we pop off the shadow stack
			and jump to that, which is the original caller to
			funcA.

That is, the current algorithm traces the end of both funcA and funcB
without issue, because of how the shadow stack works.

Now if we add a __fexit__, we will need a way to tell the tracers how to
record this scenario. That is why I'm thinking of a jmp to __ftail__.

Perhaps something like:

funcA:
	call __fentry__
	[..]
	push address of funcB
	jmp __ftail__
	jmp funcB

Where, __ftail__ would do at the end:

	ret

To jump to funcB and we skip the jmp to funcB anyway.

And to "nop" it out, we would have to convert it to.

funcA:
	call __fentry__
	[..]
	jmp 1
	jmp __ftail__
1:	jmp funcB


This is one way I can think of if we include a __fexit__. But to maintain
backward compatibility to function graph tracing (which is a requirement),
we need to be able to handle such cases.

Perhaps this is a good topic to bring up at Plumbers? :-)

Do I need to submit a tracing MC, or can we have this conversation at a
compiler / toolchain MC?

-- Steve
