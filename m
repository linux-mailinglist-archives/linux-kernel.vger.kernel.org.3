Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101D54AC5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385075AbiBGQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388549AbiBGQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:26:03 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBCE2C0401CE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 08:26:02 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 217GOc0w014393;
        Mon, 7 Feb 2022 17:24:38 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/42] tools/nolibc/ctype: add the missing is* functions
Date:   Mon,  7 Feb 2022 17:23:22 +0100
Message-Id: <20220207162354.14293-11-w@1wt.eu>
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

There was only isdigit, this commit adds the other ones.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/ctype.h | 79 +++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/ctype.h b/tools/include/nolibc/ctype.h
index 6735bd906f25..e3000b2992d7 100644
--- a/tools/include/nolibc/ctype.h
+++ b/tools/include/nolibc/ctype.h
@@ -13,10 +13,87 @@
  * As much as possible, please keep functions alphabetically sorted.
  */
 
+static __attribute__((unused))
+int isascii(int c)
+{
+	/* 0x00..0x7f */
+	return (unsigned int)c <= 0x7f;
+}
+
+static __attribute__((unused))
+int isblank(int c)
+{
+	return c == '\t' || c == ' ';
+}
+
+static __attribute__((unused))
+int iscntrl(int c)
+{
+	/* 0x00..0x1f, 0x7f */
+	return (unsigned int)c < 0x20 || c == 0x7f;
+}
+
 static __attribute__((unused))
 int isdigit(int c)
 {
-	return (unsigned int)(c - '0') <= 9;
+	return (unsigned int)(c - '0') < 10;
+}
+
+static __attribute__((unused))
+int isgraph(int c)
+{
+	/* 0x21..0x7e */
+	return (unsigned int)(c - 0x21) < 0x5e;
+}
+
+static __attribute__((unused))
+int islower(int c)
+{
+	return (unsigned int)(c - 'a') < 26;
+}
+
+static __attribute__((unused))
+int isprint(int c)
+{
+	/* 0x20..0x7e */
+	return (unsigned int)(c - 0x20) < 0x5f;
+}
+
+static __attribute__((unused))
+int isspace(int c)
+{
+	/* \t is 0x9, \n is 0xA, \v is 0xB, \f is 0xC, \r is 0xD */
+	return ((unsigned int)c == ' ') || (unsigned int)(c - 0x09) < 5;
+}
+
+static __attribute__((unused))
+int isupper(int c)
+{
+	return (unsigned int)(c - 'A') < 26;
+}
+
+static __attribute__((unused))
+int isxdigit(int c)
+{
+	return isdigit(c) || (unsigned int)(c - 'A') < 6 || (unsigned int)(c - 'a') < 6;
+}
+
+static __attribute__((unused))
+int isalpha(int c)
+{
+	return islower(c) || isupper(c);
+}
+
+static __attribute__((unused))
+int isalnum(int c)
+{
+	return isalpha(c) || isdigit(c);
+}
+
+static __attribute__((unused))
+int ispunct(int c)
+{
+	return isgraph(c) && !isalnum(c);
 }
 
 #endif /* _NOLIBC_CTYPE_H */
-- 
2.35.1

