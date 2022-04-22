Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1604150B544
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241753AbiDVKjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446724AbiDVKiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2796448;
        Fri, 22 Apr 2022 03:35:11 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4ynCu1L+m8zBjQtbzbBkuaaUKNAGn2zg2v8b2/gyfE=;
        b=z94uzEXFmxKPd0BkCYgf00WKyDVke9Cp4vqytClF9b3dAPa8PqEMv4YTokcI7YiV0Cfv49
        OiHWmn2lDg72GodaJI7sqMkHvRfuz1nMsr0sQ5TEnZMZ2A90yEvNpjaK7Z26apzUMKB4Dv
        mYkut0G3HWMDGho15bnJ7NiOoWBi54ijBcFoTLjyZYBI0QKCiTZ3Snx/39z8oTHleIK0ss
        BiTTwSt70RxjQmaiu0kWt16AFwgzbj7ugC7FFS0W6Vw2W0s3f0Lr0w+sxuqoO06z7goeBJ
        9stdF0mpy3or6Ei1WHwy85xAhywmVLwPwPQZH6onBQjCQKSroJVZoHTKrwQR1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A4ynCu1L+m8zBjQtbzbBkuaaUKNAGn2zg2v8b2/gyfE=;
        b=I5zXezX6Pq4qKv7ysQurnbc+Zv3KO4Wcqz6Tac0pTrpvfxB41kJXsjxMROrRHJRcTCvWpj
        A1ShJEoHo8YhylAQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Reorganize cmdline options
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9dcaa752f83aca24b1b21f0b0eeb28a0c181c0b0.1650300597.git.jpoimboe@redhat.com>
References: <9dcaa752f83aca24b1b21f0b0eeb28a0c181c0b0.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370880.4207.6216585307084826492.tip-bot2@tip-bot2>
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

Commit-ID:     2daf7faba7ded8703e4b4ebc8b161f22272fc91a
Gitweb:        https://git.kernel.org/tip/2daf7faba7ded8703e4b4ebc8b161f22272fc91a
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:26 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:01 +02:00

objtool: Reorganize cmdline options

Split the existing options into two groups: actions, which actually do
something; and options, which modify the actions in some way.

Also there's no need to have short flags for all the non-action options.
Reserve short flags for the more important actions.

While at it:

- change a few of the short flags to be more intuitive

- make option descriptions more consistently descriptive

- sort options in the source like they are when printed

- move options to a global struct

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/9dcaa752f83aca24b1b21f0b0eeb28a0c181c0b0.1650300597.git.jpoimboe@redhat.com
---
 scripts/Makefile.build                  | 10 ++--
 scripts/link-vmlinux.sh                 | 30 +++++++-----
 tools/objtool/arch/x86/decode.c         |  2 +-
 tools/objtool/arch/x86/special.c        |  2 +-
 tools/objtool/builtin-check.c           | 40 +++++++--------
 tools/objtool/check.c                   | 62 ++++++++++++------------
 tools/objtool/elf.c                     |  8 +--
 tools/objtool/include/objtool/builtin.h | 26 ++++++++--
 tools/objtool/objtool.c                 |  6 +-
 9 files changed, 108 insertions(+), 78 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 33c1ed5..dd9d582 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -228,14 +228,14 @@ objtool := $(objtree)/tools/objtool/objtool
 
 objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
-	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_X86_KERNEL_IBT), --lto --ibt)			\
-	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
-	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)			\
+	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
+	$(if $(CONFIG_SLS), --sls)					\
 	$(if $(CONFIG_X86_SMAP), --uaccess)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_SLS), --sls)
+	$(if $(part-of-module), --module)				\
+	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
+	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
 
 cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 9361a1e..c6e9fef 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -117,8 +117,6 @@ objtool_link()
 			objtoolcmd="orc generate"
 		fi
 
-		objtoolopt="${objtoolopt} --lto"
-
 		if is_enabled CONFIG_X86_KERNEL_IBT; then
 			objtoolopt="${objtoolopt} --ibt"
 		fi
@@ -126,6 +124,8 @@ objtool_link()
 		if is_enabled CONFIG_FTRACE_MCOUNT_USE_OBJTOOL; then
 			objtoolopt="${objtoolopt} --mcount"
 		fi
+
+		objtoolopt="${objtoolopt} --lto"
 	fi
 
 	if is_enabled CONFIG_VMLINUX_VALIDATION; then
@@ -133,25 +133,33 @@ objtool_link()
 	fi
 
 	if [ -n "${objtoolopt}" ]; then
+
 		if [ -z "${objtoolcmd}" ]; then
 			objtoolcmd="check"
 		fi
-		objtoolopt="${objtoolopt} --vmlinux"
-		if ! is_enabled CONFIG_FRAME_POINTER; then
-			objtoolopt="${objtoolopt} --no-fp"
-		fi
-		if is_enabled CONFIG_GCOV_KERNEL; then
-			objtoolopt="${objtoolopt} --no-unreachable"
-		fi
+
 		if is_enabled CONFIG_RETPOLINE; then
 			objtoolopt="${objtoolopt} --retpoline"
 		fi
+
+		if is_enabled CONFIG_SLS; then
+			objtoolopt="${objtoolopt} --sls"
+		fi
+
 		if is_enabled CONFIG_X86_SMAP; then
 			objtoolopt="${objtoolopt} --uaccess"
 		fi
-		if is_enabled CONFIG_SLS; then
-			objtoolopt="${objtoolopt} --sls"
+
+		if ! is_enabled CONFIG_FRAME_POINTER; then
+			objtoolopt="${objtoolopt} --no-fp"
 		fi
+
+		if is_enabled CONFIG_GCOV_KERNEL; then
+			objtoolopt="${objtoolopt} --no-unreachable"
+		fi
+
+		objtoolopt="${objtoolopt} --vmlinux"
+
 		info OBJTOOL ${1}
 		tools/objtool/objtool ${objtoolcmd} ${objtoolopt} ${1}
 	fi
diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 943cb41..8b990a5 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -581,7 +581,7 @@ int arch_decode_instruction(struct objtool_file *file, const struct section *sec
 		break;
 
 	case 0xc7: /* mov imm, r/m */
-		if (!noinstr)
+		if (!opts.noinstr)
 			break;
 
 		if (insn.length == 3+4+4 && !strncmp(sec->name, ".init.text", 10)) {
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index e707d9b..7c97b73 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -20,7 +20,7 @@ void arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 		 * find paths that see the STAC but take the NOP instead of
 		 * CLAC and the other way around.
 		 */
-		if (uaccess)
+		if (opts.uaccess)
 			alt->skip_orig = true;
 		else
 			alt->skip_alt = true;
diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index fc6975a..bc447b3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -19,12 +19,10 @@
 #include <objtool/builtin.h>
 #include <objtool/objtool.h>
 
-bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt;
+struct opts opts;
 
 static const char * const check_usage[] = {
-	"objtool check [<options>] file.o",
+	"objtool check <actions> [<options>] file.o",
 	NULL,
 };
 
@@ -34,21 +32,25 @@ static const char * const env_usage[] = {
 };
 
 const struct option check_options[] = {
-	OPT_BOOLEAN('f', "no-fp", &no_fp, "Skip frame pointer validation"),
-	OPT_BOOLEAN('u', "no-unreachable", &no_unreachable, "Skip 'unreachable instruction' warnings"),
-	OPT_BOOLEAN('r', "retpoline", &retpoline, "Validate retpoline assumptions"),
-	OPT_BOOLEAN('m', "module", &module, "Indicates the object will be part of a kernel module"),
-	OPT_BOOLEAN('b', "backtrace", &backtrace, "unwind on error"),
-	OPT_BOOLEAN('a', "uaccess", &uaccess, "enable uaccess checking"),
-	OPT_BOOLEAN('s', "stats", &stats, "print statistics"),
-	OPT_BOOLEAN(0, "lto", &lto, "whole-archive like runs"),
-	OPT_BOOLEAN('n', "noinstr", &noinstr, "noinstr validation for vmlinux.o"),
-	OPT_BOOLEAN('l', "vmlinux", &vmlinux, "vmlinux.o validation"),
-	OPT_BOOLEAN('M', "mcount", &mcount, "generate __mcount_loc"),
-	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
-	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
-	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
-	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_GROUP("Actions:"),
+	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
+	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for ftrace"),
+	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
+	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpoline usage"),
+	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
+	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP"),
+
+	OPT_GROUP("Options:"),
+	OPT_BOOLEAN(0, "backtrace", &opts.backtrace, "unwind on error"),
+	OPT_BOOLEAN(0, "backup", &opts.backup, "create .orig files before modification"),
+	OPT_BOOLEAN(0, "dry-run", &opts.dryrun, "don't write modifications"),
+	OPT_BOOLEAN(0, "lto", &opts.lto, "whole-archive like runs"),
+	OPT_BOOLEAN(0, "module", &opts.module, "object is part of a kernel module"),
+	OPT_BOOLEAN(0, "no-fp", &opts.no_fp, "skip frame pointer validation"),
+	OPT_BOOLEAN(0, "no-unreachable", &opts.no_unreachable, "skip 'unreachable instruction' warnings"),
+	OPT_BOOLEAN(0, "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN(0, "vmlinux", &opts.vmlinux, "vmlinux.o validation"),
+
 	OPT_END(),
 };
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ca5b746..3362cc3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -273,7 +273,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (vmlinux && noinstr && sec)
+	if (opts.vmlinux && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
@@ -339,7 +339,7 @@ static void *cfi_hash_alloc(unsigned long size)
 	if (cfi_hash == (void *)-1L) {
 		WARN("mmap fail cfi_hash");
 		cfi_hash = NULL;
-	}  else if (stats) {
+	}  else if (opts.stats) {
 		printf("cfi_bits: %d\n", cfi_bits);
 	}
 
@@ -434,7 +434,7 @@ static int decode_instructions(struct objtool_file *file)
 		}
 	}
 
-	if (stats)
+	if (opts.stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
 	return 0;
@@ -497,7 +497,7 @@ static int init_pv_ops(struct objtool_file *file)
 	struct symbol *sym;
 	int idx, nr;
 
-	if (!noinstr)
+	if (!opts.noinstr)
 		return 0;
 
 	file->pv_ops = NULL;
@@ -668,7 +668,7 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!module) {
+			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
 				return -1;
 			}
@@ -761,7 +761,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->endbr_list, call_node)
 		idx++;
 
-	if (stats) {
+	if (opts.stats) {
 		printf("ibt: ENDBR at function start: %d\n", file->nr_endbr);
 		printf("ibt: ENDBR inside functions:  %d\n", file->nr_endbr_int);
 		printf("ibt: superfluous ENDBR:       %d\n", idx);
@@ -1028,7 +1028,7 @@ static void add_uaccess_safe(struct objtool_file *file)
 	struct symbol *func;
 	const char **name;
 
-	if (!uaccess)
+	if (!opts.uaccess)
 		return;
 
 	for (name = uaccess_safe_builtin; *name; name++) {
@@ -1170,7 +1170,7 @@ static void annotate_call_site(struct objtool_file *file,
 		return;
 	}
 
-	if (mcount && sym->fentry) {
+	if (opts.mcount && sym->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1256,7 +1256,7 @@ static bool is_first_func_insn(struct objtool_file *file, struct instruction *in
 	if (insn->offset == insn->func->offset)
 		return true;
 
-	if (ibt) {
+	if (opts.ibt) {
 		struct instruction *prev = prev_insn_same_sym(file, insn);
 
 		if (prev && prev->type == INSN_ENDBR &&
@@ -1699,7 +1699,7 @@ static int add_special_section_alts(struct objtool_file *file)
 		free(special_alt);
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("jl\\\tNOP\tJMP\n");
 		printf("short:\t%ld\t%ld\n", file->jl_nop_short, file->jl_short);
 		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
@@ -1945,7 +1945,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
-		if (ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
+		if (opts.ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
 			struct symbol *sym = find_symbol_by_offset(insn->sec, insn->offset);
 
 			if (sym && sym->bind == STB_GLOBAL &&
@@ -2806,7 +2806,7 @@ static int update_cfi_state(struct instruction *insn,
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
+		if (!opts.no_fp && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3363,7 +3363,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
-					if (backtrace)
+					if (opts.backtrace)
 						BT_FUNC("(alt)", insn);
 					return ret;
 				}
@@ -3379,7 +3379,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (sls && !insn->retpoline_safe &&
+			if (opts.sls && !insn->retpoline_safe &&
 			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after ret",
 					  insn->sec, insn->offset);
@@ -3392,7 +3392,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!no_fp && func && !is_fentry_call(insn) &&
+			if (!opts.no_fp && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -3415,7 +3415,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (backtrace)
+					if (opts.backtrace)
 						BT_FUNC("(branch)", insn);
 					return ret;
 				}
@@ -3427,7 +3427,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (sls && !insn->retpoline_safe &&
+			if (opts.sls && !insn->retpoline_safe &&
 			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after indirect jump",
 					  insn->sec, insn->offset);
@@ -3499,7 +3499,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 		}
 
-		if (ibt)
+		if (opts.ibt)
 			validate_ibt_insn(file, insn);
 
 		if (insn->dead_end)
@@ -3541,7 +3541,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited && !insn->ignore) {
 			ret = validate_branch(file, insn->func, insn, state);
-			if (ret && backtrace)
+			if (ret && opts.backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
@@ -3571,7 +3571,7 @@ static int validate_retpoline(struct objtool_file *file)
 		 * loaded late, they very much do need retpoline in their
 		 * .init.text
 		 */
-		if (!strcmp(insn->sec->name, ".init.text") && !module)
+		if (!strcmp(insn->sec->name, ".init.text") && !opts.module)
 			continue;
 
 		WARN_FUNC("indirect %s found in RETPOLINE build",
@@ -3621,7 +3621,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (!insn->func && lto) {
+	if (!insn->func && opts.lto) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3728,7 +3728,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn->func, insn, *state);
-	if (ret && backtrace)
+	if (ret && opts.backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
 }
@@ -3853,12 +3853,12 @@ int check(struct objtool_file *file)
 {
 	int ret, warnings = 0;
 
-	if (lto && !(vmlinux || module)) {
+	if (opts.lto && !(opts.vmlinux || opts.module)) {
 		fprintf(stderr, "--lto requires: --vmlinux or --module\n");
 		return 1;
 	}
 
-	if (ibt && !lto) {
+	if (opts.ibt && !opts.lto) {
 		fprintf(stderr, "--ibt requires: --lto\n");
 		return 1;
 	}
@@ -3883,7 +3883,7 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (vmlinux && !lto) {
+	if (opts.vmlinux && !opts.lto) {
 		ret = validate_vmlinux_functions(file);
 		if (ret < 0)
 			goto out;
@@ -3892,7 +3892,7 @@ int check(struct objtool_file *file)
 		goto out;
 	}
 
-	if (retpoline) {
+	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
 			return ret;
@@ -3909,7 +3909,7 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
-	if (ibt) {
+	if (opts.ibt) {
 		ret = validate_ibt(file);
 		if (ret < 0)
 			goto out;
@@ -3928,28 +3928,28 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
-	if (retpoline) {
+	if (opts.retpoline) {
 		ret = create_retpoline_sites_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
-	if (mcount) {
+	if (opts.mcount) {
 		ret = create_mcount_loc_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
-	if (ibt) {
+	if (opts.ibt) {
 		ret = create_ibt_endbr_seal_sections(file);
 		if (ret < 0)
 			goto out;
 		warnings += ret;
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
 		printf("nr_cfi_reused: %ld\n", nr_cfi_reused);
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index ebf2ba5..0f6fa37 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -355,7 +355,7 @@ static int read_sections(struct elf *elf)
 		elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("nr_sections: %lu\n", (unsigned long)sections_nr);
 		printf("section_bits: %d\n", elf->section_bits);
 	}
@@ -475,7 +475,7 @@ static int read_symbols(struct elf *elf)
 		elf_add_symbol(elf, sym);
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("nr_symbols: %lu\n", (unsigned long)symbols_nr);
 		printf("symbol_bits: %d\n", elf->symbol_bits);
 	}
@@ -843,7 +843,7 @@ static int read_relocs(struct elf *elf)
 		tot_reloc += nr_reloc;
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
 		printf("reloc_bits: %d\n", elf->reloc_bits);
@@ -1222,7 +1222,7 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	if (dryrun)
+	if (opts.dryrun)
 		return 0;
 
 	/* Update changed relocation sections and section headers: */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c39dbfa..87c1a73 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -8,9 +8,29 @@
 #include <subcmd/parse-options.h>
 
 extern const struct option check_options[];
-extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt;
+
+struct opts {
+	/* actions: */
+	bool ibt;
+	bool mcount;
+	bool noinstr;
+	bool retpoline;
+	bool sls;
+	bool uaccess;
+
+	/* options: */
+	bool backtrace;
+	bool backup;
+	bool dryrun;
+	bool lto;
+	bool module;
+	bool no_fp;
+	bool no_unreachable;
+	bool stats;
+	bool vmlinux;
+};
+
+extern struct opts opts;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index 843ff3c..a0f3d3c 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -118,7 +118,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	if (!file.elf)
 		return NULL;
 
-	if (backup && !objtool_create_backup(objname)) {
+	if (opts.backup && !objtool_create_backup(objname)) {
 		WARN("can't create backup file");
 		return NULL;
 	}
@@ -129,7 +129,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
-	file.ignore_unreachables = no_unreachable;
+	file.ignore_unreachables = opts.no_unreachable;
 	file.hints = false;
 
 	return &file;
@@ -137,7 +137,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 
 void objtool_pv_add(struct objtool_file *f, int idx, struct symbol *func)
 {
-	if (!noinstr)
+	if (!opts.noinstr)
 		return;
 
 	if (!f->pv_ops) {
