Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779F467833
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381031AbhLCNcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:32:04 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56808 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380993AbhLCNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:31:47 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8E4FD1F46E3F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638538102; bh=u/wxdn3Vwh5UX7JPt9/X7+tVDblbozNL8+6pTHbITvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YAlpDH6lTFUrag17b0R7M7azXppb1iJr6+YTdrqfYbCFLJg3quaECqYAS6QmRo7EY
         PYQJo5Dj2IEH9bmKLkqDeBalmqzDaSQdTUJ68ffYXPLiMT6YFn9zHlPcdTrIE2AJWo
         /Xm7UFDNbLfJcc8w9p/gaFpZ+d1lP596iVCA+sjd11KdaXxYJAy3iGS+f/zyNef3Gp
         MUb2FA5+AoBrCbQREf37Pd/BLP+MglQTrI7tru/9TIjY5Uaox0mhxGmDkUQKMeObIf
         LT/a5/juzpKPmbmv6zfDYz55HnpJHI5X7wNGTT5reJ4OeBWlYmD3RxygyPlUzThF8P
         4IldxRRscJTaw==
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH RESEND 2/2] selftests: futex: Add FUTEX_LOCK_PI2 for timeout test
Date:   Fri,  3 Dec 2021 10:28:08 -0300
Message-Id: <20211203132808.16907-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203132808.16907-1-andrealmeid@collabora.com>
References: <20211203132808.16907-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bf22a6976897 ("futex: Provide FUTEX_LOCK_PI2 to support clock
selection"), there's a new operation that supports CLOCK_MONOTONIC and
CLOCK_REALTIME. Test the timeout interface of FUTEX_LOCK_PI2 operation.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c          | 14 +++++++++++++-
 tools/testing/selftests/futex/include/futextest.h  | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 3651ce17beeb..8d0810eb6bf4 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(9);
+	ksft_set_plan(11);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -182,6 +182,18 @@ int main(int argc, char *argv[])
 	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
 
+	/* FUTEX_LOCK_PI2 with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_lock_pi2(&futex_pi, &to, 0, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_lock_pi2 realtime", ETIMEDOUT);
+
+	/* FUTEX_LOCK_PI2 with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_lock_pi2(&futex_pi, &to, 0, 0);
+	test_timeout(res, &ret, "futex_lock_pi2 monotonic", ETIMEDOUT);
+
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
 		return RET_FAIL;
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..d5a04201cd1c 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,9 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_PI2
+#define FUTEX_PI2			13
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -124,6 +127,17 @@ futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
 	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
 }
 
+/**
+ * futex_lock_pi2() - block on uaddr as a PI mutex
+ * @detect:	whether (1) or not (0) to perform deadlock detection
+ */
+static inline int
+futex_lock_pi2(futex_t *uaddr, struct timespec *timeout, int detect,
+	       int opflags)
+{
+	return futex(uaddr, FUTEX_LOCK_PI2, detect, timeout, NULL, 0, opflags);
+}
+
 /**
  * futex_unlock_pi() - release uaddr as a PI mutex, waking the top waiter
  */
-- 
2.34.1

