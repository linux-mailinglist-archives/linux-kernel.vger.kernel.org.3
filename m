Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33D6511E59
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244389AbiD0Rfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244288AbiD0RfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:35:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D3602245B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E06B3ED1;
        Wed, 27 Apr 2022 10:31:53 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC4123F73B;
        Wed, 27 Apr 2022 10:31:52 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 10/13] lkdtm/stackleak: prevent unexpected stack usage
Date:   Wed, 27 Apr 2022 18:31:25 +0100
Message-Id: <20220427173128.2603085-11-mark.rutland@arm.com>
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

The lkdtm_STACKLEAK_ERASING() test is instrumentable and runs with IRQs
unmasked, so it's possible for unrelated code to clobber the task stack
and/or manipulate current->lowest_stack while the test is running,
resulting in spurious failures.

The regular stackleak erasing code is non-instrumentable and runs with
IRQs masked, preventing similar issues.

Make the body of the test non-instrumentable, and run it with IRQs
masked, avoiding such spurious failures.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>
---
 drivers/misc/lkdtm/stackleak.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/stackleak.c b/drivers/misc/lkdtm/stackleak.c
index 0aafa46ced7d6..46c60761a05ea 100644
--- a/drivers/misc/lkdtm/stackleak.c
+++ b/drivers/misc/lkdtm/stackleak.c
@@ -11,7 +11,20 @@
 #include "lkdtm.h"
 #include <linux/stackleak.h>
 
-void lkdtm_STACKLEAK_ERASING(void)
+/*
+ * Check that stackleak tracks the lowest stack pointer and erases the stack
+ * below this as expected.
+ *
+ * To prevent the lowest stack pointer changing during the test, IRQs are
+ * masked and instrumentation of this function is disabled. We assume that the
+ * compiler will create a fixed-size stack frame for this function.
+ *
+ * Any non-inlined function may make further use of the stack, altering the
+ * lowest stack pointer and/or clobbering poison values. To avoid spurious
+ * failures we must avoid printing until the end of the test or have already
+ * encountered a failure condition.
+ */
+static void noinstr check_stackleak_irqoff(void)
 {
 	const unsigned long task_stack_base = (unsigned long)task_stack_page(current);
 	const unsigned long task_stack_low = stackleak_task_low_bound(current);
@@ -81,3 +94,12 @@ void lkdtm_STACKLEAK_ERASING(void)
 		pr_info("OK: the rest of the thread stack is properly erased\n");
 	}
 }
+
+void lkdtm_STACKLEAK_ERASING(void)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	check_stackleak_irqoff();
+	local_irq_restore(flags);
+}
-- 
2.30.2

