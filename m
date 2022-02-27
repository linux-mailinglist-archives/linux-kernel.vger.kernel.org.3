Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A07D4C5D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiB0RBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiB0RBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:01:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A25AA6A
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c6IGZLg1cs28ExdACXB6rM1Fxn4wGWAh5pp9NK4OMxo=; b=i2AUGUhH4gZFv+hNVexGwBrMwk
        tq2eRQIO5+qlwLFcWiByZtjtAS1AvR7mI+8tHP0sA9EjNdsFgOJLYdhwvavhdqVbI3D3Ud32MZVBm
        8dTSEG7eU+t0VPenwhdZDIx1GdVc6kFGyfgCCahE8bBM8yUCpEc5ciqkK8u0+Ko/XQwP1FFWQaip1
        GAQB0LzBbW1XaMq5B3rWYrdqf3ITuFcGsfRgTs4VCntW1RcGvJBzOpy8k/4eu+Wpp62XLZ5T8DwA2
        JkPkD/IqMb8/zcQPPl1nEvKtk9OIIjz2V4WB8qn18QNXjM6gADs4em4hWWmvSRIO24JqYDsB7M194
        8t71LMyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOMtx-007hjJ-Kh; Sun, 27 Feb 2022 17:00:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id E19C09832BE; Sun, 27 Feb 2022 18:00:03 +0100 (CET)
Date:   Sun, 27 Feb 2022 18:00:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220227170003.GE11184@worktop.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
 <20220227031348.drbmkcmoqur53aay@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220227031348.drbmkcmoqur53aay@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 07:13:48PM -0800, Josh Poimboeuf wrote:
> On Thu, Feb 24, 2022 at 03:52:12PM +0100, Peter Zijlstra wrote:
> > +++ b/tools/objtool/check.c
> > @@ -380,6 +380,7 @@ static int decode_instructions(struct ob
> >  			memset(insn, 0, sizeof(*insn));
> >  			INIT_LIST_HEAD(&insn->alts);
> >  			INIT_LIST_HEAD(&insn->stack_ops);
> > +			INIT_LIST_HEAD(&insn->call_node);
> 
> Is this needed?  'call_node' isn't actually a list head, otherwise this
> would presumably be fixing a major bug.

Somewhere there's an unconditional list_del_init() on call_node, could
be that moved to another patch and now it don't make immediate sense,
I'll move them together again.

> >  			insn->sec = sec;
> >  			insn->offset = offset;
> > @@ -1176,6 +1177,14 @@ static int add_jump_destinations(struct
> >  	unsigned long dest_off;
> >  
> >  	for_each_insn(file, insn) {
> > +		if (insn->type == INSN_ENDBR && insn->func) {
> > +			if (insn->offset == insn->func->offset) {
> > +				file->nr_endbr++;
> > +			} else {
> > +				file->nr_endbr_int++;
> > +			}
> > +		}
> > +
> 
> This doesn't have much to do with adding jump destinations.  I'm
> thinking this would fit better in decode_instructions() in the
> sym_for_each_insn() loop.

Fair enough I suppose. I'm not quite sure how it ended up where it did.

> > @@ -1219,6 +1236,16 @@ static int add_jump_destinations(struct
> >  			return -1;
> >  		}
> >  
> > +		if (ibt && insn->jump_dest->type == INSN_ENDBR &&
> > +		    insn->jump_dest->func &&
> > +		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
> > +			if (reloc) {
> > +				WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
> > +			} else {
> > +				WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
> > +			}
> > +		}
> > +
> 
> I have several concerns about all the above (and corresponding changes
> elsewhere), but it looks like this was moved to separate patches, for
> ease of NACKing :-)

Right, we talked about that, I'll move the whole UD1 poisoning to the
end and use NOP4 instead, which removes the need for this.

> >  		/*
> >  		 * Cross-function jump.
> >  		 */
> > @@ -1246,7 +1273,8 @@ static int add_jump_destinations(struct
> >  				insn->jump_dest->func->pfunc = insn->func;
> >  
> >  			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
> > -				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
> > +				   ((insn->jump_dest->offset == insn->jump_dest->func->offset) ||
> > +				    (insn->jump_dest->offset == insn->jump_dest->func->offset + 4))) {
> >  				/* internal sibling call (without reloc) */
> >  				add_call_dest(file, insn, insn->jump_dest->func, true);
> 
> How about something more precise/readable/portable:
> 
> static bool same_func(struct instruction *insn1, struct instruction *insn2)
> {
> 	return insn1->func->pfunc == insn2->func->pfunc;
> }
> 
> static bool is_first_func_insn(struct instruction *insn)
> {
> 	return insn->offset == insn->func->offset ||
> 	       (insn->type == INSN_ENDBR &&
> 	        insn->offset == insn->func->offset + insn->len);
> }
> 
> 			...
> 
>   			} else if (!same_func(insn, insn->jump_dest) &&
> 				   is_first_func_insn(insn->jump_dest))
> 

Done.

> > +static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn);
> 
> I'd rather avoid forward declares and stay with the existing convention.
> 
> > +
> >  /*
> >   * Follow the branch starting at the given instruction, and recursively follow
> >   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> > @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
> >  
> >  		if (insn->hint) {
> >  			state.cfi = *insn->cfi;
> > +			if (ibt) {
> > +				struct symbol *sym;
> > +
> > +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> > +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> > +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> > +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> > +						  insn->sec, insn->offset,
> > +						  sym->name);
> > +				}
> 
> No need to print sym->name here, WARN_FUNC() already does it?

Almost; perhaps the change to make is to either introduce WARN_SYM or
make WARN_FUNC also print !STT_FUNC symbols ?

> > @@ -3260,7 +3334,12 @@ static int validate_branch(struct objtoo
> >  			state.df = false;
> >  			break;
> >  
> > +		case INSN_NOP:
> > +			break;
> > +
> >  		default:
> > +			if (ibt)
> > +				validate_ibt_insn(file, insn);
> 
> This is kind of subtle.  It would be more robust/clear to move this call
> out of the switch statement and check explicitly for the exclusion of
> jump/call instructions from within validate_ibt_insn().

Can do I suppose.

> >  			break;
> >  		}
> >  
> > @@ -3506,6 +3585,130 @@ static int validate_functions(struct obj
> >  	return warnings;
> >  }
> >  
> > +static struct instruction *
> > +validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> > +{
> > +	struct instruction *dest;
> > +	struct section *sec;
> > +	unsigned long off;
> > +
> > +	sec = reloc->sym->sec;
> > +	off = reloc->sym->offset + reloc->addend;
> 
> This math assumes non-PC-relative.  If it's R_X86_64_PC32 or
> R_X86_64_PLT32 then it needs +4 added.

Right; so I actually had that PC32 thing in there for a while, but ran
into other trouble. I'll go try and figure it out.


> > +static void validate_ibt_target(struct objtool_file *file, struct instruction *insn,
> > +				struct instruction *target)
> > +{
> > +	if (target->func && target->func == insn->func) {
> 
> (Here and elsewhere) Instead of 'target' can we call it 'dest' for
> consistency with existing code?

Done.

> > +		/*
> > +		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
> > +		 *
> > +		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
> > +		 * relocation as a constant and is happy to fold in offsets, skewing any
> > +		 * annotation we do, leading to vast amounts of false-positives.
> > +		 *
> > +		 * There's also compiler generated _THIS_IP_ through KCOV and
> > +		 * such which we have no hope of annotating.
> > +		 *
> > +		 * As such, blanked accept self-references without issue.
> 
> "blanket"

Duh.

> > +static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> > +{
> > +	struct reloc *reloc = insn_reloc(file, insn);
> > +	struct instruction *target;
> > +
> > +	for (;;) {
> > +		if (!reloc)
> > +			return;
> > +
> > +		target = validate_ibt_reloc(file, reloc);
> > +		if (target)
> > +			validate_ibt_target(file, insn, target);
> > +
> > +		reloc = find_reloc_by_dest_range(file->elf, insn->sec, reloc->offset + 1,
> > +						 (insn->offset + insn->len) - (reloc->offset + 1));
> > +	}
> 
> I'm confused about what this loop is trying to do.  Why would an
> instruction have more than one reloc?  It at least needs a comment.

Because there are some :/ 'mov' can have an immediate and a
displacement, both needing a relocation.

> Also a proper for() loop would be easier to follow:
> 
> 	for (reloc = insn_reloc(file, insn);
> 	     reloc;
> 	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
> 					      reloc->offset + 1,
> 					      (insn->offset + insn->len) - (reloc->offset + 1)) {

Sure.

> > +}
> > +
> > +static int validate_ibt(struct objtool_file *file)
> > +{
> > +	struct section *sec;
> > +	struct reloc *reloc;
> > +
> > +	for_each_sec(file, sec) {
> > +		bool is_data;
> > +
> > +		/* already done in validate_branch() */
> > +		if (sec->sh.sh_flags & SHF_EXECINSTR)
> > +			continue;
> > +
> > +		if (!sec->reloc)
> > +			continue;
> > +
> > +		if (!strncmp(sec->name, ".orc", 4))
> > +			continue;
> > +
> > +		if (!strncmp(sec->name, ".discard", 8))
> > +			continue;
> > +
> > +		if (!strncmp(sec->name, ".debug", 6))
> > +			continue;
> > +
> > +		if (!strcmp(sec->name, "_error_injection_whitelist"))
> > +			continue;
> > +
> > +		if (!strcmp(sec->name, "_kprobe_blacklist"))
> > +			continue;
> > +
> > +		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
> > +
> > +		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> > +			struct instruction *target;
> > +
> > +			target = validate_ibt_reloc(file, reloc);
> > +			if (is_data && target && !target->noendbr) {
> > +				warn_noendbr("data ", reloc->sym->sec,
> > +					     reloc->sym->offset + reloc->addend,
> 
> Another case where the addend math would be wrong if it were
> pc-relative.  Not sure if that's possible here or not.

I'll check.
