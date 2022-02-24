Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B284C2FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236449AbiBXPhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbiBXPhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:37:45 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4FC3352
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Li2ym5e5bGLmvOcbwxkBR7B+lbUlnoGsXmnse0xyBVQ=; b=ebNKOZ2K6PtWFV5rWWb5UcEkS6
        GtsGw6+fM0iFmvW0/wfyKKGWDEScN0HC6Zvkj98bK+aGxe4Sjd+MxHRSsRbYKlybLUi7TVxZO3ovI
        6KX26HuaWDdCN5jz6+NY2uiHP3P0ZAPU/ymG2z+m1RRY8vIAj8c4+iW7h6U6HNMy8xh8xKJlHo64v
        zDcNDMcJaSsPOSwB2rPFyWZRwfiL5zVIGD1/bn4u6oDxfpW723NkWA4pZp5Mlp0H39TvbhPmxc1jU
        F9SB9oM6XRWiPKxlgs4MdlqMB1dNUxYXjMnd6ocXlIKqmX80v8Bb8GF8/EYclYMHiiECceZnctVAq
        hb76ri7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNGAs-004tF7-Gj; Thu, 24 Feb 2022 15:36:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B76393000E3;
        Thu, 24 Feb 2022 16:36:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7A723203905CF; Thu, 24 Feb 2022 16:36:57 +0100 (CET)
Date:   Thu, 24 Feb 2022 16:36:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, mhiramat@kernel.org,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 14/39] x86/ibt,ftrace: Make function-graph play nice
Message-ID: <YhemGUoGmrzxuc+C@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.834445396@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.834445396@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:52PM +0100, Peter Zijlstra wrote:
> @@ -316,10 +317,12 @@ SYM_FUNC_START(return_to_handler)
>  
>  	call ftrace_return_to_handler
>  
> -	movq %rax, %rdi
> +	movq %rax, 16(%rsp)
>  	movq 8(%rsp), %rdx
>  	movq (%rsp), %rax
> -	addq $24, %rsp
> -	JMP_NOSPEC rdi
> +
> +	addq $16, %rsp
> +	UNWIND_HINT_FUNC
> +	RET
>  SYM_FUNC_END(return_to_handler)
>  #endif

While talking about this with Mark, an alternative solution is something
like this, that would keep the RSB balanced and only mess up the current
return.

No idea it if makes an appreciatable difference on current hardware,
therefore I went with the simpler option above.

@@ -307,7 +315,7 @@ EXPORT_SYMBOL(__fentry__)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_FUNC_START(return_to_handler)
-	subq  $24, %rsp
+	subq  $16, %rsp
 
 	/* Save the return values */
 	movq %rax, (%rsp)
@@ -319,7 +327,13 @@ SYM_FUNC_START(return_to_handler)
 	movq %rax, %rdi
 	movq 8(%rsp), %rdx
 	movq (%rsp), %rax
-	addq $24, %rsp
-	JMP_NOSPEC rdi
+
+	addq $16, %rsp
+	ANNOTATE_INTRA_FUNCTION_CALL
+	call .Ldo_rop
+.Ldo_rop:
+	mov %rdi, (%rsp)
+	UNWIND_HINT_FUNC
+	RET
 SYM_FUNC_END(return_to_handler)
 #endif


