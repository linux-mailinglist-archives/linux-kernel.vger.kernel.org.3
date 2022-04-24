Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AB50D4B1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237204AbiDXTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238310AbiDXTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:54 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5872BFF;
        Sun, 24 Apr 2022 12:10:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o63019069;
        Mon, 25 Apr 2022 04:08:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o63019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827337;
        bh=4VwlsHdKnI97n8eITvMnw7a1k5Sa+J49aS2TPed1vyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DsHUQgWImFEExdp1jJRQC6FpRj1SL/YHOnwlC4xh/963JxECS/k8LgIl8G1m6FmyW
         BaDLv5/jQEus6v2gwoxp2fYqWnrjIaB1DDSDKG7b0Hxx4eZ7KBsd83NZK1/MFLSDTQ
         W98gZ+p5IIVZXxSkTE9+KwWfv4vVKr5lpqzHZKk3kvPe0eDjqcjMAYWeJuqJjFrA6g
         iI6bQ7d6LtEYgH1nHNoCgALs4+uMtWrjZdeJE3X0dYraNa9vVT5SKHtTJRpHNAxKxi
         z4NXjxFfUkQZevPtrc8t1NEAYyVg24DLh7VGgkVCZXfE/TD7n+h6uh7MtxHglSozBf
         VnX/5pTORSZeQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 09/27] modpost: add sym_add_unresolved() helper
Date:   Mon, 25 Apr 2022 04:07:53 +0900
Message-Id: <20220424190811.1678416-10-masahiroy@kernel.org>
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

Add a small helper, sym_add_unresolved() to ease the further
refactoring.

Remove the 'weak' argument from alloc_symbol() because it is sensible
only for unresolved symbols.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 86416e4af626..1c7d2831e89d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -230,14 +230,12 @@ static inline unsigned int tdb_hash(const char *name)
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
@@ -250,11 +248,17 @@ static struct symbol *new_symbol(const char *name, struct module *module,
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
@@ -701,9 +705,8 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
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
@@ -2073,7 +2076,7 @@ static void read_symbols(const char *modname)
 	 * the automatic versioning doesn't pick it up, but it's really
 	 * important anyhow */
 	if (modversions)
-		mod->unres = alloc_symbol("module_layout", false, mod->unres);
+		sym_add_unresolved("module_layout", mod, false);
 }
 
 static void read_symbols_from_files(const char *filename)
-- 
2.32.0

