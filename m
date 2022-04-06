Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A664F5AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351670AbiDFJlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585823AbiDFJgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674A19D61B;
        Tue,  5 Apr 2022 19:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20AEB616B8;
        Wed,  6 Apr 2022 02:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321F8C385A0;
        Wed,  6 Apr 2022 02:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649212284;
        bh=aw2bq5SC6SuV7FHJKRzv7VxT/0OLDHfP3nbZybj0tO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhCwMTsQmGqmfrifRKhNYRshX9Xl9dg1YeS5en9OMMAb2Jvrns3OwcFsiRAk0ZCnd
         rI2Bg8FjLLLuBPzw9N72CUjdrH6EoTPNI7QW/FhqY4RF5e3FxcgaZT/2eRAK5pSjx4
         Pp2l2FRn8bATi7BHqSjPCDXWCyIx+PdUDux/4dqcB1QnWlndoTVHb9WvwsRg57d/di
         JczJt0ogZ3iw3ZsLJYKLx3zH6dMSoFp4ggG2cg67QshCe4NQcbEYnQfvWENpLYOWSR
         dWsfEf5l6TJqokFrQ/yspb+QoqXysk+1geOPyW/O+erY/UXNXD3p89nq5iPqcObaZL
         yOfmu+Sc25IHA==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: [PATCH v8 3/4] bootconfig: Support embedding a bootconfig file in kernel
Date:   Wed,  6 Apr 2022 11:31:19 +0900
Message-Id: <164921227943.1090670.14035119557571329218.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164921224829.1090670.9700650651725930602.stgit@devnote2>
References: <164921224829.1090670.9700650651725930602.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v8:
  - Fix a build error in CONFIG_BLK_DEV_INITRD=n case.
 Changes in v7:
  - Change kconfig option name to share the common prefix so that
    we can search it easier.
  - Make embedded_bootconfig_data readonly.
  - Select CONFIG_BLK_DEV_INITRD only if CONFIG_BOOT_CONFIG_EMBED=n
  - Remove redundant default settings for new Kconfig options.
 Changes in v6:
  - Split out the .incbin asm part as bootconfig-data.S according to
    Masahiro's comment.
 Changes in v5:
  - Fix .gitignore to be sorted alphabetically.
  - Make default.bconf is cleaned up correctly.
  - Allow user to specify relative path to CONFIG_EMBED_BOOT_CONFIG_FILE.
    (Thanks Masahiro!)
 Changes in v4:
  - Avoid updating the default.bconf if the file is not changed.
---
 MAINTAINERS                |    1 +
 include/linux/bootconfig.h |   10 ++++++++++
 init/Kconfig               |   21 ++++++++++++++++++++-
 init/main.c                |   22 ++++++++++++----------
 lib/.gitignore             |    1 +
 lib/Makefile               |    8 ++++++++
 lib/bootconfig-data.S      |   10 ++++++++++
 lib/bootconfig.c           |   13 +++++++++++++
 8 files changed, 75 insertions(+), 11 deletions(-)
 create mode 100644 lib/bootconfig-data.S

diff --git a/MAINTAINERS b/MAINTAINERS
index c10fbd13080a..88c9d62acd90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7318,6 +7318,7 @@ S:	Maintained
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
index beb5b866c318..e7c75fb7d244 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1347,7 +1347,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
-	select BLK_DEV_INITRD
+	select BLK_DEV_INITRD if !BOOT_CONFIG_EMBED
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
@@ -1357,6 +1357,25 @@ config BOOT_CONFIG
 
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
index 4f3ba3b84e34..d00c6f77d0e0 100644
--- a/init/main.c
+++ b/init/main.c
@@ -265,7 +265,7 @@ static int __init loglevel(char *str)
 early_param("loglevel", loglevel);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-static void * __init get_boot_config_from_initrd(u32 *_size)
+static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	u32 size, csum;
 	char *data;
@@ -312,7 +312,7 @@ static void * __init get_boot_config_from_initrd(u32 *_size)
 	return data;
 }
 #else
-static void * __init get_boot_config_from_initrd(u32 *_size)
+static void * __init get_boot_config_from_initrd(size_t *_size)
 {
 	return NULL;
 }
@@ -409,14 +409,16 @@ static int __init warn_bootconfig(char *str)
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
@@ -435,8 +437,8 @@ static void __init setup_boot_config(void)
 	}
 
 	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
+		pr_err("bootconfig size %ld greater than max size %d\n",
+			(long)size, XBC_DATA_MAX);
 		return;
 	}
 
@@ -449,7 +451,7 @@ static void __init setup_boot_config(void)
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
index 4fc48543dc8f..62a103aaabd4 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -277,6 +277,14 @@ $(foreach file, $(libfdt_files), \
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

