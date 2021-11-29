Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3DD461D28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245084AbhK2R7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:59:25 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:37095 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233231AbhK2R5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:57:23 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J2tCq6gKXz9sSr;
        Mon, 29 Nov 2021 18:49:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id opmSJnmzTvVT; Mon, 29 Nov 2021 18:49:59 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J2tCn6kz4z9sSh;
        Mon, 29 Nov 2021 18:49:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D35828B7B2;
        Mon, 29 Nov 2021 18:49:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7SepyU8EpgJH; Mon, 29 Nov 2021 18:49:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.92])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 59CA38B7AD;
        Mon, 29 Nov 2021 18:49:57 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1ATHno0J015562
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 18:49:50 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1ATHnoTp015561;
        Mon, 29 Nov 2021 18:49:50 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v5 3/5] powerpc/inst: Define ppc_inst_t as u32 on PPC32
Date:   Mon, 29 Nov 2021 18:49:39 +0100
Message-Id: <c6d0c46f598f76ad0b0a88bc0d84773bd921b17c.1638208156.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
References: <1f0ede830ccb33a659119a55cb590820c27004db.1638208156.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638208179; l=2480; s=20211009; h=from:subject:message-id; bh=bRSXL/bM2fHo0+BAsYi79ROpQjL4J98x+R5UsmSQH6w=; b=7fWmrDcjPGQDzRKmPO+3yLfzB8eKw5YZVJgCxvuDvDHx5Oc3XXj9aJVowao5kGJt7NWQZJe7IdWa jjmwB5ZkBMTVuadzGInNqMo3MsH3AtdnuvpXGCmZzGoUoqroaDgK
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike PPC64 ABI, PPC32 uses the stack to pass a parameter defined
as a struct, even when the struct has a single simple element.

To avoid that, define ppc_inst_t as u32 on PPC32.

Keep it as 'struct ppc_inst' when __CHECKER__ is defined so that
sparse can perform type checking.

Also revert commit 511eea5e2ccd ("powerpc/kprobes: Fix Oops by passing
ppc_inst as a pointer to emulate_step() on ppc32") as now the
instruction to be emulated is passed as a register to emulate_step().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Make it work with kprobes
---
 arch/powerpc/include/asm/inst.h | 15 +++++++++++++--
 arch/powerpc/kernel/optprobes.c |  8 ++------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/inst.h b/arch/powerpc/include/asm/inst.h
index b3502f21e0f4..7ef5fd3bb167 100644
--- a/arch/powerpc/include/asm/inst.h
+++ b/arch/powerpc/include/asm/inst.h
@@ -34,6 +34,7 @@
  * Instruction data type for POWER
  */
 
+#if defined(CONFIG_PPC64) || defined(__CHECKER__)
 typedef struct {
 	u32 val;
 #ifdef CONFIG_PPC64
@@ -46,13 +47,23 @@ static inline u32 ppc_inst_val(ppc_inst_t x)
 	return x.val;
 }
 
+#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
+
+#else
+typedef u32 ppc_inst_t;
+
+static inline u32 ppc_inst_val(ppc_inst_t x)
+{
+	return x;
+}
+#define ppc_inst(x) (x)
+#endif
+
 static inline int ppc_inst_primary_opcode(ppc_inst_t x)
 {
 	return ppc_inst_val(x) >> 26;
 }
 
-#define ppc_inst(x) ((ppc_inst_t){ .val = (x) })
-
 #ifdef CONFIG_PPC64
 #define ppc_inst_prefix(x, y) ((ppc_inst_t){ .val = (x), .suffix = (y) })
 
diff --git a/arch/powerpc/kernel/optprobes.c b/arch/powerpc/kernel/optprobes.c
index 378db980ded3..3b1c2236cbee 100644
--- a/arch/powerpc/kernel/optprobes.c
+++ b/arch/powerpc/kernel/optprobes.c
@@ -228,12 +228,8 @@ int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *p)
 	/*
 	 * 3. load instruction to be emulated into relevant register, and
 	 */
-	if (IS_ENABLED(CONFIG_PPC64)) {
-		temp = ppc_inst_read(p->ainsn.insn);
-		patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
-	} else {
-		patch_imm_load_insns((unsigned long)p->ainsn.insn, 4, buff + TMPL_INSN_IDX);
-	}
+	temp = ppc_inst_read(p->ainsn.insn);
+	patch_imm_load_insns(ppc_inst_as_ulong(temp), 4, buff + TMPL_INSN_IDX);
 
 	/*
 	 * 4. branch back from trampoline
-- 
2.33.1

