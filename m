Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B95E474DB0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238252AbhLNWFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58734 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbhLNWEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E120CE1B02
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473CCC341CA;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=AyEpGIij6KWnymZdzgckM155Ks14j4hzuMiUj4gcOKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NLXyvB1fDRRLl+3DEovI/l6bjSejtVx0d2iPODdfz9TF0KPvjX5G9D1FrguaAqa0J
         FG0XP4nrtrHnPKMkiYyP69jtX6oNbxdSs8Qa9PKtppAo0p5Wc/dN8x32k4FKheQ9KJ
         9Mlyju9GkfBR5ZZc4RyYX9zXJndDkoT/b4nsZKFKTHxRD6TOfu5Dbli7v2i1+Q29FS
         85Y3KagO4eAr1BEOc3dJWm8/nmrfUrISudFeX5kFD350dyS8Lmmo3QB9TNSDJIJo+L
         JrrQF8u3z4E4jrqUn+DjcgbNLaBBCm22g0M0mTbpV8ofEG2xN3LfvQv80HsdQO/P8m
         5YnQN2+9I8m2A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8E1F95C2B3C; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        kernel test robot <lkp@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 27/29] kcsan: Turn barrier instrumentation into macros
Date:   Tue, 14 Dec 2021 14:04:37 -0800
Message-Id: <20211214220439.2236564-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

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
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 9d2c869167f2e..92f3843d9ebb8 100644
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
2.31.1.189.g2e36527f23

