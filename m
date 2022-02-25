Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A4F4C47CD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiBYOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiBYOob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:44:31 -0500
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02981FED91;
        Fri, 25 Feb 2022 06:43:58 -0800 (PST)
Received: from grover.RMN.KIBA.LAB.jp (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21PEgqX4020761;
        Fri, 25 Feb 2022 23:42:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21PEgqX4020761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645800172;
        bh=I9jAwX0NbU12zK9seDrAyeHVaSvKsx5FCTRWrnYxfAs=;
        h=From:To:Cc:Subject:Date:From;
        b=Ou1p4dPFbNoaxgDMabPHid6Dd3engyNSQW3zicXm5Ju/UJRE4QA7IT8RWL841zLlk
         Q5+1lTJ1U+o/ppFqIz4bQfOxJpbSI1uRZSv6SD+wTD7ZAx3DR9qMveTQQuT1IXmvtq
         LN7XbTxZNb1DRUQVtYy6cs9rAfUSbUTaAGdmUkhAWPlgFlkOl9jWSkXvc8FCKkULR5
         jLSt9HNbvW+R1Zt4JXVh/HmJQGXPzQHE1vHcOHE3FYfhGYJ2Piu5cYokNVIJAOshv5
         Bjkjr13Uth3k/7xrbi7fknYeCPRZIITfKx/wvrod5o50qwFUz8GA435jCOtnP/QpkC
         dvyaN8ahi7wNw==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     David Laight <David.Laight@ACULAB.COM>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] fixdep: use fflush() and ferror() to ensure successful write to files
Date:   Fri, 25 Feb 2022 23:42:45 +0900
Message-Id: <20220225144245.182659-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checking the return value of (v)printf does not ensure the successful
write to the .cmd file.

Call fflush() and ferror() to make sure that everything has been
written to the file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - add error message

 scripts/basic/fixdep.c | 46 +++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

diff --git a/scripts/basic/fixdep.c b/scripts/basic/fixdep.c
index 44e887cff49b..2328f9a641da 100644
--- a/scripts/basic/fixdep.c
+++ b/scripts/basic/fixdep.c
@@ -105,25 +105,6 @@ static void usage(void)
 	exit(1);
 }
 
-/*
- * In the intended usage of this program, the stdout is redirected to .*.cmd
- * files. The return value of printf() must be checked to catch any error,
- * e.g. "No space left on device".
- */
-static void xprintf(const char *format, ...)
-{
-	va_list ap;
-	int ret;
-
-	va_start(ap, format);
-	ret = vprintf(format, ap);
-	if (ret < 0) {
-		perror("fixdep");
-		exit(1);
-	}
-	va_end(ap);
-}
-
 struct item {
 	struct item	*next;
 	unsigned int	len;
@@ -189,7 +170,7 @@ static void use_config(const char *m, int slen)
 
 	define_config(m, slen, hash);
 	/* Print out a dependency path from a symbol name. */
-	xprintf("    $(wildcard include/config/%.*s) \\\n", slen, m);
+	printf("    $(wildcard include/config/%.*s) \\\n", slen, m);
 }
 
 /* test if s ends in sub */
@@ -318,13 +299,13 @@ static void parse_dep_file(char *m, const char *target)
 				 */
 				if (!saw_any_target) {
 					saw_any_target = 1;
-					xprintf("source_%s := %s\n\n",
-						target, m);
-					xprintf("deps_%s := \\\n", target);
+					printf("source_%s := %s\n\n",
+					       target, m);
+					printf("deps_%s := \\\n", target);
 				}
 				is_first_dep = 0;
 			} else {
-				xprintf("  %s \\\n", m);
+				printf("  %s \\\n", m);
 			}
 
 			buf = read_file(m);
@@ -347,8 +328,8 @@ static void parse_dep_file(char *m, const char *target)
 		exit(1);
 	}
 
-	xprintf("\n%s: $(deps_%s)\n\n", target, target);
-	xprintf("$(deps_%s):\n", target);
+	printf("\n%s: $(deps_%s)\n\n", target, target);
+	printf("$(deps_%s):\n", target);
 }
 
 int main(int argc, char *argv[])
@@ -363,11 +344,22 @@ int main(int argc, char *argv[])
 	target = argv[2];
 	cmdline = argv[3];
 
-	xprintf("cmd_%s := %s\n\n", target, cmdline);
+	printf("cmd_%s := %s\n\n", target, cmdline);
 
 	buf = read_file(depfile);
 	parse_dep_file(buf, target);
 	free(buf);
 
+	fflush(stdout);
+
+	/*
+	 * In the intended usage, the stdout is redirected to .*.cmd files.
+	 * Call ferror() to catch errors such as "No space left on device".
+	 */
+	if (ferror(stdout)) {
+		fprintf(stderr, "fixdep: not all data was written to the output\n");
+		exit(1);
+	}
+
 	return 0;
 }
-- 
2.32.0

