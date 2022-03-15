Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124094D990D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347210AbiCOKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347213AbiCOKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:44:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C7B2B256;
        Tue, 15 Mar 2022 03:43:41 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG4wnhCKw4IE5Dr2QVGD0Vn1MWeCG8UJRH8sOKrswjM=;
        b=uLaK2xbYOKOguC2aZRpuDEu3ZEvtHhA94vdx9pMbCUsoTGf9p64bEko0vFIHyVmPk7UBi5
        LOPnRbyKu8KrDXFmxej/5CGg0bbZ5RUq5fiX4INya8/os+GaSLASkqw4z0AO9vszcOFdKJ
        MlBibATA+7rf/XOE7NmjkOhqP+M8AQ9Ah/57xlnPdqvpH9ZIwlMTTdATsZ+yDo4PqAnCNA
        HYngqJYKWHNHCvV95mRSuKvV9CCfhftwqMORhrf71MouWudEm62FIWnSAfWlIJ70RvUbgP
        EpI7hDz9n2Hmi1uoLU+4jfYo7PzB42ivv5DrVU8sd9yUm6GeY0q7+4CEPMvomA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341020;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VG4wnhCKw4IE5Dr2QVGD0Vn1MWeCG8UJRH8sOKrswjM=;
        b=hQtwx2LK3NbHlPWEhoyb6XKUWUaqcRkX+Bcgfqzco/v1YiHdTKvaTBVxoUTzBtaWw1FVbl
        AeqPbasAdHPd3cDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Find unused ENDBR instructions
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.763643193@infradead.org>
References: <20220308154319.763643193@infradead.org>
MIME-Version: 1.0
Message-ID: <164734101940.16921.11639161864874862247.tip-bot2@tip-bot2>
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

Commit-ID:     89bc853eae4ad125030ef99f207ba76c2f00a26e
Gitweb:        https://git.kernel.org/tip/89bc853eae4ad125030ef99f207ba76c2f00a26e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:55 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:47 +01:00

objtool: Find unused ENDBR instructions

Find all ENDBR instructions which are never referenced and stick them
in a section such that the kernel can poison them, sealing the
functions from ever being an indirect call target.

This removes about 1-in-4 ENDBR instructions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.763643193@infradead.org
---
 arch/x86/kernel/vmlinux.lds.S           |  9 +++-
 tools/objtool/check.c                   | 69 +++++++++++++++++++++++-
 tools/objtool/include/objtool/objtool.h |  1 +-
 tools/objtool/objtool.c                 |  1 +-
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 27f8303..7fda7f2 100644
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
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d4cf831..6de5085 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -383,6 +383,7 @@ static int decode_instructions(struct objtool_file *file)
 			memset(insn, 0, sizeof(*insn));
 			INIT_LIST_HEAD(&insn->alts);
 			INIT_LIST_HEAD(&insn->stack_ops);
+			INIT_LIST_HEAD(&insn->call_node);
 
 			insn->sec = sec;
 			insn->offset = offset;
@@ -420,8 +421,9 @@ static int decode_instructions(struct objtool_file *file)
 
 			sym_for_each_insn(file, func, insn) {
 				insn->func = func;
-				if (insn->type == INSN_ENDBR) {
+				if (insn->type == INSN_ENDBR && list_empty(&insn->call_node)) {
 					if (insn->offset == insn->func->offset) {
+						list_add_tail(&insn->call_node, &file->endbr_list);
 						file->nr_endbr++;
 					} else {
 						file->nr_endbr_int++;
@@ -742,6 +744,58 @@ static int create_retpoline_sites_sections(struct objtool_file *file)
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
@@ -3120,8 +3174,12 @@ validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc)
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
@@ -3860,6 +3918,13 @@ int check(struct objtool_file *file)
 		warnings += ret;
 	}
 
+	if (ibt) {
+		ret = create_ibt_endbr_seal_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
+	}
+
 	if (stats) {
 		printf("nr_insns_visited: %ld\n", nr_insns_visited);
 		printf("nr_cfi: %ld\n", nr_cfi);
diff --git a/tools/objtool/include/objtool/objtool.h b/tools/objtool/include/objtool/objtool.h
index fa3c7fa..7a5c13a 100644
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -26,6 +26,7 @@ struct objtool_file {
 	struct list_head retpoline_call_list;
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
+	struct list_head endbr_list;
 	bool ignore_unreachables, c_file, hints, rodata;
 
 	unsigned int nr_endbr;
diff --git a/tools/objtool/objtool.c b/tools/objtool/objtool.c
index bdf699f..b09946f 100644
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -128,6 +128,7 @@ struct objtool_file *objtool_open_read(const char *_objname)
 	INIT_LIST_HEAD(&file.retpoline_call_list);
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
+	INIT_LIST_HEAD(&file.endbr_list);
 	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
