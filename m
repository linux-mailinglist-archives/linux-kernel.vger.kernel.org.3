Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491224BC386
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240401AbiBSAhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:37:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236378AbiBSAhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B03522BE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645231001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4R6Nn11eH8+HMB0b4SrukdKf7xIJbg0Fr7rSklqR4uI=;
        b=FncBDrPEzvev3V29CFPAG/Ce0HncI2RPAXPpvgQDUHLvtDDDuP9Q3qXj8Ngg6EoUztWImV
        mWDWKEvlXJynLcaK0wU4o+vtmnrsV93mqITkT0ZrXOpCjEbGN7qrYFHe8qqHaG6XeigcAp
        Kwj7muSk6fBZItJrWr9wJcgzbj/a3dw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-N87-YzpKP_OONnP2L23Maw-1; Fri, 18 Feb 2022 19:36:39 -0500
X-MC-Unique: N87-YzpKP_OONnP2L23Maw-1
Received: by mail-oo1-f72.google.com with SMTP id k10-20020a4ad98a000000b003185c75574dso2047784oou.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4R6Nn11eH8+HMB0b4SrukdKf7xIJbg0Fr7rSklqR4uI=;
        b=ABkjOIR5O3hjDczV+I9vakUhRIRqIrQloz1G4JukdoOtpvQjI2f6np0CaaUNtsHfoo
         n6a4VSi7/xISiXsKRCP+JCJPXzdqWDuXVxtMOCPa10X0VqYmqmQHY/mZCPgtqoaA8VgD
         dkp5NrHHWyhrq9wtfWcjhgM3cmEOa40mLLuos5C8L5LkuR/QHEjYHzL/z7B8Wp8Bz1Lr
         a+L4K61k1hBLaI7Yw7toAVnUMhT5IJ/YNYb1FjA3vykeQUbpjmVgEhfQdNn+ilHq9SjD
         qEziZZkY8pthg1Aau6YXlRfxOYEABlzLjhAKs5Y0GjK3szJ+IO2INWr7Mh5yCB2lRV0X
         scaw==
X-Gm-Message-State: AOAM530qSktVHv71vUV66uerz60gyNsRNUSTguAkNFAUwDjx34Eee1Bf
        bpXabDKTeA3bExGXxpafzL0ZVy7hejghFduT8UlpTJxFn01B1Dzes+5jTIlyClORWN3mwK2lQxp
        esSjfFFtv478exX67+dNWeGHM
X-Received: by 2002:a05:6870:670e:b0:ce:c0c9:65e with SMTP id gb14-20020a056870670e00b000cec0c9065emr5238980oab.176.1645230999235;
        Fri, 18 Feb 2022 16:36:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVQAV0jYbKSuL0O+UVjJH7dbgQLS9Ip6HL2HCFjohnDMGLVGpM+Wp2cF1Sm3oJXvJYctjbyQ==
X-Received: by 2002:a05:6870:670e:b0:ce:c0c9:65e with SMTP id gb14-20020a056870670e00b000cec0c9065emr5238970oab.176.1645230998830;
        Fri, 18 Feb 2022 16:36:38 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id r204sm2740878oih.1.2022.02.18.16.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:36:38 -0800 (PST)
Date:   Fri, 18 Feb 2022 16:36:35 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: Re: [PATCH 07/29] x86/entry: Sprinkle ENDBR dust
Message-ID: <20220219003635.uhzrzsuy5pjtp5jm@treble>
References: <20220218164902.008644515@infradead.org>
 <20220218171408.984834165@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218171408.984834165@infradead.org>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 05:49:09PM +0100, Peter Zijlstra wrote:
> -	.align 8
> +
> +	.align IDT_ALIGN
>  SYM_CODE_START(irq_entries_start)
>      vector=FIRST_EXTERNAL_VECTOR
>      .rept NR_EXTERNAL_VECTORS
> -	UNWIND_HINT_IRET_REGS
> +	UNWIND_HINT_IRET_REGS entry=1
>  0 :
> +	ENDBR
>  	.byte	0x6a, vector
>  	jmp	asm_common_interrupt
> -	nop
>  	/* Ensure that the above is 8 bytes max */

"IDT_ALIGN bytes max" ?

> -	. = 0b + 8
> +	.fill 0b + IDT_ALIGN - ., 1, 0x90
>  	vector = vector+1
>      .endr
>  SYM_CODE_END(irq_entries_start)
>  
>  #ifdef CONFIG_X86_LOCAL_APIC
> -	.align 8
> +	.align IDT_ALIGN
>  SYM_CODE_START(spurious_entries_start)
>      vector=FIRST_SYSTEM_VECTOR
>      .rept NR_SYSTEM_VECTORS
> -	UNWIND_HINT_IRET_REGS
> +	UNWIND_HINT_IRET_REGS entry=1
>  0 :
> +	ENDBR
>  	.byte	0x6a, vector
>  	jmp	asm_spurious_interrupt
> -	nop
>  	/* Ensure that the above is 8 bytes max */

Ditto

> -	. = 0b + 8
> +	.fill 0b + IDT_ALIGN - ., 1, 0x90
>  	vector = vector+1
>      .endr

>  SYM_CODE_END(spurious_entries_start)
> --- a/arch/x86/include/asm/segment.h
> +++ b/arch/x86/include/asm/segment.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/const.h>
>  #include <asm/alternative.h>
> +#include <asm/ibt.h>
>  
>  /*
>   * Constructor for a conventional segment GDT (or LDT) entry.
> @@ -275,7 +276,11 @@ static inline void vdso_read_cpunode(uns
>   * vector has no error code (two bytes), a 'push $vector_number' (two
>   * bytes), and a jump to the common entry code (up to five bytes).
>   */
> +#ifdef CONFIG_X86_IBT
> +#define EARLY_IDT_HANDLER_SIZE 13
> +#else
>  #define EARLY_IDT_HANDLER_SIZE 9
> +#endif

Might want to add a sentence to the comment above: With IDT enabled,
ENDBR adds another four bytes.

>  /*
>   * xen_early_idt_handler_array is for Xen pv guests: for each entry in
> --- a/arch/x86/include/asm/unwind_hints.h
> +++ b/arch/x86/include/asm/unwind_hints.h
> @@ -11,7 +11,7 @@
>  	UNWIND_HINT sp_reg=ORC_REG_UNDEFINED type=UNWIND_HINT_TYPE_CALL end=1
>  .endm
>  
> -.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0
> +.macro UNWIND_HINT_REGS base=%rsp offset=0 indirect=0 extra=1 partial=0 entry=1
>  	.if \base == %rsp
>  		.if \indirect
>  			.set sp_reg, ORC_REG_SP_INDIRECT
> @@ -33,9 +33,17 @@
>  	.set sp_offset, \offset
>  
>  	.if \partial
> -		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
> +		.if \entry
> +		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
> +		.else
> +		.set type, UNWIND_HINT_TYPE_REGS_EXIT
> +		.endif
>  	.elseif \extra == 0
> -		.set type, UNWIND_HINT_TYPE_REGS_PARTIAL
> +		.if \entry
> +		.set type, UNWIND_HINT_TYPE_REGS_ENTRY
> +		.else
> +		.set type, UNWIND_HINT_TYPE_REGS_EXIT
> +		.endif
>  		.set sp_offset, \offset + (16*8)

'extra' is apparently no longer needed and can be shown the door.

-- 
Josh

