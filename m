Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDD5474DA0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbhLNWFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:05:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:56120 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhLNWEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC35361723
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DAC3463A;
        Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519482;
        bh=suMRtz9eOkx8t+TeoIoIqKiiGn2vIfRnCp0Lrdxlg8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9AsQcoZz2vGuDYICcHP2kP07/8CCYN8K3euC/NCXmCqQBbKh4n0uQBY0vB6zYW2g
         smLEfGzm0KCLT/kD0I16f84RsB/vCAWYE3zlfnmZTbBWUVPHvwZcWknr8fDnyNVlSP
         m4/gJ0ymAA5prg+s2So3ZmJSKL8RVesMzyTBOLdALsoIPc2cIOqUdHMB+bKyVVQGDa
         uP4uClCYxELN61Eij35aNwE2AsdOYCiAYBTfD3qbdCyWMB88RK8Zwvci86ui6Y1+f3
         R3NCTp9Ywn+8dS19iaHK0u56fBAbqvmfeKwaWOiLX4ranj7vZQ1JqDxR8hgmgpRUan
         7s+BgutSGbARQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 8A2C05C2147; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 25/29] kcsan: Support WEAK_MEMORY with Clang where no objtool support exists
Date:   Tue, 14 Dec 2021 14:04:35 -0800
Message-Id: <20211214220439.2236564-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Clang and GCC behave a little differently when it comes to the
__no_sanitize_thread attribute, which has valid reasons, and depending
on context either one could be right.

Traditionally, user space ThreadSanitizer [1] still expects instrumented
builtin atomics (to avoid false positives) and __tsan_func_{entry,exit}
(to generate meaningful stack traces), even if the function has the
attribute no_sanitize("thread").

[1] https://clang.llvm.org/docs/ThreadSanitizer.html#attribute-no-sanitize-thread

GCC doesn't follow the same policy (for better or worse), and removes
all kinds of instrumentation if no_sanitize is added. Arguably, since
this may be a problem for user space ThreadSanitizer, we expect this may
change in future.

Since KCSAN != ThreadSanitizer, the likelihood of false positives even
without barrier instrumentation everywhere, is much lower by design.

At least for Clang, however, to fully remove all sanitizer
instrumentation, we must add the disable_sanitizer_instrumentation
attribute, which is available since Clang 14.0.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/compiler_types.h | 13 ++++++++++++-
 lib/Kconfig.kcsan              |  2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 1d32f4c03c9ef..3c1795fdb5686 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -198,9 +198,20 @@ struct ftrace_likely_data {
 # define __no_kasan_or_inline __always_inline
 #endif
 
-#define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
+/*
+ * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
+ * atomics even with __no_sanitize_thread (to avoid false positives in userspace
+ * ThreadSanitizer). The kernel's requirements are stricter and we really do not
+ * want any instrumentation with __no_kcsan.
+ *
+ * Therefore we add __disable_sanitizer_instrumentation where available to
+ * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
+ */
+# define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
 # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
+#else
+# define __no_kcsan
 #endif
 
 #ifndef __no_sanitize_or_inline
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index e4394ea8068b0..63b70b8c55519 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -198,7 +198,7 @@ config KCSAN_WEAK_MEMORY
 	# We can either let objtool nop __tsan_func_{entry,exit}() and builtin
 	# atomics instrumentation in .noinstr.text, or use a compiler that can
 	# implement __no_kcsan to really remove all instrumentation.
-	depends on STACK_VALIDATION || CC_IS_GCC
+	depends on STACK_VALIDATION || CC_IS_GCC || CLANG_VERSION >= 140000
 	help
 	  Enable support for modeling a subset of weak memory, which allows
 	  detecting a subset of data races due to missing memory barriers.
-- 
2.31.1.189.g2e36527f23

