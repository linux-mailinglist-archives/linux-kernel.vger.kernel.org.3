Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA44A3A80
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 22:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356755AbiA3Vd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 16:33:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51412 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356537AbiA3Vc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 16:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643578346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pUE7TRSTRaoiZ1wlOtXxOCtAqDzvICLX8IMQbGpBGgE=;
        b=g1cyHKPn9i57svEzHnFHpsG5fTA720dDHRXDVTBGgln+/6sneqS8dwzN5o5QizD6zX0jJB
        0+GYSyerH5pIiGdytfFk8u48MImuRVPB61qDAlCIp0ptvP/z7w0QEmnd322R1gslNXdhGJ
        ke5XQ5oG4L/kwBZ4mzjsnl3ZQr2pYzc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-R0zRtMAOPl-dlrOEzzco0Q-1; Sun, 30 Jan 2022 16:32:25 -0500
X-MC-Unique: R0zRtMAOPl-dlrOEzzco0Q-1
Received: by mail-wm1-f69.google.com with SMTP id f188-20020a1c1fc5000000b0034d79edde84so2542327wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 13:32:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pUE7TRSTRaoiZ1wlOtXxOCtAqDzvICLX8IMQbGpBGgE=;
        b=sF8rkALOZl6o0JcZeLONtCoqRUOaLheNsHhR1ujZRzB98TQ2CM6+HoxMacqmCR4Ij5
         P/z/h+8vNTybnFg5oqcpUHFLWWoPExr7jqh7iAN9moTrpmve/2FzQ8Y9rPbiW3iFE1eU
         5sdZzvMp5w+7wuf+A/Piu41Leu5jMy7KxxvOVNTbovdWwTZi652J8mPyhgKhREoM3JOw
         Eg2GfomlU1mCHygYmAS5KVu8yrjnW2uzR2agADo4gjrbIhBksFcrKDq71OyOgSsOtdXS
         XJcn1W+yhyvcgXV2p9B311fZh5Nnn2p+tBmmYDzQAsdK+k/bNMIkuUBpzo5NvEZYyFo3
         zX6Q==
X-Gm-Message-State: AOAM533f+0WLc5H6uL5jTxq5LhZF6K03AA1Ge9WzuULLZ1vgklpyDWU+
        mYXs51nn3e3RP8sF5YXBYSCAv+fYtLGrVSEI1w0Oc5eSXCqua557seyc+znbaWVfnYqR0izB0+3
        TpQyEgjtYffOKTLcBeBa9LpI=
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr16054804wmb.109.1643578343951;
        Sun, 30 Jan 2022 13:32:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwqbRW6GKt1zWz3cu463QUS2dcAe0Zt6f1zElO6WwC0sHHOja9ANvD68R3Z1bShAGRbtS0uXg==
X-Received: by 2002:a05:600c:3d8c:: with SMTP id bi12mr16054788wmb.109.1643578343759;
        Sun, 30 Jan 2022 13:32:23 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id p190sm7246166wmp.16.2022.01.30.13.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 13:32:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, void@manifault.com,
        joe@perches.com
Subject: [RFC PATCH v4 05/13] module: Move arch strict rwx support to a separate file
Date:   Sun, 30 Jan 2022 21:32:06 +0000
Message-Id: <20220130213214.1042497-6-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130213214.1042497-1-atomlin@redhat.com>
References: <20220130213214.1042497-1-atomlin@redhat.com>
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
index faeb7ae49b89..8b75380bc340 100644
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
 /* Only touch one cacheline for common rbtree-for-core-layout case. */
 #define __module_layout_align ____cacheline_aligned
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index fc6d7a053a62..146509978708 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -10,4 +10,5 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 ifdef CONFIG_MODULES
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
+obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 endif
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
index 941be7788626..7e98ea12b146 100644
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
@@ -1794,45 +1782,6 @@ static void mod_sysfs_teardown(struct module *mod)
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

