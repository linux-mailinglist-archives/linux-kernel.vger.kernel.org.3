Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF452B3E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbiERHkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 03:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiERHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 03:40:29 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12CD6EC47
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 00:40:27 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L34f05mRKz9snR;
        Wed, 18 May 2022 09:40:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7NB8nyYK2GVL; Wed, 18 May 2022 09:40:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L34f04wBpz9snF;
        Wed, 18 May 2022 09:40:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 977778B77C;
        Wed, 18 May 2022 09:40:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZBvs3ZPwmeUS; Wed, 18 May 2022 09:40:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7B0358B77B;
        Wed, 18 May 2022 09:40:24 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24I7eIHw2950429
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 09:40:18 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24I7eIfs2950427;
        Wed, 18 May 2022 09:40:18 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/irq64: Remove get_irq_happened()
Date:   Wed, 18 May 2022 09:40:16 +0200
Message-Id: <af511b53e4eb51f8fbc51eda7f5597175e68dce6.1652859593.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <9f1a47de80f78d3dd270a7a72f69f55f581c4054.1652859593.git.christophe.leroy@csgroup.eu>
References: <9f1a47de80f78d3dd270a7a72f69f55f581c4054.1652859593.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652859615; l=1520; s=20211009; h=from:subject:message-id; bh=ki5lqa1nR6Ei2hRN9t5gh7hJJB8s3+Kwk0dFblFytvE=; b=TRYat2aXOZrP/KvwCM+P5QKnDEjoX/tD6mhWCL/P+e0R7jQTcuMiVgXkk22R26fs9zbcxsyVw/b8 EWUwI2gvBgA8XmcRHUs3JI55nDqX7xzB4yA5PoJXx+7ECrsTN6U5
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

No need to open code the read of local_paca->irq_happened in
assembly, we have READ_ONCE() for doing the same.

Replace get_irq_happened() by READ_ONCE(local_paca->irq_happened).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/irq_64.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/irq_64.c b/arch/powerpc/kernel/irq_64.c
index 488f6eb4553d..0f0e8bcb368c 100644
--- a/arch/powerpc/kernel/irq_64.c
+++ b/arch/powerpc/kernel/irq_64.c
@@ -67,16 +67,6 @@
 
 int distribute_irqs = 1;
 
-static inline notrace unsigned long get_irq_happened(void)
-{
-	unsigned long happened;
-
-	__asm__ __volatile__("lbz %0,%1(13)"
-	: "=r" (happened) : "i" (offsetof(struct paca_struct, irq_happened)));
-
-	return happened;
-}
-
 void replay_soft_interrupts(void)
 {
 	struct pt_regs regs;
@@ -233,7 +223,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	return;
 
 happened:
-	irq_happened = get_irq_happened();
+	irq_happened = READ_ONCE(local_paca->irq_happened);
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
 		WARN_ON_ONCE(!irq_happened);
 
@@ -256,7 +246,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 				 * IRQ_HARD_DIS again and warn if it is still
 				 * clear.
 				 */
-				irq_happened = get_irq_happened();
+				irq_happened = READ_ONCE(local_paca->irq_happened);
 				WARN_ON_ONCE(!(irq_happened & PACA_IRQ_HARD_DIS));
 			}
 		}
-- 
2.35.3

