Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F94BF648
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiBVKkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 05:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbiBVKkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 05:40:01 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC4915AF12;
        Tue, 22 Feb 2022 02:39:32 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K2wdh4K2tz9sT6;
        Tue, 22 Feb 2022 11:39:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h2jlBWO3szAD; Tue, 22 Feb 2022 11:39:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K2wdb6mYjz9sT5;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D5DAD8B783;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PlSJrMjOJ7r2; Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A46CA8B779;
        Tue, 22 Feb 2022 11:39:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MAd7Ra1076218
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 11:39:07 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MAd7HK1076217;
        Tue, 22 Feb 2022 11:39:07 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/6] module: Move module_enable_x() and frob_text() in strict_rwx.c
Date:   Tue, 22 Feb 2022 11:38:58 +0100
Message-Id: <8fdf932ba4ae4b6a72b7439dbe4fedb7de30ae3e.1645526008.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645526008.git.christophe.leroy@csgroup.eu>
References: <cover.1645526008.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645526317; l=7350; s=20211009; h=from:subject:message-id; bh=DzolO/LhQKwrnqLza+xjE1AU+Gi9hEBK6ObvQJ8/Yrs=; b=JEcB6uyK8hDuEqB91pib7jW/KRXUWlpDFeKIcuq7uDq8aOUWaXYhWp/3xTj7aRf6qgtO5dR83feT B+iuLWuADEZscBso9a9NhiU+jVbU80GQiECeXOllWcGRxiIzLVWP
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

Move module_enable_x() together with module_enable_nx() and
module_enable_ro().

Those three functions are going together, they are all used
to set up the correct page flags on the different sections.

As module_enable_x() is used independently of
CONFIG_STRICT_MODULE_RWX, build strict_rwx.c all the time and
use IS_ENABLED(CONFIG_STRICT_MODULE_RWX) when relevant.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 kernel/module/Makefile     |  3 +--
 kernel/module/internal.h   | 15 +-----------
 kernel/module/main.c       | 38 ------------------------------
 kernel/module/strict_rwx.c | 48 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 5fe90d246fcc..037ecc72ac23 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,12 +7,11 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_main.o := n
 
-obj-y += main.o
+obj-y += main.o strict_rwx.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
-obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ec4b46c67d10..b80a746b2e5a 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -182,25 +182,12 @@ static inline struct module *mod_find(unsigned long addr, struct mod_tree_root *
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
-void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned long start,
-								     int num_pages));
-
-#ifdef CONFIG_STRICT_MODULE_RWX
 void module_enable_ro(const struct module *mod, bool after_init);
 void module_enable_nx(const struct module *mod);
+void module_enable_x(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
-#else /* !CONFIG_STRICT_MODULE_RWX */
-static inline void module_enable_nx(const struct module *mod) { }
-static inline void module_enable_ro(const struct module *mod, bool after_init) {}
-static inline int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-					      char *secstrings, struct module *mod)
-{
-	return 0;
-}
-#endif /* CONFIG_STRICT_MODULE_RWX */
-
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
 #else /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2b2f5d79bd7a..47addf849ef7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1142,44 +1142,6 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }
 
-/*
- * LKM RO/NX protection: protect module's text/ro-data
- * from modification and any data from execution.
- *
- * General layout of module is:
- *          [text] [read-only-data] [ro-after-init] [writable data]
- * text_size -----^                ^               ^               ^
- * ro_size ------------------------|               |               |
- * ro_after_init_size -----------------------------|               |
- * size -----------------------------------------------------------|
- *
- * These values are always page-aligned (as is base)
- */
-
-/*
- * Since some arches are moving towards PAGE_KERNEL module allocations instead
- * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
- * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
- * whether we are strict.
- */
-void frob_text(const struct module_layout *layout,
-	       int (*set_memory)(unsigned long start, int num_pages))
-{
-	set_memory((unsigned long)layout->base,
-		   PAGE_ALIGN(layout->text_size) >> PAGE_SHIFT);
-}
-
-static void module_enable_x(const struct module *mod)
-{
-	if (!PAGE_ALIGNED(mod->core_layout.base))
-		return;
-	if (!PAGE_ALIGNED(mod->init_layout.base))
-		return;
-
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
-}
-
 void __weak module_memfree(void *module_region)
 {
 	/*
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index a2104e9233a5..b023cea06af0 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -11,6 +11,34 @@
 #include <linux/set_memory.h>
 #include "internal.h"
 
+/*
+ * LKM RO/NX protection: protect module's text/ro-data
+ * from modification and any data from execution.
+ *
+ * General layout of module is:
+ *          [text] [read-only-data] [ro-after-init] [writable data]
+ * text_size -----^                ^               ^               ^
+ * ro_size ------------------------|               |               |
+ * ro_after_init_size -----------------------------|               |
+ * size -----------------------------------------------------------|
+ *
+ * These values are always page-aligned (as is base) when
+ * CONFIG_STRICT_MODULE_RWX is set.
+ */
+
+/*
+ * Since some arches are moving towards PAGE_KERNEL module allocations instead
+ * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() independent of
+ * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whether we
+ * are strict.
+ */
+static void frob_text(const struct module_layout *layout,
+		      int (*set_memory)(unsigned long start, int num_pages))
+{
+	set_memory((unsigned long)layout->base,
+		   PAGE_ALIGN(layout->text_size) >> PAGE_SHIFT);
+}
+
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
 {
@@ -41,10 +69,24 @@ static void frob_writable_data(const struct module_layout *layout,
 		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
 }
 
+void module_enable_x(const struct module *mod)
+{
+	if (!PAGE_ALIGNED(mod->core_layout.base) ||
+	    !PAGE_ALIGNED(mod->init_layout.base))
+		return;
+
+	frob_text(&mod->core_layout, set_memory_x);
+	frob_text(&mod->init_layout, set_memory_x);
+}
+
 void module_enable_ro(const struct module *mod, bool after_init)
 {
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return;
+#ifdef CONFIG_STRICT_MODULE_RWX
 	if (!rodata_enabled)
 		return;
+#endif
 
 	set_vm_flush_reset_perms(mod->core_layout.base);
 	set_vm_flush_reset_perms(mod->init_layout.base);
@@ -60,6 +102,9 @@ void module_enable_ro(const struct module *mod, bool after_init)
 
 void module_enable_nx(const struct module *mod)
 {
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return;
+
 	frob_rodata(&mod->data_layout, set_memory_nx);
 	frob_ro_after_init(&mod->data_layout, set_memory_nx);
 	frob_writable_data(&mod->data_layout, set_memory_nx);
@@ -73,6 +118,9 @@ int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 	const unsigned long shf_wx = SHF_WRITE | SHF_EXECINSTR;
 	int i;
 
+	if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		return 0;
+
 	for (i = 0; i < hdr->e_shnum; i++) {
 		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
 			pr_err("%s: section %s (index %d) has invalid WRITE|EXEC flags\n",
-- 
2.34.1

