Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6FE516305
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbiEAIq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6595B4CD46;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rm008518;
        Sun, 1 May 2022 17:41:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rm008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394463;
        bh=riwb9QXv2hBu8N0z69a0HeQiTrS7A0gFffoIzVXlCFg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkENgDXPBL+1BgLUl1hlgNuoabXEFcqOfBQSCxIXzUX8z2EGma6sAyZV/YMP3jMpt
         8ylZcPPqpmR78gYD8W5/vRZjTM8E5VWYbIzTonvPNvrYKkKt4Eaf6Cxg75AmdnUFNV
         yVtTTLr8oTxIWXWUjRPtSpGDkk1MNU3Ynz0eYLiUGYCsyUAjFPYgOcMAYyMkC3nxmb
         dfTBNEReithIHYI3vpSnDlKM8y7RnAjGiOVPROmFNjJZbtknwV5NFlfoK0OonvdPWm
         /yOJSHTRsaX8a8lgIU1LPFxWpnkMyoTzqgwvyObB8rmxu6q9o+q7WeVvlYj+MTHtXF
         2+TMfXMzc3Bcw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 01/26] modpost: use bool type where appropriate
Date:   Sun,  1 May 2022 17:40:07 +0900
Message-Id: <20220501084032.1025918-2-masahiroy@kernel.org>
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

Use 'bool' to clarify that the valid value is true or false.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - postpone mod->gpl_compatible change
  - change is_static_library() as well

 scripts/mod/modpost.c    | 56 ++++++++++++++++++++--------------------
 scripts/mod/modpost.h    | 10 +++----
 scripts/mod/sumversion.c |  8 +++---
 3 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 689a34229809..a6035ab78cd8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -23,20 +23,20 @@
 #include "../../include/linux/license.h"
 
 /* Are we using CONFIG_MODVERSIONS? */
-static int modversions;
+static bool modversions;
 /* Is CONFIG_MODULE_SRCVERSION_ALL set? */
-static int all_versions;
+static bool all_versions;
 /* If we are modposting external module set to 1 */
-static int external_module;
+static bool external_module;
 /* Only warn about unresolved symbols */
-static int warn_unresolved;
+static bool warn_unresolved;
 /* How a symbol is exported */
 static int sec_mismatch_count;
-static int sec_mismatch_warn_only = true;
+static bool sec_mismatch_warn_only = true;
 /* ignore missing files */
-static int ignore_missing_files;
+static bool ignore_missing_files;
 /* If set to 1, only warn (instead of error) about missing ns imports */
-static int allow_missing_ns_imports;
+static bool allow_missing_ns_imports;
 
 static bool error_occurred;
 
@@ -202,11 +202,11 @@ static struct module *new_module(const char *modname)
 struct symbol {
 	struct symbol *next;
 	struct module *module;
-	unsigned int crc;
-	int crc_valid;
 	char *namespace;
-	unsigned int weak:1;
-	unsigned int is_static:1;  /* 1 if symbol is not global */
+	unsigned int crc;
+	bool crc_valid;
+	bool weak;
+	bool is_static;		/* true if symbol is not global */
 	enum export  export;       /* Type of export */
 	char name[];
 };
@@ -230,7 +230,7 @@ static inline unsigned int tdb_hash(const char *name)
  * Allocate a new symbols for use in the hash of exported symbols or
  * the list of unresolved symbols per module
  **/
-static struct symbol *alloc_symbol(const char *name, unsigned int weak,
+static struct symbol *alloc_symbol(const char *name, bool weak,
 				   struct symbol *next)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
@@ -239,7 +239,7 @@ static struct symbol *alloc_symbol(const char *name, unsigned int weak,
 	strcpy(s->name, name);
 	s->weak = weak;
 	s->next = next;
-	s->is_static = 1;
+	s->is_static = true;
 	return s;
 }
 
@@ -250,7 +250,7 @@ static struct symbol *new_symbol(const char *name, struct module *module,
 	unsigned int hash;
 
 	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	symbolhash[hash] = alloc_symbol(name, 0, symbolhash[hash]);
+	symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
 
 	return symbolhash[hash];
 }
@@ -424,7 +424,7 @@ static void sym_set_crc(const char *name, unsigned int crc)
 		return;
 
 	s->crc = crc;
-	s->crc_valid = 1;
+	s->crc_valid = true;
 }
 
 static void *grab_file(const char *filename, size_t *size)
@@ -721,9 +721,9 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 			sym_add_exported(name, mod, export);
 		}
 		if (strcmp(symname, "init_module") == 0)
-			mod->has_init = 1;
+			mod->has_init = true;
 		if (strcmp(symname, "cleanup_module") == 0)
-			mod->has_cleanup = 1;
+			mod->has_cleanup = true;
 		break;
 	}
 }
@@ -2058,7 +2058,7 @@ static void read_symbols(const char *modname)
 						       sym->st_name));
 
 			if (s)
-				s->is_static = 0;
+				s->is_static = false;
 		}
 	}
 
@@ -2078,7 +2078,7 @@ static void read_symbols(const char *modname)
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
 	if (modversions)
-		mod->unres = alloc_symbol("module_layout", 0, mod->unres);
+		mod->unres = alloc_symbol("module_layout", false, mod->unres);
 }
 
 static void read_symbols_from_files(const char *filename)
@@ -2310,7 +2310,7 @@ static void add_depends(struct buffer *b, struct module *mod)
 		if (s->module->seen)
 			continue;
 
-		s->module->seen = 1;
+		s->module->seen = true;
 		p = strrchr(s->module->name, '/');
 		if (p)
 			p++;
@@ -2427,10 +2427,10 @@ static void read_dump(const char *fname)
 		mod = find_module(modname);
 		if (!mod) {
 			mod = new_module(modname);
-			mod->from_dump = 1;
+			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, export_no(export));
-		s->is_static = 0;
+		s->is_static = false;
 		sym_set_crc(symname, crc);
 		sym_update_namespace(symname, namespace);
 	}
@@ -2508,7 +2508,7 @@ int main(int argc, char **argv)
 	while ((opt = getopt(argc, argv, "ei:mnT:o:awENd:")) != -1) {
 		switch (opt) {
 		case 'e':
-			external_module = 1;
+			external_module = true;
 			break;
 		case 'i':
 			*dump_read_iter =
@@ -2517,28 +2517,28 @@ int main(int argc, char **argv)
 			dump_read_iter = &(*dump_read_iter)->next;
 			break;
 		case 'm':
-			modversions = 1;
+			modversions = true;
 			break;
 		case 'n':
-			ignore_missing_files = 1;
+			ignore_missing_files = true;
 			break;
 		case 'o':
 			dump_write = optarg;
 			break;
 		case 'a':
-			all_versions = 1;
+			all_versions = true;
 			break;
 		case 'T':
 			files_source = optarg;
 			break;
 		case 'w':
-			warn_unresolved = 1;
+			warn_unresolved = true;
 			break;
 		case 'E':
 			sec_mismatch_warn_only = false;
 			break;
 		case 'N':
-			allow_missing_ns_imports = 1;
+			allow_missing_ns_imports = true;
 			break;
 		case 'd':
 			missing_namespace_deps = optarg;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 96d6b3a16ca2..7ccfcc8899c1 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -111,11 +112,10 @@ struct module {
 	struct module *next;
 	int gpl_compatible;
 	struct symbol *unres;
-	int from_dump;  /* 1 if module was loaded from *.symvers */
-	int is_vmlinux;
-	int seen;
-	int has_init;
-	int has_cleanup;
+	bool from_dump;		/* true if module was loaded from *.symvers */
+	bool is_vmlinux;
+	bool seen;
+	bool has_init, has_cleanup;
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	// Missing namespace dependencies
diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index 79bb9eaa65ac..6bf9caca0968 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -290,13 +290,11 @@ static int parse_file(const char *fname, struct md4_ctx *md)
 	return 1;
 }
 /* Check whether the file is a static library or not */
-static int is_static_library(const char *objfile)
+static bool is_static_library(const char *objfile)
 {
 	int len = strlen(objfile);
-	if (objfile[len - 2] == '.' && objfile[len - 1] == 'a')
-		return 1;
-	else
-		return 0;
+
+	return objfile[len - 2] == '.' && objfile[len - 1] == 'a';
 }
 
 /* We have dir/file.o.  Open dir/.file.o.cmd, look for source_ and deps_ line
-- 
2.32.0

