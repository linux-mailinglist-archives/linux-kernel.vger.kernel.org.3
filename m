Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF0511D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244323AbiD0Rfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbiD0RfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:35:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B12420A420
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 638EF1474;
        Wed, 27 Apr 2022 10:31:48 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2FACE3F73B;
        Wed, 27 Apr 2022 10:31:47 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 07/13] stackleak: rework poison scanning
Date:   Wed, 27 Apr 2022 18:31:22 +0100
Message-Id: <20220427173128.2603085-8-mark.rutland@arm.com>
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

Currently we over-estimate the region of stack which must be erased.

To determine the region to be erased, we scan downards for a contiguous
block of poison values (or the low bound of the stack). There are a few
minor problems with this today:

* When we find a block of poison values, we include this block within
  the region to erase.

  As this is included within the region to erase, this causes us to
  redundantly overwrite 'STACKLEAK_SEARCH_DEPTH' (128) bytes with
  poison.

* As the loop condition checks 'poison_count <= depth', it will run an
  additional iteration after finding the contiguous block of poison,
  decrementing 'erase_low' once more than necessary.

  As this is included within the region to erase, this causes us to
  redundantly overwrite an additional unsigned long with poison.

* As we always decrement 'erase_low' after checking an element on the
  stack, we always include the element below this within the region to
  erase.

  As this is included within the region to erase, this causes us to
  redundantly overwrite an additional unsigned long with poison.

  Note that this is not a functional problem. As the loop condition
  checks 'erase_low > task_stack_low', we'll never clobber the
  STACK_END_MAGIC. As we always decrement 'erase_low' after this, we'll
  never fail to erase the element immediately above the STACK_END_MAGIC.

In total, this can cause us to erase `128 + 2 * sizeof(unsigned long)`
bytes more than necessary, which is unfortunate.

This patch reworks the logic to find the address immediately above the
poisoned region, by finding the lowest non-poisoned address. This is
factored into a stackleak_find_top_of_poison() helper both for clarity
and so that this can be shared with the LKDTM test in subsequent
patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 include/linux/stackleak.h | 26 ++++++++++++++++++++++++++
 kernel/stackleak.c        | 18 ++++--------------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index 467661aeb4136..c36e7a3b45e7e 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -42,6 +42,32 @@ stackleak_task_high_bound(const struct task_struct *tsk)
 	return (unsigned long)task_pt_regs(tsk);
 }
 
+/*
+ * Find the address immediately above the poisoned region of the stack, where
+ * that region falls between 'low' (inclusive) and 'high' (exclusive).
+ */
+static __always_inline unsigned long
+stackleak_find_top_of_poison(const unsigned long low, const unsigned long high)
+{
+	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
+	unsigned int poison_count = 0;
+	unsigned long poison_high = high;
+	unsigned long sp = high;
+
+	while (sp > low && poison_count < depth) {
+		sp -= sizeof(unsigned long);
+
+		if (*(unsigned long *)sp == STACKLEAK_POISON) {
+			poison_count++;
+		} else {
+			poison_count = 0;
+			poison_high = sp;
+		}
+	}
+
+	return poison_high;
+}
+
 static inline void stackleak_task_init(struct task_struct *t)
 {
 	t->lowest_stack = stackleak_task_low_bound(t);
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ba346d46218f5..afd54b8e10b83 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -74,20 +74,10 @@ static __always_inline void __stackleak_erase(void)
 {
 	const unsigned long task_stack_low = stackleak_task_low_bound(current);
 	const unsigned long task_stack_high = stackleak_task_high_bound(current);
-	unsigned long erase_low = current->lowest_stack;
-	unsigned long erase_high;
-	unsigned int poison_count = 0;
-	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
-
-	/* Search for the poison value in the kernel stack */
-	while (erase_low > task_stack_low && poison_count <= depth) {
-		if (*(unsigned long *)erase_low == STACKLEAK_POISON)
-			poison_count++;
-		else
-			poison_count = 0;
-
-		erase_low -= sizeof(unsigned long);
-	}
+	unsigned long erase_low, erase_high;
+
+	erase_low = stackleak_find_top_of_poison(task_stack_low,
+						 current->lowest_stack);
 
 #ifdef CONFIG_STACKLEAK_METRICS
 	current->prev_lowest_stack = erase_low;
-- 
2.30.2

