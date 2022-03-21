Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EE64E2F18
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349358AbiCURfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348687AbiCURe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:57 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C207266AC5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXN0f007572;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 3/8] tools/nolibc/stdio: add support for '%p' to vfprintf()
Date:   Mon, 21 Mar 2022 18:33:09 +0100
Message-Id: <20220321173314.7519-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220321173314.7519-1-w@1wt.eu>
References: <20220321173314.7519-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

%p remains quite useful in test code, and the code path can easily be
merged with the existing "%x" thus only adds ~50 bytes, thus let's
add it.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/stdio.h | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/include/nolibc/stdio.h b/tools/include/nolibc/stdio.h
index 559ebe052a75..15dedf8d0902 100644
--- a/tools/include/nolibc/stdio.h
+++ b/tools/include/nolibc/stdio.h
@@ -163,7 +163,7 @@ char *fgets(char *s, int size, FILE *stream)
 
 
 /* minimal vfprintf(). It supports the following formats:
- *  - %[l*]{d,u,c,x}
+ *  - %[l*]{d,u,c,x,p}
  *  - %s
  *  - unknown modifiers are ignored.
  */
@@ -184,8 +184,12 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 		if (escape) {
 			/* we're in an escape sequence, ofs == 1 */
 			escape = 0;
-			if (c == 'c' || c == 'd' || c == 'u' || c == 'x') {
-				if (lpref) {
+			if (c == 'c' || c == 'd' || c == 'u' || c == 'x' || c == 'p') {
+				char *out = tmpbuf;
+
+				if (c == 'p')
+					v = va_arg(args, unsigned long);
+				else if (lpref) {
 					if (lpref > 1)
 						v = va_arg(args, unsigned long long);
 					else
@@ -202,18 +206,22 @@ int vfprintf(FILE *stream, const char *fmt, va_list args)
 				}
 
 				switch (c) {
+				case 'c':
+					out[0] = v;
+					out[1] = 0;
+					break;
 				case 'd':
-					i64toa_r(v, tmpbuf);
+					i64toa_r(v, out);
 					break;
 				case 'u':
-					u64toa_r(v, tmpbuf);
+					u64toa_r(v, out);
 					break;
-				case 'x':
-					u64toh_r(v, tmpbuf);
-					break;
-				default: /* 'c' */
-					tmpbuf[0] = v;
-					tmpbuf[1] = 0;
+				case 'p':
+					*(out++) = '0';
+					*(out++) = 'x';
+					/* fall through */
+				default: /* 'x' and 'p' above */
+					u64toh_r(v, out);
 					break;
 				}
 				outstr = tmpbuf;
-- 
2.35.1

