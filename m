Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA26950D4A2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238694AbiDXTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238065AbiDXTNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:45 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15D9111E;
        Sun, 24 Apr 2022 12:10:11 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o69019069;
        Mon, 25 Apr 2022 04:09:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o69019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827340;
        bh=fFSgbXsS5gwUrnH11gUc1A0zSBYugGdxXRo6n/xj35g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19VBAGpuCkzoMIrMgcvWGGuwsA+oAMt28OKWBbGN5xhMBPLluzx6YtFW9ZoHlzXVl
         Tia2bODv21DcFr9N82V8bjiZ5FHWWA4FwH4/Chw+lv4XXYpCyOaRzqq1L8/HjcjIoN
         THe8bTkU5WT+zSS1a0ec38dpk4DJ1cvmDlVcqzw6m2B+ses1I1a770OLcBvTrCrX9l
         OX1ZRYmDsUwkkVLu5/ojeM3klY+0Wr9w9dLUWPaPFbz7iq65V+jVcACx1+ERCvp6C4
         /s74Kw15yl2+jGJBSBE2ACnDNxncWdBaSNq3ze518OadDi1eykEmOKGbKA+RLtqZJq
         zArQHu/rajpuQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 15/27] modpost: move static EXPORT_SYMBOL check to check_exports()
Date:   Mon, 25 Apr 2022 04:07:59 +0900
Message-Id: <20220424190811.1678416-16-masahiroy@kernel.org>
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

Now that struct module has a list of symbols it exports, this check
can go into check_exports(). The code becomes shorter.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1793396e1323..14044cd94aaa 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2195,6 +2195,12 @@ static void check_exports(struct module *mod)
 		if (!mod->gpl_compatible)
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
@@ -2506,7 +2512,6 @@ int main(int argc, char **argv)
 	char *missing_namespace_deps = NULL;
 	char *dump_write = NULL, *files_source = NULL;
 	int opt;
-	int n;
 	LIST_HEAD(dump_lists);
 	struct dump_list *dl, *dl2;
 
@@ -2602,16 +2607,6 @@ int main(int argc, char **argv)
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

