Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2FC486DF4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343670AbiAFXnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51276 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245702AbiAFXna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uueBGakT/gT7TUjBGwoofDgqQKuu/ItyPgp72/wDjB0=;
        b=hNiPkbuRatLQQ0UcRq2hqCVGmUOcL2bu9dULvr6jxVXaZ89PV43kUomCLjVubU+NzaBiI0
        XOHm3DjtPyImf36ke+xSfBX+LLmn+Xb24vMhepCjUMUJtWElSGIC4eoJe0MayzkxXz4Uag
        LuTmFWWujz0zCvna7H/jAEm+JZMsxUI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-35-sQarBMLKPeKzUf7T6qwtBw-1; Thu, 06 Jan 2022 18:43:28 -0500
X-MC-Unique: sQarBMLKPeKzUf7T6qwtBw-1
Received: by mail-wr1-f70.google.com with SMTP id w25-20020adf8bd9000000b001a255212b7cso1669163wra.18
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uueBGakT/gT7TUjBGwoofDgqQKuu/ItyPgp72/wDjB0=;
        b=aQQXr470PkHdbyaNCWqLXfmKhFNNL99mjgXj/SF8HKDfrwsshMoWn5uADmcL8NNgJw
         CUMaX5SW0ubLpuO2otpJbXfDOzhqVF9GG+nsnY3NnEnQjYBZSGvPip9qLKrQ8IU5B2Z/
         3TPlD27mClZrFmqV4bHbuJeyWzKziHumfF0KcIKjywh0Jwtzb1nDUjgc9gphvtgdI8cc
         onmLdt1tuXScFVZ/NXOTGYZ73jog+UzwEDXqJ2Z/u4ipvRH2qdL6Ds/PN5d3T/bkd41R
         64h22AZuQU7oD88gvoN5b2UzbS8faZDci/ENYX8y2up1KO8liSBD5Egs2mxXfG+oB/iE
         e6Bg==
X-Gm-Message-State: AOAM532BYvkI+VMfyjHs4igwGskUwkUbEDmRwpC0SfoD4F+W5OLxXDjW
        UixH8bWngMjBmpBK7KdxYXtv4WWrQmUh0w2iwPe31ZYZoSj2BkBPKKFfXgv2ZiUrXtzDGUBRz2Z
        CYoKaJvLEYPbKV9hlets3xUw=
X-Received: by 2002:a05:6000:382:: with SMTP id u2mr53920438wrf.331.1641512607258;
        Thu, 06 Jan 2022 15:43:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUvslYb/hDGjDVoJqLgZk+nt/mxNyTGa3/j+tE0FaOD5uWG01VPKt44cvlshEGt8sWMN/pJQ==
X-Received: by 2002:a05:6000:382:: with SMTP id u2mr53920419wrf.331.1641512607042;
        Thu, 06 Jan 2022 15:43:27 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id o12sm3598673wrc.69.2022.01.06.15.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:26 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 06/13] module: Move strict rwx support to a separate file
Date:   Thu,  6 Jan 2022 23:43:12 +0000
Message-Id: <20220106234319.2067842-7-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates code that makes module text
and rodata memory read-only and non-text memory
non-executable from core module code into
kernel/module/strict_rwx.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h     | 18 ++++++++
 kernel/module/Makefile     |  1 +
 kernel/module/main.c       | 84 --------------------------------------
 kernel/module/strict_rwx.c | 83 +++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+), 84 deletions(-)
 create mode 100644 kernel/module/strict_rwx.c

diff --git a/include/linux/module.h b/include/linux/module.h
index caa7212cf754..218ac6768433 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -354,6 +354,24 @@ extern void module_enable_x(const struct module *mod);
 static void module_enable_x(const struct module *mod) { }
 #endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
 
+#ifdef CONFIG_STRICT_MODULE_RWX
+extern void frob_rodata(const struct module_layout *layout, int (*set_memory)(unsigned long start, int num_pages));
+extern void frob_ro_after_init(const struct module_layout *layout, int (*set_memory)(unsigned long start, int num_pages));
+extern void frob_writable_data(const struct module_layout *layout, int (*set_memory)(unsigned long start, int num_pages));
+extern void module_enable_ro(const struct module *mod, bool after_init);
+extern void module_enable_nx(const struct module *mod);
+extern int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs, char *secstrings, struct module *mod);
+
+#else /* !CONFIG_STRICT_MODULE_RWX */
+static void module_enable_nx(const struct module *mod) { }
+static void module_enable_ro(const struct module *mod, bool after_init) {}
+static int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
+				       char *secstrings, struct module *mod)
+{
+	return 0;
+}
+#endif /* CONFIG_STRICT_MODULE_RWX */
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 struct mod_tree_root {
 	struct latch_tree_root root;
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 95fad95a0549..795fe10ac530 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
+obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
diff --git a/kernel/module/main.c b/kernel/module/main.c
index a0619256b343..c404d00f7958 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1774,90 +1774,6 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
 }
 
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
index 000000000000..8a513ced02c6
--- /dev/null
+++ b/kernel/module/strict_rwx.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/strict_rwx.c - module strict rwx
+ *
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/set_memory.h>
+
+void frob_rodata(const struct module_layout *layout,
+			int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
+	set_memory((unsigned long)layout->base + layout->text_size,
+		   (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
+}
+
+void frob_ro_after_init(const struct module_layout *layout,
+				int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->ro_size & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
+	set_memory((unsigned long)layout->base + layout->ro_size,
+		   (layout->ro_after_init_size - layout->ro_size) >> PAGE_SHIFT);
+}
+
+void frob_writable_data(const struct module_layout *layout,
+			       int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->ro_after_init_size & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->size & (PAGE_SIZE-1));
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
+				       char *secstrings, struct module *mod)
+{
+	const unsigned long shf_wx = SHF_WRITE|SHF_EXECINSTR;
+	int i;
+
+	for (i = 0; i < hdr->e_shnum; i++) {
+		if ((sechdrs[i].sh_flags & shf_wx) == shf_wx) {
+			pr_err("%s: section %s (index %d) has invalid WRITE|EXEC flags\n",
+				mod->name, secstrings + sechdrs[i].sh_name, i);
+			return -ENOEXEC;
+		}
+	}
+
+	return 0;
+}
-- 
2.31.1

