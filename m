Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED03480D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbhL1Vaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30902 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237500AbhL1Vas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=Vgp5z6NkIZkFybj1xXbQN4JCYw9TcE+ox4SVfSLv1/SfJXN82zF5UJcNTiQ44QGPtW2iWT
        NLDLXhQPXwBqI0RH5MOMzxLOodrWl19UXWSvj+GJLqk3jTzZSAhMlH5kKulATZQUGpVumB
        fzHjUKz0wNPKNDx7mgIm8xdMAlaws/c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-R5VRlgDxPSGM-yYLz-UWFw-1; Tue, 28 Dec 2021 16:30:46 -0500
X-MC-Unique: R5VRlgDxPSGM-yYLz-UWFw-1
Received: by mail-wr1-f71.google.com with SMTP id q21-20020adfab15000000b001a24b36e47eso4282455wrc.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=NutyuUbyw5vxM8Ywi7n9W1miD543qcXZVqn086jU4AKK3oZzMKh0GOvi7DD2RfZmKh
         7uhMKucpEipwm8Yp9LAts1sP0154XFXC7dXqO7kKhImjkFt59kqKNUpakodRG9MGufZ1
         SbcKqPZVtVl0gEOta/UWb7I7r9o/NPhL/TFynZOuv6x13LRTuKD+QH38m1aihI3EiZXg
         sZYNoUZ4zj5URJjhgpCmLzKUVOP1Oj3aXr/BTs6kvxfF6A5oFPqvImLfXok0B9QrsAIc
         0zu4HfxMbn09lXUoH3pzR49nS6g3wFsU+BXsR1FAmIdQaMzbf7hyZ32k7N67Bu3Xkyro
         +Usg==
X-Gm-Message-State: AOAM530Iw+/5FxXgvMb6PBE0VEh9SM+0TtkZyQchmH2E+WAmJBsNja7R
        0KCg/O6zLOkZj5SZOs/ZjJNcGvuRcSqC1fbMXKxhpX20jtJzsDdUFmy9CheiPiJhDkb/h8zgxLF
        m7FItbu86GZF0j0LO7q9hmVc=
X-Received: by 2002:a05:600c:3c84:: with SMTP id bg4mr13093256wmb.190.1640727045272;
        Tue, 28 Dec 2021 13:30:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjpOoXQT6HgiXt9+XxGLg/eP4hezShDWUozZdG8eMn130cQxvJgnJNXdDb51ljSQZAbDPE0g==
X-Received: by 2002:a05:600c:3c84:: with SMTP id bg4mr13093248wmb.190.1640727045094;
        Tue, 28 Dec 2021 13:30:45 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 1sm21331501wry.33.2021.12.28.13.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:44 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 03/12] module: Move livepatch support to a separate file
Date:   Tue, 28 Dec 2021 21:30:32 +0000
Message-Id: <20211228213041.1356334-4-atomlin@redhat.com>
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

This patch migrates livepatch support (i.e. used during module
add/or load and remove/or deletion) from core module code into
kernel/module/livepatch.c. At the moment it contains code to
persist Elf information about a given livepatch module, only.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile    |  1 +
 kernel/module/internal.h  | 12 ++++++
 kernel/module/livepatch.c | 75 +++++++++++++++++++++++++++++++++
 kernel/module/main.c      | 89 +--------------------------------------
 4 files changed, 89 insertions(+), 88 deletions(-)
 create mode 100644 kernel/module/livepatch.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index a9cf6e822075..47d70bb18da3 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -6,3 +6,4 @@
 obj-$(CONFIG_MODULES) += main.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
+obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ffc50df010a7..91ef152aeffb 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -51,3 +51,15 @@ struct load_info {
 };
 
 extern int mod_verify_sig(const void *mod, struct load_info *info);
+
+#ifdef CONFIG_LIVEPATCH
+extern int copy_module_elf(struct module *mod, struct load_info *info);
+extern void free_module_elf(struct module *mod);
+extern int check_modinfo_livepatch(struct module *mod, struct load_info *info);
+#else /* !CONFIG_LIVEPATCH */
+static inline int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	return 0;
+}
+static inline void free_module_elf(struct module *mod) { }
+#endif /* CONFIG_LIVEPATCH */
diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
new file mode 100644
index 000000000000..e147f5418327
--- /dev/null
+++ b/kernel/module/livepatch.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/livepatch.c - module livepatch support
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
+	mod->klp_info->sechdrs[symndx].sh_addr = \
+		(unsigned long) mod->core_kallsyms.symtab;
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
index 2a6b859716c0..9bcaf251e109 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2043,81 +2043,6 @@ static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
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
@@ -3052,19 +2977,7 @@ static int copy_chunked_from_user(void *dst, const void __user *usrc, unsigned l
 	return 0;
 }
 
-#ifdef CONFIG_LIVEPATCH
-static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
-{
-	if (get_modinfo(info, "livepatch")) {
-		mod->klp = true;
-		add_taint_module(mod, TAINT_LIVEPATCH, LOCKDEP_STILL_OK);
-		pr_notice_once("%s: tainting kernel with TAINT_LIVEPATCH\n",
-			       mod->name);
-	}
-
-	return 0;
-}
-#else /* !CONFIG_LIVEPATCH */
+#ifndef CONFIG_LIVEPATCH
 static int check_modinfo_livepatch(struct module *mod, struct load_info *info)
 {
 	if (get_modinfo(info, "livepatch")) {
-- 
2.31.1

