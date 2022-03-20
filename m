Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2E4E1AE9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 10:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243604AbiCTJkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 05:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243812AbiCTJkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 05:40:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB113CF7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 02:39:00 -0700 (PDT)
Received: from integral2.. (unknown [182.2.42.189])
        by gnuweeb.org (Postfix) with ESMTPSA id B40567E333;
        Sun, 20 Mar 2022 09:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647769140;
        bh=RSEq8dI5RloSlWnt62U9OOk+SbaLshrfq3hpAG2JDpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvatmLBmNzRkFYsBQuFHEtUP6oTAmULHalxKHODm24mf0pEraWorzAhDCnV8J/P69
         lYp//Sw2RRvob30XXxfYOs8gVxEYEnfE98wkKgtKo+ovQwAeP9EI+hcQHowj+fsF9k
         T1W2sg4adNOwY9SxD3lCNFsHirdDLPkKY0VOVLE2/9xFTJkM69Zfz3KGrcXycvPyfg
         Lh0tiIBoufRvogJblWrXMx7B3K+UYdbtGf/wh1d1jUVDqWJFG+XmpNpPaIWnotesWS
         igV5zUBo6E1A9mLpFSkDlgahAPONLbVjBcEH6OKMYjVSIm8gvIcRHylusWx/FJhL56
         EnnSJKKtjp9eg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v1 5/6] tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
Date:   Sun, 20 Mar 2022 16:37:49 +0700
Message-Id: <20220320093750.159991-6-ammarfaizi2@gnuweeb.org>
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

Implement basic dynamic allocator functions. These functions are
currently only available on architectures that have nolibc mmap()
syscall implemented. These are not a super-fast memory allocator,
but at least they can satisfy basic needs for having heap without
libc.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/stdlib.h | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 733105c574ee..13600e73404d 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -10,8 +10,24 @@
 #include "std.h"
 #include "arch.h"
 #include "types.h"
+#include "string.h"
 #include "sys.h"
 
+struct nolibc_heap {
+	size_t	len;
+	char	user_p[] __attribute__((__aligned__));
+};
+
+#ifndef offsetof
+#define offsetof(TYPE, FIELD) ((size_t) &((TYPE *)0)->FIELD)
+#endif
+
+#ifndef container_of
+#define container_of(PTR, TYPE, FIELD) ({			\
+	__typeof__(((TYPE *)0)->FIELD) *__FIELD_PTR = (PTR);	\
+	(TYPE *)((char *) __FIELD_PTR - offsetof(TYPE, FIELD));	\
+})
+#endif
 
 /* Buffer used to store int-to-ASCII conversions. Will only be implemented if
  * any of the related functions is implemented. The area is large enough to
@@ -60,6 +76,18 @@ int atoi(const char *s)
 	return atol(s);
 }
 
+static __attribute__((unused))
+void free(void *ptr)
+{
+	struct nolibc_heap *heap;
+
+	if (!ptr)
+		return;
+
+	heap = container_of(ptr, struct nolibc_heap, user_p);
+	munmap(heap, heap->len);
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
@@ -182,6 +210,57 @@ char *ltoa(long in)
 	return itoa_buffer;
 }
 
+static inline __attribute__((unused))
+void *malloc(size_t len)
+{
+	struct nolibc_heap *heap;
+
+	heap = mmap(NULL, sizeof(*heap) + len, PROT_READ|PROT_WRITE,
+		    MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (__builtin_expect(heap == MAP_FAILED, 0))
+		return NULL;
+
+	heap->len = sizeof(*heap) + len;
+	return heap->user_p;
+}
+
+static inline __attribute__((unused))
+void *calloc(size_t size, size_t nmemb)
+{
+	void *orig;
+	size_t res = 0;
+
+	if (__builtin_expect(__builtin_mul_overflow(nmemb, size, &res), 0)) {
+		SET_ERRNO(ENOMEM);
+		return NULL;
+	}
+
+	/*
+	 * No need to zero the heap, the MAP_ANONYMOUS in malloc()
+	 * already does it.
+	 */
+	return malloc(res);
+}
+
+static inline __attribute__((unused))
+void *realloc(void *old_ptr, size_t new_size)
+{
+	struct nolibc_heap *heap;
+	void *ret;
+
+	if (!old_ptr)
+		return malloc(new_size);
+
+	ret = malloc(new_size);
+	if (__builtin_expect(!ret, 0))
+		return NULL;
+
+	heap = container_of(old_ptr, struct nolibc_heap, user_p);
+	memcpy(ret, heap->user_p, heap->len);
+	munmap(heap, heap->len);
+	return ret;
+}
+
 /* converts unsigned long integer <in> to a string using the static itoa_buffer
  * and returns the pointer to that string.
  */
-- 
Ammar Faizi

