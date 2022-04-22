Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0A650B53E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446650AbiDVKiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446700AbiDVKiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:38:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBA0D9A;
        Fri, 22 Apr 2022 03:35:06 -0700 (PDT)
Date:   Fri, 22 Apr 2022 10:35:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650623705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImXtbGWF3Uxkm3g5510jPVEIapKEf+4cmpOyztV/28k=;
        b=kKqNs96u49nOrvHxJ4a6p5/qpnENlW9hHjPTg2TbdcGBEpf/noA+OeTnl56SYZ4HiyfFHx
        gunsleuTiYjtSuAnw+DqhPtX1xqZiwXS34S9cKd0+xDAiZTkwiRPAtbmSVF+tuldcVFSMS
        SB3vPp1FznXscXT2mq7wQelzTtc7dNuFbjOrAvmv2742UydZK8LXFGhhrB+AUGXj/YgsGa
        6bQmHR5qgeYdfoS2j/Uj9Wb1pPYw0QpVq6BVB0lQp/Pzno7p0cby/Egr6nYTSrIXDFJJFd
        2rhstgqC9ppuJdVH+zl9FYlUmoV0+Vz/iBy2Dj13kRDP3wiExDAY6P9YQs6xIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650623705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ImXtbGWF3Uxkm3g5510jPVEIapKEf+4cmpOyztV/28k=;
        b=YP2xWYV5LwRBtFp5M6GI9SB9o1Mx3tcqrclnlVtXxw8M6fxL9eWYQqSWbG6Ri1GLiSSXqK
        CB9JD9J5Ig0PqzAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Rework ibt and extricate from stack validation
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
References: <fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <165062370439.4207.4600011103643495312.tip-bot2@tip-bot2>
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

Commit-ID:     3c6f9f77e6188ca4d283633d66e91b3821a505ae
Gitweb:        https://git.kernel.org/tip/3c6f9f77e6188ca4d283633d66e91b3821a505ae
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 18 Apr 2022 09:50:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Apr 2022 12:32:02 +02:00

objtool: Rework ibt and extricate from stack validation

Extricate ibt from validate_branch() so they can be executed (or ported)
independently from each other.

While shuffling code around, simplify and improve the ibt logic:

- Ignore an explicit list of known sections which reference functions
  for reasons other than indirect branching to them.  This helps prevent
  unnnecesary sealing.

- Warn on missing !ENDBR for all other sections, not just .data and
  .rodata.  This finds additional warnings, because there are sections
  other than .[ro]data which reference function pointers.  For example,
  the ksymtab sections which are used for exporting symbols.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lkml.kernel.org/r/fd1435e46bb95f81031b8fb1fa360f5f787e4316.1650300597.git.jpoimboe@redhat.com
---
 tools/objtool/check.c | 280 +++++++++++++++++++++--------------------
 1 file changed, 147 insertions(+), 133 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3456eb9..85c2888 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3182,114 +3182,6 @@ static struct instruction *next_insn_to_validate(struct objtool_file *file,
 	return next_insn_same_sec(file, insn);
 }
 
-static struct instruction *
-validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
-{
-	struct instruction *dest;
-	struct section *sec;
-	unsigned long off;
-
-	sec = reloc->sym->sec;
-	off = reloc->sym->offset;
-
-	if ((reloc->sec->base->sh.sh_flags & SHF_EXECINSTR) &&
-	    (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32))
-		off += arch_dest_reloc_offset(reloc->addend);
-	else
-		off += reloc->addend;
-
-	dest = find_insn(file, sec, off);
-	if (!dest)
-		return NULL;
-
-	if (dest->type == INSN_ENDBR) {
-		if (!list_empty(&dest->call_node))
-			list_del_init(&dest->call_node);
-
-		return NULL;
-	}
-
-	if (reloc->sym->static_call_tramp)
-		return NULL;
-
-	return dest;
-}
-
-static void warn_noendbr(const char *msg, struct section *sec, unsigned long offset,
-			 struct instruction *dest)
-{
-	WARN_FUNC("%srelocation to !ENDBR: %s", sec, offset, msg,
-		  offstr(dest->sec, dest->offset));
-}
-
-static void validate_ibt_dest(struct objtool_file *file, struct instruction *insn,
-			      struct instruction *dest)
-{
-	if (dest->func && dest->func == insn->func) {
-		/*
-		 * Anything from->to self is either _THIS_IP_ or IRET-to-self.
-		 *
-		 * There is no sane way to annotate _THIS_IP_ since the compiler treats the
-		 * relocation as a constant and is happy to fold in offsets, skewing any
-		 * annotation we do, leading to vast amounts of false-positives.
-		 *
-		 * There's also compiler generated _THIS_IP_ through KCOV and
-		 * such which we have no hope of annotating.
-		 *
-		 * As such, blanket accept self-references without issue.
-		 */
-		return;
-	}
-
-	if (dest->noendbr)
-		return;
-
-	warn_noendbr("", insn->sec, insn->offset, dest);
-}
-
-static void validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
-{
-	struct instruction *dest;
-	struct reloc *reloc;
-
-	switch (insn->type) {
-	case INSN_CALL:
-	case INSN_CALL_DYNAMIC:
-	case INSN_JUMP_CONDITIONAL:
-	case INSN_JUMP_UNCONDITIONAL:
-	case INSN_JUMP_DYNAMIC:
-	case INSN_JUMP_DYNAMIC_CONDITIONAL:
-	case INSN_RETURN:
-		/*
-		 * We're looking for code references setting up indirect code
-		 * flow. As such, ignore direct code flow and the actual
-		 * dynamic branches.
-		 */
-		return;
-
-	case INSN_NOP:
-		/*
-		 * handle_group_alt() will create INSN_NOP instruction that
-		 * don't belong to any section, ignore all NOP since they won't
-		 * carry a (useful) relocation anyway.
-		 */
-		return;
-
-	default:
-		break;
-	}
-
-	for (reloc = insn_reloc(file, insn);
-	     reloc;
-	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					      reloc->offset + 1,
-					      (insn->offset + insn->len) - (reloc->offset + 1))) {
-		dest = validate_ibt_reloc(file, reloc);
-		if (dest)
-			validate_ibt_dest(file, insn, dest);
-	}
-}
-
 /*
  * Follow the branch starting at the given instruction, and recursively follow
  * any other branches (jumps).  Meanwhile, track the frame pointer state at
@@ -3499,9 +3391,6 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 			break;
 		}
 
-		if (opts.ibt)
-			validate_ibt_insn(file, insn);
-
 		if (insn->dead_end)
 			return 0;
 
@@ -3787,48 +3676,173 @@ static int validate_functions(struct objtool_file *file)
 	return warnings;
 }
 
-static int validate_ibt(struct objtool_file *file)
+static void mark_endbr_used(struct instruction *insn)
 {
-	struct section *sec;
+	if (!list_empty(&insn->call_node))
+		list_del_init(&insn->call_node);
+}
+
+static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn)
+{
+	struct instruction *dest;
 	struct reloc *reloc;
+	unsigned long off;
+	int warnings = 0;
 
-	for_each_sec(file, sec) {
-		bool is_data;
+	/*
+	 * Looking for function pointer load relocations.  Ignore
+	 * direct/indirect branches:
+	 */
+	switch (insn->type) {
+	case INSN_CALL:
+	case INSN_CALL_DYNAMIC:
+	case INSN_JUMP_CONDITIONAL:
+	case INSN_JUMP_UNCONDITIONAL:
+	case INSN_JUMP_DYNAMIC:
+	case INSN_JUMP_DYNAMIC_CONDITIONAL:
+	case INSN_RETURN:
+	case INSN_NOP:
+		return 0;
+	default:
+		break;
+	}
 
-		/* already done in validate_branch() */
-		if (sec->sh.sh_flags & SHF_EXECINSTR)
-			continue;
+	for (reloc = insn_reloc(file, insn);
+	     reloc;
+	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
+					      reloc->offset + 1,
+					      (insn->offset + insn->len) - (reloc->offset + 1))) {
 
-		if (!sec->reloc)
+		/*
+		 * static_call_update() references the trampoline, which
+		 * doesn't have (or need) ENDBR.  Skip warning in that case.
+		 */
+		if (reloc->sym->static_call_tramp)
 			continue;
 
-		if (!strncmp(sec->name, ".orc", 4))
+		off = reloc->sym->offset;
+		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+			off += arch_dest_reloc_offset(reloc->addend);
+		else
+			off += reloc->addend;
+
+		dest = find_insn(file, reloc->sym->sec, off);
+		if (!dest)
 			continue;
 
-		if (!strncmp(sec->name, ".discard", 8))
+		if (dest->type == INSN_ENDBR) {
+			mark_endbr_used(dest);
 			continue;
+		}
 
-		if (!strncmp(sec->name, ".debug", 6))
+		if (dest->func && dest->func == insn->func) {
+			/*
+			 * Anything from->to self is either _THIS_IP_ or
+			 * IRET-to-self.
+			 *
+			 * There is no sane way to annotate _THIS_IP_ since the
+			 * compiler treats the relocation as a constant and is
+			 * happy to fold in offsets, skewing any annotation we
+			 * do, leading to vast amounts of false-positives.
+			 *
+			 * There's also compiler generated _THIS_IP_ through
+			 * KCOV and such which we have no hope of annotating.
+			 *
+			 * As such, blanket accept self-references without
+			 * issue.
+			 */
 			continue;
+		}
 
-		if (!strcmp(sec->name, "_error_injection_whitelist"))
+		if (dest->noendbr)
 			continue;
 
-		if (!strcmp(sec->name, "_kprobe_blacklist"))
+		WARN_FUNC("relocation to !ENDBR: %s",
+			  insn->sec, insn->offset,
+			  offstr(dest->sec, dest->offset));
+
+		warnings++;
+	}
+
+	return warnings;
+}
+
+static int validate_ibt_data_reloc(struct objtool_file *file,
+				   struct reloc *reloc)
+{
+	struct instruction *dest;
+
+	dest = find_insn(file, reloc->sym->sec,
+			 reloc->sym->offset + reloc->addend);
+	if (!dest)
+		return 0;
+
+	if (dest->type == INSN_ENDBR) {
+		mark_endbr_used(dest);
+		return 0;
+	}
+
+	if (dest->noendbr)
+		return 0;
+
+	WARN_FUNC("data relocation to !ENDBR: %s",
+		  reloc->sec->base, reloc->offset,
+		  offstr(dest->sec, dest->offset));
+
+	return 1;
+}
+
+/*
+ * Validate IBT rules and remove used ENDBR instructions from the seal list.
+ * Unused ENDBR instructions will be annotated for sealing (i.e., replaced with
+ * NOPs) later, in create_ibt_endbr_seal_sections().
+ */
+static int validate_ibt(struct objtool_file *file)
+{
+	struct section *sec;
+	struct reloc *reloc;
+	struct instruction *insn;
+	int warnings = 0;
+
+	for_each_insn(file, insn)
+		warnings += validate_ibt_insn(file, insn);
+
+	for_each_sec(file, sec) {
+
+		/* Already done by validate_ibt_insn() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			continue;
 
-		is_data = strstr(sec->name, ".data") || strstr(sec->name, ".rodata");
+		if (!sec->reloc)
+			continue;
 
-		list_for_each_entry(reloc, &sec->reloc->reloc_list, list) {
-			struct instruction *dest;
+		/*
+		 * These sections can reference text addresses, but not with
+		 * the intent to indirect branch to them.
+		 */
+		if (!strncmp(sec->name, ".discard", 8)			||
+		    !strncmp(sec->name, ".debug", 6)			||
+		    !strcmp(sec->name, ".altinstructions")		||
+		    !strcmp(sec->name, ".ibt_endbr_seal")		||
+		    !strcmp(sec->name, ".orc_unwind_ip")		||
+		    !strcmp(sec->name, ".parainstructions")		||
+		    !strcmp(sec->name, ".retpoline_sites")		||
+		    !strcmp(sec->name, ".smp_locks")			||
+		    !strcmp(sec->name, ".static_call_sites")		||
+		    !strcmp(sec->name, "_error_injection_whitelist")	||
+		    !strcmp(sec->name, "_kprobe_blacklist")		||
+		    !strcmp(sec->name, "__bug_table")			||
+		    !strcmp(sec->name, "__ex_table")			||
+		    !strcmp(sec->name, "__jump_table")			||
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    !strcmp(sec->name, "__tracepoints"))
+			continue;
 
-			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr)
-				warn_noendbr("data ", sec, reloc->offset, dest);
-		}
+		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
+			warnings += validate_ibt_data_reloc(file, reloc);
 	}
 
-	return 0;
+	return warnings;
 }
 
 static int validate_reachable_instructions(struct objtool_file *file)
@@ -3899,7 +3913,7 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
-	if (opts.stackval || opts.orc || opts.uaccess || opts.ibt || opts.sls) {
+	if (opts.stackval || opts.orc || opts.uaccess || opts.sls) {
 		ret = validate_functions(file);
 		if (ret < 0)
 			goto out;
