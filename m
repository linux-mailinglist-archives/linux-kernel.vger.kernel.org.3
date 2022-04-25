Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483CF50DF7A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiDYL7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236443AbiDYL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:59:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31303B1CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 04:56:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAA8D1FB;
        Mon, 25 Apr 2022 04:56:18 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 92BDF3F73B;
        Mon, 25 Apr 2022 04:56:17 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH 4/8] stackleak: clarify variable names
Date:   Mon, 25 Apr 2022 12:55:59 +0100
Message-Id: <20220425115603.781311-5-mark.rutland@arm.com>
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

The logic within __stackleak_erase() can be a little hard to follow, as
`boundary` switches from being the low bound to the high bound mid way
through the function, and `kstack_ptr` is used to represent the start of
the region to erase while `boundary` represents the end of the region to
erase.

Make this a little clearer by consistently using clearer variable names.
The `boundary` variable is removed, the bounds of the region to erase
are described by `erase_low` and `erase_high`, and bounds of the task
stack are described by `task_stack_low` and `task_stck_high`.

As the same time, remove the comment above the variables, since it is
unclear whether it's intended as rationale, a complaint, or a TODO, and
is more confusing than helpful.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 0472956d9a2ce..8fbc1e4c21435 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -73,44 +73,42 @@ late_initcall(stackleak_sysctls_init);
 static __always_inline void __stackleak_erase(void)
 {
 	const unsigned long task_stack_low = stackleak_task_low_bound(current);
-
-	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
-	unsigned long kstack_ptr = current->lowest_stack;
-	unsigned long boundary = task_stack_low;
+	unsigned long erase_low = current->lowest_stack;
+	unsigned long erase_high;
 	unsigned int poison_count = 0;
 	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
 
 	/* Check that 'lowest_stack' value is sane */
-	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
-		kstack_ptr = boundary;
+	if (unlikely(erase_low - task_stack_low >= THREAD_SIZE))
+		erase_low = task_stack_low;
 
 	/* Search for the poison value in the kernel stack */
-	while (kstack_ptr > boundary && poison_count <= depth) {
-		if (*(unsigned long *)kstack_ptr == STACKLEAK_POISON)
+	while (erase_low > task_stack_low && poison_count <= depth) {
+		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
 			poison_count++;
 		else
 			poison_count = 0;
 
-		kstack_ptr -= sizeof(unsigned long);
+		erase_low -= sizeof(unsigned long);
 	}
 
 #ifdef CONFIG_STACKLEAK_METRICS
-	current->prev_lowest_stack = kstack_ptr;
+	current->prev_lowest_stack = erase_low;
 #endif
 
 	/*
-	 * Now write the poison value to the kernel stack. Start from
-	 * 'kstack_ptr' and move up till the new 'boundary'. We assume that
-	 * the stack pointer doesn't change when we write poison.
+	 * Now write the poison value to the kernel stack between 'erase_low'
+	 * and 'erase_high'. We assume that the stack pointer doesn't change
+	 * when we write poison.
 	 */
 	if (on_thread_stack())
-		boundary = current_stack_pointer;
+		erase_high = current_stack_pointer;
 	else
-		boundary = current_top_of_stack();
+		erase_high = current_top_of_stack();
 
-	while (kstack_ptr < boundary) {
-		*(unsigned long *)kstack_ptr = STACKLEAK_POISON;
-		kstack_ptr += sizeof(unsigned long);
+	while (erase_low < erase_high) {
+		*(unsigned long *)erase_low = STACKLEAK_POISON;
+		erase_low += sizeof(unsigned long);
 	}
 
 	/* Reset the 'lowest_stack' value for the next syscall */
-- 
2.30.2

