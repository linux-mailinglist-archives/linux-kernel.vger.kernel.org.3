Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B62E50D4A7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiDXTOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238124AbiDXTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:48 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF5BA64FC;
        Sun, 24 Apr 2022 12:10:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o67019069;
        Mon, 25 Apr 2022 04:08:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o67019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827339;
        bh=kE3YmacwRc4w88KruYVhB9uFU4llfm9uxH0kRa2UuWE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URbGOQa7nj4mk+0Ham1C85tpC48ZZ4kGppiS6TTGNc65Nnt8wJ+tXmXYMYaKlxUXa
         1woY4y1nO5QJTj6vsuAA+7mWihaz8s8NBQUe4p9ojRHrfK+Axb9sLPtEzLPAxeBrue
         scY9ODtfpfzNaY9C1c8SZWEpnhrPG1RoJea6mrI3PuCmpDdPjtsjK6A5QWUq1H/Fu3
         KHs1cDgCgl1GUTLuzgCS4AIe7YHlO2qz1mHbC8IZ+JHAs9glF25+Tad8iJG303w95l
         ryBXzB7NQ0cYxJZoemIMCKcpeigX8dN9aj3Gp0mvwS721Z5ENZ6be9aM9JoQX7BMh3
         9DnBTZhIiGmqw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 13/27] modpost: traverse the namespace_list in order
Date:   Mon, 25 Apr 2022 04:07:57 +0900
Message-Id: <20220424190811.1678416-14-masahiroy@kernel.org>
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

Use the doubly linked list to traverse the list in the added order.
This makes the code more consistent.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 33 +++++++++++++++------------------
 scripts/mod/modpost.h |  4 ++--
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6f2748340746..e23e416213bf 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -186,6 +186,8 @@ static struct module *new_module(const char *modname)
 	memset(mod, 0, sizeof(*mod));
 
 	INIT_LIST_HEAD(&mod->unresolved_symbols);
+	INIT_LIST_HEAD(&mod->missing_namespaces);
+	INIT_LIST_HEAD(&mod->imported_namespaces);
 
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
@@ -282,39 +284,34 @@ static struct symbol *find_symbol(const char *name)
 }
 
 struct namespace_list {
-	struct namespace_list *next;
+	struct list_head list;
 	char namespace[];
 };
 
-static bool contains_namespace(struct namespace_list *list,
-			       const char *namespace)
+static bool contains_namespace(struct list_head *head, const char *namespace)
 {
-	for (; list; list = list->next)
+	struct namespace_list *list;
+
+	list_for_each_entry(list, head, list) {
 		if (!strcmp(list->namespace, namespace))
 			return true;
+	}
 
 	return false;
 }
 
-static void add_namespace(struct namespace_list **list, const char *namespace)
+static void add_namespace(struct list_head *head, const char *namespace)
 {
 	struct namespace_list *ns_entry;
 
-	if (!contains_namespace(*list, namespace)) {
-		ns_entry = NOFAIL(malloc(sizeof(struct namespace_list) +
+	if (!contains_namespace(head, namespace)) {
+		ns_entry = NOFAIL(malloc(sizeof(*ns_entry) +
 					 strlen(namespace) + 1));
 		strcpy(ns_entry->namespace, namespace);
-		ns_entry->next = *list;
-		*list = ns_entry;
+		list_add_tail(&ns_entry->list, head);
 	}
 }
 
-static bool module_imports_namespace(struct module *module,
-				     const char *namespace)
-{
-	return contains_namespace(module->imported_namespaces, namespace);
-}
-
 static const struct {
 	const char *str;
 	enum export export;
@@ -2186,7 +2183,7 @@ static void check_exports(struct module *mod)
 			basename = mod->name;
 
 		if (exp->namespace &&
-		    !module_imports_namespace(mod, exp->namespace)) {
+		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -2485,12 +2482,12 @@ static void write_namespace_deps_files(const char *fname)
 
 	list_for_each_entry(mod, &modules, list) {
 
-		if (mod->from_dump || !mod->missing_namespaces)
+		if (mod->from_dump || list_empty(&mod->missing_namespaces))
 			continue;
 
 		buf_printf(&ns_deps_buf, "%s.ko:", mod->name);
 
-		for (ns = mod->missing_namespaces; ns; ns = ns->next)
+		list_for_each_entry(ns, &mod->missing_namespaces, list)
 			buf_printf(&ns_deps_buf, " %s", ns->namespace);
 
 		buf_printf(&ns_deps_buf, "\n");
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 2dbafbda9b0f..4cb955dda83f 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -120,9 +120,9 @@ struct module {
 	struct buffer dev_table_buf;
 	char	     srcversion[25];
 	// Missing namespace dependencies
-	struct namespace_list *missing_namespaces;
+	struct list_head missing_namespaces;
 	// Actual imported namespaces
-	struct namespace_list *imported_namespaces;
+	struct list_head imported_namespaces;
 	char name[];
 };
 
-- 
2.32.0

