Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B108352B58A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiERItZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiERItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:49:21 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BC813C1CC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:49:10 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L369J6Ppjz9srY;
        Wed, 18 May 2022 10:49:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id T7bNQxdeIToW; Wed, 18 May 2022 10:49:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L369J5bm3z9srH;
        Wed, 18 May 2022 10:49:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AD90B8B77D;
        Wed, 18 May 2022 10:49:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ajDl9ScbllcI; Wed, 18 May 2022 10:49:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 942678B77C;
        Wed, 18 May 2022 10:49:08 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24I8mt5v2968122
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 10:48:55 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24I8mtTV2968121;
        Wed, 18 May 2022 10:48:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/irq: remove inline assembly in hard_irq_disable macro
Date:   Wed, 18 May 2022 10:48:55 +0200
Message-Id: <9f05937d8722ddd2064a7c2362d8f9000e15e1ba.1652863723.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652863734; l=1048; s=20211009; h=from:subject:message-id; bh=REfAp0B2RYqKCCYWSypqG3oRXhNX7z9oD4h4eZLeFUw=; b=MluBCnm5RlsKVocLp/PugtJ5F31R2vFDM3x0a86lQ2NSfZuZg5rKdvCv3dpZ0neLcK54sk7oTpE0 +kOi4vobD7PAgpm//pRX9t4qJQdgAWONeAkauAk6HGEsjPtokajc
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

Use WRITE_ONCE() instead of opencoding the saving of current
stack pointeur.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
By the way, is WRITE_ONCE() needed at all ? Could we instead do local_paca->saved_r1 = current_stack_pointer;
---
 arch/powerpc/include/asm/hw_irq.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 6efab00aa1c8..26ede09c521d 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -282,9 +282,7 @@ static inline bool pmi_irq_pending(void)
 	flags = irq_soft_mask_set_return(IRQS_ALL_DISABLED);		\
 	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;			\
 	if (!arch_irqs_disabled_flags(flags)) {				\
-		asm ("stdx %%r1, 0, %1 ;"				\
-		     : "=m" (local_paca->saved_r1)			\
-		     : "b" (&local_paca->saved_r1));			\
+		WRITE_ONCE(local_paca->saved_r1, current_stack_pointer);\
 		trace_hardirqs_off();					\
 	}								\
 } while(0)
-- 
2.35.3

