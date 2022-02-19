Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BA24BC72A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 10:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiBSJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 04:39:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiBSJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 04:39:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC65EDC1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 01:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q5wuRX1209w9xSnSv02m71PSrfUPKRuv74EGFBPFlHA=; b=gVzd6yIJ1bdt92jUJTn1kIFm5J
        HqNXW3+kkwCldJFZ5VSr3e/ZJ8YL2RMi31dUlxapYsz+UQWMzfIrT7uS+MX1O/3BSVyevKpwqVOUp
        8Tsc/tARHW6Rj2HLDoTBmhfB6Ro+QLFCvyqPM0hjIq07VtMSRM4zyhB5I7Eshx1iPCLrvy4Et6f6+
        EfnonFvZklKu/rEjNfOWXsKxe9nxQulBvPDeuxPXe+DoAwDBj36GQc1RXd6nTdPkKuA1ycjpWyM7U
        gytrM+dZe9v9nqGsBWu2IkhwFcedOkNVOdHCbjL+QEZRHAyaHEIi19gOV7AqAIC9/+Gk4LBQUpI0o
        ykS4lY0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nLMCk-00HYSm-1T; Sat, 19 Feb 2022 09:39:02 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9029098681B; Sat, 19 Feb 2022 10:39:00 +0100 (CET)
Date:   Sat, 19 Feb 2022 10:39:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 17/29] x86/ibt: Annotate text references
Message-ID: <20220219093900.GH23216@worktop.programming.kicks-ass.net>
References: <20220218164902.008644515@infradead.org>
 <20220218171409.579455015@infradead.org>
 <20220219052216.7b5fx6qileqrdjbw@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220219052216.7b5fx6qileqrdjbw@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 09:22:16PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 18, 2022 at 05:49:19PM +0100, Peter Zijlstra wrote:
> > Annotate away some of the generic code references. This is things
> > where we take the address of a symbol for exception handling or return
> > addresses (eg. context switch).
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> The vast majority of these annotations can go away if objtool only
> requires ENDBR for referenced *STT_FUNC* symbols.
> 
> Anything still needing ANNOTATE_NOENDBR after that, might arguably not
> belong as STT_FUNC anyway and it might make sense to convert it to
> non-function code (e.g. SYM_CODE{START,END}.

I really rather prefer objtool to err to the side of caution for now.
Missing ENDBR typically bricks a box hard, normal consoles don't get
around to showing anything. My force_early_printk patches saved the day
a number of times.

Given that the only hardware I have with this on is a NUC without
serial, this is a massive pain in the arse to debug. That box has been
 >< close to total destruction a number of times. I never want to do that
ever again, life's too short to have to work with a NUC.

> > @@ -564,12 +565,16 @@ SYM_CODE_END(\asmsym)
> >  	.align 16
> >  	.globl __irqentry_text_start
> >  __irqentry_text_start:
> > +	ANNOTATE_NOENDBR // unwinders
> > +	ud2;
> >  
> >  #include <asm/idtentry.h>
> >  
> >  	.align 16
> >  	.globl __irqentry_text_end
> >  __irqentry_text_end:
> > +	ANNOTATE_NOENDBR
> > +	ud2;
> 
> Why ud2?  If no ud2 then the annotation shouldn't be needed since the
> first idt entry has ENDBR.

paranoia :-) just to make absolutely sure nobody ever tries to call
__irqentry_text_end, but yes, removed it.
