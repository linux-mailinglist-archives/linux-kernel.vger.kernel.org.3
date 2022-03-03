Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3294CBE7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiCCNGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbiCCNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:06:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1E452E47
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 05:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vG1GugHzH65ALQjC843dza+LXMjw3Fb66FqmyCiZVR4=; b=FXzr3bF61pYzyirdZSeI9suUOI
        YL4nDXwe7OjjNA5PS4vMiOf64WWhkNxkYXjlHwXkV7ORoVfffEVLc3ZuZFuAAlBjcaFBOVrUYkrJm
        DdHYlxt2JmNeAW89wbVtt1N1uuS+amEV9iPYSrx8ZLBacutKXyyxm8rB2uc/G5QOYIhgfY67gEQ6l
        bjcnc7mQecXc4L6JEF3wJs1q2R3Jsboyi87C7AfxJDbwjJOYGiNPJi8+cEpoBH4zuY+c76/dQmiRy
        3Q72gCDzxYuBB2hTbBVsZSkuoLAOGcLKWYkASVYxpMMvK12AWks9YvvNkFwmQyhRfA+FxtN1KLUYN
        GRByxIDg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPl8Y-00BetW-7h; Thu, 03 Mar 2022 13:04:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4661300242;
        Thu,  3 Mar 2022 14:04:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6146930227409; Thu,  3 Mar 2022 14:04:52 +0100 (CET)
Date:   Thu, 3 Mar 2022 14:04:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, alexei.starovoitov@gmail.com,
        alyssa.milburn@intel.com, andrew.cooper3@citrix.com,
        hjl.tools@gmail.com, joao@overdrivepizza.com, jpoimboe@redhat.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mbenes@suse.cz,
        Masami Hiramatsu <mhiramat@kernel.org>,
        ndesaulniers@google.com, samitolvanen@google.com, x86@kernel.org
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <YiC89O5WtsU871Sf@hirez.programming.kicks-ass.net>
References: <20220224211919.0612a3f6@rorschach.local.home>
 <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
 <20220225083647.12ceb54b@gandalf.local.home>
 <1646159447.ngbqgzj71t.naveen@linux.ibm.com>
 <20220301142016.22e787fb@gandalf.local.home>
 <Yh9vF8REB1JlhQCJ@hirez.programming.kicks-ass.net>
 <20220302110138.6d2abcec@gandalf.local.home>
 <20220302144716.1772020c@gandalf.local.home>
 <Yh/Y2FHw90m00owK@hirez.programming.kicks-ass.net>
 <1646300416.yyrqygami4.naveen@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646300416.yyrqygami4.naveen@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 03:15:14PM +0530, Naveen N. Rao wrote:

> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 7f0ce42f8ff9..4c13406e0bc4 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -198,13 +198,14 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
> > 
> >  	kp = get_kprobe((void *)addr);
> >  	faddr = ftrace_location(addr);
> > +
> >  	/*
> > -	 * Addresses inside the ftrace location are refused by
> > -	 * arch_check_ftrace_location(). Something went terribly wrong
> > -	 * if such an address is checked here.
> > +	 * In case addr maps to sym+0 ftrace_location() might return something
> > +	 * other than faddr. In that case consider it the same as !faddr.
> >  	 */
> > -	if (WARN_ON(faddr && faddr != addr))
> > -		return 0UL;
> > +	if (faddr && faddr != addr)
> > +		faddr = 0;
> > +
> >  	/*
> >  	 * Use the current code if it is not modified by Kprobe
> >  	 * and it cannot be modified by ftrace.
> 
> I hit this issue yesterday in kprobe generic code in
> check_ftrace_location().

What exactly where you running to trigger this? (so that I can extend my
test coverage etc..)

> In both these scenarios, we just want to check if a
> particular instruction is reserved by ftrace.  ftrace_location_range()
> should still work for that purpose, so that may be the easier fix:
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 066fa644e9dfa3..ee3cd035403ca2 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1596,7 +1596,7 @@ static int check_ftrace_location(struct kprobe *p)
> {
> 	unsigned long ftrace_addr;
> 
> -	ftrace_addr = ftrace_location((unsigned long)p->addr);
> +	ftrace_addr = ftrace_location_range((unsigned long)p->addr, (unsigned long)p->addr);

Yes, although perhaps a new helper. I'll go ponder during lunch.

PS. I posted v3 but forgot to Cc you:

  https://lkml.kernel.org/r/20220303112321.422525803@infradead.org

I think the above hunk ended up in the kprobe patch, but on second
thought I should've put it in the ftrace one. I'll go ammend and add
this other site you found.
