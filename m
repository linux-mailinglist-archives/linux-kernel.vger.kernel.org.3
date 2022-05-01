Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB76516314
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbiEAIqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245753AbiEAIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:50 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9AF4C79A;
        Sun,  1 May 2022 01:42:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2S0008518;
        Sun, 1 May 2022 17:41:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2S0008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394471;
        bh=ZUU3Y3vmA9T0Ee8Y/D7InN0T59RmqKTCWwB+kK1nhPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqC51XT+Ao9fidzBHJF7XTQNjsjC9nt77I2kKcEzxAJjxO17slLeirh36ubIaMUph
         gzzLUyrfd/L/viT5Vxds6k5MTDD4ZIOa5BXaZgOibK4i3NsJNINw96vWG5+5FOZnX/
         82ubgyjxZGMkkzw+ad1RWcS8r+ajHtSSOlE28FXS88dZleTkE5e1OX4UPymeQBNYUy
         NB26DIHh//x+zu0nG0QeGFrwpC7UZOk0Wqo4PUqbqFrfBp7HNIcgzNaFJoRFJvBn5Y
         edB2Q3rbJAytuC7AQhlMnl527dZixlhds8KzSQjGMCpDyrvjAggztWSXZqm8kpNmLl
         6G8MGITZAP4SA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 13/26] modpost: split new_symbol() to symbol allocation and hash table addition
Date:   Sun,  1 May 2022 17:40:19 +0900
Message-Id: <20220501084032.1025918-14-masahiroy@kernel.org>
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

new_symbol() does two things; allocate a new symbol and register it
to the hash table.

Using a separate function for each is easier to understand.

Replace new_symbol() with hash_add_symbol(). Remove the second parameter
of alloc_symbol().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - New patch

 scripts/mod/modpost.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c9b75697d0fc..b9f359d10968 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -242,34 +242,31 @@ static inline unsigned int tdb_hash(const char *name)
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
 	s->is_static = true;
 	return s;
 }
 
 /* For the hash of exported symbols */
-static struct symbol *new_symbol(const char *name, struct module *module,
-				 enum export export)
+static void hash_add_symbol(struct symbol *sym)
 {
 	unsigned int hash;
 
-	hash = tdb_hash(name) % SYMBOL_HASH_SIZE;
-	symbolhash[hash] = alloc_symbol(name, symbolhash[hash]);
-
-	return symbolhash[hash];
+	hash = tdb_hash(sym->name) % SYMBOL_HASH_SIZE;
+	sym->next = symbolhash[hash];
+	symbolhash[hash] = sym;
 }
 
 static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 {
 	struct symbol *sym;
 
-	sym = alloc_symbol(name, NULL);
+	sym = alloc_symbol(name);
 	sym->weak = weak;
 
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
@@ -418,10 +415,11 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 		      s->module->is_vmlinux ? "" : ".ko");
 	}
 
-	s = new_symbol(name, mod, export);
+	s = alloc_symbol(name);
 	s->module = mod;
 	s->export    = export;
 	list_add_tail(&s->list, &mod->exported_symbols);
+	hash_add_symbol(s);
 
 	return s;
 }
-- 
2.32.0

