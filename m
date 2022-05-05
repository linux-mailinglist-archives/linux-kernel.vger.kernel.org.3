Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BC51B8CC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343909AbiEEHaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241460AbiEEH3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:29:55 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7952019E;
        Thu,  5 May 2022 00:26:16 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenj019426;
        Thu, 5 May 2022 16:23:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenj019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735422;
        bh=XSY8vEAsNwUxWuIu8VWQF0+mhoFGCgLIKTmGfMENfeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RheR5FxUn3suG0aI8H/cOySl5D+ea3lf6kWVUuBW/Qv7LKdzP5/84CeKz1jAxq2L4
         9liEI6t51lHDtY1AaMooucUWmii/fm/hi1OU9T+oabmID+8I3+jRJ7leqQulu+IgOO
         55Dyo2mwltMLUMEtuQHgzA18PJ6yWcqyR3MlNt4+9BUnfHUp/mWPXh29EY4Nx3It5K
         LavJf8lECquHSZuVekyynVI/mgFQ38u7gG6W6o6oWLhjmJ1C/2cXEYoI7rDLGfdw68
         jbbcAtxL76GVOB4mTjb+MpTNwFytJtiwz2QNXU8CRQor+7hThIioJFpCrRcRURr8J0
         kfiE/5EqGWraw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 01/15] modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
Date:   Thu,  5 May 2022 16:22:30 +0900
Message-Id: <20220505072244.1155033-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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
because it is fooled by the same name symbol in another module, mymod2.
(Without mymod2, modpost can detect the error in mymod1)

find_symbol() returns the first symbol found in the hash table with the
given name. This hash table is global, so it may return a symbol from
an unrelated module. So, a global symbol in a module may unset the
'is_static' flag of another module.

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

(no changes since v2)

Changes in v2:
  - Rename the new func to sym_find_with_module()

 scripts/mod/modpost.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index b605f4a58759..a55fa2b88a9a 100644
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

