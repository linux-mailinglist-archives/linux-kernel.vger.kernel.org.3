Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68342466301
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357711AbhLBMF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:05:26 -0500
Received: from pegase2.c-s.fr ([93.17.235.10]:55019 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1357626AbhLBMFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:05:18 -0500
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4J4ZKV0k8Dz9sT3;
        Thu,  2 Dec 2021 13:00:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KoZyMEmFwKPV; Thu,  2 Dec 2021 13:00:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4J4ZKM153wz9sSw;
        Thu,  2 Dec 2021 13:00:39 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FD398B7C4;
        Thu,  2 Dec 2021 13:00:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qNd-pJtiBJps; Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.163])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 54B2B8B7CB;
        Thu,  2 Dec 2021 13:00:38 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 1B2C0Wbv177273
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Dec 2021 13:00:32 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 1B2C0WKb177272;
        Thu, 2 Dec 2021 13:00:32 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 09/11] powerpc/code-patching: Move instr_is_branch_{i/b}form() in code-patching.h
Date:   Thu,  2 Dec 2021 13:00:25 +0100
Message-Id: <fca0f3b191211b3681020885a611bf73eef20563.1638446239.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
References: <3ff9823c0a812a8a145d979a9600a6d4591b80ee.1638446239.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1638446425; l=2047; s=20211009; h=from:subject:message-id; bh=wRDSISeicKDJX6JeNkgMtSJNyflikmT2k1wJ8bYmY5c=; b=klC2D+6jP1pd2auvXwF/87IrfjkrJm4iCn1AgeBISGbBm1r0hSDajSW/4U8g2UD6YiKRM3T0YVa6 9F3ciZiQC9WuRdwR4ViiW4MGVdF2ZmdR6oZl+Jr6FMJlued1jrdE
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable moving selftests in their own C file in following patch,
move instr_is_branch_iform() and instr_is_branch_bform()
to code-patching.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/code-patching.h | 15 +++++++++++++++
 arch/powerpc/lib/code-patching.c         | 15 ---------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/code-patching.h b/arch/powerpc/include/asm/code-patching.h
index 275061c3c977..e26080539c31 100644
--- a/arch/powerpc/include/asm/code-patching.h
+++ b/arch/powerpc/include/asm/code-patching.h
@@ -58,6 +58,21 @@ static inline int modify_instruction_site(s32 *site, unsigned int clr, unsigned
 	return modify_instruction((unsigned int *)patch_site_addr(site), clr, set);
 }
 
+static inline unsigned int branch_opcode(ppc_inst_t instr)
+{
+	return ppc_inst_primary_opcode(instr) & 0x3F;
+}
+
+static inline int instr_is_branch_iform(ppc_inst_t instr)
+{
+	return branch_opcode(instr) == 18;
+}
+
+static inline int instr_is_branch_bform(ppc_inst_t instr)
+{
+	return branch_opcode(instr) == 16;
+}
+
 int instr_is_relative_branch(ppc_inst_t instr);
 int instr_is_relative_link_branch(ppc_inst_t instr);
 unsigned long branch_target(const u32 *instr);
diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 17e6443eb6c8..e07de5db06c0 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -285,21 +285,6 @@ int create_cond_branch(ppc_inst_t *instr, const u32 *addr,
 	return 0;
 }
 
-static unsigned int branch_opcode(ppc_inst_t instr)
-{
-	return ppc_inst_primary_opcode(instr) & 0x3F;
-}
-
-static int instr_is_branch_iform(ppc_inst_t instr)
-{
-	return branch_opcode(instr) == 18;
-}
-
-static int instr_is_branch_bform(ppc_inst_t instr)
-{
-	return branch_opcode(instr) == 16;
-}
-
 int instr_is_relative_branch(ppc_inst_t instr)
 {
 	if (ppc_inst_val(instr) & BRANCH_ABSOLUTE)
-- 
2.33.1

