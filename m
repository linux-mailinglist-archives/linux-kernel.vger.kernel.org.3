Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61C5340E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237901AbiEYP7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234692AbiEYP67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:58:59 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC76A045
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:58:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L7bMp44C4z9tFP;
        Wed, 25 May 2022 17:58:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IudBluSszBof; Wed, 25 May 2022 17:58:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L7bMk5Tfnz9tFQ;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A64068B778;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dgbKZko-DR1S; Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F92A8B779;
        Wed, 25 May 2022 17:58:42 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24PFwQQw419144
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 25 May 2022 17:58:26 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24PFwQvv419143;
        Wed, 25 May 2022 17:58:26 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, peterz@infradead.org,
        aik@ozlabs.ru, sv@linux.ibm.com, rostedt@goodmis.org,
        jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v1 2/4] objtool: Add R_REL32 macro
Date:   Wed, 25 May 2022 17:58:15 +0200
Message-Id: <35932b18ea948cbc1e7ec9d006e4575641a4daa5.1653494186.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1653494186.git.christophe.leroy@csgroup.eu>
References: <cover.1653494186.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653494295; l=3240; s=20211009; h=from:subject:message-id; bh=HeAHS6wno4JDo4xXjHYp0mjmOd64h8tHFwO+XOy3g1s=; b=5MOLe86ugZeE8gnNNaNKg0O07wJ8+iarURLC6rBBVfly3pTT/G0Wx84X7GsxpXrA9LkqAFrU667k KVxgz77HBQl13FUfPqfFc1SJPSHKLcgQiQGo8ZWZgYii9Hw38eYJ
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

In order to allow other architectures than x86 to use 32 bits
relative relocations, define a R_REL32 macro that each architecture
will define, in the same way as already done for R_NONE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/objtool/arch/x86/include/arch/elf.h |  1 +
 tools/objtool/check.c                     | 10 +++++-----
 tools/objtool/orc_gen.c                   |  2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/arch/x86/include/arch/elf.h b/tools/objtool/arch/x86/include/arch/elf.h
index 69cc4264b28a..8aa8c29607da 100644
--- a/tools/objtool/arch/x86/include/arch/elf.h
+++ b/tools/objtool/arch/x86/include/arch/elf.h
@@ -2,5 +2,6 @@
 #define _OBJTOOL_ARCH_ELF
 
 #define R_NONE R_X86_64_NONE
+#define R_REL32	R_X86_64_PC32
 
 #endif /* _OBJTOOL_ARCH_ELF */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 70be5a72e838..1627d14a01c9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -650,7 +650,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		/* populate reloc for 'addr' */
 		if (elf_add_reloc_to_insn(file->elf, sec,
 					  idx * sizeof(struct static_call_site),
-					  R_X86_64_PC32,
+					  R_REL32,
 					  insn->sec, insn->offset))
 			return -1;
 
@@ -691,7 +691,7 @@ static int create_static_call_sections(struct objtool_file *file)
 		/* populate reloc for 'key' */
 		if (elf_add_reloc(file->elf, sec,
 				  idx * sizeof(struct static_call_site) + 4,
-				  R_X86_64_PC32, key_sym,
+				  R_REL32, key_sym,
 				  is_sibling_call(insn) * STATIC_CALL_SITE_TAIL))
 			return -1;
 
@@ -735,7 +735,7 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
 
 		if (elf_add_reloc_to_insn(file->elf, sec,
 					  idx * sizeof(int),
-					  R_X86_64_PC32,
+					  R_REL32,
 					  insn->sec, insn->offset)) {
 			WARN("elf_add_reloc_to_insn: .retpoline_sites");
 			return -1;
@@ -787,7 +787,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 
 		if (elf_add_reloc_to_insn(file->elf, sec,
 					  idx * sizeof(int),
-					  R_X86_64_PC32,
+					  R_REL32,
 					  insn->sec, insn->offset)) {
 			WARN("elf_add_reloc_to_insn: .ibt_endbr_seal");
 			return -1;
@@ -3716,7 +3716,7 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 
 		off = reloc->sym->offset;
-		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		if (reloc->type == R_REL32 || reloc->type == R_X86_64_PLT32)
 			off += arch_dest_reloc_offset(reloc->addend);
 		else
 			off += reloc->addend;
diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 1f22b7ebae58..49a877b9c879 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -101,7 +101,7 @@ static int write_orc_entry(struct elf *elf, struct section *orc_sec,
 	orc->bp_offset = bswap_if_needed(elf, orc->bp_offset);
 
 	/* populate reloc for ip */
-	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_X86_64_PC32,
+	if (elf_add_reloc_to_insn(elf, ip_sec, idx * sizeof(int), R_REL32,
 				  insn_sec, insn_off))
 		return -1;
 
-- 
2.35.3

