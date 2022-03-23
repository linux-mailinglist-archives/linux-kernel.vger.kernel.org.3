Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F724E4ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 03:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241165AbiCWCZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 22:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiCWCZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 22:25:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0AB7005E;
        Tue, 22 Mar 2022 19:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66650B81DB1;
        Wed, 23 Mar 2022 02:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A27C340F2;
        Wed, 23 Mar 2022 02:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648002209;
        bh=1cvkF/9sYmW6g5wCOxL9pkp7ASz+ZnvBaAaw5jFv7CA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JynR6umewdVdS9sJsJpEGY4XJKO6Ry9NkATSBVbSdZrtZbNO/nJ3Vn8uJoZEpGoMM
         PJb0tU3AXQKMzn9qjR5MTBBWRKMFR6Knk2Oll0Km7p+4sGoxqYZylCItGXaNZkhKDL
         X2rsGmWE3XZSx1C6P5du3W13ExYQEXOQY1+XLbgf1jg3AzfOEAL+if3aH6ESxe5UZo
         33/lNyykQueClf7VldoZH5cfcqntWvqrX7BPQojeQoO9mHSo21h7dAWTccnG/Yrgkt
         peNVyyNMQoDBwBWV/uRuq+94RyG/W4LA86A2dmRDBV6uZZnMEsnPKCk7PjdaclQJ1q
         WLSzftzOI9ODQ==
Date:   Wed, 23 Mar 2022 11:23:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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
Message-Id: <20220323112323.65337d76d96836e487064a99@kernel.org>
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
> 
> I suggested inhibiting tail-call to notrace, you said no. You now seem to
> agree that solves it.
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
> 
> inhibit tail-calls to notrace.
> 
> > And note, I do not want to limit function tracing (which does not rely on
> > __fexit__) just because we can't figure out how to handle __fexit__.
> 
> I'm not following. Regular function tracing needs none of this.
> 
> It's function graph tracing, kretprobes and whatever else this rethook
> stuff is about that needs this because return trampolines will stop
> working somewhere in the not too distant future.

I see the __fexit__ is needed, but why __ftail__ is needed? I guess because
func_B is notrace, in that case the __fexit__ will not be in the func_B.
Am I correct?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
