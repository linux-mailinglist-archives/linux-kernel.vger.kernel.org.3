Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5414C1035
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 11:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiBWKWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 05:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiBWKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 05:22:04 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EFE1262F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 02:21:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E8FB41F3A8;
        Wed, 23 Feb 2022 10:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645611693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tadDHS2N9HpA5UT59geTEf24+yMniaG0dLcp39bFAek=;
        b=canKdnVDaZO2bfg0kP5vn40cVmrf6/XyVJqkl4ouP4eXsdj3wpDyOzPKO/ET6/hayqISPz
        pr0fXduSP1eMZ41n/+vVxY5bWfZeB/LljdZJd6BIUiydto3TzO9F/IEAM84Xo1zxrRre4/
        vZ8c2djPEKaWfLnJFLaF8BGWLVPjAuI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645611693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tadDHS2N9HpA5UT59geTEf24+yMniaG0dLcp39bFAek=;
        b=fyB4WeWwY3gzsDqwwiVb+cmNA6han5BXJE7RJZI34QEmGqRHrRSvJ+BFOAPq8TncwFzYIR
        N8hdGvqP/drKJJDw==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B46B1A3B93;
        Wed, 23 Feb 2022 10:21:33 +0000 (UTC)
Date:   Wed, 23 Feb 2022 11:21:33 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 04/29] x86/livepatch: Validate __fentry__ location
In-Reply-To: <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LSU.2.21.2202231119160.2981@pobox.suse.cz>
References: <20220218164902.008644515@infradead.org> <20220218171408.808810436@infradead.org> <20220218210831.u2ugtfr7gxllk4cs@treble> <YhYH6FMNh8pMws6Z@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Feb 2022, Peter Zijlstra wrote:

> On Fri, Feb 18, 2022 at 01:08:31PM -0800, Josh Poimboeuf wrote:
> > On Fri, Feb 18, 2022 at 05:49:06PM +0100, Peter Zijlstra wrote:
> > > Currently livepatch assumes __fentry__ lives at func+0, which is most
> > > likely untrue with IBT on. Override the weak klp_get_ftrace_location()
> > > function with an arch specific version that's IBT aware.
> > > 
> > > Also make the weak fallback verify the location is an actual ftrace
> > > location as a sanity check.
> > > 
> > > Suggested-by: Miroslav Benes <mbenes@suse.cz>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  arch/x86/include/asm/livepatch.h |    9 +++++++++
> > >  kernel/livepatch/patch.c         |    2 +-
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > 
> > > --- a/arch/x86/include/asm/livepatch.h
> > > +++ b/arch/x86/include/asm/livepatch.h
> > > @@ -17,4 +17,13 @@ static inline void klp_arch_set_pc(struc
> > >  	ftrace_instruction_pointer_set(fregs, ip);
> > >  }
> > >  
> > > +#define klp_get_ftrace_location klp_get_ftrace_location
> > > +static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
> > > +{
> > > +	unsigned long addr = ftrace_location(faddr);
> > > +	if (!addr && IS_ENABLED(CONFIG_X86_IBT))
> > > +		addr = ftrace_location(faddr + 4);
> > > +	return addr;
> > 
> > I'm kind of surprised this logic doesn't exist in ftrace itself.  Is
> > livepatch really the only user that needs to find the fentry for a given
> > function?
> > 
> > I had to do a double take for the ftrace_location() semantics, as I
> > originally assumed that's what it did, based on its name and signature.
> > 
> > Instead it apparently functions like a bool but returns its argument on
> > success.
> > 
> > Though the function comment tells a different story:
> > 
> > /**
> >  * ftrace_location - return true if the ip giving is a traced location
> > 
> > So it's all kinds of confusing...
> 
> Yes.. so yesterday, when making function-graph tracing not explode, I
> ran into a similar issue. Steve suggested something along the lines of
> .... this.
> 
> (modified from his actual suggestion to also cover this case)
> 
> Let me go try this...

Yes, this looks good.
 
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1578,7 +1578,23 @@ unsigned long ftrace_location_range(unsi
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	return ftrace_location_range(ip, ip);
> +	struct dyn_ftrace *rec;
> +	unsigned long offset;
> +	unsigned long size;
> +
> +	rec = lookup_rec(ip, ip);
> +	if (!rec) {
> +		if (!kallsyms_lookup(ip, &size, &offset, NULL, NULL))

Since we do not care about a symbol name, kallsyms_lookup_size_offset() 
would be better I think.

Miroslav
