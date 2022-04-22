Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2205F50B505
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446625AbiDVKbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446578AbiDVKay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:30:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCAB54F99;
        Fri, 22 Apr 2022 03:28:00 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:27:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZlyJl4oyKJ1WtamAofyK8c0unHWdG8/zxJrCnE89Z0=;
        b=dvbUj7NwipxtTbTSWjHhbVsHyGQ3YyQMN0cPeuxdK4fn8+jQEw/cr2+LcNp057H32/9/B4
        URplZsK147+FarXtV4Af6fVKTQ13JPF3VzGmsnFtrCiqQi9mbBSa3hu/L4Bd36spkdTlUx
        zpGEw8E51vg7YLKm2LCpNnOc6FTJeiWEiSKPjTQlTxu4O+OhHefa4F6LVNEg7uEGKRECW+
        4GPMhd3xyyDvfkAtj3azAX2iQWbLZ39h5mA1I+4OpIDT3bE6AR1jfOjF1uMNbz5OX4kbJ7
        JTzp7/KEOo0nfl7Dx23DiahH41oRqO9OLtUYBwFzHZ2Xhqk2Lfxk0+6DOwTWBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623279;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZlyJl4oyKJ1WtamAofyK8c0unHWdG8/zxJrCnE89Z0=;
        b=g9lgn4G7B/D5jS6p5gvjMHYjYIou9ygSdJSEO07Sazt1FsaFWpljCKnl5YapqlJ5tRcutT
        Y/iAbet1JTg6wKBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix code relocs vs weak symbols
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220419203807.655552918@infradead.org>
References: <20220419203807.655552918@infradead.org>
MIME-Version: 1.0
Message-ID: <165062327811.4207.17165843968442413950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4abff6d48dbcea8200c7ea35ba70c242d128ebf3
Gitweb:        https://git.kernel.org/tip/4abff6d48dbcea8200c7ea35ba70c242d128ebf3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 17 Apr 2022 17:03:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:13:55 +02:00

objtool: Fix code relocs vs weak symbols

Occasionally objtool driven code patching (think .static_call_sites
.retpoline_sites etc..) goes sideways and it tries to patch an
instruction that doesn't match.

Much head-scatching and cursing later the problem is as outlined below
and affects every section that objtool generates for us, very much
including the ORC data. The below uses .static_call_sites because it's
convenient for demonstration purposes, but as mentioned the ORC
sections, .retpoline_sites and __mount_loc are all similarly affected.

Consider:

foo-weak.c:

  extern void __SCT__foo(void);

  __attribute__((weak)) void foo(void)
  {
	  return __SCT__foo();
  }

foo.c:

  extern void __SCT__foo(void);
  extern void my_foo(void);

  void foo(void)
  {
	  my_foo();
	  return __SCT__foo();
  }

These generate the obvious code
(gcc -O2 -fcf-protection=none -fno-asynchronous-unwind-tables -c foo*.c):

foo-weak.o:
0000000000000000 <foo>:
   0:   e9 00 00 00 00          jmpq   5 <foo+0x5>      1: R_X86_64_PLT32       __SCT__foo-0x4

foo.o:
0000000000000000 <foo>:
   0:   48 83 ec 08             sub    $0x8,%rsp
   4:   e8 00 00 00 00          callq  9 <foo+0x9>      5: R_X86_64_PLT32       my_foo-0x4
   9:   48 83 c4 08             add    $0x8,%rsp
   d:   e9 00 00 00 00          jmpq   12 <foo+0x12>    e: R_X86_64_PLT32       __SCT__foo-0x4

Now, when we link these two files together, you get something like
(ld -r -o foos.o foo-weak.o foo.o):

foos.o:
0000000000000000 <foo-0x10>:
   0:   e9 00 00 00 00          jmpq   5 <foo-0xb>      1: R_X86_64_PLT32       __SCT__foo-0x4
   5:   66 2e 0f 1f 84 00 00 00 00 00   nopw   %cs:0x0(%rax,%rax,1)
   f:   90                      nop

0000000000000010 <foo>:
  10:   48 83 ec 08             sub    $0x8,%rsp
  14:   e8 00 00 00 00          callq  19 <foo+0x9>     15: R_X86_64_PLT32      my_foo-0x4
  19:   48 83 c4 08             add    $0x8,%rsp
  1d:   e9 00 00 00 00          jmpq   22 <foo+0x12>    1e: R_X86_64_PLT32      __SCT__foo-0x4

Noting that ld preserves the weak function text, but strips the symbol
off of it (hence objdump doing that funny negative offset thing). This
does lead to 'interesting' unused code issues with objtool when ran on
linked objects, but that seems to be working (fingers crossed).

So far so good.. Now lets consider the objtool static_call output
section (readelf output, old binutils):

foo-weak.o:

Relocation section '.rela.static_call_sites' at offset 0x2c8 contains 1 entry:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + 0
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

foo.o:

Relocation section '.rela.static_call_sites' at offset 0x310 contains 2 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 .text + d
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

foos.o:

Relocation section '.rela.static_call_sites' at offset 0x430 contains 4 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000100000002 R_X86_64_PC32          0000000000000000 .text + 0
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1
0000000000000008  0000000100000002 R_X86_64_PC32          0000000000000000 .text + 1d
000000000000000c  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

So we have two patch sites, one in the dead code of the weak foo and one
in the real foo. All is well.

*HOWEVER*, when the toolchain strips unused section symbols it
generates things like this (using new enough binutils):

foo-weak.o:

Relocation section '.rela.static_call_sites' at offset 0x2c8 contains 1 entry:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 foo + 0
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

foo.o:

Relocation section '.rela.static_call_sites' at offset 0x310 contains 2 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000200000002 R_X86_64_PC32          0000000000000000 foo + d
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

foos.o:

Relocation section '.rela.static_call_sites' at offset 0x430 contains 4 entries:
    Offset             Info             Type               Symbol's Value  Symbol's Name + Addend
0000000000000000  0000000100000002 R_X86_64_PC32          0000000000000000 foo + 0
0000000000000004  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1
0000000000000008  0000000100000002 R_X86_64_PC32          0000000000000000 foo + d
000000000000000c  0000000d00000002 R_X86_64_PC32          0000000000000000 __SCT__foo + 1

And now we can see how that foos.o .static_call_sites goes side-ways, we
now have _two_ patch sites in foo. One for the weak symbol at foo+0
(which is no longer a static_call site!) and one at foo+d which is in
fact the right location.

This seems to happen when objtool cannot find a section symbol, in which
case it falls back to any other symbol to key off of, however in this
case that goes terribly wrong!

As such, teach objtool to create a section symbol when there isn't
one.

Fixes: 44f6a7c0755d ("objtool: Fix seg fault with Clang non-section symbols")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lkml.kernel.org/r/20220419203807.655552918@infradead.org
---
 tools/objtool/elf.c | 187 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 165 insertions(+), 22 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 0cfe84a..ebf2ba5 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -575,37 +575,180 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	return 0;
 }
 
-int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
-			  unsigned long offset, unsigned int type,
-			  struct section *insn_sec, unsigned long insn_off)
+/*
+ * Ensure that any reloc section containing references to @sym is marked
+ * changed such that it will get re-generated in elf_rebuild_reloc_sections()
+ * with the new symbol index.
+ */
+static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
+{
+	struct section *sec;
+
+	list_for_each_entry(sec, &elf->sections, list) {
+		struct reloc *reloc;
+
+		if (sec->changed)
+			continue;
+
+		list_for_each_entry(reloc, &sec->reloc_list, list) {
+			if (reloc->sym == sym) {
+				sec->changed = true;
+				break;
+			}
+		}
+	}
+}
+
+/*
+ * Move the first global symbol, as per sh_info, into a new, higher symbol
+ * index. This fees up the shndx for a new local symbol.
+ */
+static int elf_move_global_symbol(struct elf *elf, struct section *symtab,
+				  struct section *symtab_shndx)
 {
+	Elf_Data *data, *shndx_data = NULL;
+	Elf32_Word first_non_local;
 	struct symbol *sym;
-	int addend;
+	Elf_Scn *s;
 
-	if (insn_sec->sym) {
-		sym = insn_sec->sym;
-		addend = insn_off;
+	first_non_local = symtab->sh.sh_info;
 
-	} else {
-		/*
-		 * The Clang assembler strips section symbols, so we have to
-		 * reference the function symbol instead:
-		 */
-		sym = find_symbol_containing(insn_sec, insn_off);
-		if (!sym) {
-			/*
-			 * Hack alert.  This happens when we need to reference
-			 * the NOP pad insn immediately after the function.
-			 */
-			sym = find_symbol_containing(insn_sec, insn_off - 1);
+	sym = find_symbol_by_index(elf, first_non_local);
+	if (!sym) {
+		WARN("no non-local symbols !?");
+		return first_non_local;
+	}
+
+	s = elf_getscn(elf->elf, symtab->idx);
+	if (!s) {
+		WARN_ELF("elf_getscn");
+		return -1;
+	}
+
+	data = elf_newdata(s);
+	if (!data) {
+		WARN_ELF("elf_newdata");
+		return -1;
+	}
+
+	data->d_buf = &sym->sym;
+	data->d_size = sizeof(sym->sym);
+	data->d_align = 1;
+	data->d_type = ELF_T_SYM;
+
+	sym->idx = symtab->sh.sh_size / sizeof(sym->sym);
+	elf_dirty_reloc_sym(elf, sym);
+
+	symtab->sh.sh_info += 1;
+	symtab->sh.sh_size += data->d_size;
+	symtab->changed = true;
+
+	if (symtab_shndx) {
+		s = elf_getscn(elf->elf, symtab_shndx->idx);
+		if (!s) {
+			WARN_ELF("elf_getscn");
+			return -1;
 		}
 
-		if (!sym) {
-			WARN("can't find symbol containing %s+0x%lx", insn_sec->name, insn_off);
+		shndx_data = elf_newdata(s);
+		if (!shndx_data) {
+			WARN_ELF("elf_newshndx_data");
 			return -1;
 		}
 
-		addend = insn_off - sym->offset;
+		shndx_data->d_buf = &sym->sec->idx;
+		shndx_data->d_size = sizeof(Elf32_Word);
+		shndx_data->d_align = 4;
+		shndx_data->d_type = ELF_T_WORD;
+
+		symtab_shndx->sh.sh_size += 4;
+		symtab_shndx->changed = true;
+	}
+
+	return first_non_local;
+}
+
+static struct symbol *
+elf_create_section_symbol(struct elf *elf, struct section *sec)
+{
+	struct section *symtab, *symtab_shndx;
+	Elf_Data *shndx_data = NULL;
+	struct symbol *sym;
+	Elf32_Word shndx;
+
+	symtab = find_section_by_name(elf, ".symtab");
+	if (symtab) {
+		symtab_shndx = find_section_by_name(elf, ".symtab_shndx");
+		if (symtab_shndx)
+			shndx_data = symtab_shndx->data;
+	} else {
+		WARN("no .symtab");
+		return NULL;
+	}
+
+	sym = malloc(sizeof(*sym));
+	if (!sym) {
+		perror("malloc");
+		return NULL;
+	}
+	memset(sym, 0, sizeof(*sym));
+
+	sym->idx = elf_move_global_symbol(elf, symtab, symtab_shndx);
+	if (sym->idx < 0) {
+		WARN("elf_move_global_symbol");
+		return NULL;
+	}
+
+	sym->name = sec->name;
+	sym->sec = sec;
+
+	// st_name 0
+	sym->sym.st_info = GELF_ST_INFO(STB_LOCAL, STT_SECTION);
+	// st_other 0
+	// st_value 0
+	// st_size 0
+	shndx = sec->idx;
+	if (shndx >= SHN_UNDEF && shndx < SHN_LORESERVE) {
+		sym->sym.st_shndx = shndx;
+		if (!shndx_data)
+			shndx = 0;
+	} else {
+		sym->sym.st_shndx = SHN_XINDEX;
+		if (!shndx_data) {
+			WARN("no .symtab_shndx");
+			return NULL;
+		}
+	}
+
+	if (!gelf_update_symshndx(symtab->data, shndx_data, sym->idx, &sym->sym, shndx)) {
+		WARN_ELF("gelf_update_symshndx");
+		return NULL;
+	}
+
+	elf_add_symbol(elf, sym);
+
+	return sym;
+}
+
+int elf_add_reloc_to_insn(struct elf *elf, struct section *sec,
+			  unsigned long offset, unsigned int type,
+			  struct section *insn_sec, unsigned long insn_off)
+{
+	struct symbol *sym = insn_sec->sym;
+	int addend = insn_off;
+
+	if (!sym) {
+		/*
+		 * Due to how weak functions work, we must use section based
+		 * relocations. Symbol based relocations would result in the
+		 * weak and non-weak function annotations being overlaid on the
+		 * non-weak function after linking.
+		 */
+		sym = elf_create_section_symbol(elf, insn_sec);
+		if (!sym)
+			return -1;
+
+		insn_sec->sym = sym;
 	}
 
 	return elf_add_reloc(elf, sec, offset, type, sym, addend);
