Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769CB57A906
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237986AbiGSVdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiGSVda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:33:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869352441
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RrOcKS4/BXSdepJnpia2FEqhNk3eb/NqhM77HuERpY=; b=L4jcOCWxLSfLmL/TDdV435r+za
        LkZyNaSoX72sjpfkSB9YfIUEvQZmjpM715/h6goSZTK8zRrNfTs6JWXtUvu6/ZiSiZfUWhFKxFK5o
        AQgLPYBaGcEw+cE8mxtbgdg9L7HdxF3a3SbXcySJMyAz3/emMDznbOTDa7gSK4NKmv81SF8rirLrB
        08OM2M6KrSJzWrjP4TCeBIcNXWimL5r8JsZ7kjEnUW/s2zQvkkRlaCmpAip656hA+VsCi103tWKxz
        2YKq1Tprnd9fktRwOUSYvQieEQAPR7MeO5OqX4OZszlKUWh/OBzraB8haSrU6T579B5wf5y1wDhd3
        OrWE6Ycg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDuq1-00Dtkj-Bn; Tue, 19 Jul 2022 21:33:05 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id F32FF9802BB; Tue, 19 Jul 2022 23:33:04 +0200 (CEST)
Date:   Tue, 19 Jul 2022 23:33:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        hjl.tools@gmail.com, andrew.cooper3@citrix.com,
        mark.rutland@arm.com, will@kernel.org, ndesaulniers@google.com,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Subject: Re: [RFC][PATCH] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <YtcjEEpfvYmvHjmE@worktop.programming.kicks-ass.net>
References: <20211204134338.760603010@infradead.org>
 <20211204134908.140103474@infradead.org>
 <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
 <Ytcguqp+/aTiOcnN@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytcguqp+/aTiOcnN@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 11:23:07PM +0200, Peter Zijlstra wrote:
> Subject: x86,nospec: Simplify {JMP,CALL}_NOSPEC
> 
> Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
> calls and rely on the objtool retpoline patching infrastructure.
> 
> There's no reason these should be alternatives while the vast bulk of
> compiler generated retpolines are not.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index 10a3bfc1eb23..7bb319d2932c 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -93,6 +93,19 @@
>  #endif
>  .endm
>  
> +/*
> + * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
> + * to the retpoline thunk with a CS prefix when the register requires
> + * a RAX prefix byte to encode. Also see apply_alternatives().

Obviously I meant: apply_retpolines() ...

> + */
> +.macro __CS_PREFIX reg:req
> +	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
> +	.ifc \reg,\rs
> +	.byte 0x2e
> +	.endif
> +	.endr
> +.endm
> +
>  /*
>   * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
>   * indirect jmp/call which may be susceptible to the Spectre variant 2
> @@ -100,19 +113,18 @@
>   */
>  .macro JMP_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> -		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
> -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
> +	__CS_PREFIX \reg
> +	jmp	__x86_indirect_thunk_\reg
>  #else
>  	jmp	*%\reg
> +	int3
>  #endif
>  .endm
>  
>  .macro CALL_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
> -		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
> -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_LFENCE
> +	__CS_PREFIX \reg
> +	call	__x86_indirect_thunk_\reg
>  #else
>  	call	*%\reg
>  #endif
