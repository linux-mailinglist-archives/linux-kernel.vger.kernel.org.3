Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA2511FCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbiD0Rey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244135AbiD0Rex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4791C1F3E24
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E1FA2143D;
        Wed, 27 Apr 2022 10:31:36 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ADEFA3F73B;
        Wed, 27 Apr 2022 10:31:35 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 01/13] arm64: stackleak: fix current_top_of_stack()
Date:   Wed, 27 Apr 2022 18:31:16 +0100
Message-Id: <20220427173128.2603085-2-mark.rutland@arm.com>
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

Due to some historical confusion, arm64's current_top_of_stack() isn't
what the stackleak code expects. This could in theory result in a number
of problems, and practically results in an unnecessary performance hit.
We can avoid this by aligning the arm64 implementation with the x86
implementation.

The arm64 implementation of current_top_of_stack() was added
specifically for stackleak in commit:

  0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")

This was intended to be equivalent to the x86 implementation, but the
implementation, semantics, and performance characteristics differ
wildly:

* On x86, current_top_of_stack() returns the top of the current task's
  task stack, regardless of which stack is in active use.

  The implementation accesses a percpu variable which the x86 entry code
  maintains, and returns the location immediately above the pt_regs on
  the task stack (above which x86 has some padding).

* On arm64 current_top_of_stack() returns the top of the stack in active
  use (i.e. the one which is currently being used).

  The implementation checks the SP against a number of
  potentially-accessible stacks, and will BUG() if no stack is found.

The core stackleak_erase() code determines the upper bound of stack to
erase with:

| if (on_thread_stack())
|         boundary = current_stack_pointer;
| else
|         boundary = current_top_of_stack();

On arm64 stackleak_erase() is always called on a task stack, and
on_thread_stack() should always be true. On x86, stackleak_erase() is
mostly called on a trampoline stack, and is sometimes called on a task
stack.

Currently, this results in a lot of unnecessary code being generated for
arm64 for the impossible !on_thread_stack() case. Some of this is
inlined, bloating stackleak_erase(), while portions of this are left
out-of-line and permitted to be instrumented (which would be a
functional problem if that code were reachable).

As a first step towards improving this, this patch aligns arm64's
implementation of current_top_of_stack() with x86's, always returning
the top of the current task's stack. With GCC 11.1.0 this results in the
bulk of the unnecessary code being removed, including all of the
out-of-line instrumentable code.

While I don't believe there's a functional problem in practice I've
marked this as a fix since the semantic was clearly wrong, the fix
itself is simple, and other code might rely upon this in future.

Fixes: 0b3e336601b82c6a ("arm64: Add support for STACKLEAK gcc plugin")
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/processor.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 73e38d9a540ce..6b1a12c23fe77 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -381,12 +381,10 @@ long get_tagged_addr_ctrl(struct task_struct *task);
  * of header definitions for the use of task_stack_page.
  */
 
-#define current_top_of_stack()								\
-({											\
-	struct stack_info _info;							\
-	BUG_ON(!on_accessible_stack(current, current_stack_pointer, 1, &_info));	\
-	_info.high;									\
-})
+/*
+ * The top of the current task's task stack
+ */
+#define current_top_of_stack()	((unsigned long)current->stack + THREAD_SIZE)
 #define on_thread_stack()	(on_task_stack(current, current_stack_pointer, 1, NULL))
 
 #endif /* __ASSEMBLY__ */
-- 
2.30.2

