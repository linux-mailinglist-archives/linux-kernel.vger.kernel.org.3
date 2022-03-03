Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31524CBC9C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbiCCLbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbiCCLbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D1F1795FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=s8UEKus7hfhygQm3RJZysk5Va+U3e0y1gd6XWgrv9ag=; b=oZ+m956DnLZd/fAD4HIOHnNM9I
        0OXWUvDeFZ8LfJhNwVNVgP1mTs/Mz+YrkEYaDHLEvsn5FyMUgLAw0ZbsAnWESYsiUtzAq55uBDMjy
        49Kw3Y64ma6exsE/6weozgln1Uzc2+xkoS+gh9Ss6XDGtKhHmPyGjBI6vSdlpshfcw47vx8Nay4dM
        zzKZ4HEm8e9mD2mQ/67BBmZeKO3SumkjH1bWglj4O3b3BrSiF6I+EIX4qxVmonPcF4mJStDZlqXBn
        eAJWzgVrED70c+gWSYbp5iBqudDiU4NZSh1/KT51yVndnpC1jyEC/0x9aIixZ3K0OBBEdo5/ewO8I
        89U1zrQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00BaHC-8X; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 13C6C302DD5;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A6FE83012B08B; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.151161893@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 36/39] objtool: Validate IBT assumptions
References: <20220303112321.422525803@infradead.org>
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

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c           |    4 
 tools/objtool/check.c                   |  210 +++++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |    3 
 tools/objtool/include/objtool/objtool.h |    3 
 4 files changed, 215 insertions(+), 5 deletions(-)

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
@@ -407,8 +407,16 @@ static int decode_instructions(struct ob
 				return -1;
 			}
 
-			sym_for_each_insn(file, func, insn)
+			sym_for_each_insn(file, func, insn) {
 				insn->func = func;
+				if (insn->type == INSN_ENDBR) {
+					if (insn->offset == insn->func->offset) {
+						file->nr_endbr++;
+					} else {
+						file->nr_endbr_int++;
+					}
+				}
+			}
 		}
 	}
 
@@ -1165,6 +1173,19 @@ static void add_retpoline_call(struct ob
 
 	annotate_call_site(file, insn, false);
 }
+
+static bool same_function(struct instruction *insn1, struct instruction *insn2)
+{
+	return insn1->func->pfunc == insn2->func->pfunc;
+}
+
+static bool is_first_func_insn(struct instruction *insn)
+{
+	return insn->offset == insn->func->offset ||
+	       (insn->type == INSN_ENDBR &&
+		insn->offset == insn->func->offset + insn->len);
+}
+
 /*
  * Find the destination instructions for all jumps.
  */
@@ -1245,8 +1266,8 @@ static int add_jump_destinations(struct
 				insn->func->cfunc = insn->jump_dest->func;
 				insn->jump_dest->func->pfunc = insn->func;
 
-			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+			} else if (!same_function(insn, insn->jump_dest) &&
+				   is_first_func_insn(insn->jump_dest)) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
@@ -1836,6 +1857,16 @@ static int read_unwind_hints(struct objt
 
 		insn->hint = true;
 
+		if (ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
+			struct symbol *sym = find_symbol_by_offset(insn->sec, insn->offset);
+
+			if (sym && sym->bind == STB_GLOBAL &&
+			    insn->type != INSN_ENDBR && !insn->noendbr) {
+				WARN_FUNC("UNWIND_HINT_IRET_REGS without ENDBR",
+					  insn->sec, insn->offset);
+			}
+		}
+
 		if (hint->type == UNWIND_HINT_TYPE_FUNC) {
 			insn->cfi = &func_cfi;
 			continue;
@@ -1877,6 +1908,9 @@ static int read_noendbr_hints(struct obj
 			return -1;
 		}
 
+		if (insn->type == INSN_ENDBR)
+			WARN_FUNC("ANNOTATE_NOENDBR on ENDBR", insn->sec, insn->offset);
+
 		insn->noendbr = 1;
 	}
 
@@ -2120,6 +2154,9 @@ static int decode_sections(struct objtoo
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before read_unwind_hints() since that needs insn->noendbr.
+	 */
 	ret = read_noendbr_hints(file);
 	if (ret)
 		return ret;
@@ -3053,6 +3090,111 @@ static struct instruction *next_insn_to_
 	return next_insn_same_sec(file, insn);
 }
 
+static struct instruction *
+validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
+{
+	struct instruction *dest;
+	struct section *sec;
+	unsigned long off;
+
+	sec = reloc->sym->sec;
+	off = reloc->sym->offset;
+
+	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
+	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
+		off += arch_dest_reloc_offset(reloc->addend);
+	else
+		off += reloc->addend;
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
+			 struct instruction *dest)
+{
+	WARN_FUNC("%srelocation to !ENDBR: %s+0x%lx", sec, offset, msg,
+		  dest->func ? dest->func->name : dest->sec->name,
+		  dest->func ? dest->offset - dest->func->offset : dest->offset);
+}
+
+static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
+			      struct instruction *dest)
+{
+	if (dest->func && dest->func == insn->func) {
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
+		 * As such, blanket accept self-references without issue.
+		 */
+		return;
+	}
+
+	if (dest->noendbr)
+		return;
+
+	warn_noendbr("", insn->sec, insn->offset, dest);
+}
+
+static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct instruction *dest;
+	struct reloc *reloc;
+
+	switch (insn->type) {
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+	case INSN_JUMP_DYNAMIC:
+	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+	case INSN_RETURN:
+		/*
+		 * We're looking for code references setting up indirect code
+		 * flow. As such, ignore direct code flow and the actual
+		 * dynamic branches.
+		 */
+		return;
+
+	case INSN_NOP:
+		/*
+		 * handle_group_alt() will create INSN_NOP instruction that
+		 * don't belong to any section, ignore all NOP since they won't
+		 * carry a (useful) relocation anyway.
+		 */
+		return;
+
+	default:
+		break;
+	}
+
+	for (reloc = insn_reloc(file, insn);
+	     reloc;
+	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					      reloc->offset + 1,
+					      (insn->offset + insn->len) - (reloc->offset + 1))) {
+		dest = validate_ibt_reloc(file, reloc);
+		if (dest)
+			validate_ibt_dest(file, insn, dest);
+	}
+}
+
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3264,6 +3406,9 @@ static int validate_branch(struct objtoo
 			break;
 		}
 
+		if (ibt)
+			validate_ibt_insn(file, insn);
+
 		if (insn->dead_end)
 			return 0;
 
@@ -3506,6 +3651,53 @@ static int validate_functions(struct obj
 	return warnings;
 }
 
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
+			struct instruction *dest;
+
+			dest = validate_ibt_reloc(file, reloc);
+			if (is_data && dest && !dest->noendbr) {
+				warn_noendbr("data ", reloc->sym->sec,
+					     reloc->sym->offset + reloc->addend,
+					     dest);
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
@@ -3533,6 +3725,11 @@ int check(struct objtool_file *file)
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
@@ -3579,6 +3776,13 @@ int check(struct objtool_file *file)
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
 


