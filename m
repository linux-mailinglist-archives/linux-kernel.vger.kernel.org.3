Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B55544899
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 12:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbiFIKRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiFIKRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:17:20 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C67ABB1D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 03:17:19 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LJg4p0fyjz9tJB;
        Thu,  9 Jun 2022 12:17:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CwCJpVoUbHxB; Thu,  9 Jun 2022 12:17:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LJg4n1zxpz9tJF;
        Thu,  9 Jun 2022 12:17:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 334D88B779;
        Thu,  9 Jun 2022 12:17:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yeryjKyfAtDF; Thu,  9 Jun 2022 12:17:13 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.129])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D58CA8B77D;
        Thu,  9 Jun 2022 12:17:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 259AH37n133866
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 9 Jun 2022 12:17:03 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 259AH0PB133864;
        Thu, 9 Jun 2022 12:17:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 1/3] powerpc/irq: Make __do_irq() static
Date:   Thu,  9 Jun 2022 12:16:40 +0200
Message-Id: <adbe1c8315ec2d63259f41468e82e51677bb1eda.1654769775.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1654769796; l=2894; s=20211009; h=from:subject:message-id; bh=D/YnwbpsLRuA5tJYiZC5RVaVHXgdTEiVTKEkUJ95FSE=; b=Qaamowtk+TMggMfh9IooX3NDV7HcTwS5pRTBwM545kHOyAZIfRv/2JfrVcBW0Q0rQk6Eg6D69om/ KWZy4d24C/wDwabcvEioa17SkELs5MmrwFwMcMgUbPCZpTJ7hv5N
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 48cf12d88969 ("powerpc/irq: Inline call_do_irq() and
call_do_softirq()"), __do_irq() is not used outside irq.c

Reorder functions and make __do_irq() static and
drop the declaration in irq.h.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/irq.h |  1 -
 arch/powerpc/kernel/irq.c      | 46 +++++++++++++++++-----------------
 2 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/irq.h b/arch/powerpc/include/asm/irq.h
index 13f0409dd617..5c1516a5ba8f 100644
--- a/arch/powerpc/include/asm/irq.h
+++ b/arch/powerpc/include/asm/irq.h
@@ -54,7 +54,6 @@ extern void *softirq_ctx[NR_CPUS];
 
 void __do_IRQ(struct pt_regs *regs);
 extern void __init init_IRQ(void);
-extern void __do_irq(struct pt_regs *regs);
 
 int irq_choose_cpu(const struct cpumask *mask);
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 873e6dffb868..370434f6c316 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -219,31 +219,9 @@ static __always_inline void call_do_softirq(const void *sp)
 	);
 }
 
-static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
-{
-	register unsigned long r3 asm("r3") = (unsigned long)regs;
-
-	/* Temporarily switch r1 to sp, call __do_irq() then restore r1. */
-	asm volatile (
-		 PPC_STLU "	%%r1, %[offset](%[sp])	;"
-		"mr		%%r1, %[sp]		;"
-		"bl		%[callee]		;"
-		 PPC_LL "	%%r1, 0(%%r1)		;"
-		 : // Outputs
-		   "+r" (r3)
-		 : // Inputs
-		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_OVERHEAD),
-		   [callee] "i" (__do_irq)
-		 : // Clobbers
-		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
-		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
-		   "r11", "r12"
-	);
-}
-
 DEFINE_STATIC_CALL_RET0(ppc_get_irq, *ppc_md.get_irq);
 
-void __do_irq(struct pt_regs *regs)
+static void __do_irq(struct pt_regs *regs)
 {
 	unsigned int irq;
 
@@ -269,6 +247,28 @@ void __do_irq(struct pt_regs *regs)
 	trace_irq_exit(regs);
 }
 
+static __always_inline void call_do_irq(struct pt_regs *regs, void *sp)
+{
+	register unsigned long r3 asm("r3") = (unsigned long)regs;
+
+	/* Temporarily switch r1 to sp, call __do_irq() then restore r1. */
+	asm volatile (
+		 PPC_STLU "	%%r1, %[offset](%[sp])	;"
+		"mr		%%r1, %[sp]		;"
+		"bl		%[callee]		;"
+		 PPC_LL "	%%r1, 0(%%r1)		;"
+		 : // Outputs
+		   "+r" (r3)
+		 : // Inputs
+		   [sp] "b" (sp), [offset] "i" (THREAD_SIZE - STACK_FRAME_OVERHEAD),
+		   [callee] "i" (__do_irq)
+		 : // Clobbers
+		   "lr", "xer", "ctr", "memory", "cr0", "cr1", "cr5", "cr6",
+		   "cr7", "r0", "r4", "r5", "r6", "r7", "r8", "r9", "r10",
+		   "r11", "r12"
+	);
+}
+
 void __do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-- 
2.35.3

