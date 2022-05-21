Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA152FFDD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347412AbiEUXvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 19:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245043AbiEUXvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:51:08 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD16220D9
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:51:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653177061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vy7Ak3F0cMwR4NDgJNAiMt1tqQVmnBF5Rj3rg221j68=;
        b=SUmBT+dywr8KVt4aoiuH2M3+BxG79p6/AO1BHjmyp9Un+owxWRFHH1r+jjFD07QDZp6Z0j
        5Cgb6h2LszIWU2sHQnDBMbeccu1hbK+JpIeZ/ako3tvtCp9uEDQD4uueS0RUNAYZf3aBb2
        SrE3U+96Fl+XOnRjt/Q86NqfLZVkmGY=
From:   andrey.konovalov@linux.dev
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 1/2] arm64: kasan: do not instrument stacktrace.c
Date:   Sun, 22 May 2022 01:50:58 +0200
Message-Id: <697e015e22ea78b021c2546f390ad5d773f3af86.1653177005.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Disable KASAN instrumentation of arch/arm64/kernel/stacktrace.c.

This speeds up Generic KASAN by 5-20%.

As a side-effect, KASAN is now unable to detect bugs in the stack trace
collection code. This is taken as an acceptable downside.

Also replace READ_ONCE_NOCHECK() with READ_ONCE() in stacktrace.c.
As the file is now not instrumented, there is no need to use the
NOCHECK version of READ_ONCE().

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 arch/arm64/kernel/Makefile     | 3 +++
 arch/arm64/kernel/stacktrace.c | 4 ++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index fa7981d0d917..da8cf6905c76 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -14,6 +14,9 @@ CFLAGS_REMOVE_return_address.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_syscall.o	 = -fstack-protector -fstack-protector-strong
 CFLAGS_syscall.o	+= -fno-stack-protector
 
+# Do not instrument to improve performance.
+KASAN_SANITIZE_stacktrace.o := n
+
 # It's not safe to invoke KCOV when portions of the kernel environment aren't
 # available or are out-of-sync with HW state. Since `noinstr` doesn't always
 # inhibit KCOV instrumentation, disable it for the entire compilation unit.
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index e4103e085681..33e96ae4b15f 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -110,8 +110,8 @@ static int notrace unwind_frame(struct task_struct *tsk,
 	 * Record this frame record's values and location. The prev_fp and
 	 * prev_type are only meaningful to the next unwind_frame() invocation.
 	 */
-	frame->fp = READ_ONCE_NOCHECK(*(unsigned long *)(fp));
-	frame->pc = READ_ONCE_NOCHECK(*(unsigned long *)(fp + 8));
+	frame->fp = READ_ONCE(*(unsigned long *)(fp));
+	frame->pc = READ_ONCE(*(unsigned long *)(fp + 8));
 	frame->prev_fp = fp;
 	frame->prev_type = info.type;
 
-- 
2.25.1

