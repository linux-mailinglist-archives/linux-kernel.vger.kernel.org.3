Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E154CBC8D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiCCLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiCCLbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9B87E5A9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=4Rvh+1BbqB7+uHCIxdXY7qkisfSDxtfEMR7TyEtBSkw=; b=ehbDe/WUlhsE/C0EMuTB/jT6tp
        UcFfVPufCcN5ko2kudka8pJXN1aIrh4O84630zIikRbeLY4N1YEQLK7glOhfLfNlmsgBh7LabgDif
        Yr2BRUAhXlQat1t4zW9kHqyaBCME8fJm4gL8OQljbfwr/FAlHI52eFqaamLS6JO2Bjk411fTl5cZg
        BmuOzmOcVXrLpO6fsgUnjG/2QZcagZCqJpwHMblS+rL/HQLPnf5NJMi86tqlNzZGzmDKW2vRPXobm
        GP1A51vcWRfhi2nYnyjyP1mf+xE+vkSz0dwZ1JFavIpC9VNuU75rMsKuOTaiWLjhHDYhAFAtcQtIH
        iTTlN2og==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeg-00BaGq-Ej; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E79C430120E;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 46923300243F4; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.680530557@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 12/39] x86/linkage: Add ENDBR to SYM_FUNC_START*()
References: <20220303112321.422525803@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure the ASM functions have ENDBR on for IBT builds, this follows
the ARM64 example. Unlike ARM64, we'll likely end up overwriting them
with poison.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/linkage.h |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

--- a/arch/x86/include/asm/linkage.h
+++ b/arch/x86/include/asm/linkage.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_LINKAGE_H
 
 #include <linux/stringify.h>
+#include <asm/ibt.h>
 
 #undef notrace
 #define notrace __attribute__((no_instrument_function))
@@ -34,5 +35,43 @@
 
 #endif /* __ASSEMBLY__ */
 
+/*
+ * compressed and purgatory define this to disable EXPORT,
+ * hijack this same to also not emit ENDBR.
+ */
+#ifndef __DISABLE_EXPORTS
+
+/* SYM_FUNC_START -- use for global functions */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_NOALIGN -- use for global functions, w/o alignment */
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL -- use for local functions */
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_LOCAL_NOALIGN -- use for local functions, w/o alignment */
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK -- use for weak functions */
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	ENDBR
+
+/* SYM_FUNC_START_WEAK_NOALIGN -- use for weak functions, w/o alignment */
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	ENDBR
+
+#endif /* __DISABLE_EXPORTS */
+
 #endif /* _ASM_X86_LINKAGE_H */
 


