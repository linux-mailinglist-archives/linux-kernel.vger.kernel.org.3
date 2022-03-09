Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF704D2C06
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 10:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbiCIJbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 04:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiCIJbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 04:31:07 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAACF16EAA0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 01:30:08 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KD6Nv0b01z9sSV;
        Wed,  9 Mar 2022 10:30:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ooq6_0FsSdGe; Wed,  9 Mar 2022 10:30:07 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KD6Nt6qh0z9sSR;
        Wed,  9 Mar 2022 10:30:06 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D7EB78B77E;
        Wed,  9 Mar 2022 10:30:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pOpmT6DffnpU; Wed,  9 Mar 2022 10:30:06 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 88E9C8B763;
        Wed,  9 Mar 2022 10:30:06 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2299Tscg3598467
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 10:29:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2299TqDE3598460;
        Wed, 9 Mar 2022 10:29:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove find_current_mm_pte()
Date:   Wed,  9 Mar 2022 10:29:50 +0100
Message-Id: <ec79f462a3bfa8365b7df505e574d5d85246bc68.1646818177.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646818188; l=2526; s=20211009; h=from:subject:message-id; bh=h44Sg5AgvIMvJpGkxPGM0gq65QXd16xNa43MAsRSfio=; b=oHkiv4ZIEp7UvFFwzb2z/ajNVIwFcw+hXyjZMtTPV39nDHiMTygEQApsjKlwdgTeYlYy4PBdfQ2k JJCXgKLsAox3Wfh8ffT2Z/AwuimMsc2zUcKoli3ayLGN2lw+AZsE
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

Last usage of find_current_mm_pte() was removed by
commit 15759cb054ef ("powerpc/perf/callchain: Use
__get_user_pages_fast in read_user_stack_slow")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/pte-walk.h | 25 -------------------------
 arch/powerpc/mm/book3s64/pgtable.c  |  4 ++--
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-walk.h b/arch/powerpc/include/asm/pte-walk.h
index 714a35f0d425..73c22c579a79 100644
--- a/arch/powerpc/include/asm/pte-walk.h
+++ b/arch/powerpc/include/asm/pte-walk.h
@@ -60,29 +60,4 @@ static inline phys_addr_t ppc_find_vmap_phys(unsigned long addr)
 	return pa;
 }
 
-/*
- * This is what we should always use. Any other lockless page table lookup needs
- * careful audit against THP split.
- */
-static inline pte_t *find_current_mm_pte(pgd_t *pgdir, unsigned long ea,
-					 bool *is_thp, unsigned *hshift)
-{
-	pte_t *pte;
-
-	VM_WARN(!arch_irqs_disabled(), "%s called with irq enabled\n", __func__);
-	VM_WARN(pgdir != current->mm->pgd,
-		"%s lock less page table lookup called on wrong mm\n", __func__);
-	pte = __find_linux_pte(pgdir, ea, is_thp, hshift);
-
-#if defined(CONFIG_DEBUG_VM) &&						\
-	!(defined(CONFIG_HUGETLB_PAGE) || defined(CONFIG_TRANSPARENT_HUGEPAGE))
-	/*
-	 * We should not find huge page if these configs are not enabled.
-	 */
-	if (hshift)
-		WARN_ON(*hshift);
-#endif
-	return pte;
-}
-
 #endif /* _ASM_POWERPC_PTE_WALK_H */
diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
index 79ce3c22a29d..41a41357799d 100644
--- a/arch/powerpc/mm/book3s64/pgtable.c
+++ b/arch/powerpc/mm/book3s64/pgtable.c
@@ -98,14 +98,14 @@ static void do_serialize(void *arg)
 }
 
 /*
- * Serialize against find_current_mm_pte which does lock-less
+ * Serialize against __find_linux_pte() which does lock-less
  * lookup in page tables with local interrupts disabled. For huge pages
  * it casts pmd_t to pte_t. Since format of pte_t is different from
  * pmd_t we want to prevent transit from pmd pointing to page table
  * to pmd pointing to huge page (and back) while interrupts are disabled.
  * We clear pmd to possibly replace it with page table pointer in
  * different code paths. So make sure we wait for the parallel
- * find_current_mm_pte to finish.
+ * __find_linux_pte() to finish.
  */
 void serialize_against_pte_lookup(struct mm_struct *mm)
 {
-- 
2.34.1

