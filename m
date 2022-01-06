Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16A486DF9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343604AbiAFXnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:43:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24904 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343527AbiAFXne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641512613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VxUWH6ivJOFpbXbRPW5hN0FCZVwBuQeN4pyxAhArSmU=;
        b=HDp6vexdBamDPs9resvfRCnLJt/eIhhPdIkJfvNepGbW39Z2KHFZ3fO/UICL7aN6E5maBg
        bT67J1dFl74Ga+LspD1/accp5PiRYLEBfyXF/iNdLDB5JIjjHZpI7JjMsC/p6+9GZKlhdw
        WRWnccmUijY17TegUPixLfR9WxN8h5s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-212-a3uBZ3IdM6S248_-WJ8XpQ-1; Thu, 06 Jan 2022 18:43:32 -0500
X-MC-Unique: a3uBZ3IdM6S248_-WJ8XpQ-1
Received: by mail-wm1-f70.google.com with SMTP id m15-20020a05600c3b0f00b003465ede5e04so625621wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxUWH6ivJOFpbXbRPW5hN0FCZVwBuQeN4pyxAhArSmU=;
        b=BKNgxdzQUk15xOraTAqHooBvCCarMmvfiXQxDH6TlE9e7IJTDISu845qy6kbSXvEs3
         jG+rKqRILzc6sZXYCi1yt78wK3ktnMu0Sd0d9c3WGTQuSjoGwd8gaIKLyEdxOEuEKOPy
         FC2HBRufQrPN/KKVQY5hPpzH7G1jCVtlBfwSAdAc4LchMDM1XfnhBxAUPAnZ62Ng80Q8
         joZsvUGWEoE739nUxJ8kcoOOQe3qUmhELc+60YGNZ644R3OLmxX1BBSH6JSWz/9Dpnl+
         mSArlnYaZC+a+GTiRFX5Npy2t4xBWRwlhHsTeFL0z+IMVpVSKqSn7PFTq/hUGq5MjM2W
         c2eQ==
X-Gm-Message-State: AOAM533DbywhcWdB6xHN9GICjSZo9/L/jtyzQwygSZHPtipkUiWio/s9
        ng7DBx97pQcUEurJrZ5YpcJ0aD+jQqeJswWWpFpDi6Va37x5CL85C5VUxJ2vWpOtKrpjdtahlGw
        I+SsM5Bk/gQqyvZ4wxYTbOlA=
X-Received: by 2002:adf:82d2:: with SMTP id 76mr52608524wrc.329.1641512611279;
        Thu, 06 Jan 2022 15:43:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwg5hUcAgDKEMXX/mzb5iTx0aU4x5q7qgQ5Ag4SVhvzeLif5IDvrFj80YjkU2maincrxJiQIg==
X-Received: by 2002:adf:82d2:: with SMTP id 76mr52608508wrc.329.1641512611082;
        Thu, 06 Jan 2022 15:43:31 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bg12sm3980983wmb.5.2022.01.06.15.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:43:30 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com, allen.lkml@gmail.com
Subject: [RFC PATCH v2 10/13] module: Move procfs support into a separate file
Date:   Thu,  6 Jan 2022 23:43:16 +0000
Message-Id: <20220106234319.2067842-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220106234319.2067842-1-atomlin@redhat.com>
References: <20220106234319.2067842-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates code that allows one to generate a
list of loaded/or linked modules via /proc when procfs
support is enabled into kernel/module/procfs.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile |   1 +
 kernel/module/main.c   |  98 -------------------------------------
 kernel/module/procfs.c | 108 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 98 deletions(-)
 create mode 100644 kernel/module/procfs.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 23582011ab08..cba3e608b4ca 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_ARCH_HAS_STRICT_MODULE_RWX) += arch_strict_rwx.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_PROC_FS) += procfs.o
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 9813e1672d8c..2da580c7b069 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -21,7 +21,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -3529,103 +3528,6 @@ static char *module_flags(struct module *mod, char *buf)
 	return buf;
 }
 
-#ifdef CONFIG_PROC_FS
-/* Called by the /proc file system to return a list of modules. */
-static void *m_start(struct seq_file *m, loff_t *pos)
-{
-	mutex_lock(&module_mutex);
-	return seq_list_start(&modules, *pos);
-}
-
-static void *m_next(struct seq_file *m, void *p, loff_t *pos)
-{
-	return seq_list_next(p, &modules, pos);
-}
-
-static void m_stop(struct seq_file *m, void *p)
-{
-	mutex_unlock(&module_mutex);
-}
-
-static int m_show(struct seq_file *m, void *p)
-{
-	struct module *mod = list_entry(p, struct module, list);
-	char buf[MODULE_FLAGS_BUF_SIZE];
-	void *value;
-
-	/* We always ignore unformed modules. */
-	if (mod->state == MODULE_STATE_UNFORMED)
-		return 0;
-
-	seq_printf(m, "%s %u",
-		   mod->name, mod->init_layout.size + mod->core_layout.size);
-	print_unload_info(m, mod);
-
-	/* Informative for users. */
-	seq_printf(m, " %s",
-		   mod->state == MODULE_STATE_GOING ? "Unloading" :
-		   mod->state == MODULE_STATE_COMING ? "Loading" :
-		   "Live");
-	/* Used by oprofile and other similar tools. */
-	value = m->private ? NULL : mod->core_layout.base;
-	seq_printf(m, " 0x%px", value);
-
-	/* Taints info */
-	if (mod->taints)
-		seq_printf(m, " %s", module_flags(mod, buf));
-
-	seq_puts(m, "\n");
-	return 0;
-}
-
-/*
- * Format: modulename size refcount deps address
- *
- * Where refcount is a number or -, and deps is a comma-separated list
- * of depends or -.
- */
-static const struct seq_operations modules_op = {
-	.start	= m_start,
-	.next	= m_next,
-	.stop	= m_stop,
-	.show	= m_show
-};
-
-/*
- * This also sets the "private" pointer to non-NULL if the
- * kernel pointers should be hidden (so you can just test
- * "m->private" to see if you should keep the values private).
- *
- * We use the same logic as for /proc/kallsyms.
- */
-static int modules_open(struct inode *inode, struct file *file)
-{
-	int err = seq_open(file, &modules_op);
-
-	if (!err) {
-		struct seq_file *m = file->private_data;
-		m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
-	}
-
-	return err;
-}
-
-static const struct proc_ops modules_proc_ops = {
-	.proc_flags	= PROC_ENTRY_PERMANENT,
-	.proc_open	= modules_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= seq_release,
-};
-
-static int __init proc_modules_init(void)
-{
-	proc_create("modules", 0, NULL, &modules_proc_ops);
-	return 0;
-}
-module_init(proc_modules_init);
-#endif
-
 /* Given an address, look for it in the module exception tables. */
 const struct exception_table_entry *search_module_extables(unsigned long addr)
 {
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
new file mode 100644
index 000000000000..98d898250475
--- /dev/null
+++ b/kernel/module/procfs.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/proc.c - module proc support
+ *
+ * Copyright (C) 2008 Alexey Dobriyan
+ */
+
+#include <linux/module.h>
+#include <linux/kallsyms.h>
+#include <linux/mutex.h>
+#include <linux/seq_file.h>
+#include <linux/proc_fs.h>
+#include "internal.h"
+
+/* Called by the /proc file system to return a list of modules. */
+static void *m_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&module_mutex);
+	return seq_list_start(&modules, *pos);
+}
+
+static void *m_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next(p, &modules, pos);
+}
+
+static void m_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&module_mutex);
+}
+
+static int m_show(struct seq_file *m, void *p)
+{
+	struct module *mod = list_entry(p, struct module, list);
+	char buf[MODULE_FLAGS_BUF_SIZE];
+	void *value;
+
+	/* We always ignore unformed modules. */
+	if (mod->state == MODULE_STATE_UNFORMED)
+		return 0;
+
+	seq_printf(m, "%s %u",
+		   mod->name, mod->init_layout.size + mod->core_layout.size);
+	print_unload_info(m, mod);
+
+	/* Informative for users. */
+	seq_printf(m, " %s",
+		   mod->state == MODULE_STATE_GOING ? "Unloading" :
+		   mod->state == MODULE_STATE_COMING ? "Loading" :
+		   "Live");
+	/* Used by oprofile and other similar tools. */
+	value = m->private ? NULL : mod->core_layout.base;
+	seq_printf(m, " 0x%px", value);
+
+	/* Taints info */
+	if (mod->taints)
+		seq_printf(m, " %s", module_flags(mod, buf));
+
+	seq_puts(m, "\n");
+	return 0;
+}
+
+/*
+ * Format: modulename size refcount deps address
+ *
+ * Where refcount is a number or -, and deps is a comma-separated list
+ * of depends or -.
+ */
+static const struct seq_operations modules_op = {
+	.start	= m_start,
+	.next	= m_next,
+	.stop	= m_stop,
+	.show	= m_show
+};
+
+/*
+ * This also sets the "private" pointer to non-NULL if the
+ * kernel pointers should be hidden (so you can just test
+ * "m->private" to see if you should keep the values private).
+ *
+ * We use the same logic as for /proc/kallsyms.
+ */
+static int modules_open(struct inode *inode, struct file *file)
+{
+	int err = seq_open(file, &modules_op);
+
+	if (!err) {
+		struct seq_file *m = file->private_data;
+		m->private = kallsyms_show_value(file->f_cred) ? NULL : (void *)8ul;
+	}
+
+	return err;
+}
+
+static const struct proc_ops modules_proc_ops = {
+	.proc_flags	= PROC_ENTRY_PERMANENT,
+	.proc_open	= modules_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release,
+};
+
+static int __init proc_modules_init(void)
+{
+	proc_create("modules", 0, NULL, &modules_proc_ops);
+	return 0;
+}
+module_init(proc_modules_init);
-- 
2.31.1

