Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE6C4AE578
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiBHXdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbiBHXdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:33:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2DC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:33:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id m7so632583pjk.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xX25dTQaes3Vtbf2vIrnkeE30pwP3qXb68DjPMbMqnQ=;
        b=Pr1N/OG+9cbdJ4ZUfUqcmkElsbUq/bH53Nd9zaUTbobsX4wW1z8QhrLggqiqz0buVJ
         UmvG6W4ZTj1sr+qEEaxd4CU3FBzqDbvnRxPdmsamj1PZmPK7aLPPbABqkKnGk/0R3/eX
         OJDJnuzcu8rk2f8FTfjzG8B2hhGmJs60rZhKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xX25dTQaes3Vtbf2vIrnkeE30pwP3qXb68DjPMbMqnQ=;
        b=vApb0cZedqX/alBKTyalYhg0QP17Aq6rwApzts9GGiZ43jIRMI34tR2o/NkgY8FpBt
         nwnCxMz4226snyqoceQHSS8b7Yw/9uIcAiToBR+c5W4UXI42l5L8/Wz4Y32W2nqh3G4k
         0TRuDhUggDhqU4TWxCTJ63GCF/oVW0ji/mN1p3i3/7p9iXatwsoxkG1I8yZMQ7Wmx8a3
         eUFKdRnSjjm3rxQ9winTIv4H68ctNrhJGGaDYa+tR4PCK8fFg1rNXLOIFXSQTeawuriz
         ZtSA0B+xRoHjY+sjHK1Jcx9vkHdJxo9K1UCcY9M1JtceYibyZ6uOlQekdSHgwucwHfmK
         6nUA==
X-Gm-Message-State: AOAM531klgE2zOxfqtBm9bB+JxrAvON9zvQIuUhEU0jmEp5kx7fH/UQg
        K5OcUh7Jslx643pB2aANhHdllg==
X-Google-Smtp-Source: ABdhPJxXU0+poAvY8WRSulnaMluv/E3tE5DArJAuliiCQpTA4wW7v8hQc3tHyYvgMHSLcBHMJhu11Q==
X-Received: by 2002:a17:90b:30cf:: with SMTP id hi15mr394480pjb.30.1644363225109;
        Tue, 08 Feb 2022 15:33:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a22sm10816042pfv.185.2022.02.08.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:33:44 -0800 (PST)
Date:   Tue, 8 Feb 2022 15:33:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 3/6] x86: Add ENDBR to IRET-to-Self
Message-ID: <202202081533.C5FB668@keescook>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.149482391@infradead.org>
 <20211122180947.GA721624@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122180947.GA721624@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 07:09:47PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 22, 2021 at 06:03:04PM +0100, Peter Zijlstra wrote:
> > The IRET-to-Self chunks trigger forward code references without ENDBR,
> > fix that.
> 
> Andy corrected me, IRET doesn't take ENBR, the alternative is the below.

Okay, good. I was scratching my head for a second there. :)

-Kees

> 
> ---
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1316,7 +1316,6 @@ SYM_CODE_START(asm_exc_nmi)
>  	iretq			/* continues at repeat_nmi below */
>  	UNWIND_HINT_IRET_REGS entry=0
>  1:
> -	ENDBR
>  #endif
>  
>  repeat_nmi:
> --- a/arch/x86/include/asm/sync_core.h
> +++ b/arch/x86/include/asm/sync_core.h
> @@ -6,7 +6,6 @@
>  #include <asm/processor.h>
>  #include <asm/cpufeature.h>
>  #include <asm/special_insns.h>
> -#include <asm/ibt.h>
>  
>  #ifdef CONFIG_X86_32
>  static inline void iret_to_self(void)
> @@ -35,7 +34,6 @@ static inline void iret_to_self(void)
>  		"pushq $1f\n\t"
>  		"iretq\n\t"
>  		"1:"
> -		ASM_ENDBR
>  		: "=&r" (tmp), ASM_CALL_CONSTRAINT : : "cc", "memory");
>  }
>  #endif /* CONFIG_X86_32 */
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -598,6 +598,7 @@ int arch_decode_instruction(struct objto
>  				op->dest.type = OP_DEST_REG;
>  				op->dest.reg = CFI_SP;
>  			}
> +			*type = INSN_IRET;
>  			break;
>  		}
>  
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3587,7 +3587,7 @@ static int validate_ibt_reloc(struct obj
>  static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
>  {
>  	struct reloc *reloc = insn_reloc(file, insn);
> -	struct instruction *target;
> +	struct instruction *target, *n;
>  	unsigned long offset;
>  
>  	if (!reloc)
> @@ -3599,8 +3599,16 @@ static void validate_ibt_insn(struct obj
>  	offset = reloc->sym->offset + reloc->addend;
>  
>  	target = find_insn(file, reloc->sym->sec, offset);
> -	if (target && insn->func == target->func && target->this_ip)
> -		return;
> +	if (target && insn->func == target->func) {
> +		if (target->this_ip)
> +			return;
> +
> +		for (n = insn; n->offset <= target->offset;
> +		     n = next_insn_same_func(file, n)) {
> +			if (n->type == INSN_IRET)
> +				return;
> +		}
> +	}
>  
>  	WARN_FUNC("relocation to !ENDBR: %s+0x%lx",
>  		  insn->sec, insn->offset,
> --- a/tools/objtool/include/objtool/arch.h
> +++ b/tools/objtool/include/objtool/arch.h
> @@ -27,6 +27,7 @@ enum insn_type {
>  	INSN_STD,
>  	INSN_CLD,
>  	INSN_ENDBR,
> +	INSN_IRET,
>  	INSN_OTHER,
>  };
>  

-- 
Kees Cook
