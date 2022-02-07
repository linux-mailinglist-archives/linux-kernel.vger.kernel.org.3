Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055644AC5A3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351190AbiBGQaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389572AbiBGQ0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:05 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C264C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:05 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOeMr014411;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 28/42] tools/nolibc/string: use unidirectional variants for memcpy()
Date:   Mon,  7 Feb 2022 17:23:40 +0100
Message-Id: <20220207162354.14293-29-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220207162354.14293-1-w@1wt.eu>
References: <20220207162354.14293-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Till now memcpy() relies on memmove(), but it's always included for libgcc,
so we have a larger than needed function. Let's implement two unidirectional
variants to copy from bottom to top and from top to bottom, and use the
former for memcpy(). The variants are optimized to be compact, and at the
same time the compiler is sometimes able to detect the loop and to replace
it with a "rep movsb". The new function is 24 bytes instead of 52 on x86_64.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 8a23cda2d450..6d8fad7a92e6 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -25,6 +25,28 @@ int memcmp(const void *s1, const void *s2, size_t n)
 	return c1;
 }
 
+static __attribute__((unused))
+void *_nolibc_memcpy_up(void *dst, const void *src, size_t len)
+{
+	size_t pos = 0;
+
+	while (pos < len) {
+		((char *)dst)[pos] = ((const char *)src)[pos];
+		pos++;
+	}
+	return dst;
+}
+
+static __attribute__((unused))
+void *_nolibc_memcpy_down(void *dst, const void *src, size_t len)
+{
+	while (len) {
+		len--;
+		((char *)dst)[len] = ((const char *)src)[len];
+	}
+	return dst;
+}
+
 static __attribute__((unused))
 void *memmove(void *dst, const void *src, size_t len)
 {
@@ -42,7 +64,7 @@ void *memmove(void *dst, const void *src, size_t len)
 __attribute__((weak,unused))
 void *memcpy(void *dst, const void *src, size_t len)
 {
-	return memmove(dst, src, len);
+	return _nolibc_memcpy_up(dst, src, len);
 }
 
 static __attribute__((unused))
-- 
2.35.1

