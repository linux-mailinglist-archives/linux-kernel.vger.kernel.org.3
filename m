Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB403480D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhL1VbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:31:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20074 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237588AbhL1Va5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUEkJWsxXP6BsETJkrvhPjouaNdbfj3jiXJF/PlhK0o=;
        b=gS4MiBIXQ6h0HCWDbP//D6U+FwEwATV8Ar2S0m7oiR1meIcxkJaEC5pWfg1XSVO5HYydP2
        1KSvTMYWIK2uqSCsp9wLWzQ2KZIcrtaDZCbfu8HatP1gpijpB6PwuAPy/SWW7qEh1nZQ22
        0QcOEHkOTo0n+jUs+ij1DsDICAhBJG4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-iirFBhd7NJ-GiMyC2rLvDg-1; Tue, 28 Dec 2021 16:30:53 -0500
X-MC-Unique: iirFBhd7NJ-GiMyC2rLvDg-1
Received: by mail-wr1-f71.google.com with SMTP id l9-20020adfa389000000b001a23bd1c661so4300443wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZUEkJWsxXP6BsETJkrvhPjouaNdbfj3jiXJF/PlhK0o=;
        b=l6rM2P1gePARh3DFyPwiQkSudj5t89xVxGsjyYkVW9mYsH23UgDT/7/6Gkr0tsEsT3
         MRkLxLVehpiwj5BiV5LltuAWr1rVL1uUSmR1pTFbyKhX7Q+m4HpU+P6Z1PGeTxW01n1z
         uhKqjDjy4tyd+ALCq9Sr5sgp5yI78ExSGxB6qpMu0IQpb+/SkZ0pJQq1MelkWRJG1ynL
         CJMHsqDHJEFX20p+UZVgsbBFaWKgYj/eDH8YfRB/ixA2lBQ9bRHULJkMJU9QcDVYNebq
         a2+Dr48qLtAnwiv+Do6p37p7BKGwSx9CGP3+2Jx4OU92IuQNW8hn9W7lBwJQjxo4uq0K
         7avQ==
X-Gm-Message-State: AOAM532v6jYxdBfNUBLAuIATwEWKiPf30gOw+eFlz6ZCXFgdH7t/9XTs
        gMOeZ3zqsxLgAEAtUT/wz4U9fnMQRnMxlCjEaXmdTpfrtwyjpa8I69A2oxwBiXUJRap4BI1i1C5
        kCWIYPv0JeP5B2ZC5gREDfZ4=
X-Received: by 2002:a5d:4568:: with SMTP id a8mr18494048wrc.471.1640727051621;
        Tue, 28 Dec 2021 13:30:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzoOpCT9b9YngsldqtjvWCX+4PsCaEviuSQZDsPGpVJLimvBlMoZxnPQrkUYZ0MNF2ibJDFSQ==
X-Received: by 2002:a5d:4568:: with SMTP id a8mr18494032wrc.471.1640727051290;
        Tue, 28 Dec 2021 13:30:51 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o14sm19380517wms.4.2021.12.28.13.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:50 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 09/12] module: Move kallsyms support into a separate file
Date:   Tue, 28 Dec 2021 21:30:38 +0000
Message-Id: <20211228213041.1356334-10-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kallsyms code out of core module
code kernel/module/kallsyms.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |  20 ++
 kernel/module/kallsyms.c | 506 ++++++++++++++++++++++++++++++++++++++
 kernel/module/main.c     | 516 +--------------------------------------
 4 files changed, 531 insertions(+), 512 deletions(-)
 create mode 100644 kernel/module/kallsyms.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 2e03da799833..23582011ab08 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
+obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 31d767416f0c..119d42c304a1 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -79,3 +79,23 @@ extern void kmemleak_load_module(const struct module *mod, const struct load_inf
 #else /* !CONFIG_DEBUG_KMEMLEAK */
 static inline void __maybe_unused kmemleak_load_module(const struct module *mod, const struct load_info *info) { }
 #endif /* CONFIG_DEBUG_KMEMLEAK */
+
+#ifdef CONFIG_KALLSYMS
+#ifdef CONFIG_STACKTRACE_BUILD_ID
+extern void init_build_id(struct module *mod, const struct load_info *info);
+#else /* !CONFIG_STACKTRACE_BUILD_ID */
+static inline void init_build_id(struct module *mod, const struct load_info *info) { }
+
+#endif
+extern void layout_symtab(struct module *mod, struct load_info *info);
+extern void add_kallsyms(struct module *mod, const struct load_info *info);
+extern bool sect_empty(const Elf_Shdr *sect);
+extern const char *find_kallsyms_symbol(struct module *mod, unsigned long addr, unsigned long *size, unsigned long *offset);
+#else /* !CONFIG_KALLSYMS */
+static inline void layout_symtab(struct module *mod, struct load_info *info) { }
+static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
+static inline char *find_kallsyms_symbol(struct module *mod, unsigned long addr, unsigned long *size, unsigned long *offset)
+{
+	return NULL;
+}
+#endif /* CONFIG_KALLSYMS */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
new file mode 100644
index 000000000000..f682415459fe
--- /dev/null
+++ b/kernel/module/kallsyms.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/kallsyms.c - module kallsyms support
+ *
+ * Copyright (C) 2010 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <linux/buildid.h>
+#include <linux/bsearch.h>
+#include "internal.h"
+
+extern struct module *find_module_all(const char *name, size_t len, bool even_unformed);
+extern unsigned long kernel_symbol_value(const struct kernel_symbol *sym);
+extern int cmp_name(const void *name, const void *sym);
+extern long get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr, unsigned int section);
+
+/* Lookup exported symbol in given range of kernel_symbols */
+static const struct kernel_symbol *lookup_exported_symbol(const char *name,
+							  const struct kernel_symbol *start,
+							  const struct kernel_symbol *stop)
+{
+	return bsearch(name, start, stop - start,
+			sizeof(struct kernel_symbol), cmp_name);
+}
+
+static int is_exported(const char *name, unsigned long value,
+		       const struct module *mod)
+{
+	const struct kernel_symbol *ks;
+	if (!mod)
+		ks = lookup_exported_symbol(name, __start___ksymtab, __stop___ksymtab);
+	else
+		ks = lookup_exported_symbol(name, mod->syms, mod->syms + mod->num_syms);
+
+	return ks != NULL && kernel_symbol_value(ks) == value;
+}
+
+/* As per nm */
+static char elf_type(const Elf_Sym *sym, const struct load_info *info)
+{
+	const Elf_Shdr *sechdrs = info->sechdrs;
+
+	if (ELF_ST_BIND(sym->st_info) == STB_WEAK) {
+		if (ELF_ST_TYPE(sym->st_info) == STT_OBJECT)
+			return 'v';
+		else
+			return 'w';
+	}
+	if (sym->st_shndx == SHN_UNDEF)
+		return 'U';
+	if (sym->st_shndx == SHN_ABS || sym->st_shndx == info->index.pcpu)
+		return 'a';
+	if (sym->st_shndx >= SHN_LORESERVE)
+		return '?';
+	if (sechdrs[sym->st_shndx].sh_flags & SHF_EXECINSTR)
+		return 't';
+	if (sechdrs[sym->st_shndx].sh_flags & SHF_ALLOC
+	    && sechdrs[sym->st_shndx].sh_type != SHT_NOBITS) {
+		if (!(sechdrs[sym->st_shndx].sh_flags & SHF_WRITE))
+			return 'r';
+		else if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
+			return 'g';
+		else
+			return 'd';
+	}
+	if (sechdrs[sym->st_shndx].sh_type == SHT_NOBITS) {
+		if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
+			return 's';
+		else
+			return 'b';
+	}
+	if (strstarts(info->secstrings + sechdrs[sym->st_shndx].sh_name,
+		      ".debug")) {
+		return 'n';
+	}
+	return '?';
+}
+
+static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
+			unsigned int shnum, unsigned int pcpundx)
+{
+	const Elf_Shdr *sec;
+
+	if (src->st_shndx == SHN_UNDEF
+	    || src->st_shndx >= shnum
+	    || !src->st_name)
+		return false;
+
+#ifdef CONFIG_KALLSYMS_ALL
+	if (src->st_shndx == pcpundx)
+		return true;
+#endif
+
+	sec = sechdrs + src->st_shndx;
+	if (!(sec->sh_flags & SHF_ALLOC)
+#ifndef CONFIG_KALLSYMS_ALL
+	    || !(sec->sh_flags & SHF_EXECINSTR)
+#endif
+	    || (sec->sh_entsize & INIT_OFFSET_MASK))
+		return false;
+
+	return true;
+}
+
+/*
+ * We only allocate and copy the strings needed by the parts of symtab
+ * we keep.  This is simple, but has the effect of making multiple
+ * copies of duplicates.  We could be more sophisticated, see
+ * linux-kernel thread starting with
+ * <73defb5e4bca04a6431392cc341112b1@localhost>.
+ */
+void layout_symtab(struct module *mod, struct load_info *info)
+{
+	Elf_Shdr *symsect = info->sechdrs + info->index.sym;
+	Elf_Shdr *strsect = info->sechdrs + info->index.str;
+	const Elf_Sym *src;
+	unsigned int i, nsrc, ndst, strtab_size = 0;
+
+	/* Put symbol section at end of init part of module. */
+	symsect->sh_flags |= SHF_ALLOC;
+	symsect->sh_entsize = get_offset(mod, &mod->init_layout.size, symsect,
+					 info->index.sym) | INIT_OFFSET_MASK;
+	pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
+
+	src = (void *)info->hdr + symsect->sh_offset;
+	nsrc = symsect->sh_size / sizeof(*src);
+
+	/* Compute total space required for the core symbols' strtab. */
+	for (ndst = i = 0; i < nsrc; i++) {
+		if (i == 0 || is_livepatch_module(mod) ||
+		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu)) {
+			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
+			ndst++;
+		}
+	}
+
+	/* Append room for core symbols at end of core part. */
+	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
+	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
+	mod->core_layout.size += strtab_size;
+	info->core_typeoffs = mod->core_layout.size;
+	mod->core_layout.size += ndst * sizeof(char);
+	mod->core_layout.size = debug_align(mod->core_layout.size);
+
+	/* Put string table section at end of init part of module. */
+	strsect->sh_flags |= SHF_ALLOC;
+	strsect->sh_entsize = get_offset(mod, &mod->init_layout.size, strsect,
+					 info->index.str) | INIT_OFFSET_MASK;
+	pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
+
+	/* We'll tack temporary mod_kallsyms on the end. */
+	mod->init_layout.size = ALIGN(mod->init_layout.size,
+				      __alignof__(struct mod_kallsyms));
+	info->mod_kallsyms_init_off = mod->init_layout.size;
+	mod->init_layout.size += sizeof(struct mod_kallsyms);
+	info->init_typeoffs = mod->init_layout.size;
+	mod->init_layout.size += nsrc * sizeof(char);
+	mod->init_layout.size = debug_align(mod->init_layout.size);
+}
+
+/*
+ * We use the full symtab and strtab which layout_symtab arranged to
+ * be appended to the init section.  Later we switch to the cut-down
+ * core-only ones.
+ */
+void add_kallsyms(struct module *mod, const struct load_info *info)
+{
+	unsigned int i, ndst;
+	const Elf_Sym *src;
+	Elf_Sym *dst;
+	char *s;
+	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
+
+	/* Set up to point into init section. */
+	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
+
+	mod->kallsyms->symtab = (void *)symsec->sh_addr;
+	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
+	/* Make sure we get permanent strtab: don't use info->strtab. */
+	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
+	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
+
+	/*
+	 * Now populate the cut down core kallsyms for after init
+	 * and set types up while we still have access to sections.
+	 */
+	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
+	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
+	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
+	src = mod->kallsyms->symtab;
+	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
+		mod->kallsyms->typetab[i] = elf_type(src + i, info);
+		if (i == 0 || is_livepatch_module(mod) ||
+		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu)) {
+			mod->core_kallsyms.typetab[ndst] =
+			    mod->kallsyms->typetab[i];
+			dst[ndst] = src[i];
+			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
+			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
+				     KSYM_NAME_LEN) + 1;
+		}
+	}
+	mod->core_kallsyms.num_symtab = ndst;
+}
+
+inline bool sect_empty(const Elf_Shdr *sect)
+{
+	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
+}
+
+#ifdef CONFIG_STACKTRACE_BUILD_ID
+void init_build_id(struct module *mod, const struct load_info *info)
+{
+	const Elf_Shdr *sechdr;
+	unsigned int i;
+
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		sechdr = &info->sechdrs[i];
+		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
+		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
+					sechdr->sh_size))
+			break;
+	}
+}
+#endif
+
+/*
+ * This ignores the intensely annoying "mapping symbols" found
+ * in ARM ELF files: $a, $t and $d.
+ */
+static inline int is_arm_mapping_symbol(const char *str)
+{
+	if (str[0] == '.' && str[1] == 'L')
+		return true;
+	return str[0] == '$' && strchr("axtd", str[1])
+	       && (str[2] == '\0' || str[2] == '.');
+}
+
+static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
+{
+	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
+}
+
+/*
+ * Given a module and address, find the corresponding symbol and return its name
+ * while providing its size and offset if needed.
+ */
+const char *find_kallsyms_symbol(struct module *mod,
+					unsigned long addr,
+					unsigned long *size,
+					unsigned long *offset)
+{
+	unsigned int i, best = 0;
+	unsigned long nextval, bestval;
+	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+
+	/* At worse, next value is at end of module */
+	if (within_module_init(addr, mod))
+		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
+	else
+		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
+
+	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
+
+	/*
+	 * Scan for closest preceding symbol, and next symbol. (ELF
+	 * starts real symbols at 1).
+	 */
+	for (i = 1; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+		unsigned long thisval = kallsyms_symbol_value(sym);
+
+		if (sym->st_shndx == SHN_UNDEF)
+			continue;
+
+		/*
+		 * We ignore unnamed symbols: they're uninformative
+		 * and inserted at a whim.
+		 */
+		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
+		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
+			continue;
+
+		if (thisval <= addr && thisval > bestval) {
+			best = i;
+			bestval = thisval;
+		}
+		if (thisval > addr && thisval < nextval)
+			nextval = thisval;
+	}
+
+	if (!best)
+		return NULL;
+
+	if (size)
+		*size = nextval - bestval;
+	if (offset)
+		*offset = addr - bestval;
+
+	return kallsyms_symbol_name(kallsyms, best);
+}
+
+void * __weak dereference_module_function_descriptor(struct module *mod,
+						     void *ptr)
+{
+	return ptr;
+}
+
+/*
+ * For kallsyms to ask for address resolution.  NULL means not found.  Careful
+ * not to lock to avoid deadlock on oopses, simply disable preemption.
+ */
+const char *module_address_lookup(unsigned long addr,
+			    unsigned long *size,
+			    unsigned long *offset,
+			    char **modname,
+			    const unsigned char **modbuildid,
+			    char *namebuf)
+{
+	const char *ret = NULL;
+	struct module *mod;
+
+	preempt_disable();
+	mod = __module_address(addr);
+	if (mod) {
+		if (modname)
+			*modname = mod->name;
+		if (modbuildid) {
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
+			*modbuildid = mod->build_id;
+#else
+			*modbuildid = NULL;
+#endif
+		}
+
+		ret = find_kallsyms_symbol(mod, addr, size, offset);
+	}
+	/* Make a copy in here where it's safe */
+	if (ret) {
+		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
+		ret = namebuf;
+	}
+	preempt_enable();
+
+	return ret;
+}
+
+int lookup_module_symbol_name(unsigned long addr, char *symname)
+{
+	struct module *mod;
+
+	preempt_disable();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (within_module(addr, mod)) {
+			const char *sym;
+
+			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
+			if (!sym)
+				goto out;
+
+			strlcpy(symname, sym, KSYM_NAME_LEN);
+			preempt_enable();
+			return 0;
+		}
+	}
+out:
+	preempt_enable();
+	return -ERANGE;
+}
+
+int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
+			unsigned long *offset, char *modname, char *name)
+{
+	struct module *mod;
+
+	preempt_disable();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		if (within_module(addr, mod)) {
+			const char *sym;
+
+			sym = find_kallsyms_symbol(mod, addr, size, offset);
+			if (!sym)
+				goto out;
+			if (modname)
+				strlcpy(modname, mod->name, MODULE_NAME_LEN);
+			if (name)
+				strlcpy(name, sym, KSYM_NAME_LEN);
+			preempt_enable();
+			return 0;
+		}
+	}
+out:
+	preempt_enable();
+	return -ERANGE;
+}
+
+int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
+			char *name, char *module_name, int *exported)
+{
+	struct module *mod;
+
+	preempt_disable();
+	list_for_each_entry_rcu(mod, &modules, list) {
+		struct mod_kallsyms *kallsyms;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		kallsyms = rcu_dereference_sched(mod->kallsyms);
+		if (symnum < kallsyms->num_symtab) {
+			const Elf_Sym *sym = &kallsyms->symtab[symnum];
+
+			*value = kallsyms_symbol_value(sym);
+			*type = kallsyms->typetab[symnum];
+			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
+			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
+			*exported = is_exported(name, *value, mod);
+			preempt_enable();
+			return 0;
+		}
+		symnum -= kallsyms->num_symtab;
+	}
+	preempt_enable();
+	return -ERANGE;
+}
+
+/* Given a module and name of symbol, find and return the symbol's value */
+static unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
+{
+	unsigned int i;
+	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
+
+	for (i = 0; i < kallsyms->num_symtab; i++) {
+		const Elf_Sym *sym = &kallsyms->symtab[i];
+
+		if (strcmp(name, kallsyms_symbol_name(kallsyms, i)) == 0 &&
+		    sym->st_shndx != SHN_UNDEF)
+			return kallsyms_symbol_value(sym);
+	}
+	return 0;
+}
+
+/* Look for this name: can be of form module:name. */
+unsigned long module_kallsyms_lookup_name(const char *name)
+{
+	struct module *mod;
+	char *colon;
+	unsigned long ret = 0;
+
+	/* Don't lock: we're in enough trouble already. */
+	preempt_disable();
+	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
+		if ((mod = find_module_all(name, colon - name, false)) != NULL)
+			ret = find_kallsyms_symbol_value(mod, colon+1);
+	} else {
+		list_for_each_entry_rcu(mod, &modules, list) {
+			if (mod->state == MODULE_STATE_UNFORMED)
+				continue;
+			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)
+				break;
+		}
+	}
+	preempt_enable();
+	return ret;
+}
+
+#ifdef CONFIG_LIVEPATCH
+int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
+					     struct module *, unsigned long),
+				   void *data)
+{
+	struct module *mod;
+	unsigned int i;
+	int ret = 0;
+
+	mutex_lock(&module_mutex);
+	list_for_each_entry(mod, &modules, list) {
+		/* We hold module_mutex: no need for rcu_dereference_sched */
+		struct mod_kallsyms *kallsyms = mod->kallsyms;
+
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+		for (i = 0; i < kallsyms->num_symtab; i++) {
+			const Elf_Sym *sym = &kallsyms->symtab[i];
+
+			if (sym->st_shndx == SHN_UNDEF)
+				continue;
+
+			ret = fn(data, kallsyms_symbol_name(kallsyms, i),
+				 mod, kallsyms_symbol_value(sym));
+			if (ret != 0)
+				goto out;
+		}
+	}
+out:
+	mutex_unlock(&module_mutex);
+	return ret;
+}
+#endif /* CONFIG_LIVEPATCH */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 672a977b1320..9813e1672d8c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -275,7 +275,7 @@ static bool check_exported_symbol(const struct symsearch *syms,
 	return true;
 }
 
-static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
 	return (unsigned long)offset_to_ptr(&sym->value_offset);
@@ -304,7 +304,7 @@ static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
 #endif
 }
 
-static int cmp_name(const void *name, const void *sym)
+int cmp_name(const void *name, const void *sym)
 {
 	return strcmp(name, kernel_symbol_name(sym));
 }
@@ -374,7 +374,7 @@ static bool find_symbol(struct find_symbol_arg *fsa)
  * Search for module by name: must hold module_mutex (or preempt disabled
  * for read-only access).
  */
-static struct module *find_module_all(const char *name, size_t len,
+struct module *find_module_all(const char *name, size_t len,
 				      bool even_unformed)
 {
 	struct module *mod;
@@ -1282,13 +1282,6 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }
 
-#ifdef CONFIG_KALLSYMS
-static inline bool sect_empty(const Elf_Shdr *sect)
-{
-	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
-}
-#endif
-
 /*
  * /sys/module/foo/sections stuff
  * J. Corbet <corbet@lwn.net>
@@ -2013,7 +2006,7 @@ unsigned int __weak arch_mod_section_prepend(struct module *mod,
 }
 
 /* Update size with this section: return offset. */
-static long get_offset(struct module *mod, unsigned int *size,
+long get_offset(struct module *mod, unsigned int *size,
 		       Elf_Shdr *sechdr, unsigned int section)
 {
 	long ret;
@@ -2215,228 +2208,6 @@ static void free_modinfo(struct module *mod)
 	}
 }
 
-#ifdef CONFIG_KALLSYMS
-
-/* Lookup exported symbol in given range of kernel_symbols */
-static const struct kernel_symbol *lookup_exported_symbol(const char *name,
-							  const struct kernel_symbol *start,
-							  const struct kernel_symbol *stop)
-{
-	return bsearch(name, start, stop - start,
-			sizeof(struct kernel_symbol), cmp_name);
-}
-
-static int is_exported(const char *name, unsigned long value,
-		       const struct module *mod)
-{
-	const struct kernel_symbol *ks;
-	if (!mod)
-		ks = lookup_exported_symbol(name, __start___ksymtab, __stop___ksymtab);
-	else
-		ks = lookup_exported_symbol(name, mod->syms, mod->syms + mod->num_syms);
-
-	return ks != NULL && kernel_symbol_value(ks) == value;
-}
-
-/* As per nm */
-static char elf_type(const Elf_Sym *sym, const struct load_info *info)
-{
-	const Elf_Shdr *sechdrs = info->sechdrs;
-
-	if (ELF_ST_BIND(sym->st_info) == STB_WEAK) {
-		if (ELF_ST_TYPE(sym->st_info) == STT_OBJECT)
-			return 'v';
-		else
-			return 'w';
-	}
-	if (sym->st_shndx == SHN_UNDEF)
-		return 'U';
-	if (sym->st_shndx == SHN_ABS || sym->st_shndx == info->index.pcpu)
-		return 'a';
-	if (sym->st_shndx >= SHN_LORESERVE)
-		return '?';
-	if (sechdrs[sym->st_shndx].sh_flags & SHF_EXECINSTR)
-		return 't';
-	if (sechdrs[sym->st_shndx].sh_flags & SHF_ALLOC
-	    && sechdrs[sym->st_shndx].sh_type != SHT_NOBITS) {
-		if (!(sechdrs[sym->st_shndx].sh_flags & SHF_WRITE))
-			return 'r';
-		else if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
-			return 'g';
-		else
-			return 'd';
-	}
-	if (sechdrs[sym->st_shndx].sh_type == SHT_NOBITS) {
-		if (sechdrs[sym->st_shndx].sh_flags & ARCH_SHF_SMALL)
-			return 's';
-		else
-			return 'b';
-	}
-	if (strstarts(info->secstrings + sechdrs[sym->st_shndx].sh_name,
-		      ".debug")) {
-		return 'n';
-	}
-	return '?';
-}
-
-static bool is_core_symbol(const Elf_Sym *src, const Elf_Shdr *sechdrs,
-			unsigned int shnum, unsigned int pcpundx)
-{
-	const Elf_Shdr *sec;
-
-	if (src->st_shndx == SHN_UNDEF
-	    || src->st_shndx >= shnum
-	    || !src->st_name)
-		return false;
-
-#ifdef CONFIG_KALLSYMS_ALL
-	if (src->st_shndx == pcpundx)
-		return true;
-#endif
-
-	sec = sechdrs + src->st_shndx;
-	if (!(sec->sh_flags & SHF_ALLOC)
-#ifndef CONFIG_KALLSYMS_ALL
-	    || !(sec->sh_flags & SHF_EXECINSTR)
-#endif
-	    || (sec->sh_entsize & INIT_OFFSET_MASK))
-		return false;
-
-	return true;
-}
-
-/*
- * We only allocate and copy the strings needed by the parts of symtab
- * we keep.  This is simple, but has the effect of making multiple
- * copies of duplicates.  We could be more sophisticated, see
- * linux-kernel thread starting with
- * <73defb5e4bca04a6431392cc341112b1@localhost>.
- */
-static void layout_symtab(struct module *mod, struct load_info *info)
-{
-	Elf_Shdr *symsect = info->sechdrs + info->index.sym;
-	Elf_Shdr *strsect = info->sechdrs + info->index.str;
-	const Elf_Sym *src;
-	unsigned int i, nsrc, ndst, strtab_size = 0;
-
-	/* Put symbol section at end of init part of module. */
-	symsect->sh_flags |= SHF_ALLOC;
-	symsect->sh_entsize = get_offset(mod, &mod->init_layout.size, symsect,
-					 info->index.sym) | INIT_OFFSET_MASK;
-	pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
-
-	src = (void *)info->hdr + symsect->sh_offset;
-	nsrc = symsect->sh_size / sizeof(*src);
-
-	/* Compute total space required for the core symbols' strtab. */
-	for (ndst = i = 0; i < nsrc; i++) {
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			strtab_size += strlen(&info->strtab[src[i].st_name])+1;
-			ndst++;
-		}
-	}
-
-	/* Append room for core symbols at end of core part. */
-	info->symoffs = ALIGN(mod->core_layout.size, symsect->sh_addralign ?: 1);
-	info->stroffs = mod->core_layout.size = info->symoffs + ndst * sizeof(Elf_Sym);
-	mod->core_layout.size += strtab_size;
-	info->core_typeoffs = mod->core_layout.size;
-	mod->core_layout.size += ndst * sizeof(char);
-	mod->core_layout.size = debug_align(mod->core_layout.size);
-
-	/* Put string table section at end of init part of module. */
-	strsect->sh_flags |= SHF_ALLOC;
-	strsect->sh_entsize = get_offset(mod, &mod->init_layout.size, strsect,
-					 info->index.str) | INIT_OFFSET_MASK;
-	pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
-
-	/* We'll tack temporary mod_kallsyms on the end. */
-	mod->init_layout.size = ALIGN(mod->init_layout.size,
-				      __alignof__(struct mod_kallsyms));
-	info->mod_kallsyms_init_off = mod->init_layout.size;
-	mod->init_layout.size += sizeof(struct mod_kallsyms);
-	info->init_typeoffs = mod->init_layout.size;
-	mod->init_layout.size += nsrc * sizeof(char);
-	mod->init_layout.size = debug_align(mod->init_layout.size);
-}
-
-/*
- * We use the full symtab and strtab which layout_symtab arranged to
- * be appended to the init section.  Later we switch to the cut-down
- * core-only ones.
- */
-static void add_kallsyms(struct module *mod, const struct load_info *info)
-{
-	unsigned int i, ndst;
-	const Elf_Sym *src;
-	Elf_Sym *dst;
-	char *s;
-	Elf_Shdr *symsec = &info->sechdrs[info->index.sym];
-
-	/* Set up to point into init section. */
-	mod->kallsyms = mod->init_layout.base + info->mod_kallsyms_init_off;
-
-	mod->kallsyms->symtab = (void *)symsec->sh_addr;
-	mod->kallsyms->num_symtab = symsec->sh_size / sizeof(Elf_Sym);
-	/* Make sure we get permanent strtab: don't use info->strtab. */
-	mod->kallsyms->strtab = (void *)info->sechdrs[info->index.str].sh_addr;
-	mod->kallsyms->typetab = mod->init_layout.base + info->init_typeoffs;
-
-	/*
-	 * Now populate the cut down core kallsyms for after init
-	 * and set types up while we still have access to sections.
-	 */
-	mod->core_kallsyms.symtab = dst = mod->core_layout.base + info->symoffs;
-	mod->core_kallsyms.strtab = s = mod->core_layout.base + info->stroffs;
-	mod->core_kallsyms.typetab = mod->core_layout.base + info->core_typeoffs;
-	src = mod->kallsyms->symtab;
-	for (ndst = i = 0; i < mod->kallsyms->num_symtab; i++) {
-		mod->kallsyms->typetab[i] = elf_type(src + i, info);
-		if (i == 0 || is_livepatch_module(mod) ||
-		    is_core_symbol(src+i, info->sechdrs, info->hdr->e_shnum,
-				   info->index.pcpu)) {
-			mod->core_kallsyms.typetab[ndst] =
-			    mod->kallsyms->typetab[i];
-			dst[ndst] = src[i];
-			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
-			s += strlcpy(s, &mod->kallsyms->strtab[src[i].st_name],
-				     KSYM_NAME_LEN) + 1;
-		}
-	}
-	mod->core_kallsyms.num_symtab = ndst;
-}
-#else
-static inline void layout_symtab(struct module *mod, struct load_info *info)
-{
-}
-
-static void add_kallsyms(struct module *mod, const struct load_info *info)
-{
-}
-#endif /* CONFIG_KALLSYMS */
-
-#if IS_ENABLED(CONFIG_KALLSYMS) && IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-static void init_build_id(struct module *mod, const struct load_info *info)
-{
-	const Elf_Shdr *sechdr;
-	unsigned int i;
-
-	for (i = 0; i < info->hdr->e_shnum; i++) {
-		sechdr = &info->sechdrs[i];
-		if (!sect_empty(sechdr) && sechdr->sh_type == SHT_NOTE &&
-		    !build_id_parse_buf((void *)sechdr->sh_addr, mod->build_id,
-					sechdr->sh_size))
-			break;
-	}
-}
-#else
-static void init_build_id(struct module *mod, const struct load_info *info)
-{
-}
-#endif
-
 static void dynamic_debug_setup(struct module *mod, struct _ddebug *debug, unsigned int num)
 {
 	if (!debug)
@@ -3702,285 +3473,6 @@ static inline int within(unsigned long addr, void *start, unsigned long size)
 	return ((void *)addr >= start && (void *)addr < start + size);
 }
 
-#ifdef CONFIG_KALLSYMS
-/*
- * This ignores the intensely annoying "mapping symbols" found
- * in ARM ELF files: $a, $t and $d.
- */
-static inline int is_arm_mapping_symbol(const char *str)
-{
-	if (str[0] == '.' && str[1] == 'L')
-		return true;
-	return str[0] == '$' && strchr("axtd", str[1])
-	       && (str[2] == '\0' || str[2] == '.');
-}
-
-static const char *kallsyms_symbol_name(struct mod_kallsyms *kallsyms, unsigned int symnum)
-{
-	return kallsyms->strtab + kallsyms->symtab[symnum].st_name;
-}
-
-/*
- * Given a module and address, find the corresponding symbol and return its name
- * while providing its size and offset if needed.
- */
-static const char *find_kallsyms_symbol(struct module *mod,
-					unsigned long addr,
-					unsigned long *size,
-					unsigned long *offset)
-{
-	unsigned int i, best = 0;
-	unsigned long nextval, bestval;
-	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
-
-	/* At worse, next value is at end of module */
-	if (within_module_init(addr, mod))
-		nextval = (unsigned long)mod->init_layout.base+mod->init_layout.text_size;
-	else
-		nextval = (unsigned long)mod->core_layout.base+mod->core_layout.text_size;
-
-	bestval = kallsyms_symbol_value(&kallsyms->symtab[best]);
-
-	/*
-	 * Scan for closest preceding symbol, and next symbol. (ELF
-	 * starts real symbols at 1).
-	 */
-	for (i = 1; i < kallsyms->num_symtab; i++) {
-		const Elf_Sym *sym = &kallsyms->symtab[i];
-		unsigned long thisval = kallsyms_symbol_value(sym);
-
-		if (sym->st_shndx == SHN_UNDEF)
-			continue;
-
-		/*
-		 * We ignore unnamed symbols: they're uninformative
-		 * and inserted at a whim.
-		 */
-		if (*kallsyms_symbol_name(kallsyms, i) == '\0'
-		    || is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
-			continue;
-
-		if (thisval <= addr && thisval > bestval) {
-			best = i;
-			bestval = thisval;
-		}
-		if (thisval > addr && thisval < nextval)
-			nextval = thisval;
-	}
-
-	if (!best)
-		return NULL;
-
-	if (size)
-		*size = nextval - bestval;
-	if (offset)
-		*offset = addr - bestval;
-
-	return kallsyms_symbol_name(kallsyms, best);
-}
-
-void * __weak dereference_module_function_descriptor(struct module *mod,
-						     void *ptr)
-{
-	return ptr;
-}
-
-/*
- * For kallsyms to ask for address resolution.  NULL means not found.  Careful
- * not to lock to avoid deadlock on oopses, simply disable preemption.
- */
-const char *module_address_lookup(unsigned long addr,
-			    unsigned long *size,
-			    unsigned long *offset,
-			    char **modname,
-			    const unsigned char **modbuildid,
-			    char *namebuf)
-{
-	const char *ret = NULL;
-	struct module *mod;
-
-	preempt_disable();
-	mod = __module_address(addr);
-	if (mod) {
-		if (modname)
-			*modname = mod->name;
-		if (modbuildid) {
-#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
-			*modbuildid = mod->build_id;
-#else
-			*modbuildid = NULL;
-#endif
-		}
-
-		ret = find_kallsyms_symbol(mod, addr, size, offset);
-	}
-	/* Make a copy in here where it's safe */
-	if (ret) {
-		strncpy(namebuf, ret, KSYM_NAME_LEN - 1);
-		ret = namebuf;
-	}
-	preempt_enable();
-
-	return ret;
-}
-
-int lookup_module_symbol_name(unsigned long addr, char *symname)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		if (within_module(addr, mod)) {
-			const char *sym;
-
-			sym = find_kallsyms_symbol(mod, addr, NULL, NULL);
-			if (!sym)
-				goto out;
-
-			strlcpy(symname, sym, KSYM_NAME_LEN);
-			preempt_enable();
-			return 0;
-		}
-	}
-out:
-	preempt_enable();
-	return -ERANGE;
-}
-
-int lookup_module_symbol_attrs(unsigned long addr, unsigned long *size,
-			unsigned long *offset, char *modname, char *name)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		if (within_module(addr, mod)) {
-			const char *sym;
-
-			sym = find_kallsyms_symbol(mod, addr, size, offset);
-			if (!sym)
-				goto out;
-			if (modname)
-				strlcpy(modname, mod->name, MODULE_NAME_LEN);
-			if (name)
-				strlcpy(name, sym, KSYM_NAME_LEN);
-			preempt_enable();
-			return 0;
-		}
-	}
-out:
-	preempt_enable();
-	return -ERANGE;
-}
-
-int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
-			char *name, char *module_name, int *exported)
-{
-	struct module *mod;
-
-	preempt_disable();
-	list_for_each_entry_rcu(mod, &modules, list) {
-		struct mod_kallsyms *kallsyms;
-
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		kallsyms = rcu_dereference_sched(mod->kallsyms);
-		if (symnum < kallsyms->num_symtab) {
-			const Elf_Sym *sym = &kallsyms->symtab[symnum];
-
-			*value = kallsyms_symbol_value(sym);
-			*type = kallsyms->typetab[symnum];
-			strlcpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
-			strlcpy(module_name, mod->name, MODULE_NAME_LEN);
-			*exported = is_exported(name, *value, mod);
-			preempt_enable();
-			return 0;
-		}
-		symnum -= kallsyms->num_symtab;
-	}
-	preempt_enable();
-	return -ERANGE;
-}
-
-/* Given a module and name of symbol, find and return the symbol's value */
-static unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
-{
-	unsigned int i;
-	struct mod_kallsyms *kallsyms = rcu_dereference_sched(mod->kallsyms);
-
-	for (i = 0; i < kallsyms->num_symtab; i++) {
-		const Elf_Sym *sym = &kallsyms->symtab[i];
-
-		if (strcmp(name, kallsyms_symbol_name(kallsyms, i)) == 0 &&
-		    sym->st_shndx != SHN_UNDEF)
-			return kallsyms_symbol_value(sym);
-	}
-	return 0;
-}
-
-/* Look for this name: can be of form module:name. */
-unsigned long module_kallsyms_lookup_name(const char *name)
-{
-	struct module *mod;
-	char *colon;
-	unsigned long ret = 0;
-
-	/* Don't lock: we're in enough trouble already. */
-	preempt_disable();
-	if ((colon = strnchr(name, MODULE_NAME_LEN, ':')) != NULL) {
-		if ((mod = find_module_all(name, colon - name, false)) != NULL)
-			ret = find_kallsyms_symbol_value(mod, colon+1);
-	} else {
-		list_for_each_entry_rcu(mod, &modules, list) {
-			if (mod->state == MODULE_STATE_UNFORMED)
-				continue;
-			if ((ret = find_kallsyms_symbol_value(mod, name)) != 0)
-				break;
-		}
-	}
-	preempt_enable();
-	return ret;
-}
-
-#ifdef CONFIG_LIVEPATCH
-int module_kallsyms_on_each_symbol(int (*fn)(void *, const char *,
-					     struct module *, unsigned long),
-				   void *data)
-{
-	struct module *mod;
-	unsigned int i;
-	int ret = 0;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry(mod, &modules, list) {
-		/* We hold module_mutex: no need for rcu_dereference_sched */
-		struct mod_kallsyms *kallsyms = mod->kallsyms;
-
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-		for (i = 0; i < kallsyms->num_symtab; i++) {
-			const Elf_Sym *sym = &kallsyms->symtab[i];
-
-			if (sym->st_shndx == SHN_UNDEF)
-				continue;
-
-			ret = fn(data, kallsyms_symbol_name(kallsyms, i),
-				 mod, kallsyms_symbol_value(sym));
-			if (ret != 0)
-				goto out;
-		}
-	}
-out:
-	mutex_unlock(&module_mutex);
-	return ret;
-}
-#endif /* CONFIG_LIVEPATCH */
-#endif /* CONFIG_KALLSYMS */
-
 static void cfi_init(struct module *mod)
 {
 #ifdef CONFIG_CFI_CLANG
-- 
2.31.1

