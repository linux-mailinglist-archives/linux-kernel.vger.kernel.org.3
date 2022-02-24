Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2664C2F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbiBXPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbiBXPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:31 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E335141FDC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=QAUleNMitdEV456BQHF8E2uz5k0IuNzEfT0St/nK4Ls=; b=SGid/uQ713gS7P4fC9kMcVYOcD
        vNil022JW2VMFemGq4n6/qxpKZlo+f0ZEYY7MneZwrRaPtmcoNylxbyBhIfMqlCEM+sCLmoYYWaRk
        EUx7SJZSM6Yhjve7LrCaeSTH1E3/U2b+NX8tncQpi1M5Vsg4iWj4KhFg713oxbacqGL+uV+wbLrH4
        3skdlJWbu525Z9Di0grA7lQ44m4oK6kT3Vnotlbzhkgn1UPR9pNOXdmhWaPJ59xrFJOgKpoFkl4vL
        n68fo4uqJjgs7lDY7pBvjTUw+nnAkkQYMq9HofW4XEAbfxfoXNJc7SyfIfsO1oxzVIstcgoIIwM+J
        qS14Dbrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs4-00CeM5-0T; Thu, 24 Feb 2022 15:17:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 512DA302D8A;
        Thu, 24 Feb 2022 16:17:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AFCB42B3547AF; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151324.137868984@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:52:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 36/39] objtool: Find unused ENDBR instructions
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

Find all unused ENDBR instructions and stick them in a section such
that the kernel can poison them.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S           |    9 ++++
 tools/objtool/builtin-check.c           |    3 -
 tools/objtool/check.c                   |   72 +++++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/builtin.h |    2 
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 6 files changed, 85 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -285,6 +285,15 @@ SECTIONS
 	}
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	. = ALIGN(8);
+	.ibt_endbr_sites : AT(ADDR(.ibt_endbr_sites) - LOAD_OFFSET) {
+		__ibt_endbr_sites = .;
+		*(.ibt_endbr_sites)
+		__ibt_endbr_sites_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -21,7 +21,7 @@
 
 bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
      lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-     ibt, ibt_fix_direct;
+     ibt, ibt_fix_direct, ibt_seal;
 
 static const char * const check_usage[] = {
 	"objtool check [<options>] file.o",
@@ -50,6 +50,7 @@ const struct option check_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &dryrun, "don't write the modifications"),
 	OPT_BOOLEAN(0, "ibt", &ibt, "validate ENDBR placement"),
 	OPT_BOOLEAN(0, "ibt-fix-direct", &ibt_fix_direct, "fixup direct jmp/call to ENDBR"),
+	OPT_BOOLEAN(0, "ibt-seal", &ibt_seal, "list superfluous ENDBR instructions"),
 	OPT_END(),
 };
 
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -732,6 +732,58 @@ static int create_retpoline_sites_sectio
 	return 0;
 }
 
+static int create_ibt_endbr_sites_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".ibt_endbr_sites");
+	if (sec) {
+		WARN("file already has .ibt_endbr_sites, skipping");
+		return 0;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->endbr_list, call_node)
+		idx++;
+
+	if (stats) {
+		printf("ibt: ENDBR at function start: %d\n", file->nr_endbr);
+		printf("ibt: ENDBR inside functions:  %d\n", file->nr_endbr_int);
+		printf("ibt: superfluous ENDBR:       %d\n", idx);
+	}
+
+	if (!idx)
+		return 0;
+
+	sec = elf_create_section(file->elf, ".ibt_endbr_sites", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .ibt_endbr_sites");
+		return -1;
+	}
+
+	idx = 0;
+	list_for_each_entry(insn, &file->endbr_list, call_node) {
+
+		int *site = (int *)sec->data->d_buf + idx;
+		*site = 0;
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset)) {
+			WARN("elf_add_reloc_to_insn: .ibt_endbr_sites");
+			return -1;
+		}
+
+		idx++;
+	}
+
+	return 0;
+}
+
 static int create_mcount_loc_sections(struct objtool_file *file)
 {
 	struct section *sec;
@@ -1179,6 +1231,7 @@ static int add_jump_destinations(struct
 	for_each_insn(file, insn) {
 		if (insn->type == INSN_ENDBR && insn->func) {
 			if (insn->offset == insn->func->offset) {
+				list_add_tail(&insn->call_node, &file->endbr_list);
 				file->nr_endbr++;
 			} else {
 				file->nr_endbr_int++;
@@ -3633,8 +3687,12 @@ validate_ibt_reloc(struct objtool_file *
 	if (!dest)
 		return NULL;
 
-	if (dest->type == INSN_ENDBR)
+	if (dest->type == INSN_ENDBR) {
+		if (!list_empty(&dest->call_node))
+			list_del_init(&dest->call_node);
+
 		return NULL;
+	}
 
 	if (reloc->sym->static_call_tramp)
 		return NULL;
@@ -3777,6 +3835,11 @@ int check(struct objtool_file *file)
 		return 1;
 	}
 
+	if (ibt_seal && !ibt_fix_direct) {
+		fprintf(stderr, "--ibt-seal requires: --ibt-fix-direct\n");
+		return 1;
+	}
+
 	arch_initial_func_cfi_state(&initial_func_cfi);
 	init_cfi_state(&init_cfi);
 	init_cfi_state(&func_cfi);
@@ -3854,6 +3917,13 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+	}
+
+	if (ibt_seal) {
+		ret = create_ibt_endbr_sites_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (stats) {
--- a/tools/objtool/include/objtool/builtin.h
+++ b/tools/objtool/include/objtool/builtin.h
@@ -10,7 +10,7 @@
 extern const struct option check_options[];
 extern bool no_fp, no_unreachable, retpoline, module, backtrace, uaccess, stats,
 	    lto, vmlinux, mcount, noinstr, backup, sls, dryrun,
-	    ibt, ibt_fix_direct;
+	    ibt, ibt_fix_direct, ibt_seal;
 
 extern int cmd_parse_options(int argc, const char **argv, const char * const usage[]);
 
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -26,6 +26,7 @@ struct objtool_file {
 	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
+	struct list_head endbr_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 
 	unsigned int nr_endbr;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -128,6 +128,7 @@ struct objtool_file *objtool_open_read(c
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
+	INIT_LIST_HEAD(&file.endbr_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;


