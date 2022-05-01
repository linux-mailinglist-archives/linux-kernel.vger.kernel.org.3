Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721D75162EF
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbiEAIpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiEAIps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:48 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC524C434;
        Sun,  1 May 2022 01:42:23 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rr008518;
        Sun, 1 May 2022 17:41:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rr008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394466;
        bh=YzFh8n36dC/Y57W+XPof+oSXPIE4BbH7mX21y8+hRrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8IPszMBmbSN5tKnHK2LszQEx5Hs7qYx0NBUphyHUMZBKg91PIZd7FVWgOxwZz20j
         aGwHoukGiYA4rzbDZv8z/WQLfvLGP3OGdsOaC7BMN+lXgvUd9VYaKTg22SgGdmm5yn
         GsOdElr7i2Zh6N5fXSEU1eTde8FUTeUDwQC43YNXR501WUJ7CFq922ltY+walukeO4
         50VtcOqUwtMtzOaIUS8tkbVuX5rzhrF16rf1IcCT1AweozvONRcNdvhsOW5DoWBnXE
         VrgQbw4xq+96EKJqCkY6MM4gmIOTph0hcYQQsxVQBCbpS1MpzKsGkOvNLIfodgJBHD
         11WxMw7qM5gMA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 06/26] modpost: traverse unresolved symbols in order
Date:   Sun,  1 May 2022 17:40:12 +0900
Message-Id: <20220501084032.1025918-7-masahiroy@kernel.org>
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

Currently, modpost manages unresolved in a singly linked list; it adds
a new node to the head, and traverses the list from new to old.

Use a doubly linked list to keep the order in the symbol table in the
ELF file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/mod/modpost.c | 20 ++++++++++++++------
 scripts/mod/modpost.h |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index abcdb0677775..c7dda4cfa497 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -185,6 +185,8 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
+	INIT_LIST_HEAD(&mod->unresolved_symbols);
+
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 
@@ -207,6 +209,7 @@ static struct module *new_module(const char *modname)
 
 struct symbol {
 	struct symbol *next;
+	struct list_head list;	/* link to module::unresolved_symbols */
 	struct module *module;
 	char *namespace;
 	unsigned int crc;
@@ -261,8 +264,12 @@ static struct symbol *new_symbol(const char *name, struct module *module,
 
 static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 {
-	mod->unres = alloc_symbol(name, mod->unres);
-	mod->unres->weak = weak;
+	struct symbol *sym;
+
+	sym = alloc_symbol(name, NULL);
+	sym->weak = weak;
+
+	list_add_tail(&sym->list, &mod->unresolved_symbols);
 }
 
 static struct symbol *find_symbol(const char *name)
@@ -2156,7 +2163,7 @@ static void check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
 
-	for (s = mod->unres; s; s = s->next) {
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		const char *basename;
 		exp = find_symbol(s->name);
 		if (!exp) {
@@ -2277,7 +2284,7 @@ static void add_versions(struct buffer *b, struct module *mod)
 	buf_printf(b, "static const struct modversion_info ____versions[]\n");
 	buf_printf(b, "__used __section(\"__versions\") = {\n");
 
-	for (s = mod->unres; s; s = s->next) {
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		if (!s->module)
 			continue;
 		if (!s->crc_valid) {
@@ -2303,13 +2310,14 @@ static void add_depends(struct buffer *b, struct module *mod)
 	int first = 1;
 
 	/* Clear ->seen flag of modules that own symbols needed by this. */
-	for (s = mod->unres; s; s = s->next)
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		if (s->module)
 			s->module->seen = s->module->is_vmlinux;
+	}
 
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(depends, \"");
-	for (s = mod->unres; s; s = s->next) {
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		const char *p;
 		if (!s->module)
 			continue;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index d0a8ab60f413..65296eca20a1 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -111,8 +111,8 @@ buf_write(struct buffer *buf, const char *s, int len);
 
 struct module {
 	struct list_head list;
+	struct list_head unresolved_symbols;
 	bool is_gpl_compatible;
-	struct symbol *unres;
 	bool from_dump;		/* true if module was loaded from *.symvers */
 	bool is_vmlinux;
 	bool seen;
-- 
2.32.0

