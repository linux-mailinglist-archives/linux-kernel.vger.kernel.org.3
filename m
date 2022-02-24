Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008184C3989
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 00:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiBXXKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 18:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiBXXKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:10:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F032179A24
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V59eDIpTzpeWeLqXBU5pQFd0+hZzIXzC0Llp51HlzY0=; b=krrwFwKUGIUE1PWsZmepdLQ9jg
        MYEAKnuFPI9uabTQYP035uKF9HynNAl/MlRXNo6I8JMMXwHh3yvRN+4z0sbcKZkuI5Di9/e9HdmKn
        YFAw5W1Th1LWPt7Mcc8KEL1qrtqRyYXSRbmcnqujg00kTnHDF9wIO97OxN4ju+6yiAxFjdmJMZcF0
        xIwt4TgfPiD4t3/NtKK4ZwTZEP5eCWJlgLfWUXQkKLvEECjuQ0MzTjnow8pDGlHYL+BNBxQYpZjs+
        EHI1Ii30dvCAnAFCIkNvX1hZyY75qhSIpET8MJKc+MNPq9ZadsPUocqTy+bhxRhxfC2VN9Q66wJux
        pEHAbLMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNNEg-00ClXN-Uh; Thu, 24 Feb 2022 23:09:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13EC8300230;
        Fri, 25 Feb 2022 00:09:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 977352D06161E; Fri, 25 Feb 2022 00:09:20 +0100 (CET)
Date:   Fri, 25 Feb 2022 00:09:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 14/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <YhgQIGfrkOB7OYWw@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.834445396@infradead.org>
 <YhemGUoGmrzxuc+C@hirez.programming.kicks-ass.net>
 <20220224104230.4a9a3125@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224104230.4a9a3125@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 10:42:30AM -0500, Steven Rostedt wrote:
> On Thu, 24 Feb 2022 16:36:57 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Thu, Feb 24, 2022 at 03:51:52PM +0100, Peter Zijlstra wrote:
> > > @@ -316,10 +317,12 @@ SYM_FUNC_START(return_to_handler)
> > >  
> > >  	call ftrace_return_to_handler
> > >  
> > > -	movq %rax, %rdi
> > > +	movq %rax, 16(%rsp)
> > >  	movq 8(%rsp), %rdx
> > >  	movq (%rsp), %rax
> > > -	addq $24, %rsp
> > > -	JMP_NOSPEC rdi
> > > +
> > > +	addq $16, %rsp
> > > +	UNWIND_HINT_FUNC
> > > +	RET
> > >  SYM_FUNC_END(return_to_handler)
> > >  #endif  
> > 
> > While talking about this with Mark, an alternative solution is something
> > like this, that would keep the RSB balanced and only mess up the current
> > return.
> > 
> > No idea it if makes an appreciatable difference on current hardware,
> > therefore I went with the simpler option above.
> > 
> > @@ -307,7 +315,7 @@ EXPORT_SYMBOL(__fentry__)
> >  
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> >  SYM_FUNC_START(return_to_handler)
> > -	subq  $24, %rsp
> > +	subq  $16, %rsp
> >  
> >  	/* Save the return values */
> >  	movq %rax, (%rsp)
> > @@ -319,7 +327,13 @@ SYM_FUNC_START(return_to_handler)
> >  	movq %rax, %rdi
> >  	movq 8(%rsp), %rdx
> >  	movq (%rsp), %rax
> > -	addq $24, %rsp
> > -	JMP_NOSPEC rdi
> > +
> > +	addq $16, %rsp
> > +	ANNOTATE_INTRA_FUNCTION_CALL
> > +	call .Ldo_rop
> > +.Ldo_rop:
> 
> What's the overhead of an added call (for every function call that is being
> traced)?

Who knows :-) That's all u-arch magic and needs testing (on lots of
hardware). I suspect the dominating cost of all this code is the RSB
miss, not a few regular instructions.

So with this alternative we'll get one guaranteed RSB miss per
construction, but at least the RSB should be mostly good again
afterwards.

With the patch as proposed, the RSB is basically scrap due to
unbalanced.

The original patch changing it to an indirect call cited <2% performance
improvement IIRC, and that all was pre-speculation mess. This
alternative isn't much different from a retpoline (all that's missing is
the speculation trap).

