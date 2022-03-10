Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82A84D4479
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241251AbiCJKZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241205AbiCJKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 301A813D57A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0XjJucHH84WkOaA2Fzv90/VbRq4leBo+7myOeJDewzQ=;
        b=X+5AarYzZsdMcySQcdudePNOzukab37eXVUY11wcvWx71z87HWIoNa73DCRO0nWMd79WXQ
        ZY/bvEaAPwrIQ+5UEBQnWNcWulVitSOMunvGiaIAv8H8EUZ7jxJ1C0kVrPvqSh/MIW7qT9
        7ddU5QAEeywq1j4FAN5ZbC6H29SoYpM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-vOYUsfmxO26XlUk6Bz51-g-1; Thu, 10 Mar 2022 05:24:26 -0500
X-MC-Unique: vOYUsfmxO26XlUk6Bz51-g-1
Received: by mail-wm1-f69.google.com with SMTP id 84-20020a1c0257000000b00389a203e5adso1652712wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:24:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0XjJucHH84WkOaA2Fzv90/VbRq4leBo+7myOeJDewzQ=;
        b=Q0y+6exVRd6keOQZ1BNJ4VqtqcAp913LtUb+Az6DV10OX8g/Qnv6BBQMeFgncbhVRs
         kmLpPsfG1T7VzfCJU9T89kXUF/DNaZq227D5jNgjVNhkDRkflxTvh9eKmplRMfUJnOUz
         WLKvPdYR7iUDQcGYJ40k0pf8m6YhICE7o3BWI/0GeRvwaruI4PWyxY7zCsORV/U2ffBT
         KKnRNaYRan3F9XuOrPHP98JLBkfCLQLwrcL/tqe5PRcVwpdx3gY8K0nS4wKXhxoYdIRP
         o4DZAMPT2ESgGp/VnhllXo+N3HGBLlTnZ60yd/ORErrcy8GBCPg8lVln/TjzN7ME4jEh
         UFyA==
X-Gm-Message-State: AOAM530eSfUSQRTVlV00E28wiYK8xBXmNNKzz79h4K6wqQMjDuXVWY55
        LGMqaFcWL8KgipyFQGC7B7tIHV95jDvRccZ8GPcVGyRNRIi/Bw0nxUpEv0R/L/eg/8MuU0Mfbit
        S47sO6inMrdppryojHFvLN+Q=
X-Received: by 2002:adf:fd0a:0:b0:1f0:25fd:4082 with SMTP id e10-20020adffd0a000000b001f025fd4082mr2913163wrr.501.1646907864738;
        Thu, 10 Mar 2022 02:24:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPR22J9v/ekxOLTN9INTYY5z2VKqugszxmvmhgvsGsDIx0STWDDncpe0zYWqIkyQDdqKf1mg==
X-Received: by 2002:adf:fd0a:0:b0:1f0:25fd:4082 with SMTP id e10-20020adffd0a000000b001f025fd4082mr2913145wrr.501.1646907864509;
        Thu, 10 Mar 2022 02:24:24 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f8-20020adfb608000000b0020229d72a4esm3651641wre.38.2022.03.10.02.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:24:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 04/14] module: Move livepatch support to a separate file
Date:   Thu, 10 Mar 2022 10:24:03 +0000
Message-Id: <20220310102413.3438665-5-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102413.3438665-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates livepatch support (i.e. used during module
add/or load and remove/or deletion) from core module code into
kernel/module/livepatch.c. At the moment it contains code to
persist Elf information about a given livepatch module, only.
The new file was added to MAINTAINERS.

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS               |   1 +
 include/linux/module.h    |   9 ++--
 kernel/module/Makefile    |   1 +
 kernel/module/internal.h  |  22 ++++++++
 kernel/module/livepatch.c |  74 +++++++++++++++++++++++++++
 kernel/module/main.c      | 102 ++++----------------------------------
 6 files changed, 111 insertions(+), 98 deletions(-)
 create mode 100644 kernel/module/livepatch.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 463bdb829db4..195cf1ac2ee8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11149,6 +11149,7 @@ F:	arch/s390/include/asm/livepatch.h
 F:	arch/x86/include/asm/livepatch.h
 F:	include/linux/livepatch.h
 F:	kernel/livepatch/
+F:	kernel/module/livepatch.c
 F:	lib/livepatch/
 F:	samples/livepatch/
 F:	tools/testing/selftests/livepatch/
diff --git a/include/linux/module.h b/include/linux/module.h
index 1e135fd5c076..7ec9715de7dc 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -663,17 +663,14 @@ static inline bool module_requested_async_probing(struct module *module)
 	return module && module->async_probe_requested;
 }
 
-#ifdef CONFIG_LIVEPATCH
 static inline bool is_livepatch_module(struct module *mod)
 {
+#ifdef CONFIG_LIVEPATCH
 	return mod->klp;
-}
-#else /* !CONFIG_LIVEPATCH */
-static inline bool is_livepatch_module(struct module *mod)
-{
+#else
 	return false;
+#endif
 }
-#endif /* CONFIG_LIVEPATCH */
 
 bool is_module_sig_enforced(void);
 void set_module_sig_enforced(void);
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index cdd5c61b8c7f..ed3aacb04f17 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,3 +10,4 @@ KCOV_INSTRUMENT_module.o := n
 obj-y += main.o
 obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
+obj-$(CONFIG_LIVEPATCH) += livepatch.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e0775e66bcf7..ad7a444253ed 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -57,6 +57,28 @@ struct load_info {
 
 int mod_verify_sig(const void *mod, struct load_info *info);
 
+#ifdef CONFIG_LIVEPATCH
+int copy_module_elf(struct module *mod, struct load_info *info);
+void free_module_elf(struct module *mod);
+#else /* !CONFIG_LIVEPATCH */
+static inline int copy_module_elf(struct module *mod, struct load_info *info)
+{
+	return 0;
+}
+
+static inline void free_module_elf(struct module *mod) { }
+#endif /* CONFIG_LIVEPATCH */
+
+static inline bool set_livepatch_module(struct module *mod)
+{
+#ifdef CONFIG_LIVEPATCH
+	mod->klp = true;
+	return true;
+#else
+	return false;
+#endif
+}
+
 #ifdef CONFIG_MODULE_DECOMPRESS
 int module_decompress(struct load_info *info, const void *buf, size_t size);
 void module_decompress_cleanup(struct load_info *info);
diff --git a/kernel/module/livepatch.c b/kernel/module/livepatch.c
new file mode 100644
index 000000000000..486d4ff92719
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
+	if (!mod->klp_info)
+		return -ENOMEM;
+
+	/* Elf header */
+	size = sizeof(mod->klp_info->hdr);
+	memcpy(&mod->klp_info->hdr, info->hdr, size);
+
+	/* Elf section header table */
+	size = sizeof(*info->sechdrs) * info->hdr->e_shnum;
+	mod->klp_info->sechdrs = kmemdup(info->sechdrs, size, GFP_KERNEL);
+	if (!mod->klp_info->sechdrs) {
+		ret = -ENOMEM;
+		goto free_info;
+	}
+
+	/* Elf section name string table */
+	size = info->sechdrs[info->hdr->e_shstrndx].sh_size;
+	mod->klp_info->secstrings = kmemdup(info->secstrings, size, GFP_KERNEL);
+	if (!mod->klp_info->secstrings) {
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
+	mod->klp_info->sechdrs[symndx].sh_addr = (unsigned long)mod->core_kallsyms.symtab;
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
index 5f5e21f972dd..3596ebf3a6c3 100644
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
@@ -3092,30 +3017,23 @@ static int copy_chunked_from_user(void *dst, const void __user *usrc, unsigned l
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
+	       mod->name);
+	return -ENOEXEC;
 }
-#endif /* CONFIG_LIVEPATCH */
 
 static void check_modinfo_retpoline(struct module *mod, struct load_info *info)
 {
-- 
2.34.1

