Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025CC474D99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbhLNWEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:04:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55950 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhLNWEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:04:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27892616CF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 22:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C3FC34605;
        Tue, 14 Dec 2021 22:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639519481;
        bh=NutXZOjos+OXRguAypoyirmrM7rvyeKjGS7yQROX5V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WWFffCBmKZQPHnZ1ZCv4xbrsk611RMlKdMfOoUDhsfXWMcPPzcPb22HQUGPecLs9V
         WPNhvHwz9JfwNmNw9WwL0adiid3OJMZezhDB70tMRAmCIuzcdBdxKAkhQK2/AC4W2S
         6ycswK3F0cOWCiK84VvRbVAVcLHEOPS94h8fzc90A1nuXvvNUFK12FfO5P9VpmVn8D
         HSpw7mOc4k5chr7p3dK0EixThvV3TJhXXq34bZ7kZLLV/04YD/Kq3qaYWf63eMuGUK
         +5LJdD0HqPyfspTtBd4xitrnyzq8ohHE/sSxYIciytkZ/RzRCT4gaMpgq3XX4mZllA
         gLn2vEDFhUj8w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 585B95C03AE; Tue, 14 Dec 2021 14:04:41 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH kcsan 01/29] kcsan: Refactor reading of instrumented memory
Date:   Tue, 14 Dec 2021 14:04:11 -0800
Message-Id: <20211214220439.2236564-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
References: <20211214220356.GA2236323@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Factor out the switch statement reading instrumented memory into a
helper read_instrumented_memory().

No functional change.

Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 51 +++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 4b84c8e7884b4..6bfd3040f46be 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -325,6 +325,21 @@ static void delay_access(int type)
 	udelay(delay);
 }
 
+/*
+ * Reads the instrumented memory for value change detection; value change
+ * detection is currently done for accesses up to a size of 8 bytes.
+ */
+static __always_inline u64 read_instrumented_memory(const volatile void *ptr, size_t size)
+{
+	switch (size) {
+	case 1:  return READ_ONCE(*(const u8 *)ptr);
+	case 2:  return READ_ONCE(*(const u16 *)ptr);
+	case 4:  return READ_ONCE(*(const u32 *)ptr);
+	case 8:  return READ_ONCE(*(const u64 *)ptr);
+	default: return 0; /* Ignore; we do not diff the values. */
+	}
+}
+
 void kcsan_save_irqtrace(struct task_struct *task)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
@@ -482,23 +497,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	 * Read the current value, to later check and infer a race if the data
 	 * was modified via a non-instrumented access, e.g. from a device.
 	 */
-	old = 0;
-	switch (size) {
-	case 1:
-		old = READ_ONCE(*(const u8 *)ptr);
-		break;
-	case 2:
-		old = READ_ONCE(*(const u16 *)ptr);
-		break;
-	case 4:
-		old = READ_ONCE(*(const u32 *)ptr);
-		break;
-	case 8:
-		old = READ_ONCE(*(const u64 *)ptr);
-		break;
-	default:
-		break; /* ignore; we do not diff the values */
-	}
+	old = read_instrumented_memory(ptr, size);
 
 	/*
 	 * Delay this thread, to increase probability of observing a racy
@@ -511,23 +510,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type, unsigned
 	 * racy access.
 	 */
 	access_mask = ctx->access_mask;
-	new = 0;
-	switch (size) {
-	case 1:
-		new = READ_ONCE(*(const u8 *)ptr);
-		break;
-	case 2:
-		new = READ_ONCE(*(const u16 *)ptr);
-		break;
-	case 4:
-		new = READ_ONCE(*(const u32 *)ptr);
-		break;
-	case 8:
-		new = READ_ONCE(*(const u64 *)ptr);
-		break;
-	default:
-		break; /* ignore; we do not diff the values */
-	}
+	new = read_instrumented_memory(ptr, size);
 
 	diff = old ^ new;
 	if (access_mask)
-- 
2.31.1.189.g2e36527f23

