Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE77250D4A5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbiDXTOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238258AbiDXTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:50 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7760C6319;
        Sun, 24 Apr 2022 12:10:10 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o68019069;
        Mon, 25 Apr 2022 04:08:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o68019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827340;
        bh=oqndtVYLCIBDWZ0aZIcaRbv9dV6V+z9+SQafKWTziNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSqgA7XzxoyIReg4ZWYjGaBUbYOXzhtkTERl8PdvjUi+YGD6W3X5FdDXTzMkQjx73
         4UUFssushX0QylqndSnQYg7EP73MIEAIh81tmozHAfEtysegRZLqFbOsWLUYF0Ccex
         LccqF64N9g4FbqKHOThUfvYjeSGNRvluqwX+qN0XBY3C9AsxpLTyLiM0r5zpVnu20v
         vq7KqrKOBi20ChKYhtqvAFx9QsZd0g7dnLoQTF4qzWwTifDSeLrStK8+/aE6ER5iAa
         cL0JrHrdvw2M8P5Frnvf5Cotd6fcKHP1aTkxAJmKaidLDrhmvRNu+h4J73PhDszfoD
         y32pVoB0CS/5Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 14/27] modpost: dump Module.symvers in the same order of modules.order
Date:   Mon, 25 Apr 2022 04:07:58 +0900
Message-Id: <20220424190811.1678416-15-masahiroy@kernel.org>
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

modpost dumps the exported symbols into Module.symvers, but currently
in random order because it iterates in the hash table.

Add a linked list of exported symbols in struct module, so we can
iterate on symbols per module.

This commit makes Module.symvers much more readable; the outer loop in
write_dump() iterates over the modules in the order of modules.order,
and the inner loop dumps symbols in each module.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 27 ++++++++++++---------------
 scripts/mod/modpost.h |  1 +
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e23e416213bf..1793396e1323 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -185,6 +185,7 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
+	INIT_LIST_HEAD(&mod->exported_symbols);
 	INIT_LIST_HEAD(&mod->unresolved_symbols);
 	INIT_LIST_HEAD(&mod->missing_namespaces);
 	INIT_LIST_HEAD(&mod->imported_namespaces);
@@ -407,6 +408,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 
 	if (!s) {
 		s = new_symbol(name, mod, export);
+		list_add_tail(&s->list, &mod->exported_symbols);
 	} else if (!external_module || s->module->is_vmlinux ||
 		   s->module == mod) {
 		warn("%s: '%s' exported twice. Previous export was in %s%s\n",
@@ -2452,22 +2454,17 @@ static void read_dump(const char *fname)
 static void write_dump(const char *fname)
 {
 	struct buffer buf = { };
-	struct symbol *symbol;
-	const char *namespace;
-	int n;
+	struct module *mod;
+	struct symbol *sym;
 
-	for (n = 0; n < SYMBOL_HASH_SIZE ; n++) {
-		symbol = symbolhash[n];
-		while (symbol) {
-			if (!symbol->module->from_dump) {
-				namespace = symbol->namespace;
-				buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
-					   symbol->crc, symbol->name,
-					   symbol->module->name,
-					   export_str(symbol->export),
-					   namespace ? namespace : "");
-			}
-			symbol = symbol->next;
+	list_for_each_entry(mod, &modules, list) {
+		if (mod->from_dump)
+			continue;
+		list_for_each_entry(sym, &mod->exported_symbols, list) {
+			buf_printf(&buf, "0x%08x\t%s\t%s\t%s\t%s\n",
+				   sym->crc, sym->name, mod->name,
+				   export_str(sym->export),
+				   sym->namespace ?: "");
 		}
 	}
 	write_buf(&buf, fname);
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 4cb955dda83f..5922b0c39bb7 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -112,6 +112,7 @@ buf_write(struct buffer *buf, const char *s, int len);
 struct module {
 	struct list_head list;
 	int gpl_compatible;
+	struct list_head exported_symbols;
 	struct list_head unresolved_symbols;
 	bool from_dump;		/* true if module was loaded from *.symvers */
 	bool is_vmlinux;
-- 
2.32.0

