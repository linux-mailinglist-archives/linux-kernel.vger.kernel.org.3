Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D834D448C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbiCJK1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiCJK1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAA68EB9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646907992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NMs3KnPEzp7T5GTU2fcwESnZ9O2vamkfw2Pjzynyr8=;
        b=ieCpBYU7QI6t7+cCT/CEyo+RMmsrTHgCPb+7ETPqoH8OVL6ugFW1AHVIjHLsqPLSemVEhU
        7UlH/Zvl32/ou01/wvR/tn2cZIO0fIO4Rc2YHE53w5VjjZmtqwlqjlxWf0sslKozgcWZKa
        kshRymZmo0CsmRL4kfrpY3oLXxZZIC0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-wXKQWQsGP9u3xsSlYgQqUg-1; Thu, 10 Mar 2022 05:26:30 -0500
X-MC-Unique: wXKQWQsGP9u3xsSlYgQqUg-1
Received: by mail-wm1-f70.google.com with SMTP id r133-20020a1c448b000000b00385c3f3defaso1951416wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5NMs3KnPEzp7T5GTU2fcwESnZ9O2vamkfw2Pjzynyr8=;
        b=m6FKXh30aKhK1KRb6oQt0Zm9t1bg03w8jI7kusVh0RmCWfGHc2yYzGbtqHHH0vwbQU
         AhT/ePUcjhQy8US1b+Kg5TWLWmCQYiHJXg1Jr/FTVhDHt0ikn6TJS8jHx0clZLk63dQp
         gRDrZ7BbE/8jrZFNOl5e3VN8GLeMIerhK9AfF08egVvi/lnJG/HrpVC01bY3Y+RzuPo2
         LPZmM3qntIi0D3CIGUx1dMWatCJaFm4LbO97mERKQ/J1gN7bDfwgpVebtq/ZZDccJd98
         UNz6SJjSe2MeLiVvbTS6N6whCJD0kBpSC5lmvXS4z2T5UFfOU79h56NukdJ/YAVBgda3
         hQSg==
X-Gm-Message-State: AOAM530tlY6Ot4s/o8LuzeHeU8Wt3SEgXTgR2RuK7x/UXYgi/N16ybtj
        PrK0V32dqMln52d1xL3vcnTS3fcwkXnvytkgWEKwPUmsNh70u7HkfcpBoiqvLJFMy1KVmskDuKR
        NAGUmYda1aub6z+nzShtKI18=
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr10989079wmb.157.1646907989592;
        Thu, 10 Mar 2022 02:26:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaeToA92CQDbwh6JfKe+NhTPTu7XxJSxzS89UvvNgP2J/UVk8xZdg4tNggtD0D1buIuJL3vw==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr10989059wmb.157.1646907989362;
        Thu, 10 Mar 2022 02:26:29 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id v124-20020a1cac82000000b0037c3d08e0e7sm7259171wme.29.2022.03.10.02.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:26:28 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, pmladek@suse.com,
        daniel.thompson@linaro.org, hch@infradead.org
Subject: [PATCH v11 13/14] module: Move kdb module related code out of main kdb code
Date:   Thu, 10 Mar 2022 10:26:24 +0000
Message-Id: <20220310102625.3441888-2-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220310102625.3441888-1-atomlin@redhat.com>
References: <20220310102413.3438665-1-atomlin@redhat.com>
 <20220310102625.3441888-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates the kdb 'lsmod' command support out of main
kdb code into its own file under kernel/module. In addition to
the above, a minor style warning i.e. missing a blank line after
declarations, was resolved too. The new file was added to
MAINTAINERS. Finally we remove linux/module.h as it is entirely
redundant.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS                     |  1 +
 include/linux/kdb.h             |  1 +
 kernel/debug/kdb/kdb_io.c       |  1 -
 kernel/debug/kdb/kdb_keyboard.c |  1 -
 kernel/debug/kdb/kdb_main.c     | 49 -----------------------------
 kernel/debug/kdb/kdb_private.h  |  4 ---
 kernel/debug/kdb/kdb_support.c  |  1 -
 kernel/module/Makefile          |  1 +
 kernel/module/kdb.c             | 56 +++++++++++++++++++++++++++++++++
 kernel/module/main.c            |  4 ---
 10 files changed, 59 insertions(+), 60 deletions(-)
 create mode 100644 kernel/module/kdb.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 195cf1ac2ee8..40c717f93c1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10689,6 +10689,7 @@ F:	drivers/tty/serial/kgdboc.c
 F:	include/linux/kdb.h
 F:	include/linux/kgdb.h
 F:	kernel/debug/
+F:	kernel/module/kdb.c
 
 KHADAS MCU MFD DRIVER
 M:	Neil Armstrong <narmstrong@baylibre.com>
diff --git a/include/linux/kdb.h b/include/linux/kdb.h
index ea0f5e580fac..07dfb6a20a1c 100644
--- a/include/linux/kdb.h
+++ b/include/linux/kdb.h
@@ -222,5 +222,6 @@ enum {
 
 extern int kdbgetintenv(const char *, int *);
 extern int kdb_set(int, const char **);
+int kdb_lsmod(int argc, const char **argv);
 
 #endif	/* !_KDB_H */
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 6735ac36b718..67d3c48a1522 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -9,7 +9,6 @@
  * Copyright (c) 2009 Wind River Systems, Inc.  All Rights Reserved.
  */
 
-#include <linux/module.h>
 #include <linux/types.h>
 #include <linux/ctype.h>
 #include <linux/kernel.h>
diff --git a/kernel/debug/kdb/kdb_keyboard.c b/kernel/debug/kdb/kdb_keyboard.c
index f877a0a0d7cf..f87c750d3eb3 100644
--- a/kernel/debug/kdb/kdb_keyboard.c
+++ b/kernel/debug/kdb/kdb_keyboard.c
@@ -11,7 +11,6 @@
 #include <linux/kdb.h>
 #include <linux/keyboard.h>
 #include <linux/ctype.h>
-#include <linux/module.h>
 #include <linux/io.h>
 
 /* Keyboard Controller Registers on normal PCs. */
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 0852a537dad4..f3a30cd5037f 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -26,7 +26,6 @@
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/atomic.h>
-#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mm.h>
 #include <linux/init.h>
@@ -2004,54 +2003,6 @@ static int kdb_ef(int argc, const char **argv)
 	return 0;
 }
 
-#if defined(CONFIG_MODULES)
-/*
- * kdb_lsmod - This function implements the 'lsmod' command.  Lists
- *	currently loaded kernel modules.
- *	Mostly taken from userland lsmod.
- */
-static int kdb_lsmod(int argc, const char **argv)
-{
-	struct module *mod;
-
-	if (argc != 0)
-		return KDB_ARGCOUNT;
-
-	kdb_printf("Module                  Size  modstruct     Used by\n");
-	list_for_each_entry(mod, kdb_modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
-			continue;
-
-		kdb_printf("%-20s%8u  0x%px ", mod->name,
-			   mod->core_layout.size, (void *)mod);
-#ifdef CONFIG_MODULE_UNLOAD
-		kdb_printf("%4d ", module_refcount(mod));
-#endif
-		if (mod->state == MODULE_STATE_GOING)
-			kdb_printf(" (Unloading)");
-		else if (mod->state == MODULE_STATE_COMING)
-			kdb_printf(" (Loading)");
-		else
-			kdb_printf(" (Live)");
-		kdb_printf(" 0x%px", mod->core_layout.base);
-
-#ifdef CONFIG_MODULE_UNLOAD
-		{
-			struct module_use *use;
-			kdb_printf(" [ ");
-			list_for_each_entry(use, &mod->source_list,
-					    source_list)
-				kdb_printf("%s ", use->target->name);
-			kdb_printf("]\n");
-		}
-#endif
-	}
-
-	return 0;
-}
-
-#endif	/* CONFIG_MODULES */
-
 /*
  * kdb_env - This function implements the 'env' command.  Display the
  *	current environment variables.
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index 0d2f9feea0a4..1f8c519a5f81 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -226,10 +226,6 @@ extern void kdb_kbd_cleanup_state(void);
 #define kdb_kbd_cleanup_state()
 #endif /* ! CONFIG_KDB_KEYBOARD */
 
-#ifdef CONFIG_MODULES
-extern struct list_head *kdb_modules;
-#endif /* CONFIG_MODULES */
-
 extern char kdb_prompt_str[];
 
 #define	KDB_WORD_SIZE	((int)sizeof(unsigned long))
diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index df2bface866e..08229ffb6b5e 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -17,7 +17,6 @@
 #include <linux/stddef.h>
 #include <linux/vmalloc.h>
 #include <linux/ptrace.h>
-#include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/hardirq.h>
 #include <linux/delay.h>
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index cf8dcdc6b55f..88f5cdcdb067 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
 obj-$(CONFIG_SYSFS) += sysfs.o
+obj-$(CONFIG_KGDB_KDB) += kdb.o
diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
new file mode 100644
index 000000000000..a446c699db0a
--- /dev/null
+++ b/kernel/module/kdb.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module kdb support
+ *
+ * Copyright (C) 2010 Jason Wessel
+ */
+
+#include <linux/module.h>
+#include <linux/kdb.h>
+#include "internal.h"
+
+/*
+ * kdb_lsmod - This function implements the 'lsmod' command.  Lists
+ *	currently loaded kernel modules.
+ *	Mostly taken from userland lsmod.
+ */
+int kdb_lsmod(int argc, const char **argv)
+{
+	struct module *mod;
+
+	if (argc != 0)
+		return KDB_ARGCOUNT;
+
+	kdb_printf("Module                  Size  modstruct     Used by\n");
+	list_for_each_entry(mod, &modules, list) {
+		if (mod->state == MODULE_STATE_UNFORMED)
+			continue;
+
+		kdb_printf("%-20s%8u  0x%px ", mod->name,
+			   mod->core_layout.size, (void *)mod);
+#ifdef CONFIG_MODULE_UNLOAD
+		kdb_printf("%4d ", module_refcount(mod));
+#endif
+		if (mod->state == MODULE_STATE_GOING)
+			kdb_printf(" (Unloading)");
+		else if (mod->state == MODULE_STATE_COMING)
+			kdb_printf(" (Loading)");
+		else
+			kdb_printf(" (Live)");
+		kdb_printf(" 0x%px", mod->core_layout.base);
+
+#ifdef CONFIG_MODULE_UNLOAD
+		{
+			struct module_use *use;
+
+			kdb_printf(" [ ");
+			list_for_each_entry(use, &mod->source_list,
+					    source_list)
+				kdb_printf("%s ", use->target->name);
+			kdb_printf("]\n");
+		}
+#endif
+	}
+
+	return 0;
+}
diff --git a/kernel/module/main.c b/kernel/module/main.c
index b8a59b5c3e3a..bcc4f7a82649 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -108,10 +108,6 @@ static void mod_update_bounds(struct module *mod)
 		__mod_update_bounds(mod->init_layout.base, mod->init_layout.size);
 }
 
-#ifdef CONFIG_KGDB_KDB
-struct list_head *kdb_modules = &modules; /* kdb needs the list of modules */
-#endif /* CONFIG_KGDB_KDB */
-
 static void module_assert_mutex_or_preempt(void)
 {
 #ifdef CONFIG_LOCKDEP
-- 
2.34.1

