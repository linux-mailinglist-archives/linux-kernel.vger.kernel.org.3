Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31305122F5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiD0Tmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbiD0Tj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C1E5D;
        Wed, 27 Apr 2022 12:36:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFCE761B8E;
        Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD7BC385C3;
        Wed, 27 Apr 2022 19:36:42 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1njnSr-002Iuq-Q5;
        Wed, 27 Apr 2022 15:36:41 -0400
Message-ID: <20220427193641.651401737@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 27 Apr 2022 15:36:35 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 12/21] bootconfig: Support embedding a bootconfig file in kernel
References: <20220427193623.529296556@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

This allows kernel developer to embed a default bootconfig file in
the kernel instead of embedding it in the initrd. This will be good
for who are using the kernel without initrd, or who needs a default
bootconfigs.
This needs to set two kconfigs: CONFIG_BOOT_CONFIG_EMBED=y and set
the file path to CONFIG_BOOT_CONFIG_EMBED_FILE.

Note that you still need 'bootconfig' command line option to load the
embedded bootconfig. Also if you boot using an initrd with a different
bootconfig, the kernel will use the bootconfig in the initrd, instead
of the default bootconfig.

Link: https://lkml.kernel.org/r/164921227943.1090670.14035119557571329218.stgit@devnote2

Cc: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS                |  1 +
 include/linux/bootconfig.h | 10 ++++++++++
 init/Kconfig               | 21 ++++++++++++++++++++-
 init/main.c                | 22 ++++++++++++----------
 lib/.gitignore             |  1 +
 lib/Makefile               |  8 ++++++++
 lib/bootconfig-data.S      | 10 ++++++++++
 lib/bootconfig.c           | 13 +++++++++++++
 8 files changed, 75 insertions(+), 11 deletions(-)
 create mode 100644 lib/bootconfig-data.S

diff --git a/MAINTAINERS b/MAINTAINERS
index b90535d923a0..abc8e6fee21e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7457,6 +7457,7 @@ S:	Maintained
 F:	Documentation/admin-guide/bootconfig.rst
 F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
+F:	lib/bootconfig-data.S
 F:	lib/bootconfig.c
 F:	tools/bootconfig/*
 F:	tools/bootconfig/scripts/*
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index a4665c7ab07c..1611f9db878e 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init xbc_exit(void);
 
+/* XBC embedded bootconfig data in kernel */
+#ifdef CONFIG_BOOT_CONFIG_EMBED
+const char * __init xbc_get_embedded_bootconfig(size_t *size);
+#else
+static inline const char *xbc_get_embedded_bootconfig(size_t *size)
+{
+	return NULL;
+}
+#endif
+
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..2462d4ae2dc8 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1351,7 +1351,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
-	select BLK_DEV_INITRD
+	select BLK_DEV_INITRD if !BOOT_CONFIG_EMBED
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
@@ -1361,6 +1361,25 @@ config BOOT_CONFIG
 
 	  If unsure, say Y.
 
+config BOOT_CONFIG_EMBED
+	bool "Embed bootconfig file in the kernel"
+	depends on BOOT_CONFIG
+	help
+	  Embed a bootconfig file given by BOOT_CONFIG_EMBED_FILE in the
+	  kernel. Usually, the bootconfig file is loaded with the initrd
+	  image. But if the system doesn't support initrd, this option will
+	  help you by embedding a bootconfig file while building the kernel.
+
+	  If unsure, say N.
+
+config BOOT_CONFIG_EMBED_FILE
+	string "Embedded bootconfig file path"
+	depends on BOOT_CONFIG_EMBED
+	help
+	  Specify a bootconfig file which will be embedded to the kernel.
+	  This bootconfig will be used if there is no initrd or no other
+	  bootconfig in the initrd.
+
 choice
 	prompt "Compiler optimization level"
 	default CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/init/main.c b/init/main.c
index 266d61bc67b0..f7fe7cbb1df8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -266,7 +266,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(u32 *_size)
+static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -313,7 +313,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size)
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(u32 *_size)
+static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	return NULL;
 }
@@ -410,14 +410,16 @@ static int __init warn_bootconfig(char *str)
 static void __init setup_boot_config(void)
 {
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
-	const char *msg;
-	int pos;
-	u32 size;
-	char *data, *err;
-	int ret;
+	const char *msg, *data;
+	int pos, ret;
+	size_t size;
+	char *err;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
+	/* If there is no bootconfig in initrd, try embedded one. */
+	if (!data)
+		data = xbc_get_embedded_bootconfig(&size);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -436,8 +438,8 @@ static void __init setup_boot_config(void)
 	}
 
 	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
+		pr_err("bootconfig size %ld greater than max size %d\n",
+			(long)size, XBC_DATA_MAX);
 		return;
 	}
 
@@ -450,7 +452,7 @@ static void __init setup_boot_config(void)
 				msg, pos);
 	} else {
 		xbc_get_info(&ret, NULL);
-		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
+		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
diff --git a/lib/.gitignore b/lib/.gitignore
index e5e217b8307b..54596b634ecb 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /crc32table.h
 /crc64table.h
+/default.bconf
 /gen_crc32table
 /gen_crc64table
 /oid_registry_data.c
diff --git a/lib/Makefile b/lib/Makefile
index 08053df16c7c..95268d6c75b7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -280,6 +280,14 @@ $(foreach file, $(libfdt_files), \
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
 obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
+obj-$(CONFIG_BOOT_CONFIG_EMBED) += bootconfig-data.o
+
+$(obj)/bootconfig-data.o: $(obj)/default.bconf
+
+targets += default.bconf
+filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
+$(obj)/default.bconf: $(CONFIG_BOOT_CONFIG_EMBED_FILE) FORCE
+	$(call filechk,defbconf)
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
diff --git a/lib/bootconfig-data.S b/lib/bootconfig-data.S
new file mode 100644
index 000000000000..ef85ba1a82f4
--- /dev/null
+++ b/lib/bootconfig-data.S
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed default bootconfig in the kernel.
+ */
+	.section .init.rodata, "aw"
+	.global embedded_bootconfig_data
+embedded_bootconfig_data:
+	.incbin "lib/default.bconf"
+	.global embedded_bootconfig_data_end
+embedded_bootconfig_data_end:
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 74f3201ab8e5..c59d26068a64 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -12,6 +12,19 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
+
+#ifdef CONFIG_BOOT_CONFIG_EMBED
+/* embedded_bootconfig_data is defined in bootconfig-data.S */
+extern __visible const char embedded_bootconfig_data[];
+extern __visible const char embedded_bootconfig_data_end[];
+
+const char * __init xbc_get_embedded_bootconfig(size_t *size)
+{
+	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
+	return (*size) ? embedded_bootconfig_data : NULL;
+}
+#endif
+
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will
-- 
2.35.1
