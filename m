Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E742500287
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbiDMXXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239291AbiDMXW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 196A44616E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xCPwQ1JH76jZXkH9sEaTrRPxjwwIFtJIMBVxZyCU0aI=;
        b=N0d4bUzqwMJXhcu5HzOQlxOpt4oWa+bGlFXqaQ3HElqw5sriY+RKrVnnKd5OYoDKRer6Pp
        /V0JrPfbqNXSl7jpyOHhCSaJu7PTE2Mc6/KlPXOXqqsFA5G6kzwr1dpX+38d3hrLueDT4e
        EnFDgo2UaALRm+rNisMpQP/1nkXZVx0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-628-BtUqYwr3NmyPcLLu6C6bog-1; Wed, 13 Apr 2022 19:20:25 -0400
X-MC-Unique: BtUqYwr3NmyPcLLu6C6bog-1
Received: by mail-qv1-f70.google.com with SMTP id dd5-20020ad45805000000b004461b16d4caso1742526qvb.16
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xCPwQ1JH76jZXkH9sEaTrRPxjwwIFtJIMBVxZyCU0aI=;
        b=b3gMWVoTuAx5g6bu8qq0iCKQ6pF1W9dFQLz+AFwTVW3OSfESs15Fw68CMj8uV0UtCk
         umA7gkffBmRJXAgehcfdAwKHOVPEReEefTCv9LS60LOVZcv8DY9dllxLX9epW6D7D6j3
         SsxO92fw6t/b2W/XsPweWHurLo0eFiFHZVg+u3JCuhVPtJUpaEUT0pc3lWOu6VLE2O3h
         nGrCU3YbRa32hflcbV0Ww9f41FZta7NXgf0mVqFA3TczMMB8ie5row8LuaW1vVGm2Fpe
         ztCZjfR36aw+OB6zLPllrBkI/8td5Y+HkYNV4VVS4eggeWvy2aYSIdzjc4stBT9SXzOK
         KI1Q==
X-Gm-Message-State: AOAM533laZNmwLvUR9D70/D3eFWhfgVdA4a2hUlhHH6Jd8FUm41WRi5+
        BBoAMATqNAfUoLhDZ4d+gORlfnEcaAliwoqdB0RH1Z6gVA04B1hoEFu5vK4FBOxJzJo9MtEG9WD
        TxaEhU3qYM2TDc3JhYGqutqAc
X-Received: by 2002:a05:6214:ccb:b0:444:4af0:bcc7 with SMTP id 11-20020a0562140ccb00b004444af0bcc7mr1056462qvx.126.1649892024524;
        Wed, 13 Apr 2022 16:20:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyecvQTxqObZtXeJYCZv6oGl6HfNMzGACZiCJ7+Tq0la9Qr+4YZU6YO43idj+Zr4if0YRiFzQ==
X-Received: by 2002:a05:6214:ccb:b0:444:4af0:bcc7 with SMTP id 11-20020a0562140ccb00b004444af0bcc7mr1056444qvx.126.1649892024191;
        Wed, 13 Apr 2022 16:20:24 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:23 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 17/18] objtool: Remove --lto and --vmlinux
Date:   Wed, 13 Apr 2022 16:19:52 -0700
Message-Id: <b64b57896eaedf69f53d54c7d9ea373834aef069.1649891421.git.jpoimboe@redhat.com>
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

The '--lto' option is a confusing way of telling objtool to do stack
validation despite it being a linked object.  That's no longer needed
now that an explicit '--stackval' option exists.

The '--vmlinux' option can also be made redundant by adding detection of
a multi-object archive.

Remove both options.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 scripts/Makefile.build                  |  2 +-
 scripts/link-vmlinux.sh                 |  8 ++---
 tools/objtool/builtin-check.c           | 23 ++++++++++++--
 tools/objtool/check.c                   | 40 +++++++++----------------
 tools/objtool/elf.c                     |  3 ++
 tools/objtool/include/objtool/builtin.h |  2 --
 tools/objtool/include/objtool/elf.h     |  8 ++++-
 7 files changed, 48 insertions(+), 38 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3b53de3dec67..f4b44d77e8a0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,7 +228,7 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
 	$(if $(CONFIG_HAVE_TOOLCHAIN_HACKS), --hacks)			\
-	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
+	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 96dbaaeaecd1..0a79f80bd789 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -114,8 +114,8 @@ objtool_link()
 
 	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 
-		# Don't perform vmlinux validation unless explicitly requested,
-		# but run objtool on vmlinux.o now that we have an object file.
+		# For LTO and IBT, objtool doesn't run on individual
+		# translation units.  Run everything on vmlinux instead.
 
 		if is_enabled CONFIG_HAVE_TOOLCHAIN_HACKS; then
 			objtoolopt="${objtoolopt} --hacks"
@@ -152,8 +152,6 @@ objtool_link()
 		if is_enabled CONFIG_X86_SMAP; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
-
-		objtoolopt="${objtoolopt} --lto"
 	fi
 
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
@@ -166,8 +164,6 @@ objtool_link()
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 
-		objtoolopt="${objtoolopt} --vmlinux"
-
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolopt} ${1}
 	fi
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 13e1c46f155a..80fc0d1c0a53 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -54,11 +54,9 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
 	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
-	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
 	OPT_END(),
 };
@@ -117,6 +115,24 @@ static bool opts_valid(void)
 	return false;
 }
 
+static bool link_opts_valid(struct objtool_file *file)
+{
+	if (is_linked_object(file->elf))
+		return true;
+
+	if (opts.noinstr) {
+		fprintf(stderr, "--noinstr requires linked object\n");
+		return false;
+	}
+
+	if (opts.ibt) {
+		fprintf(stderr, "--ibt requires linked object\n");
+		return false;
+	}
+
+	return true;
+}
+
 int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
@@ -136,6 +152,9 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
+	if (!link_opts_valid(file))
+		return 1;
+
 	ret = check(file);
 	if (ret)
 		return ret;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 273ba6840ed2..2d18f23a895b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -264,7 +264,8 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct insn_state *state, struct section *sec)
+static void init_insn_state(struct objtool_file *file, struct insn_state *state,
+			    struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -274,7 +275,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (opts.vmlinux && opts.noinstr && sec)
+	if (is_linked_object(file->elf) && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
@@ -3418,7 +3419,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(&state, sec);
+	init_insn_state(file, &state, sec);
 
 	if (sec) {
 		insn = find_insn(file, sec, 0);
@@ -3504,14 +3505,14 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 		return true;
 
 	/*
-	 * Whole archive runs might encounder dead code from weak symbols.
+	 * Whole archive runs might encounter dead code from weak symbols.
 	 * This is where the linker will have dropped the weak symbol in
 	 * favour of a regular symbol, but leaves the code in place.
 	 *
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (!insn->func && opts.lto) {
+	if (!insn->func && is_linked_object(file->elf)) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3633,7 +3634,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(&state, sec);
+		init_insn_state(file, &state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
@@ -3642,7 +3643,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	return warnings;
 }
 
-static int validate_vmlinux_functions(struct objtool_file *file)
+static int validate_noinstr_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	int warnings = 0;
@@ -3841,16 +3842,6 @@ int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
-	if (opts.lto && !(opts.vmlinux || opts.module)) {
-		fprintf(stderr, "--lto requires: --vmlinux or --module\n");
-		return 1;
-	}
-
-	if (opts.ibt && !opts.lto) {
-		fprintf(stderr, "--ibt requires: --lto\n");
-		return 1;
-	}
-
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3871,15 +3862,6 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (opts.vmlinux && !opts.lto) {
-		ret = validate_vmlinux_functions(file);
-		if (ret < 0)
-			goto out;
-
-		warnings += ret;
-		goto out;
-	}
-
 	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
@@ -3904,6 +3886,12 @@ int check(struct objtool_file *file)
 				goto out;
 			warnings += ret;
 		}
+
+	} else if (opts.noinstr) {
+		ret = validate_noinstr_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.ibt) {
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f7b2ad27bb1c..41fea838aeba 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -377,6 +377,9 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	sym->type = GELF_ST_TYPE(sym->sym.st_info);
 	sym->bind = GELF_ST_BIND(sym->sym.st_info);
 
+	if (sym->type == STT_FILE)
+		elf->num_files++;
+
 	sym->offset = sym->sym.st_value;
 	sym->len = sym->sym.st_size;
 
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 7bc76edb0a85..5c698fb33eca 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -32,11 +32,9 @@ struct opts {
 	bool backtrace;
 	bool backup;
 	bool dryrun;
-	bool lto;
 	bool module;
 	bool no_unreachable;
 	bool stats;
-	bool vmlinux;
 };
 
 extern struct opts opts;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 22ba7e2b816e..1b03a270c58c 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -86,7 +86,7 @@ struct elf {
 	int fd;
 	bool changed;
 	char *name;
-	unsigned int text_size;
+	unsigned int text_size, num_files;
 	struct list_head sections;
 
 	int symbol_bits;
@@ -131,6 +131,12 @@ static inline u32 reloc_hash(struct reloc *reloc)
 	return sec_offset_hash(reloc->sec, reloc->offset);
 }
 
+/* is it a whole archive (vmlinux.o or module)? */
+static inline bool is_linked_object(struct elf *elf)
+{
+	return elf->num_files > 1;
+}
+
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
-- 
2.34.1

