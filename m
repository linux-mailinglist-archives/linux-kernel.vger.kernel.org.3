Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F9650B537
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446734AbiDVKjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446715AbiDVKiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC15FFE;
        Fri, 22 Apr 2022 03:35:10 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9/14HRmxXu2/aEIwg3du1g5l4j1mNIEvgsjuXLX6k8=;
        b=NWiKCGC+jVN6c3TRsZPDqxxdpOMNMfJgoOZpQF4aq3mTFr4NFEu8Ac2g+enSSgkdXDvs1K
        9wNboqw47QYJILq6Ko5EMWdvoGCYc6n06xD+7onC3LC5iJk/hW7bjezGLoAzMb1C4hpgBC
        Xv+jAgc8F9ej3HwJUimahy3Mm/LeoD0bxHgmL337CUFkzVWgFijN0c4llH3D4dHosoChNI
        L8UBCDX64dYEfShnqWQ08Hko64i1dHxIAu12eShcpWWFDLtL7XKk6/H196S2cDkO8f88fq
        T0gyqxXx4J5Kz31uVS79cQdono2Zyqswb8Ab1jEj4BII23psjXbsOMTT+nnU7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9/14HRmxXu2/aEIwg3du1g5l4j1mNIEvgsjuXLX6k8=;
        b=cXaFS61LJMdVxD5GufUk6kb1+RsBCHrA/ZGMp2OobLVt8baMpfTRZQwQ1RU0oB7KdurOpJ
        d003GtBmJPfQpmAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Ditch subcommands
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <5c61ebf805e90aefc5fa62bc63468ffae53b9df6.1650300597.git.jpoimboe@redhat.com>
References: <5c61ebf805e90aefc5fa62bc63468ffae53b9df6.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370792.4207.1976776419666677358.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     b51277eb9775ce916f9efd2c51533e481180c1e8
Gitweb:        https://git.kernel.org/tip/b51277eb9775ce916f9efd2c51533e481180c1e8
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:01 +02:00

objtool: Ditch subcommands

Objtool has a fairly singular focus.  It runs on object files and does
validations and transformations which can be combined in various ways.
The subcommand model has never been a good fit, making it awkward to
combine and remove options.

Remove the "check" and "orc" subcommands in favor of a more traditional
cmdline option model.  This makes it much more flexible to use, and
easier to port individual features to other arches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/5c61ebf805e90aefc5fa62bc63468ffae53b9df6.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  |  2 +-
 scripts/link-vmlinux.sh                 | 13 +--
 tools/objtool/Build                     | 12 +--
 tools/objtool/Makefile                  |  8 +--
 tools/objtool/builtin-check.c           | 56 +++++++++++---
 tools/objtool/builtin-orc.c             | 73 +------------------
 tools/objtool/check.c                   |  8 ++-
 tools/objtool/include/objtool/builtin.h |  5 +-
 tools/objtool/objtool.c                 | 97 +------------------------
 tools/objtool/weak.c                    |  9 +--
 10 files changed, 72 insertions(+), 211 deletions(-)
 delete mode 100644 tools/objtool/builtin-orc.c

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dd9d582..116c727 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -227,9 +227,9 @@ ifdef CONFIG_STACK_VALIDATION
 objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
-	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
+	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
 	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index c6e9fef..f6db79b 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -113,9 +113,6 @@ objtool_link()
 
 		# Don't perform vmlinux validation unless explicitly requested,
 		# but run objtool on vmlinux.o now that we have an object file.
-		if is_enabled CONFIG_UNWINDER_ORC; then
-			objtoolcmd="orc generate"
-		fi
 
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
@@ -125,6 +122,10 @@ objtool_link()
 			objtoolopt="${objtoolopt} --mcount"
 		fi
 
+		if is_enabled CONFIG_UNWINDER_ORC; then
+			objtoolopt="${objtoolopt} --orc"
+		fi
+
 		objtoolopt="${objtoolopt} --lto"
 	fi
 
@@ -134,10 +135,6 @@ objtool_link()
 
 	if [ -n "${objtoolopt}" ]; then
 
-		if [ -z "${objtoolcmd}" ]; then
-			objtoolcmd="check"
-		fi
-
 		if is_enabled CONFIG_RETPOLINE; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
@@ -161,7 +158,7 @@ objtool_link()
 		objtoolopt="${objtoolopt} --vmlinux"
 
 		info OBJTOOL ${1}
-		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
+		tools/objtool/objtool ${objtoolopt} ${1}
 	fi
 }
 
diff --git a/tools/objtool/Build b/tools/objtool/Build
index b7222d5..33f2ee5 100644
--- a/tools/objtool/Build
+++ b/tools/objtool/Build
@@ -2,17 +2,15 @@ objtool-y += arch/$(SRCARCH)/
 
 objtool-y += weak.o
 
-objtool-$(SUBCMD_CHECK) += check.o
-objtool-$(SUBCMD_CHECK) += special.o
-objtool-$(SUBCMD_ORC) += check.o
-objtool-$(SUBCMD_ORC) += orc_gen.o
-objtool-$(SUBCMD_ORC) += orc_dump.o
-
+objtool-y += check.o
+objtool-y += special.o
 objtool-y += builtin-check.o
-objtool-y += builtin-orc.o
 objtool-y += elf.o
 objtool-y += objtool.o
 
+objtool-$(BUILD_ORC) += orc_gen.o
+objtool-$(BUILD_ORC) += orc_dump.o
+
 objtool-y += libstring.o
 objtool-y += libctype.o
 objtool-y += str_error_r.o
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 0dbd397..061cf1c 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -39,15 +39,13 @@ CFLAGS += $(if $(elfshdr),,-DLIBELF_USE_DEPRECATED)
 
 AWK = awk
 
-SUBCMD_CHECK := n
-SUBCMD_ORC := n
+BUILD_ORC := n
 
 ifeq ($(SRCARCH),x86)
-	SUBCMD_CHECK := y
-	SUBCMD_ORC := y
+	BUILD_ORC := y
 endif
 
-export SUBCMD_CHECK SUBCMD_ORC
+export BUILD_ORC
 export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index bc447b3..8c3eed5 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -3,16 +3,6 @@
  * Copyright (C) 2015-2017 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
-/*
- * objtool check:
- *
- * This command analyzes every .o file and ensures the validity of its stack
- * trace metadata.  It enforces a set of rules on asm code and C inline
- * assembly code so that stack traces can be reliable.
- *
- * For more information, see tools/objtool/Documentation/stack-validation.txt.
- */
-
 #include <subcmd/parse-options.h>
 #include <string.h>
 #include <stdlib.h>
@@ -22,7 +12,7 @@
 struct opts opts;
 
 static const char * const check_usage[] = {
-	"objtool check <actions> [<options>] file.o",
+	"objtool <actions> [<options>] file.o",
 	NULL,
 };
 
@@ -31,14 +21,26 @@ static const char * const env_usage[] = {
 	NULL,
 };
 
+static int parse_dump(const struct option *opt, const char *str, int unset)
+{
+	if (!str || !strcmp(str, "orc")) {
+		opts.dump_orc = true;
+		return 0;
+	}
+
+	return -1;
+}
+
 const struct option check_options[] = {
 	OPT_GROUP("Actions:"),
 	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
 	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
 	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
+	OPT_BOOLEAN('o', "orc", &opts.orc, "generate ORC metadata"),
 	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
 	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
+	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_dump),
 
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
@@ -81,7 +83,31 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
 	return argc;
 }
 
-int cmd_check(int argc, const char **argv)
+static bool opts_valid(void)
+{
+	if (opts.ibt		||
+	    opts.mcount		||
+	    opts.noinstr	||
+	    opts.orc		||
+	    opts.retpoline	||
+	    opts.sls		||
+	    opts.uaccess) {
+		if (opts.dump_orc) {
+			fprintf(stderr, "--dump can't be combined with other options\n");
+			return false;
+		}
+
+		return true;
+	}
+
+	if (opts.dump_orc)
+		return true;
+
+	fprintf(stderr, "At least one command required\n");
+	return false;
+}
+
+int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
 	struct objtool_file *file;
@@ -90,6 +116,12 @@ int cmd_check(int argc, const char **argv)
 	argc = cmd_parse_options(argc, argv, check_usage);
 	objname = argv[0];
 
+	if (!opts_valid())
+		return 1;
+
+	if (opts.dump_orc)
+		return orc_dump(objname);
+
 	file = objtool_open_read(objname);
 	if (!file)
 		return 1;
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
deleted file mode 100644
index 17f8b93..0000000
--- a/tools/objtool/builtin-orc.c
+++ /dev/null
@@ -1,73 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (C) 2017 Josh Poimboeuf <jpoimboe@redhat.com>
- */
-
-/*
- * objtool orc:
- *
- * This command analyzes a .o file and adds .orc_unwind and .orc_unwind_ip
- * sections to it, which is used by the in-kernel ORC unwinder.
- *
- * This command is a superset of "objtool check".
- */
-
-#include <string.h>
-#include <objtool/builtin.h>
-#include <objtool/objtool.h>
-
-static const char *orc_usage[] = {
-	"objtool orc generate [<options>] file.o",
-	"objtool orc dump file.o",
-	NULL,
-};
-
-int cmd_orc(int argc, const char **argv)
-{
-	const char *objname;
-
-	argc--; argv++;
-	if (argc <= 0)
-		usage_with_options(orc_usage, check_options);
-
-	if (!strncmp(argv[0], "gen", 3)) {
-		struct objtool_file *file;
-		int ret;
-
-		argc = cmd_parse_options(argc, argv, orc_usage);
-		objname = argv[0];
-
-		file = objtool_open_read(objname);
-		if (!file)
-			return 1;
-
-		ret = check(file);
-		if (ret)
-			return ret;
-
-		if (list_empty(&file->insn_list))
-			return 0;
-
-		ret = orc_create(file);
-		if (ret)
-			return ret;
-
-		if (!file->elf->changed)
-			return 0;
-
-		return elf_write(file->elf);
-	}
-
-	if (!strcmp(argv[0], "dump")) {
-		if (argc != 2)
-			usage_with_options(orc_usage, check_options);
-
-		objname = argv[1];
-
-		return orc_dump(objname);
-	}
-
-	usage_with_options(orc_usage, check_options);
-
-	return 0;
-}
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3362cc3..16a6c4b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3949,6 +3949,14 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (opts.orc && !list_empty(&file->insn_list)) {
+		ret = orc_create(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
+
 	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 87c1a73..44548e2 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -11,9 +11,11 @@ extern const struct option check_options[];
 
 struct opts {
 	/* actions: */
+	bool dump_orc;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
+	bool orc;
 	bool retpoline;
 	bool sls;
 	bool uaccess;
@@ -34,7 +36,6 @@ extern struct opts opts;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
-extern int cmd_check(int argc, const char **argv);
-extern int cmd_orc(int argc, const char **argv);
+extern int objtool_run(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index a0f3d3c..512669c 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -3,16 +3,6 @@
  * Copyright (C) 2015 Josh Poimboeuf <jpoimboe@redhat.com>
  */
 
-/*
- * objtool:
- *
- * The 'check' subcmd analyzes every .o file and ensures the validity of its
- * stack trace metadata.  It enforces a set of rules on asm code and C inline
- * assembly code so that stack traces can be reliable.
- *
- * For more information, see tools/objtool/Documentation/stack-validation.txt.
- */
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <string.h>
@@ -26,20 +16,6 @@
 #include <objtool/objtool.h>
 #include <objtool/warn.h>
 
-struct cmd_struct {
-	const char *name;
-	int (*fn)(int, const char **);
-	const char *help;
-};
-
-static const char objtool_usage_string[] =
-	"objtool COMMAND [ARGS]";
-
-static struct cmd_struct objtool_cmds[] = {
-	{"check",	cmd_check,	"Perform stack metadata validation on an object file" },
-	{"orc",		cmd_orc,	"Generate in-place ORC unwind tables for an object file" },
-};
-
 bool help;
 
 const char *objname;
@@ -161,70 +137,6 @@ void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 	f->pv_ops[idx].clean = false;
 }
 
-static void cmd_usage(void)
-{
-	unsigned int i, longest = 0;
-
-	printf("\n usage: %s\n\n", objtool_usage_string);
-
-	for (i = 0; i < ARRAY_SIZE(objtool_cmds); i++) {
-		if (longest < strlen(objtool_cmds[i].name))
-			longest = strlen(objtool_cmds[i].name);
-	}
-
-	puts(" Commands:");
-	for (i = 0; i < ARRAY_SIZE(objtool_cmds); i++) {
-		printf("   %-*s   ", longest, objtool_cmds[i].name);
-		puts(objtool_cmds[i].help);
-	}
-
-	printf("\n");
-
-	if (!help)
-		exit(129);
-	exit(0);
-}
-
-static void handle_options(int *argc, const char ***argv)
-{
-	while (*argc > 0) {
-		const char *cmd = (*argv)[0];
-
-		if (cmd[0] != '-')
-			break;
-
-		if (!strcmp(cmd, "--help") || !strcmp(cmd, "-h")) {
-			help = true;
-			break;
-		} else {
-			fprintf(stderr, "Unknown option: %s\n", cmd);
-			cmd_usage();
-		}
-
-		(*argv)++;
-		(*argc)--;
-	}
-}
-
-static void handle_internal_command(int argc, const char **argv)
-{
-	const char *cmd = argv[0];
-	unsigned int i, ret;
-
-	for (i = 0; i < ARRAY_SIZE(objtool_cmds); i++) {
-		struct cmd_struct *p = objtool_cmds+i;
-
-		if (strcmp(p->name, cmd))
-			continue;
-
-		ret = p->fn(argc, argv);
-
-		exit(ret);
-	}
-
-	cmd_usage();
-}
-
 int main(int argc, const char **argv)
 {
 	static const char *UNUSED = "OBJTOOL_NOT_IMPLEMENTED";
@@ -233,14 +145,7 @@ int main(int argc, const char **argv)
 	exec_cmd_init("objtool", UNUSED, UNUSED, UNUSED);
 	pager_init(UNUSED);
 
-	argv++;
-	argc--;
-	handle_options(&argc, &argv);
-
-	if (!argc || help)
-		cmd_usage();
-
-	handle_internal_command(argc, argv);
+	objtool_run(argc, argv);
 
 	return 0;
 }
diff --git a/tools/objtool/weak.c b/tools/objtool/weak.c
index 8314e82..d83f607 100644
--- a/tools/objtool/weak.c
+++ b/tools/objtool/weak.c
@@ -15,17 +15,12 @@
 	return ENOSYS;							\
 })
 
-int __weak check(struct objtool_file *file)
-{
-	UNSUPPORTED("check subcommand");
-}
-
 int __weak orc_dump(const char *_objname)
 {
-	UNSUPPORTED("orc");
+	UNSUPPORTED("ORC");
 }
 
 int __weak orc_create(struct objtool_file *file)
 {
-	UNSUPPORTED("orc");
+	UNSUPPORTED("ORC");
 }
