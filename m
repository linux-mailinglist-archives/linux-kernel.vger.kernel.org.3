Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE0546C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350081AbiFJSfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbiFJSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:47 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165063A5C7;
        Fri, 10 Jun 2022 11:34:38 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TS020882;
        Sat, 11 Jun 2022 03:33:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TS020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885992;
        bh=Fv4Q2sQU9/jGRzTAgd2r3B6fBk4S6c2Z53z5KaB5G4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfczt2NaxLXAYn3OGPGpV6wFMUIu/m80wEWYFsaxM/S5uFGRFQ6O89+xGr1tOfYuy
         vo6Llz4Romdo1QylXEvMULly0QGTjRm1mMATFSVxsnAGZOOfix9T3SSGStb8iHYfRj
         tX8OlJcBk5E9XLgafJ04nlTrRYAiHP+pEFubun4vM8NihUwanoO3MZPZj4aMA7rEuk
         Uk0VRqv+RYi/6kxiG++sqYpDiK5p0ope/uODBcjZQ063s4meH/RWTpUZA4e3iNTlSP
         O6+BVb4nwQj6+4sDeTeekpZQSFz9VwAbakRvxO1+F6h/pFnAW996aBg4BmFtZlzt4G
         BhsgcuKfnErgg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] modpost: use null string instead of NULL pointer for default namespace
Date:   Sat, 11 Jun 2022 03:32:36 +0900
Message-Id: <20220610183236.1272216-8-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default namespace is the null string, "".

When set, the null string "" is converted to NULL:

  s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;

When printed, the NULL pointer is get back to the null string:

  sym->namespace ?: ""

This saves 1 byte memory allocated for "", but loses the readability.

In kernel-space, we strive to save memory, but modpost is a userspace
tool used to build the kernel. On modern systems, such small piece of
memory is not a big deal.

Handle the namespace string as is.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 0db2cbb74a2a..5a1785645943 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -296,6 +296,13 @@ static bool contains_namespace(struct list_head *head, const char *namespace)
 {
 	struct namespace_list *list;
 
+	/*
+	 * The default namespace is null string "", which is always implicitly
+	 * contained.
+	 */
+	if (!namespace[0])
+		return true;
+
 	list_for_each_entry(list, head, list) {
 		if (!strcmp(list->namespace, namespace))
 			return true;
@@ -371,7 +378,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	s->namespace = NOFAIL(strdup(namespace));
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -2117,8 +2124,7 @@ static void check_exports(struct module *mod)
 		else
 			basename = mod->name;
 
-		if (exp->namespace &&
-		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
+		if (!contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -2201,7 +2207,7 @@ static void add_exported_symbols(struct buffer *buf, struct module *mod)
 	list_for_each_entry(sym, &mod->exported_symbols, list)
 		buf_printf(buf, "KSYMTAB_ENTRY(%s, \"%s\", \"%s\");\n",
 			   sym->name, sym->is_gpl_only ? "_gpl" : "",
-			   sym->namespace ?: "");
+			   sym->namespace);
 
 	if (!modversions)
 		return;
@@ -2471,7 +2477,7 @@ static void write_dump(const char *fname)
 			buf_printf(&buf, "0x%08x\t%s\t%s\tEXPORT_SYMBOL%s\t%s\n",
 				   sym->crc, sym->name, mod->name,
 				   sym->is_gpl_only ? "_GPL" : "",
-				   sym->namespace ?: "");
+				   sym->namespace);
 		}
 	}
 	write_buf(&buf, fname);
-- 
2.32.0

