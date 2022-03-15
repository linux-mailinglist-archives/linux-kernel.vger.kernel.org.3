Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACD64D9932
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345262AbiCOKp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347279AbiCOKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD9634BAD;
        Tue, 15 Mar 2022 03:43:52 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Wq35/iZAlxdevVct8p5zefpE51UTE9bhbwDutgz3JM=;
        b=k+k+Kz85a842PTFttpkgw8EvtZCgjNz5FZMQ31wANAHNwUoNqD/Khsv2TsCqQyq3KdTR42
        FjlO/y8BukU+IykpMNoCvVOufFdjPnIP+zrd1w7+0P5S1P1q60fpTThGOsgZt03loBYmda
        6UTMt9LKh19Llcx4G895hIOR8IjznypISC0BrV/ufdf6rbElo06MrnTtUwpp5+WnE0MxON
        rmM2qZ6aJIqfHFKYadiAyk+hOvKZdoqvU6vGlBABBbSFatMibJPb89WT4zsn59Cqpv1a6E
        01Kq5RDFdm7KD9kZ1FpcIvQnOP9wbziH/Dy7DbyMw/b/0qVghtjJ3W10c7Oexw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341031;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0Wq35/iZAlxdevVct8p5zefpE51UTE9bhbwDutgz3JM=;
        b=okPoqpf+QoGLrKK4dGWbv9utckfOdwI0IfxTePjq747ECNT+TFrq3AP4eLHHb9+NhakcDU
        yU5yytdeX/5UsfCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Ignore extra-symbol code
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.232019347@infradead.org>
References: <20220308154319.232019347@infradead.org>
MIME-Version: 1.0
Message-ID: <164734103023.16921.6263492677430129555.tip-bot2@tip-bot2>
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

Commit-ID:     4adb23686795e9c88e3217b5d7b4524c0da9d04f
Gitweb:        https://git.kernel.org/tip/4adb23686795e9c88e3217b5d7b4524c0da9d04f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:43 +01:00

objtool: Ignore extra-symbol code

There's a fun implementation detail on linking STB_WEAK symbols. When
the linker combines two translation units, where one contains a weak
function and the other an override for it. It simply strips the
STB_WEAK symbol from the symbol table, but doesn't actually remove the
code.

The result is that when objtool is ran in a whole-archive kind of way,
it will encounter *heaps* of unused (and unreferenced) code. All
rudiments of weak functions.

Additionally, when a weak implementation is split into a .cold
subfunction that .cold symbol is left in place, even though completely
unused.

Teach objtool to ignore such rudiments by searching for symbol holes;
that is, code ranges that fall outside the given symbol bounds.
Specifically, ignore a sequence of unreachable instruction iff they
occupy a single hole, additionally ignore any .cold subfunctions
referenced.

Both ld.bfd and ld.lld behave like this. LTO builds otoh can (and do)
properly DCE weak functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.232019347@infradead.org
---
 tools/objtool/check.c               | 43 ++++++++++++++++++++-
 tools/objtool/elf.c                 | 60 ++++++++++++++++++++++++++++-
 tools/objtool/include/objtool/elf.h |  1 +-
 3 files changed, 104 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index ae1d4f9..0e0e5b5 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3346,6 +3346,49 @@ static bool ignore_unreachable_insn(struct objtool_file *file, struct instructio
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
 
+	/*
+	 * Whole archive runs might encounder dead code from weak symbols.
+	 * This is where the linker will have dropped the weak symbol in
+	 * favour of a regular symbol, but leaves the code in place.
+	 *
+	 * In this case we'll find a piece of code (whole function) that is not
+	 * covered by a !section symbol. Ignore them.
+	 */
+	if (!insn->func && lto) {
+		int size = find_symbol_hole_containing(insn->sec, insn->offset);
+		unsigned long end = insn->offset + size;
+
+		if (!size) /* not a hole */
+			return false;
+
+		if (size < 0) /* hole until the end */
+			return true;
+
+		sec_for_each_insn_continue(file, insn) {
+			/*
+			 * If we reach a visited instruction at or before the
+			 * end of the hole, ignore the unreachable.
+			 */
+			if (insn->visited)
+				return true;
+
+			if (insn->offset >= end)
+				break;
+
+			/*
+			 * If this hole jumps to a .cold function, mark it ignore too.
+			 */
+			if (insn->jump_dest && insn->jump_dest->func &&
+			    strstr(insn->jump_dest->func->name, ".cold")) {
+				struct instruction *dest = insn->jump_dest;
+				func_for_each_insn(file, dest->func, dest)
+					dest->ignore = true;
+			}
+		}
+
+		return false;
+	}
+
 	if (!insn->func)
 		return false;
 
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 456ac22..d7b99a7 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -83,6 +83,31 @@ static int symbol_by_offset(const void *key, const struct rb_node *node)
 	return 0;
 }
 
+struct symbol_hole {
+	unsigned long key;
+	const struct symbol *sym;
+};
+
+/*
+ * Find !section symbol where @offset is after it.
+ */
+static int symbol_hole_by_offset(const void *key, const struct rb_node *node)
+{
+	const struct symbol *s = rb_entry(node, struct symbol, node);
+	struct symbol_hole *sh = (void *)key;
+
+	if (sh->key < s->offset)
+		return -1;
+
+	if (sh->key >= s->offset + s->len) {
+		if (s->type != STT_SECTION)
+			sh->sym = s;
+		return 1;
+	}
+
+	return 0;
+}
+
 struct section *find_section_by_name(const struct elf *elf, const char *name)
 {
 	struct section *sec;
@@ -162,6 +187,41 @@ struct symbol *find_symbol_containing(const struct section *sec, unsigned long o
 	return NULL;
 }
 
+/*
+ * Returns size of hole starting at @offset.
+ */
+int find_symbol_hole_containing(const struct section *sec, unsigned long offset)
+{
+	struct symbol_hole hole = {
+		.key = offset,
+		.sym = NULL,
+	};
+	struct rb_node *n;
+	struct symbol *s;
+
+	/*
+	 * Find the rightmost symbol for which @offset is after it.
+	 */
+	n = rb_find(&hole, &sec->symbol_tree, symbol_hole_by_offset);
+
+	/* found a symbol that contains @offset */
+	if (n)
+		return 0; /* not a hole */
+
+	/* didn't find a symbol for which @offset is after it */
+	if (!hole.sym)
+		return 0; /* not a hole */
+
+	/* @offset >= sym->offset + sym->len, find symbol after it */
+	n = rb_next(&hole.sym->node);
+	if (!n)
+		return -1; /* until end of address space */
+
+	/* hole until start of next symbol */
+	s = rb_entry(n, struct symbol, node);
+	return s->offset - offset;
+}
+
 struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
 	struct rb_node *node;
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d223367..22ba7e2 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -152,6 +152,7 @@ struct symbol *find_func_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
+int find_symbol_hole_containing(const struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);
