Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888174D759E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 14:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiCMN5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 09:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiCMN5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:57:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137DE5EDF9;
        Sun, 13 Mar 2022 06:56:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A52666112F;
        Sun, 13 Mar 2022 13:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFDCC340E8;
        Sun, 13 Mar 2022 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647179792;
        bh=yR9X6l6nshQ2ueNse50V7C3RqIErXIt//9LNe5HY0Ao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ekO8RbncygmPoPV5FdnIw4n9HmS6/tsQpqA2z20h/7XQmX17u52Yvhg0VR/DI4NPD
         5sCmcDbhJS0FUsVxYLB6ZIIP35Mh3WsI4NSpVsqrSdnTLTOrIl0/rggt/2trAQkysS
         952CXtoQpIUl+xtHLnl+U82l1JjGHwDVi+Kllr5XrfBQITP9khFpT66AFKrSiCrj68
         j4nlVuGiSVk+RIR9svuXJpPZ1SrJW8ICdIcwMl8EUumScpZ69j5+Ap7OMhiqFYqaad
         s4xQI/ICp+/YKJJ5XCdB2pzYD39LUaZ3N91gaD7lq2loSLFZ/ebgQr0IKPsT2POKrV
         f31HcfValDwPg==
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 2/3] bootconfig: Support embedding a bootconfig file in kernel
Date:   Sun, 13 Mar 2022 22:56:28 +0900
Message-Id: <164717978802.656425.5404523823256215813.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <164717976871.656425.6189991392886085524.stgit@devnote2>
References: <164717976871.656425.6189991392886085524.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
This needs 2 options: CONFIG_EMBED_BOOT_CONFIG=y and set the file
path to CONFIG_EMBED_BOOT_CONFIG_FILE.
Note that you still need 'bootconfig' command line option to load the
embedded bootconfig. And if you boot with the initrd which has another
bootconfig, the kernel will use the bootconfig in the initrd, instead
of embedding one.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/linux/bootconfig.h |   10 ++++++++++
 init/Kconfig               |   21 +++++++++++++++++++++
 init/main.c                |   13 ++++++++-----
 lib/.gitignore             |    1 +
 lib/Makefile               |   12 ++++++++++++
 lib/bootconfig.c           |   23 +++++++++++++++++++++++
 6 files changed, 75 insertions(+), 5 deletions(-)

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
index e9119bf54b1f..70440804874d 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1357,6 +1357,27 @@ config BOOT_CONFIG
 
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
index 421050be5039..3803bf2e22ea 100644
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
@@ -411,12 +411,15 @@ static void __init setup_boot_config(void)
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
@@ -435,8 +438,8 @@ static void __init setup_boot_config(void)
 	}
 
 	if (size >= XBC_DATA_MAX) {
-		pr_err("bootconfig size %d greater than max size %d\n",
-			size, XBC_DATA_MAX);
+		pr_err("bootconfig size %ld greater than max size %d\n",
+			(long)size, XBC_DATA_MAX);
 		return;
 	}
 
@@ -449,7 +452,7 @@ static void __init setup_boot_config(void)
 				msg, pos);
 	} else {
 		xbc_get_info(&ret, NULL);
-		pr_info("Load bootconfig: %d bytes %d nodes\n", size, ret);
+		pr_info("Load bootconfig: %ld bytes %d nodes\n", (long)size, ret);
 		/* keys starting with "kernel." are passed via cmdline */
 		extra_command_line = xbc_make_cmdline("kernel");
 		/* Also, "init." keys are init arguments */
diff --git a/lib/.gitignore b/lib/.gitignore
index e5e217b8307b..30a2a5db7033 100644
--- a/lib/.gitignore
+++ b/lib/.gitignore
@@ -6,3 +6,4 @@
 /oid_registry_data.c
 /test_fortify.log
 /test_fortify/*.log
+/default.bconf
diff --git a/lib/Makefile b/lib/Makefile
index 300f569c626b..8183785ee99d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -279,6 +279,18 @@ $(foreach file, $(libfdt_files), \
 	$(eval CFLAGS_$(file) = -I $(srctree)/scripts/dtc/libfdt))
 lib-$(CONFIG_LIBFDT) += $(libfdt_files)
 
+ifeq ($(CONFIG_EMBED_BOOT_CONFIG),y)
+# Since the specified bootconfig file can be switched, we forcibly update the
+# default.bconf file always.
+$(obj)/default.bconf: FORCE
+	$(call cmd,defbconf)
+
+quiet_cmd_defbconf = GEN     $@
+      cmd_defbconf = cat < /dev/null $(CONFIG_EMBED_BOOT_CONFIG_FILE) > $@
+clean-files	+= default.bconf
+$(obj)/bootconfig.o: $(obj)/default.bconf
+endif
+
 lib-$(CONFIG_BOOT_CONFIG) += bootconfig.o
 
 obj-$(CONFIG_RBTREE_TEST) += rbtree_test.o
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 74f3201ab8e5..3a3bf3a208e3 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -12,6 +12,29 @@
 #include <linux/kernel.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
+
+#ifdef CONFIG_EMBED_BOOT_CONFIG
+asm (
+"	.pushsection .init.data, \"aw\"			\n"
+"	.global embedded_bootconfig_data		\n"
+"embedded_bootconfig_data:				\n"
+"	.incbin \"lib/default.bconf\"			\n"
+"	.global embedded_bootconfig_data_end		\n"
+"embedded_bootconfig_data_end:				\n"
+"	.popsection					\n"
+);
+
+extern __visible char embedded_bootconfig_data[];
+extern __visible char embedded_bootconfig_data_end[];
+
+char * __init xbc_get_embedded_bootconfig(size_t *size)
+{
+	*size = embedded_bootconfig_data_end - embedded_bootconfig_data;
+	return (*size) ? embedded_bootconfig_data : NULL;
+}
+
+#endif
+
 #else /* !__KERNEL__ */
 /*
  * NOTE: This is only for tools/bootconfig, because tools/bootconfig will

