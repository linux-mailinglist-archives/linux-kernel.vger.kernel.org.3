Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68CA500288
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 01:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiDMXY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 19:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbiDMXWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 19:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C59D3A5D1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649892010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ychhaRzz2uHI/l+EWy0iFhYfdo18db/Qi9v32WYip94=;
        b=GzOQS1LvYqnLbc+mt6hj3tLJh9zWOeV7YNhMBLnJ/OwmQvlpibPzsIOCqVgeimwWoIS7vP
        lwlugJHXZKwaBn/5p9tiZsTezpZsPzQSa+XbXQjEZv6khaMDrCg7j4ZKU01BVXDKi+Qg04
        urSDg/HQ6kgcLLJT/ywN3T7w31yWvi8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-250-DVus8TnFMeeqAwHXQByseQ-1; Wed, 13 Apr 2022 19:20:09 -0400
X-MC-Unique: DVus8TnFMeeqAwHXQByseQ-1
Received: by mail-qk1-f199.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso2165991qkl.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 16:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ychhaRzz2uHI/l+EWy0iFhYfdo18db/Qi9v32WYip94=;
        b=UPflxhrZjHWyjq1M7uxZN54ZuKsC+fOISBpVPZY3xrSWIj41jcs1h7oMHzxlzbFSy7
         4xGvlRm5W4BWDHCZW/iRbxHccBkm5944hA1R5fsGg87cP6T73paybFpe7orWvEZpjriG
         qqf5ypeD9o4PcjqXellmuykvrze+JIFMHsNmhvBd4JJ1y46mrTXHOqdyk3ZSXJQjn8EJ
         53Da4vqXjCoVK/OneLAQE1YYJvrZ43aqh/bRs7XKhl85z4K7z3OSfOWl69af0PCQFLFv
         eS34PavjscD36UqemT+Vyea/dbc5k+eCOQ4QJGxBEfr22/dmCImhWGcYXvYvYjn1cRIN
         X7qg==
X-Gm-Message-State: AOAM531I0NcEVmv+yzvdHk2/FTCiMZEywtCEB4qoHuC1fvXb00FGUtFr
        i9P2iqg6GJuj5Ggkw5VuFwCwcFZ9alnYQ+QF7OezgV5Fcbwo1snih5YFUMjz63sE+T7Oa0xzjL2
        sc0HQMbuj6qyPjwC+iwq+chOZ
X-Received: by 2002:a05:6214:21ad:b0:444:3de0:148c with SMTP id t13-20020a05621421ad00b004443de0148cmr1048700qvc.119.1649892008659;
        Wed, 13 Apr 2022 16:20:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjgHCMnYGzKJl9ADv96L9Xgz0T1Mo2xZEQCVbid6X7kYJ/KAendvokv9sGhAiGbhln4zYrTg==
X-Received: by 2002:a05:6214:21ad:b0:444:3de0:148c with SMTP id t13-20020a05621421ad00b004443de0148cmr1048679qvc.119.1649892008340;
        Wed, 13 Apr 2022 16:20:08 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id b20-20020a05622a021400b002f08f5658a2sm193925qtx.68.2022.04.13.16.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 16:20:07 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 07/18] objtool: Reorganize cmdline options
Date:   Wed, 13 Apr 2022 16:19:42 -0700
Message-Id: <fef7a0e4fd371c152d268ec9472815c34193a626.1649891421.git.jpoimboe@redhat.com>
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
---
 scripts/Makefile.build                  | 10 ++--
 scripts/link-vmlinux.sh                 | 30 +++++++-----
 tools/objtool/arch/x86/decode.c         |  2 +-
 tools/objtool/arch/x86/special.c        |  2 +-
 tools/objtool/builtin-check.c           | 40 ++++++++--------
 tools/objtool/check.c                   | 62 ++++++++++++-------------
 tools/objtool/elf.c                     |  8 ++--
 tools/objtool/include/objtool/builtin.h | 26 +++++++++--
 tools/objtool/objtool.c                 |  6 +--
 9 files changed, 108 insertions(+), 78 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 33c1ed581522..dd9d582808d6 100644
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
index 9361a1ef02c9..c6e9fef61b11 100755
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
index 943cb41cddf7..8b990a52aada 100644
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
index e707d9bcd161..7c97b7391279 100644
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
index fc6975ab8b06..4f4a087720b3 100644
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
+	OPT_BOOLEAN('S', "sls", &opts.sls, "validate straight-line-speculation mitigations"),
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
index b27c2ce5d79e..5059c097c563 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -274,7 +274,7 @@ static void init_insn_state(struct insn_state *state, struct section *sec)
 	 * not correctly determine insn->call_dest->sec (external symbols do
 	 * not have a section).
 	 */
-	if (vmlinux && noinstr && sec)
+	if (opts.vmlinux && opts.noinstr && sec)
 		state->noinstr = sec->noinstr;
 }
 
@@ -340,7 +340,7 @@ static void *cfi_hash_alloc(unsigned long size)
 	if (cfi_hash == (void *)-1L) {
 		WARN("mmap fail cfi_hash");
 		cfi_hash = NULL;
-	}  else if (stats) {
+	}  else if (opts.stats) {
 		printf("cfi_bits: %d\n", cfi_bits);
 	}
 
@@ -435,7 +435,7 @@ static int decode_instructions(struct objtool_file *file)
 		}
 	}
 
-	if (stats)
+	if (opts.stats)
 		printf("nr_insns: %lu\n", nr_insns);
 
 	return 0;
@@ -498,7 +498,7 @@ static int init_pv_ops(struct objtool_file *file)
 	struct symbol *sym;
 	int idx, nr;
 
-	if (!noinstr)
+	if (!opts.noinstr)
 		return 0;
 
 	file->pv_ops = NULL;
@@ -669,7 +669,7 @@ static int create_static_call_sections(struct objtool_file *file)
 
 		key_sym = find_symbol_by_name(file->elf, tmp);
 		if (!key_sym) {
-			if (!module) {
+			if (!opts.module) {
 				WARN("static_call: can't find static_call_key symbol: %s", tmp);
 				return -1;
 			}
@@ -762,7 +762,7 @@ static int create_ibt_endbr_seal_sections(struct objtool_file *file)
 	list_for_each_entry(insn, &file->endbr_list, call_node)
 		idx++;
 
-	if (stats) {
+	if (opts.stats) {
 		printf("ibt: ENDBR at function start: %d\n", file->nr_endbr);
 		printf("ibt: ENDBR inside functions:  %d\n", file->nr_endbr_int);
 		printf("ibt: superfluous ENDBR:       %d\n", idx);
@@ -1029,7 +1029,7 @@ static void add_uaccess_safe(struct objtool_file *file)
 	struct symbol *func;
 	const char **name;
 
-	if (!uaccess)
+	if (!opts.uaccess)
 		return;
 
 	for (name = uaccess_safe_builtin; *name; name++) {
@@ -1171,7 +1171,7 @@ static void annotate_call_site(struct objtool_file *file,
 		return;
 	}
 
-	if (mcount && sym->fentry) {
+	if (opts.mcount && sym->fentry) {
 		if (sibling)
 			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);
 
@@ -1257,7 +1257,7 @@ static bool is_first_func_insn(struct objtool_file *file, struct instruction *in
 	if (insn->offset == insn->func->offset)
 		return true;
 
-	if (ibt) {
+	if (opts.ibt) {
 		struct instruction *prev = prev_insn_same_sym(file, insn);
 
 		if (prev && prev->type == INSN_ENDBR &&
@@ -1700,7 +1700,7 @@ static int add_special_section_alts(struct objtool_file *file)
 		free(special_alt);
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("jl\\\tNOP\tJMP\n");
 		printf("short:\t%ld\t%ld\n", file->jl_nop_short, file->jl_short);
 		printf("long:\t%ld\t%ld\n", file->jl_nop_long, file->jl_long);
@@ -1946,7 +1946,7 @@ static int read_unwind_hints(struct objtool_file *file)
 
 		insn->hint = true;
 
-		if (ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
+		if (opts.ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
 			struct symbol *sym = find_symbol_by_offset(insn->sec, insn->offset);
 
 			if (sym && sym->bind == STB_GLOBAL &&
@@ -2807,7 +2807,7 @@ static int update_cfi_state(struct instruction *insn,
 		}
 
 		/* detect when asm code uses rbp as a scratch register */
-		if (!no_fp && insn->func && op->src.reg == CFI_BP &&
+		if (!opts.no_fp && insn->func && op->src.reg == CFI_BP &&
 		    cfa->base != CFI_BP)
 			cfi->bp_scratch = true;
 		break;
@@ -3364,7 +3364,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 
 				ret = validate_branch(file, func, alt->insn, state);
 				if (ret) {
-					if (backtrace)
+					if (opts.backtrace)
 						BT_FUNC("(alt)", insn);
 					return ret;
 				}
@@ -3380,7 +3380,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		switch (insn->type) {
 
 		case INSN_RETURN:
-			if (sls && !insn->retpoline_safe &&
+			if (opts.sls && !insn->retpoline_safe &&
 			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after ret",
 					  insn->sec, insn->offset);
@@ -3393,7 +3393,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			if (ret)
 				return ret;
 
-			if (!no_fp && func && !is_fentry_call(insn) &&
+			if (!opts.no_fp && func && !is_fentry_call(insn) &&
 			    !has_valid_stack_frame(&state)) {
 				WARN_FUNC("call without frame pointer save/setup",
 					  sec, insn->offset);
@@ -3416,7 +3416,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 				ret = validate_branch(file, func,
 						      insn->jump_dest, state);
 				if (ret) {
-					if (backtrace)
+					if (opts.backtrace)
 						BT_FUNC("(branch)", insn);
 					return ret;
 				}
@@ -3428,7 +3428,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 
 		case INSN_JUMP_DYNAMIC:
-			if (sls && !insn->retpoline_safe &&
+			if (opts.sls && !insn->retpoline_safe &&
 			    next_insn && next_insn->type != INSN_TRAP) {
 				WARN_FUNC("missing int3 after indirect jump",
 					  insn->sec, insn->offset);
@@ -3500,7 +3500,7 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 		}
 
-		if (ibt)
+		if (opts.ibt)
 			validate_ibt_insn(file, insn);
 
 		if (insn->dead_end)
@@ -3542,7 +3542,7 @@ static int validate_unwind_hints(struct objtool_file *file, struct section *sec)
 	while (&insn->list != &file->insn_list && (!sec || insn->sec == sec)) {
 		if (insn->hint && !insn->visited && !insn->ignore) {
 			ret = validate_branch(file, insn->func, insn, state);
-			if (ret && backtrace)
+			if (ret && opts.backtrace)
 				BT_FUNC("<=== (hint)", insn);
 			warnings += ret;
 		}
@@ -3572,7 +3572,7 @@ static int validate_retpoline(struct objtool_file *file)
 		 * loaded late, they very much do need retpoline in their
 		 * .init.text
 		 */
-		if (!strcmp(insn->sec->name, ".init.text") && !module)
+		if (!strcmp(insn->sec->name, ".init.text") && !opts.module)
 			continue;
 
 		WARN_FUNC("indirect %s found in RETPOLINE build",
@@ -3622,7 +3622,7 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	 * In this case we'll find a piece of code (whole function) that is not
 	 * covered by a !section symbol. Ignore them.
 	 */
-	if (!insn->func && lto) {
+	if (!insn->func && opts.lto) {
 		int size = find_symbol_hole_containing(insn->sec, insn->offset);
 		unsigned long end = insn->offset + size;
 
@@ -3729,7 +3729,7 @@ static int validate_symbol(struct objtool_file *file, struct section *sec,
 	state->uaccess = sym->uaccess_safe;
 
 	ret = validate_branch(file, insn->func, insn, *state);
-	if (ret && backtrace)
+	if (ret && opts.backtrace)
 		BT_FUNC("<=== (sym)", insn);
 	return ret;
 }
@@ -3854,12 +3854,12 @@ int check(struct objtool_file *file)
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
@@ -3884,7 +3884,7 @@ int check(struct objtool_file *file)
 	if (list_empty(&file->insn_list))
 		goto out;
 
-	if (vmlinux && !lto) {
+	if (opts.vmlinux && !opts.lto) {
 		ret = validate_vmlinux_functions(file);
 		if (ret < 0)
 			goto out;
@@ -3893,7 +3893,7 @@ int check(struct objtool_file *file)
 		goto out;
 	}
 
-	if (retpoline) {
+	if (opts.retpoline) {
 		ret = validate_retpoline(file);
 		if (ret < 0)
 			return ret;
@@ -3910,7 +3910,7 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
-	if (ibt) {
+	if (opts.ibt) {
 		ret = validate_ibt(file);
 		if (ret < 0)
 			goto out;
@@ -3929,28 +3929,28 @@ int check(struct objtool_file *file)
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
index d7b99a737496..f7b2ad27bb1c 100644
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
@@ -700,7 +700,7 @@ static int read_relocs(struct elf *elf)
 		tot_reloc += nr_reloc;
 	}
 
-	if (stats) {
+	if (opts.stats) {
 		printf("max_reloc: %lu\n", max_reloc);
 		printf("tot_reloc: %lu\n", tot_reloc);
 		printf("reloc_bits: %d\n", elf->reloc_bits);
@@ -1079,7 +1079,7 @@ int elf_write(struct elf *elf)
 	struct section *sec;
 	Elf_Scn *s;
 
-	if (dryrun)
+	if (opts.dryrun)
 		return 0;
 
 	/* Update changed relocation sections and section headers: */
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index c39dbfaef6dc..87c1a7351e3c 100644
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
index 843ff3c2f28e..a0f3d3c9558d 100644
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
-- 
2.34.1

