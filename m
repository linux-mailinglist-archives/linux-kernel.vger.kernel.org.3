Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 970844BF8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiBVNKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 08:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiBVNKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 08:10:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9140C154D09
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645535373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=akE8OiHzJZIISM63S6KtNcmr+sYPpgo/QTrlGAyqYEE=;
        b=LtGvKKg6JROb1eUM0FINC8qQRlQgnNoBxZqCH7CmONVxX3HUhwa6Zb3r648DC3GdRuOBnU
        5Afic7vkYUaqX6j21VNBXqOEGSZ57vrcXllovoXo6/yKMbQaH8JyxsH0piepQzv63CRgZw
        PNxp+7Wgn/fzbobzMMX+CAVI83NtCJo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-08M32B43PgKW9-bj8LU3Yg-1; Tue, 22 Feb 2022 08:09:32 -0500
X-MC-Unique: 08M32B43PgKW9-bj8LU3Yg-1
Received: by mail-wr1-f69.google.com with SMTP id v17-20020adfc5d1000000b001e6405c2b56so8986953wrg.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 05:09:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=akE8OiHzJZIISM63S6KtNcmr+sYPpgo/QTrlGAyqYEE=;
        b=ZY0mXDALhYvRB34PpG7nrFWdBRjSdKMZwNNBAXn9555r6WX59NK8vp+Inq3NVyVgHk
         GmChgyZAtsq21MV4zFSaSStKARK2/v74/Az/vLBAee7fYdRwWvGl9J6cdmIUi8UKqxQ1
         Fawg0zPXGEDOe4CebR7ifFAPJ/cvi7blRAE357l1STIv7Derqoc+En15WIwXAzDy9Eh8
         hwNiiatFIJWiM+7lxxiTwx4nnCCcm3AzclqkV4frh8KAFMqMYgkC4lDNzysZiD+a+7Y6
         1nwTNzbxMpedcKEc1l4kUq2Y74VpXfXbhi4F9I7HbDPVji6JIEnmzk0iBnNwmjKwidcm
         TaWw==
X-Gm-Message-State: AOAM531zrb5VR+GciYciVMdJe8+WoNGlTzkWhjgMVuLkS7BQLU7GDcFH
        685OqVKpGHPSPEiaziDMXQpIY3XzGsRuF54XqHXq6XwC72NsqVtWwT4/lrm9BaIS9wB7B0scm7A
        f9+Q/UzRDePEW3TI8baRJuXU=
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr3252895wmq.130.1645535364540;
        Tue, 22 Feb 2022 05:09:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPPs2zt5WDuz81GDDadZZyI2wN0+uxEF07BgKxylxinQprKwNDUWx92hw5lj4IXjbTXsJLjw==
X-Received: by 2002:a05:600c:4f4f:b0:37b:d847:ef15 with SMTP id m15-20020a05600c4f4f00b0037bd847ef15mr3252869wmq.130.1645535364253;
        Tue, 22 Feb 2022 05:09:24 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id d2sm25036836wro.49.2022.02.22.05.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 05:09:23 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        void@manifault.com, atomlin@atomlin.com, allen.lkml@gmail.com,
        joe@perches.com, msuchanek@suse.de, oleksandr@natalenko.name
Subject: [PATCH v7 10/13] module: Move procfs support into a separate file
Date:   Tue, 22 Feb 2022 13:09:08 +0000
Message-Id: <20220222130911.1348513-11-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222130911.1348513-1-atomlin@redhat.com>
References: <20220222130911.1348513-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates code that allows one to generate a
list of loaded/or linked modules via /proc when procfs
support is enabled into kernel/module/procfs.c.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |   1 +
 kernel/module/main.c     | 131 +-----------------------------------
 kernel/module/procfs.c   | 142 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 145 insertions(+), 130 deletions(-)
 create mode 100644 kernel/module/procfs.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 4d11753f9e4e..5a32a7e7f73f 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -16,4 +16,5 @@ obj-$(CONFIG_MODULES_TREE_LOOKUP) += tree_lookup.o
 obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
+obj-$(CONFIG_PROC_FS) += procfs.o
 endif
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 44ca05b9eb8f..6af40c2d145f 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -72,6 +72,7 @@ struct module *find_module_all(const char *name, size_t len, bool even_unformed)
 int cmp_name(const void *name, const void *sym);
 long module_get_offset(struct module *mod, unsigned int *size, Elf_Shdr *sechdr,
 		       unsigned int section);
+char *module_flags(struct module *mod, char *buf);
 
 static inline unsigned long kernel_symbol_value(const struct kernel_symbol *sym)
 {
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 952079987ea4..44b6fd1acc44 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/elf.h>
-#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/syscalls.h>
 #include <linux/fcntl.h>
@@ -805,31 +804,6 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	return ret;
 }
 
-static inline void print_unload_info(struct seq_file *m, struct module *mod)
-{
-	struct module_use *use;
-	int printed_something = 0;
-
-	seq_printf(m, " %i ", module_refcount(mod));
-
-	/*
-	 * Always include a trailing , so userspace can differentiate
-	 * between this and the old multi-field proc format.
-	 */
-	list_for_each_entry(use, &mod->source_list, source_list) {
-		printed_something = 1;
-		seq_printf(m, "%s,", use->source->name);
-	}
-
-	if (mod->init != NULL && mod->exit == NULL) {
-		printed_something = 1;
-		seq_puts(m, "[permanent],");
-	}
-
-	if (!printed_something)
-		seq_puts(m, "-");
-}
-
 void __symbol_put(const char *symbol)
 {
 	struct find_symbol_arg fsa = {
@@ -919,12 +893,6 @@ void module_put(struct module *module)
 EXPORT_SYMBOL(module_put);
 
 #else /* !CONFIG_MODULE_UNLOAD */
-static inline void print_unload_info(struct seq_file *m, struct module *mod)
-{
-	/* We don't know the usage count, or what modules are using. */
-	seq_puts(m, " - -");
-}
-
 static inline void module_unload_free(struct module *mod)
 {
 }
@@ -3596,7 +3564,7 @@ static void cfi_cleanup(struct module *mod)
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-static char *module_flags(struct module *mod, char *buf)
+char *module_flags(struct module *mod, char *buf)
 {
 	int bx = 0;
 
@@ -3619,103 +3587,6 @@ static char *module_flags(struct module *mod, char *buf)
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
index 000000000000..2717e130788e
--- /dev/null
+++ b/kernel/module/procfs.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module proc support
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
+#ifdef CONFIG_MODULE_UNLOAD
+static inline void print_unload_info(struct seq_file *m, struct module *mod)
+{
+	struct module_use *use;
+	int printed_something = 0;
+
+	seq_printf(m, " %i ", module_refcount(mod));
+
+	/*
+	 * Always include a trailing , so userspace can differentiate
+	 * between this and the old multi-field proc format.
+	 */
+	list_for_each_entry(use, &mod->source_list, source_list) {
+		printed_something = 1;
+		seq_printf(m, "%s,", use->source->name);
+	}
+
+	if (mod->init && !mod->exit) {
+		printed_something = 1;
+		seq_puts(m, "[permanent],");
+	}
+
+	if (!printed_something)
+		seq_puts(m, "-");
+}
+#else /* !CONFIG_MODULE_UNLOAD */
+static inline void print_unload_info(struct seq_file *m, struct module *mod)
+{
+	/* We don't know the usage count, or what modules are using. */
+	seq_puts(m, " - -");
+}
+#endif /* CONFIG_MODULE_UNLOAD */
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
+
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
2.34.1

