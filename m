Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4637346F69D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhLIWT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbhLIWT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:19:28 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC90BC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:15:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso12868361ybm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dwdgd8JweL+y6+nrXqZEHKOZ4Er9g7fAxzLKfl2roN8=;
        b=gdXEWqkFty7aXvoUbqtxrKuTbwrsUWyeKzBc/2qK05ncxkeU68IGN+z7CBSBSLhvq0
         VSKZ5zuaZcR1YIagxQBuut2Z1O2JrZ0EYA/8DH5YHg6GIumsATva7EN7ZhQK7SVPg4zI
         B/jm3bOv5kZxpYfijvhqhh27odhS/YcaM02HZ31iiV7B46zKtsD4t+mz0JcFE0ajrOGR
         fC6aqvEfq4GxpxT5lvscXBoZSk5GHmZaUMF6Xhe+RQ/+JXgaZumiw9nurVXihAKKtdLm
         +Occtswm+rWEXKNqAKRP+rNrebfRZmBeaNNCo/NCqPoBWjlhaX/yMiwnSOuqhynp2Wgz
         Y81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dwdgd8JweL+y6+nrXqZEHKOZ4Er9g7fAxzLKfl2roN8=;
        b=7tEl4Tdi3qJnagNTkbIrY9eoBQhup/bcJcrE7WrA4BbxVY0/iJyFLqCM9SWTRLcfhc
         94VKKAG+ujE5zDZjiXz9Fxz092PG88z4c2PwbT3zZyfP5Vq3Xv0Ylg/UWfTt+XtYSfd/
         W1LrUIj2dr9pgiPoBM3JyJ4bqO4tveN/MNLa2KB6uFzUaJtjMA1S2D41cSesFJJIs6fG
         JtziLRG6npp2k8whBApYnhXf4Yia3bjZGstdyHKUskdLwo7hB3cEC0YGpyC7lFvInkIB
         y00B0IrdVD2es6uCrmLdKgomZ0pp4O8b/SkLmwBU7Q1HqdszyL2+dft1eM4TJrFqCMfF
         zVyA==
X-Gm-Message-State: AOAM530DL8HLkYJLbCKYQQr3eAmYADUwmm7t8zho0omh6b49GTC0Xy6W
        678Lugqpd+IYqNk3mO9MEu3tsMI=
X-Google-Smtp-Source: ABdhPJwKihBmfBMEk5ZMArBh1OYKiVcJoYUSS/GWhVtMWG2HAxD/AOhvEyywlKZX0yJ1PDn2dw6nRVI=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:f233:e324:8aa0:f65c])
 (user=pcc job=sendgmr) by 2002:a25:8441:: with SMTP id r1mr9421270ybm.269.1639088154069;
 Thu, 09 Dec 2021 14:15:54 -0800 (PST)
Date:   Thu,  9 Dec 2021 14:15:38 -0800
In-Reply-To: <20211209221545.2333249-1-pcc@google.com>
Message-Id: <20211209221545.2333249-2-pcc@google.com>
Mime-Version: 1.0
References: <20211209221545.2333249-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 1/7] include: split out uaccess instrumentation into a
 separate header
From:   Peter Collingbourne <pcc@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Collingbourne <pcc@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        David Hildenbrand <david@redhat.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an upcoming change we are going to add uaccess instrumentation
that uses inline access to struct task_struct from the
instrumentation routines. Because instrumentation.h is included
from many places including (recursively) from sched.h this would
otherwise lead to a circular dependency. Break the dependency by
moving uaccess instrumentation routines into a separate header,
instrumentation-uaccess.h.

Link: https://linux-review.googlesource.com/id/I625728db0c8db374e13e4ebc54985ac5c79ace7d
Signed-off-by: Peter Collingbourne <pcc@google.com>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
---
 include/linux/instrumented-uaccess.h | 49 ++++++++++++++++++++++++++++
 include/linux/instrumented.h         | 34 -------------------
 include/linux/uaccess.h              |  2 +-
 lib/iov_iter.c                       |  2 +-
 lib/usercopy.c                       |  2 +-
 5 files changed, 52 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/instrumented-uaccess.h

diff --git a/include/linux/instrumented-uaccess.h b/include/linux/instrumented-uaccess.h
new file mode 100644
index 000000000000..ece549088e50
--- /dev/null
+++ b/include/linux/instrumented-uaccess.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This header provides generic wrappers for memory access instrumentation for
+ * uaccess routines that the compiler cannot emit for: KASAN, KCSAN.
+ */
+#ifndef _LINUX_INSTRUMENTED_UACCESS_H
+#define _LINUX_INSTRUMENTED_UACCESS_H
+
+#include <linux/compiler.h>
+#include <linux/kasan-checks.h>
+#include <linux/kcsan-checks.h>
+#include <linux/types.h>
+
+/**
+ * instrument_copy_to_user - instrument reads of copy_to_user
+ *
+ * Instrument reads from kernel memory, that are due to copy_to_user (and
+ * variants). The instrumentation must be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
+{
+	kasan_check_read(from, n);
+	kcsan_check_read(from, n);
+}
+
+/**
+ * instrument_copy_from_user - instrument writes of copy_from_user
+ *
+ * Instrument writes to kernel memory, that are due to copy_from_user (and
+ * variants). The instrumentation should be inserted before the accesses.
+ *
+ * @to destination address
+ * @from source address
+ * @n number of bytes to copy
+ */
+static __always_inline void
+instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
+{
+	kasan_check_write(to, n);
+	kcsan_check_write(to, n);
+}
+
+#endif /* _LINUX_INSTRUMENTED_UACCESS_H */
diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 42faebbaa202..b68f415510c7 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -102,38 +102,4 @@ static __always_inline void instrument_atomic_read_write(const volatile void *v,
 	kcsan_check_atomic_read_write(v, size);
 }
 
-/**
- * instrument_copy_to_user - instrument reads of copy_to_user
- *
- * Instrument reads from kernel memory, that are due to copy_to_user (and
- * variants). The instrumentation must be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
- */
-static __always_inline void
-instrument_copy_to_user(void __user *to, const void *from, unsigned long n)
-{
-	kasan_check_read(from, n);
-	kcsan_check_read(from, n);
-}
-
-/**
- * instrument_copy_from_user - instrument writes of copy_from_user
- *
- * Instrument writes to kernel memory, that are due to copy_from_user (and
- * variants). The instrumentation should be inserted before the accesses.
- *
- * @to destination address
- * @from source address
- * @n number of bytes to copy
- */
-static __always_inline void
-instrument_copy_from_user(const void *to, const void __user *from, unsigned long n)
-{
-	kasan_check_write(to, n);
-	kcsan_check_write(to, n);
-}
-
 #endif /* _LINUX_INSTRUMENTED_H */
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..c0c467e39657 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -3,7 +3,7 @@
 #define __LINUX_UACCESS_H__
 
 #include <linux/fault-inject-usercopy.h>
-#include <linux/instrumented.h>
+#include <linux/instrumented-uaccess.h>
 #include <linux/minmax.h>
 #include <linux/sched.h>
 #include <linux/thread_info.h>
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 66a740e6e153..3f9dc6df7102 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -12,7 +12,7 @@
 #include <linux/compat.h>
 #include <net/checksum.h>
 #include <linux/scatterlist.h>
-#include <linux/instrumented.h>
+#include <linux/instrumented-uaccess.h>
 
 #define PIPE_PARANOIA /* for now */
 
diff --git a/lib/usercopy.c b/lib/usercopy.c
index 7413dd300516..1cd188e62d06 100644
--- a/lib/usercopy.c
+++ b/lib/usercopy.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bitops.h>
 #include <linux/fault-inject-usercopy.h>
-#include <linux/instrumented.h>
+#include <linux/instrumented-uaccess.h>
 #include <linux/uaccess.h>
 
 /* out-of-line parts */
-- 
2.34.1.173.g76aa8bc2d0-goog

