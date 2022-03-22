Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA164E401A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 15:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbiCVOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 10:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236145AbiCVOFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8C2D31902
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647957846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Izr11YJzmvAe+LaxIWKRd054OpBnoHmXtcTT48M4YnE=;
        b=HmUDmsTWHGregMKKXYe7QPLDUbPi08enuY7xfJWzZvEUH7vv+tfsE+V1ZCdQ/4enfl0lRN
        YF4jIDhcSV73HgESvEZ3C6WH4sPDaopeJBaWWnISkPbTyKA6/xDZkGEqXAGg/h5f1Mj1MB
        5d51S31IbmX4FI7Zg46OwUc81YKvkr8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-EtB26mClN8G31d6LPsw5ag-1; Tue, 22 Mar 2022 10:04:05 -0400
X-MC-Unique: EtB26mClN8G31d6LPsw5ag-1
Received: by mail-wm1-f72.google.com with SMTP id l1-20020a1c2501000000b00389c7b9254cso1072256wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 07:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Izr11YJzmvAe+LaxIWKRd054OpBnoHmXtcTT48M4YnE=;
        b=M5f+Qex6SYFrMgePvVEDFsz3BlxKl1lktiigQlvxENBzfhd3vgTl7HPI0qtjZ2ZrSS
         bp7sOTwO8GHdD0EVHWmfL85RV66H3yfDk97rPyf07fIKNmI6avaeO437gyVCsowMZbDE
         VF8O9tgBjcV4kb76yYsQZTfzTweAHK4P+TBem6GYrtjNZhVWzuCTGiZcHdUW05AzMxH0
         KhkLTmYHFFJ6a/VbVKeGmPKWOTquf589ESFjT2GPyBdiNoXrE3qKQaZ7WKO0LKIl+sgU
         56nCz0wse91RwJQ/w9VGTu/ilE2fg0tYgW3v5P080mgpbC89h6SEJ7X0kOf2E0KdDpv7
         E3hg==
X-Gm-Message-State: AOAM533mdt26TB332BwbUWzWXcxwV/IpKkO4g8FF6jIn6OMxNHFu5t0O
        MT7r/V4bo4cdmmZmyTEmKXDAyqFnbaQmZQxzS5eenej4XK5hC0UdvtbTOF51ma7LfgDn0K76OGM
        HAdCmwkvODRcuY10ZmtJmXA4=
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr22920002wrs.227.1647957844334;
        Tue, 22 Mar 2022 07:04:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwraUVu51A8yjc6rSrKIzWZY7nohdSngiV3q7qZiwJD8eC39yzqqD4LjTZ+LYf2AGkd/SWOVg==
X-Received: by 2002:a5d:6da5:0:b0:1f1:f968:1a62 with SMTP id u5-20020a5d6da5000000b001f1f9681a62mr22919968wrs.227.1647957844115;
        Tue, 22 Mar 2022 07:04:04 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id b15-20020adfc74f000000b001e888b871a0sm15988346wrh.87.2022.03.22.07.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:04:03 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v12 06/14] module: Move strict rwx support to a separate file
Date:   Tue, 22 Mar 2022 14:03:36 +0000
Message-Id: <20220322140344.556474-7-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220322140344.556474-1-atomlin@redhat.com>
References: <20220322140344.556474-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates code that makes module text
and rodata memory read-only and non-text memory
non-executable from core module code into
kernel/module/strict_rwx.c.

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile     |  1 +
 kernel/module/internal.h   | 32 ++++++++++++
 kernel/module/main.c       | 99 +-------------------------------------
 kernel/module/strict_rwx.c | 85 ++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 97 deletions(-)
 create mode 100644 kernel/module/strict_rwx.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 88774e386276..d313c8472cb3 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_MODULE_DECOMPRESS) += decompress.o
 obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
+obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index f1682e3677be..a6895bb5598a 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -20,6 +20,17 @@
 /* Maximum number of characters written by module_flags() */
 #define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
 
+/*
+ * Modules' sections will be aligned on page boundaries
+ * to ensure complete separation of code and data, but
+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
+ */
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+# define debug_align(X) PAGE_ALIGN(X)
+#else
+# define debug_align(X) (X)
+#endif
+
 extern struct mutex module_mutex;
 extern struct list_head modules;
 
@@ -126,3 +137,24 @@ static inline struct module *mod_find(unsigned long addr)
 	return NULL;
 }
 #endif /* CONFIG_MODULES_TREE_LOOKUP */
+
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned long start,
+								     int num_pages));
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
+#ifdef CONFIG_STRICT_MODULE_RWX
+void module_enable_ro(const struct module *mod, bool after_init);
+void module_enable_nx(const struct module *mod);
+int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				char *secstrings, struct module *mod);
+
+#else /* !CONFIG_STRICT_MODULE_RWX */
+static inline void module_enable_nx(const struct module *mod) { }
+static inline void module_enable_ro(const struct module *mod, bool after_init) {}
+static inline int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				       char *secstrings, struct module *mod)
+{
+	return 0;
+}
+#endif /* CONFIG_STRICT_MODULE_RWX */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 76b53880ad91..5cd63f14b1ef 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -63,17 +63,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/module.h>
 
-/*
- * Modules' sections will be aligned on page boundaries
- * to ensure complete separation of code and data, but
- * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
- */
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-# define debug_align(X) ALIGN(X, PAGE_SIZE)
-#else
-# define debug_align(X) (X)
-#endif
-
 /*
  * Mutex protects:
  * 1) List of modules (also safely readable with preempt_disable),
@@ -1819,8 +1808,8 @@ static void mod_sysfs_teardown(struct module *mod)
  * whether we are strict.
  */
 #ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-static void frob_text(const struct module_layout *layout,
-		      int (*set_memory)(unsigned long start, int num_pages))
+void frob_text(const struct module_layout *layout,
+	       int (*set_memory)(unsigned long start, int num_pages))
 {
 	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
 	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
@@ -1837,90 +1826,6 @@ static void module_enable_x(const struct module *mod)
 static void module_enable_x(const struct module *mod) { }
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
-#ifdef CONFIG_STRICT_MODULE_RWX
-static void frob_rodata(const struct module_layout *layout,
-			int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->text_size,
-		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
-}
-
-static void frob_ro_after_init(const struct module_layout *layout,
-				int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->ro_size,
-		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
-}
-
-static void frob_writable_data(const struct module_layout *layout,
-			       int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base + layout->ro_after_init_size,
-		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
-}
-
-static void module_enable_ro(const struct module *mod, bool after_init)
-{
-	if (!rodata_enabled)
-		return;
-
-	set_vm_flush_reset_perms(mod->core_layout.base);
-	set_vm_flush_reset_perms(mod->init_layout.base);
-	frob_text(&mod->core_layout, set_memory_ro);
-
-	frob_rodata(&mod->core_layout, set_memory_ro);
-	frob_text(&mod->init_layout, set_memory_ro);
-	frob_rodata(&mod->init_layout, set_memory_ro);
-
-	if (after_init)
-		frob_ro_after_init(&mod->core_layout, set_memory_ro);
-}
-
-static void module_enable_nx(const struct module *mod)
-{
-	frob_rodata(&mod->core_layout, set_memory_nx);
-	frob_ro_after_init(&mod->core_layout, set_memory_nx);
-	frob_writable_data(&mod->core_layout, set_memory_nx);
-	frob_rodata(&mod->init_layout, set_memory_nx);
-	frob_writable_data(&mod->init_layout, set_memory_nx);
-}
-
-static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-				       char *secstrings, struct module *mod)
-{
-	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
-	int i;
-
-	for (i = 0; i < hdr->e_shnum; i++) {
-		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
-			pr_err("%s: section %s (index %d) has invalid WRITE|EXEC flags\n",
-				mod->name, secstrings + sechdrs[i].sh_name, i);
-			return -ENOEXEC;
-		}
-	}
-
-	return 0;
-}
-
-#else /* !CONFIG_STRICT_MODULE_RWX */
-static void module_enable_nx(const struct module *mod) { }
-static void module_enable_ro(const struct module *mod, bool after_init) {}
-static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
-				       char *secstrings, struct module *mod)
-{
-	return 0;
-}
-#endif /*  CONFIG_STRICT_MODULE_RWX */
-
 void __weak module_memfree(void *module_region)
 {
 	/*
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
new file mode 100644
index 000000000000..7949dfd449c2
--- /dev/null
+++ b/kernel/module/strict_rwx.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module strict rwx
+ *
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+#include <linux/set_memory.h>
+#include "internal.h"
+
+static void frob_rodata(const struct module_layout *layout,
+		 int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON(!PAGE_ALIGNED(layout->base));
+	BUG_ON(!PAGE_ALIGNED(layout->text_size));
+	BUG_ON(!PAGE_ALIGNED(layout->ro_size));
+	set_memory((unsigned long)layout->base + layout->text_size,
+		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
+}
+
+static void frob_ro_after_init(const struct module_layout *layout,
+			int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON(!PAGE_ALIGNED(layout->base));
+	BUG_ON(!PAGE_ALIGNED(layout->ro_size));
+	BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
+	set_memory((unsigned long)layout->base + layout->ro_size,
+		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
+}
+
+static void frob_writable_data(const struct module_layout *layout,
+			int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON(!PAGE_ALIGNED(layout->base));
+	BUG_ON(!PAGE_ALIGNED(layout->ro_after_init_size));
+	BUG_ON(!PAGE_ALIGNED(layout->size));
+	set_memory((unsigned long)layout->base + layout->ro_after_init_size,
+		   (layout->size - layout->ro_after_init_size) >> PAGE_SHIFT);
+}
+
+void module_enable_ro(const struct module *mod, bool after_init)
+{
+	if (!rodata_enabled)
+		return;
+
+	set_vm_flush_reset_perms(mod->core_layout.base);
+	set_vm_flush_reset_perms(mod->init_layout.base);
+	frob_text(&mod->core_layout, set_memory_ro);
+
+	frob_rodata(&mod->core_layout, set_memory_ro);
+	frob_text(&mod->init_layout, set_memory_ro);
+	frob_rodata(&mod->init_layout, set_memory_ro);
+
+	if (after_init)
+		frob_ro_after_init(&mod->core_layout, set_memory_ro);
+}
+
+void module_enable_nx(const struct module *mod)
+{
+	frob_rodata(&mod->core_layout, set_memory_nx);
+	frob_ro_after_init(&mod->core_layout, set_memory_nx);
+	frob_writable_data(&mod->core_layout, set_memory_nx);
+	frob_rodata(&mod->init_layout, set_memory_nx);
+	frob_writable_data(&mod->init_layout, set_memory_nx);
+}
+
+int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				char *secstrings, struct module *mod)
+{
+	const unsigned long shf_wx = SHF_WRITE | SHF_EXECINSTR;
+	int i;
+
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
+			pr_err("%s: section %s (index %d) has invalid WRITE|EXEC flags\n",
+			       mod->name, secstrings + sechdrs[i].sh_name, i);
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
-- 
2.34.1

