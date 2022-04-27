Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DCB511EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbiD0Rfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244195AbiD0RfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:35:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2A922168A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04A7E1477;
        Wed, 27 Apr 2022 10:31:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C475A3F73B;
        Wed, 27 Apr 2022 10:31:50 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 09/13] lkdtm/stackleak: rework boundary management
Date:   Wed, 27 Apr 2022 18:31:24 +0100
Message-Id: <20220427173128.2603085-10-mark.rutland@arm.com>
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

There are a few problems with the way the LKDTM STACKLEAK_ERASING test
manipulates the stack pointer and boundary values:

* It uses the address of a local variable to determine the current stack
  pointer, rather than using current_stack_pointer directly. As the
  local variable could be placed anywhere within the stack frame, this
  can be an over-estimate of the true stack pointer value.

* Is uses an estiamte of the current stack pointer as the upper boundary
  when scanning for poison, even though prior functions could have used
  more stack (and may have updated current->lowest stack accordingly).

* A pr_info() call is made in the middle of the test. As the printk()
  code is out-of-line and will make use of the stack, this could clobber
  poison and/or adjust current->lowest_stack. It would be better to log
  the metadata after the body of the test to avoid such problems.

These have been observed to result in spurious test failures on arm64.

In addition to this there are a couple of thigns which are sub-optimal:

* To avoid the STACK_END_MAGIC value, it conditionally modifies 'left'
  if this contains more than a single element, when it could instead
  calculate the bound unconditionally using stackleak_task_low_bound().

* It open-codes the poison scanning. It would be better if this used the
  same helper code as used by erasing function so that the two cannot
  diverge.

This patch reworks the test to avoid these issues, making use of the
recently introduced helpers to ensure this is aligned with the regular
stackleak code.

As the new code tests stack boundaries before accessing the stack, there
is no need to fail early when the tracked or untracked portions of the
stack extend all the way to the low stack boundary.

As stackleak_find_top_of_poison() is now used to find the top of the
poisoned region of the stack, the subsequent poison checking starts at
this boundary and verifies that stackleak_find_top_of_poison() is
working correctly.

The pr_info() which logged the untracked portion of stack is now moved
to the end of the function, and logs the size of all the portions of the
stack relevant to the test, including the portions at the top and bottom
of the stack which are not erased or scanned, and the current / lowest
recorded stack usage.

Tested on x86_64:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 168 bytes
|   current:     336 bytes
|   lowest:      656 bytes
|   tracked:     656 bytes
|   untracked:   400 bytes
|   poisoned:    15152 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

Tested on arm64:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     656 bytes
|   lowest:      1232 bytes
|   tracked:     1232 bytes
|   untracked:   672 bytes
|   poisoned:    14136 bytes
|   low offset:  8 bytes
| lkdtm: OK: the rest of the thread stack is properly erased

Tested on arm64 with deliberate breakage to the starting stack value and
poison scanning:

| # echo STACKLEAK_ERASING > /sys/kernel/debug/provoke-crash/DIRECT
| lkdtm: Performing direct entry STACKLEAK_ERASING
| lkdtm: FAIL: non-poison value 24 bytes below poison boundary: 0x0
| lkdtm: FAIL: non-poison value 32 bytes below poison boundary: 0xffff8000083dbc00
...
| lkdtm: FAIL: non-poison value 1912 bytes below poison boundary: 0x78b4b9999e8cb15
| lkdtm: FAIL: non-poison value 1920 bytes below poison boundary: 0xffff8000083db400
| lkdtm: stackleak stack usage:
|   high offset: 336 bytes
|   current:     688 bytes
|   lowest:      1232 bytes
|   tracked:     576 bytes
|   untracked:   288 bytes
|   poisoned:    15176 bytes
|   low offset:  8 bytes
| lkdtm: FAIL: the thread stack is NOT properly erased!
| lkdtm: Unexpected! This kernel (5.18.0-rc1-00013-g1f7b1f1e29e0-dirty aarch64) was built with CONFIG_GCC_PLUGIN_STACKLEAK=y

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 drivers/misc/lkdtm/stackleak.c | 86 +++++++++++++++++++---------------
 1 file changed, 47 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 707d530d509b7..0aafa46ced7d6 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -13,59 +13,67 @@
 
 void lkdtm_STACKLEAK_ERASING(void)
 {
-	unsigned long *sp, left, found, i;
-	const unsigned long check_depth =
-			STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
+	const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
+	const unsigned long task_stack_low = stackleak_task_low_bound(current);
+	const unsigned long task_stack_high = stackleak_task_high_bound(current);
+	const unsigned long current_sp = current_stack_pointer;
+	const unsigned long lowest_sp = current->lowest_stack;
+	unsigned long untracked_high;
+	unsigned long poison_high, poison_low;
 	bool test_failed = false;
 
 	/*
-	 * For the details about the alignment of the poison values, see
-	 * the comment in stackleak_track_stack().
+	 * Depending on what has run prior to this test, the lowest recorded
+	 * stack pointer could be above or below the current stack pointer.
+	 * Start from the lowest of the two.
+	 *
+	 * Poison values are naturally-aligned unsigned longs. As the current
+	 * stack pointer might not be sufficiently aligned, we must align
+	 * downwards to find the lowest known stack pointer value. This is the
+	 * high boundary for a portion of the stack which may have been used
+	 * without being tracked, and has to be scanned for poison.
 	 */
-	sp = PTR_ALIGN(&i, sizeof(unsigned long));
-
-	left = ((unsigned long)sp & (THREAD_SIZE - 1)) / sizeof(unsigned long);
-	sp--;
+	untracked_high = min(current_sp, lowest_sp);
+	untracked_high = ALIGN_DOWN(untracked_high, sizeof(unsigned long));
 
 	/*
-	 * One 'long int' at the bottom of the thread stack is reserved
-	 * and not poisoned.
+	 * Find the top of the poison in the same way as the erasing code.
 	 */
-	if (left > 1) {
-		left--;
-	} else {
-		pr_err("FAIL: not enough stack space for the test\n");
-		test_failed = true;
-		goto end;
-	}
-
-	pr_info("checking unused part of the thread stack (%lu bytes)...\n",
-					left * sizeof(unsigned long));
+	poison_high = stackleak_find_top_of_poison(task_stack_low, untracked_high);
 
 	/*
-	 * Search for 'check_depth' poison values in a row (just like
-	 * stackleak_erase() does).
+	 * Check whether the poisoned portion of the stack (if any) consists
+	 * entirely of poison. This verifies the entries that
+	 * stackleak_find_top_of_poison() should have checked.
 	 */
-	for (i = 0, found = 0; i < left && found <= check_depth; i++) {
-		if (*(sp - i) == STACKLEAK_POISON)
-			found++;
-		else
-			found = 0;
-	}
+	poison_low = poison_high;
+	while (poison_low > task_stack_low) {
+		poison_low -= sizeof(unsigned long);
 
-	pr_info("the erased part begins after %lu not poisoned bytes\n",
-				(i - found) * sizeof(unsigned long));
+		if (*(unsigned long *)poison_low == STACKLEAK_POISON)
+			continue;
 
-	/* The rest of thread stack should be erased */
-	for (; i < left; i++) {
-		if (*(sp - i) != STACKLEAK_POISON) {
-			pr_err("FAIL: bad value number %lu in the erased part: 0x%lx\n",
-								i, *(sp - i));
-			test_failed = true;
-		}
+		pr_err("FAIL: non-poison value %lu bytes below poison boundary: 0x%lx\n",
+		       poison_high - poison_low, *(unsigned long *)poison_low);
+		test_failed = true;
 	}
 
-end:
+	pr_info("stackleak stack usage:\n"
+		"  high offset: %lu bytes\n"
+		"  current:     %lu bytes\n"
+		"  lowest:      %lu bytes\n"
+		"  tracked:     %lu bytes\n"
+		"  untracked:   %lu bytes\n"
+		"  poisoned:    %lu bytes\n"
+		"  low offset:  %lu bytes\n",
+		task_stack_base + THREAD_SIZE - task_stack_high,
+		task_stack_high - current_sp,
+		task_stack_high - lowest_sp,
+		task_stack_high - untracked_high,
+		untracked_high - poison_high,
+		poison_high - task_stack_low,
+		task_stack_low - task_stack_base);
+
 	if (test_failed) {
 		pr_err("FAIL: the thread stack is NOT properly erased!\n");
 		pr_expected_config(CONFIG_GCC_PLUGIN_STACKLEAK);
-- 
2.30.2

