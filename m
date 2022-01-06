Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09832486DED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbiAFXnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55280 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245671AbiAFXn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=STnbsB1XsbVW8bN5zX3BZYgJ9VScJRBeAhjxWEgxw/YDQV8kBamWvnv0LIQre1dDL4JE8v
        O5Bidn2uc8bz5nbiVTS3JWpPg8P4YZ+4fZszsBSehNLYZ0z/TZcOLIMLhGJKGO1mGN3+8k
        ISsrJBRMSPSg/nPMkhNmjZoP0Ipj4X8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-Ubj8kD-tOMqRa3e9SGbgfQ-1; Thu, 06 Jan 2022 18:43:25 -0500
X-MC-Unique: Ubj8kD-tOMqRa3e9SGbgfQ-1
Received: by mail-wr1-f71.google.com with SMTP id k4-20020adfc704000000b001a32d86a772so1704468wrg.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSjRwfWfC6TRwI79+5Cdb0GwAHoA8kDMFqEtGap/jfs=;
        b=pOWsOdZBuSscQd1cANIf1RatVoSI5/892yLpFp5K8OnvwwOv4/xr/Co86CHjBlp0ET
         iLOn0dBKH7vbZGrbXzP5xCxP7MygYyBMfzCa4idI7uj9WhQBtU4bHLgPeRAtiSmLLUgq
         wUegyc91pKlgHWMAYIXmyadquFUawD8w9qCoJyD4z45cf9idoLuXZYkth6I1pNUG2Tlh
         /zfLd5mbKKJXsfRKxFNBSs+sL9oyiENTSoUgeCN41RaNkD9dOYP3ZMMZ4YZFoKryT96p
         ub6zQ1rv2ixVQHpBXKmlNQVm0BOo0WWjL+ayk/xRS761gUbqePwPOtroTQG26u7ENsoK
         H2bw==
X-Gm-Message-State: AOAM530JvKRpVNXEwe6nMGnLO/2HGBeC/D46iDITeoUVVvk4ebgI3uRs
        iPTqpcHfvsnGVahZKDA4W92EmknBEZOpZiBLiS/oTueAbWt9eyjx+q53fL5JhekWnzoaqpspwUY
        PaYUfBGq6DYku72/7mRxY1jA=
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr51258387wrm.370.1641512603886;
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjKEHT9DdOF4blh8PX20pBtvIe2bBsbcaRVH0d0cfv/hvFPF5GSeN6YgK1PmmnqFEMCS9o/Q==
X-Received: by 2002:adf:e4ce:: with SMTP id v14mr51258380wrm.370.1641512603674;
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id h2sm1892114wrr.96.2022.01.06.15.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 03/13] module: Move livepatch support to a separate file
Date:   Thu,  6 Jan 2022 23:43:09 +0000
Message-Id: <20220106234319.2067842-4-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
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

