Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6715866F6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiHAJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiHAJl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:41:58 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33837192;
        Mon,  1 Aug 2022 02:41:57 -0700 (PDT)
Received: from grover.sesame ([133.106.54.139]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 2719ejxu028043;
        Mon, 1 Aug 2022 18:40:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 2719ejxu028043
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659346846;
        bh=t99GlSsT7vbIGrGiCUuJvD+nKsJBskTcdf/ObhFgXWI=;
        h=From:To:Cc:Subject:Date:From;
        b=YXzWfU9BtSCQtsx4ZQhSFcNG51BH/46O/St8t+dyveoQ/8SURDGcJ1v6ZnesvRR2e
         kXvgxlb60DftfQCVLDNpzHH3JBx6v8KSD5uxahsCWJXs/CwLleSUyfh5EpNhY5HaN2
         z0J+1A2wR/ntMcjIiiVguF9zB06wPW7N6PEGnurWyJPde4HC5R+/jj2UQsUu4ANlWN
         4595RoCYdCBqeIusgc8onF/VGIjrwgWdhZIiaxcppeVDi/sOJpsXl+3AVqEaiQI5gy
         d/n7mbv5l0F/nohGBCZbnDOxEbrwJSPvxjZk++cPB2NK4WeZ41ia/8upKoImF2t5pF
         DPl+6CcEZjTiw==
X-Nifty-SrcIP: [133.106.54.139]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] modpost: shorten warning messages in report_sec_mismatch()
Date:   Mon,  1 Aug 2022 18:38:59 +0900
Message-Id: <20220801093902.1506297-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each section mismatch results in long warning messages. Too much.

Make each warning fit in one line, and remove a lot of messy code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 179 +++---------------------------------------
 1 file changed, 9 insertions(+), 170 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a8ee27496da7..9e8ae2636ec1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1238,42 +1238,6 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 	return near;
 }
 
-/*
- * Convert a section name to the function/data attribute
- * .init.text => __init
- * .memexitconst => __memconst
- * etc.
- *
- * The memory of returned value has been allocated on a heap. The user of this
- * method should free it after usage.
-*/
-static char *sec2annotation(const char *s)
-{
-	if (match(s, init_exit_sections)) {
-		char *p = NOFAIL(malloc(20));
-		char *r = p;
-
-		*p++ = '_';
-		*p++ = '_';
-		if (*s == '.')
-			s++;
-		while (*s && *s != '.')
-			*p++ = *s++;
-		*p = '\0';
-		if (*s == '.')
-			s++;
-		if (strstr(s, "rodata") != NULL)
-			strcat(p, "const ");
-		else if (strstr(s, "data") != NULL)
-			strcat(p, "data ");
-		else
-			strcat(p, " ");
-		return r;
-	} else {
-		return NOFAIL(strdup(""));
-	}
-}
-
 static int is_function(Elf_Sym *sym)
 {
 	if (sym)
@@ -1282,19 +1246,6 @@ static int is_function(Elf_Sym *sym)
 		return -1;
 }
 
-static void print_section_list(const char * const list[20])
-{
-	const char *const *s = list;
-
-	while (*s) {
-		fprintf(stderr, "%s", *s);
-		s++;
-		if (*s)
-			fprintf(stderr, ", ");
-	}
-	fprintf(stderr, "\n");
-}
-
 static inline void get_pretty_name(int is_func, const char** name, const char** name_p)
 {
 	switch (is_func) {
@@ -1312,141 +1263,31 @@ static inline void get_pretty_name(int is_func, const char** name, const char**
 static void report_sec_mismatch(const char *modname,
 				const struct sectioncheck *mismatch,
 				const char *fromsec,
-				unsigned long long fromaddr,
 				const char *fromsym,
-				int from_is_func,
-				const char *tosec, const char *tosym,
-				int to_is_func)
+				const char *tosec, const char *tosym)
 {
-	const char *from, *from_p;
-	const char *to, *to_p;
-	char *prl_from;
-	char *prl_to;
-
 	sec_mismatch_count++;
 
-	get_pretty_name(from_is_func, &from, &from_p);
-	get_pretty_name(to_is_func, &to, &to_p);
-
-	warn("%s(%s+0x%llx): Section mismatch in reference from the %s %s%s "
-	     "to the %s %s:%s%s\n",
-	     modname, fromsec, fromaddr, from, fromsym, from_p, to, tosec,
-	     tosym, to_p);
-
 	switch (mismatch->mismatch) {
 	case TEXT_TO_ANY_INIT:
-		prl_from = sec2annotation(fromsec);
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The function %s%s() references\n"
-		"the %s %s%s%s.\n"
-		"This is often because %s lacks a %s\n"
-		"annotation or the annotation of %s is wrong.\n",
-		prl_from, fromsym,
-		to, prl_to, tosym, to_p,
-		fromsym, prl_to, tosym);
-		free(prl_from);
-		free(prl_to);
-		break;
-	case DATA_TO_ANY_INIT: {
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The variable %s references\n"
-		"the %s %s%s%s\n"
-		"If the reference is valid then annotate the\n"
-		"variable with __init* or __refdata (see linux/init.h) "
-		"or name the variable:\n",
-		fromsym, to, prl_to, tosym, to_p);
-		print_section_list(mismatch->symbol_white_list);
-		free(prl_to);
-		break;
-	}
+	case DATA_TO_ANY_INIT:
 	case TEXT_TO_ANY_EXIT:
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The function %s() references a %s in an exit section.\n"
-		"Often the %s %s%s has valid usage outside the exit section\n"
-		"and the fix is to remove the %sannotation of %s.\n",
-		fromsym, to, to, tosym, to_p, prl_to, tosym);
-		free(prl_to);
-		break;
-	case DATA_TO_ANY_EXIT: {
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The variable %s references\n"
-		"the %s %s%s%s\n"
-		"If the reference is valid then annotate the\n"
-		"variable with __exit* (see linux/init.h) or "
-		"name the variable:\n",
-		fromsym, to, prl_to, tosym, to_p);
-		print_section_list(mismatch->symbol_white_list);
-		free(prl_to);
-		break;
-	}
+	case DATA_TO_ANY_EXIT:
 	case XXXINIT_TO_SOME_INIT:
 	case XXXEXIT_TO_SOME_EXIT:
-		prl_from = sec2annotation(fromsec);
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The %s %s%s%s references\n"
-		"a %s %s%s%s.\n"
-		"If %s is only used by %s then\n"
-		"annotate %s with a matching annotation.\n",
-		from, prl_from, fromsym, from_p,
-		to, prl_to, tosym, to_p,
-		tosym, fromsym, tosym);
-		free(prl_from);
-		free(prl_to);
-		break;
 	case ANY_INIT_TO_ANY_EXIT:
-		prl_from = sec2annotation(fromsec);
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The %s %s%s%s references\n"
-		"a %s %s%s%s.\n"
-		"This is often seen when error handling "
-		"in the init function\n"
-		"uses functionality in the exit path.\n"
-		"The fix is often to remove the %sannotation of\n"
-		"%s%s so it may be used outside an exit section.\n",
-		from, prl_from, fromsym, from_p,
-		to, prl_to, tosym, to_p,
-		prl_to, tosym, to_p);
-		free(prl_from);
-		free(prl_to);
-		break;
 	case ANY_EXIT_TO_ANY_INIT:
-		prl_from = sec2annotation(fromsec);
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The %s %s%s%s references\n"
-		"a %s %s%s%s.\n"
-		"This is often seen when error handling "
-		"in the exit function\n"
-		"uses functionality in the init path.\n"
-		"The fix is often to remove the %sannotation of\n"
-		"%s%s so it may be used outside an init section.\n",
-		from, prl_from, fromsym, from_p,
-		to, prl_to, tosym, to_p,
-		prl_to, tosym, to_p);
-		free(prl_from);
-		free(prl_to);
+		warn("%s: section mismatch in reference: %s (section: %s) -> %s (section: %s)\n",
+		     modname, fromsym, fromsec, tosym, tosec);
 		break;
 	case EXPORT_TO_INIT_EXIT:
-		prl_to = sec2annotation(tosec);
-		fprintf(stderr,
-		"The symbol %s is exported and annotated %s\n"
-		"Fix this by removing the %sannotation of %s "
-		"or drop the export.\n",
-		tosym, prl_to, prl_to, tosym);
-		free(prl_to);
+		warn("%s: EXPORT_SYMBOL used for init/exit symbol: %s (section: %s)\n",
+		     modname, tosym, tosec);
 		break;
 	case EXTABLE_TO_NON_TEXT:
-		fatal("There's a special handler for this mismatch type, "
-		      "we should never get here.");
+		fatal("There's a special handler for this mismatch type, we should never get here.\n");
 		break;
 	}
-	fprintf(stderr, "\n");
 }
 
 static void default_mismatch_handler(const char *modname, struct elf_info *elf,
@@ -1470,9 +1311,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	if (secref_whitelist(mismatch,
 			     fromsec, fromsym, tosec, tosym)) {
 		report_sec_mismatch(modname, mismatch,
-				    fromsec, r->r_offset, fromsym,
-				    is_function(from), tosec, tosym,
-				    is_function(to));
+				    fromsec, fromsym, tosec, tosym);
 	}
 }
 
-- 
2.34.1

