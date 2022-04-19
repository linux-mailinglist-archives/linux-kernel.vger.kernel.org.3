Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3C850610F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbiDSAsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241155AbiDSApQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1FB205E2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0661FB8114D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7918C341D9;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=qvoFiGnxKGL8CeO41lGykeBwj5OoHw3G8fgrmqqwfYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nrM7sBRD3Wbdv24wd4fzRJrbeu5JDFOFXD782vNyFjEVTukRRGXHEvwlXSXZkNR1n
         wP7Z4UJ/s622u5NaxdC4bei9puiYmgqyQanFV/+n8cIVbS9OhLSK6lOXepMmO+p9LC
         Pg90dnXBghaGwfUJMNVuHRXqawWH2ojFL0cPdzm7pJzOTNI5rZFE/TVYmc1GuNd0Xd
         1bqadmLdtw0n1VS3j06Tu1CSdab/M0AepA8MiC/TDqYq6blCtRGgu85qifwV/BIB+p
         NmjfQ8cUEOxaFC9S2GsOU72R2wMda1c3D3LW8S1j7wZLVApWEcicbUM8XdzPKMbxkz
         ww51s9O59t8fQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 74C185C3243; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 59/61] tools/nolibc/stdlib: Implement `malloc()`, `calloc()`, `realloc()` and `free()`
Date:   Mon, 18 Apr 2022 17:42:23 -0700
Message-Id: <20220419004225.3952530-59-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Implement basic dynamic allocator functions. These functions are
currently only available on architectures that have nolibc mmap()
syscall implemented. These are not a super-fast memory allocator,
but at least they can satisfy basic needs for having heap without
libc.

Cc: David Laight <David.Laight@ACULAB.COM>
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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
2.31.1.189.g2e36527f23

