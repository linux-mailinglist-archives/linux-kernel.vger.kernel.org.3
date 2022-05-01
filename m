Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1651631B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344437AbiEAIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343628AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F934D242;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2SD008518;
        Sun, 1 May 2022 17:41:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2SD008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394479;
        bh=LtVXFRqfwfAlXYHTNWOCPAk/W0tQ+V8EtvwcoPnsATQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQm5d47w03tHA6HlAVPsV3x5N3110iOdOctvRsBqVeXvSKJjTAigKhvJQjdXJiujc
         +J6Zlo4JTvxz3B1MtIsDqr6KSpDpWU8YSljj4qCxavHpXNQuVNSWfBxIMGyXqHQrU1
         p6rhOLIDRli0ycKqUGxVYK7qBDK0ADVeRpqqPGFLw6cg9ivi5H5l/3LoogzHLHO2Js
         vj4IixBpE6iScfU13hfw8p18dJyubibRPRrlLjMO/zG4noqtupmydZ7m1dBh8LjFZ5
         pR9DnYSjGLoEcjjB7y46eY1QeS1sytxVszT3ENtgplWaSQc+KzPdkFD5yicuHfuR2R
         UyTeDSaG9NflQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 26/26] modpost: use hlist for hash table implementation
Date:   Sun,  1 May 2022 17:40:32 +0900
Message-Id: <20220501084032.1025918-27-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Import hlist macros from include/linux/list.h to implement the hash
table in a more generic way.

While I was here, I increased the hash table size from 1024 to 8192
to decrease the hash collision.

I moved ARRAY_SIZE() from file2alias.c to modpost.h because it is needed
in modpost.c as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Move to the end of the series because this is now optional

 scripts/mod/file2alias.c |  2 --
 scripts/mod/list.h       | 52 ++++++++++++++++++++++++++++++++++++++++
 scripts/mod/modpost.c    | 39 +++++++++++++++---------------
 scripts/mod/modpost.h    |  2 ++
 4 files changed, 73 insertions(+), 22 deletions(-)

diff --git a/scripts/mod/file2alias.c b/scripts/mod/file2alias.c
index 5258247d78ac..e8a9c6816fec 100644
--- a/scripts/mod/file2alias.c
+++ b/scripts/mod/file2alias.c
@@ -734,8 +734,6 @@ static int do_vio_entry(const char *filename, void *symval,
 	return 1;
 }
 
-#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
-
 static void do_input(char *alias,
 		     kernel_ulong_t *arr, unsigned int min, unsigned int max)
 {
diff --git a/scripts/mod/list.h b/scripts/mod/list.h
index a924a6c4aa4d..c60dbaa70d6b 100644
--- a/scripts/mod/list.h
+++ b/scripts/mod/list.h
@@ -210,4 +210,56 @@ static inline int list_empty(const struct list_head *head)
 	     !list_entry_is_head(pos, head, member);			\
 	     pos = n, n = list_next_entry(n, member))
 
+/*
+ * Double linked lists with a single pointer list head.
+ * Mostly useful for hash tables where the two pointer list head is
+ * too wasteful.
+ * You lose the ability to access the tail in O(1).
+ */
+
+struct hlist_head {
+	struct hlist_node *first;
+};
+
+struct hlist_node {
+	struct hlist_node *next, **pprev;
+};
+
+/**
+ * hlist_add_head - add a new entry at the beginning of the hlist
+ * @n: new entry to be added
+ * @h: hlist head to add it after
+ *
+ * Insert a new entry after the specified head.
+ * This is good for implementing stacks.
+ */
+static inline void hlist_add_head(struct hlist_node *n, struct hlist_head *h)
+{
+	struct hlist_node *first = h->first;
+
+	n->next = first;
+	if (first)
+		first->pprev = &n->next;
+	h->first = n;
+	n->pprev = &h->first;
+}
+
+#define hlist_entry(ptr, type, member) container_of(ptr, type, member)
+
+#define hlist_entry_safe(ptr, type, member) \
+	({ typeof(ptr) ____ptr = (ptr); \
+	   ____ptr ? hlist_entry(____ptr, type, member) : NULL; \
+	})
+
+/**
+ * hlist_for_each_entry	- iterate over list of given type
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the hlist_node within the struct.
+ */
+#define hlist_for_each_entry(pos, head, member)				\
+	for (pos = hlist_entry_safe((head)->first, typeof(*(pos)), member);\
+	     pos;							\
+	     pos = hlist_entry_safe((pos)->member.next, typeof(*(pos)), member))
+
 #endif /* LIST_H */
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 85fcac84d2d1..ebd544717b91 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -207,13 +207,8 @@ static struct module *new_module(const char *modname)
 	return mod;
 }
 
-/* A hash of all exported symbols,
- * struct symbol is also used for lists of unresolved symbols */
-
-#define SYMBOL_HASH_SIZE 1024
-
 struct symbol {
-	struct symbol *next;
+	struct hlist_node hash_node;	/* link to the hash table */
 	struct list_head list;	/* link to module::exported_symbols or module::unresolved_symbols */
 	struct module *module;
 	char *namespace;
@@ -225,8 +220,6 @@ struct symbol {
 	char name[];
 };
 
-static struct symbol *symbolhash[SYMBOL_HASH_SIZE];
-
 /* This is based on the hash algorithm from gdbm, via tdb */
 static inline unsigned int tdb_hash(const char *name)
 {
@@ -240,6 +233,21 @@ static inline unsigned int tdb_hash(const char *name)
 	return (1103515243 * value + 12345);
 }
 
+/* useful hash macros */
+#define hash_head(table, key)		(&(table)[tdb_hash(key) % ARRAY_SIZE(table)])
+
+#define hash_add_symbol(sym, table)	hlist_add_head(&(sym)->hash_node, \
+						       hash_head(table, (sym)->name))
+
+#define hash_for_matched_symbol(sym, table, key) \
+	hlist_for_each_entry(sym, hash_head(table, key), hash_node) \
+		if (!strcmp(sym->name, key))
+
+#define HASHTABLE_DECLARE(name, size)	struct hlist_head name[size]
+
+/* hash table of all exported symbols */
+HASHTABLE_DECLARE(exported_symbols, 8192);
+
 /**
  * Allocate a new symbols for use in the hash of exported symbols or
  * the list of unresolved symbols per module
@@ -254,15 +262,6 @@ static struct symbol *alloc_symbol(const char *name)
 	return s;
 }
 
-/* For the hash of exported symbols */
-static void hash_add_symbol(struct symbol *sym)
-{
-	unsigned int hash;
-
-	hash = tdb_hash(sym->name) % SYMBOL_HASH_SIZE;
-	sym->next = symbolhash[hash];
-	symbolhash[hash] = sym;
-}
 
 static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 {
@@ -282,8 +281,8 @@ static struct symbol *sym_find_with_module(const char *name, struct module *mod)
 	if (name[0] == '.')
 		name++;
 
-	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
-		if (strcmp(s->name, name) == 0 && (!mod || s->module == mod))
+	hash_for_matched_symbol(s, exported_symbols, name) {
+		if (!mod || s->module == mod)
 			return s;
 	}
 	return NULL;
@@ -427,7 +426,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s->is_static = !mod->from_dump;
 	s->export    = export;
 	list_add_tail(&s->list, &mod->exported_symbols);
-	hash_add_symbol(s);
+	hash_add_symbol(s, exported_symbols);
 
 	return s;
 }
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 1c2d6498d764..180eb142375e 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -14,6 +14,8 @@
 #include "list.h"
 #include "elfconfig.h"
 
+#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
+
 /* On BSD-alike OSes elf.h defines these according to host's word size */
 #undef ELF_ST_BIND
 #undef ELF_ST_TYPE
-- 
2.32.0

