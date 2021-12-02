Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740664662F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357615AbhLBMEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:04:15 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:49557 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357581AbhLBMEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:04:08 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J4ZKN0y6jz9sT6;
        Thu,  2 Dec 2021 13:00:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WrqxKG4E2YYK; Thu,  2 Dec 2021 13:00:40 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J4ZKL6QjSz9sSM;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC78E8B7C5;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id s0JAvnKwLXXD; Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.163])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E6228B7C8;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1B2C0Vd7177249
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Dec 2021 13:00:31 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1B2C0VRw177248;
        Thu, 2 Dec 2021 13:00:31 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 03/11] powerpc/code-patching: Fix error handling in do_patch_instruction()
Date:   Thu,  2 Dec 2021 13:00:19 +0100
Message-Id: <85259d894069e47f915ea580b169e1adbeec7a61.1638446239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
References: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638446424; l=1451; s=20211009; h=from:subject:message-id; bh=Dmm8aG4rMQU3IgEeb3nRDZ2TR6qNJxYi+D8mNebrJjs=; b=id5uTKf3dNxXwp4YT3SPds366HjSjT24Zqme/D+sfC5OERxyyAYa6G3YknHCs6fqpWPnPuckGWrO 224QBZVmB6qtihShGLbGOpMcC0q9eamm8EOH3mSiv3WXbEcYhetJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use real errors instead of using -1 as error, so that errors
returned by callees can be used towards callers.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 7bb8dd2dc19e..4ce2b6457757 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -85,19 +85,13 @@ void __init poking_init(void)
 static int map_patch_area(void *addr, unsigned long text_poke_addr)
 {
 	unsigned long pfn;
-	int err;
 
 	if (is_vmalloc_or_module_addr(addr))
 		pfn = vmalloc_to_pfn(addr);
 	else
 		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
 
-	err = map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
-
-	if (err)
-		return -1;
-
-	return 0;
+	return map_kernel_page(text_poke_addr, (pfn << PAGE_SHIFT), PAGE_KERNEL);
 }
 
 static inline int unmap_patch_area(unsigned long addr)
@@ -156,10 +150,9 @@ static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
 	local_irq_save(flags);
 
 	text_poke_addr = (unsigned long)__this_cpu_read(text_poke_area)->addr;
-	if (map_patch_area(addr, text_poke_addr)) {
-		err = -1;
+	err = map_patch_area(addr, text_poke_addr);
+	if (err)
 		goto out;
-	}
 
 	patch_addr = (u32 *)(text_poke_addr + (kaddr & ~PAGE_MASK));
 
-- 
2.33.1

