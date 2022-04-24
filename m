Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F7A50D4B5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbiDXTP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238263AbiDXTNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:52 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C0D70;
        Sun, 24 Apr 2022 12:10:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o6D019069;
        Mon, 25 Apr 2022 04:09:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o6D019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827343;
        bh=6vquSTq8d9y0j4rSHSlvsvzC/wKpk+itTAO7xDqkCzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P3CDNpI4hruGzJHZORat1huzpzi05r/ojDx4bEu/nDFrDuaiC2XhA/W963XZADN1U
         450SKy0UAP1dMMBfuWIrI3VymvJrwXnI3gZFAzbsZ6egu0wPs0nB9GOjkfo8N/hE/F
         qQsvuH30kSvUqHqHltRohg5Ti66XmyLDroIUBUqnPaW0qqjeK8+3z9qF0XrNaL53bB
         sIl2lQbaEuXFu9pbld0ULhKDlReYa+yDXHkhPx3Ej+cz3CsXH+2fKOrK9rF1ohGx1Q
         4w+TihMt8ZJN2V9VJti0FhjUqe/S1l4Hg0+UJD8+4HHLbI/5n1mDBoOUS3HuqXBnIL
         HANIRlyR+8vew==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 19/27] modpost: use hlist for hash table implementation
Date:   Mon, 25 Apr 2022 04:08:03 +0900
Message-Id: <20220424190811.1678416-20-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost has a simple hash table, which only supports the entry addition
(new_symbol), and search (find_symbol).

I want to have a macro to delete an entry from the hash table, and also
support multiple hash tables.

Instead of extending the own implementation, let's reuse hlist in list.h.
The code originates in included/linux/list.h, and looks familiar for
kernel developers.

I added 4 macros on top of the hlist utility macros:

 - hash_add_symbol

     add a symbol to the given hash table

 - hash_del_symbol

     delete a symbol from the given hash table

 - hash_for_matched_symbol

     traverse the hash table, stopping by the symbol whose name matches

 - hash_for_matched_symbol_safe

     like hash_for_each_symbol, but safe against node removal

While I was here, I increased the hash table size from 1024 to 8192
to decrease the hash collision. We have more and more exported symbols
these days.

I moved ARRAY_SIZE() from file2alias.c to modpost.h because it is needed
in modpost.c as well.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/file2alias.c |  2 --
 scripts/mod/modpost.c    | 54 +++++++++++++++++++++-------------------
 scripts/mod/modpost.h    |  2 ++
 3 files changed, 30 insertions(+), 28 deletions(-)

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
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index fd710aa59bda..908390b4fa80 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -199,13 +199,8 @@ static struct module *new_module(const char *modname)
 	return mod;
 }
 
-/* A hash of all exported symbols,
- * struct symbol is also used for lists of unresolved symbols */
-
-#define SYMBOL_HASH_SIZE 1024
-
 struct symbol {
-	struct symbol *next;
+	struct hlist_node hash_node;
 	struct list_head list;
 	struct module *module;
 	unsigned int crc;
@@ -217,8 +212,6 @@ struct symbol {
 	char name[];
 };
 
-static struct symbol *symbolhash[SYMBOL_HASH_SIZE];
-
 /* This is based on the hash algorithm from gdbm, via tdb */
 static inline unsigned int tdb_hash(const char *name)
 {
@@ -232,38 +225,47 @@ static inline unsigned int tdb_hash(const char *name)
 	return (1103515243 * value + 12345);
 }
 
+/* useful hash macros */
+#define hash_head(table, key)		(&(table)[tdb_hash(key) % ARRAY_SIZE(table)])
+
+#define hash_add_symbol(sym, table)	hlist_add_head(&(sym)->hash_node, \
+						       hash_head(table, (sym)->name))
+
+#define hash_del_symbol(sym)		hlist_del_init(&(sym)->hash_node)
+
+#define hash_for_matched_symbol(sym, table, key) \
+	hlist_for_each_entry(sym, hash_head(table, key), hash_node) \
+		if (!strcmp(sym->name, key))
+
+#define hash_for_matched_symbol_safe(sym, n, table, key) \
+	hlist_for_each_entry_safe(sym, n, hash_head(table, key), hash_node) \
+		if (!strcmp(sym->name, key))
+
+#define HASHTABLE_DECLARE(name, size)	struct hlist_head name[size];
+
+/* hash table of all exported symbols */
+HASHTABLE_DECLARE(exported_symbols, 8192);
+
 /**
  * Allocate a new symbols for use in the hash of exported symbols or
  * the list of unresolved symbols per module
  **/
-static struct symbol *alloc_symbol(const char *name, struct symbol *next)
+static struct symbol *alloc_symbol(const char *name)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
-	s->next = next;
 
 	return s;
 }
 
-/* For the hash of exported symbols */
-static struct symbol *new_symbol(const char *name, struct module *module,
-				 enum export export)
-{
-	unsigned int hash;
-
-	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
-
-	return symbolhash[hash];
-}
 
 static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 {
 	struct symbol *sym;
 
-	sym = alloc_symbol(name, NULL);
+	sym = alloc_symbol(name);
 	sym->weak = weak;
 
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
@@ -277,9 +279,8 @@ static struct symbol *find_symbol(const char *name)
 	if (name[0] == '.')
 		name++;
 
-	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
-		if (strcmp(s->name, name) == 0)
-			return s;
+	hash_for_matched_symbol(s, exported_symbols, name) {
+		return s;
 	}
 	return NULL;
 }
@@ -412,11 +413,12 @@ static void sym_add_exported(const char *name, struct module *mod,
 		      s->module->is_vmlinux ? "" : ".ko");
 	}
 
-	s = new_symbol(name, mod, export);
+	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_static = !mod->from_dump;
 	s->export    = export;
 	list_add_tail(&s->list, &mod->exported_symbols);
+	hash_add_symbol(s, exported_symbols);
 }
 
 static void sym_set_crc(const char *name, unsigned int crc)
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 5922b0c39bb7..7c6ece1957fc 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -14,6 +14,8 @@
 #include "list.h"
 #include "elfconfig.h"
 
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
+
 /* On BSD-alike OSes elf.h defines these according to host's word size */
 #undef ELF_ST_BIND
 #undef ELF_ST_TYPE
-- 
2.32.0

