Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FDA4E3C61
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbiCVKXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiCVKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:23:31 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703C481198
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:21:57 -0700 (PDT)
Received: from integral2.. (unknown [182.2.69.158])
        by gnuweeb.org (Postfix) with ESMTPSA id 09F127E33E;
        Tue, 22 Mar 2022 10:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647944516;
        bh=x+mKN/1p95Zf0+fLiZBiEJVGOeVZbrDqmetqJdLgFD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cT5xjjU4jkQdMIwuGOxBIramShd5dkEo+XyOG2iYIYWG9zFSZ60OS42FDLHCfdf4D
         oQeb5+PUAmNrCiFpeA6M/Unj/FM6NvgggmZO9FIKxgvlektJV6Ro7ZEQyGugl20YOi
         e/QO4nySl3GgRXzZ7cAphWPkHyS8MxgUZbKP/L7XrsYsgH6HJYOUc0yzFGBs2sBhpd
         YAy2K0L7ScVcuoDD6ISwWIoBLMh8VEiZdx5rncoCMjrNXbSSLTBni5Ib9tRBWmw2Yo
         wSCSPAG2MpnGgaEkwT/vAHSVhpvYugdNBPhxE/Mu0u9Cos4cEhN8HtnkOtVWVAPd48
         GpX+C/AjNdH4g==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Nugraha <richiisei@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [RFC PATCH v2 6/8] tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
Date:   Tue, 22 Mar 2022 17:21:13 +0700
Message-Id: <20220322102115.186179-7-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
References: <20220322102115.186179-1-ammarfaizi2@gnuweeb.org>
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

@@ Changelog:

   Link: https://lore.kernel.org/lkml/20220320093750.159991-6-ammarfaizi2@gnuweeb.org
   RFC v1 -> RFC v2:
    - Move container_of() and offsetof() macro to types.h with a
      separate patch (comment from Willy).
---
 tools/include/nolibc/stdlib.h | 68 +++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index aca8616335e3..a0ed75431e0a 100644
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
 /* Tries to find the environment variable named <name> in the environment array
  * pointed to by global variable "environ" which must be declared as a char **,
  * and must be terminated by a NULL (it is recommended to set this variable to
@@ -205,6 +222,57 @@ char *ltoa(long in)
 	return itoa_buffer;
 }
 
+static __attribute__((unused))
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
+	void *ret;
+
+	ret = malloc(new_size);
+	if (__builtin_expect(!ret, 0))
+		return NULL;
+
+	if (!old_ptr)
+		return ret;
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

