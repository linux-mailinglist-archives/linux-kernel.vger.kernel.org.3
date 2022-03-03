Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E054CBCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiCCLd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD8F17CC4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=6LYv8z1P2TeT6PK13PfrXbItNpDm78oXk5ltG6J3AXc=; b=YNd74qxIE/PrSWGebPZ5xAWiQg
        5//2LH5IRa4Vt6u4D/MWwGVysfrWEFkV6Xmydn0AAX/Z/9JAQLRyazASIs3voEtjEArwi9x4ewcZF
        B4ZYxWVMYWQ8q1BgpOHESVRY8woD5+UavRKEkg5NvrPiPgkWaVh3XzUuKyCTZG2K1cc97v9bBfZSJ
        beCNtl2zxW8XJriCzDm8iYF/xgx2hOX/Lkr0PjzokE/12ZYySkVQTv1WUlQeit+vM+4kJaPn+yTJO
        que5noppdNHrMM9l55ABh+DLgRFZolHbbR6B3ifSrjBPZm5/nrwkJPV7PHJdLowm90O5KW/s8tB7c
        USJ2J+Vw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00Etpx-Oo; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1602B302DD6;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AB4943012BCD3; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.210703687@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 37/39] objtool: Optionally WARN about unused ANNOTATE_NOENDBR
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

Separate option because this option is somewhat prone to false
positives since a bunch of symbols/annotations are not correctly
#ifdef'ed, presumably to avoid clutter.

Can be manually ran on allmodconfig builds using OBJTOOL_ARGS.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/builtin-check.c           |    3 +-
 tools/objtool/check.c                   |   45 +++++++++++++++++++++++++++++---
 tools/objtool/include/objtool/builtin.h |    2 -
 tools/objtool/include/objtool/check.h   |    3 +-
 4 files changed, 46 insertions(+), 7 deletions(-)

--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -21,7 +21,7 @@
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
      lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt;
+     ibt, ibt_warn;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -49,6 +49,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN('S', "sls", &sls, "validate straight-line-speculation"),
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
+	OPT_BOOLEAN(0, "ibt-warn", &ibt_warn, "warn about unused ANNOTATE_ENDBR"),
 	OPT_END(),
 };
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1814,6 +1814,19 @@ static void set_func_state(struct cfi_st
 	state->stack_size = initial_func_cfi.cfa.offset;
 }
 
+static bool insn_is_endbr(struct instruction *insn)
+{
+	if (insn->type == INSN_ENDBR)
+		return true;
+
+	if (insn->noendbr) {
+		insn->noendbr_hit = 1;
+		return true;
+	}
+
+	return false;
+}
+
 static int read_unwind_hints(struct objtool_file *file)
 {
 	struct cfi_state cfi = init_cfi;
@@ -1860,8 +1873,7 @@ static int read_unwind_hints(struct objt
 		if (ibt && hint->type == UNWIND_HINT_TYPE_REGS_PARTIAL) {
 			struct symbol *sym = find_symbol_by_offset(insn->sec, insn->offset);
 
-			if (sym && sym->bind == STB_GLOBAL &&
-			    insn->type != INSN_ENDBR && !insn->noendbr) {
+			if (sym && sym->bind == STB_GLOBAL && !insn_is_endbr(insn)) {
 				WARN_FUNC("UNWIND_HINT_IRET_REGS without ENDBR",
 					  insn->sec, insn->offset);
 			}
@@ -3146,7 +3158,7 @@ static void validate_ibt_dest(struct obj
 		return;
 	}
 
-	if (dest->noendbr)
+	if (insn_is_endbr(dest))
 		return;
 
 	warn_noendbr("", insn->sec, insn->offset, dest);
@@ -3687,7 +3699,7 @@ static int validate_ibt(struct objtool_f
 			struct instruction *dest;
 
 			dest = validate_ibt_reloc(file, reloc);
-			if (is_data && dest && !dest->noendbr) {
+			if (is_data && dest && !insn_is_endbr(dest)) {
 				warn_noendbr("data ", reloc->sym->sec,
 					     reloc->sym->offset + reloc->addend,
 					     dest);
@@ -3695,6 +3707,31 @@ static int validate_ibt(struct objtool_f
 		}
 	}
 
+	if (ibt_warn) {
+		struct symbol *hypercall_page = find_symbol_by_name(file->elf, "hypercall_page");
+		struct instruction *insn;
+
+		for_each_insn(file, insn) {
+			if (!insn->noendbr || insn->noendbr_hit)
+				continue;
+
+			if (hypercall_page) {
+				/*
+				 * The Xen hypercall page contains many
+				 * hypercalls (and unused slots) that are never
+				 * indirectly called. Still every slot has an
+				 * annotation. Suppress complaints.
+				 */
+				if (insn->sec == hypercall_page->sec &&
+				    insn->offset >= hypercall_page->offset &&
+				    insn->offset <  hypercall_page->offset + hypercall_page->len)
+					continue;
+			}
+
+			WARN_FUNC("unused ANNOTATE_NOENDBR", insn->sec, insn->offset);
+		}
+	}
+
 	return 0;
 }
 
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -10,7 +10,7 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt;
+	    ibt, ibt_warn;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -51,7 +51,8 @@ struct instruction {
 	   ignore_alts	: 1,
 	   hint		: 1,
 	   retpoline_safe : 1,
-	   noendbr	: 1;
+	   noendbr	: 1,
+	   noendbr_hit  : 1;
 		/* 2 bit hole */
 	s8 instr;
 	u8 visited;


