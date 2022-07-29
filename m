Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FAC584D89
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbiG2Ilq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbiG2Ijq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:39:46 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6EA83F06
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659083979;
        bh=Pr7+lAk3BpHjZc9aaO+tL3K4NBHyUQwC5PAB5P1mSzc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hhY7WEjFNEGVj5jCb9WOp06Z4p5gVcblRZkf0YUy9nnCjHO36bMrRYnRKEpp2wbEZ
         gxCf8oujMj25mKTHFsRouFMg/Tj9sK+TSn7Hi49ZzWJPk6TMXMuie637CubdbFWOvu
         Lg0vYiWC++dKyOaVvY3Qu5IzE0Z9mGribUxAt+4s=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id B6F28669EB;
        Fri, 29 Jul 2022 04:39:37 -0400 (EDT)
Message-ID: <f80a1c26cc0062995613546da16797deb0de7c36.camel@xry111.site>
Subject: [PATCH v4 1/4] LoongArch: Add section of GOT for kernel module
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 16:39:35 +0800
In-Reply-To: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The address of external symbols will locate more than 32-bit offset.  We
were using the `-Wa,-mla-global-with-abs` and `-Wa,-mla-local-with-abs`
to prevent the compiler and assembler from generating GOT relocations,
but these options are undocumented hacks and do not work anymore with
GAS 2.40 and GCC 13.

Let the module loader emit GOT entries for data symbols so we would be
able to handle GOT relocations.  The GOT entry is just the data symbol
address.

In module.lds, emit a stub .got section for a section header entry.
The actual content of the entry will be filled at runtime by
module_frob_arch_sections.

A special symbol named "_GLOBAL_OFFSET_TABLE_" is used by stack-based
relocations for the PC-relative offset of a GOT entry, like:

    R_LARCH_SOP_PUSH_PCREL _GLOBAL_OFFSET_TABLE_
    R_LARCH_SOP_PUSH_GPREL foo
    R_LARCH_SOP_ADD

Each kernel module has its own GOT (like a shared object), so we need
to generate _GLOBAL_OFFSET_TABLE_ as a local symbol for each module.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/module.h     | 23 +++++++++++++
 arch/loongarch/include/asm/module.lds.h |  1 +
 arch/loongarch/kernel/module-sections.c | 43 ++++++++++++++++++++++---
 3 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/module.h b/arch/loongarch/include/a=
sm/module.h
index 9f6718df1854..76a98a0ab8a0 100644
--- a/arch/loongarch/include/asm/module.h
+++ b/arch/loongarch/include/asm/module.h
@@ -19,6 +19,7 @@ struct mod_section {
 struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section plt_idx;
+	struct mod_section got;
 };
=20
 struct plt_entry {
@@ -28,11 +29,16 @@ struct plt_entry {
 	u32 inst_jirl;
 };
=20
+struct got_entry {
+	Elf_Addr symbol_addr;
+};
+
 struct plt_idx_entry {
 	unsigned long symbol_addr;
 };
=20
 Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val);
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val);
=20
 static inline struct plt_entry emit_plt_entry(unsigned long val)
 {
@@ -51,6 +57,11 @@ static inline struct plt_idx_entry emit_plt_idx_entry(un=
signed long val)
 	return (struct plt_idx_entry) { val };
 }
=20
+static inline struct got_entry emit_got_entry(Elf_Addr val)
+{
+	return (struct got_entry) { val };
+}
+
 static inline int get_plt_idx(unsigned long val, const struct mod_section =
*sec)
 {
 	int i;
@@ -77,4 +88,16 @@ static inline struct plt_entry *get_plt_entry(unsigned l=
ong val,
 	return plt + plt_idx;
 }
=20
+static inline struct got_entry *get_got_entry(Elf_Addr val,
+					      const struct mod_section *sec)
+{
+	struct got_entry *got =3D (struct got_entry *)sec->shdr->sh_addr;
+	int i;
+
+	for (i =3D 0; i < sec->num_entries; i++)
+		if (got[i].symbol_addr =3D=3D val)
+			return &got[i];
+	return NULL;
+}
+
 #endif /* _ASM_MODULE_H */
diff --git a/arch/loongarch/include/asm/module.lds.h b/arch/loongarch/inclu=
de/asm/module.lds.h
index 31c1c0db11a3..42b7cca0b947 100644
--- a/arch/loongarch/include/asm/module.lds.h
+++ b/arch/loongarch/include/asm/module.lds.h
@@ -4,4 +4,5 @@ SECTIONS {
 	. =3D ALIGN(4);
 	.plt : { BYTE(0) }
 	.plt.idx : { BYTE(0) }
+	.got : { HIDDEN(_GLOBAL_OFFSET_TABLE_ =3D .); BYTE(0) }
 }
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kerne=
l/module-sections.c
index 6d498288977d..36a77771d18c 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -33,6 +33,25 @@ Elf_Addr module_emit_plt_entry(struct module *mod, unsig=
ned long val)
 	return (Elf_Addr)&plt[nr];
 }
=20
+Elf_Addr module_emit_got_entry(struct module *mod, Elf_Addr val)
+{
+	struct mod_section *got_sec =3D &mod->arch.got;
+	int i =3D got_sec->num_entries;
+	struct got_entry *got =3D get_got_entry(val, got_sec);
+
+	if (got)
+		return (Elf_Addr)got;
+
+	/* There is no GOT entry existing for val yet.  Create a new one.  */
+	got =3D (struct got_entry *)got_sec->shdr->sh_addr;
+	got[i] =3D emit_got_entry(val);
+
+	got_sec->num_entries++;
+	BUG_ON(got_sec->num_entries > got_sec->max_entries);
+
+	return (Elf_Addr)&got[i];
+}
+
 static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
 {
 	return x->r_info =3D=3D y->r_info && x->r_addend =3D=3D y->r_addend;
@@ -50,7 +69,8 @@ static bool duplicate_rela(const Elf_Rela *rela, int idx)
 	return false;
 }
=20
-static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts=
)
+static void count_max_entries(Elf_Rela *relas, int num,
+			      unsigned int *plts, unsigned int *gots)
 {
 	unsigned int i, type;
=20
@@ -59,14 +79,16 @@ static void count_max_entries(Elf_Rela *relas, int num,=
 unsigned int *plts)
 		if (type =3D=3D R_LARCH_SOP_PUSH_PLT_PCREL) {
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
-		}
+		} else if (type =3D=3D R_LARCH_SOP_PUSH_GPREL)
+			if (!duplicate_rela(relas, i))
+				(*gots)++;
 	}
 }
=20
 int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 			      char *secstrings, struct module *mod)
 {
-	unsigned int i, num_plts =3D 0;
+	unsigned int i, num_plts =3D 0, num_gots =3D 0;
=20
 	/*
 	 * Find the empty .plt sections.
@@ -76,6 +98,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *s=
echdrs,
 			mod->arch.plt.shdr =3D sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
 			mod->arch.plt_idx.shdr =3D sechdrs + i;
+		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
+			mod->arch.got.shdr =3D sechdrs + i;
 	}
=20
 	if (!mod->arch.plt.shdr) {
@@ -86,6 +110,10 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr =
*sechdrs,
 		pr_err("%s: module PLT.IDX section(s) missing\n", mod->name);
 		return -ENOEXEC;
 	}
+	if (!mod->arch.got.shdr) {
+		pr_err("%s: module GOT section(s) missing\n", mod->name);
+		return -ENOEXEC;
+	}
=20
 	/* Calculate the maxinum number of entries */
 	for (i =3D 0; i < ehdr->e_shnum; i++) {
@@ -100,7 +128,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr =
*sechdrs,
 		if (!(dst_sec->sh_flags & SHF_EXECINSTR))
 			continue;
=20
-		count_max_entries(relas, num_rela, &num_plts);
+		count_max_entries(relas, num_rela, &num_plts, &num_gots);
 	}
=20
 	mod->arch.plt.shdr->sh_type =3D SHT_NOBITS;
@@ -117,5 +145,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr=
 *sechdrs,
 	mod->arch.plt_idx.num_entries =3D 0;
 	mod->arch.plt_idx.max_entries =3D num_plts;
=20
+	mod->arch.got.shdr->sh_type =3D SHT_NOBITS;
+	mod->arch.got.shdr->sh_flags =3D SHF_ALLOC;
+	mod->arch.got.shdr->sh_addralign =3D L1_CACHE_BYTES;
+	mod->arch.got.shdr->sh_size =3D (num_gots + 1) * sizeof(struct got_entry)=
;
+	mod->arch.got.num_entries =3D 0;
+	mod->arch.got.max_entries =3D num_gots;
+
 	return 0;
 }
--=20
2.37.0


