Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1340480D74
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbhL1Va5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237513AbhL1Vau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOXz+O07LBQHEUssdkx6GwmEYZ1hrM8RRSVfzn//wI8=;
        b=BjSNCPzsDUgD1GbdGe37j4120WGvQFLCIonijboyjA3SD+mgn9/ekJ0tTsrz9oLYCz/CXO
        bv53jUBLH6iM8M5INlouzO5GlssxVl7nAceVGk9xMsLRapXKWiAtgIYCnRAWNkspn/tH0M
        IOX6skgunGliTEcO5CsHoaDsLcMfO7I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-634-OdxUTj8WON6hrda2MzcZwA-1; Tue, 28 Dec 2021 16:30:48 -0500
X-MC-Unique: OdxUTj8WON6hrda2MzcZwA-1
Received: by mail-wm1-f69.google.com with SMTP id n3-20020a05600c3b8300b00345c3fc40b0so9719161wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NOXz+O07LBQHEUssdkx6GwmEYZ1hrM8RRSVfzn//wI8=;
        b=6VRG6Dlj4HRXg1GcCcB7KjP+YEOEFHUndwD2hh7eM1jteisfnvVX9TdJIxdObgings
         1BQGDw6uIFoLMEiDrFLc+F/Hkn8B2+0SG52cMXmdzYQu6uXvjEhWVIcVa0+Yrj8rNtJ1
         5q5Hx3yq6dvGAwYkkg2X+aAgZFLRqElEHxCS/4Pk6xWMSszrXnqJIXD5FUmf7vfS6Tr9
         gfPi5cD8QHBD3OgxSF1uQSZ8FlTShNR5QwwCbGP+sckcGsd9j+nHLMPX5DdzA4YVifkB
         AsyAOkNZZs2wzSltTtSWo7C6oavYZkqEsM3qotrp2zNmM/LHdbicVO04LK+mfyc1Lko1
         mTMQ==
X-Gm-Message-State: AOAM530NfhpJgpHQrLtG2bJ4myDR+2x744e5Vp75/HK/dUBQr3sZ3Mz8
        M31pzLatU+iaunL3KWoF7f5NQI7KCiJPkXbs+q4uZBuOSfQ5icXB0eoZA0Fvj0rSC17sNZKSh48
        5QtIUOP51jbLiwmcn8mNbuBw=
X-Received: by 2002:a05:600c:510f:: with SMTP id o15mr18896718wms.104.1640727047333;
        Tue, 28 Dec 2021 13:30:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjpnlOaqFRUgSq8sfKk6ja8TSc54MC+oQzyCfy9yX6FfHKeKlJyp9VFxHu2VPPClkvot8puA==
X-Received: by 2002:a05:600c:510f:: with SMTP id o15mr18896698wms.104.1640727047134;
        Tue, 28 Dec 2021 13:30:47 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id r62sm19064369wmr.35.2021.12.28.13.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:46 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 05/12] module: Move arch strict rwx support to a separate file
Date:   Tue, 28 Dec 2021 21:30:34 +0000
Message-Id: <20211228213041.1356334-6-atomlin@redhat.com>
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

This patch migrates applicable architecture code
that support strict module rwx from core module code
into kernel/module/arch_strict_rwx.c

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 include/linux/module.h          | 16 +++++++++++
 kernel/module/Makefile          |  1 +
 kernel/module/arch_strict_rwx.c | 44 ++++++++++++++++++++++++++++
 kernel/module/main.c            | 51 ---------------------------------
 4 files changed, 61 insertions(+), 51 deletions(-)
 create mode 100644 kernel/module/arch_strict_rwx.c

diff --git a/include/linux/module.h b/include/linux/module.h
index 8b4d254a84c0..caa7212cf754 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -338,6 +338,22 @@ struct module_layout {
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
+extern void frob_text(const struct module_layout *layout, int (*set_memory)(unsigned long start, int num_pages));
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
index 9d593362156d..95fad95a0549 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MODULE_SIG) += signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += signature.o
 obj-$(CONFIG_LIVEPATCH) += livepatch.o
 obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
+obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
diff --git a/kernel/module/arch_strict_rwx.c b/kernel/module/arch_strict_rwx.c
new file mode 100644
index 000000000000..68e970671ec5
--- /dev/null
+++ b/kernel/module/arch_strict_rwx.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/arch_strict_rwx.c - module arch strict rwx
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
index 692cc520420d..a0619256b343 100644
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
@@ -1786,45 +1774,6 @@ static void mod_sysfs_teardown(struct module *mod)
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
2.31.1

