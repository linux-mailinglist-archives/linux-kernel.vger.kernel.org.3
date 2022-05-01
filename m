Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2DA5162FB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343540AbiEAIqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343496AbiEAIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:50 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12E4C78B;
        Sun,  1 May 2022 01:42:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rt008518;
        Sun, 1 May 2022 17:41:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rt008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394468;
        bh=nqOwWZU/3WvDM0nGPo3Nyua+Qk38pqiTNHwRVkuJFf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKhAqpGlRTBN2yfW448P+xDa3CHR5Udd/iH6n9/6rI7Ox0XpSOxK4l/jeJgvPgIa7
         KqD+p/NXwOWMnvA5el3GPM2k38vyfqoIWWiVvRYyEkaHUX3geSC5s6jes4496/LJDP
         +WCHX4eGjgl5ytehiUNiToxt0qALNdFQNFMOQRtupuEW/V83tRim95tXsaFB+z/FCX
         QZRXR2IhHcHMN3bBPIQRMise43ZO+rMkKUgTonTnt8ehYbeI3ZB5s/vlc5JlOsNoR3
         np8Tt/l9VqJqGMQHrDTaR5+skro6PhyiHuNNauKeM0FUHJOLUizsQF3aPJdHnuuYwT
         iGfNrZ+dJXR2g==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 08/26] modpost: traverse the namespace_list in order
Date:   Sun,  1 May 2022 17:40:14 +0900
Message-Id: <20220501084032.1025918-9-masahiroy@kernel.org>
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

Use the doubly linked list to traverse the list in the added order.
This makes the code more consistent.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 33 +++++++++++++++------------------
 scripts/mod/modpost.h |  4 ++--
 2 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 5e99493b0a82..d0cf94e1e984 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -186,6 +186,8 @@ static struct module *new_module(const char *modname)
 	memset(mod, 0, sizeof(*mod));
 
 	INIT_LIST_HEAD(&mod->unresolved_symbols);
+	INIT_LIST_HEAD(&mod->missing_namespaces);
+	INIT_LIST_HEAD(&mod->imported_namespaces);
 
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
@@ -288,39 +290,34 @@ static struct symbol *find_symbol(const char *name)
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
@@ -2190,7 +2187,7 @@ static void check_exports(struct module *mod)
 			basename = mod->name;
 
 		if (exp->namespace &&
-		    !module_imports_namespace(mod, exp->namespace)) {
+		    !contains_namespace(&mod->imported_namespaces, exp->namespace)) {
 			modpost_log(allow_missing_ns_imports ? LOG_WARN : LOG_ERROR,
 				    "module %s uses symbol %s from namespace %s, but does not import it.\n",
 				    basename, exp->name, exp->namespace);
@@ -2489,12 +2486,12 @@ static void write_namespace_deps_files(const char *fname)
 
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
index 65296eca20a1..2a8c1ad0305e 100644
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

