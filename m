Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616DD511D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244248AbiD0Rf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbiD0Re5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235A67DA94
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D0A17ED1;
        Wed, 27 Apr 2022 10:31:42 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9CB7B3F73B;
        Wed, 27 Apr 2022 10:31:41 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 04/13] stackleak: rework stack low bound handling
Date:   Wed, 27 Apr 2022 18:31:19 +0100
Message-Id: <20220427173128.2603085-5-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220427173128.2603085-1-mark.rutland@arm.com>
References: <20220427173128.2603085-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In stackleak_task_init(), stackleak_track_stack(), and
__stackleak_erase(), we open-code skipping the STACK_END_MAGIC at the
bottom of the stack. Each case is implemented slightly differently, and
only the __stackleak_erase() case is commented.

In stackleak_task_init() and stackleak_track_stack() we unconditionally
add sizeof(unsigned long) to the lowest stack address. In
stackleak_task_init() we use end_of_stack() for this, and in
stackleak_track_stack() we use task_stack_page(). In __stackleak_erase()
we handle this by detecting if `kstack_ptr` has hit the stack end
boundary, and if so, conditionally moving it above the magic.

This patch adds a new stackleak_task_low_bound() helper which is used in
all three cases, which unconditionally adds sizeof(unsigned long) to the
lowest address on the task stack, with commentary as to why. This uses
end_of_stack() as stackleak_task_init() did prior to this patch, as this
is consistent with the code in kernel/fork.c which initializes the
STACK_END_MAGIC value.

In __stackleak_erase() we no longer need to check whether we've spilled
into the STACK_END_MAGIC value, as stackleak_track_stack() ensures that
`current->lowest_stack` stops immediately above this, and similarly the
poison scan will stop immediately above this.

For stackleak_task_init() and stackleak_track_stack() this results in no
change to code generation. For __stackleak_erase() the generated
assembly is slightly simpler and shorter.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/stackleak.h | 15 ++++++++++++++-
 kernel/stackleak.c        | 14 ++++----------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index ccaab2043fcd5..67430faa5c518 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -15,9 +15,22 @@
 #ifdef CONFIG_GCC_PLUGIN_STACKLEAK
 #include <asm/stacktrace.h>
 
+/*
+ * The lowest address on tsk's stack which we can plausibly erase.
+ */
+static __always_inline unsigned long
+stackleak_task_low_bound(const struct task_struct *tsk)
+{
+	/*
+	 * The lowest unsigned long on the task stack contains STACK_END_MAGIC,
+	 * which we must not corrupt.
+	 */
+	return (unsigned long)end_of_stack(tsk) + sizeof(unsigned long);
+}
+
 static inline void stackleak_task_init(struct task_struct *t)
 {
-	t->lowest_stack = (unsigned long)end_of_stack(t) + sizeof(unsigned long);
+	t->lowest_stack = stackleak_task_low_bound(t);
 # ifdef CONFIG_STACKLEAK_METRICS
 	t->prev_lowest_stack = t->lowest_stack;
 # endif
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index f7a0f8cf73c37..24b7cf01b2972 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -72,9 +72,11 @@ late_initcall(stackleak_sysctls_init);
 
 static __always_inline void __stackleak_erase(void)
 {
+	const unsigned long task_stack_low = stackleak_task_low_bound(current);
+
 	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
 	unsigned long kstack_ptr = current->lowest_stack;
-	unsigned long boundary = (unsigned long)end_of_stack(current);
+	unsigned long boundary = task_stack_low;
 	unsigned int poison_count = 0;
 	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
 
@@ -88,13 +90,6 @@ static __always_inline void __stackleak_erase(void)
 		kstack_ptr -= sizeof(unsigned long);
 	}
 
-	/*
-	 * One 'long int' at the bottom of the thread stack is reserved and
-	 * should not be poisoned (see CONFIG_SCHED_STACK_END_CHECK=y).
-	 */
-	if (kstack_ptr == boundary)
-		kstack_ptr += sizeof(unsigned long);
-
 #ifdef CONFIG_STACKLEAK_METRICS
 	current->prev_lowest_stack = kstack_ptr;
 #endif
@@ -140,8 +135,7 @@ void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
 	/* 'lowest_stack' should be aligned on the register width boundary */
 	sp = ALIGN(sp, sizeof(unsigned long));
 	if (sp < current->lowest_stack &&
-	    sp >= (unsigned long)task_stack_page(current) +
-						sizeof(unsigned long)) {
+	    sp >= stackleak_task_low_bound(current)) {
 		current->lowest_stack = sp;
 	}
 }
-- 
2.30.2

