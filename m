Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82F154AE88
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355786AbiFNKfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355722AbiFNKev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:34:51 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B1D4839F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:34:49 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LMlDm11l5z9tNV;
        Tue, 14 Jun 2022 12:34:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EUnX0ObVE5zA; Tue, 14 Jun 2022 12:34:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LMlDl70gHz9tNR;
        Tue, 14 Jun 2022 12:34:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0E088B766;
        Tue, 14 Jun 2022 12:34:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id NGWFE1zE5us5; Tue, 14 Jun 2022 12:34:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.246])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FB958B763;
        Tue, 14 Jun 2022 12:34:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 25EAYbs4198174
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 14 Jun 2022 12:34:38 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 25EAYWPZ198172;
        Tue, 14 Jun 2022 12:34:32 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 2/2] powerpc/32: Set an IBAT covering up to _einittext during init
Date:   Tue, 14 Jun 2022 12:34:09 +0200
Message-Id: <ce7f04a39593934d9b1ee68c69144ccd3d4da4a1.1655202804.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <db3fc14f3bfa6215b0786ef58a6e2bc1e1f964d7.1655202804.git.christophe.leroy@csgroup.eu>
References: <db3fc14f3bfa6215b0786ef58a6e2bc1e1f964d7.1655202804.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1655202848; l=3101; s=20211009; h=from:subject:message-id; bh=tycdwvBGgDGk37LlXhd93JhsbTtrffdtuzPgsGXITfM=; b=e3XvWSqyGJyTPGOB1K+RAuG7Lapbf9zPsBD40X/CmWeocMVTUARXWa4iUjhI5fUKMN8e5KgEmfBS evHd6T8XCbGQZ0Wr8lwUol5tbEe9/Rbwt1UEOqyp8f7iOSEZVnQM
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

Always set an IBAT covering up to _einittext during init because when
CONFIG_MODULES is not selected there is no reason to have an exception
handler for kernel instruction TLB misses.

It implies DBAT and IBAT are now totaly independent, IBATs are set
by setibat() and DBAT by setbat().

This allows to revert commit 9bb162fa26ed ("powerpc/603: Fix
boot failure with DEBUG_PAGEALLOC and KFENCE")

Reported-by: Maxime Bizon <mbizon@freebox.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S |  4 ++--
 arch/powerpc/mm/book3s32/mmu.c       | 10 ++++------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 6c739beb938c..519b60695167 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -418,14 +418,14 @@ InstructionTLBMiss:
  */
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
-#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
+#ifdef CONFIG_MODULES
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
 	cmplw	0,r1,r3
 #endif
 	mfspr	r2, SPRN_SDR1
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC | _PAGE_USER
 	rlwinm	r2, r2, 28, 0xfffff000
-#if defined(CONFIG_MODULES) || defined(CONFIG_DEBUG_PAGEALLOC) || defined(CONFIG_KFENCE)
+#ifdef CONFIG_MODULES
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
diff --git a/arch/powerpc/mm/book3s32/mmu.c b/arch/powerpc/mm/book3s32/mmu.c
index 49a737fbbd18..40029280c320 100644
--- a/arch/powerpc/mm/book3s32/mmu.c
+++ b/arch/powerpc/mm/book3s32/mmu.c
@@ -159,7 +159,10 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 {
 	unsigned long done;
 	unsigned long border = (unsigned long)__init_begin - PAGE_OFFSET;
+	unsigned long size;
 
+	size = roundup_pow_of_two((unsigned long)_einittext - PAGE_OFFSET);
+	setibat(0, PAGE_OFFSET, 0, size, PAGE_KERNEL_X);
 
 	if (debug_pagealloc_enabled_or_kfence() || __map_without_bats) {
 		pr_debug_once("Read-Write memory mapped without BATs\n");
@@ -245,10 +248,9 @@ void mmu_mark_rodata_ro(void)
 }
 
 /*
- * Set up one of the I/D BAT (block address translation) register pairs.
+ * Set up one of the D BAT (block address translation) register pairs.
  * The parameters are not checked; in particular size must be a power
  * of 2 between 128k and 256M.
- * On 603+, only set IBAT when _PAGE_EXEC is set
  */
 void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		   unsigned int size, pgprot_t prot)
@@ -284,10 +286,6 @@ void __init setbat(int index, unsigned long virt, phys_addr_t phys,
 		/* G bit must be zero in IBATs */
 		flags &= ~_PAGE_EXEC;
 	}
-	if (flags & _PAGE_EXEC)
-		bat[0] = bat[1];
-	else
-		bat[0].batu = bat[0].batl = 0;
 
 	bat_addrs[index].start = virt;
 	bat_addrs[index].limit = virt + ((bl + 1) << 17) - 1;
-- 
2.36.1

