Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958734CBC9E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiCCLdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiCCLbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0642717CC6F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bM/2CfoNUi7Kkgqfth4YTpf/0vnJo3PNRdu2me27tHQ=; b=Dnenwif0HTQXCPZJiegdxOTQ8Z
        /LkarDm5GJVdZbpdRrHmg7ZUMeHzmfiNxNFx+7WFztRaBsEGdGy3PWrG+3hXmt+lkRtJzaMW7X0+d
        3WE3tAaeHDg//k7hsQZRRxtsIZFW80MfWEY8Mw35RrIlAzDBszj0OGBDrsabN+jaawBdvKrRFuR+J
        tFGhu+gqksqV+sLGlukokCH0JTv93tRgT3j9ZW8hp+mu0hSoCEQZfeygL609mBjLJmLYzefnq3YNQ
        SkmNMRbby0nu2OQQmFjW0/5WXmYcafUuFOcmlLPRPvBTFdfZm7XqxenFKQcsRZPEXsWSfCJlIS44b
        Iw2OofPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjei-00BaHJ-Oq; Thu, 03 Mar 2022 11:30:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16A59302DD9;
        Thu,  3 Mar 2022 12:29:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF63C3012BCD7; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112827.272113089@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 38/39] objtool: Find unused ENDBR instructions
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

Find all ENDBR instructions which are never referenced and stick them
in a section such that the kernel can poison them, sealing the
functions from ever being an indirect call target.

This removes about 1-in-4 ENDBR instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S           |    9 ++++
 tools/objtool/check.c                   |   69 +++++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 4 files changed, 78 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -285,6 +285,15 @@ SECTIONS
 	}
 #endif
 
+#ifdef CONFIG_X86_KERNEL_IBT
+	. = ALIGN(8);
+	.ibt_endbr_seal : AT(ADDR(.ibt_endbr_seal) - LOAD_OFFSET) {
+		__ibt_endbr_seal = .;
+		*(.ibt_endbr_seal)
+		__ibt_endbr_seal_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -380,6 +380,7 @@ static int decode_instructions(struct ob
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
+			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -409,8 +410,9 @@ static int decode_instructions(struct ob
 
 			sym_for_each_insn(file, func, insn) {
 				insn->func = func;
-				if (insn->type == INSN_ENDBR) {
+				if (insn->type == INSN_ENDBR && list_empty(&insn->call_node)) {
 					if (insn->offset == insn->func->offset) {
+						list_add_tail(&insn->call_node, &file->endbr_list);
 						file->nr_endbr++;
 					} else {
 						file->nr_endbr_int++;
@@ -739,6 +741,58 @@ static int create_retpoline_sites_sectio
 	return 0;
 }
 
+static int create_ibt_endbr_seal_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".ibt_endbr_seal");
+	if (sec) {
+		WARN("file already has .ibt_endbr_seal, skipping");
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
+	sec = elf_create_section(file->elf, ".ibt_endbr_seal", 0,
+				 sizeof(int), idx);
+	if (!sec) {
+		WARN("elf_create_section: .ibt_endbr_seal");
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
+			WARN("elf_add_reloc_to_insn: .ibt_endbr_seal");
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
@@ -3097,8 +3151,12 @@ validate_ibt_reloc(struct objtool_file *
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
@@ -3805,6 +3863,13 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+	}
+
+	if (ibt) {
+		ret = create_ibt_endbr_seal_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (stats) {
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


