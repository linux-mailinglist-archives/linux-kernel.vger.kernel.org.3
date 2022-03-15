Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B644D991A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347243AbiCOKpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347215AbiCOKoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F972C11D;
        Tue, 15 Mar 2022 03:43:42 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeLfLsB7ZPSqJTiny4x2zsz/tukrYEvRYnQ6MpUOUUY=;
        b=Qs3CT4jkZ290ki+5Mq9NIYJyna+j2n6ih+xW28P8II3U+CF7leb3ym4I13suu5WpP0fs2Z
        GJwreB+HD1XBJoynmiWC/oK18wjS1v+1rt97V/cP5ObdHhqxZAWrHVOT/pB78nvOHNpOst
        dTbLHxO4Ex7p3mP1BNvwFWX5NKIHijnOx4SJCyY/2QQXHU4I5t7I9TPRhILxOkKkOZmPkz
        KhXS3u1E6+Ed3FDtlgRVXqd+w4FqB28MUoMwZLhSmLzwLRp+Voj9yXZsOAAZdicLgJrDrG
        jmByGxw54BXepRPqwv7M5UTrxzo6G7Rncf3oGjmKIfY4zGMbj/Wyq9BssUrfvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OeLfLsB7ZPSqJTiny4x2zsz/tukrYEvRYnQ6MpUOUUY=;
        b=Zz0rJJh3Ps9ZYstxgSbpsYgI+v0Lw560LCIY+VNe+xWYs5rfkskT9p9mBImVORxhKOS6le
        uVnfcDsoDvv/8uBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Validate IBT assumptions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.705110141@infradead.org>
References: <20220308154319.705110141@infradead.org>
MIME-Version: 1.0
Message-ID: <164734102036.16921.560415342975314707.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     08f87a93c8ec709698edba66a5167077181fc978
Gitweb:        https://git.kernel.org/tip/08f87a93c8ec709698edba66a5167077181fc978
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:46 +01:00

objtool: Validate IBT assumptions

Intel IBT requires that every indirect JMP/CALL targets an ENDBR
instructions, failing this #CP happens and we die. Similarly, all
exception entries should be ENDBR.

Find all code relocations and ensure they're either an ENDBR
instruction or ANNOTATE_NOENDBR. For the exceptions look for
UNWIND_HINT_IRET_REGS at sym+0 not being ENDBR.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.705110141@infradead.org
---
 tools/objtool/builtin-check.c           |   4 +-
 tools/objtool/check.c                   | 210 ++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |   3 +-
 tools/objtool/include/objtool/objtool.h |   3 +-
 4 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5c2fcaa..fc6975a 100644
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
 
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 6399394..d4cf831 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -418,8 +418,16 @@ static int decode_instructions(struct objtool_file *file)
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
 
@@ -1171,6 +1179,19 @@ static void add_retpoline_call(struct objtool_file *file, struct instruction *in
 
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
@@ -1251,8 +1272,8 @@ static int add_jump_destinations(struct objtool_file *file)
 				insn->func->cfunc = insn->jump_dest->func;
 				insn->jump_dest->func->pfunc = insn->func;
 
-			} else if (insn->jump_dest->func->pfunc != insn->func->pfunc &&
-				   insn->jump_dest->offset == insn->jump_dest->func->offset) {
+			} else if (!same_function(insn, insn->jump_dest) &&
+				   is_first_func_insn(insn->jump_dest)) {
 				/* internal sibling call (without reloc) */
 				add_call_dest(file, insn, insn->jump_dest->func, true);
 			}
@@ -1842,6 +1863,16 @@ static int read_unwind_hints(struct objtool_file *file)
 
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
@@ -1883,6 +1914,9 @@ static int read_noendbr_hints(struct objtool_file *file)
 			return -1;
 		}
 
+		if (insn->type == INSN_ENDBR)
+			WARN_FUNC("ANNOTATE_NOENDBR on ENDBR", insn->sec, insn->offset);
+
 		insn->noendbr = 1;
 	}
 
@@ -2122,6 +2156,9 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	/*
+	 * Must be before read_unwind_hints() since that needs insn->noendbr.
+	 */
 	ret = read_noendbr_hints(file);
 	if (ret)
 		return ret;
@@ -3063,6 +3100,111 @@ static struct instruction *next_insn_to_validate(struct objtool_file *file,
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
@@ -3272,6 +3414,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 		}
 
+		if (ibt)
+			validate_ibt_insn(file, insn);
+
 		if (insn->dead_end)
 			return 0;
 
@@ -3557,6 +3702,53 @@ static int validate_functions(struct objtool_file *file)
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
@@ -3584,6 +3776,11 @@ int check(struct objtool_file *file)
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
@@ -3630,6 +3827,13 @@ int check(struct objtool_file *file)
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
diff --git a/tools/objtool/include/objtool/builtin.h b/tools/objtool/include/objtool/builtin.h
index 0cbe739..c39dbfa 100644
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -9,7 +9,8 @@
 
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
-	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun;
+	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
+	    ibt;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index f99fbc6..fa3c7fa 100644
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
 
