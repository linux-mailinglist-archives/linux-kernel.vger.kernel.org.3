Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A1A516307
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbiEAIr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343613AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACCC4CD6C;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rp008518;
        Sun, 1 May 2022 17:41:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rp008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394465;
        bh=WIjeLRAhpYr77UzE5z2GZ8qpEcsYuKMA0+vtG/T0sEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWhbEHB2LfoKudqj2e7VzODAteAFp9dm3/ccrf/HtSQvDb9LzW3g2EV85qa9n9BVN
         BDE6lEOMz+MtjrI1h3iC8B7q4WXKRyv6q9uht7dr4RW89ytax8eX5BZTu/uPmROSNR
         +BuyF2gSjLHj+y1LxTKuf56Dwz71PwzMXxTskuuAihsUC7yBVDxc4P6+IEX2tPGDmO
         eDAZhQ8LwWHJeyvK+2kgk+coTDGASKvexSlLC1WlqgeGu/0vU0mwwifPhSb85/ASa2
         7kp6lPgQAVfSgdHJyUSCnJ7hCBcOLZgY8/hiuaAuek+7V8cSVsOfbXb7HB8E1M+Ul4
         nHpP1F4/zQ8oA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 04/26] modpost: traverse modules in order
Date:   Sun,  1 May 2022 17:40:10 +0900
Message-Id: <20220501084032.1025918-5-masahiroy@kernel.org>
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

Currently, modpost manages modules in a singly linked list; it adds
a new node to the head, and traverses the list from new to old.

It works, but the error messages are shown in the reverse order.

If you have a Makefile like this:

  obj-m += foo.o bar.o

then, modpost shows error messages in bar.o, foo.o, in this order.

Use a doubly linked list to keep the order in modules.order; use
list_add_tail() for the node addition and list_for_each_entry() for
the list traverse.

Now that the kernel's list macros have been imported to modpost, I will
use them actively going forward.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 17 ++++++++---------
 scripts/mod/modpost.h |  3 ++-
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f2d6c152cd3f..553e5cf88fee 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -165,16 +165,17 @@ char *get_line(char **stringp)
 }
 
 /* A list of all modules we processed */
-static struct module *modules;
+LIST_HEAD(modules);
 
 static struct module *find_module(const char *modname)
 {
 	struct module *mod;
 
-	for (mod = modules; mod; mod = mod->next)
+	list_for_each_entry(mod, &modules, list) {
 		if (strcmp(mod->name, modname) == 0)
-			break;
-	return mod;
+			return mod;
+	}
+	return NULL;
 }
 
 static struct module *new_module(const char *modname)
@@ -184,7 +185,6 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
-	/* add to list */
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 
@@ -195,8 +195,7 @@ static struct module *new_module(const char *modname)
 	 */
 	mod->is_gpl_compatible = true;
 
-	mod->next = modules;
-	modules = mod;
+	list_add_tail(&mod->list, &modules);
 
 	return mod;
 }
@@ -2477,7 +2476,7 @@ static void write_namespace_deps_files(const char *fname)
 	struct namespace_list *ns;
 	struct buffer ns_deps_buf = {};
 
-	for (mod = modules; mod; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 
 		if (mod->from_dump || !mod->missing_namespaces)
 			continue;
@@ -2568,7 +2567,7 @@ int main(int argc, char **argv)
 	if (files_source)
 		read_symbols_from_files(files_source);
 
-	for (mod = modules; mod; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 		char fname[PATH_MAX];
 		int ret;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index f21a3782885b..d0a8ab60f413 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <elf.h>
 
+#include "list.h"
 #include "elfconfig.h"
 
 /* On BSD-alike OSes elf.h defines these according to host's word size */
@@ -109,7 +110,7 @@ void
 buf_write(struct buffer *buf, const char *s, int len);
 
 struct module {
-	struct module *next;
+	struct list_head list;
 	bool is_gpl_compatible;
 	struct symbol *unres;
 	bool from_dump;		/* true if module was loaded from *.symvers */
-- 
2.32.0

