Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5642B51630B
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiEAIqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343491AbiEAIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:50 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C484C780;
        Sun,  1 May 2022 01:42:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rq008518;
        Sun, 1 May 2022 17:41:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rq008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394466;
        bh=B+lNmWK0VYu6vQPAdnNXHiB6/Fl/C2exBpvfY8zKS7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0SrOHkYQN1gjPZisws3UrOM4hAA3OJqrs9PHgoQ9sQf6IFqZIsFJ3H3j/Qjzq3Kl
         ggaYbhCBnpvRsrNTRGmLFOuKgzfnQpfEFyrqIIFGy3VvVdCXpcHEodXMqbeRcrdzSa
         JJLJgXZx1yrAAS1DbkcII4bhtBgGPAbcPKb3qwBp9VzfxUb4scVp/FHy55GMGXUPrc
         XFf5Z4Sid7WkwpaTMDY6UbDC4FuigP1z/ElwgR5Wd2FYenn7S2e2qSel+eE/RepEMz
         zOfcciSkTxLUyCXzCdw6Zb7VtcS29lfL1/ufDyBf8fB32DjHelg6mzSrYQ01c6T+9K
         S6D/WrQo5aWPQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 05/26] modpost: add sym_add_unresolved() helper
Date:   Sun,  1 May 2022 17:40:11 +0900
Message-Id: <20220501084032.1025918-6-masahiroy@kernel.org>
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

Add a small helper, sym_add_unresolved() to ease the further
refactoring.

Remove the 'weak' argument from alloc_symbol() because it is sensible
only for unresolved symbols.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 553e5cf88fee..abcdb0677775 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -236,14 +236,12 @@ static inline unsigned int tdb_hash(const char *name)
  * Allocate a new symbols for use in the hash of exported symbols or
  * the list of unresolved symbols per module
  **/
-static struct symbol *alloc_symbol(const char *name, bool weak,
-				   struct symbol *next)
+static struct symbol *alloc_symbol(const char *name, struct symbol *next)
 {
 	struct symbol *s = NOFAIL(malloc(sizeof(*s) + strlen(name) + 1));
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
-	s->weak = weak;
 	s->next = next;
 	s->is_static = true;
 	return s;
@@ -256,11 +254,17 @@ static struct symbol *new_symbol(const char *name, struct module *module,
 	unsigned int hash;
 
 	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	symbolhash[hash] = alloc_symbol(name, false, symbolhash[hash]);
+	symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
 
 	return symbolhash[hash];
 }
 
+static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
+{
+	mod->unres = alloc_symbol(name, mod->unres);
+	mod->unres->weak = weak;
+}
+
 static struct symbol *find_symbol(const char *name)
 {
 	struct symbol *s;
@@ -712,9 +716,8 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 			}
 		}
 
-		mod->unres = alloc_symbol(symname,
-					  ELF_ST_BIND(sym->st_info) == STB_WEAK,
-					  mod->unres);
+		sym_add_unresolved(symname, mod,
+				   ELF_ST_BIND(sym->st_info) == STB_WEAK);
 		break;
 	default:
 		/* All exported symbols */
@@ -2082,7 +2085,7 @@ static void read_symbols(const char *modname)
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
 	if (modversions)
-		mod->unres = alloc_symbol("module_layout", false, mod->unres);
+		sym_add_unresolved("module_layout", mod, false);
 }
 
 static void read_symbols_from_files(const char *filename)
-- 
2.32.0

