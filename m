Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128804D1C81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348305AbiCHP6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348058AbiCHP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:56:08 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDF54F9DB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=pOXAhYpwyUq7J/Sr4ITx6/mq7zlOV7buPpe6IITPszc=; b=URQEQg/4OsQnrJZ/bfb6LgKenm
        VEftAZd/zmbor6U521l8kLeCewls8TIjdEg4YGGGBBm2loSiFGh42W9EJOjKEeSHhLmP7SR7aJ1m3
        A4STRuCtoGW4KsNnbKEGtKo6x1+qz98dD+y07ULI6gLGAeLWJ+ftocve9ezCMc1StjRw0Yo9rfGl6
        YeNf53joXaqyjsGRv04KXm3aJhle6uchimjTziDz9unVOrJCi6NG8CWCwyokjgJEoJK35Sqj7W97w
        UTALGbdvd3tkfOh85850FxMnQlpGNrXZpDcX2zxcroGWa3jQ3xbBDxh+Bkt5VBU4CZidZ/9hnnqBO
        +OxRAJEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRcAd-00GUij-3W; Tue, 08 Mar 2022 15:54:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4D5C7302DD5;
        Tue,  8 Mar 2022 16:54:40 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BACFD2B5649CE; Tue,  8 Mar 2022 16:54:39 +0100 (CET)
Message-ID: <20220308154319.232019347@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 08 Mar 2022 16:30:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v4 35/45] objtool: Ignore extra-symbol code
References: <20220308153011.021123062@infradead.org>
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
---
 tools/objtool/check.c               |   43 +++++++++++++++++++++++++
 tools/objtool/elf.c                 |   60 ++++++++++++++++++++++++++++++++++++
 tools/objtool/include/objtool/elf.h |    1 
 3 files changed, 104 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3577,6 +3577,49 @@ static bool ignore_unreachable_insn(stru
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
 
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -83,6 +83,31 @@ static int symbol_by_offset(const void *
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
@@ -162,6 +187,41 @@ struct symbol *find_symbol_containing(co
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
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -152,6 +152,7 @@ struct symbol *find_func_by_offset(struc
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset);
 struct symbol *find_symbol_by_name(const struct elf *elf, const char *name);
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset);
+int find_symbol_hole_containing(const struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest(const struct elf *elf, struct section *sec, unsigned long offset);
 struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *sec,
 				     unsigned long offset, unsigned int len);


