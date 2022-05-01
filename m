Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA5E51631C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344559AbiEAIr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343624AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DAB4CD7D;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rv008518;
        Sun, 1 May 2022 17:41:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rv008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394469;
        bh=fMEBYGXyw4wj0YOPqOXyNSxkMAJy9YroKhDuXUSoXHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VoYnIDWCigw029YpcY9orum2qtHKvupe14SmLYVoEnEVna4FGF2OvA47OKgqmsOfR
         X0OCV+VdhGnek8U5PTX3InZuqt36tiqlCE3v6lJtom2h3MV7iSUOJ4V+saTScayl5V
         HRGJ4fqJ7hpwnIqib8S4RpyOUuPN16JUKa7SfGEcGqHOlfRtu1Z2z1whksi6IwuuFk
         pmpxBCpI31U+EletnMR9FJGhBF3XlVbokHomg43Yoy6XCb5TutnXUXVVfalG+4mriO
         ieYNksoYewJu6B6BfE7JtePcgnbMDHGQkqryVCw1ka1I/B4UJ2qeqdk2bCvMiAlUsh
         tJxKGbWLgxCGQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 10/26] modpost: move static EXPORT_SYMBOL check to check_exports()
Date:   Sun,  1 May 2022 17:40:16 +0900
Message-Id: <20220501084032.1025918-11-masahiroy@kernel.org>
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

Now that struct module has a list of symbols it exports, this check
can go into check_exports(). The code becomes shorter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/mod/modpost.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd49ef7b5953..4ce8d164b8e0 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2199,6 +2199,12 @@ static void check_exports(struct module *mod)
 		if (!mod->is_gpl_compatible)
 			check_for_gpl_usage(exp->export, basename, exp->name);
 	}
+
+	list_for_each_entry(s, &mod->exported_symbols, list) {
+		if (s->is_static)
+			error("\"%s\" [%s] is a static %s\n",
+			      s->name, mod->name, export_str(s->export));
+	}
 }
 
 static void check_modname_len(struct module *mod)
@@ -2510,7 +2516,6 @@ int main(int argc, char **argv)
 	char *missing_namespace_deps = NULL;
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
-	int n;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
@@ -2606,16 +2611,6 @@ int main(int argc, char **argv)
 	if (sec_mismatch_count && !sec_mismatch_warn_only)
 		error("Section mismatches detected.\n"
 		      "Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.\n");
-	for (n = 0; n < SYMBOL_HASH_SIZE; n++) {
-		struct symbol *s;
-
-		for (s = symbolhash[n]; s; s = s->next) {
-			if (s->is_static)
-				error("\"%s\" [%s] is a static %s\n",
-				      s->name, s->module->name,
-				      export_str(s->export));
-		}
-	}
 
 	if (nr_unresolved > MAX_UNRESOLVED_REPORTS)
 		warn("suppressed %u unresolved symbol warnings because there were too many)\n",
-- 
2.32.0

