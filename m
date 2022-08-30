Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A0F5A6124
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiH3Kup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiH3KuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:50:10 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74810192BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661856601;
        bh=DB4Ffo5SN0ZV+zTfmpPsFT6cWHPkockNfKUAaHs29Oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhBqm/07FxkypjpKQz3TvxigFnBDOfTatmrdKYtlUXD1hr10liXhRSJzRmaZG0Faw
         UxWxHaE/REe97CjxpNZ9yPa9b2z92OvIuc05ioTnqg5m5yFOWkbsz1+ItSNpjsJSyX
         mKaG0EFGKoQGdN+q0H0q926DRN9FBWz42L9LHlM0=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 08BBB66016;
        Tue, 30 Aug 2022 06:49:57 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7 5/5] LoongArch: Support R_LARCH_GOT_PC* in modules
Date:   Tue, 30 Aug 2022 18:48:06 +0800
Message-Id: <20220830104806.128365-6-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830104806.128365-1-xry111@xry111.site>
References: <20220830104806.128365-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC >= 13 and GNU assembler >= 2.40 use these relocations to address
external symbols, so we need to add them.

Let the module loader emit GOT entries for data symbols so we would be
able to handle GOT relocations.  The GOT entry is just the data symbol
address.

In module.lds, emit a stub .got section for a section header entry.
The actual content of the entry will be filled at runtime by
module_frob_arch_sections.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/module.h     | 23 ++++++++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/module-sections.c | 49 +++++++++++++++++++++++--
 arch/loongarch/kernel/module.c          | 24 ++++++++++++
 4 files changed, 94 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/asm/module.h
index 9f6718df1854..76a98a0ab8a0 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -19,6 +19,7 @@ struct mod_section {
 struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section plt_idx;
+	struct mod_section got;
 };
 
 struct plt_entry {
@@ -28,11 +29,16 @@ struct plt_entry {
 	u32 inst_jirl;
 };
 
+struct got_entry {
+	Elf_Addr symbol_addr;
+};
+
 struct plt_idx_entry {
 	unsigned long symbol_addr;
 };
 
 Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val);
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val);
 
 static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
@@ -51,6 +57,11 @@ static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long val)
 	return (struct plt_idx_entry) { val };
 }
 
+static inline struct got_entry emit_got_entry(Elf_Addr val)
+{
+	return (struct got_entry) { val };
+}
+
 static inline int get_plt_idx(unsigned long val, const struct mod_section *sec)
 {
 	int i;
@@ -77,4 +88,16 @@ static inline struct plt_entry *get_plt_entry(unsigned long val,
 	return plt + plt_idx;
 }
 
+static inline struct got_entry *get_got_entry(Elf_Addr val,
+					      const struct mod_section *sec)
+{
+	struct got_entry *got = (struct got_entry *)sec->shdr->sh_addr;
+	int i;
+
+	for (i = 0; i < sec->num_entries; i++)
+		if (got[i].symbol_addr == val)
+			return &got[i];
+	return NULL;
+}
+
 #endif /* _ASM_MODULE_H */
diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/include/asm/module.lds.h
index 31c1c0db11a3..57bbd0cedd26 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -4,4 +4,5 @@ SECTIONS {
 	. = ALIGN(4);
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
+	.got : { BYTE(0) }
 }
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index c67b9cb220eb..4c99737cd8dc 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -33,6 +33,31 @@ Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val)
 	return (Elf_Addr)&plt[nr];
 }
 
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val)
+{
+	struct mod_section *got_sec = &mod->arch.got;
+	int i = got_sec->num_entries;
+	struct got_entry *got = get_got_entry(val, got_sec);
+
+	if (got)
+		return (Elf_Addr)got;
+
+	/* There is no GOT entry existing for val yet.  Create a new one.  */
+	got = (struct got_entry *)got_sec->shdr->sh_addr;
+	got[i] = emit_got_entry(val);
+
+	got_sec->num_entries++;
+	if (got_sec->num_entries > got_sec->max_entries) {
+		/* This may happen when the module contains a GOT_HI20 without
+		 * a paired GOT_LO12.  Such a module is broken, reject it.
+		 */
+		pr_err("%s: module contains bad GOT relocation\n", mod->name);
+		return 0;
+	}
+
+	return (Elf_Addr)&got[i];
+}
+
 static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
 {
 	return x->r_info == y->r_info && x->r_addend == y->r_addend;
@@ -50,7 +75,8 @@ static bool duplicate_rela(const Elf_Rela *rela, int idx)
 	return false;
 }
 
-static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
+static void count_max_entries(Elf_Rela *relas, int num,
+			      unsigned int *plts, unsigned int *gots)
 {
 	unsigned int i, type;
 
@@ -62,6 +88,10 @@ static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
 			break;
+		case R_LARCH_GOT_PC_HI20:
+			if (!duplicate_rela(relas, i))
+				(*gots)++;
+			break;
 		default:
 			/* Do nothing. */
 		}
@@ -71,7 +101,7 @@ static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned int i, num_plts = 0;
+	unsigned int i, num_plts = 0, num_gots = 0;
 
 	/*
 	 * Find the empty .plt sections.
@@ -81,6 +111,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			mod->arch.plt.shdr = sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
 			mod->arch.plt_idx.shdr = sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
+			mod->arch.got.shdr = sechdrs + i;
 	}
 
 	if (!mod->arch.plt.shdr) {
@@ -91,6 +123,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		pr_err("%s: module PLT.IDX section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
+	if (!mod->arch.got.shdr) {
+		pr_err("%s: module GOT section(s) missing\n", mod->name);
+		return -ENOEXEC;
+	}
 
 	/* Calculate the maxinum number of entries */
 	for (i = 0; i < ehdr->e_shnum; i++) {
@@ -105,7 +141,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		if (!(dst_sec->sh_flags & SHF_EXECINSTR))
 			continue;
 
-		count_max_entries(relas, num_rela, &num_plts);
+		count_max_entries(relas, num_rela, &num_plts, &num_gots);
 	}
 
 	mod->arch.plt.shdr->sh_type = SHT_NOBITS;
@@ -122,5 +158,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	mod->arch.plt_idx.num_entries = 0;
 	mod->arch.plt_idx.max_entries = num_plts;
 
+	mod->arch.got.shdr->sh_type = SHT_NOBITS;
+	mod->arch.got.shdr->sh_flags = SHF_ALLOC;
+	mod->arch.got.shdr->sh_addralign = L1_CACHE_BYTES;
+	mod->arch.got.shdr->sh_size = (num_gots + 1) * sizeof(struct got_entry);
+	mod->arch.got.num_entries = 0;
+	mod->arch.got.max_entries = num_gots;
+
 	return 0;
 }
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index c09ddbe5ed8b..059bc6c86a99 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -346,6 +346,29 @@ static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
 	return 0;
 }
 
+static int apply_r_larch_got_pc(struct module *mod, u32 *location, Elf_Addr v,
+			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	Elf_Addr got = module_emit_got_entry(mod, v);
+
+	if (!got)
+		return -EINVAL;
+
+	switch (type) {
+	case R_LARCH_GOT_PC_LO12:
+		type = R_LARCH_PCALA_LO12;
+		break;
+	case R_LARCH_GOT_PC_HI20:
+		type = R_LARCH_PCALA_HI20;
+		break;
+	default:
+		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
+		return -EINVAL;
+	}
+
+	return apply_r_larch_pcala(mod, location, got, rela_stack, rela_stack_top, type);
+}
+
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -377,6 +400,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
 	[R_LARCH_B26]					     = apply_r_larch_b26,
 	[R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]	     = apply_r_larch_pcala,
+	[R_LARCH_GOT_PC_HI20...R_LARCH_GOT_PC_LO12]	     = apply_r_larch_got_pc,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.37.0

