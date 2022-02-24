Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE24C3014
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbiBXPnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236544AbiBXPnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:43:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB3C1A39F8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:42:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E9D360F3D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA40C340E9;
        Thu, 24 Feb 2022 15:42:32 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:42:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 14/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <20220224104230.4a9a3125@gandalf.local.home>
In-Reply-To: <YhemGUoGmrzxuc+C@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.834445396@infradead.org>
        <YhemGUoGmrzxuc+C@hirez.programming.kicks-ass.net>
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

On Thu, 24 Feb 2022 16:36:57 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Feb 24, 2022 at 03:51:52PM +0100, Peter Zijlstra wrote:
> > @@ -316,10 +317,12 @@ SYM_FUNC_START(return_to_handler)
> >  
> >  	call ftrace_return_to_handler
> >  
> > -	movq %rax, %rdi
> > +	movq %rax, 16(%rsp)
> >  	movq 8(%rsp), %rdx
> >  	movq (%rsp), %rax
> > -	addq $24, %rsp
> > -	JMP_NOSPEC rdi
> > +
> > +	addq $16, %rsp
> > +	UNWIND_HINT_FUNC
> > +	RET
> >  SYM_FUNC_END(return_to_handler)
> >  #endif  
> 
> While talking about this with Mark, an alternative solution is something
> like this, that would keep the RSB balanced and only mess up the current
> return.
> 
> No idea it if makes an appreciatable difference on current hardware,
> therefore I went with the simpler option above.
> 
> @@ -307,7 +315,7 @@ EXPORT_SYMBOL(__fentry__)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  SYM_FUNC_START(return_to_handler)
> -	subq  $24, %rsp
> +	subq  $16, %rsp
>  
>  	/* Save the return values */
>  	movq %rax, (%rsp)
> @@ -319,7 +327,13 @@ SYM_FUNC_START(return_to_handler)
>  	movq %rax, %rdi
>  	movq 8(%rsp), %rdx
>  	movq (%rsp), %rax
> -	addq $24, %rsp
> -	JMP_NOSPEC rdi
> +
> +	addq $16, %rsp
> +	ANNOTATE_INTRA_FUNCTION_CALL
> +	call .Ldo_rop
> +.Ldo_rop:

What's the overhead of an added call (for every function call that is being
traced)?

-- Steve

> +	mov %rdi, (%rsp)
> +	UNWIND_HINT_FUNC
> +	RET
>  SYM_FUNC_END(return_to_handler)
>  #endif
> 

