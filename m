Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED30511D02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiD0RfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 13:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244138AbiD0Rey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 13:34:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 580971F4798
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 10:31:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B9EA1474;
        Wed, 27 Apr 2022 10:31:39 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DBCD03F73B;
        Wed, 27 Apr 2022 10:31:37 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     akpm@linux-foundation.org, alex.popov@linux.com,
        catalin.marinas@arm.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        mark.rutland@arm.com, will@kernel.org
Subject: [PATCH v2 02/13] stackleak: move skip_erasing() check earlier
Date:   Wed, 27 Apr 2022 18:31:17 +0100
Message-Id: <20220427173128.2603085-3-mark.rutland@arm.com>
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

In stackleak_erase() we check skip_erasing() after accessing some fields
from current. As generating the address of current uses asm which
hazards with the static branch asm, this work is always performed, even
when the static branch is patched to jump to the return a the end of the
function.

This patch avoids this redundant work by moving the skip_erasing() check
earlier.

To avoid complicating initialization within stackleak_erase(), the body
of the function is split out into a __stackleak_erase() helper, with the
check left in a wrapper function. The __stackleak_erase() helper is
marked __always_inline to ensure that this is inlined into
stackleak_erase() and not instrumented.

Before this patch, on x86-64 w/ GCC 11.1.0 the start of the function is:

<stackleak_erase>:
   65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
   00 00
   48 8b 48 20             mov    0x20(%rax),%rcx
   48 8b 80 98 0a 00 00    mov    0xa98(%rax),%rax
   66 90                   xchg   %ax,%ax  <------------ static branch
   48 89 c2                mov    %rax,%rdx
   48 29 ca                sub    %rcx,%rdx
   48 81 fa ff 3f 00 00    cmp    $0x3fff,%rdx

After this patch, on x86-64 w/ GCC 11.1.0 the start of the function is:

<stackleak_erase>:
   0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)  <--- static branch
   65 48 8b 04 25 00 00    mov    %gs:0x0,%rax
   00 00
   48 8b 48 20             mov    0x20(%rax),%rcx
   48 8b 80 98 0a 00 00    mov    0xa98(%rax),%rax
   48 89 c2                mov    %rax,%rdx
   48 29 ca                sub    %rcx,%rdx
   48 81 fa ff 3f 00 00    cmp    $0x3fff,%rdx

Before this patch, on arm64 w/ GCC 11.1.0 the start of the function is:

<stackleak_erase>:
   d503245f        bti     c
   d5384100        mrs     x0, sp_el0
   f9401003        ldr     x3, [x0, #32]
   f9451000        ldr     x0, [x0, #2592]
   d503201f        nop  <------------------------------- static branch
   d503233f        paciasp
   cb030002        sub     x2, x0, x3
   d287ffe1        mov     x1, #0x3fff
   eb01005f        cmp     x2, x1

After this patch, on arm64 w/ GCC 11.1.0 the start of the function is:

<stackleak_erase>:
   d503245f        bti     c
   d503201f        nop  <------------------------------- static branch
   d503233f        paciasp
   d5384100        mrs     x0, sp_el0
   f9401003        ldr     x3, [x0, #32]
   d287ffe1        mov     x1, #0x3fff
   f9451000        ldr     x0, [x0, #2592]
   cb030002        sub     x2, x0, x3
   eb01005f        cmp     x2, x1

While this may not be a huge win on its own, moving the static branch
will permit further optimization of the body of the function in
subsequent patches.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Popov <alex.popov@linux.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 kernel/stackleak.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index ddb5a7f48d69e..753eab797a04d 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -70,7 +70,7 @@ late_initcall(stackleak_sysctls_init);
 #define skip_erasing()	false
 #endif /* CONFIG_STACKLEAK_RUNTIME_DISABLE */
 
-asmlinkage void noinstr stackleak_erase(void)
+static __always_inline void __stackleak_erase(void)
 {
 	/* It would be nice not to have 'kstack_ptr' and 'boundary' on stack */
 	unsigned long kstack_ptr = current->lowest_stack;
@@ -78,9 +78,6 @@ asmlinkage void noinstr stackleak_erase(void)
 	unsigned int poison_count = 0;
 	const unsigned int depth = STACKLEAK_SEARCH_DEPTH / sizeof(unsigned long);
 
-	if (skip_erasing())
-		return;
-
 	/* Check that 'lowest_stack' value is sane */
 	if (unlikely(kstack_ptr - boundary >= THREAD_SIZE))
 		kstack_ptr = boundary;
@@ -125,6 +122,14 @@ asmlinkage void noinstr stackleak_erase(void)
 	current->lowest_stack = current_top_of_stack() - THREAD_SIZE/64;
 }
 
+asmlinkage void noinstr stackleak_erase(void)
+{
+	if (skip_erasing())
+		return;
+
+	__stackleak_erase();
+}
+
 void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
 {
 	unsigned long sp = current_stack_pointer;
-- 
2.30.2

