Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E364EAB24
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbiC2KUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbiC2KUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:20:06 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B76A13CEE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:18 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 91AE17E728;
        Tue, 29 Mar 2022 10:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549098;
        bh=xHCPU9NOBSts5NOJLTkMXjyz0B2Gtmos6nJsWrNZUJI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lDYHBaduwYvLQzNN7zQCJmfIfWdPud/oAw0V3IysxTH4DX2QF2HuWlhCCoBqpk+aB
         6WUq8b/Iq6QZ21koMJUszKRtCAOEeIgNZXlCUSLtc7VohKyWHwCLj7VEt9zVVVQarf
         qP25RXW4YNUHfzYD2hebJjONlSLQNrTA46kFCl8pY0Q6yLLg9A1E/24FAiwqno39X1
         WkFLufjcQzcEs+GRzvbeASmjT2ornLMcSZNtVMgmI+DH4tgJbOQWjFEiixvPO+yrmG
         qM2gYcCSet6FAZCoHYGGrU4P/Nh4sIldifaEaY9EYvbFpVYxn0uh0GhFs293eGBAzU
         lVutbfp6zNw3A==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: [PATCH v2 9/9] tools/include/string: Implement `strdup()` and `strndup()`
Date:   Tue, 29 Mar 2022 17:17:37 +0700
Message-Id: <20220329101737.58985-10-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
References: <20220329101737.58985-1-ammarfaizi2@gnuweeb.org>
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

These functions are currently only available on architectures that have
my_syscall6() macro implemented. Since these functions use malloc(),
malloc() uses mmap(), mmap() depends on my_syscall6() macro.

On architectures that don't support my_syscall6(), these function will
always return NULL with errno set to ENOSYS.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===

@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-12-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link RFC v2: https://lore.kernel.org/lkml/20220322102115.186179-9-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    * No changes *

   Link RFC v1: https://lore.kernel.org/lkml/20220320093750.159991-7-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Update strdup and strndup implementation, use strlen and strnlen to get
      the string length first (comment from Willy and Alviro).
    - Fix the subject line prefix, it was "tools/include/string: ", it should be
      "tools/nolibc/string: ".
---
 tools/include/nolibc/string.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index f43d52a44d09..bef35bee9c44 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -9,6 +9,8 @@
 
 #include "std.h"
 
+static void *malloc(size_t len);
+
 /*
  * As much as possible, please keep functions alphabetically sorted.
  */
@@ -156,6 +158,36 @@ size_t strnlen(const char *str, size_t maxlen)
 	return len;
 }
 
+static __attribute__((unused))
+char *strdup(const char *str)
+{
+	size_t len;
+	char *ret;
+
+	len = strlen(str);
+	ret = malloc(len + 1);
+	if (__builtin_expect(ret != NULL, 1))
+		memcpy(ret, str, len + 1);
+
+	return ret;
+}
+
+static __attribute__((unused))
+char *strndup(const char *str, size_t maxlen)
+{
+	size_t len;
+	char *ret;
+
+	len = strnlen(str, maxlen);
+	ret = malloc(len + 1);
+	if (__builtin_expect(ret != NULL, 1)) {
+		memcpy(ret, str, len);
+		ret[len] = '\0';
+	}
+
+	return ret;
+}
+
 static __attribute__((unused))
 size_t strlcat(char *dst, const char *src, size_t size)
 {
-- 
Ammar Faizi

