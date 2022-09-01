Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664DD5A9DDD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 19:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbiIARQL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Sep 2022 13:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiIARQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 13:16:02 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF9D40E1C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 10:16:01 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2819eLaI032534
        for <linux-kernel@vger.kernel.org>; Thu, 1 Sep 2022 10:16:00 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ja8n3h6gq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 10:16:00 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 10:15:58 -0700
Received: by devbig932.frc1.facebook.com (Postfix, from userid 4523)
        id 447B8C567595; Thu,  1 Sep 2022 10:12:56 -0700 (PDT)
From:   Song Liu <song@kernel.org>
To:     <live-patching@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@kernel.org>, <jikos@kernel.org>, <mbenes@suse.cz>,
        <pmladek@suse.com>, <x86@kernel.org>, <joe.lawrence@redhat.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Song Liu <song@kernel.org>
Subject: [PATCH v6] livepatch: Clear relocation targets on a module removal
Date:   Thu, 1 Sep 2022 10:12:52 -0700
Message-ID: <20220901171252.2148348-1-song@kernel.org>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: rnMSrou92P5T74sqN8w3TcZxcs_POtyF
X-Proofpoint-ORIG-GUID: rnMSrou92P5T74sqN8w3TcZxcs_POtyF
Content-Transfer-Encoding: 8BIT
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-01_10,2022-08-31_03,2022-06-22_01
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Benes <mbenes@suse.cz>

Josh reported a bug:

  When the object to be patched is a module, and that module is
  rmmod'ed and reloaded, it fails to load with:

  module: x86/modules: Skipping invalid relocation target, existing value is nonzero for type 2, loc 00000000ba0302e9, val ffffffffa03e293c
  livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
  livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'

  The livepatch module has a relocation which references a symbol
  in the _previous_ loading of nfsd. When apply_relocate_add()
  tries to replace the old relocation with a new one, it sees that
  the previous one is nonzero and it errors out.

  On ppc64le, we have a similar issue:

  module_64: livepatch_nfsd: Expected nop after call, got e8410018 at e_show+0x60/0x548 [livepatch_nfsd]
  livepatch: failed to initialize patch 'livepatch_nfsd' for module 'nfsd' (-8)
  livepatch: patch 'livepatch_nfsd' failed for module 'nfsd', refusing to load module 'nfsd'

He also proposed three different solutions. We could remove the error
check in apply_relocate_add() introduced by commit eda9cec4c9a1
("x86/module: Detect and skip invalid relocations"). However the check
is useful for detecting corrupted modules.

We could also deny the patched modules to be removed. If it proved to be
a major drawback for users, we could still implement a different
approach. The solution would also complicate the existing code a lot.

We thus decided to reverse the relocation patching (clear all relocation
targets on x86_64). The solution is not
universal and is too much arch-specific, but it may prove to be simpler
in the end.

Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Song Liu <song@kernel.org>

---

NOTE: powerpc32 code is only compile tested.

Changes v5 = v6:
1. Fix powerpc64.
2. Fix compile for powerpc32.

Changes v4 = v5:
1. Fix compile with powerpc.

Changes v3 = v4:
1. Reuse __apply_relocate_add to make it more reliable in long term.
   (Josh Poimboeuf)
2. Add back ppc64 logic from v2, with changes to match current code.
   (Josh Poimboeuf)

Changes v2 => v3:
1. Rewrite x86 changes to match current code style.
2. Remove powerpc changes as there is no test coverage in v3.
3. Only keep 1/3 of v2.

v2: https://lore.kernel.org/all/20190905124514.8944-1-mbenes@suse.cz/T/#u
---
 arch/powerpc/kernel/module_32.c |  10 ++++
 arch/powerpc/kernel/module_64.c |  49 +++++++++++++++
 arch/s390/kernel/module.c       |   8 +++
 arch/x86/kernel/module.c        | 102 +++++++++++++++++++++++---------
 include/linux/moduleloader.h    |   7 +++
 kernel/livepatch/core.c         |  41 ++++++++++++-
 6 files changed, 189 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index ea6536171778..e3c312770453 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -285,6 +285,16 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 	return 0;
 }
 
+#ifdef CONFIG_LIVEPATCH
+void clear_relocate_add(Elf32_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me)
+{
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 notrace int module_trampoline_target(struct module *mod, unsigned long addr,
 				     unsigned long *target)
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 7e45dc98df8a..514951f97391 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -739,6 +739,55 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	return 0;
 }
 
+#ifdef CONFIG_LIVEPATCH
+void clear_relocate_add(Elf64_Shdr *sechdrs,
+		       const char *strtab,
+		       unsigned int symindex,
+		       unsigned int relsec,
+		       struct module *me)
+{
+	unsigned int i;
+	Elf64_Rela *rela = (void *)sechdrs[relsec].sh_addr;
+	Elf64_Sym *sym;
+	unsigned long *location;
+	const char *symname;
+	u32 *instruction;
+
+	pr_debug("Clearing ADD relocate section %u to %u\n", relsec,
+		 sechdrs[relsec].sh_info);
+
+	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rela); i++) {
+		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rela[i].r_offset;
+		sym = (Elf64_Sym *)sechdrs[symindex].sh_addr
+			+ ELF64_R_SYM(rela[i].r_info);
+		symname = me->core_kallsyms.strtab
+			+ sym->st_name;
+
+		if (ELF64_R_TYPE(rela[i].r_info) != R_PPC_REL24)
+			continue;
+		/*
+		 * reverse the operations in apply_relocate_add() for case
+		 * R_PPC_REL24.
+		 */
+		if (sym->st_shndx != SHN_UNDEF &&
+		    sym->st_shndx != SHN_LIVEPATCH)
+			continue;
+
+		instruction = (u32 *)location;
+		if (is_mprofile_ftrace_call(symname))
+			continue;
+
+		if (!instr_is_relative_link_branch(ppc_inst(*instruction)))
+			continue;
+
+		instruction += 1;
+		patch_instruction(instruction, ppc_inst(PPC_RAW_NOP()));
+	}
+
+}
+#endif
+
 #ifdef CONFIG_DYNAMIC_FTRACE
 int module_trampoline_target(struct module *mod, unsigned long addr,
 			     unsigned long *target)
diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index 2d159b32885b..cc6784fbc1ac 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -500,6 +500,14 @@ static int module_alloc_ftrace_hotpatch_trampolines(struct module *me,
 }
 #endif /* CONFIG_FUNCTION_TRACER */
 
+#ifdef CONFIG_LIVEPATCH
+void clear_relocate_add(Elf64_Shdr *sechdrs, const char *strtab,
+			unsigned int symindex, unsigned int relsec,
+			struct module *me)
+{
+}
+#endif
+
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index b1abf663417c..f9632afbb84c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -128,18 +128,20 @@ int apply_relocate(Elf32_Shdr *sechdrs,
 	return 0;
 }
 #else /*X86_64*/
-static int __apply_relocate_add(Elf64_Shdr *sechdrs,
+static int __apply_clear_relocate_add(Elf64_Shdr *sechdrs,
 		   const char *strtab,
 		   unsigned int symindex,
 		   unsigned int relsec,
 		   struct module *me,
-		   void *(*write)(void *dest, const void *src, size_t len))
+		   void *(*write)(void *dest, const void *src, size_t len),
+		   bool clear)
 {
 	unsigned int i;
 	Elf64_Rela *rel = (void *)sechdrs[relsec].sh_addr;
 	Elf64_Sym *sym;
 	void *loc;
 	u64 val;
+	u64 zero = 0ULL;
 
 	DEBUGP("Applying relocate section %u to %u\n",
 	       relsec, sechdrs[relsec].sh_info);
@@ -163,40 +165,60 @@ static int __apply_relocate_add(Elf64_Shdr *sechdrs,
 		case R_X86_64_NONE:
 			break;
 		case R_X86_64_64:
-			if (*(u64 *)loc != 0)
-				goto invalid_relocation;
-			write(loc, &val, 8);
+			if (!clear) {
+				if (*(u64 *)loc != 0)
+					goto invalid_relocation;
+				write(loc, &val, 8);
+			} else {
+				write(loc, &zero, 8);
+			}
 			break;
 		case R_X86_64_32:
-			if (*(u32 *)loc != 0)
-				goto invalid_relocation;
-			write(loc, &val, 4);
-			if (val != *(u32 *)loc)
-				goto overflow;
+			if (!clear) {
+				if (*(u32 *)loc != 0)
+					goto invalid_relocation;
+				write(loc, &val, 4);
+				if (val != *(u32 *)loc)
+					goto overflow;
+			} else {
+				write(loc, &zero, 4);
+			}
 			break;
 		case R_X86_64_32S:
-			if (*(s32 *)loc != 0)
-				goto invalid_relocation;
-			write(loc, &val, 4);
-			if ((s64)val != *(s32 *)loc)
-				goto overflow;
+			if (!clear) {
+				if (*(s32 *)loc != 0)
+					goto invalid_relocation;
+				write(loc, &val, 4);
+				if ((s64)val != *(s32 *)loc)
+					goto overflow;
+			} else {
+				write(loc, &zero, 4);
+			}
 			break;
 		case R_X86_64_PC32:
 		case R_X86_64_PLT32:
-			if (*(u32 *)loc != 0)
-				goto invalid_relocation;
-			val -= (u64)loc;
-			write(loc, &val, 4);
+			if (!clear) {
+				if (*(u32 *)loc != 0)
+					goto invalid_relocation;
+				val -= (u64)loc;
+				write(loc, &val, 4);
 #if 0
-			if ((s64)val != *(s32 *)loc)
-				goto overflow;
+				if ((s64)val != *(s32 *)loc)
+					goto overflow;
 #endif
+			} else {
+				write(loc, &zero, 4);
+			}
 			break;
 		case R_X86_64_PC64:
-			if (*(u64 *)loc != 0)
-				goto invalid_relocation;
-			val -= (u64)loc;
-			write(loc, &val, 8);
+			if (!clear) {
+				if (*(u64 *)loc != 0)
+					goto invalid_relocation;
+				val -= (u64)loc;
+				write(loc, &val, 8);
+			} else {
+				write(loc, &zero, 8);
+			}
 			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
@@ -234,8 +256,8 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 		mutex_lock(&text_mutex);
 	}
 
-	ret = __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
-				   write);
+	ret = __apply_clear_relocate_add(sechdrs, strtab, symindex, relsec, me,
+					 write, false /* clear */);
 
 	if (!early) {
 		text_poke_sync();
@@ -245,6 +267,32 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 	return ret;
 }
 
+#ifdef CONFIG_LIVEPATCH
+
+void clear_relocate_add(Elf64_Shdr *sechdrs,
+			const char *strtab,
+			unsigned int symindex,
+			unsigned int relsec,
+			struct module *me)
+{
+	bool early = me->state == MODULE_STATE_UNFORMED;
+	void *(*write)(void *, const void *, size_t) = memcpy;
+
+	if (!early) {
+		write = text_poke;
+		mutex_lock(&text_mutex);
+	}
+
+	__apply_clear_relocate_add(sechdrs, strtab, symindex, relsec, me,
+				   write, true /* clear */);
+
+	if (!early) {
+		text_poke_sync();
+		mutex_unlock(&text_mutex);
+	}
+}
+#endif
+
 #endif
 
 int module_finalize(const Elf_Ehdr *hdr,
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 9e09d11ffe5b..958e6da7f475 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -72,6 +72,13 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
 		       unsigned int symindex,
 		       unsigned int relsec,
 		       struct module *mod);
+#ifdef CONFIG_LIVEPATCH
+void clear_relocate_add(Elf_Shdr *sechdrs,
+		   const char *strtab,
+		   unsigned int symindex,
+		   unsigned int relsec,
+		   struct module *me);
+#endif
 #else
 static inline int apply_relocate_add(Elf_Shdr *sechdrs,
 				     const char *strtab,
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index bc475e62279d..5c0d8a4eba13 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -316,6 +316,45 @@ int klp_apply_section_relocs(struct module *pmod, Elf_Shdr *sechdrs,
 	return apply_relocate_add(sechdrs, strtab, symndx, secndx, pmod);
 }
 
+static void klp_clear_object_relocations(struct module *pmod,
+					struct klp_object *obj)
+{
+	int i, cnt;
+	const char *objname, *secname;
+	char sec_objname[MODULE_NAME_LEN];
+	Elf_Shdr *sec;
+
+	objname = klp_is_module(obj) ? obj->name : "vmlinux";
+
+	/* For each klp relocation section */
+	for (i = 1; i < pmod->klp_info->hdr.e_shnum; i++) {
+		sec = pmod->klp_info->sechdrs + i;
+		secname = pmod->klp_info->secstrings + sec->sh_name;
+		if (!(sec->sh_flags & SHF_RELA_LIVEPATCH))
+			continue;
+
+		/*
+		 * Format: .klp.rela.sec_objname.section_name
+		 * See comment in klp_resolve_symbols() for an explanation
+		 * of the selected field width value.
+		 */
+		secname = pmod->klp_info->secstrings + sec->sh_name;
+		cnt = sscanf(secname, ".klp.rela.%55[^.]", sec_objname);
+		if (cnt != 1) {
+			pr_err("section %s has an incorrectly formatted name\n",
+			       secname);
+			continue;
+		}
+
+		if (strcmp(objname, sec_objname))
+			continue;
+
+		clear_relocate_add(pmod->klp_info->sechdrs,
+				   pmod->core_kallsyms.strtab,
+				   pmod->klp_info->symndx, i, pmod);
+	}
+}
+
 /*
  * Sysfs Interface
  *
@@ -1154,7 +1193,7 @@ static void klp_cleanup_module_patches_limited(struct module *mod,
 			klp_unpatch_object(obj);
 
 			klp_post_unpatch_callback(obj);
-
+			klp_clear_object_relocations(patch->mod, obj);
 			klp_free_object_loaded(obj);
 			break;
 		}
-- 
2.30.2

