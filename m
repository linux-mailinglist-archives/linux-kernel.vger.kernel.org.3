Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8F4D05A6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244527AbiCGRs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244524AbiCGRsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:48:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B20E1D33F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 09:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646675265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XzDd/KuuRgH8He0fXa6WBPwvyUAPEEoXAXfWyEFzqbI=;
        b=Qnuj53J1cpNOG1B/VnTjxhW23FM9JapkhvwLvm6thvZ7oPhVhTszj5GQXA0WQfDC4nXkMg
        veJLVXdcZIkn/tGP6nYlAk9rVCKxr9ftWtfer/ojcVmtpboqdRUKO1bBMGBAgty9hZ07jr
        b24MJ5J27AxjD1/e67jOdRgZzJsvuaQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-D36QSkokNRqMyFuUQYCe6w-1; Mon, 07 Mar 2022 12:47:44 -0500
X-MC-Unique: D36QSkokNRqMyFuUQYCe6w-1
Received: by mail-wr1-f71.google.com with SMTP id f9-20020a5d58e9000000b001f0247e5e96so4823179wrd.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 09:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzDd/KuuRgH8He0fXa6WBPwvyUAPEEoXAXfWyEFzqbI=;
        b=Eg4IkgOBppgnzxsc2e27FZrMnBTzRskILL4MOGuAnz0XL1M20WK2p42ZApTY02+CpJ
         a+RsB4IAcVpmoDq81FNWrnX6jxgwknl1cBPQC9dD4w8HXowZave7uTYO/jkyVeawkxp2
         dHOREQY+ahpM3FYg0v3czPjGX5RvKtqGagYff3zVKexctVZS8rqRF4g+sK07valSfq+2
         N6PWz9nBPag7fOZUeNSId/+fiAnt2xWNmn16G2LV6Tb41Ix0oqYlI6fbnVvbMocjT6b5
         3xMIfiSGPIc1IayJb2PR7tO0FoqXYURpRhSI95G5GWIQFv1WY74elIWgkneH2GpvX0d8
         rnFQ==
X-Gm-Message-State: AOAM530VeputRRfjG4g8VhpKX3TuFVH+ImMb3NVolPOAVVGlwYApCPsR
        B5b1ceO+wya9st1Qfy3MtBF0LxV1nNjeTE+Wrg3KIP1kazgxTUeU5EuE6+TCNvDj22KareAzNir
        SmaK5GNjo+7AMqrgpGEOlyfo=
X-Received: by 2002:a5d:68d2:0:b0:1f0:653f:108d with SMTP id p18-20020a5d68d2000000b001f0653f108dmr8978766wrw.283.1646675263229;
        Mon, 07 Mar 2022 09:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxVk4tcMQi5mW47Ahdmqg2rUqP8i7z7pOFRgPMY0DeuLvwNEa+sw6CpAJbavkC1217W0I2MNQ==
X-Received: by 2002:a5d:68d2:0:b0:1f0:653f:108d with SMTP id p18-20020a5d68d2000000b001f0653f108dmr8978741wrw.283.1646675263015;
        Mon, 07 Mar 2022 09:47:43 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n9-20020a1c7209000000b00389a616615csm359383wmc.2.2022.03.07.09.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 09:47:42 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org, christophe.leroy@csgroup.eu
Cc:     cl@linux.com, mbenes@suse.cz, akpm@linux-foundation.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, void@manifault.com,
        atomlin@atomlin.com, allen.lkml@gmail.com, joe@perches.com,
        msuchanek@suse.de, oleksandr@natalenko.name,
        jason.wessel@windriver.com, daniel.thompson@linaro.org,
        hch@infradead.org, pmladek@suse.com
Subject: [PATCH v10 13/14] module: Move kdb module related code out of main kdb code
Date:   Mon,  7 Mar 2022 17:47:41 +0000
Message-Id: <20220307174741.2889588-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220307174509.2887714-1-atomlin@redhat.com>
References: <20220307174509.2887714-1-atomlin@redhat.com>
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

This patch migrates the kdb 'lsmod' command support out of main
kdb code into its own file under kernel/module. In addition to
the above, a minor style warning i.e. missing a blank line after
declarations, was resolved too. The new file was added to
MAINTAINERS.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 MAINTAINERS                 |  1 +
 include/linux/kdb.h         |  1 +
 kernel/debug/kdb/kdb_main.c | 49 ---------------------------------
 kernel/module/Makefile      |  1 +
 kernel/module/kdb.c         | 55 +++++++++++++++++++++++++++++++++++++
 kernel/module/main.c        |  4 ---
 6 files changed, 58 insertions(+), 53 deletions(-)
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
index 000000000000..60baeebea3e0
--- /dev/null
+++ b/kernel/module/kdb.c
@@ -0,0 +1,55 @@
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

