Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83504AC5B3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389786AbiBGQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380026AbiBGQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:23 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21EE4C0401CF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:20 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOeRj014413;
        Mon, 7 Feb 2022 17:24:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 30/42] tools/nolibc/string: add strncpy() and strlcpy()
Date:   Mon,  7 Feb 2022 17:23:42 +0100
Message-Id: <20220207162354.14293-31-w@1wt.eu>
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

These are minimal variants. strncpy() always fills the destination for
<size> chars, while strlcpy() copies no more than <size> including the
zero and returns the source's length. The respective sizes on various
archs are:

  strncpy(): x86:0x1f mips:0x30 arm:0x20
  strlcpy(): x86:0x17 mips:0x34 arm:0x1a

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index b831a02de83f..7c274efcdfae 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -121,6 +121,34 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+size_t strlcpy(char *dst, const char *src, size_t size)
+{
+	size_t len;
+	char c;
+
+	for (len = 0;;) {
+		c = src[len];
+		if (len < size)
+			dst[len] = c;
+		if (!c)
+			break;
+		len++;
+	}
+	return len;
+}
+
+static __attribute__((unused))
+char *strncpy(char *dst, const char *src, size_t size)
+{
+	size_t len;
+
+	for (len = 0; len < size; len++)
+		if ((dst[len] = *src))
+			src++;
+	return dst;
+}
+
 static __attribute__((unused))
 char *strrchr(const char *s, int c)
 {
-- 
2.35.1

