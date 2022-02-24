Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9DD4C2F62
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiBXPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbiBXPSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8120141FED
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pmljlO8GsrjkE9rNYNKJXjps/XRWHnHxEt2kCJ7xPCk=; b=XfE4zTJ98NxFqhKXJ289uq5BkI
        wSAk45JWo1ae/zy/MW0SqPA+yUIBXKddTXYj/ERIb7CPn3wxfNiSfWKv9lHs7XmzS4yCDFAZvAaXl
        KSFkRUwRbvs7KJ9Fj9apEK1TTsn3aq/8JhEPq3HF+TZmyr1vgXna+w3LtqXjMr9KYvY+jFN/kl/BJ
        zgDpyUFRsIkIwOaTrTa+TquOcbF5QHi8DxwLqxT2WOcTxaTOdD+6m/Zb1koVPbaw/V33Np/d0q+9D
        fqlq3xHvHWC9IE4cOwB82NtLmocWSQctHBuA/ggxCW+q6P3hm8JFq+QY6zy/i6gYKpeNgaRGVPwdF
        DzPhtkvg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-004s2P-F2; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51345302D9B;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A58C72B3547AB; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.018939604@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 34/39] objtool: Validate IBT assumptions
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel IBT requires that every indirect JMP/CALL targets an ENDBR
instructions, failing this #CP happens and we die. Similarly, all
exception entries should be ENDBR.

Find all code relocations and ensure they're either an ENDBR
instruction or ANNOTATE_NOENDBR. For the exceptions look for
UNWIND_HINT_IRET_REGS at sym+0 not being ENDBR.

Additionally, look for direct JMP/CALL instructions and warn if they
target an ENDBR instruction. This extra constraint comes from the
desire to poison unused ENDBR instructions.

NOTE: the changes in add_{call,jump}_destination() are to add a common
path after setting insn->{jump,call}_dest with both (source and
destination) instructions available.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c           |    4 
 tools/objtool/check.c                   |  255 +++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/builtin.h |    3 
 tools/objtool/include/objtool/objtool.h |    3 
 4 files changed, 243 insertions(+), 22 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -20,7 +20,8 @@
 #include <objtool/objtool.h>
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-     lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
+     lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
+     ibt;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -47,6 +48,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('B', "backup", &backup, "create .orig files before modification"),
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
+	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
 	OPT_END(),
 };
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -380,6 +380,7 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
+			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -1176,6 +1177,14 @@ static int add_jump_destinations(struct
 	unsigned long dest_off;
 
 	for_each_insn(file, insn) {
+		if (insn->type == INSN_ENDBR && insn->func) {
+			if (insn->offset == insn->func->offset) {
+				file->nr_endbr++;
+			} else {
+				file->nr_endbr_int++;
+			}
+		}
+
 		if (!is_static_jump(insn))
 			continue;
 
@@ -1192,10 +1201,14 @@ static int add_jump_destinations(struct
 		} else if (insn->func) {
 			/* internal or external sibling call (with reloc) */
 			add_call_dest(file, insn, reloc->sym, true);
-			continue;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
 		} else if (reloc->sym->sec->idx) {
 			dest_sec = reloc->sym->sec;
-			dest_off = reloc->sym->sym.st_value +
+			dest_off = reloc->sym->offset +
 				   arch_dest_reloc_offset(reloc->addend);
 		} else {
 			/* non-func asm code jumping to another file */
@@ -1205,6 +1218,10 @@ static int add_jump_destinations(struct
 		insn->jump_dest = find_insn(file, dest_sec, dest_off);
 		if (!insn->jump_dest) {
 
+			/* external symbol */
+			if (!vmlinux && insn->func)
+				continue;
+
 			/*
 			 * This is a special case where an alt instruction
 			 * jumps past the end of the section.  These are
@@ -1219,6 +1236,16 @@ static int add_jump_destinations(struct
 			return -1;
 		}
 
+		if (ibt && insn->jump_dest->type == INSN_ENDBR &&
+		    insn->jump_dest->func &&
+		    insn->jump_dest->offset == insn->jump_dest->func->offset) {
+			if (reloc) {
+				WARN_FUNC("Direct RELOC jump to ENDBR", insn->sec, insn->offset);
+			} else {
+				WARN_FUNC("Direct IMM jump to ENDBR", insn->sec, insn->offset);
+			}
+		}
+
 		/*
 		 * Cross-function jump.
 		 */
@@ -1246,7 +1273,8 @@ static int add_jump_destinations(struct
 				insn->jump_dest->func->pfunc = insn->func;
 
 			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+				   ((insn->jump_dest->offset == insn->jump_dest->func->offset) ||
+				    (insn->jump_dest->offset == insn->jump_dest->func->offset + 4))) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
@@ -1256,23 +1284,12 @@ static int add_jump_destinations(struct
 	return 0;
 }
 
-static struct symbol *find_call_destination(struct section *sec, unsigned long offset)
-{
-	struct symbol *call_dest;
-
-	call_dest = find_func_by_offset(sec, offset);
-	if (!call_dest)
-		call_dest = find_symbol_by_offset(sec, offset);
-
-	return call_dest;
-}
-
 /*
  * Find the destination instructions for all calls.
  */
 static int add_call_destinations(struct objtool_file *file)
 {
-	struct instruction *insn;
+	struct instruction *insn, *target = NULL;
 	unsigned long dest_off;
 	struct symbol *dest;
 	struct reloc *reloc;
@@ -1284,7 +1301,21 @@ static int add_call_destinations(struct
 		reloc = insn_reloc(file, insn);
 		if (!reloc) {
 			dest_off = arch_jump_destination(insn);
-			dest = find_call_destination(insn->sec, dest_off);
+
+			target = find_insn(file, insn->sec, dest_off);
+			if (!target) {
+				WARN_FUNC("direct call to nowhere", insn->sec, insn->offset);
+				return -1;
+			}
+			dest = target->func;
+			if (!dest)
+				dest = find_symbol_containing(insn->sec, dest_off);
+			if (!dest) {
+				WARN_FUNC("IMM can't find call dest symbol at %s+0x%lx",
+					  insn->sec, insn->offset,
+					  insn->sec->name, dest_off);
+				return -1;
+			}
 
 			add_call_dest(file, insn, dest, false);
 
@@ -1303,10 +1334,22 @@ static int add_call_destinations(struct
 			}
 
 		} else if (reloc->sym->type == STT_SECTION) {
-			dest_off = arch_dest_reloc_offset(reloc->addend);
-			dest = find_call_destination(reloc->sym->sec, dest_off);
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
+			if (!target) {
+				WARN_FUNC("direct call to nowhere", insn->sec, insn->offset);
+				return -1;
+			}
+			dest = target->func;
+			if (!dest)
+				dest = find_symbol_containing(dest_sec, dest_off);
 			if (!dest) {
-				WARN_FUNC("can't find call dest symbol at %s+0x%lx",
+				WARN_FUNC("RELOC can't find call dest symbol at %s+0x%lx",
 					  insn->sec, insn->offset,
 					  reloc->sym->sec->name,
 					  dest_off);
@@ -1317,9 +1360,27 @@ static int add_call_destinations(struct
 
 		} else if (reloc->sym->retpoline_thunk) {
 			add_retpoline_call(file, insn);
+			continue;
+
+		} else {
+			struct section *dest_sec;
+
+			dest_sec = reloc->sym->sec;
+			dest_off = reloc->sym->offset +
+				   arch_dest_reloc_offset(reloc->addend);
+
+			target = find_insn(file, dest_sec, dest_off);
 
-		} else
 			add_call_dest(file, insn, reloc->sym, false);
+		}
+
+		if (ibt && target && target->type == INSN_ENDBR) {
+			if (reloc) {
+				WARN_FUNC("Direct RELOC call to ENDBR", insn->sec, insn->offset);
+			} else {
+				WARN_FUNC("Direct IMM call to ENDBR", insn->sec, insn->offset);
+			}
+		}
 	}
 
 	return 0;
@@ -3053,6 +3114,8 @@ static struct instruction *next_insn_to_
 	return next_insn_same_sec(file, insn);
 }
 
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn);
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3101,6 +3164,17 @@ static int validate_branch(struct objtoo
 
 		if (insn->hint) {
 			state.cfi = *insn->cfi;
+			if (ibt) {
+				struct symbol *sym;
+
+				if (insn->cfi->type == UNWIND_HINT_TYPE_REGS_PARTIAL &&
+				    (sym = find_symbol_by_offset(insn->sec, insn->offset)) &&
+				    insn->type != INSN_ENDBR && !insn->noendbr) {
+					WARN_FUNC("IRET_REGS hint without ENDBR: %s",
+						  insn->sec, insn->offset,
+						  sym->name);
+				}
+			}
 		} else {
 			/* XXX track if we actually changed state.cfi */
 
@@ -3260,7 +3334,12 @@ static int validate_branch(struct objtoo
 			state.df = false;
 			break;
 
+		case INSN_NOP:
+			break;
+
 		default:
+			if (ibt)
+				validate_ibt_insn(file, insn);
 			break;
 		}
 
@@ -3506,6 +3585,130 @@ static int validate_functions(struct obj
 	return warnings;
 }
 
+static struct instruction *
+validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
+{
+	struct instruction *dest;
+	struct section *sec;
+	unsigned long off;
+
+	sec = reloc->sym->sec;
+	off = reloc->sym->offset + reloc->addend;
+
+	dest = find_insn(file, sec, off);
+	if (!dest)
+		return NULL;
+
+	if (dest->type == INSN_ENDBR)
+		return NULL;
+
+	if (reloc->sym->static_call_tramp)
+		return NULL;
+
+	return dest;
+}
+
+static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
+			 struct instruction *target)
+{
+	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
+		  target->func ? target->func->name : target->sec->name,
+		  target->func ? target->offset - target->func->offset : target->offset);
+}
+
+static void validate_ibt_target(struct objtool_file *file, struct instruction *insn,
+				struct instruction *target)
+{
+	if (target->func && target->func == insn->func) {
+		/*
+		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
+		 *
+		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
+		 * relocation as a constant and is happy to fold in offsets, skewing any
+		 * annotation we do, leading to vast amounts of false-positives.
+		 *
+		 * There's also compiler generated _THIS_IP_ through KCOV and
+		 * such which we have no hope of annotating.
+		 *
+		 * As such, blanked accept self-references without issue.
+		 */
+		return;
+	}
+
+	/*
+	 * Annotated non-control flow target.
+	 */
+	if (target->noendbr)
+		return;
+
+	warn_noendbr("", insn->sec, insn->offset, target);
+}
+
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct reloc *reloc = insn_reloc(file, insn);
+	struct instruction *target;
+
+	for (;;) {
+		if (!reloc)
+			return;
+
+		target = validate_ibt_reloc(file, reloc);
+		if (target)
+			validate_ibt_target(file, insn, target);
+
+		reloc = find_reloc_by_dest_range(file->elf, insn->sec, reloc->offset + 1,
+						 (insn->offset + insn->len) - (reloc->offset + 1));
+	}
+}
+
+static int validate_ibt(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+
+	for_each_sec(file, sec) {
+		bool is_data;
+
+		/* already done in validate_branch() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
+			continue;
+
+		if (!sec->reloc)
+			continue;
+
+		if (!strncmp(sec->name, ".orc", 4))
+			continue;
+
+		if (!strncmp(sec->name, ".discard", 8))
+			continue;
+
+		if (!strncmp(sec->name, ".debug", 6))
+			continue;
+
+		if (!strcmp(sec->name, "_error_injection_whitelist"))
+			continue;
+
+		if (!strcmp(sec->name, "_kprobe_blacklist"))
+			continue;
+
+		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
+
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
+			struct instruction *target;
+
+			target = validate_ibt_reloc(file, reloc);
+			if (is_data && target && !target->noendbr) {
+				warn_noendbr("data ", reloc->sym->sec,
+					     reloc->sym->offset + reloc->addend,
+					     target);
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn;
@@ -3533,6 +3736,11 @@ int check(struct objtool_file *file)
 		return 1;
 	}
 
+	if (ibt && !lto) {
+		fprintf(stderr, "--ibt requires: --lto\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3579,6 +3787,13 @@ int check(struct objtool_file *file)
 		goto out;
 	warnings += ret;
 
+	if (ibt) {
+		ret = validate_ibt(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (!warnings) {
 		ret = validate_reachable_instructions(file);
 		if (ret < 0)
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,8 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
+	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
+	    ibt;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -28,6 +28,9 @@ struct objtool_file {
 	struct list_head mcount_loc_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 
+	unsigned int nr_endbr;
+	unsigned int nr_endbr_int;
+
 	unsigned long jl_short, jl_long;
 	unsigned long jl_nop_short, jl_nop_long;
 


