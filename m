Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488834A021D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:40:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiA1Uj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:39:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27162 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344360AbiA1Ujn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d16QLh1b9mk2jCD+hTXFdS67qH+rGFScBQ+xHFcVQ8Y=;
        b=Jof6ekRY33TwuYlEDVCTui0oOl1NNbTlHxIk/ULoKX20u0QkdnZ3LtkOgFhx7vpo3dOlR7
        MtAeBJytVHsjLIkBufDVtz/GDDA5YXERUE2/4aaxiPn2hPH2/mgSQCWGTGfB7w54G/tzNk
        G4uo2S34xHDrJ+EiSVNa3Zsua+XjILY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-TM0mOraNPxaiSF0iCLCImQ-1; Fri, 28 Jan 2022 15:39:42 -0500
X-MC-Unique: TM0mOraNPxaiSF0iCLCImQ-1
Received: by mail-wm1-f71.google.com with SMTP id m189-20020a1c26c6000000b003508ba87dfbso1675491wmm.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d16QLh1b9mk2jCD+hTXFdS67qH+rGFScBQ+xHFcVQ8Y=;
        b=TQxiwetkweQS+SvZKJT+rGN7OxdJkzsQyoO3+W2BjEnxF/3Un0T5mNPZdYgq/cfisj
         RZY00zBBTNuaVPFpWlHb5oS1N8/W0WKI2d5VsEiTLEWLvkMJloXkbl7jhAoGeGgaVEjG
         JpM0JFpFJhuRlcZG/t+L9N2QOt89jIhXi2sU6AhYYU+PNNZvqC9w0/4nnuQX6DbvXcGw
         2aBcM6+ETcY9qDjBcjrg4p7oSyxfsrZo+jzwbgaWwAJOrvmPGAnWhP+ddQzYLUT2jOc5
         LmVhO9IpTpFMgYag4uH9G+QxLNtGOVNiVMjCMBfneZbg1rWTrz77dB+YUOEs98suISNe
         jNoQ==
X-Gm-Message-State: AOAM5305M56rtoyZdH7qvc4Jld5bF4wTG6pVi9mY7pC6/xP/UJdHRaEe
        r9s9fdMbn+L/5TVxa+RD3++Ahk44dCCjqn2fVcpKRFw7S3sccnjOA57iqqZW2PFtnoGC48B39X3
        zeSTOEPHikh+4Dil1QE+7iOY=
X-Received: by 2002:a5d:458d:: with SMTP id p13mr8704485wrq.580.1643402379772;
        Fri, 28 Jan 2022 12:39:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznnzOL+XK7/yi1zY0r025gKwZSHdCpphgz/2vVbU3vAB//bhuSlyCOuDAonCMMExhli3rjdg==
X-Received: by 2002:a5d:458d:: with SMTP id p13mr8704476wrq.580.1643402379519;
        Fri, 28 Jan 2022 12:39:39 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u14sm5309946wrm.58.2022.01.28.12.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:39 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 03/13] module: Move livepatch support to a separate file
Date:   Fri, 28 Jan 2022 20:39:24 +0000
Message-Id: <20220128203934.600247-4-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates livepatch support (i.e. used during module
add/or load and remove/or deletion) from core module code into
kernel/module/livepatch.c. At the moment it contains code to
persist Elf information about a given livepatch module, only.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h    |  11 ++++
 kernel/module/Makefile    |   1 +
 kernel/module/internal.h  |  10 ++++
 kernel/module/livepatch.c |  74 +++++++++++++++++++++++++++
 kernel/module/main.c      | 102 ++++----------------------------------
 5 files changed, 106 insertions(+), 92 deletions(-)
 create mode 100644 kernel/module/livepatch.c

diff --git a/include/linux/module.h b/include/linux/module.h
index f4338235ed2c..8d49f12a7601 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -668,11 +668,22 @@ static inline bool is_livepatch_module(struct module *mod)
 {
 	return mod->klp;
 }
+
+static inline bool set_livepatch_module(struct module *mod)
+{
+	mod->klp = true;
+	return true;
+}
 #else /* !CONFIG_LIVEPATCH */
 static inline bool is_livepatch_module(struct module *mod)
 {
 	return false;
 }
+
+static inline bool set_livepatch_module(struct module *mod)
+{
+	return false;
+}
 #endif /* CONFIG_LIVEPATCH */
 
 bool is_module_sig_enforced(void);
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 2902fc7d0ef1..ba3ebdb7055b 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -7,3 +7,4 @@ obj-$(CONFIG_MODULES) += main.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
+obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e3c593f8767f..0cd624179545 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -57,6 +57,16 @@ struct load_info {
 
 extern int mod_verify_sig(const void *mod, struct load_info *info);
 
+#ifdef CONFIG_LIVEPATCH
+extern int copy_module_elf(struct module *mod, struct load_info *info);
+extern void free_module_elf(struct module *mod);
+#else /* !CONFIG_LIVEPATCH */
+static inline int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	return 0;
+}
+static inline void free_module_elf(struct module *mod) { }
+#endif /* CONFIG_LIVEPATCH */
 #ifdef CONFIG_MODULE_DECOMPRESS
 int module_decompress(struct load_info *info, const void *buf, size_t size);
 void module_decompress_cleanup(struct load_info *info);
diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
new file mode 100644
index 000000000000..961045d32332
--- /dev/null
+++ b/kernel/module/livepatch.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module livepatch support
+ *
+ * Copyright (C) 2016 Jessica Yu <jeyu@redhat.com>
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Persist Elf information about a module. Copy the Elf header,
+ * section header table, section string table, and symtab section
+ * index from info to mod->klp_info.
+ */
+int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	unsigned int size, symndx;
+	int ret;
+
+	size = sizeof(*mod->klp_info);
+	mod->klp_info = kmalloc(size, GFP_KERNEL);
+	if (mod->klp_info == NULL)
+		return -ENOMEM;
+
+	/* Elf header */
+	size = sizeof(mod->klp_info->hdr);
+	memcpy(&mod->klp_info->hdr, info->hdr, size);
+
+	/* Elf section header table */
+	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
+	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
+	if (mod->klp_info->sechdrs == NULL) {
+		ret = -ENOMEM;
+		goto free_info;
+	}
+
+	/* Elf section name string table */
+	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
+	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
+	if (mod->klp_info->secstrings == NULL) {
+		ret = -ENOMEM;
+		goto free_sechdrs;
+	}
+
+	/* Elf symbol section index */
+	symndx = info->index.sym;
+	mod->klp_info->symndx = symndx;
+
+	/*
+	 * For livepatch modules, core_kallsyms.symtab is a complete
+	 * copy of the original symbol table. Adjust sh_addr to point
+	 * to core_kallsyms.symtab since the copy of the symtab in module
+	 * init memory is freed at the end of do_init_module().
+	 */
+	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long) mod->core_kallsyms.symtab;
+
+	return 0;
+
+free_sechdrs:
+	kfree(mod->klp_info->sechdrs);
+free_info:
+	kfree(mod->klp_info);
+	return ret;
+}
+
+void free_module_elf(struct module *mod)
+{
+	kfree(mod->klp_info->sechdrs);
+	kfree(mod->klp_info->secstrings);
+	kfree(mod->klp_info);
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index fee64c4957f3..c91c7e57bca7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2042,81 +2042,6 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 }
 #endif /*  CONFIG_STRICT_MODULE_RWX */
 
-#ifdef CONFIG_LIVEPATCH
-/*
- * Persist Elf information about a module. Copy the Elf header,
- * section header table, section string table, and symtab section
- * index from info to mod->klp_info.
- */
-static int copy_module_elf(struct module *mod, struct load_info *info)
-{
-	unsigned int size, symndx;
-	int ret;
-
-	size = sizeof(*mod->klp_info);
-	mod->klp_info = kmalloc(size, GFP_KERNEL);
-	if (mod->klp_info == NULL)
-		return -ENOMEM;
-
-	/* Elf header */
-	size = sizeof(mod->klp_info->hdr);
-	memcpy(&mod->klp_info->hdr, info->hdr, size);
-
-	/* Elf section header table */
-	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
-	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
-	if (mod->klp_info->sechdrs == NULL) {
-		ret = -ENOMEM;
-		goto free_info;
-	}
-
-	/* Elf section name string table */
-	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
-	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
-	if (mod->klp_info->secstrings == NULL) {
-		ret = -ENOMEM;
-		goto free_sechdrs;
-	}
-
-	/* Elf symbol section index */
-	symndx = info->index.sym;
-	mod->klp_info->symndx = symndx;
-
-	/*
-	 * For livepatch modules, core_kallsyms.symtab is a complete
-	 * copy of the original symbol table. Adjust sh_addr to point
-	 * to core_kallsyms.symtab since the copy of the symtab in module
-	 * init memory is freed at the end of do_init_module().
-	 */
-	mod->klp_info->sechdrs[symndx].sh_addr = \
-		(unsigned long) mod->core_kallsyms.symtab;
-
-	return 0;
-
-free_sechdrs:
-	kfree(mod->klp_info->sechdrs);
-free_info:
-	kfree(mod->klp_info);
-	return ret;
-}
-
-static void free_module_elf(struct module *mod)
-{
-	kfree(mod->klp_info->sechdrs);
-	kfree(mod->klp_info->secstrings);
-	kfree(mod->klp_info);
-}
-#else /* !CONFIG_LIVEPATCH */
-static int copy_module_elf(struct module *mod, struct load_info *info)
-{
-	return 0;
-}
-
-static void free_module_elf(struct module *mod)
-{
-}
-#endif /* CONFIG_LIVEPATCH */
-
 void __weak module_memfree(void *module_region)
 {
 	/*
@@ -3091,30 +3016,23 @@ static int copy_chunked_from_user(void *dst, const void __user *usrc, unsigned l
 	return 0;
 }
 
-#ifdef CONFIG_LIVEPATCH
 static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
 {
-	if (get_modinfo(info, "livepatch")) {
-		mod->klp = true;
+	if (!get_modinfo(info, "livepatch"))
+		/* Nothing more to do */
+		return 0;
+
+	if (set_livepatch_module(mod)) {
 		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
 		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
-			       mod->name);
-	}
-
-	return 0;
-}
-#else /* !CONFIG_LIVEPATCH */
-static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
-{
-	if (get_modinfo(info, "livepatch")) {
-		pr_err("%s: module is marked as livepatch module, but livepatch support is disabled",
-		       mod->name);
-		return -ENOEXEC;
+				mod->name);
+		return 0;
 	}
 
-	return 0;
+	pr_err("%s: module is marked as livepatch module, but livepatch support is disabled",
+		mod->name);
+	return -ENOEXEC;
 }
-#endif /* CONFIG_LIVEPATCH */
 
 static void check_modinfo_retpoline(struct module *mod, struct load_info *info)
 {
-- 
2.34.1

