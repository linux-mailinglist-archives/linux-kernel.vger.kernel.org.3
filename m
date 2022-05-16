Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8ADA5288FE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245412AbiEPPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 11:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbiEPPgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 11:36:22 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBA720F54
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 08:36:18 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L23J04XPKz9sv6;
        Mon, 16 May 2022 17:36:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UNIQeZVrcqmx; Mon, 16 May 2022 17:36:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L23J03kcSz9sv5;
        Mon, 16 May 2022 17:36:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7154C8B76E;
        Mon, 16 May 2022 17:36:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ziEXgnIYi9U0; Mon, 16 May 2022 17:36:16 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4FE728B763;
        Mon, 16 May 2022 17:36:16 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24GFa7Ol2667221
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 17:36:07 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24GFa6232667218;
        Mon, 16 May 2022 17:36:06 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/irq: Remove arch_local_irq_restore() for !CONFIG_CC_HAS_ASM_GOTO
Date:   Mon, 16 May 2022 17:36:04 +0200
Message-Id: <58df50c9e77e2ed945bacdead30412770578886b.1652715336.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652715344; l=3201; s=20211009; h=from:subject:message-id; bh=C31tbK0iwmtdja7r/jhK/x9hBYZZUMb/QQwP/WTCnUY=; b=dptpsagpthJSiCP0y80IMh2sPCLb/+m+bpXU237qpmhqJz9mqWXsRUwKqQ/ZcgPiX0TaeQjj4ysM yrtfFei9CHM591sAlc+JeuEV7DEWbOT+CfG8VzwNdg5LLl1UJNMk
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

All supported versions of GCC support asm goto.

Remove the !CONFIG_CC_HAS_ASM_GOTO version of arch_local_irq_restore()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/irq.c | 77 ---------------------------------------
 1 file changed, 77 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index c768cde03e36..dd09919c3c66 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -216,7 +216,6 @@ static inline void replay_soft_interrupts_irqrestore(void)
 #define replay_soft_interrupts_irqrestore() replay_soft_interrupts()
 #endif
 
-#ifdef CONFIG_CC_HAS_ASM_GOTO
 notrace void arch_local_irq_restore(unsigned long mask)
 {
 	unsigned char irq_happened;
@@ -312,82 +311,6 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	__hard_irq_enable();
 	preempt_enable();
 }
-#else
-notrace void arch_local_irq_restore(unsigned long mask)
-{
-	unsigned char irq_happened;
-
-	/* Write the new soft-enabled value */
-	irq_soft_mask_set(mask);
-	if (mask)
-		return;
-
-	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-		WARN_ON_ONCE(in_nmi() || in_hardirq());
-
-	/*
-	 * From this point onward, we can take interrupts, preempt,
-	 * etc... unless we got hard-disabled. We check if an event
-	 * happened. If none happened, we know we can just return.
-	 *
-	 * We may have preempted before the check below, in which case
-	 * we are checking the "new" CPU instead of the old one. This
-	 * is only a problem if an event happened on the "old" CPU.
-	 *
-	 * External interrupt events will have caused interrupts to
-	 * be hard-disabled, so there is no problem, we
-	 * cannot have preempted.
-	 */
-	irq_happened = get_irq_happened();
-	if (!irq_happened) {
-		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
-		return;
-	}
-
-	/* We need to hard disable to replay. */
-	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
-		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
-			WARN_ON_ONCE(!(mfmsr() & MSR_EE));
-		__hard_irq_disable();
-		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
-	} else {
-		/*
-		 * We should already be hard disabled here. We had bugs
-		 * where that wasn't the case so let's dbl check it and
-		 * warn if we are wrong. Only do that when IRQ tracing
-		 * is enabled as mfmsr() can be costly.
-		 */
-		if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
-			if (WARN_ON_ONCE(mfmsr() & MSR_EE))
-				__hard_irq_disable();
-		}
-
-		if (irq_happened == PACA_IRQ_HARD_DIS) {
-			local_paca->irq_happened = 0;
-			__hard_irq_enable();
-			return;
-		}
-	}
-
-	/*
-	 * Disable preempt here, so that the below preempt_enable will
-	 * perform resched if required (a replayed interrupt may set
-	 * need_resched).
-	 */
-	preempt_disable();
-	irq_soft_mask_set(IRQS_ALL_DISABLED);
-	trace_hardirqs_off();
-
-	replay_soft_interrupts_irqrestore();
-	local_paca->irq_happened = 0;
-
-	trace_hardirqs_on();
-	irq_soft_mask_set(IRQS_ENABLED);
-	__hard_irq_enable();
-	preempt_enable();
-}
-#endif
 EXPORT_SYMBOL(arch_local_irq_restore);
 
 /*
-- 
2.35.1

