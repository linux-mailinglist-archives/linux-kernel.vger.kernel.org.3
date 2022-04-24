Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AB50D4AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238714AbiDXTOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238255AbiDXTNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:50 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E888C62C8;
        Sun, 24 Apr 2022 12:10:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o62019069;
        Mon, 25 Apr 2022 04:08:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o62019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827336;
        bh=/rt+evyzPsd3S3ztHUwtb8jwWosNiUJtIBCWGhVH/s0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jXpk104VNeX1spsVdhf/v5r3U0eBpXZZygK4UYd8DXiVcNAmFqEx0Nsr89DbAukZX
         8XKxYnL6DkYw1CgdXNClZNBll2laTtNtkhJesrPy3oxToKp55uqfv38BRdh5EoljXi
         rtL483iwTIydjocVwJfWzxsceM06c44n4AMH0m3TgIxCW/s8ZcBDsxJgIkDTbLGGr+
         uIl9Bba7d/VreS0KVHYPhIWjICwvjjlDLE6kO60wuUP7cKgokysXnxp4cTHFsQ5VZK
         l5VLwCijhLMiOdYFfyTqW44j+OCyx1G74ZdYNJIdK7RsnSfhPUTKqcdd+wBzYMA9nW
         2oUf85fmITcfg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 08/27] modpost: traverse modules in order
Date:   Mon, 25 Apr 2022 04:07:52 +0900
Message-Id: <20220424190811.1678416-9-masahiroy@kernel.org>
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

Currently, modpost manages modules in a singly liked list; it adds a new
node to the head, and traverses the list from new to old.

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
---

 scripts/mod/modpost.c | 18 +++++++++---------
 scripts/mod/modpost.h |  3 ++-
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 52dd07a36379..86416e4af626 100644
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
@@ -184,12 +185,11 @@ static struct module *new_module(const char *modname)
 	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
 	memset(mod, 0, sizeof(*mod));
 
-	/* add to list */
 	strcpy(mod->name, modname);
 	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
 	mod->gpl_compatible = true;
-	mod->next = modules;
-	modules = mod;
+
+	list_add_tail(&mod->list, &modules);
 
 	return mod;
 }
@@ -2467,7 +2467,7 @@ static void write_namespace_deps_files(const char *fname)
 	struct namespace_list *ns;
 	struct buffer ns_deps_buf = {};
 
-	for (mod = modules; mod; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 
 		if (mod->from_dump || !mod->missing_namespaces)
 			continue;
@@ -2558,7 +2558,7 @@ int main(int argc, char **argv)
 	if (files_source)
 		read_symbols_from_files(files_source);
 
-	for (mod = modules; mod; mod = mod->next) {
+	list_for_each_entry(mod, &modules, list) {
 		char fname[PATH_MAX];
 		int ret;
 
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 4085bf5b33aa..c3b5d2f0e2bb 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <elf.h>
 
+#include "list.h"
 #include "elfconfig.h"
 
 /* On BSD-alike OSes elf.h defines these according to host's word size */
@@ -114,7 +115,7 @@ struct namespace_list {
 };
 
 struct module {
-	struct module *next;
+	struct list_head list;
 	int gpl_compatible;
 	struct symbol *unres;
 	bool from_dump;		/* true if module was loaded from *.symvers */
-- 
2.32.0

