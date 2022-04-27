Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0F5511DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbiD0RfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbiD0Re7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08FD51FC0D5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDAF7143D;
        Wed, 27 Apr 2022 10:31:44 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 89A483F73B;
        Wed, 27 Apr 2022 10:31:43 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 05/13] stackleak: clarify variable names
Date:   Wed, 27 Apr 2022 18:31:20 +0100
Message-Id: <20220427173128.2603085-6-mark.rutland@arm.com>
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
 kernel/stackleak.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 24b7cf01b2972..d5f684dc0a2d9 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -73,40 +73,38 @@ late_initcall(stackleak_sysctls_init);
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

