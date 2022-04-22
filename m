Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE3F50B541
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446766AbiDVKj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446680AbiDVKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:37:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE517DD1;
        Fri, 22 Apr 2022 03:34:58 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:34:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9anwvJrW2pm08BqlJRscGUZgVm1ZukiQhh9vT7Br5U=;
        b=NPx087JfL2gqMuVkIUDHPkAwvXiUVCUwIUwaIsQAPINsDfJs8R8NksUt9gSO1sbHKEQ97l
        J5O2Y4zOcUUFjewAsyUT9sNlfW05a0vGbSFgIDWPV4liOt+kOZq11+zoBiJ6M5uxcVq6H+
        H3OfxYcXBUbB2Fn7NeOzs9/T607mzx50xiw6OvTw7Y6nY3wNR3XNteUjAZEYqoSuuVyTVw
        AzfTpEQqr1RHTuLTPdK9TeUllBF0B/MXWLgvTAHEVb+T6jAbQVBHO0DxDitfhuvVCUMVta
        pQTqWE1SzUFoQeqXKOvU25Ky4xoxF0DbSvwQEiDS+kpJhtdZ+XL04IUKoge2lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u9anwvJrW2pm08BqlJRscGUZgVm1ZukiQhh9vT7Br5U=;
        b=jq3IlTzr6tJhVpi7OMe2XgS8ebpMcdjtvWJ9QzPj4+la13wGX4sAJ0isLB04pIzoiOwGEa
        bPh0UBTz1xPu5SBg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove --lto and --vmlinux in favor of --link
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com>
References: <dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062369637.4207.3206266588151730216.tip-bot2@tip-bot2>
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

Commit-ID:     753da4179d08b625d8df72e97724e22749969fd3
Gitweb:        https://git.kernel.org/tip/753da4179d08b625d8df72e97724e22749969fd3
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:43 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:05 +02:00

objtool: Remove --lto and --vmlinux in favor of --link

The '--lto' option is a confusing way of telling objtool to do stack
validation despite it being a linked object.  It's no longer needed now
that an explicit '--stackval' option exists.  The '--vmlinux' option is
also redundant.

Remove both options in favor of a straightforward '--link' option which
identifies a linked object.

Also, implicitly set '--link' with a warning if the user forgets to do
so and we can tell that it's a linked object.  This makes it easier for
manual vmlinux runs.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/dcd3ceffd15a54822c6183e5766d21ad06082b45.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  |  4 +-
 scripts/link-vmlinux.sh                 |  8 +----
 tools/objtool/builtin-check.c           | 39 ++++++++++++++++++++---
 tools/objtool/check.c                   | 40 ++++++++----------------
 tools/objtool/elf.c                     |  3 ++-
 tools/objtool/include/objtool/builtin.h |  3 +--
 tools/objtool/include/objtool/elf.h     | 12 ++++++-
 7 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 6c206a1..ac81672 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -229,7 +229,7 @@ objtool := $(objtree)/tools/objtool/objtool
 objtool_args =								\
 	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
 	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
-	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
+	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
 	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
@@ -237,6 +237,7 @@ objtool_args =								\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
+	$(if $(linked-object), --link)					\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
 
@@ -306,6 +307,7 @@ quiet_cmd_cc_prelink_modules = LD [M]  $@
 # modules into native code
 $(obj)/%.prelink.o: objtool-enabled = y
 $(obj)/%.prelink.o: part-of-module := y
+$(obj)/%.prelink.o: linked-object := y
 
 $(obj)/%.prelink.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_prelink_modules)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index fce4f41..eb9324f 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -114,8 +114,8 @@ objtool_link()
 
 	if is_enabled CONFIG_LTO_CLANG || is_enabled CONFIG_X86_KERNEL_IBT; then
 
-		# Don't perform vmlinux validation unless explicitly requested,
-		# but run objtool on vmlinux.o now that we have an object file.
+		# For LTO and IBT, objtool doesn't run on individual
+		# translation units.  Run everything on vmlinux instead.
 
 		if is_enabled CONFIG_HAVE_JUMP_LABEL_HACK; then
 			objtoolopt="${objtoolopt} --hacks=jump_label"
@@ -156,8 +156,6 @@ objtool_link()
 		if is_enabled CONFIG_X86_SMAP; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
-
-		objtoolopt="${objtoolopt} --lto"
 	fi
 
 	if is_enabled CONFIG_NOINSTR_VALIDATION; then
@@ -170,7 +168,7 @@ objtool_link()
 			objtoolopt="${objtoolopt} --no-unreachable"
 		fi
 
-		objtoolopt="${objtoolopt} --vmlinux"
+		objtoolopt="${objtoolopt} --link"
 
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolopt} ${1}
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 1803a63..f4c3a50 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -9,6 +9,11 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
+#define ERROR(format, ...)				\
+	fprintf(stderr,					\
+		"error: objtool: " format "\n",		\
+		##__VA_ARGS__)
+
 struct opts opts;
 
 static const char * const check_usage[] = {
@@ -73,12 +78,11 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
 	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
 	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
+	OPT_BOOLEAN(0, "link", &opts.link, "object is a linked object"),
 	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
 	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
 	OPT_BOOLEAN(0, "sec-address", &opts.sec_address, "print section addresses in warnings"),
 	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
-	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
 
 	OPT_END(),
 };
@@ -124,7 +128,7 @@ static bool opts_valid(void)
 	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
-			fprintf(stderr, "--dump can't be combined with other options\n");
+			ERROR("--dump can't be combined with other options");
 			return false;
 		}
 
@@ -134,10 +138,34 @@ static bool opts_valid(void)
 	if (opts.dump_orc)
 		return true;
 
-	fprintf(stderr, "At least one command required\n");
+	ERROR("At least one command required");
 	return false;
 }
 
+static bool link_opts_valid(struct objtool_file *file)
+{
+	if (opts.link)
+		return true;
+
+	if (has_multiple_files(file->elf)) {
+		ERROR("Linked object detected, forcing --link");
+		opts.link = true;
+		return true;
+	}
+
+	if (opts.noinstr) {
+		ERROR("--noinstr requires --link");
+		return false;
+	}
+
+	if (opts.ibt) {
+		ERROR("--ibt requires --link");
+		return false;
+	}
+
+	return true;
+}
+
 int objtool_run(int argc, const char **argv)
 {
 	const char *objname;
@@ -157,6 +185,9 @@ int objtool_run(int argc, const char **argv)
 	if (!file)
 		return 1;
 
+	if (!link_opts_valid(file))
+		return 1;
+
 	ret = check(file);
 	if (ret)
 		return ret;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 30b24dc..2063f9f 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -263,7 +263,8 @@ static void init_cfi_state(struct cfi_state *cfi)
 	cfi->drap_offset = -1;
 }
 
-static void init_insn_state(struct insn_state *state, struct section *sec)
+static void init_insn_state(struct objtool_file *file, struct insn_state *state,
+			    struct section *sec)
 {
 	memset(state, 0, sizeof(*state));
 	init_cfi_state(&state->cfi);
@@ -273,7 +274,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (opts.vmlinux && opts.noinstr && sec)
+	if (opts.link && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
@@ -3405,7 +3406,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	if (!file->hints)
 		return 0;
 
-	init_insn_state(&state, sec);
+	init_insn_state(file, &state, sec);
 
 	if (sec) {
 		insn = find_insn(file, sec, 0);
@@ -3491,14 +3492,14 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
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
+	if (opts.link && !insn->func) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3620,7 +3621,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 		if (func->type != STT_FUNC)
 			continue;
 
-		init_insn_state(&state, sec);
+		init_insn_state(file, &state, sec);
 		set_func_state(&state.cfi);
 
 		warnings += validate_symbol(file, sec, func, &state);
@@ -3629,7 +3630,7 @@ static int validate_section(struct objtool_file *file, struct section *sec)
 	return warnings;
 }
 
-static int validate_vmlinux_functions(struct objtool_file *file)
+static int validate_noinstr_sections(struct objtool_file *file)
 {
 	struct section *sec;
 	int warnings = 0;
@@ -3890,16 +3891,6 @@ int check(struct objtool_file *file)
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
@@ -3920,15 +3911,6 @@ int check(struct objtool_file *file)
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
@@ -3953,6 +3935,12 @@ int check(struct objtool_file *file)
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
index 0f6fa37..583a3ec 100644
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
index f3a1a75..280ea18 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -28,12 +28,11 @@ struct opts {
 	bool backtrace;
 	bool backup;
 	bool dryrun;
-	bool lto;
+	bool link;
 	bool module;
 	bool no_unreachable;
 	bool sec_address;
 	bool stats;
-	bool vmlinux;
 };
 
 extern struct opts opts;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 9b36802..de0cb2f 100644
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
@@ -131,6 +131,16 @@ static inline u32 reloc_hash(struct reloc *reloc)
 	return sec_offset_hash(reloc->sec, reloc->offset);
 }
 
+/*
+ * Try to see if it's a whole archive (vmlinux.o or module).
+ *
+ * Note this will miss the case where a module only has one source file.
+ */
+static inline bool has_multiple_files(struct elf *elf)
+{
+	return elf->num_files > 1;
+}
+
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
