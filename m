Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4136C51765E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 20:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386809AbiEBSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiEBSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 14:19:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E746E1F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651515352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=epUA9W1bsIXNwUgl2HYw+NvnSlY06rrcwcViZej6KSU=;
        b=QzKmhciyjAipRY8h6wf+viWjyUT1UEGmI7VX+vs80JbuclRcobGImFF2T2ZT4FtRtSHGA/
        l3fquuuxKS3fc7E+hQhOJyUn2QHqsmE+MNYPTtCLzrTOVV7zL/d2pZzETC0W2gmiMMX5Hw
        u9ywMQfU1DSXfE1G8tmBURCwtszjfEc=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-kb8YTdE_NjmYh3pWzZ87VA-1; Mon, 02 May 2022 14:15:51 -0400
X-MC-Unique: kb8YTdE_NjmYh3pWzZ87VA-1
Received: by mail-qt1-f200.google.com with SMTP id a20-20020a05622a02d400b002f390c55f36so8602790qtx.16
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 11:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=epUA9W1bsIXNwUgl2HYw+NvnSlY06rrcwcViZej6KSU=;
        b=hDAn9RNXRJRIXovYhgoxnKnTcrS+ouk8eazbVOUPYPtbMCBXhAtmslfIosxSDrjmUz
         sJZ6DR05COlbckc9Q3KmFm8wvFJoqnu+HCJcn0RxFlNg/fu8khL/O/TXXiIK3YNg5PhT
         3qmzAbsN1Cq8gC3Lahi2kctRCrFNJX23+glum82pkdgF1JOFICTVoQ4SZg1vbsRMJNcQ
         dyC8v0CdVQO1NMS/dN/8WOl1vIaluCqddBvE0pYWdngnrv8PjlmgCZLAj4uA3Q7RExeN
         Sxj+wyBntrnc4IibxpTAS955g/zT3e0yHK/Qzzkjw1BB0AXCemYPrbNk4zzfvLB/MLpS
         H5mQ==
X-Gm-Message-State: AOAM531+S608QXbFr5qvlcH86ppAUjtuQO6oKrJoKH9JVWNb456H/1bs
        YbMdd7haRlG7KCZ7AoJI1ErjhN+Kyl73i6MOdpqWWKBzvZUqMe86vuR+6cD2tgsRYzZMwOBc5eW
        Mu1JSXstMfapkhuIxRYXWjGWi
X-Received: by 2002:a05:620a:2941:b0:69f:fda4:9ba7 with SMTP id n1-20020a05620a294100b0069ffda49ba7mr183220qkp.435.1651515351035;
        Mon, 02 May 2022 11:15:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqQZHbiej89J6ibYm9zWkLDeKxMVX0oYh0s2MaJATifMEcrIjUpz1YBul1Cvd3jOjwN6FpYg==
X-Received: by 2002:a05:620a:2941:b0:69f:fda4:9ba7 with SMTP id n1-20020a05620a294100b0069ffda49ba7mr183204qkp.435.1651515350736;
        Mon, 02 May 2022 11:15:50 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::a])
        by smtp.gmail.com with ESMTPSA id h10-20020ac8744a000000b002f39b99f695sm4467623qtr.47.2022.05.02.11.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 11:15:50 -0700 (PDT)
Date:   Mon, 2 May 2022 11:15:47 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] objtool: Fix SLS checks
Message-ID: <20220502181547.fzz2yre2p4akph4s@treble>
References: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Ym0UWja2L40QbgEc@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 12:50:02PM +0200, Peter Zijlstra wrote:
> 
> Fix the SLS validation; not having a next instruction is also a fail
> when the next instruction should be INSN_TRAP.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/check.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 3f6785415894..3354101ffe34 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -3380,7 +3380,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  		case INSN_RETURN:
>  			if (sls && !insn->retpoline_safe &&
> -			    next_insn && next_insn->type != INSN_TRAP) {
> +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
>  				WARN_FUNC("missing int3 after ret",
>  					  insn->sec, insn->offset);
>  			}
> @@ -3428,7 +3428,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  
>  		case INSN_JUMP_DYNAMIC:
>  			if (sls && !insn->retpoline_safe &&
> -			    next_insn && next_insn->type != INSN_TRAP) {
> +			    (!next_insn || (next_insn && next_insn->type != INSN_TRAP))) {
>  				WARN_FUNC("missing int3 after indirect jump",
>  					  insn->sec, insn->offset);
>  			}

My SLS rewrite in tip/objtool/core already fixed this, FWIW.  But this
could be good for -urgent.

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Here's another SLS improvement I mentioned to you the other day, do you
agree we should do this as well?


From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/speculation: Mitigate SLS for JMP_NOSPEC with retpolines disabled

Having disabled retpolines doesn't necessarily mean the user doesn't
care about straight-line speculation.  For example, retpolines are
disabled when eIBRS is used.

If CONFIG_SLS is enabled, properly mitigate SLS for JMP_NOSPEC for the
retpolines disabled cases.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/nospec-branch.h | 13 ++++++++++---
 tools/objtool/check.c                |  3 ---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index acbaeaf83b61..0648746bf60b 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -75,6 +75,13 @@
 	.popsection
 .endm
 
+.macro INDIRECT_JMP reg
+	jmp *%\reg
+#ifdef CONFIG_SLS
+	int3
+#endif
+.endm
+
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -82,11 +89,11 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
+	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), \
 		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; INDIRECT_JMP \reg), X86_FEATURE_RETPOLINE_LFENCE
 #else
-	jmp	*%\reg
+	INDIRECT_JMP \reg
 #endif
 .endm
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e7983c3e2408..3cf3ad0b5db5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3842,9 +3842,6 @@ static int validate_sls(struct objtool_file *file)
 	for_each_insn(file, insn) {
 		next_insn = next_insn_same_sec(file, insn);
 
-		if (insn->retpoline_safe)
-			continue;
-
 		switch (insn->type) {
 		case INSN_RETURN:
 			if (!next_insn || next_insn->type != INSN_TRAP) {
-- 
2.34.1

