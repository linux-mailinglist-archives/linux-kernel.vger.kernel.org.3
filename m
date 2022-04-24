Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA84B50D497
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiDXTN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbiDXTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:43 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C38025D2;
        Sun, 24 Apr 2022 12:10:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o64019069;
        Mon, 25 Apr 2022 04:08:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o64019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827337;
        bh=fbQgQihQZlSAoYRQ3/uUrvYb8jl+nm2vZ6VGCwK3C3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oyAFfLJZoyzeeCqzzc44kXA60+ey7t6uF6/DGhomg1Lm/KPigvAfbpgFNS8fxfnhh
         mULQaVMcMpaC1lBK69NDjnCPDNCLMBOncnxzFE4EqyHIuwHSEQLH1V2Rrkl/Y339Rl
         i8PlutKr4tcblnj6VDWhEOUVR8zKaoj/4OyPgF6oEjOnyTSuszYhBy7O7zuafStmvG
         xz6CA5PtSsLqcu8+2G7PCe0KtCdm1KPB5iMqKwu6zebI+zdOaCN3hD4rfOLDwTlIpS
         ZM8tK+Eu4UZeeHwccEV2DjDLqARmE7sAUshQW6V36dBfoo9ABXefsjtEkyjdsF2FnF
         p/Wk1yHzyFsaQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 10/27] modpost: traverse unresolved symbols in order
Date:   Mon, 25 Apr 2022 04:07:54 +0900
Message-Id: <20220424190811.1678416-11-masahiroy@kernel.org>
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

Currently, modpost manages unresolved in a singly liked list; it adds
a new node to the head, and traverses the list from new to old.

Use a doubly linked list to keep the order in the symbol table in the
ELF file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 20 ++++++++++++++------
 scripts/mod/modpost.h |  2 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1c7d2831e89d..e1eb188d6282 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -185,6 +185,8 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
+	INIT_LIST_HEAD(&mod->unresolved_symbols);
+
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 	mod->gpl_compatible = true;
@@ -201,6 +203,7 @@ static struct module *new_module(const char *modname)
 
 struct symbol {
 	struct symbol *next;
+	struct list_head list;
 	struct module *module;
 	unsigned int crc;
 	bool crc_valid;
@@ -255,8 +258,12 @@ static struct symbol *new_symbol(const char *name, struct module *module,
 
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
@@ -2147,7 +2154,7 @@ static void check_exports(struct module *mod)
 {
 	struct symbol *s, *exp;
 
-	for (s = mod->unres; s; s = s->next) {
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		const char *basename;
 		exp = find_symbol(s->name);
 		if (!exp) {
@@ -2268,7 +2275,7 @@ static void add_versions(struct buffer *b, struct module *mod)
 	buf_printf(b, "static const struct modversion_info ____versions[]\n");
 	buf_printf(b, "__used __section(\"__versions\") = {\n");
 
-	for (s = mod->unres; s; s = s->next) {
+	list_for_each_entry(s, &mod->unresolved_symbols, list) {
 		if (!s->module)
 			continue;
 		if (!s->crc_valid) {
@@ -2294,13 +2301,14 @@ static void add_depends(struct buffer *b, struct module *mod)
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
index c3b5d2f0e2bb..6a90bfc08458 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -117,7 +117,7 @@ struct namespace_list {
 struct module {
 	struct list_head list;
 	int gpl_compatible;
-	struct symbol *unres;
+	struct list_head unresolved_symbols;
 	bool from_dump;		/* true if module was loaded from *.symvers */
 	bool is_vmlinux;
 	bool seen;
-- 
2.32.0

