Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B7C4E4178
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiCVOiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237974AbiCVOiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:38:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194366AA52;
        Tue, 22 Mar 2022 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/4heW2XHZRFLz+hyRlxTzkxlhn+UmcdznSx7bzv3MCk=; b=piByHcxa0J71QzEQn5NsjwE3QM
        LEZc/7zDWEdUMpJl6gD7uOEjjk9XAfEdoyV/6dpngp1sO94yVcx+FUVHJIakHA8q2y7BKkjeiReA7
        h5+Q38djso32qbqwXG3m8Pp+jv8zMDIzSlM5Gxx2Vm2nYdRBKvPOHdRzpS/XOMPD/Olgey5Q7jUK4
        rL9M4E4CSTpybeVmbBNAU6kekKpH5xSp+v7O0J/IcmdxxTow/WFnvCIkKmwFR5JM1RGGQq21QGcA+
        gDnlKNKm3kPUQamkvEuT8yjowK69aHfnPxcI7sBApEXzQ3kjc9JXBNEECzeq4hlFZ/zjFLxmgY+7E
        C9JwgN8g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWfc6-00Bg37-5p; Tue, 22 Mar 2022 14:35:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 49D1A3001CD;
        Tue, 22 Mar 2022 15:35:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C73622D6D4316; Tue, 22 Mar 2022 15:35:54 +0100 (CET)
Date:   Tue, 22 Mar 2022 15:35:54 +0100
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
Message-ID: <Yjneyn8o06svJkY4@hirez.programming.kicks-ass.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322091242.1ad0206b@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 09:12:42AM -0400, Steven Rostedt wrote:

> > Suppose:
> > 
> > notrace func_B()
> > {
> > 	...
> > }
> > 
> > func_A()
> > {
> > 	...
> > 	return func_B();
> > }
> > 
> > then inhibiting tail calls would end up looking like:
> 
> If we inhibit tail calls, then we do not need to make func_B notrace.

Dude, you're arguing in circles :-( the notrace was a given.

> > func_A:
> > 	call __fentry__
> > 	...
> > 	call func_B
> > 	call __fexit__
> > 	ret
> > 
> > Then A is fully traced, B is invisible, as per spec. What is the
> > problem?
> 
> The above is fine, but then func_B is not a tail call and can also be
> traced.

Again, B is notrace as a given. This was all about how to deal with
notrace functions.

I suggested inhibiting tail-call to notrace, you said no. You now seem to
agree that solves it.

> > The problem you initially had, of doing a tail-call into a notrace, was
> > that the __fexit__ call went missing, because notrace will obviously not
> > have that. But that's avoided by inhibiting all tail-calls between
> > notrace and !notrace functions (note that notrace must also not
> > tail-call !notrace).
> 
> I'm confused by the above. Why can't a notrace tail call a !notrace?
> If we tail call to a
> 
> func_B:
> 	call __fentry__
> 	...
> 	call __fexit__
> 	ret
> 
> then the fentry and fexit show a perfectly valid trace of func_B.

Bah; I thought I had a case this morning, but now I can't seem to recall
:/

> > Your worry seems to stem about loosing visiblilty of !notrace functions,
> > but AFAICT that doesn't happen.
> 
> My worry is:
> 
> func_A:
> 	call __fentry__
> 	...
> 	jmp func_B
> 
> Where do we do the call __fexit__ ?

In B (or wherever if B again does a tail-call).

> That was the original concern, and I think the proposed solutions have
> convoluted our thoughts about what we are trying to fix. So let's go back
> to the beginning, and see how to deal with it.
> 
> That is, we have:
> 
> func_C:
> 	call __fenty__
> 	...
> 	call func_A:
> 	...
> 	call func_B:
> 	...
> 	call __fexit__
> 	ret
> 
> func_A:
> 	call __fentry__
> 	...
	call __ftail__
> 	jmp func_B
> 
> func_B:
> 	call __fentry__
> 	...
> 	call __fexit__
> 	ret
> 
> Where the above is C calling A and B as normal functions, A calling B as a
> tail call and B just being a normal function called by both A and C (and
> many other functions).

We need the __ftail__ thing to mark the trace-stack entry of func_A as
complete, then any future __fexit__ will be able to pop all completed
entries.

In recap:

	__fentry__ -- push on trace-stack
	__ftail__  -- mark top-most entry complete
	__fexit__  -- mark top-most entry complete;
	              pop all completed entries

inhibit tail-calls to notrace.

> And note, I do not want to limit function tracing (which does not rely on
> __fexit__) just because we can't figure out how to handle __fexit__.

I'm not following. Regular function tracing needs none of this.

It's function graph tracing, kretprobes and whatever else this rethook
stuff is about that needs this because return trampolines will stop
working somewhere in the not too distant future.

