Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB96466303
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346662AbhLBMFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:05:38 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:55019 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357612AbhLBMFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:05:25 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J4ZKX2mk9z9sSw;
        Thu,  2 Dec 2021 13:00:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Udl5Is05eNWq; Thu,  2 Dec 2021 13:00:48 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J4ZKM3TKsz9sSP;
        Thu,  2 Dec 2021 13:00:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 67EC88B7C4;
        Thu,  2 Dec 2021 13:00:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5KggCfnswrgq; Thu,  2 Dec 2021 13:00:39 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.163])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 664788B7CE;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1B2C0WWY177269
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Dec 2021 13:00:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1B2C0WM4177268;
        Thu, 2 Dec 2021 13:00:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 08/11] powerpc/code-patching: Move patch_exception() outside code-patching.c
Date:   Thu,  2 Dec 2021 13:00:24 +0100
Message-Id: <0968622b98b1fb51838c35b844c42ad6609de62e.1638446239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
References: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638446425; l=4578; s=20211009; h=from:subject:message-id; bh=/sU9qLAAbjwWQ/OLRmi5hB7Ehm7QyNUrCpfZcIEhskM=; b=sHSU/xC2pN6My3HrLkFkgTYLcNGetV0r1HEhaz79SUJ5AyJqb4ioJQ+Ud+G+HRixEfk5eOmpufv+ xC5m8zzMCldnZX9/4M/5BOa6IhhVnI31QHxmdFxLND6CwQK5X9mZ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

patch_exception() is dedicated to book3e/64 is nothing more than
a normal use of patch_branch(), so move it into a place dedicated
to book3e/64.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h     |  7 -------
 arch/powerpc/include/asm/exception-64e.h     |  4 ++++
 arch/powerpc/include/asm/nohash/64/pgtable.h |  6 ++++++
 arch/powerpc/lib/code-patching.c             | 16 ----------------
 arch/powerpc/mm/nohash/book3e_pgtable.c      | 14 ++++++++++++++
 5 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 46e8c5a8ce51..275061c3c977 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -63,13 +63,6 @@ int instr_is_relative_link_branch(ppc_inst_t instr);
 unsigned long branch_target(const u32 *instr);
 int translate_branch(ppc_inst_t *instr, const u32 *dest, const u32 *src);
 bool is_conditional_branch(ppc_inst_t instr);
-#ifdef CONFIG_PPC_BOOK3E_64
-void __patch_exception(int exc, unsigned long addr);
-#define patch_exception(exc, name) do { \
-	extern unsigned int name; \
-	__patch_exception((exc), (unsigned long)&name); \
-} while (0)
-#endif
 
 #define OP_RT_RA_MASK	0xffff0000UL
 #define LIS_R2		(PPC_RAW_LIS(_R2, 0))
diff --git a/arch/powerpc/include/asm/exception-64e.h b/arch/powerpc/include/asm/exception-64e.h
index 40cdcb2fb057..b1ef1e92c34a 100644
--- a/arch/powerpc/include/asm/exception-64e.h
+++ b/arch/powerpc/include/asm/exception-64e.h
@@ -149,6 +149,10 @@ exc_##label##_book3e:
 	addi	r11,r13,PACA_EXTLB;					    \
 	TLB_MISS_RESTORE(r11)
 
+#ifndef __ASSEMBLY__
+extern unsigned int interrupt_base_book3e;
+#endif
+
 #define SET_IVOR(vector_number, vector_offset)	\
 	LOAD_REG_ADDR(r3,interrupt_base_book3e);\
 	ori	r3,r3,vector_offset@l;		\
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index 9d2905a47410..a3313e853e5e 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -313,6 +313,12 @@ extern int __meminit vmemmap_create_mapping(unsigned long start,
 					    unsigned long phys);
 extern void vmemmap_remove_mapping(unsigned long start,
 				   unsigned long page_size);
+void __patch_exception(int exc, unsigned long addr);
+#define patch_exception(exc, name) do { \
+	extern unsigned int name; \
+	__patch_exception((exc), (unsigned long)&name); \
+} while (0)
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_NOHASH_64_PGTABLE_H */
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 2d878e67df3f..17e6443eb6c8 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -370,22 +370,6 @@ int translate_branch(ppc_inst_t *instr, const u32 *dest, const u32 *src)
 	return 1;
 }
 
-#ifdef CONFIG_PPC_BOOK3E_64
-void __patch_exception(int exc, unsigned long addr)
-{
-	extern unsigned int interrupt_base_book3e;
-	unsigned int *ibase = &interrupt_base_book3e;
-
-	/* Our exceptions vectors start with a NOP and -then- a branch
-	 * to deal with single stepping from userspace which stops on
-	 * the second instruction. Thus we need to patch the second
-	 * instruction of the exception, not the first one
-	 */
-
-	patch_branch(ibase + (exc / 4) + 1, addr, 0);
-}
-#endif
-
 #ifdef CONFIG_CODE_PATCHING_SELFTEST
 
 static int instr_is_branch_to_addr(const u32 *instr, unsigned long addr)
diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
index 77884e24281d..7b6db97c2bdc 100644
--- a/arch/powerpc/mm/nohash/book3e_pgtable.c
+++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
@@ -10,6 +10,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/dma.h>
+#include <asm/code-patching.h>
 
 #include <mm/mmu_decl.h>
 
@@ -115,3 +116,16 @@ int __ref map_kernel_page(unsigned long ea, unsigned long pa, pgprot_t prot)
 	smp_wmb();
 	return 0;
 }
+
+void __patch_exception(int exc, unsigned long addr)
+{
+	unsigned int *ibase = &interrupt_base_book3e;
+
+	/* Our exceptions vectors start with a NOP and -then- a branch
+	 * to deal with single stepping from userspace which stops on
+	 * the second instruction. Thus we need to patch the second
+	 * instruction of the exception, not the first one
+	 */
+
+	patch_branch(ibase + (exc / 4) + 1, addr, 0);
+}
-- 
2.33.1

