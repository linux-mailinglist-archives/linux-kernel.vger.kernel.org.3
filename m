Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A767E500291
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbiDMXXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239251AbiDMXWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46FF25C4C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PUsjixtT/2aqcPCo361GT/5WWbFX2OcpIYw6VwAndM=;
        b=jF6/E8suuNasnNOW14Dy0YOuDd6VJpGQAdW2Tb6ZsCxZMFUu2W8L5Irz1eerXa3VT4wBjN
        cOklBK+bjsLJxy6uVhc7FxaR0BgiK6koMFUWs5OP4+NEKo5fvPR5JQNaeSzJ1MV13o1jl8
        BE2HqXBgV+EdAMhD6jxW0TjV6Nh6NeI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298--sKG9eGpNEKvOh_NcAcE7w-1; Wed, 13 Apr 2022 19:20:10 -0400
X-MC-Unique: -sKG9eGpNEKvOh_NcAcE7w-1
Received: by mail-qk1-f199.google.com with SMTP id bi19-20020a05620a319300b0069c16295aabso2178775qkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6PUsjixtT/2aqcPCo361GT/5WWbFX2OcpIYw6VwAndM=;
        b=AzqWPvMiBlyni8pModGiVvrtLwOUJyee6nQkQteiN43sKrwvnEiPcLne6Llu8qTYa8
         xTmPWAIXUzYxAPzkOfR8S0HRe2oAKoCuLbpyWk+XL67QAVhwohM9knRhHxQHB/VJVnVy
         0gqr7GRdn/dngDyzVvdX85HBTSGFRCIPpQkaBkisAinCaK3c8d3ryp1u7K5afIq2nkDC
         psmysYC6B8djAGE9aBT8A2GnBdgkOgBQwtsfd2jcIM3NoGt14DZlU6B3SL3PTeJrp1zR
         x0gCk2b4oKcRs0Pmw1koNF93y1xwT7s46pqP3xa+n2n2n4ZiVhRiKLgyasGqRDBz/29n
         QlZA==
X-Gm-Message-State: AOAM532lVgkRPAY/Wko8bnI2XJNasamHecKOrcRZcfuB3AcYFhWK4bRF
        9jp8uTamX0/1RdfkOgpfiyiMSJIoh7wsLHbMtOn281wvJv7wUB2jm8RYTOdsqpSgoqouVMNfI7M
        EbFhE/+P/H8Z9TeZGHuodaAEi
X-Received: by 2002:a0c:e388:0:b0:444:2d7e:d84c with SMTP id a8-20020a0ce388000000b004442d7ed84cmr984011qvl.9.1649892010239;
        Wed, 13 Apr 2022 16:20:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOEeyK7udZnwdb3G9wcJaYKFCSYcUQ34IUlFYzkLgpJi+fKX1uhDThPvvguZs/vlxPgYnReA==
X-Received: by 2002:a0c:e388:0:b0:444:2d7e:d84c with SMTP id a8-20020a0ce388000000b004442d7ed84cmr983995qvl.9.1649892009911;
        Wed, 13 Apr 2022 16:20:09 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:09 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 08/18] objtool: Ditch subcommands
Date:   Wed, 13 Apr 2022 16:19:43 -0700
Message-Id: <9476ef23a62daa2caf99689c1f56e358f7f25f69.1649891421.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1649891421.git.jpoimboe@redhat.com>
References: <cover.1649891421.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objtool has a fairly singular focus.  It runs on object files and does
validations and transformations which can be combined in various ways.
The subcommand model has never been a good fit, making it awkward to
combine and remove options.

Remove the "check" and "orc" subcommands in favor of a more traditional
cmdline option model.  This makes it much more flexible to use, and
easier to port individual features to other arches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  |  2 +-
 scripts/link-vmlinux.sh                 | 13 ++--
 tools/objtool/Build                     | 12 ++-
 tools/objtool/Makefile                  |  8 +-
 tools/objtool/builtin-check.c           | 61 +++++++++++++---
 tools/objtool/builtin-orc.c             | 73 -------------------
 tools/objtool/check.c                   |  8 ++
 tools/objtool/include/objtool/builtin.h | 10 ++-
 tools/objtool/objtool.c                 | 97 +------------------------
 tools/objtool/weak.c                    |  9 +--
 10 files changed, 82 insertions(+), 211 deletions(-)
 delete mode 100644 tools/objtool/builtin-orc.c

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index dd9d582808d6..116c7272b41c 100644
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
index c6e9fef61b11..f6db79b11573 100755
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
index b7222d5cc7bc..33f2ee5a46d3 100644
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
index 0dbd397f319d..061cf1cd42c4 100644
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
index 4f4a087720b3..3df46e9b4b03 100644
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
 
@@ -31,14 +21,31 @@ static const char * const env_usage[] = {
 	NULL,
 };
 
+static int parse_dumpstr(const struct option *opt, const char *str, int unset)
+{
+	if (unset || !str) {
+		opts.dump = DUMP_NONE;
+		return 0;
+	}
+
+	if (!strcmp(str, "orc")) {
+		opts.dump = DUMP_ORC;
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
 	OPT_BOOLEAN('S', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
 	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
+	OPT_CALLBACK(0, "dump", NULL, "orc", "dump object data", parse_dumpstr),
 
 	OPT_GROUP("Options:"),
 	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
@@ -81,7 +88,31 @@ int cmd_parse_options(int argc, const char **argv, const char * const usage[])
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
+		if (opts.dump) {
+			fprintf(stderr, "--dump can't be combined with other options\n");
+			return false;
+		}
+
+		return true;
+	}
+
+	if (opts.dump)
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
@@ -90,6 +121,12 @@ int cmd_check(int argc, const char **argv)
 	argc = cmd_parse_options(argc, argv, check_usage);
 	objname = argv[0];
 
+	if (!opts_valid())
+		return 1;
+
+	if (opts.dump == DUMP_ORC)
+		return orc_dump(objname);
+
 	file = objtool_open_read(objname);
 	if (!file)
 		return 1;
diff --git a/tools/objtool/builtin-orc.c b/tools/objtool/builtin-orc.c
deleted file mode 100644
index 17f8b9307738..000000000000
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
index 5059c097c563..490ed3560d99 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3950,6 +3950,14 @@ int check(struct objtool_file *file)
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
index 87c1a7351e3c..0cac9bd6a97f 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,11 +9,18 @@
 
 extern const struct option check_options[];
 
+enum dump {
+	DUMP_NONE,
+	DUMP_ORC,
+};
+
 struct opts {
 	/* actions: */
+	enum dump dump;
 	bool ibt;
 	bool mcount;
 	bool noinstr;
+	bool orc;
 	bool retpoline;
 	bool sls;
 	bool uaccess;
@@ -34,7 +41,6 @@ extern struct opts opts;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
-extern int cmd_check(int argc, const char **argv);
-extern int cmd_orc(int argc, const char **argv);
+extern int objtool_run(int argc, const char **argv);
 
 #endif /* _BUILTIN_H */
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index a0f3d3c9558d..512669ce064c 100644
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
index 8314e824db4a..d83f607733b0 100644
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
-- 
2.34.1

