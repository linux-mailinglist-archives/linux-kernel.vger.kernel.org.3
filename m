Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649654E2F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbiCURfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348720AbiCURe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:34:58 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D7C36A072
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 10:33:31 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 22LHXNUw007573;
        Mon, 21 Mar 2022 18:33:23 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH 4/8] tools/nolibc/string: add strcmp() and strncmp()
Date:   Mon, 21 Mar 2022 18:33:10 +0100
Message-Id: <20220321173314.7519-5-w@1wt.eu>
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

We need these functions all the time, including when checking environment
variables and parsing command-line arguments. These implementations were
optimized to show optimal code size on a wide range of compilers (22 bytes
return included for strcmp(), 33 for strncmp()).

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 4554b6fcb400..0d5e870c7c0b 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -102,6 +102,17 @@ char *strchr(const char *s, int c)
 	return NULL;
 }
 
+static __attribute__((unused))
+int strcmp(const char *a, const char *b)
+{
+	unsigned int c;
+	int diff;
+
+	while (!(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+	return diff;
+}
+
 static __attribute__((unused))
 char *strcpy(char *dst, const char *src)
 {
@@ -184,6 +195,18 @@ char *strncat(char *dst, const char *src, size_t size)
 	return orig;
 }
 
+static __attribute__((unused))
+int strncmp(const char *a, const char *b, size_t size)
+{
+	unsigned int c;
+	int diff = 0;
+
+	while (size-- &&
+	       !(diff = (unsigned char)*a++ - (c = (unsigned char)*b++)) && c)
+		;
+
+	return diff;
+}
 
 static __attribute__((unused))
 char *strncpy(char *dst, const char *src, size_t size)
-- 
2.35.1

