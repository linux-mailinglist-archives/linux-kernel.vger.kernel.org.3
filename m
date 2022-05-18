Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EE352B4C5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbiERIc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233286AbiERIcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:32:46 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C6A4ECF6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:32:44 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L35pK6dtpz9srZ;
        Wed, 18 May 2022 10:32:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id asZI8wdTz7_S; Wed, 18 May 2022 10:32:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L35pK5lL1z9srY;
        Wed, 18 May 2022 10:32:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B65398B77B;
        Wed, 18 May 2022 10:32:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id C1zaX-77-LYm; Wed, 18 May 2022 10:32:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 949B18B763;
        Wed, 18 May 2022 10:32:41 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24I8WXG72962124
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 10:32:33 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24I8WTP22962123;
        Wed, 18 May 2022 10:32:29 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/irq: Replace #ifdefs by IS_ENABLED()
Date:   Wed, 18 May 2022 10:32:28 +0200
Message-Id: <c1ded642f8d9002767f8fed48ed6d1e76254ed73.1652862729.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <e2454434992cc932a5a34b695ae981c0b2f4c28e.1652862729.git.christophe.leroy@csgroup.eu>
References: <e2454434992cc932a5a34b695ae981c0b2f4c28e.1652862729.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652862747; l=3411; s=20211009; h=from:subject:message-id; bh=LH4UR/Yo7A3/ZMZPI2cOjU7g3lOq9tyKbnxyOai1sxE=; b=5nhel9tpLKQ8hG4PsKHXw1L4QgwDPtFqkIKqtYIlAjPtPEQsRgLXC4zWnwSqlgDoZme0rynO/YV/ 7WALbKhrBcluFoEh/GKD6KsZTraSPZ2+835EO9TGI5pVZMjM78Jr
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

Replace
  #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG and
  #ifdef CONFIG_PERF_EVENTS
by IS_ENABLED() in hw_irq.h and plpar_wrappers.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/hw_irq.h         | 30 +++++++++++------------
 arch/powerpc/include/asm/plpar_wrappers.h |  5 ++--
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index edc569481faf..6efab00aa1c8 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -123,7 +123,6 @@ static inline notrace unsigned long irq_soft_mask_return(void)
  */
 static inline notrace void irq_soft_mask_set(unsigned long mask)
 {
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 	/*
 	 * The irq mask must always include the STD bit if any are set.
 	 *
@@ -138,8 +137,8 @@ static inline notrace void irq_soft_mask_set(unsigned long mask)
 	 * unmasks to be replayed, among other things. For now, take
 	 * the simple approach.
 	 */
-	WARN_ON(mask && !(mask & IRQS_DISABLED));
-#endif
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
+		WARN_ON(mask && !(mask & IRQS_DISABLED));
 
 	WRITE_ONCE(local_paca->irq_soft_mask, mask);
 	barrier();
@@ -324,11 +323,13 @@ bool power_pmu_wants_prompt_pmi(void);
  */
 static inline bool should_hard_irq_enable(void)
 {
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON(irq_soft_mask_return() == IRQS_ENABLED);
-	WARN_ON(mfmsr() & MSR_EE);
-#endif
-#ifdef CONFIG_PERF_EVENTS
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
+		WARN_ON(irq_soft_mask_return() == IRQS_ENABLED);
+		WARN_ON(mfmsr() & MSR_EE);
+	}
+
+	if (!IS_ENABLED(CONFIG_PERF_EVENTS))
+		return false;
 	/*
 	 * If the PMU is not running, there is not much reason to enable
 	 * MSR[EE] in irq handlers because any interrupts would just be
@@ -343,9 +344,6 @@ static inline bool should_hard_irq_enable(void)
 		return false;
 
 	return true;
-#else
-	return false;
-#endif
 }
 
 /*
@@ -353,11 +351,11 @@ static inline bool should_hard_irq_enable(void)
  */
 static inline void do_hard_irq_enable(void)
 {
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON(irq_soft_mask_return() == IRQS_ENABLED);
-	WARN_ON(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK);
-	WARN_ON(mfmsr() & MSR_EE);
-#endif
+	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG)) {
+		WARN_ON(irq_soft_mask_return() == IRQS_ENABLED);
+		WARN_ON(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK);
+		WARN_ON(mfmsr() & MSR_EE);
+	}
 	/*
 	 * This allows PMI interrupts (and watchdog soft-NMIs) through.
 	 * There is no other reason to enable this way.
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 83e0f701ebc6..8239c0af5eb2 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -43,11 +43,10 @@ static inline long extended_cede_processor(unsigned long latency_hint)
 	set_cede_latency_hint(latency_hint);
 
 	rc = cede_processor();
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+
 	/* Ensure that H_CEDE returns with IRQs on */
-	if (WARN_ON(!(mfmsr() & MSR_EE)))
+	if (WARN_ON(IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && !(mfmsr() & MSR_EE)))
 		__hard_irq_enable();
-#endif
 
 	set_cede_latency_hint(old_latency_hint);
 
-- 
2.35.3

