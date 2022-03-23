Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2284E4D36
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242170AbiCWHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbiCWHTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:19:51 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3F4672E15
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:18:21 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22N7IDKI014463;
        Wed, 23 Mar 2022 08:18:13 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 1/2] tools/nolibc/string: do not use __builtin_strlen() at -O0
Date:   Wed, 23 Mar 2022 08:18:06 +0100
Message-Id: <20220323071807.14413-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220323071807.14413-1-w@1wt.eu>
References: <20220323071807.14413-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang wants to use strlen() for __builtin_strlen() at -O0. We don't
really care about -O0 but it at least ought to build, so let's make
sure we don't choke on this, by dropping the optimizationn for
constant strings in this case.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 0d5e870c7c0b..75a453870498 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -122,7 +122,9 @@ char *strcpy(char *dst, const char *src)
 	return ret;
 }
 
-/* this function is only used with arguments that are not constants */
+/* this function is only used with arguments that are not constants or when
+ * it's not known because optimizations are disabled.
+ */
 static __attribute__((unused))
 size_t nolibc_strlen(const char *str)
 {
@@ -132,11 +134,18 @@ size_t nolibc_strlen(const char *str)
 	return len;
 }
 
+/* do not trust __builtin_constant_p() at -O0, as clang will emit a test and
+ * the two branches, then will rely on an external definition of strlen().
+ */
+#if defined(__OPTIMIZE__)
 #define strlen(str) ({                          \
 	__builtin_constant_p((str)) ?           \
 		__builtin_strlen((str)) :       \
 		nolibc_strlen((str));           \
 })
+#else
+#define strlen(str) nolibc_strlen((str))
+#endif
 
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
-- 
2.35.1

