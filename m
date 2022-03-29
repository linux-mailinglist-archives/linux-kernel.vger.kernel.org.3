Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF74EAB21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiC2KUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235090AbiC2KUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:20:05 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BDB241A04
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 03:18:12 -0700 (PDT)
Received: from integral2.. (unknown [182.2.70.161])
        by gnuweeb.org (Postfix) with ESMTPSA id 67C7A7E736;
        Tue, 29 Mar 2022 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1648549092;
        bh=4ayk0palimnVIsRYgwXKtHchFZ/kzcSyKrT7RjDdssQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QYIJB9B6WLqpi0pvZ2g54PBXl0K8QYpmDfzFNOprQssxrGTfZXy7/ofwWo2qyJbbH
         /b9SNLnIihktUfxLCov2HfkRbjiqJziy+HYX2q+Wp4llDlRzbe04bSotQiSG88qF7G
         OaI0oyvw9+wylaa4XZVt0Qh6lB7IK1/IeK0qd/Gy/2Xl4LdqLUy3owjzc1iCIAEbd9
         071ZYXdfTEDnSh5RY3j1aumnUVzFoy4oa1MaNaO8tAe/AsStAI/3HjBpmXGmlMdZb4
         C4hKgYv9DQ5yv8RKvmdaP3e3PlhGE0zVE+OVqnABCZWn1G8J1FvDPzeTK+dSTiH25T
         W5dMYxhc9YwPg==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v2 7/9] tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
Date:   Tue, 29 Mar 2022 17:17:35 +0700
Message-Id: <20220329101737.58985-8-ammarfaizi2@gnuweeb.org>
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

Implement basic dynamic allocator functions. These functions are
currently only available on architectures that have nolibc mmap()
syscall implemented. These are not a super-fast memory allocator,
but at least they can satisfy basic needs for having heap without
libc.

Cc: David Laight <David.Laight@ACULAB.COM>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
===

@@ Changelog:

   Link v1: https://lore.gnuweeb.org/gwml/20220324073039.140946-10-ammarfaizi2@gnuweeb.org
   v1 -> v2:
    * No changes *

   Link v2: https://lore.kernel.org/lkml/20220322102115.186179-7-ammarfaizi2@gnuweeb.org
   RFC v2 -> v1:
    - Round up the malloc() allocation to 4096 (comment from David).
    - Don't realloc() if we still have enough memory to contain the
      requested new size (comment from David).
    - Fix conflict with getenv() fix (after rebase).

   Link v1: https://lore.kernel.org/lkml/20220320093750.159991-6-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Move container_of() and offsetof() macro to types.h with a
      separate patch (comment from Willy).
---
 tools/include/nolibc/stdlib.h | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 8a07e263f0d0..8fd32eaf8037 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -11,7 +11,12 @@
 #include "arch.h"
 #include "types.h"
 #include "sys.h"
+#include "string.h"
 
+struct nolibc_heap {
+	size_t	len;
+	char	user_p[] __attribute__((__aligned__));
+};
 
 /* Buffer used to store int-to-ASCII conversions. Will only be implemented if
  * any of the related functions is implemented. The area is large enough to
@@ -60,6 +65,18 @@ int atoi(const char *s)
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
 /* getenv() tries to find the environment variable named <name> in the
  * environment array pointed to by global variable "environ" which must be
  * declared as a char **, and must be terminated by a NULL (it is recommended
@@ -91,6 +108,70 @@ char *getenv(const char *name)
 	return _getenv(name, environ);
 }
 
+static __attribute__((unused))
+void *malloc(size_t len)
+{
+	struct nolibc_heap *heap;
+
+	/* Always allocate memory with size multiple of 4096. */
+	len  = sizeof(*heap) + len;
+	len  = (len + 4095UL) & -4096UL;
+	heap = mmap(NULL, len, PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_PRIVATE,
+		    -1, 0);
+	if (__builtin_expect(heap == MAP_FAILED, 0))
+		return NULL;
+
+	heap->len = len;
+	return heap->user_p;
+}
+
+static __attribute__((unused))
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
+static __attribute__((unused))
+void *realloc(void *old_ptr, size_t new_size)
+{
+	struct nolibc_heap *heap;
+	size_t user_p_len;
+	void *ret;
+
+	if (!old_ptr)
+		return malloc(new_size);
+
+	heap = container_of(old_ptr, struct nolibc_heap, user_p);
+	user_p_len = heap->len - sizeof(*heap);
+	/*
+	 * Don't realloc() if @user_p_len >= @new_size, this block of
+	 * memory is still enough to handle the @new_size. Just return
+	 * the same pointer.
+	 */
+	if (user_p_len >= new_size)
+		return old_ptr;
+
+	ret = malloc(new_size);
+	if (__builtin_expect(!ret, 0))
+		return NULL;
+
+	memcpy(ret, heap->user_p, heap->len);
+	munmap(heap, heap->len);
+	return ret;
+}
+
 /* Converts the unsigned long integer <in> to its hex representation into
  * buffer <buffer>, which must be long enough to store the number and the
  * trailing zero (17 bytes for "ffffffffffffffff" or 9 for "ffffffff"). The
-- 
Ammar Faizi

