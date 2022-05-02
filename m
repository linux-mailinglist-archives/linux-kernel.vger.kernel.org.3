Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F835177D8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 22:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387263AbiEBUVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 16:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352110AbiEBUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 16:21:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0EFBF73
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 13:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Llu4EhFfyri9boZWF9UgcWQJbPBw0lrtewWWD268xjw=; b=R5Zfmcz6hlUxJGb+EcNuY6xfWQ
        W2uFkszEspHYYH4k/j//5ejjaFiYqYYx2dyd7OqN4mUGQZXR8lLvxPkAsdx1JPQ9O0aXy45hK8/YS
        hiAuL6q2HZMGfYnAze0Li6lTT2nAZbQMpsdzSXw4C0RtmIcEa8BJC4oGkRpyxoBq7FV3QxihZVR8v
        2QmLaiIrnf3bjX15vZZW6eI8I94IpAxYF6wbMxrhZEyViXR9z83bOZZ00Oa0J6UbPQEJsB2gIdzfP
        4oVRcZwYQ73PbZbuzI/c+iVuzS9MmWB6b6me4iZ45HnrSr09Lu3gGeE49BJUhCF0xL87GxV5blKsc
        8MxI3r6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nlcUG-00AZn4-6h; Mon, 02 May 2022 20:17:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD663300091;
        Mon,  2 May 2022 22:17:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B891220288CEB; Mon,  2 May 2022 22:17:39 +0200 (CEST)
Date:   Mon, 2 May 2022 22:17:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <YnA8Yw19AQV28w54@hirez.programming.kicks-ass.net>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
 <20220502181547.fzz2yre2p4akph4s@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220502181547.fzz2yre2p4akph4s@treble>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2022 at 11:15:47AM -0700, Josh Poimboeuf wrote:

> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/speculation: Mitigate SLS for JMP_NOSPEC with retpolines disabled
> 
> Having disabled retpolines doesn't necessarily mean the user doesn't
> care about straight-line speculation.  For example, retpolines are
> disabled when eIBRS is used.
> 
> If CONFIG_SLS is enabled, properly mitigate SLS for JMP_NOSPEC for the
> retpolines disabled cases.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/include/asm/nospec-branch.h | 13 ++++++++++---
>  tools/objtool/check.c                |  3 ---
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
> index acbaeaf83b61..0648746bf60b 100644
> --- a/arch/x86/include/asm/nospec-branch.h
> +++ b/arch/x86/include/asm/nospec-branch.h
> @@ -75,6 +75,13 @@
>  	.popsection
>  .endm
>  
> +.macro INDIRECT_JMP reg
> +	jmp *%\reg
> +#ifdef CONFIG_SLS
> +	int3
> +#endif
> +.endm
> +
>  /*
>   * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
>   * indirect jmp/call which may be susceptible to the Spectre variant 2
> @@ -82,11 +89,11 @@
>   */
>  .macro JMP_NOSPEC reg:req
>  #ifdef CONFIG_RETPOLINE
> -	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> +	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), \
>  		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
> -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
> +		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), X86_FEATURE_RETPOLINE_LFENCE
>  #else
> -	jmp	*%\reg
> +	INDIRECT_JMP \reg
>  #endif
>  .endm
>  
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index e7983c3e2408..3cf3ad0b5db5 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3842,9 +3842,6 @@ static int validate_sls(struct objtool_file *file)
>  	for_each_insn(file, insn) {
>  		next_insn = next_insn_same_sec(file, insn);
>  
> -		if (insn->retpoline_safe)
> -			continue;
> -
>  		switch (insn->type) {
>  		case INSN_RETURN:
>  			if (!next_insn || next_insn->type != INSN_TRAP) {

Yes, agreed. But perhaps with something like this on top?

---
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 3c66073e7645..84beeb5297d5 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -452,6 +452,17 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		return ret;
 	i += ret;
 
+#ifdef CONFIG_SLS
+	/*
+	 * Ideally this would be unconditional, except in case of
+	 * RETPOLINE_LFENCE we don't have sufficient space. Additionally,
+	 * -mharden-sls=all should be extended to emit INT3 after
+	 * direct jumps too, which will then cover that case.
+	 */
+	if (i < insn->length)
+		bytes[i++] = INT3_INSN_OPCODE;
+#endif
+
 	for (; i < insn->length;)
 		bytes[i++] = BYTES_NOP1;
 
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index b2b2366885a2..26e742da3129 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -33,9 +33,9 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
 	ANNOTATE_NOENDBR
 
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_LFENCE
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), X86_FEATURE_RETPOLINE_LFENCE
 
 .endm
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 16b6efacf7c6..6929856e7f6d 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -418,6 +418,10 @@ static void emit_indirect_jump(u8 **pprog, int reg, u8 *ip)
 #endif
 	EMIT2(0xFF, 0xE0 + reg);
 
+#ifdef CONFIG_SLS
+	EMIT1(0xCC);
+#endif
+
 	*pprog = prog;
 }
 
