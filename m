Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A29F53788B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbiE3JEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiE3JEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:04:02 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1884578913;
        Mon, 30 May 2022 02:04:00 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 24U92WD1001546;
        Mon, 30 May 2022 18:02:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 24U92WD1001546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653901357;
        bh=Hu8xQu6PYYBz+qbdMmHfhHa0GrOI0bBWx++tHbmunFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=stGCYcnjDU1LGJRuTJFeO2l8xB+B3KNxK7CtG/tGKu4fvz21aq9phPCn2ZZL4hkR7
         ckKvh934QgqAmAbHMOMAnBApG1DtFoImNXdeSUCfpaj+abvtqCHVAZCC+k8KdRJDcp
         hWqK4fdo7Iry1JN3s9IjPs5Tf6wFUSArMeI25oVeDc434yZ241rUrGSHuYLg6beK2m
         5hCrEjiS+G7srDE8IctgieoV+WRrkWorNvRKUOEiHdwNPWc89+zQEu2KHJ31VnDJbm
         CAnJ5htjM7DV89qbqyXIdRDDt7DfopSJlJpV5835R4ZBix4Vi78yNoyHMBOFDNN/Z7
         ezRGGZfRMTFVQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] modpost: use fnmatch() to simplify match()
Date:   Mon, 30 May 2022 18:01:39 +0900
Message-Id: <20220530090139.3030866-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220530090139.3030866-1-masahiroy@kernel.org>
References: <20220530090139.3030866-1-masahiroy@kernel.org>
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

Replace the own implementation for wildcard (glob) matching with
a function call to the library function, fnmatch().

Also, change the return type to 'bool'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 74 ++++++++-----------------------------------
 1 file changed, 13 insertions(+), 61 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index c1558bacf717..29d5a841e215 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -13,6 +13,7 @@
 
 #define _GNU_SOURCE
 #include <elf.h>
+#include <fnmatch.h>
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
@@ -710,29 +711,6 @@ static char *get_modinfo(struct elf_info *info, const char *tag)
 	return get_next_modinfo(info, tag, NULL);
 }
 
-/**
- * Test if string s ends in string sub
- * return 0 if match
- **/
-static int strrcmp(const char *s, const char *sub)
-{
-	int slen, sublen;
-
-	if (!s || !sub)
-		return 1;
-
-	slen = strlen(s);
-	sublen = strlen(sub);
-
-	if ((slen == 0) || (sublen == 0))
-		return 1;
-
-	if (sublen > slen)
-		return 1;
-
-	return memcmp(s + slen - sublen, sub, sublen);
-}
-
 static const char *sym_name(struct elf_info *elf, Elf_Sym *sym)
 {
 	if (sym)
@@ -741,48 +719,22 @@ static const char *sym_name(struct elf_info *elf, Elf_Sym *sym)
 		return "(unknown)";
 }
 
-/* The pattern is an array of simple patterns.
- * "foo" will match an exact string equal to "foo"
- * "*foo" will match a string that ends with "foo"
- * "foo*" will match a string that begins with "foo"
- * "*foo*" will match a string that contains "foo"
+/*
+ * Check whether the 'string' argument matches one of the 'patterns',
+ * an array of shell wildcard patterns (glob).
+ *
+ * Return true is there is a match.
  */
-static int match(const char *sym, const char * const pat[])
+static bool match(const char *string, const char *const patterns[])
 {
-	const char *p;
-	while (*pat) {
-		const char *endp;
-
-		p = *pat++;
-		endp = p + strlen(p) - 1;
+	const char *pattern;
 
-		/* "*foo*" */
-		if (*p == '*' && *endp == '*') {
-			char *bare = NOFAIL(strndup(p + 1, strlen(p) - 2));
-			char *here = strstr(sym, bare);
-
-			free(bare);
-			if (here != NULL)
-				return 1;
-		}
-		/* "*foo" */
-		else if (*p == '*') {
-			if (strrcmp(sym, p + 1) == 0)
-				return 1;
-		}
-		/* "foo*" */
-		else if (*endp == '*') {
-			if (strncmp(sym, p, strlen(p) - 1) == 0)
-				return 1;
-		}
-		/* no wildcards */
-		else {
-			if (strcmp(p, sym) == 0)
-				return 1;
-		}
+	while ((pattern = *patterns++)) {
+		if (!fnmatch(pattern, string, 0))
+			return true;
 	}
-	/* no match */
-	return 0;
+
+	return false;
 }
 
 /* sections that we do not want to do full section mismatch check on */
-- 
2.32.0

