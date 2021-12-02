Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFB44662FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357704AbhLBMEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:04:45 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:49557 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357607AbhLBMEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:04:15 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J4ZKQ6NJzz9sSf;
        Thu,  2 Dec 2021 13:00:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w2r8O-DqWHCF; Thu,  2 Dec 2021 13:00:42 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J4ZKL6qvRz9sSm;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E19B28B7C8;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id SXqztKQCMB8f; Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.163])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 488098B7C6;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1B2C0Vts177245
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Dec 2021 13:00:31 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1B2C0Vow177244;
        Thu, 2 Dec 2021 13:00:31 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 02/11] powerpc/code-patching: Remove init_mem_is_free
Date:   Thu,  2 Dec 2021 13:00:18 +0100
Message-Id: <ad8c3ccb39c8edaa89fd3eda1cc7218baea1cde5.1638446239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
References: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638446424; l=2406; s=20211009; h=from:subject:message-id; bh=HLfje8baahqPsWu1CyLIFxbGVxaxwwGQflvuvP9n5k0=; b=Q3oBY9AzuU/3NoKIkeE7JjkogePg8sQU62lFSShHvGxB9eoaE+op9O5a+LF0hQWPN7t6QihHSg+r re/iKRPUBQTBIkBSIf66K8PzDmcVGpM7/86Jsno6FXhww50jZp8j
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new state has been added by commit d2635f2012a4 ("mm: create a new
system state and fix core_kernel_text()"). That state tells when
initmem is about to be released and is redundant with init_mem_is_free.

Remove init_mem_is_free.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/setup.h | 1 -
 arch/powerpc/lib/code-patching.c | 3 +--
 arch/powerpc/mm/mem.c            | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 6c1a7d217d1a..426a2d8d028f 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -9,7 +9,6 @@ extern void ppc_printk_progress(char *s, unsigned short hex);
 
 extern unsigned int rtas_data;
 extern unsigned long long memory_limit;
-extern bool init_mem_is_free;
 extern void *zalloc_maybe_bootmem(size_t size, gfp_t mask);
 
 struct device_node;
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 4fe4464b7a84..7bb8dd2dc19e 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -15,7 +15,6 @@
 #include <asm/tlbflush.h>
 #include <asm/page.h>
 #include <asm/code-patching.h>
-#include <asm/setup.h>
 #include <asm/inst.h>
 
 static int __patch_instruction(u32 *exec_addr, ppc_inst_t instr, u32 *patch_addr)
@@ -187,7 +186,7 @@ static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
 int patch_instruction(u32 *addr, ppc_inst_t instr)
 {
 	/* Make sure we aren't patching a freed init section */
-	if (init_mem_is_free && init_section_contains(addr, 4))
+	if (system_state >= SYSTEM_FREEING_INITMEM && init_section_contains(addr, 4))
 		return 0;
 
 	return do_patch_instruction(addr, instr);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index bd5d91a31183..8e301cd8925b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -26,7 +26,6 @@
 #include <mm/mmu_decl.h>
 
 unsigned long long memory_limit;
-bool init_mem_is_free;
 
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
@@ -312,7 +311,6 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
-	init_mem_is_free = true;
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.33.1

