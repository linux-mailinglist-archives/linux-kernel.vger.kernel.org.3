Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA63C562B81
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 08:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbiGAGZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 02:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbiGAGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 02:24:58 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9744579E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 23:24:56 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LZ4tb24Ljz9tGJ;
        Fri,  1 Jul 2022 08:24:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id hWEsQtjMfA7W; Fri,  1 Jul 2022 08:24:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LZ4tb1Fy0z9tGD;
        Fri,  1 Jul 2022 08:24:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1B84D8B798;
        Fri,  1 Jul 2022 08:24:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id GsTV0VLIZlEn; Fri,  1 Jul 2022 08:24:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EADFF8B767;
        Fri,  1 Jul 2022 08:24:54 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2616Ofeg3736353
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 1 Jul 2022 08:24:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2616ObHb3736347;
        Fri, 1 Jul 2022 08:24:37 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32s: Cleanup the mess in __set_pte_at()
Date:   Fri,  1 Jul 2022 08:24:20 +0200
Message-Id: <ba485f4a77ed4279b30500bfcc32d99ef0069ba0.1656656649.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1656656658; l=4711; s=20211009; h=from:subject:message-id; bh=q+34J0fsTk9EBq2XrnYqbpuaHJg0hWtUGi/C0gN/4e8=; b=JwunFyrzqqE9Z589OmlbwRYqVOd6fc5YUB1srZSfTevoWSTFQmzCT3fSAxTBCEf7G0NscIIa56S6 BWeJ2SPsADU1d98rz912yu/nHUB9NI5sjQykqKsX0CXeOnQI+5eA
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

__set_pte_at() handles 3 main cases with #ifdefs plus the 'percpu'
subcase which leads to code duplication.

Rewrite the function using IS_ENABLED() to minimise the total number
of cases and remove duplicated code.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 77 ++++++++------------
 1 file changed, 31 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 40041ac713d9..2a0ca1f9a1ff 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -534,58 +534,43 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 
 
 /* This low level function performs the actual PTE insertion
- * Setting the PTE depends on the MMU type and other factors. It's
- * an horrible mess that I'm not going to try to clean up now but
- * I'm keeping it in one place rather than spread around
+ * Setting the PTE depends on the MMU type and other factors.
+ *
+ * First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
+ * helper pte_update() which does an atomic update. We need to do that
+ * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
+ * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
+ * the hash bits instead (ie, same as the non-SMP case)
+ *
+ * Second case is 32-bit with 64-bit PTE.  In this case, we
+ * can just store as long as we do the two halves in the right order
+ * with a barrier in between. This is possible because we take care,
+ * in the hash code, to pre-invalidate if the PTE was already hashed,
+ * which synchronizes us with any concurrent invalidation.
+ * In the percpu case, we also fallback to the simple update preserving
+ * the hash bits
+ *
+ * Third case is 32-bit hash table in UP mode, we need to preserve
+ * the _PAGE_HASHPTE bit since we may not have invalidated the previous
+ * translation in the hash yet (done in a subsequent flush_tlb_xxx())
+ * and see we need to keep track that this PTE needs invalidating
  */
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
-#if defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
-	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
-	 * helper pte_update() which does an atomic update. We need to do that
-	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
-	 * per-CPU PTE such as a kmap_atomic, we do a simple update preserving
-	 * the hash bits instead (ie, same as the non-SMP case)
-	 */
-	if (percpu)
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-	else
-		pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, pte_val(pte), 0);
+	if ((!IS_ENABLED(CONFIG_SMP) && !IS_ENABLED(CONFIG_PTE_64BIT)) || percpu) {
+		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE) |
+			      (pte_val(pte) & ~_PAGE_HASHPTE));
+	} else if (IS_ENABLED(CONFIG_PTE_64BIT)) {
+		if (pte_val(*ptep) & _PAGE_HASHPTE)
+			flush_hash_entry(mm, ptep, addr);
 
-#elif defined(CONFIG_PTE_64BIT)
-	/* Second case is 32-bit with 64-bit PTE.  In this case, we
-	 * can just store as long as we do the two halves in the right order
-	 * with a barrier in between. This is possible because we take care,
-	 * in the hash code, to pre-invalidate if the PTE was already hashed,
-	 * which synchronizes us with any concurrent invalidation.
-	 * In the percpu case, we also fallback to the simple update preserving
-	 * the hash bits
-	 */
-	if (percpu) {
-		*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-			      | (pte_val(pte) & ~_PAGE_HASHPTE));
-		return;
+		asm volatile("stw%X0 %2,%0; eieio; stw%X1 %L2,%1" :
+			     "=m" (*ptep), "=m" (*((unsigned char *)ptep+4)) :
+			     "r" (pte) : "memory");
+	} else {
+		pte_update(mm, addr, ptep, ~_PAGE_HASHPTE, pte_val(pte), 0);
 	}
-	if (pte_val(*ptep) & _PAGE_HASHPTE)
-		flush_hash_entry(mm, ptep, addr);
-	__asm__ __volatile__("\
-		stw%X0 %2,%0\n\
-		eieio\n\
-		stw%X1 %L2,%1"
-	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
-	: "r" (pte) : "memory");
-
-#else
-	/* Third case is 32-bit hash table in UP mode, we need to preserve
-	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
-	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
-	 * and see we need to keep track that this PTE needs invalidating
-	 */
-	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
-		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-#endif
 }
 
 /*
-- 
2.36.1

