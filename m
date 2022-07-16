Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104D9577267
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbiGPXRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbiGPXRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469FC22B18
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:25 -0700 (PDT)
Message-ID: <20220716230953.138004117@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QvzD5+agpmv+z+EPnO126OtvixIotUEzcS1YTM2Sf54=;
        b=MkHx/IkFOkZ/D9EqEFMfURLeqDyMptI4jvdIi9x6qwssQXJU2ADy3Sj1ttt6G/E++K/sbL
        pa5LFvU156K5VBDuHZ1oOTsLNv0nS5HMP/iAmvLJAglaqvRhfO+/nP0R9ALVDukwUmlHUs
        J9i12CzVK617RllEgwsnrJPTGRnhBodzAKvwoMPpWUB3YaWGVUNtaA2wbick1P1ghqX4Cl
        evjqEtkpX65MkW61eqXpRIEBWRpj9fMpI3BiNcL2V4CfTljHpK2mIfn7V/ZsALFo8iFJ6E
        yrzbOhtHsx4MSr5WeO6z0JA+86vu7ZE3vmfIkn6uKTOs7+z26Coem8+6T9kv7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=QvzD5+agpmv+z+EPnO126OtvixIotUEzcS1YTM2Sf54=;
        b=MzsacAQSccZGhFmiqh4qA4460KcAtZYXekavesQt88ORHeNvVzZRXJmhFclaOFnaMLCRIN
        Z1+NOdYtx+wI5VAg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 08/38] objtool: Add .call_sites section
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:22 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

In preparation for call depth tracking provide a section which collects all
direct calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/vmlinux.lds.S           |    7 ++++
 tools/objtool/check.c                   |   51 ++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 4 files changed, 60 insertions(+)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -290,6 +290,13 @@ SECTIONS
 		*(.return_sites)
 		__return_sites_end = .;
 	}
+
+	. = ALIGN(8);
+	.call_sites : AT(ADDR(.call_sites) - LOAD_OFFSET) {
+		__call_sites = .;
+		*(.call_sites)
+		__call_sites_end = .;
+	}
 #endif
 
 #ifdef CONFIG_X86_KERNEL_IBT
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -898,6 +898,49 @@ static int create_mcount_loc_sections(st
 	return 0;
 }
 
+static int create_direct_call_sections(struct objtool_file *file)
+{
+	struct instruction *insn;
+	struct section *sec;
+	unsigned int *loc;
+	int idx;
+
+	sec = find_section_by_name(file->elf, ".call_sites");
+	if (sec) {
+		INIT_LIST_HEAD(&file->call_list);
+		WARN("file already has .call_sites section, skipping");
+		return 0;
+	}
+
+	if (list_empty(&file->call_list))
+		return 0;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->call_list, call_node)
+		idx++;
+
+	sec = elf_create_section(file->elf, ".call_sites", 0, sizeof(unsigned int), idx);
+	if (!sec)
+		return -1;
+
+	idx = 0;
+	list_for_each_entry(insn, &file->call_list, call_node) {
+
+		loc = (unsigned int *)sec->data->d_buf + idx;
+		memset(loc, 0, sizeof(unsigned int));
+
+		if (elf_add_reloc_to_insn(file->elf, sec,
+					  idx * sizeof(unsigned int),
+					  R_X86_64_PC32,
+					  insn->sec, insn->offset))
+			return -1;
+
+		idx++;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1252,6 +1295,9 @@ static void annotate_call_site(struct ob
 		return;
 	}
 
+	if (insn->type == INSN_CALL && !insn->sec->init)
+		list_add_tail(&insn->call_node, &file->call_list);
+
 	if (!sibling && dead_end_function(file, sym))
 		insn->dead_end = true;
 }
@@ -4275,6 +4321,11 @@ int check(struct objtool_file *file)
 		if (ret < 0)
 			goto out;
 		warnings += ret;
+
+		ret = create_direct_call_sections(file);
+		if (ret < 0)
+			goto out;
+		warnings += ret;
 	}
 
 	if (opts.mcount) {
--- a/tools/objtool/include/objtool/objtool.h
+++ b/tools/objtool/include/objtool/objtool.h
@@ -28,6 +28,7 @@ struct objtool_file {
 	struct list_head static_call_list;
 	struct list_head mcount_loc_list;
 	struct list_head endbr_list;
+	struct list_head call_list;
 	bool ignore_unreachables, hints, rodata;
 
 	unsigned int nr_endbr;
--- a/tools/objtool/objtool.c
+++ b/tools/objtool/objtool.c
@@ -106,6 +106,7 @@ struct objtool_file *objtool_open_read(c
 	INIT_LIST_HEAD(&file.static_call_list);
 	INIT_LIST_HEAD(&file.mcount_loc_list);
 	INIT_LIST_HEAD(&file.endbr_list);
+	INIT_LIST_HEAD(&file.call_list);
 	file.ignore_unreachables = opts.no_unreachable;
 	file.hints = false;
 

