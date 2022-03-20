Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7694E1AE7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244471AbiCTJk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbiCTJkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:33 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05A140E7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:39:04 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id 0797F7E335;
        Sun, 20 Mar 2022 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769144;
        bh=BuWwbvbdO1pAfMLZtLiokH1rP8SoQ7kLSInYGGGXMhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kdnl13VXhHYGESqMLY0vF7YRt97GWcB5+OaEz4Gg55d5dm/lOKGzYEk8MtTZBZMit
         OKtQxTLqKB80mkKA8pit287FgFBPTCowBq/JUBcCpKtYsyeAmR5Yw/aKOzM5+rFCZK
         su756yLKNStlVTjU4ElSGMzJCOZARrmsmhczBzWJydaGMR4iZ+HY1SBqborb9MzYbT
         pAxsR4zRYYT06m/SdoYgdUHJBAjw2J9nzZIoZ1EEY87fjKC6auA9j3A2d5SvEdDp/c
         mvm0DXO3PWidxbrd/CjbRsf0MyH+QOupHNaON4slhyhc5Y3wjYCGzM3z3pmXh88cea
         iTXfJF1S5Y20w==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v1 6/6] tools/include/string: Implement `strdup()` and `strndup()`
Date:   Sun, 20 Mar 2022 16:37:50 +0700
Message-Id: <20220320093750.159991-7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
References: <20220320093750.159991-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add strdup and strndup support. These functions are only available on
architectures that have my_syscall6() macro from nolibc.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/string.h | 68 +++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 4554b6fcb400..413c65f7c853 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -9,6 +9,10 @@
 
 #include "std.h"
 
+static void free(void *ptr);
+static void *malloc(size_t len);
+static void *realloc(void *old_ptr, size_t new_size);
+
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
@@ -127,6 +131,70 @@ size_t nolibc_strlen(const char *str)
 		nolibc_strlen((str));           \
 })
 
+static __attribute__((unused))
+char *strdup(const char *str)
+{
+	size_t allocated = 2048;
+	size_t i;
+	char *ret;
+	char *tmp;
+
+	ret = malloc(allocated);
+	if (__builtin_expect(!ret, 0))
+		return NULL;
+
+	i = 0;
+	for (;;) {
+		char c = *str;
+		if (!c)
+			break;
+
+		if (i == allocated) {
+			allocated += 2048;
+			tmp = realloc(ret, allocated);
+			if (__builtin_expect(!tmp, 0)) {
+				free(ret);
+				return NULL;
+			}
+			ret = tmp;
+		}
+
+		ret[i++] = c;
+		str++;
+	}
+
+	ret[i] = '\0';
+	return ret;
+}
+
+static __attribute__((unused))
+char *strndup(const char *str, size_t maxlen)
+{
+	size_t i;
+	char *ret;
+
+	ret = malloc(maxlen + 1);
+	if (__builtin_expect(!ret, 0))
+		return NULL;
+
+	i = 0;
+	for (;;) {
+		char c = *str;
+		if (!c)
+			break;
+
+		if (i == maxlen)
+			break;
+
+		ret[i++] = c;
+		str++;
+	}
+
+	ret[i] = '\0';
+	return ret;
+}
+
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
Ammar Faizi

