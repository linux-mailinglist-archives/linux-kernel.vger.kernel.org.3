Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790750DF8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiDYMAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiDYL72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:59:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 270A926E6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:56:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF4121FB;
        Mon, 25 Apr 2022 04:56:24 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6A8283F73B;
        Mon, 25 Apr 2022 04:56:23 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH 7/8] stackleak: add on/off stack variants
Date:   Mon, 25 Apr 2022 12:56:02 +0100
Message-Id: <20220425115603.781311-8-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425115603.781311-1-mark.rutland@arm.com>
References: <20220425115603.781311-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stackleak_erase() code dynamically handles being on a task stack or
another stack. In most cases, this is a fixed property of the caller,
which the caller is aware of, as an architecture might always return
using the task stack, or might always return using a trampoline stack.

This patch adds stackleak_erase_on_task_stack() and
stackleak_erase_off_task_stack() functions which callers can use to
avoid on_thread_stack() check and associated redundant work when the
calling stack is known. The existing stackleak_erase() is retained as a
safe default.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ba346d46218f5..4c3f82066d7fb 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
-static __always_inline void __stackleak_erase(void)
+static __always_inline void __stackleak_erase(bool on_task_stack)
 {
 	const unsigned long task_stack_low = stackleak_task_low_bound(current);
 	const unsigned long task_stack_high = stackleak_task_high_bound(current);
@@ -106,7 +106,7 @@ static __always_inline void __stackleak_erase(void)
 	 * function has a fixed-size stack frame, and the current stack pointer
 	 * doesn't change while we write poison.
 	 */
-	if (on_thread_stack())
+	if (on_task_stack)
 		erase_high = current_stack_pointer;
 	else
 		erase_high = task_stack_high;
@@ -120,12 +120,41 @@ static __always_inline void __stackleak_erase(void)
 	current->lowest_stack = task_stack_high;
 }
 
+/*
+ * Erase and poison the portion of the task stack used since the last erase.
+ * Can be called from the task stack or an entry stack when the task stack is
+ * no longer in use.
+ */
 asmlinkage void noinstr stackleak_erase(void)
 {
 	if (skip_erasing())
 		return;
 
-	__stackleak_erase();
+	__stackleak_erase(on_thread_stack());
+}
+
+/*
+ * Erase and poison the portion of the task stack used since the last erase.
+ * Can only be called from the task stack.
+ */
+asmlinkage void noinstr stackleak_erase_on_task_stack(void)
+{
+	if (skip_erasing())
+		return;
+
+	__stackleak_erase(true);
+}
+
+/*
+ * Erase and poison the portion of the task stack used since the last erase.
+ * Can only be called from a stack other than the task stack.
+ */
+asmlinkage void noinstr stackleak_erase_off_task_stack(void)
+{
+	if (skip_erasing())
+		return;
+
+	__stackleak_erase(false);
 }
 
 void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
-- 
2.30.2

