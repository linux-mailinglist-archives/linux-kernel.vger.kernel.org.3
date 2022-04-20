Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1134507DBA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358622AbiDTAqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 20:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358616AbiDTAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 20:46:03 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A8817A93;
        Tue, 19 Apr 2022 17:43:17 -0700 (PDT)
Received: (Authenticated sender: joao@overdrivepizza.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 964FC1BF205;
        Wed, 20 Apr 2022 00:43:08 +0000 (UTC)
From:   joao@overdrivepizza.com
To:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     joao@overdrivepizza.com, peterz@infradead.org, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com, hjl.tools@gmail.com,
        alyssa.milburn@linux.intel.com, ndesaulniers@google.com,
        gabriel.gomes@linux.intel.com, rick.p.edgecombe@intel.com
Subject: [RFC PATCH 04/11] x86/module: Support FineIBT in modules
Date:   Tue, 19 Apr 2022 17:42:34 -0700
Message-Id: <20220420004241.2093-5-joao@overdrivepizza.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420004241.2093-1-joao@overdrivepizza.com>
References: <20220420004241.2093-1-joao@overdrivepizza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joao Moreira <joao@overdrivepizza.com>

Identify direct branch relocations targeting FineIBT hash check
sequence and fix the offset to bypass it.

Invoke objtool with fineibt flag for modules to fix in-module
direct branches too.

Signed-off-by: Joao Moreira <joao@overdrivepizza.com>
Tinkered-from-patches-by: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/kernel/module.c | 45 +++++++++++++++++++++++++++++++++++++---
 scripts/Makefile.build   |  1 +
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b98ffcf4d250..4afe71ae3e56 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -128,6 +128,41 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
+
+// shamelessly reshaped from PeterZ's IBT patches v2
+static inline void fineibt_branch_fix(void *loc, u64 *val)
+{
+#ifdef CONFIG_X86_KERNEL_FINEIBT
+	const void *addr = (void *)(4 + *val);
+	union text_poke_insn text;
+	u32 insn;
+
+	if (get_kernel_nofault(insn, addr) || !is_endbr(insn))
+		return;
+
+	if (get_kernel_nofault(text, addr+4) || text.opcode != SUB_INSN_OPCODE)
+		return;
+
+	if (get_kernel_nofault(text, addr+11) || text.opcode != JE_INSN_OPCODE)
+		return;
+
+	if (get_kernel_nofault(text, addr+13) ||
+			text.opcode != CALL_INSN_OPCODE)
+		return;
+
+	/* validate jmp.d32/call @ loc */
+	if (WARN_ONCE(get_kernel_nofault(text, loc-1) ||
+				(text.opcode != CALL_INSN_OPCODE &&
+				 text.opcode != JMP32_INSN_OPCODE),
+				"Unexpected code at: %pS\n", loc))
+		return;
+
+	DEBUGP("FineIBT fixed direct branch: %pS\n", addr);
+
+	*val += 18;
+#endif
+}
+
 static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
@@ -139,6 +174,7 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	void *loc;
+	int type;
 	u64 val;
 
 	DEBUGP("Applying relocate section %u to %u\n",
@@ -153,13 +189,14 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
 			+ ELF64_R_SYM(rel[i].r_info);
 
+		type = ELF64_R_TYPE(rel[i].r_info);
+
 		DEBUGP("type %d st_value %Lx r_addend %Lx loc %Lx\n",
-		       (int)ELF64_R_TYPE(rel[i].r_info),
-		       sym->st_value, rel[i].r_addend, (u64)loc);
+		       type, sym->st_value, rel[i].r_addend, (u64)loc);
 
 		val = sym->st_value + rel[i].r_addend;
 
-		switch (ELF64_R_TYPE(rel[i].r_info)) {
+		switch (type) {
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
@@ -185,6 +222,8 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_X86_64_PLT32:
 			if (*(u32 *)loc != 0)
 				goto invalid_relocation;
+			if (type == R_X86_64_PLT32)
+				fineibt_branch_fix(loc, &val);
 			val -= (u64)loc;
 			write(loc, &val, 4);
 #if 0
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f6fb31..d8862673b416 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -230,6 +230,7 @@ objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
+	$(if $(CONFIG_X86_KERNEL_FINEIBT), --fineibt)			\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-- 
2.35.1

