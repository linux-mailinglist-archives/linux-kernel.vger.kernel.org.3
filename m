Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23044C4AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243096AbiBYQhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:37:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243104AbiBYQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:37:15 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4992118D0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:36:41 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K4wQb3fgmz9sSF;
        Fri, 25 Feb 2022 17:36:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8YgDx3wKJhxM; Fri, 25 Feb 2022 17:36:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K4wQb2mZcz9sSC;
        Fri, 25 Feb 2022 17:36:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EC1C8B77E;
        Fri, 25 Feb 2022 17:36:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hAi__97nq34t; Fri, 25 Feb 2022 17:36:39 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.39])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1311B8B763;
        Fri, 25 Feb 2022 17:36:39 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21PGaSh5045790
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 25 Feb 2022 17:36:29 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21PGaRF3045789;
        Fri, 25 Feb 2022 17:36:27 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1] powerpc/interrupt: Remove struct interrupt_state
Date:   Fri, 25 Feb 2022 17:36:22 +0100
Message-Id: <1d862ce3eab3da6ca7ac47d4a78a18f154462511.1645806970.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645806978; l=4263; s=20211009; h=from:subject:message-id; bh=qTHND+P0LmWaBimVqQTVXUUhsVy8eL7e5n1A3obaQ8g=; b=+PFLUnwGxM1othpVsDf6WET2NOnWDnpu+scL3pd2OViBYDmKLk/yUbqOfVPPxdn3MLYmZ6HjDZGW y/hPK6GJAV9PKzvh//3H2wxdZb+GBLRT1tZzftSGwPdS+ov3wYx7
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

Since commit ceff77efa4f8 ("powerpc/64e/interrupt: Use new interrupt
context tracking scheme") struct interrupt_state has been empty and
unused.

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/interrupt.h | 32 +++++++++++-----------------
 1 file changed, 12 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/interrupt.h b/arch/powerpc/include/asm/interrupt.h
index fc28f46d2f9d..984ffceb8f91 100644
--- a/arch/powerpc/include/asm/interrupt.h
+++ b/arch/powerpc/include/asm/interrupt.h
@@ -123,9 +123,6 @@ static inline void nap_adjust_return(struct pt_regs *regs)
 #endif
 }
 
-struct interrupt_state {
-};
-
 static inline void booke_restore_dbcr0(void)
 {
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
@@ -138,7 +135,7 @@ static inline void booke_restore_dbcr0(void)
 #endif
 }
 
-static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
+static inline void interrupt_enter_prepare(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC32
 	if (!arch_irq_disabled_regs(regs))
@@ -228,17 +225,17 @@ static inline void interrupt_enter_prepare(struct pt_regs *regs, struct interrup
  * However interrupt_nmi_exit_prepare does return directly to regs, because
  * NMIs do not do "exit work" or replay soft-masked interrupts.
  */
-static inline void interrupt_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
+static inline void interrupt_exit_prepare(struct pt_regs *regs)
 {
 }
 
-static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct interrupt_state *state)
+static inline void interrupt_async_enter_prepare(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC64
 	/* Ensure interrupt_enter_prepare does not enable MSR[EE] */
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
 #endif
-	interrupt_enter_prepare(regs, state);
+	interrupt_enter_prepare(regs);
 #ifdef CONFIG_PPC_BOOK3S_64
 	/*
 	 * RI=1 is set by interrupt_enter_prepare, so this thread flags access
@@ -251,7 +248,7 @@ static inline void interrupt_async_enter_prepare(struct pt_regs *regs, struct in
 	irq_enter();
 }
 
-static inline void interrupt_async_exit_prepare(struct pt_regs *regs, struct interrupt_state *state)
+static inline void interrupt_async_exit_prepare(struct pt_regs *regs)
 {
 	/*
 	 * Adjust at exit so the main handler sees the true NIA. This must
@@ -262,7 +259,7 @@ static inline void interrupt_async_exit_prepare(struct pt_regs *regs, struct int
 	nap_adjust_return(regs);
 
 	irq_exit();
-	interrupt_exit_prepare(regs, state);
+	interrupt_exit_prepare(regs);
 }
 
 struct interrupt_nmi_state {
@@ -447,13 +444,11 @@ static __always_inline void ____##func(struct pt_regs *regs);		\
 									\
 interrupt_handler void func(struct pt_regs *regs)			\
 {									\
-	struct interrupt_state state;					\
-									\
-	interrupt_enter_prepare(regs, &state);				\
+	interrupt_enter_prepare(regs);					\
 									\
 	____##func (regs);						\
 									\
-	interrupt_exit_prepare(regs, &state);				\
+	interrupt_exit_prepare(regs);					\
 }									\
 NOKPROBE_SYMBOL(func);							\
 									\
@@ -482,14 +477,13 @@ static __always_inline long ____##func(struct pt_regs *regs);		\
 									\
 interrupt_handler long func(struct pt_regs *regs)			\
 {									\
-	struct interrupt_state state;					\
 	long ret;							\
 									\
-	interrupt_enter_prepare(regs, &state);				\
+	interrupt_enter_prepare(regs);					\
 									\
 	ret = ____##func (regs);					\
 									\
-	interrupt_exit_prepare(regs, &state);				\
+	interrupt_exit_prepare(regs);					\
 									\
 	return ret;							\
 }									\
@@ -518,13 +512,11 @@ static __always_inline void ____##func(struct pt_regs *regs);		\
 									\
 interrupt_handler void func(struct pt_regs *regs)			\
 {									\
-	struct interrupt_state state;					\
-									\
-	interrupt_async_enter_prepare(regs, &state);			\
+	interrupt_async_enter_prepare(regs);				\
 									\
 	____##func (regs);						\
 									\
-	interrupt_async_exit_prepare(regs, &state);			\
+	interrupt_async_exit_prepare(regs);				\
 }									\
 NOKPROBE_SYMBOL(func);							\
 									\
-- 
2.34.1

