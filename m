Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901835AB3A1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiIBOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236769AbiIBO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:28:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188AC12A90
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=cbOcmEbLj8D337GsZMcKWuXa0J6c/XUPtmKz8eI6AKk=; b=SPWRrj8JBuaPvEBBOzPGyJJHzP
        bIWxJq4UMb5Xz0Cd/fYW6xefBzhvVkH2bsHeDV23PsgdXC41IshWbQeW3KhB7NjRmPDaaCZ9ZyjwF
        VSVaLVPJF+5tv4CepoI+hztTyCos/R2gsgkarQcHUni10RGhCpVlkrAwxtrZEQaHs/qPAElvNRwef
        wekAsDqlWXDzfajbNzwLmsssXo9rMj6m6KQiUNBHrTELDehG6QoQB8nrrM5wK0tA4QDGoJ8UB3byX
        E5N9YbQ7jykfiFokjihHpJlgxUwWe3I+dGHIqeWCAaX4DTugot06iLqPEGo6ymivCHxH7JJDv3g6s
        t/7GEp8A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8E-E8; Fri, 02 Sep 2022 13:54:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 28DB1301D8A;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id DE80D2B8EF7F4; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.474319273@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 30/59] objtool: Add .call_sites section
References: <20220902130625.217071627@infradead.org>
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

From: Peter Zijlstra <peterz@infradead.org>

In preparation for call depth tracking provide a section which collects all
direct calls.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/vmlinux.lds.S           |    7 ++++
 tools/objtool/check.c                   |   51 ++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/objtool.h |    1 
 tools/objtool/objtool.c                 |    1 
 4 files changed, 60 insertions(+)

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -291,6 +291,13 @@ SECTIONS
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
@@ -4274,6 +4320,11 @@ int check(struct objtool_file *file)
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
 


