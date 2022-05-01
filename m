Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B251630F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344102AbiEAIrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343590AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF3C4C7BE;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Ru008518;
        Sun, 1 May 2022 17:41:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Ru008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394468;
        bh=b7dWhvTr9FrQ+5Dw80ljJlpc6iDLA8xOJ7ErDXQoiLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R13VRpUybqhQRpyVbQu+a3VqGuVr5Lo089hvMLNpmQbqn3HWZ2bG0jMf8x96YikTn
         UdvblE148Z0hgr3flP3TJnc66HF08ogif9sulMtKZT27oEbpMfEyBz07LZ4xOVxmF1
         l6vrZweWt8OzMRN4ckm+yLsBozkqrtU9msAz9CG6TL0sYDrdG5G329q7dN9fw/VsAI
         hwpFdMAubQRy5BUDgUsM/pgzdQJbnk0scxpXeAEETXt3+UrAbWtBHXiEzst9h3S+AO
         MAjltbzQ8HE5WCJi0kiXuih7QO3T1pbKzZojBgKAmNlMcX1oFc7VS6HDk36oKPJ8m6
         A1fnTX4rkPBsg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 09/26] modpost: dump Module.symvers in the same order of modules.order
Date:   Sun,  1 May 2022 17:40:15 +0900
Message-Id: <20220501084032.1025918-10-masahiroy@kernel.org>
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

modpost dumps the exported symbols into Module.symvers, but currently
in random order because it iterates in the hash table.

Add a linked list of exported symbols in struct module, so we can
iterate on symbols per module.

This commit makes Module.symvers much more readable; the outer loop in
write_dump() iterates over the modules in the order of modules.order,
and the inner loop dumps symbols in each module.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 29 +++++++++++++----------------
 scripts/mod/modpost.h |  1 +
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d0cf94e1e984..cd49ef7b5953 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -185,6 +185,7 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
+	INIT_LIST_HEAD(&mod->exported_symbols);
 	INIT_LIST_HEAD(&mod->unresolved_symbols);
 	INIT_LIST_HEAD(&mod->missing_namespaces);
 	INIT_LIST_HEAD(&mod->imported_namespaces);
@@ -211,7 +212,7 @@ static struct module *new_module(const char *modname)
 
 struct symbol {
 	struct symbol *next;
-	struct list_head list;	/* link to module::unresolved_symbols */
+	struct list_head list;	/* link to module::exported_symbols or module::unresolved_symbols */
 	struct module *module;
 	char *namespace;
 	unsigned int crc;
@@ -413,6 +414,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 
 	if (!s) {
 		s = new_symbol(name, mod, export);
+		list_add_tail(&s->list, &mod->exported_symbols);
 	} else if (!external_module || s->module->is_vmlinux ||
 		   s->module == mod) {
 		warn("%s: '%s' exported twice. Previous export was in %s%s\n",
@@ -2456,22 +2458,17 @@ static void read_dump(const char *fname)
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
index 2a8c1ad0305e..1c2d6498d764 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -111,6 +111,7 @@ buf_write(struct buffer *buf, const char *s, int len);
 
 struct module {
 	struct list_head list;
+	struct list_head exported_symbols;
 	struct list_head unresolved_symbols;
 	bool is_gpl_compatible;
 	bool from_dump;		/* true if module was loaded from *.symvers */
-- 
2.32.0

