Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41F4C5919
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiB0DOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiB0DOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4D7F29CBE9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645931635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/26ubjoltjj4CBjusBWCl7axdUNBpCkP32rmYaM0Bg=;
        b=cxniCNbXM97DQbPT8IyS/PMTdPs+5qCrlpGfFpXBpecTAQIaS6RpRmlT1eq1jbkTSBcyED
        vhRnlN9nTghb8zK16yEld1RpHB486q0gnCxlbjuoKr9wzn9G9XDV7TR8cfMX3XbioyngTi
        lJLOpYTtdwwULhGIODtCzFJtt//XvV4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-cxM2WCiHMo2ZK3dSqKe61w-1; Sat, 26 Feb 2022 22:13:53 -0500
X-MC-Unique: cxM2WCiHMo2ZK3dSqKe61w-1
Received: by mail-qv1-f69.google.com with SMTP id g13-20020a0cf08d000000b004329146b1ccso8347929qvk.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:13:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/26ubjoltjj4CBjusBWCl7axdUNBpCkP32rmYaM0Bg=;
        b=WFYZr9zO5hokZ39QCOx7q1Mjc01MA35+k1mQOaeo5qGZkVIn7K61qASMj/s5SNmNRj
         Z1Og6O7j15/fIZ1cMpRM2/GdHBhw7sJW2C3/9Oz0UGPNgUS2KZPGaP28tt3Hnzu8Cd+K
         wtATlmX+5rjbcxj4rqsWhM1aj4jb0AkXMxdiOO1kiyAiORDEXzxy9yDm+NJQdRC42XKg
         5WIekPhP5NqbSGIXdWye/36T2ZX85xASv7jOqnbLRH/g5I1VJI3dE8lvhcnKEMqR+yLD
         yRq7mVAAlNJGz27NpBuvEb3nFOMM9Yyoinphs1s7U+9tR1dgBUO7Kqcf4yOz6Bwtyb2E
         Ycng==
X-Gm-Message-State: AOAM530Zm0Z+sLu+fWGe30TTKaMO2OuKg8da5/Qx/lSbW6lekGhY5aAC
        Xyt40a0SRxa2wdH+fMsepDfgXIJiHHFOKFK+JfzLAWx4/Kk1RYLjknbbyTRGP8oqd3TeMbgPwl/
        4WVSlmfsbr0krbsuIpvLrrDnh
X-Received: by 2002:ac8:7f4c:0:b0:2de:37ad:99b2 with SMTP id g12-20020ac87f4c000000b002de37ad99b2mr12023006qtk.641.1645931632908;
        Sat, 26 Feb 2022 19:13:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy7sse+5hLKCdJRhA+h2qLYIsMKmVEDwjFVlLa+baTXMOsQC7YPuENXppzMWDNCNmJYq/GIBQ==
X-Received: by 2002:ac8:7f4c:0:b0:2de:37ad:99b2 with SMTP id g12-20020ac87f4c000000b002de37ad99b2mr12022995qtk.641.1645931632521;
        Sat, 26 Feb 2022 19:13:52 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id bq42-20020a05620a46aa00b006494fb49246sm3292338qkb.86.2022.02.26.19.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 19:13:51 -0800 (PST)
Date:   Sat, 26 Feb 2022 19:13:48 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 34/39] objtool: Validate IBT assumptions
Message-ID: <20220227031348.drbmkcmoqur53aay@treble>
References: <20220224145138.952963315@infradead.org>
 <20220224151324.018939604@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224151324.018939604@infradead.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:52:12PM +0100, Peter Zijlstra wrote:
> +++ b/tools/objtool/check.c
> @@ -380,6 +380,7 @@ static int decode_instructions(struct ob
>  			memset(insn, 0, sizeof(*insn));
>  			INIT_LIST_HEAD(&insn->alts);
>  			INIT_LIST_HEAD(&insn->stack_ops);
> +			INIT_LIST_HEAD(&insn->call_node);

Is this needed?  'call_node' isn't actually a list head, otherwise this
would presumably be fixing a major bug.

>  			insn->sec = sec;
>  			insn->offset = offset;
> @@ -1176,6 +1177,14 @@ static int add_jump_destinations(struct
>  	unsigned long dest_off;
>  
>  	for_each_insn(file, insn) {
> +		if (insn->type == INSN_ENDBR && insn->func) {
> +			if (insn->offset == insn->func->offset) {
> +				file->nr_endbr++;
> +			} else {
> +				file->nr_endbr_int++;
> +			}
> +		}
> +

This doesn't have much to do with adding jump destinations.  I'm
thinking this would fit better in decode_instructions() in the
sym_for_each_insn() loop.

>  		if (!is_static_jump(insn))
>  			continue;
>  
> @@ -1192,10 +1201,14 @@ static int add_jump_destinations(struct
>  		} else if (insn->func) {
>  			/* internal or external sibling call (with reloc) */
>  			add_call_dest(file, insn, reloc->sym, true);
> -			continue;
> +
> +			dest_sec = reloc->sym->sec;
> +			dest_off = reloc->sym->offset +
> +				   arch_dest_reloc_offset(reloc->addend);
> +
>  		} else if (reloc->sym->sec->idx) {
>  			dest_sec = reloc->sym->sec;
> -			dest_off = reloc->sym->sym.st_value +
> +			dest_off = reloc->sym->offset +
>  				   arch_dest_reloc_offset(reloc->addend);
>  		} else {
>  			/* non-func asm code jumping to another file */
> @@ -1205,6 +1218,10 @@ static int add_jump_destinations(struct
>  		insn->jump_dest = find_insn(file, dest_sec, dest_off);
>  		if (!insn->jump_dest) {
>  
> +			/* external symbol */
> +			if (!vmlinux && insn->func)
> +				continue;
> +
>  			/*
>  			 * This is a special case where an alt instruction
>  			 * jumps past the end of the section.  These are
> @@ -1219,6 +1236,16 @@ static int add_jump_destinations(struct
>  			return -1;
>  		}
>  
> +		if (ibt && insn->jump_dest->type == INSN_ENDBR &&
> +		    insn->jump_dest->func &&
> +		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
> +			if (reloc) {
> +				WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
> +			} else {
> +				WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
> +			}
> +		}
> +

I have several concerns about all the above (and corresponding changes
elsewhere), but it looks like this was moved to separate patches, for
ease of NACKing :-)

>  		/*
>  		 * Cross-function jump.
>  		 */
> @@ -1246,7 +1273,8 @@ static int add_jump_destinations(struct
>  				insn->jump_dest->func->pfunc = insn->func;
>  
>  			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
> -				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
> +				   ((insn->jump_dest->offset == insn->jump_dest->func->offset) ||
> +				    (insn->jump_dest->offset == insn->jump_dest->func->offset + 4))) {
>  				/* internal sibling call (without reloc) */
>  				add_call_dest(file, insn, insn->jump_dest->func, true);

How about something more precise/readable/portable:

static bool same_func(struct instruction *insn1, struct instruction *insn2)
{
	return insn1->func->pfunc == insn2->func->pfunc;
}

static bool is_first_func_insn(struct instruction *insn)
{
	return insn->offset == insn->func->offset ||
	       (insn->type == INSN_ENDBR &&
	        insn->offset == insn->func->offset + insn->len);
}

			...

  			} else if (!same_func(insn, insn->jump_dest) &&
				   is_first_func_insn(insn->jump_dest))


> +static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn);

I'd rather avoid forward declares and stay with the existing convention.

> +
>  /*
>   * Follow the branch starting at the given instruction, and recursively follow
>   * any other branches (jumps).  Meanwhile, track the frame pointer state at
> @@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
>  
>  		if (insn->hint) {
>  			state.cfi = *insn->cfi;
> +			if (ibt) {
> +				struct symbol *sym;
> +
> +				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
> +				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
> +				    insn->type != INSN_ENDBR && !insn->noendbr) {
> +					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
> +						  insn->sec, insn->offset,
> +						  sym->name);
> +				}

No need to print sym->name here, WARN_FUNC() already does it?

> +			}
>  		} else {
>  			/* XXX track if we actually changed state.cfi */
>  
> @@ -3260,7 +3334,12 @@ static int validate_branch(struct objtoo
>  			state.df = false;
>  			break;
>  
> +		case INSN_NOP:
> +			break;
> +
>  		default:
> +			if (ibt)
> +				validate_ibt_insn(file, insn);

This is kind of subtle.  It would be more robust/clear to move this call
out of the switch statement and check explicitly for the exclusion of
jump/call instructions from within validate_ibt_insn().

>  			break;
>  		}
>  
> @@ -3506,6 +3585,130 @@ static int validate_functions(struct obj
>  	return warnings;
>  }
>  
> +static struct instruction *
> +validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
> +{
> +	struct instruction *dest;
> +	struct section *sec;
> +	unsigned long off;
> +
> +	sec = reloc->sym->sec;
> +	off = reloc->sym->offset + reloc->addend;

This math assumes non-PC-relative.  If it's R_X86_64_PC32 or
R_X86_64_PLT32 then it needs +4 added.

There are actually a few cases of this in startup_64().  Those are
harmless, but there might conceivably be other code which isn't?

> +
> +	dest = find_insn(file, sec, off);
> +	if (!dest)
> +		return NULL;
> +
> +	if (dest->type == INSN_ENDBR)
> +		return NULL;
> +
> +	if (reloc->sym->static_call_tramp)
> +		return NULL;
> +
> +	return dest;
> +}
> +
> +static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
> +			 struct instruction *target)
> +{
> +	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
> +		  target->func ? target->func->name : target->sec->name,
> +		  target->func ? target->offset - target->func->offset : target->offset);
> +}
> +
> +static void validate_ibt_target(struct objtool_file *file, struct instruction *insn,
> +				struct instruction *target)
> +{
> +	if (target->func && target->func == insn->func) {

(Here and elsewhere) Instead of 'target' can we call it 'dest' for
consistency with existing code?

> +		/*
> +		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
> +		 *
> +		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
> +		 * relocation as a constant and is happy to fold in offsets, skewing any
> +		 * annotation we do, leading to vast amounts of false-positives.
> +		 *
> +		 * There's also compiler generated _THIS_IP_ through KCOV and
> +		 * such which we have no hope of annotating.
> +		 *
> +		 * As such, blanked accept self-references without issue.

"blanket"

> +		 */
> +		return;
> +	}
> +
> +	/*
> +	 * Annotated non-control flow target.
> +	 */
> +	if (target->noendbr)
> +		return;

I don't think the comment really adds anything.  What's a "non-control
flow target" anyway...

> +
> +	warn_noendbr("", insn->sec, insn->offset, target);
> +}
> +
> +static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
> +{
> +	struct reloc *reloc = insn_reloc(file, insn);
> +	struct instruction *target;
> +
> +	for (;;) {
> +		if (!reloc)
> +			return;
> +
> +		target = validate_ibt_reloc(file, reloc);
> +		if (target)
> +			validate_ibt_target(file, insn, target);
> +
> +		reloc = find_reloc_by_dest_range(file->elf, insn->sec, reloc->offset + 1,
> +						 (insn->offset + insn->len) - (reloc->offset + 1));
> +	}

I'm confused about what this loop is trying to do.  Why would an
instruction have more than one reloc?  It at least needs a comment.

Also a proper for() loop would be easier to follow:

	for (reloc = insn_reloc(file, insn);
	     reloc;
	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
					      reloc->offset + 1,
					      (insn->offset + insn->len) - (reloc->offset + 1)) {

> +}
> +
> +static int validate_ibt(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct reloc *reloc;
> +
> +	for_each_sec(file, sec) {
> +		bool is_data;
> +
> +		/* already done in validate_branch() */
> +		if (sec->sh.sh_flags & SHF_EXECINSTR)
> +			continue;
> +
> +		if (!sec->reloc)
> +			continue;
> +
> +		if (!strncmp(sec->name, ".orc", 4))
> +			continue;
> +
> +		if (!strncmp(sec->name, ".discard", 8))
> +			continue;
> +
> +		if (!strncmp(sec->name, ".debug", 6))
> +			continue;
> +
> +		if (!strcmp(sec->name, "_error_injection_whitelist"))
> +			continue;
> +
> +		if (!strcmp(sec->name, "_kprobe_blacklist"))
> +			continue;
> +
> +		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
> +
> +		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
> +			struct instruction *target;
> +
> +			target = validate_ibt_reloc(file, reloc);
> +			if (is_data && target && !target->noendbr) {
> +				warn_noendbr("data ", reloc->sym->sec,
> +					     reloc->sym->offset + reloc->addend,

Another case where the addend math would be wrong if it were
pc-relative.  Not sure if that's possible here or not.

-- 
Josh

