Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1324A0223
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351294AbiA1UkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40244 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344405AbiA1Ujp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:39:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643402384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u3+US9coizvidEZ8omLRER4gflB6ywCQZcnY38EWjAY=;
        b=BMSJY2Yqel5h7eEsIfU5l73Ztd+U1QF660N6FDGbBJWmeU+qmT6ztU2nwgcZuxTHccjv+Z
        pxyHS+f1MafwmLcr0pYcOJjcjmx0B0lwRSYF2BpcOEdXjBAm2p0RRd+1LVE9g7DASHeNW1
        vvha406374fUQ8ttCtX7vGw7wV6nK7E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-bdoOGxUSOtG-qmJVEbvmPg-1; Fri, 28 Jan 2022 15:39:43 -0500
X-MC-Unique: bdoOGxUSOtG-qmJVEbvmPg-1
Received: by mail-wm1-f71.google.com with SMTP id d140-20020a1c1d92000000b0034edefd55caso6427114wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 12:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3+US9coizvidEZ8omLRER4gflB6ywCQZcnY38EWjAY=;
        b=XjyA/1tSx2MDcn4jbeyKBUcmzEzecHvKhN5PKWR+zcl5ivGmMxovZH9Rt33m3gjGfc
         CYYk3VOuim9feYQW3LmYwMMlTzxqmdDdKRCM7hfgEXjq5CxDfqJUO0zkQFHmrcZ8k6ap
         0Zcb6cPKAoxCJmwfHfv3NkUZdAxbAPd0vazo1CRgqgOZI57xtW6f6oq2hhQZhRTnvbxH
         X7EBxj4a45fugyZhUwbwtgf42fNsJAYZfclWSAUlrLeL745zqd1Dj3oQIv9iS5gM8KQS
         qePhvzV2ZCNPBoTg6LtB49xWOWsJqMVMEdiFEXbGHhVS6HO0o/er3XfmEL17LmY4CWpk
         dmpw==
X-Gm-Message-State: AOAM530EvGqgsrISsb+vOyeXGcz5OglEQGiiOaG+QS7lLJmftH6pM9qd
        b1R+fCqolPFxp21mup1/t0lJUBwWbC9bwhzS4BQC/a59ZUnpsF4QaOn4gJB1liA1df93zhhBw28
        8CCRwYQdT/mBfX7h/n1+GaTw=
X-Received: by 2002:a1c:f404:: with SMTP id z4mr17591248wma.165.1643402382402;
        Fri, 28 Jan 2022 12:39:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZ7M4+0Z0YuutTQvNS99n1rlW4eDZQBH7wns2B4hDMixRhvlHyXE3/qo/1nbvJhWwiuWq9ag==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr17591233wma.165.1643402382224;
        Fri, 28 Jan 2022 12:39:42 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id f5sm5280239wrq.87.2022.01.28.12.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 12:39:41 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v3 05/13] module: Move arch strict rwx support to a separate file
Date:   Fri, 28 Jan 2022 20:39:26 +0000
Message-Id: <20220128203934.600247-6-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128203934.600247-1-atomlin@redhat.com>
References: <20220128203934.600247-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates applicable architecture code
that support strict module rwx from core module code
into kernel/module/arch_strict_rwx.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h          | 17 +++++++++++
 kernel/module/Makefile          |  1 +
 kernel/module/arch_strict_rwx.c | 44 ++++++++++++++++++++++++++++
 kernel/module/main.c            | 51 ---------------------------------
 4 files changed, 62 insertions(+), 51 deletions(-)
 create mode 100644 kernel/module/arch_strict_rwx.c

diff --git a/include/linux/module.h b/include/linux/module.h
index 377bdb9952cf..35552164830d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -339,6 +339,23 @@ struct module_layout {
 #endif
 };
 
+/*
+ * Modules' sections will be aligned on page boundaries
+ * to ensure complete separation of code and data, but
+ * only when CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
+ */
+#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
+# define debug_align(X) ALIGN(X, PAGE_SIZE)
+
+extern void frob_text(const struct module_layout *layout,
+		      int (*set_memory)(unsigned long start, int num_pages));
+extern void module_enable_x(const struct module *mod);
+#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+# define debug_align(X) (X)
+
+static void module_enable_x(const struct module *mod) { }
+#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
+
 #ifdef CONFIG_MODULES_TREE_LOOKUP
 struct mod_tree_root {
 	struct latch_tree_root root;
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 5990d2e4566d..71341f30c3f2 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
+obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
diff --git a/kernel/module/arch_strict_rwx.c b/kernel/module/arch_strict_rwx.c
new file mode 100644
index 000000000000..9801cb4fef36
--- /dev/null
+++ b/kernel/module/arch_strict_rwx.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module arch strict rwx
+ *
+ * Copyright (C) 2015 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/set_memory.h>
+
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
+ * These values are always page-aligned (as is base)
+ */
+
+/*
+ * Since some arches are moving towards PAGE_KERNEL module allocations instead
+ * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() outside of the
+ * CONFIG_STRICT_MODULE_RWX block below because they are needed regardless of
+ * whether we are strict.
+ */
+void frob_text(const struct module_layout *layout,
+		      int (*set_memory)(unsigned long start, int num_pages))
+{
+	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
+	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
+	set_memory((unsigned long)layout->base,
+		   layout->text_size >> PAGE_SHIFT);
+}
+
+void module_enable_x(const struct module *mod)
+{
+	frob_text(&mod->core_layout, set_memory_x);
+	frob_text(&mod->init_layout, set_memory_x);
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5c7c3201b5b4..fbac043b07d7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -13,7 +13,6 @@
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
-#include <linux/buildid.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/sysfs.h>
@@ -63,17 +62,6 @@
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
@@ -1785,45 +1773,6 @@ static void mod_sysfs_teardown(struct module *mod)
 	mod_sysfs_fini(mod);
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
-#ifdef CONFIG_ARCH_HAS_STRICT_MODULE_RWX
-static void frob_text(const struct module_layout *layout,
-		      int (*set_memory)(unsigned long start, int num_pages))
-{
-	BUG_ON((unsigned long)layout->base & (PAGE_SIZE-1));
-	BUG_ON((unsigned long)layout->text_size & (PAGE_SIZE-1));
-	set_memory((unsigned long)layout->base,
-		   layout->text_size >> PAGE_SHIFT);
-}
-
-static void module_enable_x(const struct module *mod)
-{
-	frob_text(&mod->core_layout, set_memory_x);
-	frob_text(&mod->init_layout, set_memory_x);
-}
-#else /* !CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-static void module_enable_x(const struct module *mod) { }
-#endif /* CONFIG_ARCH_HAS_STRICT_MODULE_RWX */
-
 #ifdef CONFIG_STRICT_MODULE_RWX
 static void frob_rodata(const struct module_layout *layout,
 			int (*set_memory)(unsigned long start, int num_pages))
-- 
2.34.1

