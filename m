Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91DC04684E8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384969AbhLDNCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 08:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhLDNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 08:02:37 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8D3C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 04:59:11 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so5054506wma.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 04:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ft3q1xFQfL2Ok2lDpTOpcXH+pvRUd7lyPKHQkecVzno=;
        b=jdNd5btKDeLpS3wdSGgNnCqMlYmshZH+6lXUJe9Rix6Pgj7DKR7sMxA58LOE6srWTy
         dE3dnc6dZRm6laarKz1MYi6h7EgYikQuFfdkG2Ux77YrArpjB5z1Wxkv5EFzeGtCMoEC
         JRx8i95NF/3/ykS68JSuBbrp63G5H8cfSDLJBlj9IqfxSuuYwoafhIxkWnprLJb6EbiW
         gequgI37HTjuYQacuwB+5F0FXd8duj4AiRLk55OMnpFCFwIw6trgu3GltQHtFS8dnyfF
         nc7UvnDwGqSIqKAYSVTa2ctFHXE6O1YWKhHwQPomtqA2JuYLWjF35qbbHVZfsEFv6JPW
         wT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ft3q1xFQfL2Ok2lDpTOpcXH+pvRUd7lyPKHQkecVzno=;
        b=5dqzMCxEMuKQ+NqtHm+S2JU5l/zEmxvJsDo3/kh6wET2x7GHtKxBorX1leJ9rzrXgS
         xcNrkvQ6AtDP2AW1o4yJTVKoUbgZX90ecotGrCLcHvTXJXJ0jy91oHt5vxf7EFVmXO8M
         nti9Xi5REkPKbLwUAVfwVDqtLRNbo9BVOc7+eXq7nsQPWvCzG0/u6OOw0F0cp9E2PLuL
         wqLTQBPmnZDi59V4vfWr/jk3A9LcmwCyiyRkqRM582XDI0ryllkvM6EyABViQ1jsSRGu
         gbnVER4ahSMGhXopxrUBVnsxI0ccLb/5YLn+hcI9NZzdz5vla4FqusI+RpMuGyLjilI/
         Mwrg==
X-Gm-Message-State: AOAM532VSwje3+f8NrGkRSwWKvHu0r/6X1bGgKnsZqtd4UQNu3cYBnal
        wrBVDIVfxWu19wxUaJT5txgD2O5T8g==
X-Google-Smtp-Source: ABdhPJxmw+FGTgQslgjUTt+5G8GIEZS+bU4F3Y3cQVdat6Qee6/LPuhJisf7l0Xni7Vo1mi89G7RU/NXew==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:565a:3964:11db:fb41])
 (user=elver job=sendgmr) by 2002:a5d:6101:: with SMTP id v1mr29662764wrt.598.1638622749825;
 Sat, 04 Dec 2021 04:59:09 -0800 (PST)
Date:   Sat,  4 Dec 2021 13:57:03 +0100
Message-Id: <20211204125703.3344454-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH -rcu] kcsan: Turn barrier instrumentation into macros
From:   Marco Elver <elver@google.com>
To:     elver@google.com, "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures use barriers in 'extern inline' functions, from which
we should not refer to static inline functions.

For example, building Alpha with gcc and W=1 shows:

./include/asm-generic/barrier.h:70:30: warning: 'kcsan_rmb' is static but used in inline function 'pmd_offset' which is not static
   70 | #define smp_rmb()       do { kcsan_rmb(); __smp_rmb(); } while (0)
      |                              ^~~~~~~~~
./arch/alpha/include/asm/pgtable.h:293:9: note: in expansion of macro 'smp_rmb'
  293 |         smp_rmb(); /* see above */
      |         ^~~~~~~

Which seems to warn about 6.7.4#3 of the C standard:
  "An inline definition of a function with external linkage shall not
   contain a definition of a modifiable object with static or thread
   storage duration, and shall not contain a reference to an identifier
   with internal linkage."

Fix it by turning barrier instrumentation into macros, which matches
definitions in <asm/barrier.h>.

Perhaps we can revert this change in future, when there are no more
'extern inline' users left.

Link: https://lkml.kernel.org/r/202112041334.X44uWZXf-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/kcsan-checks.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 9d2c869167f2..92f3843d9ebb 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -241,28 +241,30 @@ static inline void __kcsan_disable_current(void) { }
  * disabled with the __no_kcsan function attribute.
  *
  * Also see definition of __tsan_atomic_signal_fence() in kernel/kcsan/core.c.
+ *
+ * These are all macros, like <asm/barrier.h>, since some architectures use them
+ * in non-static inline functions.
  */
 #define __KCSAN_BARRIER_TO_SIGNAL_FENCE(name)					\
-	static __always_inline void kcsan_##name(void)				\
-	{									\
+	do {									\
 		barrier();							\
 		__atomic_signal_fence(__KCSAN_BARRIER_TO_SIGNAL_FENCE_##name);	\
 		barrier();							\
-	}
-__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
-__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
-__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
-__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
+	} while (0)
+#define kcsan_mb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(mb)
+#define kcsan_wmb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(wmb)
+#define kcsan_rmb()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(rmb)
+#define kcsan_release()	__KCSAN_BARRIER_TO_SIGNAL_FENCE(release)
 #elif defined(CONFIG_KCSAN_WEAK_MEMORY) && defined(__KCSAN_INSTRUMENT_BARRIERS__)
 #define kcsan_mb	__kcsan_mb
 #define kcsan_wmb	__kcsan_wmb
 #define kcsan_rmb	__kcsan_rmb
 #define kcsan_release	__kcsan_release
 #else /* CONFIG_KCSAN_WEAK_MEMORY && ... */
-static inline void kcsan_mb(void)		{ }
-static inline void kcsan_wmb(void)		{ }
-static inline void kcsan_rmb(void)		{ }
-static inline void kcsan_release(void)		{ }
+#define kcsan_mb()	do { } while (0)
+#define kcsan_wmb()	do { } while (0)
+#define kcsan_rmb()	do { } while (0)
+#define kcsan_release()	do { } while (0)
 #endif /* CONFIG_KCSAN_WEAK_MEMORY && ... */
 
 /**
-- 
2.34.1.400.ga245620fadb-goog

