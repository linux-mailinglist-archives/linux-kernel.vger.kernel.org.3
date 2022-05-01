Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3C51630D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiEAIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbiEAIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:53 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646F14C7A9;
        Sun,  1 May 2022 01:42:25 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2S1008518;
        Sun, 1 May 2022 17:41:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2S1008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394471;
        bh=OjwTsmKH7377EI+ozT0dNyy9b0Gac+1O9PrakkVxSB0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=suBvfGBvxdR3iRnZvDeSq1DMhGfMS24c7nUHKy5xSmFcwCQgEXHA8QDkVZE+eM34/
         QfTtjyvIfLjEfzxBuBLln8bS8kw1sySwj0vspC2o2Fr29a2iCljuO7UGBozQsIzy6C
         wmZilRcray6Od9iWrvSVdIjBEPLdSOBilTqrhcj36L5euuN9lMxLycZW6443F2bAHt
         7qYu6LHxlE2vcTZkfEkaH1BkY25vF7eVZDYmZt8DayHwWHL8f0S4OrAyqoVUES73f1
         5+iyfh1uvd49RL1caH8ZCjhgAVMPXjPjkCdVMcj46jq7GV7EgNp5Hav7lQmFnLHLHq
         KZAFmZqI7mYNQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 14/26] modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
Date:   Sun,  1 May 2022 17:40:20 +0900
Message-Id: <20220501084032.1025918-15-masahiroy@kernel.org>
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

The 'static' specifier and EXPORT_SYMBOL() are an odd combination.

Since commit 15bfc2348d54 ("modpost: check for static EXPORT_SYMBOL*
functions"), modpost tries to detect it, but there are false negatives.

Here is the sample code.

[Sample 1]

  Makefile:

    obj-m += mymod1.o mymod2.o

  mymod1.c:

    #include <linux/export.h>
    #include <linux/module.h>
    static void foo(void) {}
    EXPORT_SYMBOL(foo);
    MODULE_LICENSE("GPL");

  mymod2.c:

    #include <linux/module.h>
    void foo(void) {}
    MODULE_LICENSE("GPL");

mymod1 exports the static symbol 'foo', but modpost cannot catch it
because it is confused by the same name symbol in another module, mymod2.
(Without mymod2, modpost can detect the error in mymod1)

find_symbol() returns the first symbol found in the hash table with the
given name. This hash table is global, so it may return a symbol from
an unrelated module. So, a global symbol in a module may unset the
'is_static' flag of a different module.

To mitigate this issue, add sym_find_with_module(), which receives the
module pointer as the second argument. If non-NULL pointer is passed, it
returns the symbol in the specified module. If NULL is passed, it is
equivalent to find_module().

Please note there are still false positives in the composite module,
like below (or when both are built-in). I have no idea how to do this
correctly.

[Sample 2]  (not fixed by this commit)

  Makefile:
    obj-m += mymod.o
    mymod-objs := mymod1.o mymod2.o

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Rename the new func to sym_find_with_module()

 scripts/mod/modpost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b9f359d10968..375b9463cb8a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -272,7 +272,7 @@ static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
 }
 
-static struct symbol *find_symbol(const char *name)
+static struct symbol *sym_find_with_module(const char *name, struct module *mod)
 {
 	struct symbol *s;
 
@@ -281,12 +281,17 @@ static struct symbol *find_symbol(const char *name)
 		name++;
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
-		if (strcmp(s->name, name) == 0)
+		if (strcmp(s->name, name) == 0 && (!mod || s->module == mod))
 			return s;
 	}
 	return NULL;
 }
 
+static struct symbol *find_symbol(const char *name)
+{
+	return sym_find_with_module(name, NULL);
+}
+
 struct namespace_list {
 	struct list_head list;
 	char namespace[];
@@ -2063,8 +2068,9 @@ static void read_symbols(const char *modname)
 
 		if (bind == STB_GLOBAL || bind == STB_WEAK) {
 			struct symbol *s =
-				find_symbol(remove_dot(info.strtab +
-						       sym->st_name));
+				sym_find_with_module(remove_dot(info.strtab +
+								sym->st_name),
+						     mod);
 
 			if (s)
 				s->is_static = false;
-- 
2.32.0

