Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173A057A8E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 23:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbiGSVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 17:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiGSVXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 17:23:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432F42B242
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oquyoviez5iOBeSIHe7GZpPLBcfIF6HmL2Win3qty5Q=; b=YmbGlbf/Fx5JLeannU5TWwkK/V
        wLd2r13MmtQfd48EoiLg1Qh8wSKYFHEYknfoi9qgfRNNQ0N8Kiy4A65Bh0P/0yF64H7jwHhYutdeT
        YKQnVaZzh68OLWBYU2KDMAtEm3mzY5KtbvT2h13vJIPwzYcX+tVWpuyjCt9r4dfusSsJEFfVruO4X
        EBEmcbw5p5IFLSAyZHGMu9ddLDncgD+M8P3cUCPyjqL1SJSU8kf4ACNsbi5ir+XWLI8OL6YRuEyiG
        tZeJSD6z6Zt4pNdS2sCuBcQf7DUtKkGMDeYQccPgRdTNZZXFYNoofAW7CVwIoZFQCSrQpfGi0Eh3i
        opyiwe9A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDugO-00DtQ2-EZ; Tue, 19 Jul 2022 21:23:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00DE99802BB; Tue, 19 Jul 2022 23:23:06 +0200 (CEST)
Date:   Tue, 19 Jul 2022 23:23:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        hjl.tools@gmail.com, andrew.cooper3@citrix.com,
        mark.rutland@arm.com, will@kernel.org, ndesaulniers@google.com,
        x86@kernel.org, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [RFC][PATCH] x86,nospec: Simplify {JMP,CALL}_NOSPEC
Message-ID: <Ytcguqp+/aTiOcnN@worktop.programming.kicks-ass.net>
References: <20211204134338.760603010@infradead.org>
 <20211204134908.140103474@infradead.org>
 <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9011132e-d78b-8bec-10cb-2b3d77a4e1fc@maciej.szmigiero.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 03:19:26PM +0200, Maciej S. Szmigiero wrote:
> On 4.12.2021 14:43, Peter Zijlstra wrote:
> > Make use of an upcomming GCC feature to mitigate
> > straight-line-speculation for x86:
> > 
> >    https://gcc.gnu.org/g:53a643f8568067d7700a9f2facc8ba39974973d3
> >    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=102952
> >    https://bugs.llvm.org/show_bug.cgi?id=52323
> > 
> > It's built tested on x86_64-allyesconfig using GCC-12 and GCC-11.
> > 
> > Maintenace overhead of this should be fairly low due to objtool
> > validation.
> > 
> > Size overhead of all these additional int3 instructions comes to:
> > 
> >     text	   data	    bss	    dec	    hex	filename
> > 22267751	6933356	2011368	31212475	1dc43bb	defconfig-build/vmlinux
> > 22804126	6933356	1470696	31208178	1dc32f2	defconfig-build/vmlinux.sls
> > 
> > Or roughly 2.4% additional text.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> (..)
> > --- a/arch/x86/lib/retpoline.S
> > +++ b/arch/x86/lib/retpoline.S
> > @@ -34,7 +34,7 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\re
> >   	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> >   		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
> > -		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_AMD
> > +		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg; int3), X86_FEATURE_RETPOLINE_AMD
> >   .endm
> 
> Looking at this __x86_indirect_thunk_* change makes me wonder why there is
> no similar int3 SLS protection in the X86_FEATURE_RETPOLINE_LFENCE case of
> JMP_NOSPEC in arch/x86/include/asm/nospec-branch.h:
> > .macro JMP_NOSPEC reg:req
> > #ifdef CONFIG_RETPOLINE
> > 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
> > 		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
> > 		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
> > #else
> 
> JMP_NOSPEC users seem to have no explicit trailing int3 instructions
> either.
> 
> Or am I missing something here?

Probably just forgot about those. I'm thinking we ought to do something
like this...

---
Subject: x86,nospec: Simplify {JMP,CALL}_NOSPEC

Have {JMP,CALL}_NOSPEC generate the same code GCC does for indirect
calls and rely on the objtool retpoline patching infrastructure.

There's no reason these should be alternatives while the vast bulk of
compiler generated retpolines are not.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/nospec-branch.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 10a3bfc1eb23..7bb319d2932c 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -93,6 +93,19 @@
 #endif
 .endm
 
+/*
+ * Equivalent to -mindirect-branch-cs-prefix; emit the 5 byte jmp/call
+ * to the retpoline thunk with a CS prefix when the register requires
+ * a RAX prefix byte to encode. Also see apply_alternatives().
+ */
+.macro __CS_PREFIX reg:req
+	.irp rs,r8,r9,r10,r11,r12,r13,r14,r15
+	.ifc \reg,\rs
+	.byte 0x2e
+	.endif
+	.endr
+.endm
+
 /*
  * JMP_NOSPEC and CALL_NOSPEC macros can be used instead of a simple
  * indirect jmp/call which may be susceptible to the Spectre variant 2
@@ -100,19 +113,18 @@
  */
 .macro JMP_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
-		      __stringify(jmp __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	jmp	__x86_indirect_thunk_\reg
 #else
 	jmp	*%\reg
+	int3
 #endif
 .endm
 
 .macro CALL_NOSPEC reg:req
 #ifdef CONFIG_RETPOLINE
-	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; call *%\reg), \
-		      __stringify(call __x86_indirect_thunk_\reg), X86_FEATURE_RETPOLINE, \
-		      __stringify(lfence; ANNOTATE_RETPOLINE_SAFE; call *%\reg), X86_FEATURE_RETPOLINE_LFENCE
+	__CS_PREFIX \reg
+	call	__x86_indirect_thunk_\reg
 #else
 	call	*%\reg
 #endif
