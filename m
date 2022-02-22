Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004974BFA9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiBVOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiBVONy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BB67113DA6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645539204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KmEW6iB3oXRO8A+rH979sIuK/nynPQ326m6j/Z+UyIw=;
        b=FSx++9SMFu1PAF7fxgGUYbX/yNsrVxaC0Dar3jmb9mduGrUDRGhVdkOc5LGEUEuE+VLEaS
        D0ZWOLXlFIKLMVH2JDp2DxVutzDEs5b4CVkDkmpFD8JC5yzgqwyRFfLjQepb8TVgKHX0MQ
        e3a0zAcDK7sXAsZbL3wlTT1H2oaig7Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-SWDP-ktPMUSK2XoIn2II3g-1; Tue, 22 Feb 2022 09:13:22 -0500
X-MC-Unique: SWDP-ktPMUSK2XoIn2II3g-1
Received: by mail-wm1-f70.google.com with SMTP id j39-20020a05600c1c2700b0037becd18addso671169wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:13:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KmEW6iB3oXRO8A+rH979sIuK/nynPQ326m6j/Z+UyIw=;
        b=rVq/BiYUmqKvl4HVYhWyd6xLFS1bYLR0GLtSe2X6gSM4JNDxTGkyRnp5maKfnAV0m/
         7vWgQcsfoKG5seAztv5MZ3zDBxbV1q9E0g6lLu//8Js3lSPbiBduy4iyQh0nlrKw2uTS
         NgspzQ7HanRkqamB50DiNxlN/Z7ExrYF+FfwJoTFFcdSeTkuq+Ic68C8ALZAEaQsf4cZ
         ifmx671wXBp7xalz9qQD9iVQ572u32GBa/KtLz6QGfvSlYFzT8t2GpN2mB0I4qQBAvhq
         cW8LTaqjAoJa+AVLOrCwKvnups/ablLKx4JrtS48Y2S01UwP8LE0Qhzuqgitt8v5w9+w
         f0cA==
X-Gm-Message-State: AOAM530y2068pGQAt9i9+3i6dcRmBkBYajXTDFedekBkqE4YvIxIuJa+
        HNKQLNLEugG5mwfTljNZwGxMReUZyuDf/DNLdyDbof8L6x0FgGBlJQtH+6WmaeKmmfx3DzifmnJ
        ZRLOPOtXO5Irei87mHxauj7k=
X-Received: by 2002:adf:f2c5:0:b0:1e3:fd9:4db8 with SMTP id d5-20020adff2c5000000b001e30fd94db8mr19001010wrp.623.1645539201311;
        Tue, 22 Feb 2022 06:13:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVtHDxddOoq90tLoiOjdJ2b5sNEzVr6iskrqMhyy+sL7NBQiRG5is40Fc2/kfJGxfC4xxZQA==
X-Received: by 2002:adf:f2c5:0:b0:1e3:fd9:4db8 with SMTP id d5-20020adff2c5000000b001e30fd94db8mr19000990wrp.623.1645539201034;
        Tue, 22 Feb 2022 06:13:21 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n15sm28281489wri.80.2022.02.22.06.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:13:20 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v8 13/13] module: Move version support into a separate file
Date:   Tue, 22 Feb 2022 14:13:03 +0000
Message-Id: <20220222141303.1392190-14-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222141303.1392190-1-atomlin@redhat.com>
References: <20220222141303.1392190-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates module version support out of core code into
kernel/module/version.c. In addition simple code refactoring to
make this possible.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |  48 ++++++++++++
 kernel/module/main.c     | 156 ++-------------------------------------
 kernel/module/version.c  | 109 +++++++++++++++++++++++++++
 4 files changed, 166 insertions(+), 148 deletions(-)
 create mode 100644 kernel/module/version.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index cf8dcdc6b55f..a46e6361017f 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
+obj-$(CONFIG_MODVERSIONS) += version.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 62d749ef695e..3fc139d5074b 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -70,7 +70,27 @@ struct load_info {
 	} index;
 };
 
+enum mod_license {
+	NOT_GPL_ONLY,
+	GPL_ONLY,
+};
+
+struct find_symbol_arg {
+	/* Input */
+	const char *name;
+	bool gplok;
+	bool warn;
+
+	/* Output */
+	struct module *owner;
+	const s32 *crc;
+	const struct kernel_symbol *sym;
+	enum mod_license license;
+};
+
 int mod_verify_sig(const void *mod, struct load_info *info);
+int try_to_force_load(struct module *mod, const char *reason);
+bool find_symbol(struct find_symbol_arg *fsa);
 struct module *find_module_all(const char *name, size_t len, bool even_unformed);
 int cmp_name(const void *name, const void *sym);
 long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
@@ -225,3 +245,31 @@ static inline int mod_sysfs_setup(struct module *mod,
 static inline void mod_sysfs_teardown(struct module *mod) { }
 static inline void init_param_lock(struct module *mod) { }
 #endif /* CONFIG_SYSFS */
+
+#ifdef CONFIG_MODVERSIONS
+int check_version(const struct load_info *info,
+		  const char *symname, struct module *mod, const s32 *crc);
+void module_layout(struct module *mod, struct modversion_info *ver, struct kernel_param *kp,
+		   struct kernel_symbol *ks, struct tracepoint * const *tp);
+int check_modstruct_version(const struct load_info *info, struct module *mod);
+int same_magic(const char *amagic, const char *bmagic, bool has_crcs);
+#else /* !CONFIG_MODVERSIONS */
+static inline int check_version(const struct load_info *info,
+				const char *symname,
+				struct module *mod,
+				const s32 *crc)
+{
+	return 1;
+}
+
+static inline int check_modstruct_version(const struct load_info *info,
+					  struct module *mod)
+{
+	return 1;
+}
+
+static inline int same_magic(const char *amagic, const char *bmagic, bool has_crcs)
+{
+	return strcmp(amagic, bmagic) == 0;
+}
+#endif /* CONFIG_MODVERSIONS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bcc4f7a82649..0749afdc34b5 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -86,6 +86,12 @@ struct mod_tree_root mod_tree __cacheline_aligned = {
 static unsigned long module_addr_min = -1UL, module_addr_max;
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
 
+struct symsearch {
+	const struct kernel_symbol *start, *stop;
+	const s32 *crcs;
+	enum mod_license license;
+};
+
 /*
  * Bounds of module text, for speeding up __module_address.
  * Protected by module_mutex.
@@ -244,28 +250,6 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 #define symversion(base, idx) ((base != NULL) ? ((base) + (idx)) : NULL)
 #endif
 
-struct symsearch {
-	const struct kernel_symbol *start, *stop;
-	const s32 *crcs;
-	enum mod_license {
-		NOT_GPL_ONLY,
-		GPL_ONLY,
-	} license;
-};
-
-struct find_symbol_arg {
-	/* Input */
-	const char *name;
-	bool gplok;
-	bool warn;
-
-	/* Output */
-	struct module *owner;
-	const s32 *crc;
-	const struct kernel_symbol *sym;
-	enum mod_license license;
-};
-
 static bool check_exported_symbol(const struct symsearch *syms,
 				  struct module *owner,
 				  unsigned int symnum, void *data)
@@ -327,7 +311,7 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
  * Find an exported symbol and return it, along with, (optional) crc and
  * (optional) module which owns it.  Needs preempt disabled or module_mutex.
  */
-static bool find_symbol(struct find_symbol_arg *fsa)
+bool find_symbol(struct find_symbol_arg *fsa)
 {
 	static const struct symsearch arr[] = {
 		{ __start___ksymtab, __stop___ksymtab, __start___kcrctab,
@@ -1001,7 +985,7 @@ size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
 
 static const char vermagic[] = VERMAGIC_STRING;
 
-static int try_to_force_load(struct module *mod, const char *reason)
+int try_to_force_load(struct module *mod, const char *reason)
 {
 #ifdef CONFIG_MODULE_FORCE_LOAD
 	if (!test_taint(TAINT_FORCED_MODULE))
@@ -1013,115 +997,6 @@ static int try_to_force_load(struct module *mod, const char *reason)
 #endif
 }
 
-#ifdef CONFIG_MODVERSIONS
-
-static u32 resolve_rel_crc(const s32 *crc)
-{
-	return *(u32 *)((void *)crc + *crc);
-}
-
-static int check_version(const struct load_info *info,
-			 const char *symname,
-			 struct module *mod,
-			 const s32 *crc)
-{
-	Elf_Shdr *sechdrs = info->sechdrs;
-	unsigned int versindex = info->index.vers;
-	unsigned int i, num_versions;
-	struct modversion_info *versions;
-
-	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
-	if (!crc)
-		return 1;
-
-	/* No versions at all?  modprobe --force does this. */
-	if (versindex == 0)
-		return try_to_force_load(mod, symname) == 0;
-
-	versions = (void *) sechdrs[versindex].sh_addr;
-	num_versions = sechdrs[versindex].sh_size
-		/ sizeof(struct modversion_info);
-
-	for (i = 0; i < num_versions; i++) {
-		u32 crcval;
-
-		if (strcmp(versions[i].name, symname) != 0)
-			continue;
-
-		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
-			crcval = resolve_rel_crc(crc);
-		else
-			crcval = *crc;
-		if (versions[i].crc == crcval)
-			return 1;
-		pr_debug("Found checksum %X vs module %lX\n",
-			 crcval, versions[i].crc);
-		goto bad_version;
-	}
-
-	/* Broken toolchain. Warn once, then let it go.. */
-	pr_warn_once("%s: no symbol version for %s\n", info->name, symname);
-	return 1;
-
-bad_version:
-	pr_warn("%s: disagrees about version of symbol %s\n",
-	       info->name, symname);
-	return 0;
-}
-
-static inline int check_modstruct_version(const struct load_info *info,
-					  struct module *mod)
-{
-	struct find_symbol_arg fsa = {
-		.name	= "module_layout",
-		.gplok	= true,
-	};
-
-	/*
-	 * Since this should be found in kernel (which can't be removed), no
-	 * locking is necessary -- use preempt_disable() to placate lockdep.
-	 */
-	preempt_disable();
-	if (!find_symbol(&fsa)) {
-		preempt_enable();
-		BUG();
-	}
-	preempt_enable();
-	return check_version(info, "module_layout", mod, fsa.crc);
-}
-
-/* First part is kernel version, which we ignore if module has crcs. */
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	if (has_crcs) {
-		amagic += strcspn(amagic, " ");
-		bmagic += strcspn(bmagic, " ");
-	}
-	return strcmp(amagic, bmagic) == 0;
-}
-#else
-static inline int check_version(const struct load_info *info,
-				const char *symname,
-				struct module *mod,
-				const s32 *crc)
-{
-	return 1;
-}
-
-static inline int check_modstruct_version(const struct load_info *info,
-					  struct module *mod)
-{
-	return 1;
-}
-
-static inline int same_magic(const char *amagic, const char *bmagic,
-			     bool has_crcs)
-{
-	return strcmp(amagic, bmagic) == 0;
-}
-#endif /* CONFIG_MODVERSIONS */
-
 static char *get_modinfo(const struct load_info *info, const char *tag);
 static char *get_next_modinfo(const struct load_info *info, const char *tag,
 			      char *prev);
@@ -3247,18 +3122,3 @@ void print_modules(void)
 		pr_cont(" [last unloaded: %s]", last_unloaded_module);
 	pr_cont("\n");
 }
-
-#ifdef CONFIG_MODVERSIONS
-/*
- * Generate the signature for all relevant module structures here.
- * If these change, we don't want to try to parse the module.
- */
-void module_layout(struct module *mod,
-		   struct modversion_info *ver,
-		   struct kernel_param *kp,
-		   struct kernel_symbol *ks,
-		   struct tracepoint * const *tp)
-{
-}
-EXPORT_SYMBOL(module_layout);
-#endif
diff --git a/kernel/module/version.c b/kernel/module/version.c
new file mode 100644
index 000000000000..adaedce1dc97
--- /dev/null
+++ b/kernel/module/version.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module version support
+ *
+ * Copyright (C) 2008 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/printk.h>
+#include "internal.h"
+
+static u32 resolve_rel_crc(const s32 *crc)
+{
+	return *(u32 *)((void *)crc + *crc);
+}
+
+int check_version(const struct load_info *info,
+		  const char *symname,
+			 struct module *mod,
+			 const s32 *crc)
+{
+	Elf_Shdr *sechdrs = info->sechdrs;
+	unsigned int versindex = info->index.vers;
+	unsigned int i, num_versions;
+	struct modversion_info *versions;
+
+	/* Exporting module didn't supply crcs?  OK, we're already tainted. */
+	if (!crc)
+		return 1;
+
+	/* No versions at all?  modprobe --force does this. */
+	if (versindex == 0)
+		return try_to_force_load(mod, symname) == 0;
+
+	versions = (void *)sechdrs[versindex].sh_addr;
+	num_versions = sechdrs[versindex].sh_size
+		/ sizeof(struct modversion_info);
+
+	for (i = 0; i < num_versions; i++) {
+		u32 crcval;
+
+		if (strcmp(versions[i].name, symname) != 0)
+			continue;
+
+		if (IS_ENABLED(CONFIG_MODULE_REL_CRCS))
+			crcval = resolve_rel_crc(crc);
+		else
+			crcval = *crc;
+		if (versions[i].crc == crcval)
+			return 1;
+		pr_debug("Found checksum %X vs module %lX\n",
+			 crcval, versions[i].crc);
+		goto bad_version;
+	}
+
+	/* Broken toolchain. Warn once, then let it go.. */
+	pr_warn_once("%s: no symbol version for %s\n", info->name, symname);
+	return 1;
+
+bad_version:
+	pr_warn("%s: disagrees about version of symbol %s\n", info->name, symname);
+	return 0;
+}
+
+int check_modstruct_version(const struct load_info *info,
+			    struct module *mod)
+{
+	struct find_symbol_arg fsa = {
+		.name	= "module_layout",
+		.gplok	= true,
+	};
+
+	/*
+	 * Since this should be found in kernel (which can't be removed), no
+	 * locking is necessary -- use preempt_disable() to placate lockdep.
+	 */
+	preempt_disable();
+	if (!find_symbol(&fsa)) {
+		preempt_enable();
+		BUG();
+	}
+	preempt_enable();
+	return check_version(info, "module_layout", mod, fsa.crc);
+}
+
+/* First part is kernel version, which we ignore if module has crcs. */
+int same_magic(const char *amagic, const char *bmagic,
+	       bool has_crcs)
+{
+	if (has_crcs) {
+		amagic += strcspn(amagic, " ");
+		bmagic += strcspn(bmagic, " ");
+	}
+	return strcmp(amagic, bmagic) == 0;
+}
+
+/*
+ * Generate the signature for all relevant module structures here.
+ * If these change, we don't want to try to parse the module.
+ */
+void module_layout(struct module *mod,
+		   struct modversion_info *ver,
+		   struct kernel_param *kp,
+		   struct kernel_symbol *ks,
+		   struct tracepoint * const *tp)
+{
+}
+EXPORT_SYMBOL(module_layout);
-- 
2.34.1

