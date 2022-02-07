Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08204AC5B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389848AbiBGQaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387635AbiBGQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:39 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2B0BC0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:37 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOeL4014415;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 31/42] tools/nolibc/string: add tiny versions of strncat() and strlcat()
Date:   Mon,  7 Feb 2022 17:23:43 +0100
Message-Id: <20220207162354.14293-32-w@1wt.eu>
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

While these functions are often dangerous, forcing the user to work
around their absence is often much worse. Let's provide small versions
of each of them. The respective sizes in bytes on a few architectures
are:

  strncat(): x86:0x33 mips:0x68 arm:0x3c
  strlcat(): x86:0x25 mips:0x4c arm:0x2c

The two are quite different, and strncat() is even different from
strncpy() in that it limits the amount of data it copies and will always
terminate the output by one zero, while strlcat() will always limit the
total output to the specified size and will put a zero if possible.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 7c274efcdfae..c550c9ba8f4c 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -121,6 +121,28 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+size_t strlcat(char *dst, const char *src, size_t size)
+{
+	size_t len;
+	char c;
+
+	for (len = 0; dst[len];	len++)
+		;
+
+	for (;;) {
+		c = *src;
+		if (len < size)
+			dst[len] = c;
+		if (!c)
+			break;
+		len++;
+		src++;
+	}
+
+	return len;
+}
+
 static __attribute__((unused))
 size_t strlcpy(char *dst, const char *src, size_t size)
 {
@@ -138,6 +160,25 @@ size_t strlcpy(char *dst, const char *src, size_t size)
 	return len;
 }
 
+static __attribute__((unused))
+char *strncat(char *dst, const char *src, size_t size)
+{
+	char *orig = dst;
+
+	while (*dst)
+		dst++;
+
+	while (size && (*dst = *src)) {
+		src++;
+		dst++;
+		size--;
+	}
+
+	*dst = 0;
+	return orig;
+}
+
+
 static __attribute__((unused))
 char *strncpy(char *dst, const char *src, size_t size)
 {
-- 
2.35.1

