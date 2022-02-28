Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A26B4C7E9B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiB1Xoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiB1XoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D032CED95E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646091816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GmqrrVb04cwnz59F2sAjqiqA9LLdTqTYnWCvyZ62aUM=;
        b=hbvzWP8b3foWXOZSV8q0LiWAQPxNNUV+mz/Zif1rwZQgz/YgHLFCJtjml2Nip0Awxt5jLT
        LL4AdZwRjw/Pv1rkpW6NgHPJH54JL1OGZjp4HN5efEDAzn92LBa7iPStAJ1afMjpThKmuo
        whFuJUGcK/drSC8+eFizKLu6qREs0us=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-ZT4d25NQNGWnrtp9NonkZQ-1; Mon, 28 Feb 2022 18:43:34 -0500
X-MC-Unique: ZT4d25NQNGWnrtp9NonkZQ-1
Received: by mail-wr1-f70.google.com with SMTP id f11-20020a5d664b000000b001ef8a2c2e1fso1385449wrw.15
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GmqrrVb04cwnz59F2sAjqiqA9LLdTqTYnWCvyZ62aUM=;
        b=PRZ/ZYr8LNp937JH8z7D0Rm6BpdtKJyZB0PG8uUXZk4TfEGVbWbYONHYNlFBkL0HH0
         rdccwuWRl2/0jePUg56Lwfp3K8i5BMA0CUNCNZVYexURlCl1mVr/Ciftj9EJOL7j9iGK
         AUN4J3DGOzrmWnmV6tPtde9z6pmumYMMu/wXXim3B2V82gE9aDYRMX4UfjTBYKKv7GIN
         zaztgJ3p/GiTc3MMpf+enhZTwkAbr3riof2Pun/z172gRxp0S9syFXcio49BihUiKNVx
         1dBCTSiUCZzYpfbTTHbQMc3IPDc5lNf2454mhKAqRZ5XPSlYu37zJwIIUQspDy3UncEJ
         447g==
X-Gm-Message-State: AOAM532CkipEsMsB8dWSciHjQxSF2LYtBbcKVq7aa/wLkMSub2UJWhdO
        40UOmE28DxYjcG82KjlXUiUmAo44nzOCkX4AX5dD1gTIwDonk14vu4q+B7+UbeKRcnA+Hc6Kbrw
        hNY9SbFKX0b2b0E8qsyuFEF4=
X-Received: by 2002:a5d:52c7:0:b0:1ed:a12e:bbed with SMTP id r7-20020a5d52c7000000b001eda12ebbedmr17287843wrv.97.1646091813287;
        Mon, 28 Feb 2022 15:43:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNu2z6UBMw6eWX7sD9L7UzBV3lAx+BysQbGmBg26ZYAMyF8FswCdA1J/e2ZKm9LdJAaKqDWw==
X-Received: by 2002:a5d:52c7:0:b0:1ed:a12e:bbed with SMTP id r7-20020a5d52c7000000b001eda12ebbedmr17287820wrv.97.1646091813001;
        Mon, 28 Feb 2022 15:43:33 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id k19-20020a05600c479300b00380e461a4d2sm1027023wmo.0.2022.02.28.15.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:43:32 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu, pmladek@suse.com
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org
Subject: [PATCH v9 04/14] module: Move livepatch support to a separate file
Date:   Mon, 28 Feb 2022 23:43:12 +0000
Message-Id: <20220228234322.2073104-5-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228234322.2073104-1-atomlin@redhat.com>
References: <20220228234322.2073104-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h    |   9 ++--
 kernel/module/Makefile    |   1 +
 kernel/module/internal.h  |  22 ++++++++
 kernel/module/livepatch.c |  74 +++++++++++++++++++++++++++
 kernel/module/main.c      | 102 ++++----------------------------------
 5 files changed, 110 insertions(+), 98 deletions(-)
 create mode 100644 kernel/module/livepatch.c

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

