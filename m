Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CE4ED3A2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiCaF6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiCaF6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAA51A6E7E;
        Wed, 30 Mar 2022 22:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB11F61657;
        Thu, 31 Mar 2022 05:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189D2C340ED;
        Thu, 31 Mar 2022 05:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706197;
        bh=q1Nu4wP8agaIV4ryvjWhlVCu16gTxN73HKxVpdINGzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JlDfedkWRnAn5thRN7IdHPnTZPGdbJJT2ttqmdzkx8os/SiI/TB6j6ynp208kMDfO
         Ozbhrs7GHp1xbgtl4aedMSwdwD9oX76rcCDDctJ5Kf3IRGuLf4CxbdIHNne2/v5wIx
         QNBX21pZpsbuqiiMZly0fZiQ47dN1JaQwtqQmkC+JfJOkOCSPrx7XnTptXLsX2K4iP
         jeYNCR6/u2pHaBIbMptI5k7ItkqQlDVXEvlpEhsbNPaRN++IkRc++Nnr5MmEQTa/wA
         NWdHZJAJIxoWi7mraiES/q/aGANcqw1MXA2gKZQAGf9124OcwDPcNefh/GlOkIs5bT
         lFvIH4xjgFksg==
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
Subject: [PATCH v6 3/4] bootconfig: Support embedding a bootconfig file in kernel
Date:   Thu, 31 Mar 2022 14:56:31 +0900
Message-Id: <164870619150.127053.3677457860116913262.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164870615889.127053.9055569952366814752.stgit@devnote2>
References: <164870615889.127053.9055569952366814752.stgit@devnote2>
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
This needs to set two kconfigs: CONFIG_EMBED_BOOT_CONFIG=y and set
the file path to CONFIG_EMBED_BOOT_CONFIG_FILE.

Note that you still need 'bootconfig' command line option to load the
embedded bootconfig. Also if you boot using an initrd with a different
bootconfig, the kernel will use the bootconfig in the initrd, instead
of the default bootconfig.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
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
 init/Kconfig               |   21 +++++++++++++++++++++
 init/main.c                |   13 ++++++++-----
 lib/.gitignore             |    1 +
 lib/Makefile               |    8 ++++++++
 lib/bootconfig-data.S      |   11 +++++++++++
 lib/bootconfig.c           |   13 +++++++++++++
 8 files changed, 73 insertions(+), 5 deletions(-)
 create mode 100644 lib/bootconfig-data.S

diff --git a/MAINTAINERS b/MAINTAINERS
index b555a5e8704f..9b4910685412 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7350,6 +7350,7 @@ S:	Maintained
 F:	Documentation/admin-guide/bootconfig.rst
 F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
+F:	lib/bootconfig-data.S
 F:	lib/bootconfig.c
 F:	tools/bootconfig/*
 F:	tools/bootconfig/scripts/*
diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index a4665c7ab07c..5dbda5e3e9bb 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -289,4 +289,14 @@ int __init xbc_get_info(int *node_size, size_t *data_size);
 /* XBC cleanup data structures */
 void __init xbc_exit(void);
 
+/* XBC embedded bootconfig data in kernel */
+#ifdef CONFIG_EMBED_BOOT_CONFIG
+char * __init xbc_get_embedded_bootconfig(size_t *size);
+#else
+static inline char *xbc_get_embedded_bootconfig(size_t *size)
+{
+	return NULL;
+}
+#endif
+
 #endif
diff --git a/init/Kconfig b/init/Kconfig
index 97463a33baa7..f5d14a78cfce 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1361,6 +1361,27 @@ config BOOT_CONFIG
 
 	  If unsure, say Y.
 
+config EMBED_BOOT_CONFIG
+	bool "Embed bootconfig file in the kernel"
+	depends on BOOT_CONFIG
+	default n
+	help
+	  Embed a bootconfig file given by EMBED_BOOT_CONFIG_FILE in the
+	  kernel. Usually, the bootconfig file is loaded with the initrd
+	  image. But if the system doesn't support initrd, this option will
+	  help you by embedding a bootconfig file while building the kernel.
+
+	  If unsure, say N.
+
+config EMBED_BOOT_CONFIG_FILE
+	string "Embedded bootconfig file path"
+	default ""
+	depends on EMBED_BOOT_CONFIG
+	help
+	  Specify a bootconfig file which will be embedded to the kernel.
+	  This bootconfig will be used if there is no initrd or no other
+	  bootconfig in the initrd.
+
 choice
 	prompt "Compiler optimization level"
 	default CC_OPTIMIZE_FOR_PERFORMANCE
diff --git a/init/main.c b/init/main.c
index 266d61bc67b0..a5db3e36b809 100644
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
@@ -412,12 +412,15 @@ static void __init setup_boot_config(void)
 	static char tmp_cmdline[COMMAND_LINE_SIZE] __initdata;
 	const char *msg;
 	int pos;
-	u32 size;
+	size_t size;
 	char *data, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size);
+	/* If there is no bootconfig in initrd, try embedded one. */
+	if (!data)
+		data = xbc_get_embedded_bootconfig(&size);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
 	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
@@ -436,8 +439,8 @@ static void __init setup_boot_config(void)
 	}
 
 	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
+		pr_err("bootconfig size %ld greater than max size %d\n",
+			(long)size, XBC_DATA_MAX);
 		return;
 	}
 
@@ -450,7 +453,7 @@ static void __init setup_boot_config(void)
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
index 08053df16c7c..2a82cc324f91 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -280,6 +280,14 @@ $(foreach file, $(libfdt_files), \
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
 obj-$(CONFIG_BOOT_CONFIG) += bootconfig.o
+obj-$(CONFIG_EMBED_BOOT_CONFIG) += bootconfig-data.o
+
+$(obj)/bootconfig-data.o: $(obj)/default.bconf
+
+targets += default.bconf
+filechk_defbconf = cat $(or $(real-prereqs), /dev/null)
+$(obj)/default.bconf: $(CONFIG_EMBED_BOOT_CONFIG_FILE) FORCE
+	$(call filechk,defbconf)
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
 obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
diff --git a/lib/bootconfig-data.S b/lib/bootconfig-data.S
new file mode 100644
index 000000000000..df674ea7d8be
--- /dev/null
+++ b/lib/bootconfig-data.S
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Embed default bootconfig in the kernel.
+ */
+	.pushsection .init.data, "aw"
+	.global embedded_bootconfig_data
+embedded_bootconfig_data:
+	.incbin "lib/default.bconf"
+	.global embedded_bootconfig_data_end
+embedded_bootconfig_data_end:
+	.popsection
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 74f3201ab8e5..6d30aee85ebe 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -12,6 +12,19 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
+
+#ifdef CONFIG_EMBED_BOOT_CONFIG
+/* embedded_bootconfig_data is defined in bootconfig-data.S */
+extern __visible char embedded_bootconfig_data[];
+extern __visible char embedded_bootconfig_data_end[];
+
+char * __init xbc_get_embedded_bootconfig(size_t *size)
+{
+	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
+	return (*size) ? embedded_bootconfig_data : NULL;
+}
+#endif
+
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will

