Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C4F4E432E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiCVPmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238674AbiCVPmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:42:15 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CD8BE1A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:40:48 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KNG0R0yW5z9sTQ;
        Tue, 22 Mar 2022 16:40:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uFfBl0zt-ofa; Tue, 22 Mar 2022 16:40:39 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KNG0N0NGJz9sTT;
        Tue, 22 Mar 2022 16:40:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F03E78B774;
        Tue, 22 Mar 2022 16:40:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TIeO7rkuVip6; Tue, 22 Mar 2022 16:40:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.14])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 97A248B763;
        Tue, 22 Mar 2022 16:40:35 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22MFeUux1513374
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 16:40:30 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22MFeUtJ1513373;
        Tue, 22 Mar 2022 16:40:30 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/4] powerpc/code-patching: Use jump_label for testing freed initmem
Date:   Tue, 22 Mar 2022 16:40:20 +0100
Message-Id: <0aee964721cab7316cffde21a2ca223cee14d373.1647962456.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647962456.git.christophe.leroy@csgroup.eu>
References: <cover.1647962456.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1647963619; l=2469; s=20211009; h=from:subject:message-id; bh=lospu3LTx6JL+bF7CXBGRzqT/qZ+/MCraSgpnZzmhtw=; b=g9l17FQMJr6yrEZPgNG+4p15OSDMMEY5JeDtpnZVp+/OOFsFar8jgaLPRnJ4XeKEfoavmTx0EaH2 U05xBb8qBX4s+DRAV+Fcy92l52v4AyJN2roz1MqnvUdtQQWOszJA
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

Once init is done, initmem is freed forever so no need to
test system_state at every call to patch_instruction().

Use jump_label.

This reduces by 2% the time needed to activate ftrace on an 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 2 ++
 arch/powerpc/lib/code-patching.c         | 5 ++++-
 arch/powerpc/mm/mem.c                    | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 409483b2d0ce..bccc3a538b9f 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -22,6 +22,8 @@
 #define BRANCH_SET_LINK	0x1
 #define BRANCH_ABSOLUTE	0x2
 
+DECLARE_STATIC_KEY_FALSE(init_mem_is_free);
+
 bool is_offset_in_branch_range(long offset);
 bool is_offset_in_cond_branch_range(long offset);
 int create_branch(ppc_inst_t *instr, const u32 *addr,
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 62692c6031bc..ab434c3853c9 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -8,6 +8,7 @@
 #include <linux/init.h>
 #include <linux/cpuhotplug.h>
 #include <linux/uaccess.h>
+#include <linux/jump_label.h>
 
 #include <asm/tlbflush.h>
 #include <asm/page.h>
@@ -193,10 +194,12 @@ static int do_patch_instruction(u32 *addr, ppc_inst_t instr)
 
 #endif /* CONFIG_STRICT_KERNEL_RWX */
 
+__ro_after_init DEFINE_STATIC_KEY_FALSE(init_mem_is_free);
+
 int patch_instruction(u32 *addr, ppc_inst_t instr)
 {
 	/* Make sure we aren't patching a freed init section */
-	if (system_state >= SYSTEM_FREEING_INITMEM && init_section_contains(addr, 4))
+	if (static_branch_likely(&init_mem_is_free) && init_section_contains(addr, 4))
 		return 0;
 
 	return do_patch_instruction(addr, instr);
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8e301cd8925b..9710d4e0bf08 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -22,6 +22,7 @@
 #include <asm/kasan.h>
 #include <asm/svm.h>
 #include <asm/mmzone.h>
+#include <asm/code-patching.h>
 
 #include <mm/mmu_decl.h>
 
@@ -311,6 +312,7 @@ void free_initmem(void)
 {
 	ppc_md.progress = ppc_printk_progress;
 	mark_initmem_nx();
+	static_branch_enable(&init_mem_is_free);
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-- 
2.35.1

