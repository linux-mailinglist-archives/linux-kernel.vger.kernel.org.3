Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F9D50D4B0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239149AbiDXTPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiDXTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:48 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E0226;
        Sun, 24 Apr 2022 12:10:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o6E019069;
        Mon, 25 Apr 2022 04:09:03 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o6E019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827343;
        bh=aWmZsWLtPG9IY+voThD7sKHIw6eSBQ7zPKJZlzBGplE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+F/RLrxE+eMTR7IuGCQ2JI67hpRFOzcqDpIQt6yPOVkCId+zjZxyUzIGBbU+YQq9
         PyVU38dMdFtNqJSS7/NbOEO2vxIqsazZiSgXS2E+xoChMAfPQ0XRAyHGexFEHp6/Lp
         MQK4rwA4TJnZOgAKJC92UnFoeC9580K/l1BNb12AfRcOpwoSxFTkMa4413Hr3Jz6jf
         K7tppgjvE2dp3eQwR4uddYyV1gJowEli9YxeBlfJ1qaeySU4SrbWMgI3RvJ2gM7x8L
         cEzeTuXARToMDLApJL706qEm6ZT3oa5Pue00BT5lG8NyuHaVcFhuLD00G/ir1xnOCq
         4K8KPcQt8xJNA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 20/27] modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
Date:   Mon, 25 Apr 2022 04:08:04 +0900
Message-Id: <20220424190811.1678416-21-masahiroy@kernel.org>
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

To mitigate this issue, add find_symbol_in_module(), which receives the
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

 scripts/mod/modpost.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 908390b4fa80..fb50927cd241 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -271,7 +271,8 @@ static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
 }
 
-static struct symbol *find_symbol(const char *name)
+static struct symbol *find_symbol_in_module(const char *name,
+					    struct module *mod)
 {
 	struct symbol *s;
 
@@ -280,11 +281,17 @@ static struct symbol *find_symbol(const char *name)
 		name++;
 
 	hash_for_matched_symbol(s, exported_symbols, name) {
-		return s;
+		if (!mod || s->module == mod)
+			return s;
 	}
 	return NULL;
 }
 
+static struct symbol *find_symbol(const char *name)
+{
+	return find_symbol_in_module(name, NULL);
+}
+
 struct namespace_list {
 	struct list_head list;
 	char namespace[];
@@ -2062,8 +2069,9 @@ static void read_symbols(const char *modname)
 
 		if (bind == STB_GLOBAL || bind == STB_WEAK) {
 			struct symbol *s =
-				find_symbol(remove_dot(info.strtab +
-						       sym->st_name));
+				find_symbol_in_module(remove_dot(info.strtab +
+								 sym->st_name),
+						      mod);
 
 			if (s)
 				s->is_static = false;
-- 
2.32.0

