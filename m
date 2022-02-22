Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4A4BFC3B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiBVPSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBVPRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:17:43 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2D9AB441;
        Tue, 22 Feb 2022 07:17:12 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K32nz2ndJz9sSm;
        Tue, 22 Feb 2022 16:16:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PM-0u1yQtH0S; Tue, 22 Feb 2022 16:16:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K32nw5l2mz9sSp;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AECC28B781;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7lpda_ch5qPb; Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.78])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 46B3A8B779;
        Tue, 22 Feb 2022 16:16:52 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21MFGgTk1087714
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 16:16:42 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21MFGgHL1087713;
        Tue, 22 Feb 2022 16:16:42 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] module: Move module_enable_x() and frob_text() in strict_rwx.c
Date:   Tue, 22 Feb 2022 16:16:32 +0100
Message-Id: <1545ae8fcef61d5741fa684ad5816b5dd3a418bc.1645542893.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645542893.git.christophe.leroy@csgroup.eu>
References: <cover.1645542893.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645542984; l=7341; s=20211009; h=from:subject:message-id; bh=wUj6D7B9/Eu7E72Eq1hFg4hRDQ2fPolBrGntvtG6lQ8=; b=m5HdxFJ/6ow8rVHuIfLOcphQXdP0/4qb4nVoGhYnd9NRR4ADsBFVhL97xmkVrk4pFYYFL4b4SkKT zsWk5w/2CFIPzcVPgjJ8FJlmZauZ3dNcpMWfzYPRSazSck5J1wb6
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
 kernel/module/main.c       | 37 -----------------------------
 kernel/module/strict_rwx.c | 48 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a46e6361017f..a94f7b8b2740 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,12 +7,11 @@
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
 
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
index 7178b7c09cdd..276e3f49a4ae 100644
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
-				       char *secstrings, struct module *mod)
-{
-	return 0;
-}
-#endif /* CONFIG_STRICT_MODULE_RWX */
-
 #ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
 #else /* !CONFIG_MODULE_SIG */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index be3b31ba6e16..47addf849ef7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1142,43 +1142,6 @@ resolve_symbol_wait(struct module *mod,
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
-	if (!PAGE_ALIGNED(mod->core_layout.base) ||
-	    !PAGE_ALIGNED(mod->init_layout.base))
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
index 1a6b9573260b..6b99be9e88e1 100644
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

