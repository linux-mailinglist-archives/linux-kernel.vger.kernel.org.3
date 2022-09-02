Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBC55AAC16
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbiIBKJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 06:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbiIBKJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:09:03 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 833F0C7F83
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 03:09:01 -0700 (PDT)
Received: from bogon.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx_2s31hFjz8APAA--.65103S3;
        Fri, 02 Sep 2022 18:08:56 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        Xuerui Wang <kernel@xen0n.name>,
        Xi Ruoyao <xry111@xry111.site>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] LoongArch: tools: Add relocs tool support
Date:   Fri,  2 Sep 2022 18:08:53 +0800
Message-Id: <1662113335-14282-2-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
References: <1662113335-14282-1-git-send-email-tangyouling@loongson.cn>
X-CM-TRANSID: AQAAf8Dx_2s31hFjz8APAA--.65103S3
X-Coremail-Antispam: 1UD129KBjvAXoWfXF1fKr1xtFWrJF1DGFyDKFg_yoW8ZFyxCo
        W2yFs8Gr18Cw42yr4kJwn7WFZ7WFsrKrWrA34YvrZxGa42yr1Ygrykur1ag393ArZY93s3
        Wr92g395Cr1Utr95n29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYX7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jr4l82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280
        aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzV
        Aqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S
        6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8twCF04k20xvY0x
        0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
        7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcV
        C0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
        04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7
        CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07br6wZUUUUU=
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This tool is based on the arch/mips/boot/tools/relocs tool.

It parses the relocations present in the vmlinux elf file, building a
table of relocations that will be necessary to run the kernel from an
address other than its link address. This table is inserted into the
vmlinux elf, in the .data.relocs section. The table is subsequently used
by the code in arch/loongarch/kernel/relocate.c (added later) to relocate
the kernel.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/loongarch/boot/.gitignore          |   1 +
 arch/loongarch/boot/tools/Makefile      |   8 +
 arch/loongarch/boot/tools/relocs.c      | 544 ++++++++++++++++++++++++
 arch/loongarch/boot/tools/relocs.h      |  55 +++
 arch/loongarch/boot/tools/relocs_64.c   |  18 +
 arch/loongarch/boot/tools/relocs_main.c |  82 ++++
 6 files changed, 708 insertions(+)
 create mode 100644 arch/loongarch/boot/tools/Makefile
 create mode 100644 arch/loongarch/boot/tools/relocs.c
 create mode 100644 arch/loongarch/boot/tools/relocs.h
 create mode 100644 arch/loongarch/boot/tools/relocs_64.c
 create mode 100644 arch/loongarch/boot/tools/relocs_main.c

diff --git a/arch/loongarch/boot/.gitignore b/arch/loongarch/boot/.gitignore
index 49423ee96ef3..4a1c06836627 100644
--- a/arch/loongarch/boot/.gitignore
+++ b/arch/loongarch/boot/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vmlinux*
+relocs
diff --git a/arch/loongarch/boot/tools/Makefile b/arch/loongarch/boot/tools/Makefile
new file mode 100644
index 000000000000..3a5fba2231c3
--- /dev/null
+++ b/arch/loongarch/boot/tools/Makefile
@@ -0,0 +1,8 @@
+# SPDX-License-Identifier: GPL-2.0
+
+hostprogs	+= relocs
+relocs-objs	+= relocs_64.o
+relocs-objs	+= relocs_main.o
+PHONY += relocs
+relocs: $(obj)/relocs
+	@:
diff --git a/arch/loongarch/boot/tools/relocs.c b/arch/loongarch/boot/tools/relocs.c
new file mode 100644
index 000000000000..73963142b798
--- /dev/null
+++ b/arch/loongarch/boot/tools/relocs.c
@@ -0,0 +1,544 @@
+// SPDX-License-Identifier: GPL-2.0
+/* This is included from relocs_64.c */
+
+#define ElfW(type)		_ElfW(ELF_BITS, type)
+#define _ElfW(bits, type)	__ElfW(bits, type)
+#define __ElfW(bits, type)	Elf##bits##_##type
+
+#define Elf_Addr		ElfW(Addr)
+#define Elf_Ehdr		ElfW(Ehdr)
+#define Elf_Phdr		ElfW(Phdr)
+#define Elf_Shdr		ElfW(Shdr)
+#define Elf_Sym			ElfW(Sym)
+
+static Elf_Ehdr ehdr;
+
+struct relocs {
+	uint32_t	*offset;
+	unsigned long	count;
+	unsigned long	size;
+};
+
+static struct relocs relocs;
+
+struct section {
+	Elf_Shdr       shdr;
+	struct section *link;
+	Elf_Sym        *symtab;
+	Elf_Rel        *reltab;
+	char           *strtab;
+	long           shdr_offset;
+};
+static struct section *secs;
+
+static const char *rel_type(unsigned int type)
+{
+	static const char * const type_name[] = {
+#define REL_TYPE(X)[X] = #X
+		REL_TYPE(R_LARCH_NONE),
+		REL_TYPE(R_LARCH_32),
+		REL_TYPE(R_LARCH_64),
+		REL_TYPE(R_LARCH_MARK_LA),
+		REL_TYPE(R_LARCH_SOP_PUSH_PCREL),
+		REL_TYPE(R_LARCH_SOP_PUSH_ABSOLUTE),
+		REL_TYPE(R_LARCH_SOP_PUSH_PLT_PCREL),
+		REL_TYPE(R_LARCH_SOP_SUB),
+		REL_TYPE(R_LARCH_SOP_SL),
+		REL_TYPE(R_LARCH_SOP_SR),
+		REL_TYPE(R_LARCH_SOP_AND),
+		REL_TYPE(R_LARCH_SOP_POP_32_U_10_12),
+		REL_TYPE(R_LARCH_SOP_POP_32_S_10_12),
+		REL_TYPE(R_LARCH_SOP_POP_32_S_10_16_S2),
+		REL_TYPE(R_LARCH_SOP_POP_32_S_5_20),
+		REL_TYPE(R_LARCH_SOP_POP_32_S_0_5_10_16_S2),
+		REL_TYPE(R_LARCH_SOP_POP_32_S_0_10_10_16_S2),
+		REL_TYPE(R_LARCH_ADD32),
+		REL_TYPE(R_LARCH_ADD64),
+		REL_TYPE(R_LARCH_SUB32),
+		REL_TYPE(R_LARCH_SUB64),
+		REL_TYPE(R_LARCH_B26),
+		REL_TYPE(R_LARCH_ABS_HI20),
+		REL_TYPE(R_LARCH_ABS_LO12),
+		REL_TYPE(R_LARCH_ABS64_LO20),
+		REL_TYPE(R_LARCH_ABS64_HI12),
+		REL_TYPE(R_LARCH_PCALA_HI20),
+		REL_TYPE(R_LARCH_PCALA_LO12),
+		REL_TYPE(R_LARCH_GOT_PC_HI20),
+		REL_TYPE(R_LARCH_GOT_PC_LO12),
+#undef REL_TYPE
+	};
+	const char *name = "unknown type rel type name";
+
+	if (type < ARRAY_SIZE(type_name) && type_name[type])
+		name = type_name[type];
+	return name;
+}
+
+static const char *sec_name(unsigned int shndx)
+{
+	const char *sec_strtab;
+	const char *name;
+
+	sec_strtab = secs[ehdr.e_shstrndx].strtab;
+	if (shndx < ehdr.e_shnum)
+		name = sec_strtab + secs[shndx].shdr.sh_name;
+	else if (shndx == SHN_ABS)
+		name = "ABSOLUTE";
+	else if (shndx == SHN_COMMON)
+		name = "COMMON";
+	else
+		name = "<noname>";
+	return name;
+}
+
+static struct section *sec_lookup(const char *secname)
+{
+	int i;
+
+	for (i = 0; i < ehdr.e_shnum; i++)
+		if (strcmp(secname, sec_name(i)) == 0)
+			return &secs[i];
+
+	return NULL;
+}
+
+static const char *sym_name(const char *sym_strtab, Elf_Sym *sym)
+{
+	const char *name;
+
+	if (sym->st_name)
+		name = sym_strtab + sym->st_name;
+	else
+		name = sec_name(sym->st_shndx);
+	return name;
+}
+
+static void read_ehdr(FILE *fp)
+{
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1)
+		die("Cannot read ELF header: %s\n", strerror(errno));
+
+	if (memcmp(ehdr.e_ident, ELFMAG, SELFMAG) != 0)
+		die("No ELF magic\n");
+
+	if (ehdr.e_ident[EI_CLASS] != ELF_CLASS)
+		die("Not a %d bit executable\n", ELF_BITS);
+
+	if (ehdr.e_ident[EI_DATA] != ELFDATA2LSB)
+		die("Not a ELF Little Endianness\n");
+
+	if (ehdr.e_ident[EI_VERSION] != EV_CURRENT)
+		die("Unknown ELF version\n");
+
+	if ((ehdr.e_type != ET_EXEC) && (ehdr.e_type != ET_DYN))
+		die("Unsupported ELF header type\n");
+
+	if (ehdr.e_machine != ELF_MACHINE)
+		die("Not for %s\n", ELF_MACHINE_NAME);
+
+	if (ehdr.e_version != EV_CURRENT)
+		die("Unknown ELF version\n");
+
+	if (ehdr.e_ehsize != sizeof(Elf_Ehdr))
+		die("Bad Elf header size\n");
+
+	if (ehdr.e_phentsize != sizeof(Elf_Phdr))
+		die("Bad program header entry\n");
+
+	if (ehdr.e_shentsize != sizeof(Elf_Shdr))
+		die("Bad section header entry\n");
+
+	if (ehdr.e_shstrndx >= ehdr.e_shnum)
+		die("String table index out of bounds\n");
+}
+
+static void read_shdrs(FILE *fp)
+{
+	int i;
+
+	secs = calloc(ehdr.e_shnum, sizeof(struct section));
+	if (!secs)
+		die("Unable to allocate %d section headers\n", ehdr.e_shnum);
+
+	if (fseek(fp, ehdr.e_shoff, SEEK_SET) < 0)
+		die("Seek to %d failed: %s\n", ehdr.e_shoff, strerror(errno));
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+
+		sec->shdr_offset = ftell(fp);
+		if (fread(&sec->shdr, sizeof(Elf_Shdr), 1, fp) != 1)
+			die("Cannot read ELF section headers %d/%d: %s\n",
+			    i, ehdr.e_shnum, strerror(errno));
+
+		if (sec->shdr.sh_link < ehdr.e_shnum)
+			sec->link = &secs[sec->shdr.sh_link];
+	}
+}
+
+static void read_strtabs(FILE *fp)
+{
+	int i;
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_STRTAB)
+			continue;
+
+		sec->strtab = malloc(sec->shdr.sh_size);
+		if (!sec->strtab)
+			die("malloc of %d bytes for strtab failed\n",
+			    sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->strtab, 1, sec->shdr.sh_size, fp) !=
+		    sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+	}
+}
+
+static void read_symtabs(FILE *fp)
+{
+	int i;
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_SYMTAB)
+			continue;
+
+		sec->symtab = malloc(sec->shdr.sh_size);
+		if (!sec->symtab)
+			die("malloc of %d bytes for symtab failed\n",
+			    sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->symtab, 1, sec->shdr.sh_size, fp) !=
+		    sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+	}
+}
+
+static void read_relocs(FILE *fp)
+{
+	static unsigned long base;
+	int i, j;
+
+	if (!base) {
+		struct section *sec = sec_lookup(".text");
+
+		if (!sec)
+			die("Could not find .text section\n");
+
+		base = sec->shdr.sh_addr;
+	}
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
+			continue;
+
+		sec->reltab = malloc(sec->shdr.sh_size);
+		if (!sec->reltab)
+			die("malloc of %d bytes for relocs failed\n",
+			    sec->shdr.sh_size);
+
+		if (fseek(fp, sec->shdr.sh_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+			    sec->shdr.sh_offset, strerror(errno));
+
+		if (fread(sec->reltab, 1, sec->shdr.sh_size, fp) !=
+		    sec->shdr.sh_size)
+			die("Cannot read symbol table: %s\n", strerror(errno));
+
+		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
+			Elf_Rel *rel = &sec->reltab[j];
+
+			/* Set offset into kernel image */
+			rel->r_offset -= base;
+		}
+	}
+}
+
+static void remove_relocs(FILE *fp)
+{
+	int i;
+	Elf_Shdr shdr;
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
+			continue;
+
+		if (fseek(fp, sec->shdr_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+			    sec->shdr_offset, strerror(errno));
+
+		if (fread(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot read ELF section headers %d/%d: %s\n",
+			    i, ehdr.e_shnum, strerror(errno));
+
+		/* Set relocation section size to 0, effectively removing it.
+		 * This is necessary due to lack of support for relocations
+		 * in objcopy when creating 32bit elf from 64bit elf.
+		 */
+		shdr.sh_size = 0;
+
+		if (fseek(fp, sec->shdr_offset, SEEK_SET) < 0)
+			die("Seek to %d failed: %s\n",
+			    sec->shdr_offset, strerror(errno));
+
+		if (fwrite(&shdr, sizeof(shdr), 1, fp) != 1)
+			die("Cannot write ELF section headers %d/%d: %s\n",
+			    i, ehdr.e_shnum, strerror(errno));
+	}
+}
+
+static void add_reloc(struct relocs *r, uint32_t offset, unsigned int type)
+{
+	/* Relocation representation in binary table:
+	 * |31    28|27                       0|
+	 * |  Type  |  offset from _stext >> 2 |
+	 */
+	offset >>= 2;
+	if (offset > 0x0FFFFFFF)
+		die("Kernel image exceeds maximum size for relocation!\n");
+
+	offset = (offset & 0x0FFFFFFF) | ((type & 0xF) << 28);
+
+	if (r->count == r->size) {
+		unsigned long newsize = r->size + 50000;
+		void *mem = realloc(r->offset, newsize * sizeof(r->offset[0]));
+
+		if (!mem)
+			die("realloc failed\n");
+
+		r->offset = mem;
+		r->size = newsize;
+	}
+	r->offset[r->count++] = offset;
+}
+
+static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
+			Elf_Sym *sym, const char *symname))
+{
+	int i;
+
+	/* Walk through the relocations */
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		char *sym_strtab;
+		Elf_Sym *sh_symtab;
+		struct section *sec_applies, *sec_symtab;
+		int j;
+		struct section *sec = &secs[i];
+
+		if (sec->shdr.sh_type != SHT_REL_TYPE)
+			continue;
+
+		sec_symtab  = sec->link;
+		sec_applies = &secs[sec->shdr.sh_info];
+		if (!(sec_applies->shdr.sh_flags & SHF_ALLOC))
+			continue;
+
+		sh_symtab = sec_symtab->symtab;
+		sym_strtab = sec_symtab->link->strtab;
+		for (j = 0; j < sec->shdr.sh_size/sizeof(Elf_Rel); j++) {
+			Elf_Rel *rel = &sec->reltab[j];
+			Elf_Sym *sym = &sh_symtab[ELF_R_SYM(rel->r_info)];
+			const char *symname = sym_name(sym_strtab, sym);
+
+			process(sec, rel, sym, symname);
+		}
+	}
+}
+
+static int type2int[] = {
+	[R_LARCH_64]		= 1,
+	[R_LARCH_MARK_LA]	= 2,
+};
+
+static int do_reloc(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
+		      const char *symname)
+{
+	unsigned int r_type = ELF_R_TYPE(rel->r_info);
+	unsigned int bind = ELF_ST_BIND(sym->st_info);
+
+	if ((bind == STB_WEAK) && (sym->st_value == 0)) {
+		/* Don't relocate weak symbols without a target */
+		return 0;
+	}
+
+	switch (r_type) {
+	case R_LARCH_NONE:
+	case R_LARCH_32:
+	case R_LARCH_SOP_PUSH_PCREL:
+	case R_LARCH_SOP_PUSH_ABSOLUTE:
+	case R_LARCH_SOP_PUSH_PLT_PCREL:
+	case R_LARCH_SOP_SUB:
+	case R_LARCH_SOP_SL:
+	case R_LARCH_SOP_SR:
+	case R_LARCH_SOP_AND:
+	case R_LARCH_SOP_POP_32_U_10_12:
+	case R_LARCH_SOP_POP_32_S_10_12:
+	case R_LARCH_SOP_POP_32_S_10_16_S2:
+	case R_LARCH_SOP_POP_32_S_5_20:
+	case R_LARCH_SOP_POP_32_S_0_5_10_16_S2:
+	case R_LARCH_SOP_POP_32_S_0_10_10_16_S2:
+	case R_LARCH_ADD32:
+	case R_LARCH_ADD64:
+	case R_LARCH_SUB32:
+	case R_LARCH_SUB64:
+	case R_LARCH_B26:
+	case R_LARCH_ABS_HI20:
+	case R_LARCH_ABS_LO12:
+	case R_LARCH_ABS64_LO20:
+	case R_LARCH_ABS64_HI12:
+	case R_LARCH_PCALA_HI20:
+	case R_LARCH_PCALA_LO12:
+	case R_LARCH_GOT_PC_HI20:
+	case R_LARCH_GOT_PC_LO12:
+		break;
+
+	case R_LARCH_64:
+	case R_LARCH_MARK_LA:
+		add_reloc(&relocs, rel->r_offset, type2int[r_type]);
+		break;
+
+	default:
+		die("Unsupported relocation type: %s (%d)\n", rel_type(r_type), r_type);
+		break;
+	}
+
+	return 0;
+}
+
+static int write_reloc_as_bin(uint32_t v, FILE *f)
+{
+	return fwrite(&v, 4, 1, f);
+}
+
+static int write_reloc_as_text(uint32_t v, FILE *f)
+{
+	int res;
+
+	res = fprintf(f, "\t.long 0x%08"PRIx32"\n", v);
+	if (res < 0)
+		return res;
+	else
+		return sizeof(uint32_t);
+}
+
+static void emit_relocs(int as_text, int as_bin, FILE *outf)
+{
+	int i;
+	int (*write_reloc)(uint32_t, FILE *) = write_reloc_as_bin;
+	int size = 0;
+	int size_reserved;
+	struct section *sec_reloc;
+
+	sec_reloc = sec_lookup(".data.reloc");
+	if (!sec_reloc)
+		die("Could not find relocation section\n");
+
+	size_reserved = sec_reloc->shdr.sh_size;
+
+	/* Collect up the relocations */
+	walk_relocs(do_reloc);
+
+	/* Print the relocations */
+	if (as_text) {
+		/* Print the relocations in a form suitable that
+		 * gas will like.
+		 */
+		printf(".section \".data.reloc\",\"a\"\n");
+		printf(".balign 4\n");
+		/* Output text to stdout */
+		write_reloc = write_reloc_as_text;
+		outf = stdout;
+	} else if (as_bin) {
+		/* Output raw binary to stdout */
+		outf = stdout;
+	} else {
+		/* Seek to offset of the relocation section.
+		 * Each relocation is then written into the
+		 * vmlinux kernel image.
+		 */
+		if (fseek(outf, sec_reloc->shdr.sh_offset, SEEK_SET) < 0) {
+			die("Seek to %d failed: %s\n",
+				sec_reloc->shdr.sh_offset, strerror(errno));
+		}
+	}
+
+	for (i = 0; i < relocs.count; i++)
+		size += write_reloc(relocs.offset[i], outf);
+
+	/* Print a stop, but only if we've actually written some relocs */
+	if (size)
+		size += write_reloc(0, outf);
+
+	if (size > size_reserved)
+		/* Die, but suggest a value for CONFIG_RELOCATION_TABLE_SIZE
+		 * which will fix this problem and allow a bit of headroom
+		 * if more kernel features are enabled
+		 */
+		die("Relocations overflow available space!\n"
+		    "Please adjust CONFIG_RELOCATION_TABLE_SIZE "
+		    "to at least 0x%08x\n", (size + 0x1000) & ~0xFFF);
+}
+
+/*
+ * As an aid to debugging problems with different linkers
+ * print summary information about the relocs.
+ * Since different linkers tend to emit the sections in
+ * different orders we use the section names in the output.
+ */
+static int do_reloc_info(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
+				const char *symname)
+{
+	printf("%-16s  0x%08x  %-35s  %-40s  %-16s\n",
+		sec_name(sec->shdr.sh_info),
+		(unsigned int)rel->r_offset,
+		rel_type(ELF_R_TYPE(rel->r_info)),
+		symname,
+		sec_name(sym->st_shndx));
+	return 0;
+}
+
+static void print_reloc_info(void)
+{
+	printf("%-16s  %-10s  %-35s  %-40s  %-16s\n",
+		"reloc section",
+		"offset",
+		"reloc type",
+		"symbol",
+		"symbol section");
+	walk_relocs(do_reloc_info);
+}
+
+# define process process_64
+
+void process(FILE *fp, int as_text, int as_bin,
+	     int show_reloc_info, int keep_relocs)
+{
+	read_ehdr(fp);
+	read_shdrs(fp);
+	read_strtabs(fp);
+	read_symtabs(fp);
+	read_relocs(fp);
+	if (show_reloc_info) {
+		print_reloc_info();
+		return;
+	}
+	emit_relocs(as_text, as_bin, fp);
+	if (!keep_relocs)
+		remove_relocs(fp);
+}
diff --git a/arch/loongarch/boot/tools/relocs.h b/arch/loongarch/boot/tools/relocs.h
new file mode 100644
index 000000000000..e11a391fdfea
--- /dev/null
+++ b/arch/loongarch/boot/tools/relocs.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef RELOCS_H
+#define RELOCS_H
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <inttypes.h>
+#include <string.h>
+#include <errno.h>
+#include <unistd.h>
+#include <elf.h>
+
+#ifndef EM_LOONGARCH
+#define EM_LOONGARCH	258
+#endif
+#define R_LARCH_NONE				0
+#define R_LARCH_32				1
+#define R_LARCH_64				2
+#define R_LARCH_MARK_LA				20
+#define R_LARCH_SOP_PUSH_PCREL			22
+#define R_LARCH_SOP_PUSH_ABSOLUTE		23
+#define R_LARCH_SOP_PUSH_PLT_PCREL		29
+#define R_LARCH_SOP_SUB				32
+#define R_LARCH_SOP_SL				33
+#define R_LARCH_SOP_SR				34
+#define R_LARCH_SOP_AND				36
+#define R_LARCH_SOP_POP_32_U_10_12		39
+#define R_LARCH_SOP_POP_32_S_10_12		40
+#define R_LARCH_SOP_POP_32_S_10_16_S2		42
+#define R_LARCH_SOP_POP_32_S_5_20		43
+#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2	44
+#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2	45
+#define R_LARCH_ADD32				50
+#define R_LARCH_ADD64				51
+#define R_LARCH_SUB32				55
+#define R_LARCH_SUB64				56
+#define R_LARCH_B26				66
+#define R_LARCH_ABS_HI20			67
+#define R_LARCH_ABS_LO12			68
+#define R_LARCH_ABS64_LO20			69
+#define R_LARCH_ABS64_HI12			70
+#define R_LARCH_PCALA_HI20			71
+#define R_LARCH_PCALA_LO12			72
+#define R_LARCH_GOT_PC_HI20			75
+#define R_LARCH_GOT_PC_LO12			76
+
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
+void die(char *fmt, ...);
+void process_64(FILE *fp, int as_text, int as_bin,
+		int show_reloc_info, int keep_relocs);
+
+#endif /* RELOCS_H */
diff --git a/arch/loongarch/boot/tools/relocs_64.c b/arch/loongarch/boot/tools/relocs_64.c
new file mode 100644
index 000000000000..1024133af8ec
--- /dev/null
+++ b/arch/loongarch/boot/tools/relocs_64.c
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "relocs.h"
+
+#define ELF_BITS 64
+
+#define ELF_MACHINE             EM_LOONGARCH
+#define ELF_MACHINE_NAME        "LOONGARCH64"
+#define SHT_REL_TYPE            SHT_RELA
+#define Elf_Rel                 Elf64_Rela
+
+#define ELF_CLASS               ELFCLASS64
+#define ELF_R_SYM(val)          ELF64_R_SYM(val)
+#define ELF_R_TYPE(val)         ELF64_R_TYPE(val)
+#define ELF_ST_TYPE(o)          ELF64_ST_TYPE(o)
+#define ELF_ST_BIND(o)          ELF64_ST_BIND(o)
+#define ELF_ST_VISIBILITY(o)    ELF64_ST_VISIBILITY(o)
+
+#include "relocs.c"
diff --git a/arch/loongarch/boot/tools/relocs_main.c b/arch/loongarch/boot/tools/relocs_main.c
new file mode 100644
index 000000000000..03d23aec38fa
--- /dev/null
+++ b/arch/loongarch/boot/tools/relocs_main.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <endian.h>
+#include <elf.h>
+
+#include "relocs.h"
+
+void die(char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vfprintf(stderr, fmt, ap);
+	va_end(ap);
+	exit(1);
+}
+
+static void usage(void)
+{
+	die("relocs [--reloc-info|--text|--bin|--keep] vmlinux\n");
+}
+
+int main(int argc, char **argv)
+{
+	int show_reloc_info, as_text, as_bin, keep_relocs;
+	const char *fname;
+	FILE *fp;
+	int i;
+	unsigned char e_ident[EI_NIDENT];
+
+	show_reloc_info = 0;
+	as_text = 0;
+	as_bin = 0;
+	keep_relocs = 0;
+	fname = NULL;
+	for (i = 1; i < argc; i++) {
+		char *arg = argv[i];
+
+		if (*arg == '-') {
+			if (strcmp(arg, "--reloc-info") == 0) {
+				show_reloc_info = 1;
+				continue;
+			}
+			if (strcmp(arg, "--text") == 0) {
+				as_text = 1;
+				continue;
+			}
+			if (strcmp(arg, "--bin") == 0) {
+				as_bin = 1;
+				continue;
+			}
+			if (strcmp(arg, "--keep") == 0) {
+				keep_relocs = 1;
+				continue;
+			}
+		} else if (!fname) {
+			fname = arg;
+			continue;
+		}
+		usage();
+	}
+	if (!fname)
+		usage();
+
+	fp = fopen(fname, "r+");
+	if (!fp)
+		die("Cannot open %s: %s\n", fname, strerror(errno));
+
+	if (fread(&e_ident, 1, EI_NIDENT, fp) != EI_NIDENT)
+		die("Cannot read %s: %s", fname, strerror(errno));
+
+	rewind(fp);
+	process_64(fp, as_text,  as_bin, show_reloc_info, keep_relocs);
+	fclose(fp);
+	return 0;
+}
-- 
2.36.1

