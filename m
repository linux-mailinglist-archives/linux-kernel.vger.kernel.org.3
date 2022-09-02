Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FEE5AB394
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbiIBObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbiIBO1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234315819D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=mx58zQy98Wj+VFeO7kNG/+7nWSkg+eR2wmG7+5WoSrk=; b=NaNh3R/iwlKYiAWSqd7sSxJQkV
        UyvtNlhsdu8uUq+Z5CRjn88AROZ4+nBTZG4LJrKteU2OkXnZ3cqdb4A0D+OseLZSr31X2597PhrOR
        0WFi8bfK+o8cNpVX2PPin1WtDWyNBSxovkHW05bjqCVsDRmifhnQoehDPV2dLMWUd1CzTLmsDWb46
        F36FCkbJ03VbxFjRdofEkZ9PvRdAYTVvzFt0byhZ5K5bDyhtDqdu7gzTAWnMPg3z2NXCUUbvfuPgY
        74OWWyB2Zy0FKFR8vOojteSYGNsmbu4in3biSK/2zn1tYQ7AtM/0LuygpkVRIq6Y3QmMBb9sDD5S2
        E7qd/g2g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77M-008g8H-FS; Fri, 02 Sep 2022 13:54:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D3E13021FB;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F33D92B8AE5A4; Fri,  2 Sep 2022 15:53:52 +0200 (CEST)
Message-ID: <20220902130949.789826745@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:06:58 +0200
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
Subject: [PATCH v2 33/59] objtool: Fix find_{symbol,func}_containing()
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

The current find_{symbol,func}_containing() functions are broken in
the face of overlapping symbols, exactly the case that is needed for a
new ibt/endbr supression.

Import interval_tree_generic.h into the tools tree and convert the
symbol tree to an interval tree to support proper range stabs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/include/linux/interval_tree_generic.h |  187 ++++++++++++++++++++++++++++
 tools/objtool/elf.c                         |   93 +++++--------
 tools/objtool/include/objtool/elf.h         |    3 
 3 files changed, 229 insertions(+), 54 deletions(-)

--- /dev/null
+++ b/tools/include/linux/interval_tree_generic.h
@@ -0,0 +1,187 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+  Interval Trees
+  (C) 2012  Michel Lespinasse <walken@google.com>
+
+
+  include/linux/interval_tree_generic.h
+*/
+
+#include <linux/rbtree_augmented.h>
+
+/*
+ * Template for implementing interval trees
+ *
+ * ITSTRUCT:   struct type of the interval tree nodes
+ * ITRB:       name of struct rb_node field within ITSTRUCT
+ * ITTYPE:     type of the interval endpoints
+ * ITSUBTREE:  name of ITTYPE field within ITSTRUCT holding last-in-subtree
+ * ITSTART(n): start endpoint of ITSTRUCT node n
+ * ITLAST(n):  last endpoint of ITSTRUCT node n
+ * ITSTATIC:   'static' or empty
+ * ITPREFIX:   prefix to use for the inline tree definitions
+ *
+ * Note - before using this, please consider if generic version
+ * (interval_tree.h) would work for you...
+ */
+
+#define INTERVAL_TREE_DEFINE(ITSTRUCT, ITRB, ITTYPE, ITSUBTREE,		      \
+			     ITSTART, ITLAST, ITSTATIC, ITPREFIX)	      \
+									      \
+/* Callbacks for augmented rbtree insert and remove */			      \
+									      \
+RB_DECLARE_CALLBACKS_MAX(static, ITPREFIX ## _augment,			      \
+			 ITSTRUCT, ITRB, ITTYPE, ITSUBTREE, ITLAST)	      \
+									      \
+/* Insert / remove interval nodes from the tree */			      \
+									      \
+ITSTATIC void ITPREFIX ## _insert(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)	 	      \
+{									      \
+	struct rb_node **link = &root->rb_root.rb_node, *rb_parent = NULL;    \
+	ITTYPE start = ITSTART(node), last = ITLAST(node);		      \
+	ITSTRUCT *parent;						      \
+	bool leftmost = true;						      \
+									      \
+	while (*link) {							      \
+		rb_parent = *link;					      \
+		parent = rb_entry(rb_parent, ITSTRUCT, ITRB);		      \
+		if (parent->ITSUBTREE < last)				      \
+			parent->ITSUBTREE = last;			      \
+		if (start < ITSTART(parent))				      \
+			link = &parent->ITRB.rb_left;			      \
+		else {							      \
+			link = &parent->ITRB.rb_right;			      \
+			leftmost = false;				      \
+		}							      \
+	}								      \
+									      \
+	node->ITSUBTREE = last;						      \
+	rb_link_node(&node->ITRB, rb_parent, link);			      \
+	rb_insert_augmented_cached(&node->ITRB, root,			      \
+				   leftmost, &ITPREFIX ## _augment);	      \
+}									      \
+									      \
+ITSTATIC void ITPREFIX ## _remove(ITSTRUCT *node,			      \
+				  struct rb_root_cached *root)		      \
+{									      \
+	rb_erase_augmented_cached(&node->ITRB, root, &ITPREFIX ## _augment);  \
+}									      \
+									      \
+/*									      \
+ * Iterate over intervals intersecting [start;last]			      \
+ *									      \
+ * Note that a node's interval intersects [start;last] iff:		      \
+ *   Cond1: ITSTART(node) <= last					      \
+ * and									      \
+ *   Cond2: start <= ITLAST(node)					      \
+ */									      \
+									      \
+static ITSTRUCT *							      \
+ITPREFIX ## _subtree_search(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariant: start <= node->ITSUBTREE		      \
+		 * (Cond2 is satisfied by one of the subtree nodes)	      \
+		 */							      \
+		if (node->ITRB.rb_left) {				      \
+			ITSTRUCT *left = rb_entry(node->ITRB.rb_left,	      \
+						  ITSTRUCT, ITRB);	      \
+			if (start <= left->ITSUBTREE) {			      \
+				/*					      \
+				 * Some nodes in left subtree satisfy Cond2.  \
+				 * Iterate to find the leftmost such node N.  \
+				 * If it also satisfies Cond1, that's the     \
+				 * match we are looking for. Otherwise, there \
+				 * is no matching interval as nodes to the    \
+				 * right of N can't satisfy Cond1 either.     \
+				 */					      \
+				node = left;				      \
+				continue;				      \
+			}						      \
+		}							      \
+		if (ITSTART(node) <= last) {		/* Cond1 */	      \
+			if (start <= ITLAST(node))	/* Cond2 */	      \
+				return node;	/* node is leftmost match */  \
+			if (node->ITRB.rb_right) {			      \
+				node = rb_entry(node->ITRB.rb_right,	      \
+						ITSTRUCT, ITRB);	      \
+				if (start <= node->ITSUBTREE)		      \
+					continue;			      \
+			}						      \
+		}							      \
+		return NULL;	/* No match */				      \
+	}								      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_first(struct rb_root_cached *root,			      \
+			ITTYPE start, ITTYPE last)			      \
+{									      \
+	ITSTRUCT *node, *leftmost;					      \
+									      \
+	if (!root->rb_root.rb_node)					      \
+		return NULL;						      \
+									      \
+	/*								      \
+	 * Fastpath range intersection/overlap between A: [a0, a1] and	      \
+	 * B: [b0, b1] is given by:					      \
+	 *								      \
+	 *         a0 <= b1 && b0 <= a1					      \
+	 *								      \
+	 *  ... where A holds the lock range and B holds the smallest	      \
+	 * 'start' and largest 'last' in the tree. For the later, we	      \
+	 * rely on the root node, which by augmented interval tree	      \
+	 * property, holds the largest value in its last-in-subtree.	      \
+	 * This allows mitigating some of the tree walk overhead for	      \
+	 * for non-intersecting ranges, maintained and consulted in O(1).     \
+	 */								      \
+	node = rb_entry(root->rb_root.rb_node, ITSTRUCT, ITRB);		      \
+	if (node->ITSUBTREE < start)					      \
+		return NULL;						      \
+									      \
+	leftmost = rb_entry(root->rb_leftmost, ITSTRUCT, ITRB);		      \
+	if (ITSTART(leftmost) > last)					      \
+		return NULL;						      \
+									      \
+	return ITPREFIX ## _subtree_search(node, start, last);		      \
+}									      \
+									      \
+ITSTATIC ITSTRUCT *							      \
+ITPREFIX ## _iter_next(ITSTRUCT *node, ITTYPE start, ITTYPE last)	      \
+{									      \
+	struct rb_node *rb = node->ITRB.rb_right, *prev;		      \
+									      \
+	while (true) {							      \
+		/*							      \
+		 * Loop invariants:					      \
+		 *   Cond1: ITSTART(node) <= last			      \
+		 *   rb == node->ITRB.rb_right				      \
+		 *							      \
+		 * First, search right subtree if suitable		      \
+		 */							      \
+		if (rb) {						      \
+			ITSTRUCT *right = rb_entry(rb, ITSTRUCT, ITRB);	      \
+			if (start <= right->ITSUBTREE)			      \
+				return ITPREFIX ## _subtree_search(right,     \
+								start, last); \
+		}							      \
+									      \
+		/* Move up the tree until we come from a node's left child */ \
+		do {							      \
+			rb = rb_parent(&node->ITRB);			      \
+			if (!rb)					      \
+				return NULL;				      \
+			prev = &node->ITRB;				      \
+			node = rb_entry(rb, ITSTRUCT, ITRB);		      \
+			rb = node->ITRB.rb_right;			      \
+		} while (prev == rb);					      \
+									      \
+		/* Check if the node intersects [start;last] */		      \
+		if (last < ITSTART(node))		/* !Cond1 */	      \
+			return NULL;					      \
+		else if (start <= ITLAST(node))		/* Cond2 */	      \
+			return node;					      \
+	}								      \
+}
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <unistd.h>
 #include <errno.h>
+#include <linux/interval_tree_generic.h>
 #include <objtool/builtin.h>
 
 #include <objtool/elf.h>
@@ -50,38 +51,22 @@ static inline u32 str_hash(const char *s
 	__elf_table(name); \
 })
 
-static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+static inline unsigned long __sym_start(struct symbol *s)
 {
-	struct symbol *sa = rb_entry(a, struct symbol, node);
-	struct symbol *sb = rb_entry(b, struct symbol, node);
-
-	if (sa->offset < sb->offset)
-		return true;
-	if (sa->offset > sb->offset)
-		return false;
-
-	if (sa->len < sb->len)
-		return true;
-	if (sa->len > sb->len)
-		return false;
-
-	sa->alias = sb;
-
-	return false;
+	return s->offset;
 }
 
-static int symbol_by_offset(const void *key, const struct rb_node *node)
+static inline unsigned long __sym_last(struct symbol *s)
 {
-	const struct symbol *s = rb_entry(node, struct symbol, node);
-	const unsigned long *o = key;
+	return s->offset + s->len - 1;
+}
 
-	if (*o < s->offset)
-		return -1;
-	if (*o >= s->offset + s->len)
-		return 1;
+INTERVAL_TREE_DEFINE(struct symbol, node, unsigned long, __subtree_last,
+		     __sym_start, __sym_last, static, __sym)
 
-	return 0;
-}
+#define __sym_for_each(_iter, _tree, _start, _end)			\
+	for (_iter = __sym_iter_first((_tree), (_start), (_end));	\
+	     _iter; _iter = __sym_iter_next(_iter, (_start), (_end)))
 
 struct symbol_hole {
 	unsigned long key;
@@ -147,13 +132,12 @@ static struct symbol *find_symbol_by_ind
 
 struct symbol *find_symbol_by_offset(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->offset == offset && s->type != STT_SECTION)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->offset == offset && iter->type != STT_SECTION)
+			return iter;
 	}
 
 	return NULL;
@@ -161,13 +145,12 @@ struct symbol *find_symbol_by_offset(str
 
 struct symbol *find_func_by_offset(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
-
-		if (s->offset == offset && s->type == STT_FUNC)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->offset == offset && iter->type == STT_FUNC)
+			return iter;
 	}
 
 	return NULL;
@@ -175,13 +158,12 @@ struct symbol *find_func_by_offset(struc
 
 struct symbol *find_symbol_containing(const struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->type != STT_SECTION)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->type != STT_SECTION)
+			return iter;
 	}
 
 	return NULL;
@@ -202,7 +184,7 @@ int find_symbol_hole_containing(const st
 	/*
 	 * Find the rightmost symbol for which @offset is after it.
 	 */
-	n = rb_find(&hole, &sec->symbol_tree, symbol_hole_by_offset);
+	n = rb_find(&hole, &sec->symbol_tree.rb_root, symbol_hole_by_offset);
 
 	/* found a symbol that contains @offset */
 	if (n)
@@ -224,13 +206,12 @@ int find_symbol_hole_containing(const st
 
 struct symbol *find_func_containing(struct section *sec, unsigned long offset)
 {
-	struct rb_node *node;
-
-	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
-		struct symbol *s = rb_entry(node, struct symbol, node);
+	struct rb_root_cached *tree = (struct rb_root_cached *)&sec->symbol_tree;
+	struct symbol *iter;
 
-		if (s->type == STT_FUNC)
-			return s;
+	__sym_for_each(iter, tree, offset, offset) {
+		if (iter->type == STT_FUNC)
+			return iter;
 	}
 
 	return NULL;
@@ -373,6 +354,7 @@ static void elf_add_symbol(struct elf *e
 {
 	struct list_head *entry;
 	struct rb_node *pnode;
+	struct symbol *iter;
 
 	INIT_LIST_HEAD(&sym->pv_target);
 	sym->alias = sym;
@@ -386,7 +368,12 @@ static void elf_add_symbol(struct elf *e
 	sym->offset = sym->sym.st_value;
 	sym->len = sym->sym.st_size;
 
-	rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
+	__sym_for_each(iter, &sym->sec->symbol_tree, sym->offset, sym->offset) {
+		if (iter->offset == sym->offset && iter->type == sym->type)
+			iter->alias = sym;
+	}
+
+	__sym_insert(sym, &sym->sec->symbol_tree);
 	pnode = rb_prev(&sym->node);
 	if (pnode)
 		entry = &rb_entry(pnode, struct symbol, node)->list;
@@ -401,7 +388,7 @@ static void elf_add_symbol(struct elf *e
 	 * can exist within a function, confusing the sorting.
 	 */
 	if (!sym->len)
-		rb_erase(&sym->node, &sym->sec->symbol_tree);
+		__sym_remove(sym, &sym->sec->symbol_tree);
 }
 
 static int read_symbols(struct elf *elf)
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -30,7 +30,7 @@ struct section {
 	struct hlist_node hash;
 	struct hlist_node name_hash;
 	GElf_Shdr sh;
-	struct rb_root symbol_tree;
+	struct rb_root_cached symbol_tree;
 	struct list_head symbol_list;
 	struct list_head reloc_list;
 	struct section *base, *reloc;
@@ -53,6 +53,7 @@ struct symbol {
 	unsigned char bind, type;
 	unsigned long offset;
 	unsigned int len;
+	unsigned long __subtree_last;
 	struct symbol *pfunc, *cfunc, *alias;
 	u8 uaccess_safe      : 1;
 	u8 static_call_tramp : 1;


