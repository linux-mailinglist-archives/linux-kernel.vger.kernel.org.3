Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C5501B90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243356AbiDNTEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiDNTEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:04:32 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0797E9CA6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7Gtvh+XmNw/2pO9Tbmi5/yhRnGmCojLBbzbV+uUaWf8=; b=kQm1JgtPjs9+xaYrSz0aiArWG3
        KtdN0jXjEoD1aSFEyuaGkmqgyVOfrqiilYJPfkG1Efm9n9qZGiQWejb+fVdbYPNGwB30EjpBwvTh9
        v/ERxSnDjHk+oyA06/MsLO5I0e0ufv9ybcQlmdKZkj1VNq1pQfRHEnTguR8Z2iUhryk/eN1oW4jho
        EvE/eVbqsHkC4Og0BwEB/HGwgHVBnbfBTwg/twtW7oQVeH72Q3syjbtwhND3aRJBaj5UzMaN4vQkp
        N++sRJinIj8TDPWb8u5GLJugM3mBSL5VTuAQEeBpYs/I36zfTgNkwUWRPi1dhjBdoJFxUVYmQwSVP
        JJA1fqlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf4j8-0056RV-Pl; Thu, 14 Apr 2022 19:01:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D565130027B;
        Thu, 14 Apr 2022 21:01:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B555A322A1704; Thu, 14 Apr 2022 21:01:56 +0200 (CEST)
Date:   Thu, 14 Apr 2022 21:01:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <YlhvpGsUFIOLByhp@hirez.programming.kicks-ass.net>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
 <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
 <20220414170550.v2jmdfhmz7zbuug6@treble>
 <20220414182505.oirx3znjl7ceozq3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414182505.oirx3znjl7ceozq3@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:25:05AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 14, 2022 at 10:05:53AM -0700, Josh Poimboeuf wrote:
> > On Thu, Apr 14, 2022 at 06:38:16PM +0200, Peter Zijlstra wrote:
> > > On Thu, Apr 14, 2022 at 08:44:49AM -0700, Josh Poimboeuf wrote:
> > > 
> > > > Ok.  That was subtle, it needs a comment or two.  I had the distinct
> > > > feeling I was introducing a bug, then I got distracted ;-)
> > > 
> > > Right, lemme try and not forget to write one ;-)
> > 
> > I'm rewriting the code anyway, I'll add some comments.
> > 
> > > > Doesn't the compiler give those special cases ENDBR anyway?  Just
> > > > wondering why we avoid the warning for those.
> > > 
> > > Sure, but this is about not scribbling that ENDBR with a NOP.
> > 
> > Right, but it only prints warnings for data sections, despite marking
> > others:
> > 
> > -                       dest = validate_ibt_reloc(file, reloc);
> > -                       if (is_data && dest && !dest->noendbr)
> > -                               warn_noendbr("data ", sec, reloc->offset, dest);
> 
> 
> How about this?  This way it doesn't silence warnings for non
> .data/.rodata, as other sections (including ksymtab) can also have valid
> function pointers.  It also caught a bug(?) in putuser.S, as some of the
> exported inner labels didn't have ENDBR.
> 
> 
> diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
> index 2455d721503e..2d8dacd02643 100644
> --- a/arch/x86/include/asm/static_call.h
> +++ b/arch/x86/include/asm/static_call.h
> @@ -26,6 +26,7 @@
>  	    ".align 4						\n"	\
>  	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
>  	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
> +	    ANNOTATE_NOENDBR						\
>  	    insns "						\n"	\
>  	    ".byte 0x53, 0x43, 0x54				\n"	\
>  	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\

Right, that makes more sense than hard-coding that exclusion, no idea
what I was thinking ;-)

> diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
> index ecb2049c1273..b7dfd60243b7 100644
> --- a/arch/x86/lib/putuser.S
> +++ b/arch/x86/lib/putuser.S
> @@ -48,6 +48,7 @@ SYM_FUNC_START(__put_user_1)
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
>  SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
> +	ENDBR
>  	ASM_STAC
>  1:	movb %al,(%_ASM_CX)
>  	xor %ecx,%ecx
> @@ -62,6 +63,7 @@ SYM_FUNC_START(__put_user_2)
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
>  SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
> +	ENDBR
>  	ASM_STAC
>  2:	movw %ax,(%_ASM_CX)
>  	xor %ecx,%ecx
> @@ -76,6 +78,7 @@ SYM_FUNC_START(__put_user_4)
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
>  SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
> +	ENDBR
>  	ASM_STAC
>  3:	movl %eax,(%_ASM_CX)
>  	xor %ecx,%ecx
> @@ -90,6 +93,7 @@ SYM_FUNC_START(__put_user_8)
>  	cmp %_ASM_BX,%_ASM_CX
>  	jae .Lbad_put_user
>  SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
> +	ENDBR
>  	ASM_STAC
>  4:	mov %_ASM_AX,(%_ASM_CX)
>  #ifdef CONFIG_X86_32

Hmm, how did those go missing?

> diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
> index 5f87bab4fb8d..b2b2366885a2 100644
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -31,6 +31,7 @@
>  	.align RETPOLINE_THUNK_SIZE
>  SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR
>  
>  	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
>  		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
> @@ -55,7 +56,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
>  
>  	.align RETPOLINE_THUNK_SIZE
>  SYM_CODE_START(__x86_indirect_thunk_array)
> -	ANNOTATE_NOENDBR // apply_retpolines
>  
>  #define GEN(reg) THUNK reg
>  #include <asm/GEN-for-each-reg.h>

Hmm, where does that come from? Do you have commit be8a096521ca
("x86,bpf: Avoid IBT objtool warning")?

> diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
> index ac17196e2518..3a2cd93bf059 100644
> --- a/arch/x86/xen/xen-head.S
> +++ b/arch/x86/xen/xen-head.S
> @@ -45,6 +45,7 @@ SYM_CODE_END(hypercall_page)
>  	__INIT
>  SYM_CODE_START(startup_xen)
>  	UNWIND_HINT_EMPTY
> +	ANNOTATE_NOENDBR
>  	cld
>  
>  	/* Clear .bss */
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index b09c416432b6..10e375c84088 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3794,7 +3794,10 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
>  	return 1;
>  }
>  
> -
> +/*
> + * Validate IBT rules and mark used ENDBR instructions so the non-used ones can
> + * be sealed later by create_ibt_endbr_seal_sections().
> + */
>  static int validate_ibt(struct objtool_file *file)
>  {
>  	struct section *sec;
> @@ -3807,12 +3810,36 @@ static int validate_ibt(struct objtool_file *file)
>  
>  	for_each_sec(file, sec) {
>  
> -		if (!strstr(sec->name, ".data") && !strstr(sec->name, ".rodata"))
> +		/* Already done by validate_ibt_insn() */
> +		if (sec->sh.sh_flags & SHF_EXECINSTR)
>  			continue;
>  
>  		if (!sec->reloc)
>  			continue;
>  
> +		/*
> +		 * These sections can reference text addresses, but not with
> +		 * the intent to indirect branch to them.
> +		 */
> +		if (!strncmp(sec->name, ".discard", 8)			||
> +		    !strncmp(sec->name, ".debug", 6)			||
> +		    !strcmp(sec->name, ".altinstructions")		||
> +		    !strcmp(sec->name, ".ibt_endbr_seal")		||
> +		    !strcmp(sec->name, ".orc_unwind_ip")		||
> +		    !strcmp(sec->name, ".parainstructions")		||
> +		    !strcmp(sec->name, ".retpoline_sites")		||
> +		    !strcmp(sec->name, ".smp_locks")			||
> +		    !strcmp(sec->name, ".static_call_sites")		||
> +		    !strcmp(sec->name, ".static_call_tramp_key")	||
> +		    !strcmp(sec->name, "_error_injection_whitelist")	||
> +		    !strcmp(sec->name, "_kprobe_blacklist")		||
> +		    !strcmp(sec->name, "__bug_table")			||
> +		    !strcmp(sec->name, "__ex_table")			||
> +		    !strcmp(sec->name, "__jump_table")			||
> +		    !strcmp(sec->name, "__mcount_loc")			||
> +		    !strcmp(sec->name, "__tracepoints"))
> +			continue;
> +
>  		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
>  			warnings += validate_ibt_data_reloc(file, reloc);
>  	}
> 

Yes, looks good, Thanks!
