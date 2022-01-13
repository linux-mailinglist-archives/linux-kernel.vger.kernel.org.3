Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D9748DA31
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 15:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiAMOzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 09:55:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36248 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232728AbiAMOzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 09:55:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFBD0B82276
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 14:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74A0DC36AEC;
        Thu, 13 Jan 2022 14:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642085748;
        bh=i2ZBRJsRyYqOUwP06kMZBurjPluouzMm5gJRZyYNSwU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MUMDWBp0exatVJpdYXRN/wvTNcKuaD8UhztFwSAAJSGzoFU5sXBwMJKHCbfyOvYj+
         rjMS80+fRvxK1HPNyIFihfOUgQ5yTmCSAmWUPpJdKtgjicKTxnoWKRjr060FMFpfHz
         2p2NNygv+M3f7+T+SK+h9FWOgVBe8mk/Wi3uhykbFNovsRZbiJV+4N55x1mvSfcBB0
         7g+60OGuqpsbfOjrTvB4CG1W9azKPiUX1eLnFm6l+sS8hF8lGu358xoZKoyjmjRgbD
         kz1+44RzDPFLmwdhDX5N9qFizQXALQ6yeGAOf7r5G/p7GSwycneIwXbfSzoxGErIDl
         Kh9uvyvRl8z2g==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianhua Liu <jianhua.ljh@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Anju T <anju@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/kprobes: Fix alloc_optinsn_page() to use all area of optinsn_slot
Date:   Thu, 13 Jan 2022 23:55:45 +0900
Message-Id: <164208574549.1590449.15254840776784986500.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164208572899.1590449.14007562142219520042.stgit@devnote2>
References: <164208572899.1590449.14007562142219520042.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ppc64 uses 4K page size, most part of the optinsn_slot
is not used because alloc_optinsn_page() is expected to return
only one page-size memory.
To use the remaining memories, make insn_page_in_use as array
to manage page-sized slots and return corresponding memory
address in the optinsn_slot.

Fixes: 51c9c0843993 ("powerpc/kprobes: Implement Optprobes")
Reported-by: Jianhua Liu <jianhua.ljh@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Anju T <anju@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/kprobes.h   |    6 ++++++
 arch/powerpc/kernel/optprobes.c      |   25 +++++++++++++++++++------
 arch/powerpc/kernel/optprobes_head.S |    5 ++---
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/kprobes.h b/arch/powerpc/include/asm/kprobes.h
index bab364152b29..e7a5390effa8 100644
--- a/arch/powerpc/include/asm/kprobes.h
+++ b/arch/powerpc/include/asm/kprobes.h
@@ -4,6 +4,8 @@
 
 #include <asm-generic/kprobes.h>
 
+#ifndef __ASSEMBLY__
+
 #ifdef __KERNEL__
 /*
  *  Kernel Probes (KProbes)
@@ -94,4 +96,8 @@ static inline int kprobe_handler(struct pt_regs *regs) { return 0; }
 static inline int kprobe_post_handler(struct pt_regs *regs) { return 0; }
 #endif /* CONFIG_KPROBES */
 #endif /* __KERNEL__ */
+#endif /* __ASSEMBLY__ */
+
+#define KPROBE_OPTINSN_SLOT_SIZE        65536
+
 #endif	/* _ASM_POWERPC_KPROBES_H */
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index ce1903064031..eec2776ad2fd 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -25,19 +25,32 @@
 #define TMPL_INSN_IDX		(optprobe_template_insn - optprobe_template_entry)
 #define TMPL_END_IDX		(optprobe_template_end - optprobe_template_entry)
 
-static bool insn_page_in_use;
+#define OPTINSN_SLOT_PAGES (KPROBE_OPTINSN_SLOT_SIZE / PAGE_SIZE)
+
+static bool insn_page_in_use[OPTINSN_SLOT_PAGES];
 
 void *alloc_optinsn_page(void)
 {
-	if (insn_page_in_use)
-		return NULL;
-	insn_page_in_use = true;
-	return &optinsn_slot;
+	int i;
+
+	for (i = 0; i < OPTINSN_SLOT_PAGES; i++) {
+		if (!insn_page_in_use[i]) {
+			insn_page_in_use[i] = true;
+			return (void *)((unsigned long)&optinsn_slot + PAGE_SIZE * i);
+		}
+	}
+	return NULL;
 }
 
 void free_optinsn_page(void *page)
 {
-	insn_page_in_use = false;
+	unsigned long idx = (unsigned long)page - (unsigned long)&optinsn_slot;
+
+	WARN_ON_ONCE(idx & (PAGE_SIZE - 1));
+	idx >>= PAGE_SHIFT;
+	if (WARN_ON_ONCE(idx >= OPTINSN_SLOT_PAGES))
+		return;
+	insn_page_in_use[idx] = false;
 }
 
 /*
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 19ea3312403c..bf2106836cc6 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -8,6 +8,7 @@
 #include <asm/ppc_asm.h>
 #include <asm/ptrace.h>
 #include <asm/asm-offsets.h>
+#include <asm/kprobes.h>
 
 #ifdef CONFIG_PPC64
 #define SAVE_30GPRS(base) SAVE_10GPRS(2,base); SAVE_10GPRS(12,base); SAVE_10GPRS(22,base)
@@ -19,8 +20,6 @@
 #define TEMPLATE_FOR_IMM_LOAD_INSNS	nop; nop; nop
 #endif
 
-#define	OPT_SLOT_SIZE	65536
-
 	.balign	4
 
 	/*
@@ -30,7 +29,7 @@
 	 */
 	.global optinsn_slot
 optinsn_slot:
-	.space	OPT_SLOT_SIZE
+	.space	KPROBE_OPTINSN_SLOT_SIZE
 
 	/*
 	 * Optprobe template:

