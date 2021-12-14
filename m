Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23276474796
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 17:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235716AbhLNQWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 11:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbhLNQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 11:22:07 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE93C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:07 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id l4-20020a05600c1d0400b00332f47a0fa3so8099407wms.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CQyambTSmP5kC58BDOZ38NkSus/ix4gF7HsyVWQKWXc=;
        b=RE3Ne1BeyAaL9++X1sCY7W6HxZFmsx3WE7bIxrpwlErXaOtGOfyERSJ5er3nl4ZCpY
         zmAzhk03fbH3MJBmjIftslQUgrs8buJ/7AMueg53qeMYueUQlTzpKz7cHQ/9UUrSNWxa
         5Q5AaP2Tfoy2xyi3yDx/1yESKxT4BNyhXGlX2I0kRZ3z3SiZwhdsTzcPGlF/D0Jdeu5t
         PdY0JYCa8VbVCQxB2i1OtWjEZyLGgvMc0UvOuRLDIK2PS6jiAyEPXnpmIzANy2bhQnXQ
         FLg3tJRU2/w81RXVJWYgfl6HuKYVgTqZOrjBUgfZu4hvco/0MV0VJnM1KAFOmShvQpfR
         EHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CQyambTSmP5kC58BDOZ38NkSus/ix4gF7HsyVWQKWXc=;
        b=0krUMJcykYjfQ4KjF6tlZ+knkfZrni2pR2Jm3G7KYxtsrmIzwoatkkpB+wXp2rRhtF
         PqgWMneeeMVyCGpaO+qXXeB9zC8xa1d6MUOziK1n0EqeOhs1g6vMgRceyZyxjUiwQrY+
         9Al1QTKD6oLIAeDXhHSfMEUQTiHRwN7YHoTts4qN4ztdDn8srdj7uIQkv2ynSYZCWLHx
         tCdQbUhXaoJCxJudLYuJoBLugptcu5N8Nq2HSqZJFJY9I4P0VAixe99z24pzjHCi4p0k
         QnjgxNnH3dvO7V7Dc7lLTO6HDoQ+gJp3BJRNB3Agzj46Ae6GsYXWbO2ADLsh+B5+k6Z8
         p8rw==
X-Gm-Message-State: AOAM532uW3Y2felhZrCslpSZ/hBYYg4fesXlNbbnAXAv3FYFfwcWvp7v
        iarBJxpk1vC9PKVNm+xs17bNWhgNmrg=
X-Google-Smtp-Source: ABdhPJyj4nXTOH98QEuMjM8LdPyxWb8TjdCYI8xbjpieTOD1vLMhRc6PwL5s5uZRNEINQF/xeJdedBJ48NU=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:15:13:357e:2b9d:5b13:a652])
 (user=glider job=sendgmr) by 2002:a05:600c:1d1b:: with SMTP id
 l27mr5818449wms.1.1639498924568; Tue, 14 Dec 2021 08:22:04 -0800 (PST)
Date:   Tue, 14 Dec 2021 17:20:11 +0100
In-Reply-To: <20211214162050.660953-1-glider@google.com>
Message-Id: <20211214162050.660953-5-glider@google.com>
Mime-Version: 1.0
References: <20211214162050.660953-1-glider@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH 04/43] instrumented.h: allow instrumenting both sides of copy_from_user()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pekka Enberg <penberg@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce instrument_copy_from_user_before() and
instrument_copy_from_user_after() hooks to be invoked before and after
the call to copy_from_user().

KASAN and KCSAN will be only using instrument_copy_from_user_before(),
but for KMSAN we'll need to insert code after copy_from_user().

Signed-off-by: Alexander Potapenko <glider@google.com>
---
Link: https://linux-review.googlesource.com/id/I855034578f0b0f126734cbd734fb4ae1d3a6af99
---
 include/linux/instrumented.h | 21 +++++++++++++++++++--
 include/linux/uaccess.h      | 19 ++++++++++++++-----
 lib/iov_iter.c               |  9 ++++++---
 lib/usercopy.c               |  3 ++-
 4 files changed, 41 insertions(+), 11 deletions(-)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 42faebbaa202a..ee8f7d17d34f5 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -120,7 +120,7 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
 }
 
 /**
- * instrument_copy_from_user - instrument writes of copy_from_user
+ * instrument_copy_from_user_before - add instrumentation before copy_from_user
  *
  * Instrument writes to kernel memory, that are due to copy_from_user (and
  * variants). The instrumentation should be inserted before the accesses.
@@ -130,10 +130,27 @@ instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
  * @n number of bytes to copy
  */
 static __always_inline void
-instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
+instrument_copy_from_user_before(const void *to, const void __user *from, unsigned long n)
 {
 	kasan_check_write(to, n);
 	kcsan_check_write(to, n);
 }
 
+/**
+ * instrument_copy_from_user_after - add instrumentation after copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants). The instrumentation should be inserted after the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ * @left number of bytes not copied (as returned by copy_from_user)
+ */
+static __always_inline void
+instrument_copy_from_user_after(const void *to, const void __user *from,
+				unsigned long n, unsigned long left)
+{
+}
+
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d4..8dadd8642afbb 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -98,20 +98,28 @@ static inline void force_uaccess_end(mm_segment_t oldfs)
 static __always_inline __must_check unsigned long
 __copy_from_user_inatomic(void *to, const void __user *from, unsigned long n)
 {
-	instrument_copy_from_user(to, from, n);
+	unsigned long res;
+
+	instrument_copy_from_user_before(to, from, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, res);
+	return res;
 }
 
 static __always_inline __must_check unsigned long
 __copy_from_user(void *to, const void __user *from, unsigned long n)
 {
+	unsigned long res;
+
 	might_fault();
+	instrument_copy_from_user_before(to, from, n);
 	if (should_fail_usercopy())
 		return n;
-	instrument_copy_from_user(to, from, n);
 	check_object_size(to, n, false);
-	return raw_copy_from_user(to, from, n);
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, res);
+	return res;
 }
 
 /**
@@ -155,8 +163,9 @@ _copy_from_user(void *to, const void __user *from, unsigned long n)
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		instrument_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153c..28c033cb9e803 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -161,13 +161,16 @@ static int copyout(void __user *to, const void *from, size_t n)
 
 static int copyin(void *to, const void __user *from, size_t n)
 {
+	size_t res = n;
+
 	if (should_fail_usercopy())
 		return n;
 	if (access_ok(from, n)) {
-		instrument_copy_from_user(to, from, n);
-		n = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
+		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
-	return n;
+	return res;
 }
 
 static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7413dd300516e..1505a52f23a01 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -12,8 +12,9 @@ unsigned long _copy_from_user(void *to, const void __user *from, unsigned long n
 	unsigned long res = n;
 	might_fault();
 	if (!should_fail_usercopy() && likely(access_ok(from, n))) {
-		instrument_copy_from_user(to, from, n);
+		instrument_copy_from_user_before(to, from, n);
 		res = raw_copy_from_user(to, from, n);
+		instrument_copy_from_user_after(to, from, n, res);
 	}
 	if (unlikely(res))
 		memset(to + (n - res), 0, res);
-- 
2.34.1.173.g76aa8bc2d0-goog

