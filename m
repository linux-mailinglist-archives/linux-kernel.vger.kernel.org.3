Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB14D4484
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241334AbiCJK0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241286AbiCJKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BADF313FACD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZKsF3V2xKms5rUDdmplrUAEBHoN7M+YOs4uSrMcUTI=;
        b=MxDYmwm6dbDsBO73WFRIomM+2u7jSl9gI8qJrHA03grYyOZttab1EQsS081dJ04e5HtxXY
        w7UicOh+StqQWXIE3HxNC1cxSOSJtrmJ+RdVYNvd8pWNGabwAMfCN0tD3I7JMzHDnV241F
        t3R410VNFkmahAz71pJLKn7xnAHNLfI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-6zwDobdTOqSiQrt30enM6w-1; Thu, 10 Mar 2022 05:24:37 -0500
X-MC-Unique: 6zwDobdTOqSiQrt30enM6w-1
Received: by mail-wm1-f72.google.com with SMTP id m34-20020a05600c3b2200b0038115c73361so1945751wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZKsF3V2xKms5rUDdmplrUAEBHoN7M+YOs4uSrMcUTI=;
        b=D3rJiJv7DikmKglAW57CD2du2g3wqaazrnaZv9GNQjypRNHPBl5WSmy3ELyIRwv4H3
         LLVXYcr+Tf7sP5Y5k92PZ7dOqVIBGoRrszfhQfVb12JpcmDam1IQm3AI6/OTP858rglb
         TGqVsO+ptxbPKL9XQkXripkjD1aUhUVO+zfeUdcczPmrt5p3kTZSOBfe7Fv/Egp461Ll
         AIcXwgaiY2LGekb6gHUDN5E5r5yaRsAaXLS54OKXz683DSP88s9/r6R5lZ+vXpxHpYsQ
         hVbcjVUlmb08ZSTU8gI873+9brWYjAfu0oCt5BRbnU3+uav4ZLc3C7z7NWmRjJXxZNDT
         w+jg==
X-Gm-Message-State: AOAM5328svBv8bbD/4AXWoJ8tg+K2AqcGWrR96/rznCXxrDKMMTH5QVD
        fi8TtsexQIjUz86fzG4NsWCIuckQtN+n9q6WSDIrnm2+j3uAHHKxDSnab7KwcO0KLsq3v7MCZ1I
        UpcmL7/Gp5GNza1IgOIhz/bw=
X-Received: by 2002:a05:6000:11c8:b0:1f0:d64:fb0c with SMTP id i8-20020a05600011c800b001f00d64fb0cmr3037778wrx.279.1646907876037;
        Thu, 10 Mar 2022 02:24:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx33vrGgk2jBqaBLMuFbLfwrH8kR8jGJc5vI8A91vI/7JGaKC6erWcFz19V+CbNLDI7MMMr7w==
X-Received: by 2002:a05:6000:11c8:b0:1f0:d64:fb0c with SMTP id i8-20020a05600011c800b001f00d64fb0cmr3037740wrx.279.1646907875497;
        Thu, 10 Mar 2022 02:24:35 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k12-20020adfb34c000000b001f1e13df54dsm3798853wrd.89.2022.03.10.02.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:24:34 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 09/14] module: Move kallsyms support into a separate file
Date:   Thu, 10 Mar 2022 10:24:08 +0000
Message-Id: <20220310102413.3438665-10-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102413.3438665-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates kallsyms code out of core module
code kernel/module/kallsyms.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |  29 +++
 kernel/module/kallsyms.c | 502 ++++++++++++++++++++++++++++++++++++
 kernel/module/main.c     | 531 +--------------------------------------
 4 files changed, 538 insertions(+), 525 deletions(-)
 create mode 100644 kernel/module/kallsyms.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 12388627725c..9901bed3ab5b 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
+obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index b0c360839f63..44ca05b9eb8f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -68,6 +68,19 @@ struct load_info {
 };
 
 int mod_verify_sig(const void *mod, struct load_info *info);
+struct module *find_module_all(const char *name, size_t len, bool even_unformed);
+int cmp_name(const void *name, const void *sym);
+long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
+		       unsigned int section);
+
+static inline unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
+{
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+	return (unsigned long)offset_to_ptr(&sym->value_offset);
+#else
+	return sym->value;
+#endif
+}
 
 #ifdef CONFIG_LIVEPATCH
 int copy_module_elf(struct module *mod, struct load_info *info);
@@ -174,3 +187,19 @@ void kmemleak_load_module(const struct module *mod, const struct load_info *info
 static inline void kmemleak_load_module(const struct module *mod,
 					const struct load_info *info) { }
 #endif /* CONFIG_DEBUG_KMEMLEAK */
+
+#ifdef CONFIG_KALLSYMS
+void init_build_id(struct module *mod, const struct load_info *info);
+void layout_symtab(struct module *mod, struct load_info *info);
+void add_kallsyms(struct module *mod, const struct load_info *info);
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name);
+
+static inline bool sect_empty(const Elf_Shdr *sect)
+{
+	return !(sect->sh_flags & SHF_ALLOC) || sect->sh_size == 0;
+}
+#else /* !CONFIG_KALLSYMS */
+static inline void init_build_id(struct module *mod, const struct load_info *info) { }
+static inline void layout_symtab(struct module *mod, struct load_info *info) { }
+static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
+#endif /* CONFIG_KALLSYMS */
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
new file mode 100644
index 000000000000..1b0780e20aab
--- /dev/null
+++ b/kernel/module/kallsyms.c
@@ -0,0 +1,502 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kallsyms support
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
+
+	if (!mod)
+		ks = lookup_exported_symbol(name, __start___ksymtab, __stop___ksymtab);
+	else
+		ks = lookup_exported_symbol(name, mod->syms, mod->syms + mod->num_syms);
+
+	return ks && kernel_symbol_value(ks) == value;
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
+	if (sechdrs[sym->st_shndx].sh_flags & SHF_ALLOC &&
+	    sechdrs[sym->st_shndx].sh_type != SHT_NOBITS) {
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
+			   unsigned int shnum, unsigned int pcpundx)
+{
+	const Elf_Shdr *sec;
+
+	if (src->st_shndx == SHN_UNDEF ||
+	    src->st_shndx >= shnum ||
+	    !src->st_name)
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
+	symsect->sh_entsize = module_get_offset(mod, &mod->init_layout.size, symsect,
+						info->index.sym) | INIT_OFFSET_MASK;
+	pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
+
+	src = (void *)info->hdr + symsect->sh_offset;
+	nsrc = symsect->sh_size / sizeof(*src);
+
+	/* Compute total space required for the core symbols' strtab. */
+	for (ndst = i = 0; i < nsrc; i++) {
+		if (i == 0 || is_livepatch_module(mod) ||
+		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu)) {
+			strtab_size += strlen(&info->strtab[src[i].st_name]) + 1;
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
+	strsect->sh_entsize = module_get_offset(mod, &mod->init_layout.size, strsect,
+						info->index.str) | INIT_OFFSET_MASK;
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
+	/* The following is safe since this pointer cannot change */
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
+		    is_core_symbol(src + i, info->sechdrs, info->hdr->e_shnum,
+				   info->index.pcpu)) {
+			mod->core_kallsyms.typetab[ndst] =
+			    mod->kallsyms->typetab[i];
+			dst[ndst] = src[i];
+			dst[ndst++].st_name = s - mod->core_kallsyms.strtab;
+			s += strscpy(s, &mod->kallsyms->strtab[src[i].st_name],
+				     KSYM_NAME_LEN) + 1;
+		}
+	}
+	mod->core_kallsyms.num_symtab = ndst;
+}
+
+#if IS_ENABLED(CONFIG_STACKTRACE_BUILD_ID)
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
+#else
+void init_build_id(struct module *mod, const struct load_info *info)
+{
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
+	return str[0] == '$' && strchr("axtd", str[1]) &&
+	       (str[2] == '\0' || str[2] == '.');
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
+static const char *find_kallsyms_symbol(struct module *mod,
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
+		nextval = (unsigned long)mod->init_layout.base + mod->init_layout.text_size;
+	else
+		nextval = (unsigned long)mod->core_layout.base + mod->core_layout.text_size;
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
+		if (*kallsyms_symbol_name(kallsyms, i) == '\0' ||
+		    is_arm_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
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
+				  unsigned long *size,
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
+			strscpy(symname, sym, KSYM_NAME_LEN);
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
+			       unsigned long *offset, char *modname, char *name)
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
+				strscpy(modname, mod->name, MODULE_NAME_LEN);
+			if (name)
+				strscpy(name, sym, KSYM_NAME_LEN);
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
+		       char *name, char *module_name, int *exported)
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
+			strscpy(name, kallsyms_symbol_name(kallsyms, symnum), KSYM_NAME_LEN);
+			strscpy(module_name, mod->name, MODULE_NAME_LEN);
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
+unsigned long find_kallsyms_symbol_value(struct module *mod, const char *name)
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
+			ret = find_kallsyms_symbol_value(mod, colon + 1);
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
index 7dd283959c5c..952079987ea4 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -288,15 +288,6 @@ static bool check_exported_symbol(const struct symsearch *syms,
 	return true;
 }
 
-static unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
-{
-#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
-	return (unsigned long)offset_to_ptr(&sym->value_offset);
-#else
-	return sym->value;
-#endif
-}
-
 static const char *kernel_symbol_name(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
@@ -317,7 +308,7 @@ static const char *kernel_symbol_namespace(const struct kernel_symbol *sym)
 #endif
 }
 
-static int cmp_name(const void *name, const void *sym)
+int cmp_name(const void *name, const void *sym)
 {
 	return strcmp(name, kernel_symbol_name(sym));
 }
@@ -387,8 +378,8 @@ static bool find_symbol(struct find_symbol_arg *fsa)
  * Search for module by name: must hold module_mutex (or preempt disabled
  * for read-only access).
  */
-static struct module *find_module_all(const char *name, size_t len,
-				      bool even_unformed)
+struct module *find_module_all(const char *name, size_t len,
+			       bool even_unformed)
 {
 	struct module *mod;
 
@@ -1294,13 +1285,6 @@ resolve_symbol_wait(struct module *mod,
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
@@ -2065,7 +2049,7 @@ unsigned int __weak arch_mod_section_prepend(struct module *mod,
 }
 
 /* Update size with this section: return offset. */
-static long get_offset(struct module *mod, unsigned int *size,
+long module_get_offset(struct module *mod, unsigned int *size,
 		       Elf_Shdr *sechdr, unsigned int section)
 {
 	long ret;
@@ -2121,7 +2105,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || module_init_layout_section(sname))
 				continue;
-			s->sh_entsize = get_offset(mod, &mod->core_layout.size, s, i);
+			s->sh_entsize = module_get_offset(mod, &mod->core_layout.size, s, i);
 			pr_debug("\t%s\n", sname);
 		}
 		switch (m) {
@@ -2154,7 +2138,7 @@ static void layout_sections(struct module *mod, struct load_info *info)
 			    || s->sh_entsize != ~0UL
 			    || !module_init_layout_section(sname))
 				continue;
-			s->sh_entsize = (get_offset(mod, &mod->init_layout.size, s, i)
+			s->sh_entsize = (module_get_offset(mod, &mod->init_layout.size, s, i)
 					 | INIT_OFFSET_MASK);
 			pr_debug("\t%s\n", sname);
 		}
@@ -2267,228 +2251,6 @@ static void free_modinfo(struct module *mod)
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
@@ -3799,287 +3561,6 @@ static inline int within(unsigned long addr, void *start, unsigned long size)
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
-
-			cond_resched();
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
2.34.1

