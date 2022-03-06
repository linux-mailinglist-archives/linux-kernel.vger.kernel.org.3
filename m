Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E44CE9E2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 08:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiCFH1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 02:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFH1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 02:27:21 -0500
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBB0554B6;
        Sat,  5 Mar 2022 23:26:29 -0800 (PST)
Received: from grover.. (133-32-176-37.west.xps.vectant.ne.jp [133.32.176.37]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2267Pg0S000471;
        Sun, 6 Mar 2022 16:25:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2267Pg0S000471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1646551543;
        bh=iGaL23V+UQWSGWF3HVRNEhTafOh/eP8Uz3uI3KMOT88=;
        h=From:To:Cc:Subject:Date:From;
        b=lktP+QSdEfzeOf4A8e3uTErYMf3ZzjxKDSS7qP5zWQ6s2NCeIUzUi/Ytk6Xlkgmgp
         Y55WL2kk7q9ommXxsbxmtQkWMDFUrixDQ2DEPTKmtfPAyTfzNljqKqKduD86S0sFIf
         DIoLmUm8gpqjjBDVNK5kTQ7NkGmr7X4iRWvUFWSHbF+ny4TDahqh6pcMxhoHq1oRlh
         4qt6frbJglB3hkRO2MI/WQtGioUa6aZ4wmD6pTdd5x3jVr+WhVr4WBxbvh7XaIX2Fs
         D3xeE33ErPqjbCvH1aj6iHe084O6W50n8OFfJWj+HJ9rn5hNVxC6nZpsW03zh9DpqS
         0bTEXdRzLuHtQ==
X-Nifty-SrcIP: [133.32.176.37]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        David Laight <david.laight@aculab.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v3] fixdep: use fflush() and ferror() to ensure successful write to files
Date:   Sun,  6 Mar 2022 16:25:35 +0900
Message-Id: <20220306072535.211059-1-masahiroy@kernel.org>
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

Currently, fixdep checks the return value from (v)printf(), but it does
not ensure the complete write to the .cmd file.

printf() just writes data to the internal buffer, which usually succeeds.
(Of course, it may fail for another reason, for example when the file
descriptor is closed, but that is another story.)

When the buffer (4k?) is full, an actual write occurs, and printf() may
really fail. One of typical cases is "No space left on device" when the
disk is full.

The data remaining in the buffer will be pushed out to the file when
the program exits, but we never know if it is successful.

One straight-forward fix would be to add the following code at the end
of the program.

   ret = fflush(stdout);
   if (ret < 0) {
          /* error handling */
   }

However, it is tedious to check the return code in all the call sites
of printf(), fflush(), fclose(), and whatever can cause actual writes
to the end device. Doing that lets the program bail out at the first
failure but is usually not worth the effort.

Instead, let's check the error status from ferror(). This is 'sticky',
so you need to check it just once. You still need to call fflush().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: David Laight <david.laight@aculab.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v3:
 - add more detailed explanation. No code change.

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

