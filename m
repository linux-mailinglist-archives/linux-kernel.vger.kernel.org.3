Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC24C46CCB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 05:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244287AbhLHEv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 23:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244290AbhLHEvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 23:51:52 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BD9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 20:48:20 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r18-20020a25ac52000000b005c9047c420bso2568462ybd.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 20:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JtdRIroDVgccFwCdTVc0TsbiO+v4ycYN9fgE1zvbpew=;
        b=qioJGvHxCaUMYDmDWwlYCm4ZZ+I/yyWW6plwpkL0qqIm/yxh00rgj3Cj9bQulgK6dV
         pmNSUoGFXODYeH8/AgHcaNy+56yvC/IfqkIsGJ2nU1DCs5dHklqn6zvO6+6uL5zi4PKG
         ZsYV5JdtzeqjScR6HVpQcTk1Zdxk5Zt/JTHtOJosP2eq3+nm2bdTkOk0HeYqAZbCCFrX
         sFuguIvussQ80ecbny4Y7opDWo13Kh7hLHxb8cyc6GuZnOnbeHMnNqEnlCQk4VhFFW6w
         TTMezquVS9UurUhV30C0m6yfeHkoxhkcu3ii4CHmqPRmzh7gAQk06VS4aaXzSbUrk2CR
         gt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JtdRIroDVgccFwCdTVc0TsbiO+v4ycYN9fgE1zvbpew=;
        b=u3YPdeBHPYO42Lh7pdn0wwh89fbr7nKNjUEJQ49l7MKRFFIfEo4R/jdiJ2LqFko52m
         ssJ7lXxWndntMpgsdrecqqskISi9BUIkt4pA9k3Vx6FVvOS2LTtFnATGq7JEiq3Pus6U
         Slvaj4hjJVRGUIYyi8PB8eiyWc7E7ubf6oP8ychu69mXR8pGNZV2YevO7x/vzXXDurPK
         OFu2G0a0iLc182wNtdMgHZLDMKpWhjKsZnh0XFYT2C/9vyqqip9p8Pbzjt3fEB8x6Cl1
         nQzqHmllttN7yDnWfQdcXamqjfLQpMK1rNQjdQhcV2UhPpv4BiGpnPVtfZk2H1v6zL6p
         E32g==
X-Gm-Message-State: AOAM5307bnTTZgqHloXzP2zqc50TltxZpyoMd7YOU1o6aCpHm0jTnNwv
        CtOOnKCNZq7yRER3VevmzqSZtlc=
X-Google-Smtp-Source: ABdhPJxsCHqUib2mOPudZ77H+uVFoQunSny/sJrZzgoUbaBQQJhAf9CMq9HP1U+BRyz4zwhjxAoOygw=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:be2d:924d:844b:d2fa])
 (user=pcc job=sendgmr) by 2002:a25:d196:: with SMTP id i144mr54279180ybg.595.1638938899130;
 Tue, 07 Dec 2021 20:48:19 -0800 (PST)
Date:   Tue,  7 Dec 2021 20:48:03 -0800
In-Reply-To: <20211208044808.872554-1-pcc@google.com>
Message-Id: <20211208044808.872554-2-pcc@google.com>
Mime-Version: 1.0
References: <20211208044808.872554-1-pcc@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 1/6] include: split out uaccess instrumentation into a
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

