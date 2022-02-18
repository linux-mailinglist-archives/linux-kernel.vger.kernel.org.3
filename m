Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2C54BBE1B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiBRRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:16:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiBRRPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F694C409
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=sgeqFPf4iiUQcYgsDEuMEVfklmLydc0q++yO3hJu8EU=; b=BNPmhSizei7KamWTrucufg2DV6
        Xz0oo0FcAYJ4mB/hGuO8uNpYVaKbkJDsY3l3t9vYh/Ju2eCUG+6utIKmluRPT1ABskKlTJCaIZe46
        B3kKTujBP0318rkxkuq3H6XsDiZ0ESQV9l+r7WSbyWpVONp67TQkQFSieFQWTiEGPjcGcqQ7wS62w
        2ZhJGXZo4radMEKJCIZsNNg5Qussvt5j4+DGf7PfwS3J2rg9QOSfLttHwG02OZ9KMTtrbDNYX1MiR
        wmRa2HOmJclSG5u3GU7dYek/hNk2qoLpSTAlvhsshCx4XAcKv/ZjmB1wLUw79fuEjZAq+j7OBrC3i
        k7sSTm+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6q9-00Gl8Z-QP; Fri, 18 Feb 2022 17:14:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B7AB83009C4;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 14CD6203C2B2F; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171408.867389898@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 05/29] x86: Base IBT bits
References: <20220218164902.008644515@infradead.org>
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

Add Kconfig, Makefile and basic instruction support for x86 IBT.

TODO: clang

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/Kconfig           |   15 ++++++++++++
 arch/x86/Makefile          |    5 +++-
 arch/x86/include/asm/ibt.h |   53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1861,6 +1861,21 @@ config X86_UMIP
 	  specific cases in protected and virtual-8086 modes. Emulated
 	  results are dummy.
 
+config CC_HAS_IBT
+	# GCC >= 9 and binutils >= 2.29
+	# Retpoline check to work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=93654
+	def_bool $(cc-option, -fcf-protection=branch -mindirect-branch-register) && $(as-instr,endbr64)
+
+config X86_IBT
+	prompt "Indirect Branch Tracking"
+	bool
+	depends on X86_64 && CC_HAS_IBT
+	help
+	  Build the kernel with support for Indirect Branch Tracking, a
+	  hardware supported CFI scheme. Any indirect call must land on
+	  an ENDBR instruction, as such, the compiler will litter the
+	  code with them to make this happen.
+
 config X86_INTEL_MEMORY_PROTECTION_KEYS
 	prompt "Memory Protection Keys"
 	def_bool y
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -62,8 +62,11 @@ export BITS
 #
 KBUILD_CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
 
-# Intel CET isn't enabled in the kernel
+ifeq ($(CONFIG_X86_IBT),y)
+KBUILD_CFLAGS += $(call cc-option,-fcf-protection=branch)
+else
 KBUILD_CFLAGS += $(call cc-option,-fcf-protection=none)
+endif
 
 ifeq ($(CONFIG_X86_32),y)
         BITS := 32
--- /dev/null
+++ b/arch/x86/include/asm/ibt.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_IBT_H
+#define _ASM_X86_IBT_H
+
+#ifdef CONFIG_X86_IBT
+
+#ifndef __ASSEMBLY__
+
+#ifdef CONFIG_X86_64
+#define ASM_ENDBR	"endbr64\n\t"
+#else
+#define ASM_ENDBR	"endbr32\n\t"
+#endif
+
+#define __noendbr	__attribute__((nocf_check))
+
+/*
+ * A bit convoluted, but matches both endbr32 and endbr64 without
+ * having either as literal in the text.
+ */
+static inline bool is_endbr(const void *addr)
+{
+	unsigned int val = ~*(unsigned int *)addr;
+	val |= 0x01000000U;
+	return val == ~0xfa1e0ff3;
+}
+
+#else /* __ASSEMBLY__ */
+
+#ifdef CONFIG_X86_64
+#define ENDBR	endbr64
+#else
+#define ENDBR	endbr32
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#else /* !IBT */
+
+#ifndef __ASSEMBLY__
+
+#define ASM_ENDBR
+
+#define __noendbr
+
+#else /* __ASSEMBLY__ */
+
+#define ENDBR
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* CONFIG_X86_IBT */
+#endif /* _ASM_X86_IBT_H */


