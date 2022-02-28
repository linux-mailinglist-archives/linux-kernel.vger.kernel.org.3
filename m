Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1894C7A27
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiB1ULQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiB1ULN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:11:13 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EFE8A6D7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2jbfLrSvabZhSRAV6PbcmymrKxcMw4bmZkyd9X9fc5M=; b=XJC2MMh7oyskdts0nFgxedjw4k
        IywefnfRP5nhTF4zmniYWZWtKRsz9ooc0SlJ7admVJExTYh2bqbAVy12keAhWoMIEYSVz7QRWhY3h
        XP23b1KkLeZKKts7r9sLKl9Xw7oaPeQ4CSkufowBbafHBDHUwOtP5ePJPsNYu3tdwduZqKMEFtKGA
        buCdPhQw47cjh3usVKkVUCoCo3IzIWH6moD5zBnhmspEqZ6zjZ3UdWv+KGKOkCXEpZU4z8tvcgh0q
        eMVMnYzRgZEz1BlFYhRFGDajC/cNdNpL0cMgIRWjkA4jL4SteFFqYuNw5hGVD5UzIiMpZIBR1Ue1f
        rMwZ0INw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOmLP-00DzuP-QT; Mon, 28 Feb 2022 20:10:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 687AB986271; Mon, 28 Feb 2022 21:10:07 +0100 (CET)
Date:   Mon, 28 Feb 2022 21:10:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220228201007.GG11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
 <20220227170003.GE11184@worktop.programming.kicks-ass.net>
 <20220227222055.uqgcz33dwhl3atpr@treble>
 <YhyaS4tN9NpCJcmk@hirez.programming.kicks-ass.net>
 <20220228183655.gcacvddofbaaiqhz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228183655.gcacvddofbaaiqhz@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 10:36:55AM -0800, Josh Poimboeuf wrote:
> On Mon, Feb 28, 2022 at 10:47:55AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 27, 2022 at 02:20:55PM -0800, Josh Poimboeuf wrote:
> > > On Sun, Feb 27, 2022 at 06:00:03PM +0100, Peter Zijlstra wrote:
> > > > > > @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
> > > > > >  
> > > > > >  		if (insn->hint) {
> > > > > >  			state.cfi = *insn->cfi;
> > > > > > +			if (ibt) {
> > > > > > +				struct symbol *sym;
> > > > > > +
> > > > > > +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> > > > > > +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> > > > > > +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> > > > > > +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> > > > > > +						  insn->sec, insn->offset,
> > > > > > +						  sym->name);
> > > > > > +				}
> > > > > 
> > > > > No need to print sym->name here, WARN_FUNC() already does it?
> > > > 
> > > > Almost; perhaps the change to make is to either introduce WARN_SYM or
> > > > make WARN_FUNC also print !STT_FUNC symbols ?
> > > 
> > > In the case of no function, WARN_FUNC() falls back to printing sec+off.
> > > Is that not good enough?
> > 
> > I got really tired of doing the manual symbol lookup... I don't suppose
> > it matters too much now that I've more or less completed the triage, but
> > it was useful.
> 
> Maybe it would be reasonable to change WARN_FUNC to do that?  i.e. fall
> back from func+off to sym+off to sec+off.

I'll make it happen.
